Mimas Torres
====

Installing the server
====
* install python 3 ("sudo apt-get install python3")
* install pip3 ("sudo apt-get install python3-pip")
* if using virtualenv, "virtualenv env", ". env/bin/activate"
* install dependencies (pip install -r requirements.txt)

Installing grunt
====
* install nodejs
* in terminal (windows/linux) run:
⋅⋅⋅ "npm install -g grunt"
* move to the project root (this folder)
* run "npm install"
* compile Coffescript files with "grunt coffee"
* compile Less files with "grunt less"
* to start the automatic coffee compiler, run the command "grunt"


Running the server
====
move to torres/
* "python3 __init__.py"
