local vim = vim
-- Lazy bootstrapping

vim.opt.fileencodings= {'utf-8','cp932', 'iso-2022-jp','euc-jp','sjis','latin1'}
vim.opt.fileformats = {'unix','mac','dos'}
-- vim.opt.encoding='utf-8'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- base
    -- 'lewis6991/impatient.nvim', -- No need with Lazy.nvim.

    'kyazdani42/nvim-web-devicons',
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'kkharji/sqlite.lua',
    'nvim-treesitter/nvim-treesitter',


    'vim-jp/vimdoc-ja',

    -- startup
    { 'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    },

    -- LSP
    'neovim/nvim-lspconfig',
    { 'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall' },
        event = { 'WinNew', 'WinLeave', 'BufRead' },
    },
    'williamboman/mason-lspconfig',
    'nvimtools/none-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
    'stevearc/dressing.nvim',
    'tami5/lspsaga.nvim',
    'ray-x/lsp_signature.nvim',
    'onsails/lspkind-nvim',
    'j-hui/fidget.nvim',
    'folke/lsp-colors.nvim',

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lua',
    'ray-x/cmp-treesitter',
    'zbirenbaum/copilot-cmp',
    'hrsh7th/cmp-emoji',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    {
        "NeogitOrg/neogit",
	tag = 'v0.0.1',
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua", -- optional
        },
        config = true
    },

    -- DAP
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
    },
    'mfussenegger/nvim-dap-python',

    -- IDE
    'folke/trouble.nvim',
    'lambdalisue/fern.vim',
    'simrat39/symbols-outline.nvim',
    'SmiteshP/nvim-navic',
    'kyazdani42/nvim-tree.lua',
    -- 'mattn/vim-findroot',

    -- Git
    'lewis6991/gitsigns.nvim',

    -- telescope
    'nvim-lua/telescope.nvim',
    "nvim-telescope/telescope-packer.nvim",
    'nvim-telescope/telescope-smart-history.nvim',
    'nvim-telescope/telescope-media-files.nvim',
    'LinArcX/telescope-command-palette.nvim',
    -- { "nvim-telescope/telescope-frecency.nvim",
    --     config = function()
    --         require "telescope".load_extension("frecency")
    --     end,
    -- },

    -- jaq (quick-run)
    "is0n/jaq-nvim",

    -- 編集支援
    "JoosepAlviste/nvim-ts-context-commentstring",
    'numToStr/Comment.nvim',
    { "kylechui/nvim-surround", config = true, },
    'windwp/nvim-autopairs',
    'RRethy/nvim-treesitter-endwise',
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'andymass/vim-matchup',
        init = function()
            -- may set any options here
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    'johmsalas/text-case.nvim',

    -- Search
    -- "rlane/pounce.nvim",
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = "UEOIHTNDGCRFPKJQXVWMB",
            jump_on_sole_occurrence = false,
            multi_windows = true,
        },
    },

    -- Status line
    "nvim-lualine/lualine.nvim",

    -- Buffer line
    "akinsho/bufferline.nvim",

    {
        'b0o/incline.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            require('incline').setup {
                render = function(props)
                    local bufname = vim.api.nvim_buf_get_name(props.buf)
                    local filename = vim.fn.fnamemodify(bufname, ":t")
                    -- local dirname = vim.fs.dirname(filename)
                    local dirpath = vim.fs.dirname(bufname)
                    local dirname = vim.fs.basename(dirpath)
                    local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "None"
                    local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)


                    local buffer = {
                        { filetype_icon, guifg = color },
                        { ' ' },
                        { dirname },
                        { "/" },
                        { filename,      gui = modified },
                    }

                    if vim.api.nvim_get_option_value('modified', { buf = props.buf }) then
                        table.insert(buffer, ' [+]')
                    end

                    return buffer
                end,
            }
        end,
    },

    -- Markdown
    { 'iamcco/markdown-preview.nvim',
        ft = { 'markdown', 'plantuml' },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    'mattn/vim-maketable',

    { 'dhruvasagar/vim-table-mode',
        config = function()
            vim.cmd [[
            let g:table_mode_corner='|'

            function! s:isAtStartOfLine(mapping)
                let text_before_cursor = getline('.')[0 : col('.')-1]
                let mapping_pattern = '\V' . escape(a:mapping, '\')
                let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
                return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
            endfunction

            inoreabbrev <expr> <bar><bar>
                \ <SID>isAtStartOfLine('\|\|') ?
                \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
            inoreabbrev <expr> __
                \ <SID>isAtStartOfLine('__') ?
                \ '<c-o>:silent! TableModeDisable<cr>' : '__'
        ]]
        end,
    },


    -- syntax highlight
    'sheerun/vim-polyglot',

    -- utilities
    'NvChad/nvim-colorizer.lua',


    -- color scheme
    {
        'sainnhe/gruvbox-material',
        init = function()
            vim.cmd [[let g:gruvbox_material_better_performance = 1]] -- for better performance
            vim.cmd [[let g:gruvbox_material_background = 'hard']]
        end,
    },

    "EdenEast/nightfox.nvim",
    'arcticicestudio/nord-vim',
    'glepnir/zephyr-nvim',

    { 'sainnhe/sonokai',
        config = function()
            vim.cmd [[
            let g:sonokai_style = 'atlantis'
            let g:sonokai_better_performance = 1
            let g:sonokai_enable_italic = 1
            " let g:sonokai_dim_inactive_windows = 0
            let g:sonokai_menu_selection_background = 'green'

            colorscheme sonokai
            augroup SonokaiCustom
            au!
                autocmd ColorScheme * hi Normal ctermbg=236 guibg=#121212
                autocmd ColorScheme * hi Comment cterm=italic ctermfg=236 gui=italic guifg=#AAAAAA
                " autocmd ColorScheme * hi String ctermfg=169 guifg=#aacb64
                autocmd ColorScheme * hi cursorline term=none cterm=none gui=none  ctermfg=none  ctermbg=235 guifg=none guibg=#202020
                autocmd ColorScheme * hi EndOfBuffer  ctermfg=237 ctermbg=235 guibg=#222222
                autocmd ColorScheme * hi VertSplit ctermfg=232 guifg=#777777 guibg=236
                autocmd ColorScheme * hi Function ctermfg=107 guifg=#b8f28a
                autocmd ColorScheme * hi CursorLineNr term=bold  cterm=none ctermfg=232 ctermbg=none guifg=#00ffff
                autocmd ColorScheme * hi NormalNC guibg=#202020
                autocmd ColorScheme * hi debugPC ctermfg=235 ctermbg=107 guifg=#2a2f38 guibg=#9dd274
                " autocmd ColorScheme * hi debugPC ctermfg=235 ctermbg=107 guifg=#2a2f38 guibg=#005500
            augroup END
            colorscheme sonokai
        ]]
        end,
    },
    { 'sainnhe/everforest',
        init = function()
            vim.cmd [[
            let g:everforest_background = 'hard'
            let g:everforest_better_performance = 1
        ]]
        end,
    },
    { 'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
    },

    -- 以下、未整理
    --     use {
    --         'chipsenkbeil/distant.nvim',
    --         config = function()
    --             require('distant').setup {
    --                 -- Applies Chip's personal settings to every machine you connect to
    --                 --
    --                 -- 1. Ensures that distant servers terminate with no connections
    --                 -- 2. Provides navigation bindings for remote directories
    --                 -- 3. Provides keybinding to jump into a remote file's parent directory
    --                 ['*'] = require('distant.settings').chip_default()
    --             }
    --         end
    --     }
    --
    --
    --     use {
    --         "akinsho/toggleterm.nvim",
    --         tag = '*',
    --         config = function()
    --             require("toggleterm").setup{
    --                 -- size = 30 | function(term)
    --                 --     if term.direction == "horizontal" then
    --                 --         return 15
    --                 --     elseif term.direction == "vertical" then
    --                 --         return vim.o.columns * 0.4
    --                 --     end
    --                 -- end,
    --                 size = 30,
    --                 open_mapping = [[<Leader>t]],
    --                 hide_numbers = true,
    --                 terminal_mappings = true,
    --                 insert_mappings = false,
    --                 auto_scroll = false,
    --             }
    --         end,
    --     }
    --     function _G.set_terminal_keymaps()
    --         local opts = {buffer = 0}
    --         vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    --         vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    --         vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    --         vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    --         vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    --         vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    --     end
    --     vim.cmd[[autocmd! TermOpen term://* lua set_terminal_keymaps()]]
    --     keymap('n', '<Leader>t', '<cmd>ToggleTerm size=40<CR>', {noremap=true})
    --
    --
    --     use("tamago324/nlsp-settings.nvim")
    --
    --     use {'nvim-orgmode/orgmode',
    --         config = function()
    --             require'orgmode'.setup({
    --                 org_agenda_files = {'~/orgs/**/*',},
    --                 org_deault_notes_file = '~/orgs/refile.org',
    --             })
    --         end
    --     }
    --     require('orgmode').setup_ts_grammar()
    --
    --     -- use{
    --     --     "nvim-telescope/telescope-frecency.nvim",
    --     --     config = function()
    --     --         require"telescope".load_extension("frecency")
    --     --     end,
    --     --     requires = {"kkharji/sqlite.lua"}
    --     -- }

})



-- シンタックスを有効にする。
vim.cmd [[syntax enable]]

-- 変数
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd


-- 基本的なキーマップの設定
local keymap = vim.api.nvim_set_keymap
local key_defaultopt = { noremap = true }

keymap('n', '-', ':', { noremap = true })
keymap('v', '-', ':', { noremap = true })
keymap('n', 'U', '<C-r>', { noremap = true })

-- Y の動作を D や C と同じにする
keymap('n', 'Y', 'y$', { noremap = true })
-- j k を表示行移動できるように変更
keymap('n', 'j', 'gj', { noremap = true })
keymap('n', 'k', 'gk', { noremap = true })

keymap('i', 'jj', '<ESC>', { silent = true })

-- Leader をスペースにする。
vim.g.mapleader = ' '
-- vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>')
-- vim.keymap.set({ 'n', 'x' }, '<Plug>(lsp)', '<Nop>')
-- vim.keymap.set({ 'n', 'x' }, 'g', '<Plug>(lsp)')
vim.keymap.set({ 'n', 'x' }, '<Plug>(ff)', '<Nop>')
vim.keymap.set({ 'n', 'x' }, '<Leader>u', '<Plug>(ff)')

-- 直感的になるように、k -> ? に、J -> _ と変更します。
keymap('n', '?', 'K', { noremap = true })
keymap('n', '_', 'J', { noremap = true })

-- 保存を簡単にできるようにします。
keymap('n', '<Leader>w', ':<C-u>write<CR>', { noremap = true })
keymap('n', '<Leader>wq', ':<C-u>wq<CR>', { noremap = true })
-- keymap('n', '<Leader>q', ':<C-u>quit<CR>', {noremap=true})
keymap('n', '<Leader>r', ':<C-u>luafile ~/.config/nvim/init.lua<CR>', { noremap = true })

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- 基本的な設定
vim.o.synmaxcol = 200 -- syntax highlighting で動作を軽くする。
vim.o.number = true -- 左に番号を表示する。
vim.o.relativenumber = true -- 番号を相対表示にする。
vim.o.clipboard = 'unnamedplus' -- クリップボードを使えるようにする。
vim.o.visualbell = true -- ベルを画面フラッシュにする。
vim.o.virtualedit = 'block' -- 矩形選択で文字が無くても右へ進めるようにする。
-- vim.o.browsedir = 'buffer' -- ファイル保存ダイアログの初期ディレクトリをバッファファイル位置固定する。
vim.o.helplang = 'ja,en' -- ヘルプ検索時の日本語の優先順位を上げる。
vim.o.title = true -- 編集中のファイル名を表示する。
vim.o.wrap = true -- 長い行を折り返して表示する。


-- set lazyredraw  " マクロやコマンドを実行する間、画面を再描画しない(スクロールが重くなる対策)
-- set ttyfast     " 高速ターミナル接続を行う(スクロールが重くなる対策)

-- 折り畳みのキーバインド
-- " noremap <C-Return> zA
--  " nnoremap <Return> zMzozz
-- カーソル行を含む折り畳みを開きます。他は閉じます。
keymap('n', '<Leader><Return>', 'zMzozz', { noremap = true })
keymap('n', '<Tab><Return>', 'zA', { noremap = true })
--  " nnoremap <C-Return> zMzv
keymap('n', '<S-Tab>', 'zc', { noremap = true })
keymap('n', '<S-Tab><S-Tab>', 'zC', { noremap = true })
keymap('n', '<Tab>', 'zo', { noremap = true })
keymap('n', '<Tab><Tab>', 'zO', { noremap = true })
--  " nnoremap <Tab><Return> zC

keymap('n', 'K', 'zk', { noremap = true })
keymap('n', 'J', 'zj', { noremap = true })

keymap('n', '<Esc><Esc>', '<cmd>noh<CR>', { noremap = true })

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
vim.cmd [[autocmd ColorScheme * highlight SignColumn ctermbg=234 guibg=234]]
-- vim.api.nvim_exec("highlight SignColumn ctermbg=234", false)


-- end


-- ファイル関連
-- "
vim.o.undofile = false -- 「.*.un~」というファイルを作らない
vim.o.writebackup = false -- ファイルの上書きの前にバックアップを作らない
vim.o.autoread = true -- 他で書き換えられたら自動で読み直す
vim.o.hidden = true -- 編集中でも他のファイルを開けるようにする
vim.o.switchbuf = 'useopen' -- 新しく開く代わりにすでに開いてあるバッファを開く
-- ivim.o.switchbuf = 'usetab,newtab,split,vsplit'

vim.o.backup = false -- バックアップ取らない
vim.o.swapfile = false -- スワップファイル作らない

vim.o.backupdir = '~/.config/nvim/backups' -- バックアップファイルを作るディレクトリ
vim.o.directory = '~/.config/nvim/swaps' -- スワップファイル用のディレクトリ
vim.o.suffixes = '.bak,~,.o,.h,.info,.swp,.obj,.cmi,.cmo,.cmx,.so' -- 次のファイルは候補に含めない。


vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wrap = false
vim.o.signcolumn = 'yes'
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 2

vim.o.laststatus = 3

vim.o.winblend = 10
vim.o.pumblend = 10
vim.o.termguicolors = true

-- vim.cmd[[
-- " $TERMがxterm以外のときは以下を設定する必要がある。
-- let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
-- let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色
-- ]]

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }


vim.cmd [[
    " カーソル下のhighlight情報を表示する {{{
    function! s:get_syn_id(transparent)
        let synid = synID(line('.'), col('.'), 1)
        return a:transparent ? synIDtrans(synid) : synid
    endfunction

    function! s:get_syn_name(synid)
        return synIDattr(a:synid, 'name')
    endfunction

    function! s:get_highlight_info()
        execute "highlight " . s:get_syn_name(s:get_syn_id(0))
        execute "highlight " . s:get_syn_name(s:get_syn_id(1))
    endfunction

    command! HighlightInfo call s:get_highlight_info()
]]

--
--
-- telescope
require 'telescope'.setup {
    defaults = {
        mappings = {
            n = {
                ['<Esc>'] = require('telescope.actions').close,
                ['<C-g>'] = require('telescope.actions').close,
            },
            i = {
                ['<C-g>'] = require('telescope.actions').close,
            },
        },
        theme = 'dropdown',
    },
}

-- vim.cmd[[nnoremap <Leader>uu :lua require('telescope').extensions.frecency.frecency()<cr>]]
keymap('n', '<Leader>U', ":lua require'telescope.builtin'.builtin()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)f', ":lua require'telescope.builtin'.find_files()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)b', ":lua require'telescope.builtin'.buffers()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)h', ":lua require'telescope.builtin'.help_tags()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)c', ":lua require'telescope.builtin'.commands()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)d', ":lua require'telescope.builtin'.diagnostics()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)g', ":lua require'telescope.builtin'.live_grep()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)m', ":lua require'telescope.builtin'.marks()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)k', ":lua require'telescope.builtin'.keymaps()<cr>", key_defaultopt)
keymap('n', '<Plug>(ff)p', ":lua require'telescope.builtin'.builtin()<cr>", key_defaultopt)


------------
-- nvim-lsp
------------
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local mason_null_ls = require('mason-null-ls')
local none_ls = require('null-ls')

require('dressing').setup()
require('lspsaga').init_lsp_saga()
require('lspsaga').setup()
require('lsp_signature').setup({ hint_enable = false })
require('fidget').setup()

-- 1. LSP Sever management
mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        -- 'fsautocomplete',
        'clangd',
        -- 'pyright',
        'ts_ls',
        'eslint',
        -- 'lua-language-server',
        'lua_ls',
    },
    automatic_installation = true,
})

mason_null_ls.setup {
    ensure_installed = {
        'stylua',
        -- これらは使用予定の Python パッケージマネージャーを使用した方が良いです。
        --[[ 'pyproject_flake8', 'flake8', 'mypy', 'blue', 'usort', ]]
        -- 'fantomas',
        -- 'cspell',
        'markdownlint'
    },
    automatic_installation = true,
}

-- mypy のパスを取得します。
local Path = require('plenary.path')
local get_python_path = function()
    local python_path = Path:new(vim.fn.system('which python'))
    return python_path
end

local python_path = get_python_path()
-- print(python_path)
local null_ls_sources = {
    -- Python
    -- none_ls.builtins.diagnostics.pyproject_flake8.with {
    --     filetypes = { 'python' },
    --     command = { python_path:parent():joinpath('pflake8').filename }, -- pyproject-flake8
    -- },
    -- none_ls.builtins.diagnostics.flake8,
    -- none_ls.builtins.diagnostics.mypy.with {
    --     filetypes = { 'python' },
    --     -- command = { python_path:parent():joinpath('mypy').filename },
    -- },
    -- none_ls.builtins.formatting.blue,
    -- none_ls.builtins.formatting.blue.with {
    --     filetypes = { 'python' },
    --     -- command = { python_path:parent():joinpath('blue').filename },
    -- },
    -- none_ls.builtins.formatting.usort,
    -- none_ls.builtins.formatting.usort.with {
    --     filetypes = { 'python' },
    --     -- command = { python_path:parent():joinpath('usort').filename },
    -- },
}
require('lspconfig').ruff_lsp.setup {
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

-- 保存時のコードをフォーマットします。
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "none-ls"
        end,
        bufnr = bufnr,
    })
end

-- if you want to set up formatting on save, you can use this as a callback
local lsp_formatting_group = augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_write = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = lsp_formatting_group, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_formatting_group,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

none_ls.setup({
    sources = null_ls_sources,
    on_attach = on_write,
})


lsp_config.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' }
            },
            -- workspace = {
            --     -- Make the server aware of Neovim runtime files
            --     library = vim.api.nvim_get_runtime_file("", true),
            -- },
            -- -- Do not send telemetry data containing a randomized but unique identifier
            -- telemetry = {
            --     enable = false,
            -- },
        }
    }
}





mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        lsp_config[server_name].setup(opts)
    end,
})

--TODO CursorHold 関連のエラーが出るため、一旦コメントアウト。
-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
--     pattern = { '*' },
--     callback = function()
--         require('lspsaga.diagnostic').show_cursor_diagnostics()
--     end,
-- })

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'typescript', 'typescriptreact', 'typescript.tsx' },
    callback = function()
        vim.keymap.set({ 'n' }, '<Plug>(lsp)f', function()
            vim.cmd([[EslintFixAll]])
            vim.lsp.buf.format({ name = 'null-ls' })
        end)
    end,
})


local function show_documentation()
    local ft = vim.opt.filetype._value
    if ft == 'vim' or ft == 'help' then
        vim.cmd([[execute 'h ' . expand('<cword>') ]])
    else
        require('lspsaga.hover').render_hover_doc()
    end
end

-- https://github.com/neovim/nvim-lspconfig/issues/726
local function filter(arr, func)
    -- Filter in place
    -- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
    local new_index = 1
    local size_orig = #arr
    for old_index, v in ipairs(arr) do
        if func(v, old_index) then
            arr[new_index] = v
            new_index = new_index + 1
        end
    end
    for i = new_index, size_orig do arr[i] = nil end
end

local function filter_diagnostics(diagnostic)
    -- Only filter out Pyright stuff for now
    -- if diagnostic.source ~= "Pyright" then
    -- 	return true
    -- end
    -- Pyright の diagnostics は扱いません。
    if diagnostic.source == "Pyright" then
        return false
    end

    -- Allow kwargs to be unused, sometimes you want many functions to take the
    -- same arguments but you don't use all the arguments in all the functions,
    -- so kwargs is used to suck up all the extras
    -- if diagnostic.message == '"kwargs" is not accessed' then
    -- 	return false
    -- end

    -- Allow variables starting with an underscore
    -- if string.match(diagnostic.message, '".+" is not accessed') then
    -- 	return false
    -- end

    -- if string.match(diagnostic.message, 'Illegal type annotation: call expression not allowed') then
    -- 	return false
    -- end

    return true
end

local function on_publish_diagnostics_filtered(a, params, client_id, c, config)
    filter(params.diagnostics, filter_diagnostics)
    vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(on_publish_diagnostics_filtered, {
    virtual_text = {
        format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
        end,
    },
})

-- keyboard shortcut
vim.keymap.set('n', 'g?', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- vim.keymap.set('n', '<Leader>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>')
vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', '<Leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- Reference highlight
-- vim.cmd [[
--      set updatetime=200
--      " highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
--      " highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
--      " highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
--      augroup lsp_document_highlight
--      autocmd!
--          autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--          autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
--      augroup END
--  ]]
---------------------------------------------------------------------------
-- DAP
keymap('n', '<F4>', '<Cmd>DapToggleBreakpoint<CR>', { silent = true })
keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
keymap('n', '<leader>b', '<Cmd>DapToggleBreakpoint<CR>', { silent = true })
keymap('n', '<leader>B', '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>',
    { silent = true })
keymap('n', '<Leader>bl', '<Cmd>lua require("dap").list_breakpoints()<CR>:cw<CR>', { silent = true })
keymap('n', '<leader>b<Esc>', '<Cmd>lua require("dap").clear_breakpoints()<CR>', { silent = true })
keymap('n', '<leader>lp', '<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    { silent = true })
keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
keymap('n', '<leader>D', ':lua require("dapui").toggle()<CR>', {})
vim.cmd [[nnoremap <buffer><buffer><2-LeftMouse> <Cmd>lua require'dapui'.eval()<CR>]]
keymap('n', '<Leader>d?', '<cmd>lua require"dapui".eval()<CR>', { silent = true })

-- ビルドしてデバッグする。
keymap('n', '<F6>', '<Cmd>make<CR><Cmd>DapContinue<CR>', { silent = true })

-- vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpointTextHl' })
-- vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStoppedTextHl' })

-- local dap, dapui = require("dap"), require("dapui")
-- dapui.setup()
-- -- dap.listeners.after.event_initialized["dapui_config"] = function()
-- --     dapui.open()
-- -- end
-- -- dap.listeners.before.event_terminated["dapui_config"] = function()
-- --     dapui.close()
-- -- end
-- -- dap.listeners.before.event_exited["dapui_config"] = function()
-- --     dapui.close()
-- -- end
-- -- dap.setup()
-- 
-- dap.defaults.fallback.exseption_breakpoints = { 'raised', 'uncaughted' }
-- require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })

-- require 'dapui'.setup() {
--     -- icons =
-- }
---------------------------------------------------------------------------

-- Completion
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    enabled = true,
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs( -4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            mode = 'text',
        }),
    },
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
}

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

-- IDE
local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '_', api.tree.change_root_to_node, opts('CD'))
    -- vim.keymap.set('n', '<C-.>', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require 'nvim-tree'.setup {
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        -- mappings = {
        --     list = {
        --         -- { key = "u", action = "dir_up" },
        --     },
        -- },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
        git_ignored = false, -- デフォルトはtrue
        custom = {
            "^\\.git",
            "^node_modules",
        },
    },
    on_attach = my_on_attach,
}
keymap('n', '<Leader>ee', ':NvimTreeFocus<CR>', { noremap = true })


-- treesitter
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        -- 'typescript',
        -- 'tsx',
    },
    highlight = {
        enable = true,
    },
    require('ts_context_commentstring').setup {
        enable_autocmd = false,
        languages = {
            typescript = '// %s',
        },
    },
    endwise = { enable = true, },
    matchup = { enable = true, },

}

-- nvim-colorizer
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
        sass = { enable = false, parsers = { 'css' }, }, -- Enable sass colors
        virtualtext = "■",
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
}

-- Comment
require('Comment').setup {
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
    -- pre_hook = nil,
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), -- for treesitter-commentstring
    ---Function to call after (un)comment
    post_hook = nil,

}

-- Status line
require('lualine').setup {
    options = {
        icons_enabled = true,
        -- theme = 'auto',
        -- theme = 'gruvbox-material',
        -- material, gruvbox-material, modus-vivendi, nord, nightfly, moonfly, onedark
        theme = 'onedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                source = { 'nvim-lsp' }
            }
        },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}

}

-- Search
-- require 'pounce'.setup {
--     -- accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
--     -- accept_keys = "UEOIHTNPYGCRJQKWMVXB",
--     accept_keys = "UEOIHTNDGCRFPKJQXVWMB",
--     accept_best_key = "<enter>",
--     multi_window = true,
--     debug = false,
-- }
--
-- vim.keymap.set('n', 's', '<cmd>Pounce<CR>')
-- vim.keymap.set('n', 'S', '<cmd>PounceRepeat<CR>')
-- vim.keymap.set('v', 's', '<cmd>Pounce<CR>')
-- vim.keymap.set('o', 'gs', '<cmd>Pounce<CR>')
--
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})
vim.keymap.set('n', 'S', '<cmd>HopWord<CR>')
vim.keymap.set('n', 'gn', function() hop.hint_patterns({}, vim.api.nvim_exec('echo @/', true)) end)
vim.keymap.set('n', 'g/', '<cmd>HopPattern<CR>')

vim.cmd [[highlight HopNextKey  guifg=#c2355d guibg=#c2c2c2]]
vim.cmd [[highlight HopNextKey1  guifg=#c2352d guibg=#c2c2c2]]
vim.cmd [[highlight HopNextKey2  guifg=#c2352d guibg=#c2c2c2]]
-- vim.api.nvim_set_hl(0, 'HopNextKey', {guifg='#c2c52d'})
-- vim.api.nvim_set_hl(0, 'HopNextKey1', {guifg='#c2c52d'})
-- vim.api.nvim_set_hl(0, 'HopNextKey2', {guifg='#c2c52d'})

-- Jaq-nvim
require('jaq-nvim').setup {
    cmds = {
        -- Uses vim commands
        internal = {
            lua = "luafile %",
            vim = "source %"
        },

        -- Uses shell commands
        external = {
            markdown = "glow %",
            python   = "python %",
            go       = "go run %",
            sh       = "sh %"
        }
    },

    behavior = {
        -- Default type
        default = "terminal",

        -- Start in insert mode
        startinsert = false,

        -- Use `wincmd p` on startup
        wincmd = false,

        -- Auto-save files
        autosave = true
    },

    ui = {
        float = {
            -- See ':h nvim_open_win'
            border   = "none",

            -- See ':h winhl'
            winhl    = "Normal",
            borderhl = "FloatBorder",

            -- See ':h winblend'
            winblend = 0,

            -- Num from `0-1` for measurements
            height   = 0.8,
            width    = 0.8,
            x        = 0.5,
            y        = 0.5
        },

        terminal = {
            -- Window position
            position = "bot",

            -- Window size
            size = 20,

            -- Disable line numbers
            line_no = false
        },

        quickfix = {
            -- Window position
            position = "bot",

            -- Window size
            size = 10
        }
    }
}
keymap('n', '<Leader>cc', ':Jaq<CR>', { noremap = true })
keymap('n', '<Leader>C', ':Jaq<CR>', { noremap = true })
keymap('n', '<Leader>cb', ':Jaq bang<CR>', { noremap = true })
keymap('n', '<Leader>ct', ':Jaq terminal<CR>', { noremap = true })
keymap('n', '<Leader>cf', ':Jaq float<CR>', { noremap = true })

-- LunaSnip
-- REM
-- --press <Tab> to expand or jump in a snippet. These can also be mapped separately
-- -- via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
-- vim.cmd [[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ]]
-- -- -1 for jumping backwards.
-- vim.cmd [[inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>]]
--
-- vim.cmd [[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]]
-- vim.cmd [[snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>]]
--
-- -- For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- vim.cmd [[imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']]
-- vim.cmd [[smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']]
local ls = require('luasnip')
vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump( -1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })


--------------------------------------------------------------------------------
-- DAP
--------------------------------------------------------------------------------
--https://ryota2357.com/blog/2022/cpp-codelldb-debug-nvim/
-- local mason_registry = require("mason-registry")
-- local codelldb_root = mason_registry.get_package("codelldb"):get_install_path()
-- local cpptools_root = mason_registry.get_package("cpptools"):get_install_path()
-- dap.adapters = {
--     lldb_server = {
--         type = 'server',
--         -- port = '${port}',
--         port = 13000,
--         host = '127.0.0.1',
--         executable = {
--             -- Masonはここにデバッガを入れてくれる
--             command = codelldb_root .. '/extension/adapter/codelldb',
--             -- ポートを自動的に割り振ってくれる
--             args = {
--                 '--liblldb', codelldb_root .. '/extension/lldb/lib/liblldb.dylib',
--                 -- '--port', '${port}'
--                 '--port', 13000,
--             },
--         },
--         -- name = 'lldb-server'
--     },
--     lldb_server_local = {
--         type = 'server',
--         port = '${port}',
--         -- host = '127.0.0.1',
--         executable = {
--             -- Masonはここにデバッガを入れてくれる
--             command = os.getenv('HOME') .. '/.local/codelldb/extension/adapter/codelldb',
--             -- ポートを自動的に割り振ってくれる
--             args = {
--                 -- '--liblldb', codelldb_root .. '/extension/lldb/lib/liblldb.dylib',
--                 '--port', '${port}'
--             },
--         },
--         -- name = 'lldb-server'
--     },
--     lldb_server2 = {
--         type = 'server',
--         port = '${port}',
--         executable = {
--             command = mason_registry.get_package("codelldb"):get_install_path() .. 'bin/codelldb',
--             args = { '--port', '${port}' },
--         },
--     },
--     lldb = {
--         type = 'executable',
--         -- command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
--         command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
--         name = 'lldb'
--     },
--     cppdbg = {
--         id = 'cppdbg',
--         type = 'executable',
--         command = cpptools_root .. 'debugAdapters/bin/OpenDebugAD7',
--     },
-- }

-- ここにファイルタイプ別の設定
-- dap.configurations.cpp = {
--     -- 複数指定することもできる
--     -- 複数あるとデバッグ開始時にどの設定使うか聞かれる
--     {
--         name = 'Launch file', -- optional
--         -- dap.adapters にあるデバッガから、どれを使うか
--         type = 'lldb_server',
--         -- type = 'cppdbg',
--         -- デバッガの起動
--         request = 'launch',
--         -- コンパイル時に -g オプションをつけてビルドした実行ファイルを指定する
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/a.out', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--         args = {},
--         -- terminal = 'integrated'
--     },
--     -- {
--     --     name = 'Attach to gdbserver :1234',
--     --     type = 'cppdbg',
--     --     request = 'launch',
--     --     MIMode = 'gdb',
--     --     miDebuggerServerAddress = 'localhost:1234',
--     --     -- miDebuggerPath = '/usr/local/bin/gdb',
--     --     -- miDebuggerPath = '/usr/local/bin/gdb',
--     --     miDebuggerPath = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
--     --     cwd = '${workspaceFolder}',
--     --     program = function()
--     --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     --     end,
--     -- },
-- }
-- 
-- require 'dap-python'.setup(python_path.filename)
-- 
-- table.insert(dap.configurations.python, {
--     type = 'python',
--     request = 'launch',
--     name = 'Lauch in work',
--     cwd = '${workspaceFolder}/work',
--     program = '${file}',
--     -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- })

-- require('dap.ext.vscode').load_launchjs(nil, { codelldb = { 'c', 'cpp' } })

-- text-case
keymap('n', '<Leader>t', '<cmd>lua require("textcase").current_word("to_snake_case")<CR>', { noremap = true })
keymap('v', '<Leader>t', '<cmd>lua require("textcase").current_word("to_snake_case")<CR>', { noremap = true })
-- nnoremap gal :lua require('textcase').current_word('to_lower_case')<CR>
-- nnoremap gas :lua require('textcase').current_word('to_snake_case')<CR>
-- nnoremap gad :lua require('textcase').current_word('to_dash_case')<CR>
-- nnoremap gan :lua require('textcase').current_word('to_constant_case')<CR>
-- nnoremap gad :lua require('textcase').current_word('to_dot_case')<CR>
-- nnoremap gaa :lua require('textcase').current_word('to_phrase_case')<CR>
-- nnoremap gac :lua require('textcase').current_word('to_camel_case')<CR>
-- nnoremap gap :lua require('textcase').current_word('to_pascal_case')<CR>
-- nnoremap gat :lua require('textcase').current_word('to_title_case')<CR>
-- nnoremap gaf :lua require('textcase').current_word('to_path_case')<CR>
--
-- nnoremap gaU :lua require('textcase').lsp_rename('to_upper_case')<CR>
-- nnoremap gaL :lua require('textcase').lsp_rename('to_lower_case')<CR>
-- nnoremap gaS :lua require('textcase').lsp_rename('to_snake_case')<CR>
-- nnoremap gaD :lua require('textcase').lsp_rename('to_dash_case')<CR>
-- nnoremap gaN :lua require('textcase').lsp_rename('to_constant_case')<CR>
-- nnoremap gaD :lua require('textcase').lsp_rename('to_dot_case')<CR>
-- nnoremap gaA :lua require('textcase').lsp_rename('to_phrase_case')<CR>
-- nnoremap gaC :lua require('textcase').lsp_rename('to_camel_case')<CR>
-- nnoremap gaP :lua require('textcase').lsp_rename('to_pascal_case')<CR>
-- nnoremap gaT :lua require('textcase').lsp_rename('to_title_case')<CR>
-- nnoremap gaF :lua require('textcase').lsp_rename('to_path_case')<CR>
--
-- nnoremap geu :lua require('textcase').operator('to_upper_case')<CR>
-- nnoremap gel :lua require('textcase').operator('to_lower_case')<CR>
-- nnoremap ges :lua require('textcase').operator('to_snake_case')<CR>
-- nnoremap ged :lua require('textcase').operator('to_dash_case')<CR>
-- nnoremap gen :lua require('textcase').operator('to_constant_case')<CR>
-- nnoremap ged :lua require('textcase').operator('to_dot_case')<CR>
-- nnoremap gea :lua require('textcase').operator('to_phrase_case')<CR>
-- nnoremap gec :lua require('textcase').operator('to_camel_case')<CR>
-- nnoremap gep :lua require('textcase').operator('to_pascal_case')<CR>
-- nnoremap get :lua require('textcase').operator('to_title_case')<CR>
-- nnoremap gef :lua require('textcase').operator('to_path_case')<CR>
-- keymap('n', '/', '/\v', { noremap = true })
keymap('n', '<Leader>mm', ':TermExec cmd="make" size=25 name=make<CR>', { noremap = true })
keymap('n', '<Space><Space>', ':ToggleTermToggleAll<CR>', { noremap = true })
