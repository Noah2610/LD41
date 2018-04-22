require File.join DIR[:misc],         'extensions'

require File.join DIR[:misc],         'misc'

require File.join DIR[:rb],           'Settings'

require File.join DIR[:misc],         'resources'

# Includes (modules)
require_files DIR[:includes]

require File.join DIR[:rb],           'Instance'

#require File.join DIR[:rb],           'Entity'

require File.join DIR[:clusters],     'Cluster'
require_files DIR[:clusters], except: 'Cluster'

require File.join DIR[:rb],           'ClusterManager'

require File.join DIR[:enemies],      'Enemy'
require_files DIR[:enemies], except:  'Enemy'

require File.join DIR[:rb],           'Line'

require File.join DIR[:rb],           'Fort'
