# frozen_string_literal: true

require 'view/game/actionable'

module View
  module Game
    class Split < Snabberb::Component
      include Actionable

      needs :corporation

      def render_split_for_others
        LOGGER.info("render_split_for_others")
        return nil unless @step.respond_to?(:can_split_for)

        targets = @step.can_split_for(@current_entity)
        LOGGER.info("#{targets}")

        return nil
      end

      def render_split
        # Split handler
        handler = lambda do
          process_action(Engine::Action::Split.new(@current_entity, corporation: @corporation))
        end

        # Split button properties
        props = {
          style: {
            width: 'calc(17.5rem/6)',
            padding: '0.2rem',
          },
          on: { click: handler },
        }

        # Split button
        h('button.small', props, 'Split')
      end

      def render
        @step = @game.round.active_step
        @current_entity = @step.current_entity

        children = []
        children << render_split
        children << render_split_for_others
        children = children.compact

        h(:div, children)
      end
    end
  end
end
