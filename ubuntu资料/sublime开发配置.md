```
#sublime 开发常用插件
SideBarEnhancements
Git
Theme - Monokai+
CTags
MarkdownEditing
jQuery
JavaScriptNext - ES6 Syntax
CSS3
Theme - DefaultPlus
SidebarSeparator
Vuejs Snippets
Python 3
Golang Build
DocBlockr
JavaScript & NodeJS Snippets
Require CommonJS Modules Helper
Alignment
AutoPEP8
AlignTab
Vuejs Complete Package
SideBarTools
HTMLAttributes
Laravel 5 Snippets
Theme - Seti Monokai
JavaScript Next Snippets
GitGutter
Align Arguments
jQueryDocs
JsFormat
Laravel 5 Artisan
PyYapf Python Formatter
Gitignore
Markdown Preview
PhalconPHP Completions
Python Completions
HTML5

#sublime settings
{
	"auto_complete": true,
	"auto_match_enabled": true,
	"color_scheme": "Packages/Color Scheme - Default/Monokai.tmTheme",
	"default_encoding": "UTF-8",
	"default_line_ending": "unix",
	"draw_minimap_border": true,
	"draw_white_space": "all",
	"ensure_newline_at_eof_on_save": true,
	"expand_tabs_on_save": true,
	"font_face": "Ubuntu Mono",
	"font_size": 12,
	"highlight_line": true,
	"ignored_packages":
	[
		"Vintage"
	],
	"line_padding_bottom": 1,
	"rulers":
	[
		80,
		100,
		120
	],
	"tab_size": 4,
	"theme": "Monokai+.sublime-theme",
	"translate_tabs_to_spaces": true,
	"trim_automatic_white_space": true,
	"trim_trailing_white_space_on_save": true,
	"update_check": false,
	"word_wrap": false
}

#jsformat
{
    // exposed jsbeautifier options
    "indent_with_tabs": false,
    "preserve_newlines": true,
    "max_preserve_newlines": 2,
    "space_in_paren": false,
    "jslint_happy": false,
    "brace_style": "collapse",
    "keep_array_indentation": false,
    "keep_function_indentation": false,
    "space_before_conditional": true,
    "eval_code": false,
    "unescape_strings": false,
    "break_chained_methods": false,
    "e4x": false,
    "wrap_line_length": 140,
    "indent_level": 0,
    "indent_size": 4,
    "indent_char": " ",

    // jsformat options
    "format_on_save": true,
    "format_selection": true,
    "jsbeautifyrc_files": false,
    "ignore_sublime_settings": true,
    "format_on_save_extensions": ["js", "json"]
}

#phpfmt（前提你安装的php7放在/usr/local/php7中，并且设置sudo ln -s /usr/local/php7/bin/php /usr/bin/php软链接)
{
	"disable_auto_align": false,
	"enable_auto_align": true,
	"format_on_save": true,
	"indent_with_space": true,
	"passes":
	[
		"AlignDoubleSlashComments",
		"PrettyPrintDocBlocks",
		"ShortArray",
		"ReindentObjOps",
		"ReindentSwitchBlocks"
	],
	"php_bin": "/usr/bin/php",
	"psr1": true,
	"psr1_naming": false,
	"psr2": true,
	"smart_linebreak_after_curly": false,
	"version": 4,
	"yoda": false
}

#Terminal (user setting)
{
  "terminal": "gnome-terminal",
  // Unset LD_PRELOAD which may cause problems for sublime with imfix
  "env": {"LD_PRELOAD": null}
}
```
