# frozen_string_literal: true

require_relative 'lib/action/options'
require_relative 'lib/text_handler/text_block'

# main game file
class DarkForest
  attr_reader :hero, :stranger, :check_action, :sword, :death

  def initialize
    @stranger = 'Melvin'
    @check_action = false
    @death = false
    @sword = false
  end

  def call
    text('introduction', stranger: stranger)
    @hero = gets.chomp
    part_presentation
  end

  private

  def part_presentation
    text('presentation', stranger: stranger, hero: hero)

    while !@check_action
      text('action_beginning', stranger: stranger)
      action = gets.chomp.upcase
      case action
      when Action::Options::SWORD
        part_sword
        @check_action = true
      when Action::Options::FOLLOW
        @check_action = true
      else
        puts Action::Options::INVALID_OPTION
      end
    end

    @check_action = false
    text('post_beginning', stranger: stranger)
    part_bridge
  end

  def part_bridge
    text('bridge', stranger: stranger, hero: hero)

    while !@check_action
      text('action_bridge', stranger: stranger)
      action = gets.chomp.upcase
      case action
      when Action::Options::LET
        text('let_cross', stranger: stranger)
        @check_action = true
      when Action::Options::CROSS
        part_cross
        @check_action = true
      when Action::Options::BOTH
        part_both
        @check_action = true
      when Action::Options::ATTACK
        part_surprise_attack
      else
        puts Action::Options::INVALID_OPTION
      end
    end

    @check_action = false
    if death
      part_death
    else
      part_spell
    end
  end

  def part_spell
    text('spell', stranger: stranger, hero: hero)

    if sword
      while !@check_action
        text('action_spell', stranger: stranger)
        action = gets.chomp.upcase
        case action
        when Action::Options::ATTACK
          text('failed_attack', stranger: stranger)
          @death = true
          @check_action = true
        when Action::Options::STAND
          text('successfull_attack', stranger: stranger)
          @check_action = true
        else
          puts Action::Options::INVALID_OPTION
        end
      end
    else
      text('spell_finished', stranger: stranger, hero: hero)
      @death = true
    end

    if death
      part_death
    else
      part_conclusion
    end
  end

  def part_cross
    text('cross', stranger: stranger)
    @death = true
  end

  def part_both
    text('cross_both', stranger: stranger)
    @death = true
  end

  def part_surprise_attack
    if sword
      text('surprise_attack', stranger: stranger)
      part_conclusion
      abort
    else
      puts Action::Options::INVALID_OPTION
    end
  end

  def part_sword
    @sword = true
    text('sword_grab', stranger: stranger, hero: hero)
  end

  def part_death
    text('game_over', stranger: stranger, hero: hero)
  end

  def part_conclusion
    text('conclusion', stranger: stranger, hero: hero)
  end

  def text(block_name, vars)
    TextHandler::TextBlock.new(block_name, vars).print_content
  end
end

DarkForest.new.call
