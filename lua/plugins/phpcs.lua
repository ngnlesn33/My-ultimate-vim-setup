return {
  -- PHPCS installation.
  -- https://github.com/WordPress/WordPress-Coding-Standards?tab=readme-ov-file#installation
  "praem90/nvim-phpcsf",
  config = function()
    vim.api.nvim_create_augroup("PHPCSGroup", { clear = true })

    vim.g.nvim_phpcs_config_phpcs_path = "phpcs"
    vim.g.nvim_phpcs_config_phpcbf_path = "phpcbf"
    vim.g.nvim_phpcs_config_phpcs_standard = "PSR12" -- or path to your ruleset phpcs.xml

    -- Setup auto formatting for php files using phpcs
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = "PHPCSGroup",
      pattern = "*.php",
      command = "lua require'phpcs'.cs()",
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "PHPCSGroup",
      pattern = "*.php",
      command = "lua require'phpcs'.cbf()",
    })

    vim.keymap.set("n", "<leader>lp", function()
      require("phpcs").cbf()
    end, {
      silent = true,
      noremap = true,
      desc = "PHP Fix",
    })
  end,
}
