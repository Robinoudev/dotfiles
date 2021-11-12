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
    use 'marko-cerovac/material.nvim'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- use {
    --   'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     -- your statusline
    --     config = function() require'robin.spaceline' end,
    --     -- some optional icons
    --     requires = {'kyazdani42/nvim-web-devicons', opt = true}
    -- }

    -- Dadbod for databases
    use('tpope/vim-dadbod')
    use('kristijanhusak/vim-dadbod-ui')

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'

    -- For vsnip user.
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- basic utils
    use 'windwp/nvim-autopairs'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
end)
