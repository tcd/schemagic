namespace(:schemagic) do

  desc("Explaining what the task does")
  task(:example) do
    puts("this is an example")
  end

  desc("Generate JSON schema from YARD doc comments")
  task(:from_yard) do
    binding.pry
    # Schemagic::FromYard.generate()
    Schemagic::FromYard.debug()
  end

end
