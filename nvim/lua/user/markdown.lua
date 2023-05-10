-- Conceal inline texts, but show code block (also affect inline code block)
-- for code block, conceal doesn't hide begin/end line, just make the text invisible. it's hard to maintain.
vim.g.vim_markdown_conceal_code_blocks = 0

-- Folding
-- vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_folding_level = 3
vim.g.vim_markdown_folding_style_pythonic = 1

-- TOC (Table of Content)
-- vim.g.vim_markdown_toc_autofit = 1

-- Frontmatter
vim.g.vim_markdown_frontmatter = 1

-- Strikethrough
vim.g.vim_markdown_strikethrough = 1

-- Indent new list items when pressing "o"
-- Pressing Enter at the end of line will not trigger auto ident
vim.g.vim_markdown_new_list_item_indent = 0
