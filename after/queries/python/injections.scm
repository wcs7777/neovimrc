; extends

; SQL inside triple-quoted (or any) strings that start with --sql
((string
  (string_content) @injection.content)
 (#match? @injection.content "^\\s*--\\s*[sS][qQ][lL]")
 (#set! injection.language "sql")
 (#set! injection.include-children))
