
# text adventure made for intermediate challenge 2 of /r/dailyprogrammer

class DarkForest
  
  attr_reader :name, :stranger # names
  attr_reader :check_action, :sword, :death # boolean
  
  def initialize
    @stranger = "Melvin" # you can change the name of your enemy here
    @check_action = false
    @death = false
    @sword = false
  end
  
  def part1
    puts "You are waken up by a strange guy. You notice you are below a tree, inside a dark forest."
    puts "\"Hello, I'm #{stranger}. What is your name?\" - asks the guy." 
    @name = gets.chomp
    part2
  end
  
  def part2
    puts "\n\"So, #{name}, I am here to take you out of this forest before it is too late. Get up and let's go.\""
    puts "You stand up. #{stranger} starts walking. Before going after him, you realize there is a sword by your side, lying at the floor."
    
    while (!@check_action)
      puts "You can grab the SWORD, or FOLLOW #{stranger}."
      action = gets.chomp.upcase
      case action
        when "SWORD"
          part_sword
          @check_action = true
        when "FOLLOW"
          @check_action = true
        else
          puts "INVALID ACTION"
      end
    end
    
    @check_action = false
    puts "You go after #{stranger}."
    part3
  end
  
  def part3
    puts "\nYou two arrive at a bridge. It seems to be very old, and it might crumble if under too much weight."
    puts "#{stranger} turns to you:"
    puts "\"I think we shouldn't cross this bridge at the same time. What do you think, #{name}? What should we do?\""
    
    while (!@check_action)
      puts "You can LET #{stranger} cross the bridge, you can CROSS the bridge, or you can BOTH cross at the same time."
      action = gets.chomp.upcase
      case action
        when "LET"
          puts "\n#{stranger} cross the bridge in front of you. Nothing happens. You cross the bridge afterwards."
          @check_action = true
        when "CROSS"
          part_cross
          @check_action = true
        when "BOTH"
          part_both
          @check_action = true
        when "ATTACK"
          part_attack_s
        else
          puts "INVALID ACTION"
      end
    end
    
    @check_action = false
    if (death)
      part_death
    else
      part4
    end  
  end
  
  def part4
    puts "You arrive at an ancient construction. It looks like an altar for sacrifices."
    puts "#{stranger} goes to the center of it, right before a table, and looks at you, with eyes wide open:"
    puts "\"It's time for it, #{name}. You are the sacrifice tonight!!\""
    puts "#{stranger} starts casting the grandest and final spell. It doesn't seem things will end up well for you."
    
    if (sword)
      while (!@check_action)
        puts "You can use your sword to ATTACK #{stranger}, or you can STAND, waiting for the spell to be complete."
        action = gets.chomp.upcase
        case action
          when "ATTACK"
            part_attack1
            @death = true
            @check_action = true
          when "STAND"
            part_attack2
            @check_action = true
          else 
            puts "INVALID ACTION"
        end
      end
    else
      part_spell
      @death = true
    end
    
    if (death)
      part_death
    else
      part_conclusion
    end    
  end
  
  def part_cross
    puts "\nYou start crossing the bridge. #{stranger} silently watches you."
    puts "When you are in the middle of the bridge, #{stranger} starts laughing in an evil way."
    puts "#{stranger} evokes a black spell, which lifts a heavy rock onto the bridge."
    puts "The bridge crumbles, and you fall."
    @death = true
  end
  
  def part_both
    puts "\nYou two cross the bridge at the same"
    puts "Your weights combined are too much for the bridge. It starts crumbling."
    puts "#{stranger} casts a spell which makes him float."
    puts "You fall while watching #{stranger} levitating above you, until you hit the ground. The plants start moving to engulf and suffocate you."
    @death = true
  end
  
  def part_attack1
    puts "\nYou try to attack #{stranger}, but you are too nervous, and he is very aware of your actions."
    puts "#{stranger} prepares another spell, which makes a tree hits you from behind, making you drop the sword."
    puts "The tree branches capture you, and lift you, taking your body to the table. They finish with you by craving a hole in your chest."
  end
  
  def part_attack2
    puts "\nYou stand still, waiting for #{stranger} to finish his casting. He starts to wonder why you look so confident."
    puts "The spell is complete. The trees' roots start moving, trying to catch you."
    puts "You swing your sword and cut them off."
    puts "\"It can't be. You shouldn't be able to get rid of this.\" - says #{stranger}. He starts to get really worried, as you cut more and more roots."
    puts "You start approaching #{stranger}. He looks at you and says:"
    puts "\"I concede defeat.\""
    puts "You attack with the sword. #{stranger} falls to the floor."
  end
  
  def part_attack_s
    if (sword)
      puts "\nYou allow #{stranger} to cross before you. So he goes. When he arrives at the other side, he keeps looking straight ahead."
      puts "You slowly start crossing the bridge. When you are near the end of it, you prepare to attack."
      puts "You attack #{stranger} right through his back with your sword."
      puts "#{stranger} gasps as his lungs are filled with blood. He then falls to the floor."
      part_conclusion
      abort
    else
      puts "INVALID ACTION"
    end
  end
  
  def part_spell
    puts "\n\"You should have taken that sword with you, #{name}. Now you cannot defeat me.\""
    puts "#{stranger} finishes his casting. The roots of the trees raise and catch you. You cannot move anymore."
    puts "You are placed in the table."
    puts "The roots pierce through your chest. You start bleeding until your conscience subsides."
  end
  
  def part_sword
    @sword = true
    puts "\nYou grab the sword, and equip it."
    puts "\"So, you're a brave one, #{name}...\" - says #{stranger}, portraying an ironic smile."
  end
  
  def part_death
    puts "\"Too bad, #{name}, too bad...\" - mumbles #{stranger}."
    puts "You have died."
    puts "GAME OVER"
  end
  
  def part_conclusion()
    puts "The dark forest starts vanishing right before your eyes. On its place, you start seeing your town. This is the last thing you remember before waking up at the dark forest."
    puts "You realize you were trapped inside an illusion of #{stranger}. Now you are free."
    puts "Well done, #{name}."
  end
  
end

forest = DarkForest.new
forest.part1
