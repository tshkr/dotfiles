vim.cmd[[syntax enable]]

-- 基本的なキーマップの設定
local keymap = vim.api.nvim_set_keymap

keymap('n', '-', ':', {noremap=true})
keymap('v', '-', ':', {noremap=true})
keymap('n', 'U', '<C-r>', {noremap=true})

-- Y の動作を D や C と同じにする
keymap('n', 'Y', 'y$', {noremap=true})
-- j k を表示行移動できるように変更
keymap('n', 'j', 'gj', {noremap=true})
keymap('n', 'k', 'gk', {noremap=true})

-- Leader をスペースにする。
vim.g.mapleader = ' '

-- 直感的になるように、k -> ? に、J -> _ と変更します。
keymap('n', '?', 'K', {noremap=true})
keymap('n', '_', 'J', {noremap=true})

-- 保存を簡単にできるようにします。
keymap('n', '<Leader>w', ':<C-u>write<CR>', {noremap=true})
keymap('n', '<Leader>wq', ':<C-u>wq<CR>', {noremap=true})
-- keymap('n', '<Leader>q', ':<C-u>quit<CR>', {noremap=true})
keymap('n', '<Leader>r', ':<C-u>luafile ~/.config/nvim/init.lua<CR>', {noremap=true})

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- 基本的な設定
vim.o.synmaxcol = 200  -- syntax highlighting で動作を軽くする。
vim.o.number = true  -- 左に番号を表示する。
vim.o.relativenumber = true  -- 番号を相対表示にする。
vim.o.clipboard = 'unnamedplus' -- クリップボードを使えるようにする。
vim.o.visualbell = true  -- ベルを画面フラッシュにする。
vim.o.virtualedit = 'block' -- 矩形選択で文字が無くても右へ進めるようにする。
vim.o.browsedir = 'buffer'  -- ファイル保存ダイアログの初期ディレクトリをバッファファイル位置固定する。
vim.o.helplang = 'ja,en'  -- ヘルプ検索時の日本語の優先順位を上げる。
vim.o.title = true  -- 編集中のファイル名を示します。


-- set lazyredraw  " マクロやコマンドを実行する間、画面を再描画しない(スクロールが重くなる対策)
-- set ttyfast     " 高速ターミナル接続を行う(スクロールが重くなる対策)

-- 折り畳みのキーバインド
-- " noremap <C-Return> zA
--  " nnoremap <Return> zMzozz
-- カーソル行を含む折り畳みを開きます。他は閉じます。
keymap('n', '<Leader><Return>', 'zMzozz', {noremap=true})
keymap('n', '<Tab><Return>', 'zA', {noremap=true})
--  " nnoremap <C-Return> zMzv
keymap('n', '<S-Tab>', 'zc', {noremap=true})
keymap('n', '<S-Tab><S-Tab>', 'zC', {noremap=true})
keymap('n', '<Tab>', 'zo', {noremap=true})
keymap('n', '<Tab><Tab>', 'zO', {noremap=true})
--  " nnoremap <Tab><Return> zC

keymap('n', 'K', 'zk', {noremap=true})
keymap('n', 'J', 'zj', {noremap=true})

keymap('n', '<Esc><Esc>', '<cmd>noh<CR>', {noremap=true})

vim.o.completeopt = 'menu,menuone,noselect'

--[[
if vim.g.vscode then
    keymap('n', 'j', ':call VSCodeCall("cursorDown")<CR>', {noremap=true})
    keymap('n', 'k', ':call VSCodeCall("cursorUp")<CR>', {noremap=true})
end
]]



local function has_attr(arg)
    return vim.fn.has(arg) == 1
end

-- if not vim.g.vscode then

if has_attr('gui_vimr') then
    vim.o.background = 'dark'
end


-- set cursorline と set cursorcolumn とした場合の色設定です。
vim.o.cursorline = true
vim.o.cursorcolumn = false
-- vim.cmd[[hi cursorline term=none cterm=none gui=none  ctermfg=none  ctermbg=234 guifg=none guibg=234]]
-- vim.cmd[[hi CursorLineNr term=bold   cterm=none ctermfg=Cyan ctermbg=none  guifg=#00ffff]]

-- vim.cmd[[colorscheme default]]

-- vim.cmd[[hi cursorline term=reverse gui=none cterm=none ctermfg=none  ctermbg=237 guifg=none guibg=237]]
-- vim.cmd[[hi CursorLineNr term=bold   cterm=none ctermfg=Cyan ctermbg=none  guifg=#00ffff]]

-- vim.cmd[[hi cursorline ctermfg=none  ctermbg=238  guifg=none  guibg=238]]
-- vim.cmd[[highlight CursorLine gui=NONE guifg=none guibg=#403D3D  ctermfg=none  ctermbg=238 term=none]]
-- highlight CursorLine gui=NONE guifg=none guibg=238  ctermfg=none  ctermbg=238
-- highlight CursorColumn gui=NONE guifg=none guibg=#403D3D  ctermfg=none  ctermbg=238
-- vim.cmd[[highlight CursorColumn gui=NONE guifg=none guibg=#403D3D  ctermfg=none  ctermbg=238]]
-- hi cursorcolumn  ctermfg=none  ctermbg=238  guifg=none  guibg=238
-- hi cursor cterm=none ctermfg=230 ctermbg=230
vim.cmd[[autocmd ColorScheme * highlight SignColumn ctermbg=234 guibg=234]]
-- vim.api.nvim_exec("highlight SignColumn ctermbg=234", false)


-- end


-- ファイル関連
-- "
vim.o.undofile = false       -- 「.*.un~」というファイルを作らない
vim.o.writebackup = false    -- ファイルの上書きの前にバックアップを作らない
vim.o.autoread = true        -- 他で書き換えられたら自動で読み直す
vim.o.hidden = true          -- 編集中でも他のファイルを開けるようにする
vim.o.switchbuf = 'useopen'  -- 新しく開く代わりにすでに開いてあるバッファを開く
vim.o.backup = false         -- バックアップ取らない
vim.o.swapfile = false       -- スワップファイル作らない

vim.o.backupdir = '~/.config/nvim/backups'  -- バックアップファイルを作るディレクトリ
vim.o.directory = '~/.config/nvim/swaps'  -- スワップファイル用のディレクトリ
vim.o.suffixes = '.bak,~,.o,.h,.info,.swp,.obj,.cmi,.cmo,.cmx,.so'  -- 次のファイルは候補に含めない。



vim.cmd [[packadd packer.nvim]]

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 2

vim.o.laststatus = 3

-- vim.cmd[[highlight PounceMatch      cterm=underline,bold ctermfg=gray ctermbg=214 gui=underline,bold guifg=#555555 guibg=#FFAF60]]
-- vim.cmd[[highlight PounceGap        cterm=underline,bold ctermfg=gray ctermbg=209 gui=underline,bold guifg=#555555 guibg=#E27878]]
-- vim.cmd[[highlight PounceAccept     cterm=underline,bold ctermfg=214 ctermbg=gray gui=underline,bold guifg=#FFAF60 guibg=#555555]]
-- vim.cmd[[highlight PounceAcceptBest cterm=underline,bold ctermfg=196 ctermbg=gray gui=underline,bold guifg=#EE2513 guibg=#555555]]
--vim.cmd[[highlight PounceMatch      cterm=underline,bold ctermfg=gray ctermbg=210 gui=underline,bold guifg=#555555 guibg=#FFAF60]]
--vim.cmd[[highlight PounceGap        cterm=underline,bold ctermfg=gray ctermbg=209 gui=underline,bold guifg=#555555 guibg=#E27878]]
--vim.cmd[[highlight PounceAccept     cterm=underline,bold ctermfg=214 ctermbg=gray gui=underline,bold guifg=#FFAF60 guibg=#555555]]
--vim.cmd[[highlight PounceAcceptBest cterm=underline,bold ctermfg=196 ctermbg=gray gui=underline,bold guifg=#EE2513 guibg=#555555]]
keymap('n', 's', '<cmd>Pounce<CR>', {noremap=true})
keymap('n', 'S', '<cmd>PounceRepeat<CR>', {noremap=true})
keymap('v', 's', '<cmd>Pounce<CR>', {noremap=true})
keymap('o', 'gs', '<cmd>Pounce<CR>', {noremap=true})


vim.o.winblend = 10
vim.o.pumblend = 10
vim.o.termguicolors = true


return require('packer').startup(function(use)
    -- Packer can manage itself

    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    require('impatient')

    use("kyazdani42/nvim-web-devicons")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("MunifTanjim/nui.nvim")
    use("rcarriga/nvim-notify")

    use("EdenEast/nightfox.nvim")

    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    use("nvim-lualine/lualine.nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use("hrsh7th/cmp-buffer")
    use("onsails/lspkind-nvim")

    use("hrsh7th/cmp-nvim-lua")
    use("zbirenbaum/copilot-cmp")
    use("hrsh7th/cmp-emoji")
    use("ray-x/cmp-treesitter")

    use{"williamboman/mason.nvim"}
    use{"williamboman/mason-lspconfig.nvim"}
    use("tamago324/nlsp-settings.nvim")
    use("folke/lsp-colors.nvim")
    use("j-hui/fidget.nvim")


    use("folke/trouble.nvim")

    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-frecency.nvim")
    use("nvim-telescope/telescope-packer.nvim")
    use("nvim-telescope/telescope-smart-history.nvim")
    use("nvim-telescope/telescope-media-files.nvim")
    use("LinArcX/telescope-command-palette.nvim")

    -- require('telescope').setup{
    --     defaults = {
    --         theme = 'dropdown',
    --     }
    -- }
--
    vim.cmd[[nnoremap <Leader>uu :lua require'telescope.builtin'.find_files()<cr>]]
    vim.cmd[[nnoremap <Leader>ub :lua require'telescope.builtin'.buffers()<cr>]]
    vim.cmd[[nnoremap <Leader>uh :lua require'telescope.builtin'.help_tags()<cr>]]
    vim.cmd[[nnoremap <Leader>P :lua require'telescope.builtin'.commands()<cr>]]
    -- vim.cmd[[nnoremap <Leader>p :lua require'telescope.builtin'.current_buffer_fuzzy_find()<cr>]]
    -- vim.cmd[[nnoremap <Leader>uu :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>]]
    -- vim.cmd[[nnoremap <Leader>ub :lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>]]
    -- vim.cmd[[nnoremap <Leader>uh :lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>]]

    use("nvim-treesitter/nvim-treesitter")
    -- use("JoosepAlviste/nvim-ts-context-commentstring")

    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("SmiteshP/nvim-gps")

    require'nvim-treesitter.configs'.setup {
        auto_install = true,
        highlight = {
            enable = true,
            disable = {},
        },
        indent = {
            enable = true,
        },
    }

    use("akinsho/bufferline.nvim")

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use("rlane/pounce.nvim")
    require'pounce'.setup{
        -- accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
        -- accept_keys = "UEOIHTNPYGCRJQKWMVXB",
        accept_keys = "UEOIHTNDGCRFPKJQXVWMB",
        accept_best_key = "<enter>",
        multi_window = true,
        debug = false,
    }

    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            adaptive_size = true,
            mappings = {
                list = {
                    { key = "u", action = "dir_up" },
                },
            },
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    })


    require('lualine').setup {
        options = {
            icons_enabled = true,
            -- theme = 'auto',
            -- theme = 'gruvbox-material',
            -- material, gruvbox-material, modus-vivendi, nord, nightfly, moonfly, onedark
            theme = 'onedark',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true,
            colored = true,
            ignore_focus = {},
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    source = {'nvim-lsp'}
                }
            },
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}

    }

    require("mason").setup{
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }

    -- 1. LSP Sever management
    require('mason-lspconfig').setup_handlers{ function(server)
        local opt = {
            -- -- Function executed when the LSP server startup
            -- on_attach = function(client, bufnr)
            --   local opts = { noremap=true, silent=true }
            --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
            -- end,
            capabilities = require('cmp_nvim_lsp').update_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )
        }
        require('lspconfig')[server].setup(opt)
    end }

    -- 2. build-in LSP function
    -- keyboard shortcut
    vim.keymap.set('n', '?',  '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    -- LSP handlers
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
    )
    -- Reference highlight
    vim.cmd [[
        set updatetime=500
        " highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
        " highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
        " highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
        augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
        augroup END
        ]]

    -- 3. completion (hrsh7th/nvim-cmp)
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
        },

        mapping = cmp.mapping.preset.insert({
            -- ["<C-p>"] = cmp.mapping.select_prev_item(),
            -- ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-g>'] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        experimental = {
            ghost_text = true,
        },
    })
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "path" },
            { name = "cmdline" },
        },
    })

    use {
        'chipsenkbeil/distant.nvim',
        config = function()
            require('distant').setup {
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file's parent directory
                ['*'] = require('distant.settings').chip_default()
            }
        end
    }
    use{'sheerun/vim-polyglot'}
    -- use{'arcticicestudio/nord-vim', opt = true}
    use({
        'glepnir/zephyr-nvim',
        requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    })

    use{'sainnhe/gruvbox-material'}
    vim.cmd[[let g:gruvbox_material_background = 'hard']]

    -- For better performance
    vim.cmd[[let g:gruvbox_material_better_performance = 1]]

    use{'sainnhe/sonokai'}
    -- The configuration options should be placed before `colorscheme sonokai`.
    vim.cmd[[let g:sonokai_style = 'atlantis']]
    vim.cmd[[let g:sonokai_better_performance = 1]]

    use{'sainnhe/everforest'}
    vim.cmd[[
        let g:everforest_background = 'hard'
        let g:everforest_better_performance = 1
    ]]

    -- vim.cmd[[colorscheme gruvbox-material]]
    vim.cmd[[
        autocmd ColorScheme * hi Normal ctermbg=236 guibg=236
        autocmd ColorScheme * hi Comment cterm=italic ctermfg=236 gui=italic guifg=#AAAAAA
        autocmd ColorScheme * hi cursorline term=none cterm=none gui=none  ctermfg=none  ctermbg=235 guifg=none guibg=#292929
        autocmd ColorScheme * hi EndOfBuffer  ctermfg=237 ctermbg=235 guibg=#222222
        autocmd ColorScheme * hi VertSplit ctermfg=232 guifg=#777777 guibg=236
        autocmd ColorScheme * hi Function ctermfg=107 guifg=#b8f28a
        " autocmd ColorScheme * hi CursorLineNr term=bold  cterm=none ctermfg=232 ctermbg=none guifg=#00ffff

        ]]

    vim.cmd[[colorscheme sonokai]]


    use{'NvChad/nvim-colorizer.lua'}
    require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = true, -- "Name" codes like Blue or blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            AARRGGBB = false, -- 0xAARRGGBB hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "background", -- Set the display mode.
            -- Available methods are false / true / "normal" / "lsp" / "both"
            -- True is same as normal
            tailwind = false, -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = false, parsers = { css }, }, -- Enable sass colors
            virtualtext = "■",
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
    }

    require'nvim-treesitter.configs'.setup {
        context_commentstring = {
            enable = true
        }
    }

    use { 'numToStr/Comment.nvim' }
    require('Comment').setup{
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil,
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
            ---Line-comment toggle keymap
            line = '#',
            ---Block-comment toggle keymap
            block = '##',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = '#',
            ---Block-comment keymap
            block = '##',
        },
        ---LHS of extra mappings
        extra = {
            ---Add comment on the line above
            above = '#O',
            ---Add comment on the line below
            below = '#o',
            ---Add comment at the end of line
            eol = '#A',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
            ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            basic = true,
            ---Extra mapping; `gco`, `gcO`, `gcA`
            extra = true,
            ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
            extended = false,
        },
        ---Function to call before (un)comment
        pre_hook = nil,
        ---Function to call after (un)comment
        post_hook = nil,

    }

    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup{
                -- size = 30 | function(term)
                --     if term.direction == "horizontal" then
                --         return 15
                --     elseif term.direction == "vertical" then
                --         return vim.o.columns * 0.4
                --     end
                -- end,
                size = 30,
                open_mapping = [[<Leader>t]],
                hide_numbers = true,
                terminal_mappings = true,
                insert_mappings = false,
                auto_scroll = false,
            }
        end,
    }
    function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end
    vim.cmd[[autocmd! TermOpen term://* lua set_terminal_keymaps()]]
    keymap('n', '<Leader>t', '<cmd>ToggleTerm size=40<CR>', {noremap=true})

end)
