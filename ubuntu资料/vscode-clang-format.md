```
1.安装好vscode
2.安装vscode clang 和clang-format插件
3.安装clang,clang-format支持 sudo apt install -y clang clang-format
4.配置vscode clang,clang-format
 "C_Cpp.clang_format_path": "/usr/bin/clang-format",
 "C_Cpp.clang_format_formatOnSave": true,
 "clang.completion.enable": true,
 "clang.executable": "/usr/bin/clang"

针对js-css-html,prettier js这两个个插件，你也可以安装。
比如我的vscode配置如下（我安装了phpfmt,clang,clang-foramt,eslint插件）
eslint插件需要npm install -g eslint(这里需要提前安装好nodejs8.0.0+）
完整的vscode配置：
{
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.autoIndent": true,
    "prettier.tabWidth": 4,
    "php.executablePath": "/usr/bin/php",
    "phpfmt.format_on_save": true,
    "phpfmt.php_bin": "/usr/bin/php",
    "phpfmt.psr2": true,
    "phpfmt.indent_with_space": 4,
    "phpfmt.enable_auto_align": true,
    "phpfmt.psr1": true,
    "phpfmt.smart_linebreak_after_curly": true,
    "C_Cpp.clang_format_path": "/usr/bin/clang-format",
    "eslint.nodePath": "/usr/bin/node",
    "C_Cpp.clang_format_formatOnSave": true,
    "prettier.eslintIntegration": true,
    "eslint.enable": true,
    "clang.completion.enable": true,
    "clang.executable": "/usr/bin/clang",
    "go.formatTool": "gofmt",
    "go.gopath": "/mygo",
    "go.goroot": "/usr/local/go",
    "go.formatOnSave": true,

}
```
