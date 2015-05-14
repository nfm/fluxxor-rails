`import Flux from 'flux.es6'`

ApplicationComponent = React.createClass
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("TodoStore")]

  getInitialState: ->
    newTodoText: ""

  getStateFromFlux: ->
    @getFlux().store("TodoStore").getState()

  render: ->
    <div>
      <ul>
        {
          @state.todos.map (todo, i) ->
            <li key={i}><TodoItem todo={todo} /></li>
        }
      </ul>
      <form onSubmit={@onSubmitForm}>
        <input type="text" size="30" placeholder="New Todo" value={@state.newTodoText} onChange={@handleTodoTextChange} />
        <input type="submit" value="Add Todo" />
      </form>
      <button onClick={@clearCompletedTodos}>Clear Completed</button>
    </div>

  handleTodoTextChange: (e) ->
    @setState(newTodoText: e.target.value)

  onSubmitForm: (e) ->
    e.preventDefault()
    if @state.newTodoText.trim()
      @getFlux().actions.addTodo(@state.newTodoText)
      @setState(newTodoText: "")

  clearCompletedTodos: (e) ->
    @getFlux().actions.clearTodos()

TodoItem = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  propTypes:
    todo: React.PropTypes.object.isRequired

  render: ->
    style = { textDecoration: "line-through" } if @props.todo.complete
    <span style={style} onClick={@onClick}>{@props.todo.text}</span>

  onClick: ->
    @getFlux().actions.toggleTodo(@props.todo)

React.render(<ApplicationComponent flux={Flux} />, document.getElementById("app"))
