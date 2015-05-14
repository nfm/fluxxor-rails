`import Constants from 'constants.es6'`
`import UUID from 'uuid.es6'`

Todo = Immutable.Record
  uuid: undefined
  text: ''
  complete: false

TodoStore = Fluxxor.createStore
  initialize: ->
    @todos = new Immutable.Map()
    @bindActions(
      Constants.ADD_TODO, @onAddTodo,
      Constants.TOGGLE_TODO, @onToggleTodo,
      Constants.CLEAR_TODOS, @onClearTodos
    )

  onAddTodo: (payload) ->
    uuid = UUID.generate()
    @todos = @todos.set(uuid, new Todo(uuid: uuid, text: payload.text))
    @emit('change')

  onToggleTodo: (payload) ->
    @todos = @todos.update(payload.todo.uuid, (todo) -> todo.set('complete', !todo.complete))
    @emit("change")

  onClearTodos: ->
    @todos = @todos.filter((todo) -> !todo.complete)
    @emit("change")

  getState: ->
    todos: @todos.toJSON()

`export default TodoStore`
