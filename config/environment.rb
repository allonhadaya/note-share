# Spawn the etherpad-lite server
# Process.detach(spawn('C:/dev/lib/etherpad-lite-win/start.bat', :pgroup=>0, :chdir=>'C:/dev/lib/etherpad-lite-win/'))
# EtherpadLite::Client.ca_path = 'C:/Users/Allon/.ssh/id_rsa.pub'

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
NoteShare::Application.initialize!
