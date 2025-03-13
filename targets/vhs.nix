{ name, pkgs, terminal }: pkgs.writeTextFile {
  destination = "/share/vhs/clarity-noir.json";
  name = "clarity-noir-vhs";
  
  text = builtins.toJSON {
    inherit name;

    foreground = terminal.foreground;
    background = terminal.background;
    selection = terminal.selection;
    cursor = terminal.cursor;

    white = terminal.white;
    red = terminal.red;
    yellow = terminal.yellow;
    green = terminal.green;
    cyan = terminal.cyan;
    blue = terminal.blue;
    magenta = terminal.magenta;
    black = terminal.black;

    brightWhite = terminal.brightWhite;
    brightRed = terminal.brightRed;
    brightYellow = terminal.brightYellow;
    brightGreen = terminal.brightGreen;
    brightCyan = terminal.brightCyan;
    brightBlue = terminal.brightBlue;
    brightMagenta = terminal.brightMagenta;
    brightBlack = terminal.brightBlack;
  };
}
