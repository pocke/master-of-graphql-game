module Components
  class GameClear < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Congratulations🎉'
        o 'p', "Clear time: #{state.clear_time - state.start_time}s"
        o 'p', 'You are Master of GraphQL!👏'
        o 'button', { onclick: handle_click }, 'Replay'
      end
    end

    def handle_click
      -> () do
        actions.dispatch(state: { page: :first_view, start_time: nil, clear_time: nil })
      end
    end
  end
end
