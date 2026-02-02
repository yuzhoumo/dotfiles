return {
  cmd = { 'omnisharp' },
  filetypes = { 'cs', 'vb' },
  root_markers = { '*.sln', '*.csproj', 'omnisharp.json', 'function.json', '.git', 'NuGet.config' },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    },
  },
}
