{ palette }: let
  inherit (palette.colors)
    foreground background
    selection red yellow
    green cyan blue purple;
in {
  selection = selection.normal;
  foreground = foreground."1";
  background = background."2";
  cursor = foreground."1";

  black = background."2";
  red = red.normal;
  green = green.normal;
  yellow = yellow.normal;
  blue = blue.normal;
  magenta = purple.normal;
  cyan = cyan.normal;
  white = foreground."1";

  brightBlack = foreground."3";
  brightRed = red.light;
  brightGreen = green.light;
  brightYellow = yellow.light;
  brightBlue = blue.light;
  brightMagenta = purple.light;
  brightCyan = cyan.light;
  brightWhite = foreground."0";
}
