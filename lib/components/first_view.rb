module Components
  class FirstView < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Master of GraphQL'
        o 'p', 'Choose "GraphQL"'
        o 'p' do
          o 'span',  'Note: "Graph'
          o 'span.large-i',  'i'
          o 'span',  'QL" is not "GraphQL"!'
        end
        o 'button', { onclick: handle_start_game }, 'Start'
      end
    end

    def handle_start_game
      -> () do
        timer_id = Native(`window`).setInterval( -> () {
          actions.dispatch(state: { elapsed_time: Time.now - state.start_time })
        }, 100)
        actions.dispatch(state: { page: :stage1, start_time: Time.now, timer_id: timer_id })
      end
    end
  end
end
