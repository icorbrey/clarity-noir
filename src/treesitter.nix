{ lib, roles }: let
  inherit (roles)
    comments functions keywords
    languageConstants markup
    numbers punctuation strings
    text types variables;

  mkStyle = role: let
    fg = if lib.hasAttr "foreground" role
         then role.foreground
         else null;

    bg = if lib.hasAttr "background" role
         then role.background
         else null;

    mods = if lib.hasAttr "style" role
           then lib.splitString " " (
             if role.style == "strikethrough"
             then "crossed_out"
             else role.style)
           else [];
  in lib.filterAttrs (_: v: v != null) {
    fg = fg;
    bg = bg;
    modifiers = if mods == [] then null else mods;
  };

  mkRole = role: scopes:
    lib.foldl' lib.recursiveUpdate {} (map (scope: {
      "${scope}" = mkStyle role;
    }) scopes);
in lib.foldl' lib.recursiveUpdate {} [
  (mkRole comments.normal [
    "comment"
  ])
  (mkRole functions.normal [
    "function"
  ])
  (mkRole functions.preprocessor [
    "function.macro"
  ])
  (mkRole keywords [
    "keyword"
  ])
  (mkRole languageConstants [
    "constant"
  ])
  (mkRole markup.bold [
    "markup.bold"
  ])
  (mkRole markup.italic [
    "markup.italic"
  ])
  (mkRole text [
    "markup.link.text"
    "markup.raw.block"
  ])
  (mkRole markup.links [
    "markup.link.url"
  ])
  (mkRole markup.inlineCode [
    "markup.raw"
  ])
  (mkRole markup.codeFence.language [
    "markup.raw.block.info"
  ])
  (mkRole markup.strikethrough [
    "markup.strikethrough"
  ])
  (mkRole markup.headings."1" [
    "markup.heading.1"
  ])
  (mkRole markup.headings."2" [
    "markup.heading.2"
  ])
  (mkRole markup.headings."3" [
    "markup.heading.3"
  ])
  (mkRole markup.headings."4" [
    "markup.heading.4"
  ])
  (mkRole markup.headings."5" [
    "markup.heading.5"
  ])
  (mkRole markup.headings."6" [
    "markup.heading.6"
  ])
  (mkRole numbers [
    "constant.numeric"
  ])
  (mkRole punctuation.emphasis [
    "operator"
    "punctuation.delimiter"
    "tag.delimiter"
  ])
  (mkRole punctuation.normal [
    "comment.marker"
    "markup.list"
    "markup.heading.marker"
    "markup.heading.setext.underline"
    "punctuation"
  ])
  (mkRole strings [
    "string"
  ])
  (mkRole types [
    "type"
  ])
  (mkRole variables.attributes [
    "attribute"
    "attribute.name"
    "property"
    "field"
    "tag.attribute"
  ])
  (mkRole variables.parameters [
    "variable.parameter"
  ])
]
