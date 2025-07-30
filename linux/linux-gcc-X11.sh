# ---------------------------------------------------------------------------------------------------
# gcc

sudo apt update
sudo apt install build-essential
sudo apt-get install build-essential gdb

gcc --version
g++ --version
gdb --version

sudo apt install libx11-dev
sudo apt-get install libx11-dev xserver-xorg-dev xorg-dev


sudo apt-get install libx11-dev  		#.....for X11/Xlib.h
sudo apt-get install mesa-common-dev	#.....for GL/glx.h
sudo apt-get install libglu1-mesa-dev 	#.....for GL/glu.h
sudo apt-get install libxrandr-dev 		#.....for X11/extensions/Xrandr.h
sudo apt-get install libxi-dev 			#.....for X11/extensions/XInput.h


# ---------------------------------------------------------------------------------------------------
# X11/Xlib

cc -L/usr/lib/i386-linux-gnu -lX11 hellowin.c

Apparently, that is the correct location, as 'locate libX11' gives me:

/usr/lib/i386-linux-gnu/libX11.a

Order of arguments to gcc and linking matters a big lot
(compiler options, sources files, object files, libraries from high-level to low-level ones):

gcc hello-x.c -L/usr/X11R6/lib -lX11 -o hello-x
gcc -Wall -g  hellowin.c  -L/usr/lib/i386-linux-gnu -lX11 -o hellowin
gcc -Wall -Wno-pointer-sign -g xnoisesph.c -o xnoisesph.out -L/usr/lib/x86_64-linux-gnu -lX11 -lm

/usr/lib/x86_64-linux-gnu/libX11.a


# install X11 apps

sudo apt install x11-apps -y
