{ lib, palette, pkgs, hex, ... }: let
  ts = builtins.toString;

  # === Layout ===
  columnWidth = 112;
  rowHeight   = 28;
  columnGap   = 3.5;
  rowGap      = 7;
  padding     = 14;

  headerSize  = 21;
  headerGap   = 18;
  headerY     = padding + headerSize;
  rowsTop     = headerY + headerGap;

  rows = palette.colors;

  # === Primitive builders ===
  mkChildren = builtins.concatStringsSep "\n";

  mkTitle = { children ? [] }: ''
    <title>${mkChildren children}</title>
  '';

  mkRect = {
    style  ? "",
    radius ? 0,
    height,
    width,
    x,
    y,
  }: ''
    <rect
      x="${ts x}"
      y="${ts y}"
      width="${ts width}"
      height="${ts height}"
      rx="${ts radius}"
      style="${style}"
    />
  '';

  mkLabel = {
    fill   ? "#c8c8c8",
    anchor ? "start",
    size   ? 12,
    text,
    x,
    y,
  }: ''
    <text
      x="${ts x}"
      y="${ts y}"
      text-anchor="${anchor}"
      dominant-baseline="middle"
      style="font-family:system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
             font-size:${ts size}px;
             font-weight:bold;
             fill:${fill}"
    >${text}</text>
  '';

  mkSvg = { width, height, header, content }: ''
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="${ts width}"
      height="${ts height}"
      viewBox="0 0 ${ts width} ${ts height}"
    >
      ${mkRect {
        x      = 0;
        y      = 0;
        width  = "100%";
        height = "100%";
        style  = "fill:#18191b";
      }}
      ${header}
      ${content}
    </svg>
  '';

  # === Contrast logic (OKLCH L, scale-agnostic) ===
  # Normalize L to 0..1, then choose black/white text.
  lightCut = 0.72;

  textFillFor = bgHex: let
    lch  = hex.to.oklch bgHex;
    Lraw =
      if lib.hasAttr "l" lch then lch.l
      else if lib.hasAttr "L" lch then lch.L
      else 0.0;
    L01  = if Lraw > 1.0 then Lraw / 100.0 else Lraw;
  in
    if L01 >= lightCut then "#0b0c0e" else "#ffffff";

  # === Row & tone ordering ===
  rainbow        = [ "red" "orange" "yellow" "green" "cyan" "blue" "purple" "pink" ];
  allNames       = lib.attrNames rows;
  rainbowPresent = lib.filter (n: lib.elem n allNames) rainbow;
  extraNames     = lib.sort (a: b: a < b) (lib.filter (n: !(lib.elem n rainbow)) allNames);
  rowNames       = rainbowPresent ++ extraNames;
  rowsCount      = builtins.length rowNames;

  prefOrder = ["xlight" "light" "normal" "dark" "xdark"];

  orderedKeys = rn: let
    keys  = lib.attrNames rows.${rn};
    extra = lib.filter (k: !(lib.elem k prefOrder)) keys;
  in
    lib.filter (k: lib.elem k keys) prefOrder
    ++ lib.sort (a: b: a < b) extra;

  # === Precompute cell data ===
  rowCells = builtins.listToAttrs (map (rn: {
    name  = rn;
    value = map (n: {
      name = n;
      hex  = rows.${rn}.${n};
    }) (orderedKeys rn);
  }) rowNames);

  maxCols = lib.foldl' (acc: rn: let
    l = builtins.length rowCells.${rn};
  in
    if l > acc then l else acc) 0 rowNames;

  width = padding * 2
    + (if maxCols == 0 then 0 else maxCols * columnWidth + (maxCols - 1) * columnGap);

  height = rowsTop
    + (if rowsCount == 0 then 0 else rowsCount * rowHeight + (rowsCount - 1) * rowGap)
    + padding;

  # === SVG content builders ===
  mkCell = { rn, c, x, y  }: let
    fill = c.hex;
    tf   = textFillFor fill;
    tx   = x + 6;                   # left padding inside pill
    ty   = y + (rowHeight / 2);     # vertical center
  in ''
    <g>
      ${mkRect {
        inherit x y;

        width  = columnWidth;
        height = rowHeight;
        radius = 8;
        style  = "fill:${fill};stroke:#1e1f22;stroke-width:1";
      }}
      ${mkTitle { children = [ "${rn}:${c.name} ${c.hex}" ]; }}
      ${mkLabel {
        x    = tx;
        y    = ty;
        text = "${rn}/${c.name}";
        fill = tf;
      }}
    </g>
  '';

  mkRow = i: rn: let
    y          = rowsTop + i * (rowHeight + rowGap);
    cells      = rowCells.${rn};
    cellCount  = builtins.length cells;
    cellsMarkup = mkChildren (builtins.genList (j: let
      c = builtins.elemAt cells j;
      x = padding + j * (columnWidth + columnGap);
    in
      mkCell { inherit rn c x y; }) cellCount);
  in
    ''<g>${cellsMarkup}</g>'';

  mkHeader = { text }: ''
    <text
      x="${ts padding}"
      y="${ts headerY}"
      style="font-family:system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
             font-size:${ts headerSize}px;
             fill:#c8c8c8"
    >${text}</text>
  '';

  # === Aggregate markup ===
  content = mkChildren (builtins.genList
    (i: mkRow i (builtins.elemAt rowNames i))
    rowsCount
  );

  header = let
    escape = lib.strings.escapeXML;
    title  = if lib.hasAttr "name" palette then escape palette.name else "";
    author =
      if lib.hasAttr "author" palette && lib.hasAttr "name" palette.author
      then escape palette.author.name
      else "";
    text = "${title}${lib.optionalString (author != "") " • " + author}";
  in
    if text == "" then "" else mkHeader { text = text; };

in pkgs.writeTextFile {
  destination = "/share/clarity-noir.svg";
  name = "clarity-noir";

  text = mkSvg {
    inherit width height header content;
  };
}
