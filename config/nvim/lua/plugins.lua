return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- FZF
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'stsewd/fzf-checkout.vim'

    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'justinmk/vim-dirvish'

    -- Neovim Tree shitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use 'nvim-treesitter/playground'

     -- colors
    use 'gruvbox-community/gruvbox'
    use 'dracula/vim'
    use 'lifepillar/vim-solarized8'
    use 'whatsthatsmell/codesmell_dark.vim'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope.nvim'

    -- Lua line
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'

    -- For vsnip user.
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
end)
