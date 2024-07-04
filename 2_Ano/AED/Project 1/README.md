
# Project 1 - Algorithms and Data Structures

## Objective:
* Develop and test the ADT (Abstract Data Type) `image8bit`, which allows instantiation and operations on grayscale images, where each pixel can take an intensity value between 0 and 255 (8 bits).

* Analyze the computational complexity of the function `ImageLocateSubImage(...)`, which determines, if it exists, the location of a subimage within a given image, and the function `ImageBlur(...)`, which applies a filter to an image and blurs it.

## Files
* `image8bit.c` - module implementation

* `image8bit.h` - module interface

* `instrumentation.[ch]` - module for operation counts and time measurement

* `imageTest.c` - simple test program

* `imageTool.c` - more versatile test program

* `Makefile` - rules for compiling and testing using make

* `README.md` - this information you are reading

* `Design-by-Contract.md` - explanation about the [DbC methodology][dbc] followed in this project.


## Download Images
### Run:

* `make pgm` - to download images to the `pgm/` folder
* `make setup` - to download images for tests in the `test/` folder

### Compile:
* `make` - Compiles and generates the test programs.
* `make clean` - Cleans object files and executables.

