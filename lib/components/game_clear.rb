module Components
  class GameClear < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Congratulations🎉'
        o 'p', 'You are Master of GraphQL!👏'
        o 'button', { onclick: handle_click }, 'Replay'
      end
    end

    def handle_click
      -> () do
        actions.dispatch(state: { page: :first_view })
      end
    end
  end
end
