{ lib, roles, ... }: let
  inherit (roles)
    comments functions keywords
    languageConstants markup
    numbers punctuation strings
    text types variables;

  mkScopes = settings: scope: {
    inherit scope settings;
  };

  mkExclusions = scope: exclusions:
    lib.strings.join " "
      ([scope] ++ (builtins.map (x: "- ${x}") exclusions));
in [
  (mkScopes comments.normal [
    "comment.block"
    "comment.line"
  ])
  (mkScopes comments.documentation [
    "comment.block.documentation"
    "comment.line.documentation"
  ])
  (mkScopes functions.normal [
    "entity.name.function"
  ])
  (mkScopes functions.preprocessor [
    "entity.name.function.macro"
    "entity.name.function.preprocessor"
  ])
  (mkScopes keywords [
    "keyword"
    "storage"
  ])
  (mkScopes languageConstants [
    "constant.language"
  ])
  (mkScopes markup.bold [
	  "markup.bold"
  ])
  (mkScopes markup.boldItalic [
	  "markup.bold markup.italic"
  ])
  (mkScopes markup.headings."1" [
	  "heading.1"
  ])
  (mkScopes markup.headings."2" [
	  "heading.2"
  ])
  (mkScopes markup.headings."3" [
	  "heading.3"
  ])
  (mkScopes markup.headings."4" [
	  "heading.4"
  ])
  (mkScopes markup.headings."5" [
	  "heading.5"
  ])
  (mkScopes markup.headings."6" [
	  "heading.6"
  ])
  (mkScopes markup.inlineCode [
	  "markup.inline.raw"
  ])
  (mkScopes markup.italic [
	  "markup.italic"
  ])
  (mkScopes markup.links [
	  "markup.underline.link"
  ])
  (mkScopes markup.strikethrough [
	  "markup.strikethrough"
  ])
  (mkScopes numbers [
    "constant.numeric"
  ])
  (mkScopes punctuation.normal [
    "meta.brace"
    "punctuation"
  ])
  (mkScopes punctuation.emphasis [
    "keyword.operator"
    "punctuation.accessor"
  ])
  (mkScopes strings [
    "string.quoted"
    "string.regexp"
    "string.template"
    "string.unquoted.plain"
    (mkExclusions "string.other" [
      "string.other.link"
    ])
  ])
  (mkScopes text [
  	"entity.name.tag"
  ])
  (mkScopes types [
    "entity.name.type"
    (mkExclusions "support.type" [
      "support.type.property-name"
    ])
  ])
  (mkScopes variables.attributes [
    "variable.other.attribute-name"
    "variable.other.member"
    "variable.other.object.property"
    "variable.other.property"
  ])
  (mkScopes variables.parameters [
    "meta.definition.variable"
    "variable.other.regexp"
    "variable.parameter"
    (mkExclusions "meta.table" [
      "meta.table.inline"
    ])
  ])
]
