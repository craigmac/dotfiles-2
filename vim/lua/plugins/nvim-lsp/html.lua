local exports = {}

function exports.on_attach(client)
  -- disable formatting for html; we'll use prettier instead
  client.resolved_capabilities.document_formatting = false
end

return exports
