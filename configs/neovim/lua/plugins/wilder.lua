-- https://github.com/gelguy/wilder.nvim

-- install luarocks and fd
-- luarocks install pcre2

return {

  -- sudo pacman -S python-pynvim
  -- https://github.com/gelguy/wilder.nvim/issues/196
  {
    "gelguy/wilder.nvim",
    dependencies = {
      { "Gerodote/fzy-lua-native_updated_gitignore_repaired_makefile", build = "make", lazy = false },
      -- {
      --   "nixprime/cpsm",
      --   dependencies = { "ctrlpvim/ctrlp.vim", lazy = false },
      --   lazy = false,
      --   build = "bash ./install.sh",
      -- },
    },
    build = function()
      vim.cmd([[
                let &rtp=&rtp
            ]])
      vim.api.nvim_command("runtime! plugin/rplugin.vim")
      vim.api.nvim_command(":UpdateRemotePlugins")
    end,
    lazy = false, -- make sure the plugin is always loaded at startup
    --         config = true,
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
            -- to use fd      : {'fd', '-td'}
            dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
            -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
            -- found at https://github.com/nixprime/cpsm
            filters = { "fuzzy_filter", "difflib_sorter" },
          }),

          wilder.cmdline_pipeline({
            fuzzy = 2,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),

          wilder.python_search_pipeline()
        ),
      })

      local gradient = {
        "#f4468f",
        "#fd4a85",
        "#ff507a",
        "#ff566f",
        "#ff5e63",
        "#ff6658",
        "#ff704e",
        "#ff7a45",
        "#ff843d",
        "#ff9036",
        "#f89b31",
        "#efa72f",
        "#e6b32e",
        "#dcbe30",
        "#d2c934",
        "#c8d43a",
        "#bfde43",
        "#b6e84e",
        "#aff05b",
      }
      -- local gradient = {
      --   "#a6cee3",
      --   "#1f78b4",
      --   "#b2df8a",
      --   "#33a02c",
      --   "#fb9a99",
      --   "#e31a1c",
      --   "#fdbf6f",
      --   "#ff7f00",
      --   "#cab2d6",
      --   "#6a3d9a",
      --   "#ffff99",
      --   "#b15928",
      -- }

      for i, fg in ipairs(gradient) do
        gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
      end

      local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        border = "rounded",
        max_height = "75%", -- max height of the palette
        min_height = 0, -- set to the same as 'max_height' for a fixed height window
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        highlighter = wilder.highlighter_with_gradient({ wilder.lua_fzy_highlighter() }), --wilder.basic_highlighter(),
        highlights = {
          gradient = gradient,
          accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
        },
        left = {
          " ",
          wilder.popupmenu_devicons(),
          wilder.popupmenu_buffer_flags({
            flags = " a + ",
            icons = { ["+"] = "", a = "", h = "" },
          }),
        },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))

      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = popupmenu_renderer,
          ["/"] = wildmenu_renderer,
          substitute = wildmenu_renderer,
        })
      )
    end,
  },
}
