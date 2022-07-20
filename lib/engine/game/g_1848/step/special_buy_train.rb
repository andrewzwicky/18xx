# frozen_string_literal: true

require_relative '../../../step/special_buy_train'

module Engine
  module Game
    module G1848
      module Step
        class SpecialBuyTrain < Engine::Step::SpecialBuyTrain
          def process_buy_train(action)
            company = action.entity
            super
            # special ability is both on player and corporate, remove all left over abilities

            company.all_abilities.each { |ab| company.remove_ability(ab) }
            return unless @game.private_closed_triggered

            # close company if company closes and the ability has been used
            @log << "#{company.name} closes"
            company.close!
          end
        end
      end
    end
  end
end
