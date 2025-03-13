{ name, pkgs, terminal, textmate }: pkgs.writeTextFile {
  destination = "/share/shiki/clarity-noir.json";
  name = "clarity-noir-shiki";

  text = builtins.toJSON {
    inherit name;
    type = "dark";

    semanticHighlighting = true;
    tokenColors = textmate;

    colors = {
      "editor.background" = terminal.background;
      "editor.foreground" = terminal.foreground;
      "terminal.background" = terminal.background;
      "terminal.foreground" = terminal.foreground;

      "terminal.ansiBlack" = terminal.black;
      "terminal.ansiRed" = terminal.red;
      "terminal.ansiGreen" = terminal.green;
      "terminal.ansiYellow" = terminal.yellow;
      "terminal.ansiBlue" = terminal.blue;
      "terminal.ansiMagenta" = terminal.magenta;
      "terminal.ansiCyan" = terminal.cyan;
      "terminal.ansiWhite" = terminal.white;

      "terminal.ansiBrightBlack" = terminal.brightBlack;
      "terminal.ansiBrightRed" = terminal.brightRed;
      "terminal.ansiBrightGreen" = terminal.brightGreen;
      "terminal.ansiBrightYellow" = terminal.brightYellow;
      "terminal.ansiBrightBlue" = terminal.brightBlue;
      "terminal.ansiBrightMagenta" = terminal.brightMagenta;
      "terminal.ansiBrightCyan" = terminal.brightCyan;
      "terminal.ansiBrightWhite" = terminal.brightWhite;
    };
  };
}
