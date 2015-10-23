# dps-sign-sh
A script and method for signing DPS 2015 apps in secure environments where the DPS Signing Tool cannot be run.

## Requirements

* OS X
* Xcode
* An unsigned DPS 2015 IPA file

Follow these steps to successfully sign your DPS 2015 app:

* Clone this repo. These instructions assume the folder's name is `dps-sign-sh/`.
* Put your `.mobileprovision` file into `dps-sign-sh/`.
* Put your `YourAppName.ipa` file `dps-sign-sh/`, and rename it to `YourAppName.zip`
* Unzip `YourAppName.zip` by double clicking it in Finder. If you don’t unzip it this way, it will not preserve permissions, and the iOS device will reject the resulting IPA.
* Edit `entitlements.plist` to ensure that the TEAM ID and BUNDLE Ids have changed. You may also want to remove the aps-environment key if your App Id does not include permissions for push notifications. The provided `entitlements.plist` file cannot be used out of the box. You must edit it with the proper values and entitlements.
* Run `sign.sh` and follow the prompts. It will ask you for:
  * The name of the signing certificate in Keychain Access.
  * The bundle id: e.g. com.sample.app
  * The filename of the `.mobileprovision` file that you put in the folder. E.g. `SampleApp.mobileprovision`
* The script will then sign the app and its frameworks, embed the mobile provision file, and change the app bundle id to the provided bundle id.
* Finally, it will zip up the Payload folder into `com.sample.app-signed.ipa`

## Common Errors

You may get an error about entitlements not matching the provisioning profile. Change your `entitlements.plist` file to match the entitlements section of your provisioning profile. You can view that section by opening your `.mobileprovision` file with UTF-8 encoding, and browsing the XML to find the `<entitlements>` section.
