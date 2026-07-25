return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'sioyek'
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = '_tex_aux',
      out_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      hooks = {},
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
    -- visual/conceal settings
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 1,
      greek = 1,
      math_bounds = 1,
      sections = 1,
      styles = 1,
    }

    vim.opt.conceallevel = 2
    vim.opt.concealcursor = 'nc'
  end,
}
