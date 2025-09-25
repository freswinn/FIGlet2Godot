extends Resource
class_name FigletBorderPattern

## Name of the pattern that shows up in the dropdown.
@export var pattern_name : String = "BLANK"

## The pattern that will repeat to form the border.
@export_multiline var pattern : String = ""

## Horizontal spacing around the FIGlet text. x is to the left, and y is to the right.
@export var hspacing : Vector2i = Vector2i.ZERO

## Vertical spacing around the FIGlet text. x is above, and y is below.
@export var vspacing : Vector2i = Vector2i.ZERO

## Horizontal fill; the width (in characters) of the border to the left (x) and right (y) of the FIGlet text.[br]
## If either x or y is set to -1, then the total width of the pattern block will be equal to the width
## setting in the [b]Customization[/b] tab. If both are set to -1, then the FIGlet text will be centered;
## otherwise, it will bias to the side that is not set to -1.
@export var hfill : Vector2i = Vector2i.ZERO

## Vertical fill; the height (in lines) of the repeating pattern above (x) and below (y) the FIGlet text.
@export var vfill : Vector2i = Vector2i.ZERO

## The offset (in characters) of each iteration of the pattern, where positive offsets to the right and
## negative offsets to the left.[br]
## For example, if your pattern is [code]===%[/code] and [code]barberpole == 0[/code], then the pattern
## would look roughly like:
## [codeblock]
## ===%===%===%===%===%===%===%
## ===%===%===%===%===%===%===%
## ===%==                =%===%
## ===%==  ╺┳╸┏━╸┏━┓╺┳╸  =%===%
## ===%==   ┃ ┣╸ ┗━┓ ┃   =%===%
## ===%==   ╹ ┗━╸┗━┛ ╹   =%===%
## ===%==                =%===%
## ===%===%===%===%===%===%===%
## ===%===%===%===%===%===%===%
## [/codeblock]
## But with [code]barberpole == 1[/code] the rightmost characters from each iteration of the pattern
## get shifted to the front, resulting in:
## [codeblock]
## ===%===%===%===%===%===%===%
## %===%===%===%===%===%===%===
## =%===%                ===%==
## ==%===  ╺┳╸┏━╸┏━┓╺┳╸  %===%=
## ===%==   ┃ ┣╸ ┗━┓ ┃   =%===%
## %===%=   ╹ ┗━╸┗━┛ ╹   ==%===
## =%===%                ===%==
## ==%===%===%===%===%===%===%=
## ===%===%===%===%===%===%===%
## [/codeblock]
@export var barberpole : int = 0
