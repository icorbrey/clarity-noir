{ hex, oklch, ... }: {
  name = "Clarity Noir";
  author.name = "Isaac Corbrey";
  author.email = "isaac@isaaccorbrey.com";

  colors = let
    red = hex.to.oklch "#ff3b11";
    orange = hex.to.oklch "#ff9502";
    yellow = hex.to.oklch "#ffcc00";
    green = hex.to.oklch "#2acd41";
    cyan = hex.to.oklch "#02c7be";
    blue = hex.to.oklch "#027aff";
    purple = hex.to.oklch "#b051de";
    pink = hex.to.oklch "#ff2e55";

    spread = color: value: {
      xlight = oklch.to.hex (oklch.lighten color value);
      light = oklch.to.hex (oklch.lighten color (value / 2));
      normal = oklch.to.hex color;
      dark = oklch.to.hex (oklch.darken color (value / 2));
      xdark = oklch.to.hex (oklch.darken color value);
    };
  in {
    red = spread red 0.2;
    orange = spread orange 0.2;
    yellow = spread yellow 0.2;
    green = spread green 0.2;
    cyan = spread cyan 0.2;
    blue = spread blue 0.2;
    purple = spread purple 0.2;
    pink = spread pink 0.2;

    selection.normal = "#62a9fc80";

    background = {
      "0" = "#000000";
      "1" = "#1e1e1e";
      "2" = "#282828";
      "3" = "#ffffff1c";
    };

    foreground = {
      "0" = "#ffffff";
      "1" = "#dcdcdc";
      "2" = "#8c8c8c";
      "3" = "#686868";
    };

    ui = {
      "1" = "#373737";
      "2" = "#515151";
      "3" = "#595959";
    };
  };
}
