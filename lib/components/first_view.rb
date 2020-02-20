module Components
  class FirstView < Ovto::Component
    def render
      o 'div' do
        o 'h1', 'Master of GraphQL'
        o 'p', 'Choose "GraphQL"'
        o 'p', 'Note: "GraphiQL" is not "GraphQL"!'
        o 'button', { onclick: handle_click }, 'Start'
      end
    end

    def handle_click
      -> () do
        actions.dispatch(state: { page: :stage1 })
      end
    end
  end
end
