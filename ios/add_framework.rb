#!/usr/bin/env ruby

require 'xcodeproj'

# Path to the Xcode project
project_path = 'Runner.xcodeproj'
framework_path = 'CastarSDK.framework'

# Open the project
project = Xcodeproj::Project.open(project_path)

# Get the main target
target = project.targets.find { |t| t.name == 'Runner' }

if target.nil?
  puts "Error: Could not find Runner target"
  exit 1
end

# Add the framework file reference
framework_ref = project.new_file(framework_path)

# Add framework to the target's frameworks build phase
target.frameworks_build_phase.add_file_reference(framework_ref)

# Add framework to the target's embed frameworks build phase
target.embed_frameworks_build_phase.add_file_reference(framework_ref)

# Save the project
project.save

puts "Successfully added CastarSDK.framework to the project" 