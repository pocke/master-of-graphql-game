require 'ovto'
require 'native'
require 'components/first_view'
require 'components/stage'
require 'components/game_clear'

module Game
  class MainApp < Ovto::App
    class State < Ovto::State
      INITIAL_STATE = {
        page: :first_view,
        wa_count: 0,
        start_time: nil,
        timer_id: nil,
        elapsed_time: 0,
      }

      item :page, default: INITIAL_STATE[:page]
      item :wa_count, default: INITIAL_STATE[:wa_count]
      item :start_time, default: INITIAL_STATE[:start_time]
      item :timer_id, default: INITIAL_STATE[:timer_id]
      item :elapsed_time, default: INITIAL_STATE[:elapsed_time]
    end

    class Actions < Ovto::Actions
      def dispatch(state:)
        return state
      end

      def reset(state:)
        return State::INITIAL_STATE
      end
    end

    class MainComponent < Ovto::Component
      def render
        o 'div.container' do
          if state.timer_id
            o 'div' do
              o 'p', "WA: %d, time: %.1f" % [state.wa_count, state.elapsed_time]
            end
          end

          case state.page
          when :first_view
            o Components::FirstView
          when :stage1
            o Components::Stage, stage_count: 1, words_count: 2, next_stage: :stage2, wa_count: state.wa_count, timer_id: state.timer_id
          when :stage2
            o Components::Stage, stage_count: 2, words_count: 10, next_stage: :stage3, wa_count: state.wa_count, timer_id: state.timer_id
          when :stage3
            o Components::Stage, stage_count: 3, words_count: 30, next_stage: :stage4, wa_count: state.wa_count, timer_id: state.timer_id
          when :stage4
            o Components::Stage, stage_count: 4, words_count: 50, next_stage: :stage5, wa_count: state.wa_count, timer_id: state.timer_id
          when :stage5
            o Components::Stage, stage_count: 5, words_count: 100, next_stage: :game_clear, wa_count: state.wa_count, timer_id: state.timer_id, last: true
          when :game_clear
            o Components::GameClear
          else
            raise "unknown page: #{state.page}"
          end
        end
      end
    end
  end
end

Game::MainApp.run(id: 'ovto')
