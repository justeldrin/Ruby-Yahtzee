# Ruby-Yahtzee
The game of Yahtzee created in Ruby 2D!
## Prerequisites 
In order to run this game of Yahtzee one will need to install Ruby and Ruby 2D.
## Installation of Ruby 
1. Go to https://rubyinstaller.org/downloads/ in order to download the current Ruby+Devkit 64-bit release 
2. Run the installer. In the final step of the installer, make sure the Run 'ridk install' option is checked in order to install MSYS2 and the development tool chain.
3. You will now be asked which components you want to install. Simply just press 'enter' to all that is prompted. 
4. At the end of the installation, you can just press 'enter' again to close it.
## Checking Ruby Installation 
You can first check if your installation went through properly by using command prompt and simply writing
````
ruby --version
````  
Which should give an result like the following:
````
ruby 3.0.3p157 (2021-11-24 revision 3fb7d2cadc) [x64-mingw32]
````
## Installing Ruby 2D
Simply run the following line in your command prompt: 
````
gem install ruby2d
```` 
In order to check installation:
````
ruby2d --version
````
## Running Ruby Yahtzee
You have three choices when it comes to running Ruby Yahtzee:
* Run from an IDE 

or 
* Run from the command prompt 

or 
* Just click on the file in the folder 

Before that though you must first either download the zip file containing all the code or clone the repository. 
Make sure to extract the all the files if you downloaded the zip file and also make sure you know where your code is being stored! 

__IDE:__
1. Open which ever IDE you wish to use. 
2. Choose the option to Open or Import a Project or something to open the files you've downloaded.
3. You will now open the local ternimal available through the IDE. 
4. cd into the folder that has the __yahtzee.rb__ file in it.
5. Now run the following line in the terminal in order to run that file: 
````
ruby yahtzee.rb
````
6. The game window will open and you are free to play!

__Command Prompt:__
1. Open your command prompt
2. cd into the folder that has the __yahtzee.rb__ file in it.
3. Now run the following line in the terminal in order to run that file: 
````
ruby yahtzee.rb
````
4. The game window will open and you are free to play!

__From the folder itself:__
1. Open the file and go into the either the Ruby-Yahtzee-master folder if you downloaded the zip or Ruby-Yahtzee folder if you cloned the repository.
2. Click on the __yahtzee.rb__ file. 
3. The game window opens using command prompt and you are free to play! 
