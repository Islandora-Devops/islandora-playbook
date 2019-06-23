# Islandora 8 Sandbox Creation for Beginners

This document will explain, in the simplest step-by-step possible, how to take a computer from "unwanted box in the corner with no operating system" to working Islandora 8 sandbox.

## Terminology:
Some terminology you may need to understand to follow this step-by-step document:

Sandbox (n.) -- a copy of a software environment that you can "play in"; usually means a version that can be easily created, 
messed up, and wiped clean again

Terminal (n.) -- a command-line interface for your computer. This is the fancy/scary looking interface that sometimes has 
colorful text on a black background. Terminals provide more control than a GUI when making the kinds of advanced changes to
a computer system that are required for software like the pre-requisite requirements for Islandora.

Requirement (n.) -- software/hardware basics that must be in place before a piece of software will run properly

GUI (n.) -- a graphical user interface. This is the "pretty" front end designed for end-users.

OS (n.) -- [Operating system](https://en.wikipedia.org/wiki/Operating_system) This is the software that supports a computer's basic functions. Examples of an OS include Microsoft Windows, macOS, and many flavors of Linux.

RAM (n.) -- Random Access Memory, also called memory, this is used for temporary storage.

Hard drive (n.) -- longer-term memory where computers store saved files and software.

### Step-by-step:
#### Step one: Gather your equipment

Find the computer you want to use for your Islandora sandbox. It does not have to have an operating system (like Windows),
but if it does, that's not a problem. It should be a machine that has been totally wiped or only has files that can be deleted. If you have any files on it that you would like to save, you should back them up elsewhere. 

  Other requirements this computer will (ideally) meet:
  1. 3GB of RAM (2GB of RAM required for Ubuntu desktop)
  2. 4GB of hard drive memory free (25 GB required for Ubuntu desktop)
  3. Internet connection
  
You will also need an empty USB drive with at least 2 GB of space and a computer with an existing OS and internet connection for step two.
  
  * If you're not sure how much RAM and free memory on your hard drive is on the computer and you have a Windows computer, you can follow this [tutorial](https://www.computerhope.com/issues/ch000149.htm) to check that it meets the requirements.

  * If you don't have an operating system on the machine you want to use for your sandbox, you can try to install the Ubuntu operating system as described in step 2 and 3, then follow the instructions in this [tutorial](https://howtoubuntu.org/how-to-find-out-how-much-ram-is-installed-in-ubuntu) to make sure you have more than 3 GB of RAM (called Memory in the tutorial) and 4GB of hard drive memory (called Disk in the tutorial) required to run the default version of Islandora 8.

#### Step two: Create a bootable drive of Ubuntu

On another computer, insert the USB drive. Follow [these instructions](https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-windows#0), or this summary:
  1. Download [Rufus](https://rufus.akeo.ie/).
  2. Download [Ubuntu desktop](https://www.ubuntu.com/download/desktop).
  3. Run Rufus and select Ubuntu boot selection and the correct USB drive.

#### Step three: Install Ubuntu as your new OS

On the Islandora sandbox computer, follow these [instructions](https://tutorials.ubuntu.com/tutorial/tutorial-install-ubuntu-desktop#0), or this summary:
  1. Insert USB drive into the computer.
  2. Restart the computer.
  3. If the welcome screen for Ubuntu doesn't pop up, restart again, this time holding down F12.
  4. On the welcome screen, select your language and "Install Ubuntu."
  4. Follow the Ubuntu prompts, supplying your information when requested, and otherwise accepting the default selections.
  1. For installation type, select "Erase [name of current operating system] and reinstall".
  1. Restart.
  1. Congratulations on your new Linux computer!

#### Step four: Download Requirements for Islandora

On your new Ubuntu computer, download the following:
1. [Virtual Box](https://www.virtualbox.org/)
2. [Vagrant](https://www.vagrantup.com/) (version 2.0 or required)

Open the terminal of your new Ubuntu computer to download the remaining requirements:
1. To install [git](https://git-scm.com/) follow these [instructions](https://www.liquidweb.com/kb/install-git-ubuntu-16-04-lts/), or the following:

>$ apt-get update

>$ apt-get install git

>$ git --version

1. To install ansible, type the following lines of code, one at a time, into the terminal:

>$ sudo apt-get update

>$ sudo apt-get install software-properties-common

>$ sudo apt-add-repository ppa:ansible/ansible

>$ sudo apt-get update

>$ sudo apt-get install ansible

#### Step five: Clone and Run Islandora 8 vagrant
1. To download Islandora 8, type the following into the terminal:

>$ git clone https://github.com/Islandora-Devops/claw-playbook.git

2. When that script has finished running, open or move into the appropriate folder by typing the following into the terminal:

>$ cd claw-playbook

3. To run the scripts, type:

>$ vagrant up

