module Components
  class GameClear < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Congratulations🎉'
        o 'p', "Clear time: %.1fs" % state.elapsed_time
        o 'p', 'You are Master of GraphQL!👏'
        o 'button', { onclick: handle_click }, 'Replay'
      end
    end

    def handle_click
      -> () do
        actions.reset
      end
    end
  end
end
