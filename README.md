# SendBird-UIKit-iOS-Swift-Sample

## Install UIKit

#### CocoaPods

1. Install the `SendBirdUIKit` framework through `CocoaPods`.

```bash
$ pod install
```

2. Update the `SendBirdUIKit` framework through `CocoaPods`.

```bash
$ pod update 
```

> __Note__: Sendbird UIKit for iOS is Sendbird Chat SDK-dependent. If you install the UIKit, `CocoaPods` will automatically install the Chat SDK for iOS as well. The minimum requirement of the Chat SDK for iOS is 3.0.190 or higher.


#### Handling errors caused by unknown attributes

If you are building your project with Xcode 11.3 or earlier versions, the following 2 errors may occur.

```bash
- Unknown attribute ‘_inheritsConvenienceInitializers’
- Unknown attribute ‘_hasMissingDesignatedInitializers’
```

This is because of the 2 new annotation processing methods rolled out in `Swift 5.2`, which is used in Xcode 11.5. As they don’t apply to Xcode 11.3 and earlier versions that use `Swift 5.1`, such errors will occur in the `swiftinterface` that is automatically generated in UIKit.

When those errors happen, refer to the following steps to remove the new annotations that cause trouble in the `swiftinterface`. Once they are removed, UIKit will work properly.

1. Open the **Edit scheme** menu of the project target.
![EditScheme](https://static.sendbird.com/docs/ios/ui-kit-getting-started-handling-errors-01_20200623.png)
2. Go to **Build** > **Pre-actions** and select the **New Run Script Action** option at the bottom.
![NewRunScriptAction](https://static.sendbird.com/docs/ios/ui-kit-getting-started-handling-errors-02_20200623.png)
3. Add the script below to the editor and select the target to apply the script to.
![ApplyScript](https://static.sendbird.com/docs/ios/ui-kit-getting-started-handling-errors-03_20200623.png)
```bash
# CocoaPods
if [ -d "${PROJECT_DIR}/Pods/SendBirdUIKit" ]; then
    find ${PROJECT_DIR}/Pods/SendBirdUIKit/SendBirdUIKit.framework/Modules/SendBirdUIKit.swiftmodule/ -type f -name '*.swiftinterface' -exec sed -i '' s/'@_inheritsConvenienceInitializers '// {} +
    find ${PROJECT_DIR}/Pods/SendBirdUIKit/SendBirdUIKit.framework/Modules/SendBirdUIKit.swiftmodule/ -type f -name '*.swiftinterface' -exec sed -i '' s/'@_hasMissingDesignatedInitializers '// {} +
fi

# Carthage
if [ -d "${PROJECT_DIR}/Carthage/Build/iOS/SendBirdUIKit.framework" ]; then
    find ${PROJECT_DIR}/Carthage/Build/iOS/SendBirdUIKit.framework/Modules/SendBirdUIKit.swiftmodule/ -type f -name '*.swiftinterface' -exec sed -i '' s/'@_inheritsConvenienceInitializers '// {} +
    find ${PROJECT_DIR}/Carthage/Build/iOS/SendBirdUIKit.framework/Modules/SendBirdUIKit.swiftmodule/ -type f -name '*.swiftinterface' -exec sed -i '' s/'@_hasMissingDesignatedInitializers '// {} +
fi
```
4. Once removed, you can continue building your project.




---


## Customization sample

After signing-in on the sample app, you can enter the custom sample screen through the **Custom Samples** button. And, you can check the sample for Customization in the code and app.

Customization-related code is implemented in the `/Customize` folder. And, the sample consists of the following:

| Feature | Items | Desctription |
| :---: | :--- | :--- |
| Global | ColorSet | Sample of customizing the global color set (Primary colors) |
|  | FontSet | Sample of customizing the global font set (All fonts) |
|  | IconSet | Sample of customizing the global icon set (Barbuttons |
|  | StringSet | Sample of customizing the global string set (Header titles) |
|  | Theme | Sample of customizing the global theme (ChannelListTheme only) |
| ChannelList| UI Component | Sample of modifying some ui elements<br> (The customized part is marked with a red border) |
| | Custom Cell | Sample of changing default channel cells to custom cells |
| | ChannelListQuery | Sample of displaying empty channels and frozen channels using `SBDGroupChannelListQuery` |
| | Function Overriding | Sample that inherits and customizes `SBUChannelListViewController` class |
|Channel | UI Component | Sample of modifying some ui elements<br> (The customized part is marked with a red border) |
| | Custom Cell | Sample of changing default message cells to custom cells |
| | MessageListParams | Sample of using `SBDMessageListParams` to add specific attributes to call up a message list |
| | MessageParams | Sample sending and displaying messages by adding specific attributes using `SBUUserMessageParams` |
| | Function Overriding | Sample that inherits and customizes `SBUChannelViewController` class |
|Channel Settings | UI Component | Sample of modifying some ui elements<br> (The customized part is marked with a red border) |
| | Function Overriding | Sample that inherits and customizes `SBUChannelSettingsViewController` class |
|Create Channel | UI Component | Sample of modifying some ui elements<br> (The customized part is marked with a red border) |
| | Custom Cell | Sample of changing default user cells to custom cells |
| | User list | Sample of using own UserList |
|Invite User | UI Component | Sample of modifying some ui elements<br> (The customized part is marked with a red border) |
| | Custom Cell | Sample of changing default user cells to custom cells |
| | User list | Sample of using own UserList |
|Member List | UI Component | Sample of modifying some ui elements<br> (The customized part is marked with a red border) |
| | Custom Cell | Sample of changing default user cells to custom cells |
| | Function Overriding | Sample that inherits and customizes `SBUMemberListViewController` class |
