return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    },
    config = function()
      require("codecompanion").setup({
        pre_defined_prompts = {
          ["Explain"] = {
            prompts = {
              {
                role = "system",
                content = [[Отвечай всегда на русском языке. When asked to explain code, follow these steps:

1. Identify the programming language.
2. Describe the purpose of the code and reference core concepts from the programming language.
3. Explain each function or significant block of code, including parameters and return values.
4. Highlight any specific functions or methods used and their roles.
5. Provide context on how the code fits into a larger application if applicable. ОТВЕТ ПИШИ НА РУССКОМ ЯЗЫКЕ!! РУССКИЙ ЯЗЫК ДЛЯ ОТВЕТОВ ТВОИХ!!! ОТВЕТ ПИШИ НА РУССКОМ ЯЗЫКЕ]],
                opts = {
                  visible = false,
                },
              },
              {
                role = "user",
                content = function(context)
                  local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                  return "Please explain this code:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n\n"
                end,
                opts = {
                  contains_code = true,
                },
              },
            },
          },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              url = "https://openrouter.ai/api/v1/chat/completions",
              schema = {
                model = {
                  default = "anthropic/claude-3.5-sonnet",
                  -- default = "openai/o1-mini",
                },
              },
              env = {
                api_key = "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",
              },
            })
          end,
        },
      })
    end,
  },
}
