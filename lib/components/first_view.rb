module Components
  class FirstView < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Master of GraphQL'
        o 'p', 'Choose "GraphQL"'
        o 'p', 'Note: "GraphiQL" is not "GraphQL"!'
        o 'button', { onclick: handle_start_game }, 'Start'
      end
    end

    def handle_start_game
      -> () do
        actions.dispatch(state: { page: :stage1, start_time: Time.now })
      end
    end
  end
end
