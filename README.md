angularjs-cordova-osx
=====================

Bash script that installs the required dependencies for generator-angularjs-cordova for ios and android.

The aim is to get an environment that is fully configured. If any additional configuration is required, please create an issue for it.

# Requirements
xcode 1.6
xcode command line tools

# Disclaimer: 
By installing this you are accepting oracle license jdk-8u25-oth-JPR. see http://www.oracle.com/technetwork/java/javase/terms/license/index.html

# Installs the following:
- Android SDK r23.0.2 with installed API level 19
- Android API level 19 r01 x86 image
- Android API level 19 Nexus S x86 default AVD
- Oracle JDK 1.8 25
- Brew
- Enables showing hidden files and folders
- Ant
- node
- npm packages bower grunt-cli yo cordova generator-angularjs-cordova ios-sim ios-deploy
- ipa https://github.com/nomad/shenzhen

# Instructions
clone this repository and execute the script. Enter your user password when prompted
```
git clone https://github.com/jonaseck2/angularjs-cordova-osx.git
cd angularjs-cordova-osx
bash setup.sh
```

# Test
The aim is for the following to work after execution:
## Generate a skeleton using yeoman
```
mkdir HelloCordova
cd HelloCordova
yo angularjs-cordova
```
Answer the questions and remember to check th ios box for ios support.

## Basic desktop serve
```
grunt serve
```
## Android emulation or device deploy
```
grunt build
cordova emulate android 
cordova run android 
```
## IOS emulation or device deploy
For device deploy, open the platforms/ios/<appname>.xcodeproj project in xcode and ensure that a provisioning profile is configured for the project.
```
grunt build
cordova emulate ios
cordova run ios
```

### IOS testflight distribution
```
grunt build
cordova build ios --release
cd platforms/ios
ipa distribute
API Token:
<enter your api token from https://testflightapp.com/account>
Team Token:
<enter your api token from https://testflightapp.com/dashboard/team/edit>
What's new in this release:
<Replace with release message>
```



License: MIT
