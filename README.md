# SendBird-UIKit-iOS-Swift-Sample

#### CocoaPods

2. Install the `SendBirdUIKit` framework through `CocoaPods`.

```bash
$ pod install
```

3. Update the `SendBirdUIKit` framework through `CocoaPods`.

```bash
$ pod update 
```

> __Note__: Sendbird UIKit for iOS is Sendbird Chat SDK-dependent. If you install the UIKit, `CocoaPods` will automatically install the Chat SDK for iOS as well. The minimum requirement of the Chat SDK for iOS is 3.0.179 or higher.


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
