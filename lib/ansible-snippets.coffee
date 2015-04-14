AnsibleSnippetsView = require './ansible-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AnsibleSnippets =
  ansibleSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ansibleSnippetsView = new AnsibleSnippetsView(state.ansibleSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @ansibleSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ansible-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ansibleSnippetsView.destroy()

  serialize: ->
    ansibleSnippetsViewState: @ansibleSnippetsView.serialize()

  toggle: ->
    console.log 'AnsibleSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
