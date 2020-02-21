module Components
  class Stage < Ovto::PureComponent
    def render(stage_count:, words_count:, next_stage:, last: false, nonce:, timer_id:)
      o 'div' do
        o 'h2', "Stage #{stage_count}"

        o 'div.words' do
          words = ['GraphQL'] + ['GraphiQL'] * (words_count - 1)
          words.shuffle.each do |word|
            o 'div.word', { onclick: handle_click(word, next_stage: next_stage, last: last, timer_id: timer_id), style: random_margin }, word
          end
        end
      end
    end

    def random_margin
      n = [*1..15]
      m = -> { "#{n.sample}px" }
      {
        'margin-top': m.(),
        'margin-bottom': m.(),
        'margin-right': m.(),
        'margin-left': m.(),
      }
    end

    def handle_click(word, next_stage:, last:, timer_id:)
      case word
      when 'GraphQL'
        handle_click_correct(next_stage: next_stage, last: last, timer_id: timer_id)
      else
        handle_click_wrong
      end
    end

    def handle_click_correct(next_stage:, last:, timer_id:)
      -> () do
        actions.dispatch(state: { page: next_stage })
        if last
          Native(`window`).clearInterval(timer_id)
          actions.dispatch(state: { timer_id: nil })
        end
      end
    end

    def handle_click_wrong
      -> () do
        # just re-shuffle
        actions.dispatch(state: { nonce: rand })
      end
    end
  end
end
