#!/usr/bin/env/ruby

require_relative "controllers/cli_controller.rb"
require_relative "controllers/cli_presenter.rb"
require_relative "usecases/field_setup.rb"
require_relative "usecases/input_phase.rb"
require_relative "usecases/battle_phase.rb"

cliPresenter = CLIPresenter.new

fieldSetter = FieldSetter.new(cliPresenter)
inputPhaseExecutor = InputPhaseExecutor.new(cliPresenter)
battlePhaseExecutor = BattlePhaseExecutor.new(cliPresenter)

cliController = CLIController.new(fieldSetter, inputPhaseExecutor, battlePhaseExecutor)

cliController.StartGame
