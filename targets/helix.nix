{ palette, pkgs, treesitter, ... }: pkgs.writeTextFile {
  destination = "/share/helix/clarity-noir.toml";
  name = "clarity-noir-helix";

  text = builtins.readFile ((pkgs.formats.toml {}).generate "clarity-noir" (let
    inherit (palette.colors)
      foreground background ui;
  in (treesitter // {
    "ui.background" = { bg = background."1"; };
    "ui.window" = { bg = background."1"; };
    "ui.gutter" = { bg = background."1"; };
    "ui.text" = { fg = foreground."1"; };
    "ui.selection" = { bg = ui."1"; };
    "ui.bufferline".bg = ui."1";
    "ui.bufferline.active".fg = foreground."1";
    "ui.bufferline.active".bg = ui."2";
    "ui.cursorline.primary" = { bg = ui."1"; };
    "ui.cursorline.secondary" = { bg = ui."1"; };
    "ui.statusline" = { fg = foreground."2"; bg = ui."1"; };
  })));
}
