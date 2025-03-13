{ palette, ... }: let
  inherit (palette.colors)
    background foreground ui red
    orange yellow green
    blue purple pink;
in {
  comments.normal.foreground = pink.normal;
  comments.documentation.foreground = green.xdark;

  functions.normal.foreground = orange.light;
  functions.preprocessor.foreground = orange.dark;

  keywords.foreground = foreground."2";

  languageConstants.foreground = blue.light;

  markup.bold.style = "bold";
  markup.boldItalic.style = "bold italic";
  markup.codeFence.language.foreground = pink.dark;
  markup.inlineCode.foreground = orange.dark;
  markup.italic.style = "italic";
  markup.links.foreground = blue.light;
  markup.strikethrough.foreground = foreground."2";
  markup.strikethrough.style = "strikethrough";

  markup.headings."1".foreground = red.normal;
  markup.headings."2".foreground = orange.normal;
  markup.headings."3".foreground = yellow.normal;
  markup.headings."4".foreground = green.normal;
  markup.headings."5".foreground = blue.normal;
  markup.headings."6".foreground = purple.normal;

  numbers.foreground = green.normal;

  punctuation.normal.foreground = ui."2";
  punctuation.emphasis.foreground = foreground."3";

  strings.foreground = green.normal;

  text.foreground = foreground."1";

  types.foreground = purple.light;

  variables.parameters.foreground = blue.light;
  variables.parameters.style = "italic";
  variables.attributes.foreground = yellow.xlight;
}
