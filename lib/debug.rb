# frozen_string_literal: true

# Simple debugging class
class Debug
  attr_accessor :flag

  def initialize
    @flag = false
    a = $LOAD_PATH
    a.each do |current_path|
      @flag = true if current_path.include?('rb/gems')
      break if @flag
    end
    flag
  end

  def puts(string)
    Kernel.puts(string) if flag
  end
end
