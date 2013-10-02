#!/bin/bash

command -v wget  >/dev/null 2>&1 || { echo "I require wget but it's not installed. Aborting." >&2; exit 1; }
command -v zip   >/dev/null 2>&1 || { echo "I require zip but it's not installed. Aborting." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "I require unzip but it's not installed. Aborting." >&2; exit 1; }

echo "This script will generate releases for Win32, Win64, Mac OS X, and a GameOfLife.love file."

mkdir releases
zip releases/GameOfLife.love main.lua conf.lua lifeforms.lua README.md
cd releases

wget https://bitbucket.org/rude/love/downloads/love-0.8.0-win-x86.zip
wget https://bitbucket.org/rude/love/downloads/love-0.8.0-win-x64.zip
wget https://bitbucket.org/rude/love/downloads/love-0.8.0-macosx-ub.zip

unzip love-0.8.0-win-x86.zip
cat love-0.8.0-win-x86/love.exe GameOfLife.love > love-0.8.0-win-x86/GameOfLife.exe
rm love-0.8.0-win-x86/love.exe
zip -r GameOfLife-win-x86.zip love-0.8.0-win-x86
rm -rf love-0.8.0-win-x86.zip love-0.8.0-win-x86

unzip love-0.8.0-win-x64.zip
cat love-0.8.0-win-x64/love.exe GameOfLife.love > love-0.8.0-win-x64/GameOfLife.exe
rm love-0.8.0-win-x64/love.exe
zip -r GameOfLife-win-x64.zip love-0.8.0-win-x64
rm -rf love-0.8.0-win-x64.zip love-0.8.0-win-x64

unzip love-0.8.0-macosx-ub.zip
mv love.app GameOfLife.app
cp GameOfLife.love GameOfLife.app/Contents/Resources
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>BuildMachineOSBuild</key>
    <string>11D50b</string>
    <key>CFBundleDevelopmentRegion</key>
    <string>English</string>
    <key>CFBundleDocumentTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeIconFile</key>
            <string>LoveDocument.icns</string>
            <key>CFBundleTypeName</key>
            <string>LÖVE Project</string>
            <key>CFBundleTypeRole</key>
            <string>Viewer</string>
            <key>LSHandlerRank</key>
            <string>Owner</string>
            <key>LSItemContentTypes</key>
            <array>
                <string>org.love2d.love-game</string>
            </array>
        </dict>
        <dict>
            <key>CFBundleTypeName</key>
            <string>Folder</string>
            <key>CFBundleTypeOSTypes</key>
            <array>
                <string>fold</string>
            </array>
            <key>CFBundleTypeRole</key>
            <string>Viewer</string>
            <key>LSHandlerRank</key>
            <string>None</string>
        </dict>
    </array>
    <key>CFBundleExecutable</key>
    <string>love</string>
    <key>CFBundleIconFile</key>
    <string>Love.icns</string>
    <key>CFBundleIdentifier</key>
    <string>com.adecimo.gameoflife</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>GameOfLife</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>0.8.0</string>
    <key>CFBundleSignature</key>
    <string>LoVe</string>
    <key>DTCompiler</key>
    <string></string>
    <key>DTPlatformBuild</key>
    <string>4E2002</string>
    <key>DTPlatformVersion</key>
    <string>GM</string>
    <key>DTSDKBuild</key>
    <string>11D50a</string>
    <key>DTSDKName</key>
    <string>macosx10.7</string>
    <key>DTXcode</key>
    <string>0432</string>
    <key>DTXcodeBuild</key>
    <string>4E2002</string>
    <key>NSHumanReadableCopyright</key>
    <string>© 2006-2012 LÖVE Development Team</string>
    <key>NSMainNibFile</key>
    <string>SDLMain</string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
' > GameOfLife.app/Contents/Info.plist
zip -r GameOfLife-osx.zip GameOfLife.app
rm -rf love-0.8.0-macosx-ub.zip GameOfLife.app

echo "Done !"
