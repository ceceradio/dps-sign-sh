#!/bin/bash

echo "PLEASE MAKE SURE YOU HAVE UNZIPPED YOUR IPA FILE ALREADY IN OS X FINDER."
echo "And that entitlements.plist file is in this folder WITH THE CORRECT VALUES."
echo "Warning: failure complete the above steps will result in failure to validate on the device."
echo "Press any key to begin."

read

echo "Enter the name of the signing certificate from your Keychain:"
echo "e.g. iPhone Distribution: Sample Corporation"

read CERTIFICATE

echo "Enter the BundleIdentifer from the App ID"
echo "e.g. com.sample.app"

read BUNDLEID

echo "Enter the file path to the mobile provision profile. THE FILE MUST BE IN THIS FOLDER"
echo "e.g. Sample_App.mobileprovision"

read PROVISION

rm -rf ./Payload/Jupiter.app/_CodeSignature ./Payload/Jupiter.app/CodeResources
cp ./"$PROVISION" ./Payload/Jupiter.app/embedded.mobileprovision
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BUNDLEID" ./Payload/Jupiter.app/Info.plist

codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/AFNetwork.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/Analytics.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/ArticleParser.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/ArticleView.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/Base.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/BaseUI.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/BrowseView.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/DataModel.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/SDWebImage.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app/Frameworks/SocialSharing.framework
codesign -fvs "$CERTIFICATE" --entitlements entitlements.plist ./Payload/Jupiter.app
# zip it back up
zip -qr "$BUNDLEID"-signed.ipa Payload