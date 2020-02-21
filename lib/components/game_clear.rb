module Components
  class GameClear < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Congratulations🎉'
        o 'p', "Clear time: %.1fs" % state.elapsed_time
        o 'p', "WA: %d" % state.wa_count
        if state.wa_count == 0
          o 'p', 'You are Master of GraphQL!👏'
        elsif state.wa_count < 3
          o 'p', 'You may know GraphQL!👏'
        else
          o 'p' do 
            o 'span', 'You had too many mistakes! Be aware of the difference of GraphQL and Graph'
            o 'span.large-i', 'i'
            o 'span', 'QL'
          end
        end
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
