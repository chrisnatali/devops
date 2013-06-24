# copied almost directly from the tm2 readme here:
# https://github.com/mapbox/tm2 

sudo apt-get install -y python-software-properties git
echo 'Yes' | sudo apt-add-repository ppa:chris-lea/node.js
echo 'Yes' | sudo add-apt-repository ppa:mapnik/v2.2.0
sudo apt-get update -y
sudo apt-get install -y nodejs protobuf-compiler libprotobuf-lite7 libprotobuf-dev libmapnik libmapnik-dev make

git clone https://github.com/mapbox/tm2.git
cd tm2
npm install

# Run the tm2 server -> node index.js

