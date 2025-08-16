# FIGlet2Godot

## WARNING

I am putting up the initial files, but the only feature that actually works at the moment is the FIGlet tab itself, and only with the Linux version of FIGlet. If you try this out prior to an actual release, you are proceeding at your own risk :)

## Introduction

This plugin's intention is to provide a streamlined way of creating and formatting output from FIGlet to create ASCII word art for insertion into your game project or scripts (for example, as header labels).

![](https://github.com/freswinn/FIGlet2Godot/blob/main/Preview.png)

In order to use this plugin, you will require an installation of FIGlet (see the FIGlet Installation section, below).

More details to follow as this project progresses. Currently it is in a state that works for me, but I am on Linux and it works differently on Windows. I do not have a Mac and don't intend to make this Mac-compatible, but if this project gets to a stable release then someone can help themselves to making a branch.

# FIGlet Installation
FIGlet is a piece of software that has existed for decades in one form or another, created to generate large block text out of ASCII characters. See [http://www.figlet.org/](http://www.figlet.org) for details on FIGlet.

## Linux
Installing FIGlet on Linux ix very straightforward. You can probably find it on your distro's package manager, but you can also just type `sudo apt install figlet` in the console.

The official website of this version of FIGlet is the same as the one listed above: <give website here>

## Windows
I know of two versions of FIGlet that work on Windows, but I've only had one work in such a way that I've managed to get is output through Godot's `OS.execute()` method. Therefore, the one I recommend is pyfiglet.

To acquire and use pyfiglet, You must have an installation of Python 3 (I'm assuming you'll just wanna get the most recent one). Once installed, go to your Command Prompt and type `pip install pyfiglet` to install pyfiglet.

The official website of pyfiglet is [https://pypi.org/project/pyfiglet/]([url](https://pypi.org/project/pyfiglet/)).

# Check FIGlet Installation

This is not a complete tutorial on using FIGlet, just a very quick way to test that it's working on your computer.

**Linux (figlet):** To test that the installation is successful, type `figlet Hi!` into the console and you should get a block letter "Hi!" in return.

**Windows (pyfiglet):** To test that the installation is successful, type `pyfiglet Hi!` into Command Prompt and you should get a block letter "Hi!" in return.

If you use FIGlet in the console/command prompt but can't seem to get out of it, hit `Ctrl+C` to terminate the process.

On the official websites, you will find a guide, wiki, or manpage to help learn how to use FIGlet. The hope is that, once installed, none of the manpage stuff is actually necessary to be able to use my plugin for yourself.
