`import TodoStore from 'stores/todo_store.es6'`
`import Constants from 'constants.es6'`

actions = 
  addTodo: (text) -> @dispatch(Constants.ADD_TODO, text: text)
  toggleTodo: (todo) -> @dispatch(Constants.TOGGLE_TODO, todo: todo)
  clearTodos: -> @dispatch(Constants.CLEAR_TODOS)

Flux = new Fluxxor.Flux(TodoStore: new TodoStore(), actions)

`export default Flux`
