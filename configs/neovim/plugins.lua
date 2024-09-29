-- configurations/neovim/lua/plugins.lua
return require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Менеджер пакетов
	use("neovim/nvim-lspconfig") -- Настройки LSP
	-- Добавьте больше плагинов здесь
end)
