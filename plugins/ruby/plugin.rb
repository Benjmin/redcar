Plugin.define do
  name    "ruby"
  version "0.1"
  file    "lib", "syntax_check", "ruby"
  object  "Redcar::SyntaxCheck::Ruby"
  dependencies "syntax_check", ">0"
end
