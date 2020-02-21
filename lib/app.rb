require 'ovto'
require 'native'
require 'components/first_view'
require 'components/stage'
require 'components/game_clear'

module Game
  class MainApp < Ovto::App
    class State < Ovto::State
      item :page, default: :first_view
      item :nonce, default: 0
      item :start_time, default: nil
      item :timer_id, default: nil
      item :elapsed_time, default: 0
    end

    class Actions < Ovto::Actions
      def dispatch(state:)
        return state
      end
    end

    class MainComponent < Ovto::Component
      def render
        o 'div.container' do
          if state.timer_id
            o 'div' do
              o 'p', "time: #{state.elapsed_time}s"
            end
          end

          case state.page
          when :first_view
            o Components::FirstView
          when :stage1
            o Components::Stage, stage_count: 1, words_count: 2, next_stage: :stage2, nonce: state.nonce, timer_id: state.timer_id
          when :stage2
            o Components::Stage, stage_count: 2, words_count: 10, next_stage: :stage3, nonce: state.nonce, timer_id: state.timer_id
          when :stage3
            o Components::Stage, stage_count: 3, words_count: 30, next_stage: :stage4, nonce: state.nonce, timer_id: state.timer_id
          when :stage4
            o Components::Stage, stage_count: 4, words_count: 50, next_stage: :stage5, nonce: state.nonce, timer_id: state.timer_id
          when :stage5
            o Components::Stage, stage_count: 5, words_count: 100, next_stage: :game_clear, nonce: state.nonce, timer_id: state.timer_id, last: true
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
