# ampy wrapper
The main goal is to make the process of work with [ampy](https://github.com/adafruit/ampy) even simpler and more convenient.  
Ampyw can do only 2 things:
1. To put all your python files on the board with a single command (-f argument).
2. To pass commands to ampy (you don't need to point a port in every command) (no arguments).
## Prerequisites
In order to let ampyw define your port automatically, you should edit the first script's line:
```
port="/dev/$(ls /dev | grep cu.wchusbserial)" # should be changed for non-MacOS
```
What goes on here? In MacOS a board is always binded to `/dev/cu.wchusbserialxxxx` where `xxxx` can very. `ls /dev` shows all entries upon `/dev` folder, `grep cu.wchusbserial` filters them by `cu.wchusbserial` string and finally received device name is attached to `/dev/`. That's how it 'knows' your port.  
If you use MacOS and [this](https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver) driver you should be ok.  

**Then place the script into the folder with your code!**  
And make it executable `chmod +x ampyw`  
## Usage
```
./ampyw.sh -f
```
```
./ampyw.sh rm main.py
```
```
./ampyw.sh ls
```
