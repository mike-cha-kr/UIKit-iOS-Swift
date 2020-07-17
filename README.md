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


#### Unknown attribute error handling
In Xcode 11.3 or earlier, there is a problem that build is impossible due to the following two errors.

```basg
- Unknown attribute '_inheritsConvenienceInitializers'
- Unknown attribute '_hasMissingDesignatedInitializers'
```

This is due to the two annotation processing newly applied by Apple's Swift, and an error occurs because it is not a built-in function in Xcode 11.3 or earlier.

If this problem occurs, you can use the Framework normally after removing annotation by referring to the following procedure. 

This method removes the annotations that have problems in the swiftinterface that is automatically generated in the framework by executing the script in the build step in advance.

1. Open the `edit scheme` menu of the project target.

2. Select the `Build > Pre-actions` menu and add `new run script action`

3. After adding the script below, select the target to apply the script.

```bash
# Cocoapods
if [ -d "${PROJECT_DIR}/Pods/SendBirdUIKit" ]; then
    find ${PROJECT_DIR}/Pods/SendBirdUIKit/SendBirdUIKit.framework/Modules/SendBirdUIKit.swiftmodule/ -type f -name '*.swiftinterface' -exec sed -i '' s/'@_inheritsConvenienceInitializers '// {} +
    find ${PROJECT_DIR}/Pods/SendBirdUIKit/SendBirdUIKit.framework/Modules/SendBirdUIKit.swiftmodule/ -type f -name '*.swiftinterface' -exec sed -i '' s/'@_hasMissingDesignatedInitializers '// {} +
fi
```

4. Now build & run and you can see that the problem is solved.


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
