`import Constants from 'constants.es6'`

TodoStore = Fluxxor.createStore
  initialize: ->
    @todos = []
    @bindActions(
      Constants.ADD_TODO, @onAddTodo,
      Constants.TOGGLE_TODO, @onToggleTodo,
      Constants.CLEAR_TODOS, @onClearTodos
    )

  onAddTodo: (payload) ->
    @todos.push(text: payload.text, complete: false)
    @emit('change')

  onToggleTodo: (payload) ->
    payload.todo.complete = !payload.todo.complete
    @emit("change")

  onClearTodos: ->
    @todos = @todos.filter((todo) -> !todo.complete)
    @emit("change")

  getState: ->
    todos: @todos

`export default TodoStore`
