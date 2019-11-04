{\rtf1\ansi\ansicpg1252\cocoartf1671
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fswiss\fcharset0 ArialMT;}
{\colortbl;\red255\green255\blue255;\red27\green29\blue31;\red255\green255\blue255;}
{\*\expandedcolortbl;;\cssrgb\c14118\c15294\c16078;\cssrgb\c100000\c100000\c100000;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # Glimpse iOS App\
\
The Glimpse app allows you to access media created from both individual devices and from the entire database.\
\
## Installation\
\
Download Xcode (Must have a Mac)\
Clone the repository\
Install Cocoapods library - Open Terminal\
\
 ```bash\
Sudo gem install cocoapods\
```\
\pard\pardeftab720\sl340\partightenfactor0

\f1 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done. Next, you need to setup the cocoapods master repo. Type in terminal:\
\
```bash\
Pod setup\
```\
\
It will take a while to setup, but once it finishes navigate to the project directory and type: \
```bash\
Pod install\
```\
Then open up the project folder and open up the GlimpseApp.xcworkspace (not .xcodeproj)\
Connect your device to your computer\
Build the project and select your device in the top left corner next to the play button\
Run the project and the app should download to your phone\
\
}