local exports = {}
local lsp_util = require('vim.lsp.util')

vim.opt.completeopt = { 'menu', 'noinsert', 'noselect', 'menuone' }

local function key(key_code)
  return vim.api.nvim_replace_termcodes(key_code, true, false, true)
end

-- from runtime lsp.lua
-- this script ensures that the match start column is based on the encoding used
-- by the lsp
local function adjust_start_col(lnum, line, items, encoding)
  local min_start_char = nil
  for _, item in pairs(items) do
    if item.textEdit and item.textEdit.range.start.line == lnum - 1 then
      if
        min_start_char
        and min_start_char ~= item.textEdit.range.start.character
      then
        return nil
      end
      min_start_char = item.textEdit.range.start.character
    end
  end
  if min_start_char then
    if encoding == 'utf-8' then
      return min_start_char
    else
      return vim.str_byteindex(line, min_start_char, encoding == 'utf-16')
    end
  else
    return nil
  end
end

function exports.complete(direction)
  if vim.fn.pumvisible() == 1 then
    if direction == 1 then
      return key('<c-n>')
    end
    return key('<c-p>')
  end

  local min_chars = 1
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line():sub(1, pos[2])
  local last_chars = line:match('%S+$')
  if not last_chars or #last_chars < min_chars then
    return key('<tab>')
  end

  if last_chars:match('%W(/%w+)*/%w*') then
    -- open the file completion popup
    vim.api.nvim_feedkeys(key('<c-x><c-f>'), 'm', true)
  else
    -- open the keyword completion popup
    vim.api.nvim_feedkeys(key('<c-n>'), 'm', true)

    if vim.bo.omnifunc ~= 'v:lua.vim.lsp.omnifunc' then
      return ''
    end

    -- get a list of the keyword matches
    local keyword_items = {}
    vim.schedule(function ()
      local info = vim.fn.complete_info({ 'mode', 'items' })
      vim.list_extend(keyword_items, info.items)
    end)

    -- If omnifunc is setup for lsp, call the lsp completer. If there are any
    -- LSP matches, they'll override the keyword matches
    local bufnr = vim.api.nvim_get_current_buf()
    local keyword = vim.fn.match(line, '\\k*$')
    local params = lsp_util.make_position_params()

    -- This is the request from the runtime lua.lsp. It's repeated here so that
    -- we can only override the completion list if the lsp completer returns
    -- results. Otherwise, any keyword results being displayed will be left
    -- alone.
    vim.lsp.buf_request(
      bufnr,
      'textDocument/completion',
      params,
      function(err, result, ctx)
        if err or not result or vim.fn.mode() ~= 'i' then
          return
        end
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local encoding = client and client.offset_encoding or 'utf-16'
        local candidates = vim.lsp.util.extract_completion_items(result)
        local startbyte = adjust_start_col(pos[1], line, candidates, encoding)
          or keyword
        local prefix = line:sub(startbyte + 1, pos[2])
        local matches =
          vim.lsp.util.text_document_completion_list_to_complete_items(
            result,
            prefix
          )

        -- append any lsp items to the match list and update the completion menu
        local lsp_items = matches
        local lsp_words = vim.tbl_map(function (item)
          return item.word
        end, matches)
        for _, item in pairs(keyword_items) do
          if not vim.tbl_contains(lsp_words, item.word) then
            table.insert(lsp_items, item)
          end
        end
        vim.fn.complete(startbyte + 1, lsp_items)
      end
    )
  end

  return ''
end

-- manual completion and cycling
local util = require('util')
util.imap('<tab>', 'v:lua.completion.complete(1)', { expr = true })
util.imap('<s-tab>', 'v:lua.completion.complete(-1)', { expr = true })

-- automatic completion
util.augroup('custom-completion', {
  'TextChangedI *.md,*.textile lua completion.complete(0)',
})

_G.completion = exports

return exports
