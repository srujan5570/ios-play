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

# Add the framework file reference to the project
# The group is 'Runner' to match where other files are
group = project.main_group.find_subpath('Runner', true)
framework_ref = group.new_file(framework_path)

# Add the framework to the 'Link Binary With Libraries' build phase
target.frameworks_build_phase.add_file_reference(framework_ref)

# Find or create the 'Embed Frameworks' build phase
embed_phase = target.build_phases.find do |phase|
  phase.is_a?(Xcodeproj::Project::Object::PBXCopyFilesBuildPhase) && phase.name == 'Embed Frameworks'
end

if embed_phase.nil?
  puts "Creating new 'Embed Frameworks' build phase."
  embed_phase = project.new(Xcodeproj::Project::Object::PBXCopyFilesBuildPhase)
  embed_phase.name = 'Embed Frameworks'
  embed_phase.dst_path = ''
  embed_phase.dst_subfolder_spec = '10' # Corresponds to the 'Frameworks' directory
  target.build_phases << embed_phase
end

# Add the framework to the 'Embed Frameworks' build phase
embed_phase.add_file_reference(framework_ref)
puts "Added framework to 'Embed Frameworks' phase."

# Save the project
project.save

puts "Successfully added and configured CastarSDK.framework to the project." 