namespace(:schemagic) do

  desc("Generate JSON schema from YARD doc comments")
  task(:from_yard) do
    Rake::Task["schemagic:yard:models"].execute()
    Schemagic::FromYard.generate()
  end

end
