#!/usr/bin/env bash

android_sdk="http://dl.google.com/android/android-sdk_r23.0.2-macosx.zip"
intel_image="http://download-software.intel.com/sites/landingpage/android/sysimg_x86-19_r01.zip"
android_device="Nexus S"
java_sdk="http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-macosx-x64.dmg"
homebrew="https://raw.githubusercontent.com/Homebrew/install/master/install"

defaults write com.apple.finder AppleShowAllFiles YES

if [ ! -x /usr/local/bin/brew ] ; then
	echo y | ruby -e "$(curl -fsSL ${homebrew})"
fi

if [ -d sadasda ] ; then
    curl -fsSLjkO -H "Cookie: oraclelicense=accept-securebackup-cookie" "${java_sdk}"
    hdiutil mount ${java_sdk##*/}
    sudo installer -package "/Volumes/JDK 8 Update 25/JDK 8 Update 25.pkg" -target "/Volumes/Macintosh HD"
    hdiutil unmount "/Volumes/JDK 8 Update 25/"
    rm -f ${java_sdk##*/}

    sudo sh -c "echo \'export JAVA_HOME=$(/usr/libexec/java_home)\' >> /etc/launchd.conf"
    source /etc/launchd.conf
fi

if [ ! -d "${HOME}/android-sdk-macosx" ] ; then
    echo 'export ANDROID_HOME=${HOME}/android-sdk-macosx' >> ${HOME}/.bash_profile
    echo 'export PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools' >> ${HOME}/.bash_profile
    echo 'export ANDROID_SDK_HOME=${HOME}/.android' >> ${HOME}/.bash_profile

    source ${HOME}/.bash_profile

    curl -fsSLO "${android_sdk}"
    unzip -qq "${android_sdk##*/}" -d ~/
    rm -f ${android_sdk##*/}
fi

if [ ! -d  "${ANDROID_HOME}/platforms/android-19" ] ; then
    echo y | android update sdk -u --all --filter "platform-tool,android-19,build-tools-19.1.0"
fi

if [ ! -d "${ANDROID_HOME}/system-images/android-19/default/x86" ] ; then
    curl -fsSLO "${intel_image}"
    mkdir -p ${ANDROID_HOME}/system-images/android-19/default/
    unzip -o "${intel_image##*/}" -d ${ANDROID_HOME}/system-images/android-19/default/
    rm -f ${intel_image##*/}
fi

if [ `android list avd | wc -l` -le 1 ] ; then
    android -s create avd -n default-19 -t android-19 -b default/x86 -d "${android_device}"
fi
