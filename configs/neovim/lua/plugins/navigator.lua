return {
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        doc_lines = 2,
        floating_window = true,
        transparency = 30,
        -- use_lspsaga = true,
        fix_pos = true,
        hint_enable = true,
        hint_prefix = " ",
        hint_scheme = "String",
        hi_parameter = "Search",
        max_height = 22,
        max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        handler_opts = {
          border = "rounded", -- double, single, shadow, none
        },
        zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
        padding = " ", -- character to pad on left and right of signature can be ' ', or '|'  etc
      })
    end,
  },

  {
    "ray-x/navigator.lua",
    enabled = false,
    dependencies = {
      { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      debug = false, -- log output
      width = 0.75, -- value of cols
      height = 0.38, -- listview height
      preview_height = 0.38,
      preview_lines = 40, -- total lines in preview screen
      preview_lines_before = 5, -- lines before the highlight line
      default_mapping = true,
      keymaps = {}, -- e.g keymaps={{key = "GR", func = vim.lsp.buf.references}, } this replace gr default mapping
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double', "shadow"
      lines_show_prompt = 10, -- when the result list items number more than lines_show_prompt,
      -- fuzzy finder prompt will be shown
      combined_attach = "both", -- both: use both customized attach and navigator default attach, mine: only use my attach defined in vimrc
      treesitter_analysis = true, -- treesitter variable context
      treesitter_analysis_max_num = 100, -- how many items to run treesitter analysis
      treesitter_analysis_condense = true, -- short format of function
      treesitter_analysis_depth = 3, -- max depth
      transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil to disable it
      lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
      -- setup here. if it is nil, navigator will not init signature help
      signature_help_cfg = nil, -- if you would like to init ray-x/lsp_signature plugin in navigator, pass in signature help
      ctags = {
        cmd = "ctags",
        tagfile = ".tags",
        options = "-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number",
      },
      lsp = {
        enable = true, -- if disabled make sure add require('navigator.lspclient.mapping').setup() in you on_attach
        code_action = {
          delay = 3000, -- how long the virtual text will be shown
          enable = true,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
          virtual_text_icon = true,
        },
        rename = {
          style = "floating-preview", -- 'floating' | 'floating-preview' | 'inplace-preview'
          show_result = true,
          confirm = "<S-CR>",
          cancel = "<S-ESC>",
        },
        document_highlight = true, -- highlight reference a symbol
        code_lens_action = {
          enable = true,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
          virtual_text_icon = true,
        },
        diagnostic = {
          underline = true,
          virtual_text = { spacing = 3, source = true }, -- show virtual for diagnostic message
          update_in_insert = true, -- update diagnostic message in insert mode
          severity_sort = { reverse = true },
        },
        hover = {
          enable = true,
        }, -- bind hover action to keymap; there are other options e.g. noice, lspsaga provides lsp hover
        format_on_save = true, -- {true|false} set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
        -- table: {enable = {'lua', 'go'}, disable = {'javascript', 'typescript'}} to enable/disable specific language
        -- enable: a whitelist of language that will be formatted on save
        -- disable: a blacklist of language that will not be formatted on save
        -- function: function(bufnr) return true end to enable/disable lsp format on save
        format_options = { async = false }, -- async: disable by default, I saw something unexpected
        disable_nulls_codeaction_sign = true, -- do not show nulls codeactions (as it will alway has a valid action)
        disable_format_cap = {}, -- a list of lsp disable file format (e.g. if you using efm or vim-codeformat etc), empty by default
        disable_lsp = {}, -- a list of lsp server disabled for your project, e.g. denols and tsserver you may
        -- only want to enable one lsp server
        disply_diagnostic_qf = false, -- always show quickfix if there are diagnostic errors
        diagnostic_load_files = true, -- lsp diagnostic errors list may contains uri that not opened yet set to true
        -- to load those files
        diagnostic_virtual_text = true, -- show virtual for diagnostic message
        diagnostic_update_in_insert = true, -- update diagnostic message in insert mode
        diagnostic_scrollbar_sign = { "▃", "▆", "█" }, -- set to nil to disable, set to {'╍', 'ﮆ'} to enable diagnostic status in scroll bar area

        servers = { "pylsp" },
      },
      lsp_installer = false, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
      mason = true, -- set to true if you would like use the lsp installed by williamboman/mason
      -- mason_disabled_for = {}, -- disable mason for specified lspclients
      icons = {
        icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
        -- Code action
        code_action_icon = "", -- '🏏',
        -- code lens
        code_lens_action_icon = "👓",
        -- Diagnostics
        diagnostic_head = "🐛",
        diagnostic_err = "📛",
        diagnostic_warn = "👎",
        diagnostic_info = [[👩]],
        diagnostic_hint = [[💁]],

        diagnostic_head_severity_1 = "🈲",
        diagnostic_head_severity_2 = "☣️",
        diagnostic_head_severity_3 = "👎",
        diagnostic_head_description = "👹",
        diagnostic_virtual_text = "🦊",
        diagnostic_file = "🚑",
        -- Values
        value_changed = "📝",
        value_definition = "🐶🍡", -- it is easier to see than 🦕
        side_panel = {
          section_separator = "",
          line_num_left = "",
          line_num_right = "",
          inner_node = "├○",
          outer_node = "╰○",
          bracket_left = "⟪",
          bracket_right = "⟫",
        },
        -- Treesitter
        match_kinds = {
          var = " ", -- "👹", -- Vampaire
          method = "ƒ ", --  "🍔", -- mac
          ["function"] = " ", -- "🤣", -- Fun
          parameter = "  ", -- Pi
          associated = "🤝",
          namespace = "🚀",
          type = " ",
          field = "🏈",
          module = "📦",
          flag = "🎏",
        },
        treesitter_defult = "🌲",
        doc_symbols = "",
      },
    },
    config = function(_, opts)
      local navigator = require("navigator")
      navigator.setup(opts)
    end,
  },
}
