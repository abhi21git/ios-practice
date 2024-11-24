import ProjectDescription

//let targets = ["iOSPractice", "iOSPracticeUI", "iOSPracticeKit"]

let project = Project(
    name: "PracticeProject",
    options: .options(
        xcodeProjectName: "iOSPractice"
    ), targets: [
        .target(
            name: "iOSPractice",
            destinations: .iOS,
            product: .app,
            bundleId: "com.practice.ios",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["iOSPractice/Sources/**"],
            resources: ["iOSPractice/Resources/**"],
            dependencies: [
                .target(name: "iOSPracticeKit"),
                .target(name: "iOSPracticeUI")
            ]
        ),
        .target(
            name: "iOSPracticeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.practice.iosTests",
            infoPlist: .default,
            sources: ["iOSPractice/Tests/**"],
            resources: [],
            dependencies: [.target(name: "iOSPractice")]
        ),
        .target(
            name: "iOSPracticeKit",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.practice.iosKit",
            infoPlist: .default,
            sources: ["iOSPracticeKit/Sources/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "iOSPracticeKitTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.practice.iosKitTests",
            infoPlist: .default,
            sources: ["iOSPracticeKit/Tests/**"],
            resources: [],
            dependencies: [.target(name: "iOSPracticeKit")]
        ),
        .target(
            name: "iOSPracticeUI",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.practice.iosUI",
            infoPlist: .default,
            sources: ["iOSPracticeUI/Sources/**"],
            resources: [],
            dependencies: []
        ),
        .target(
            name: "iOSPracticeUITests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.practice.iosUITests",
            infoPlist: .default,
            sources: ["iOSPracticeUI/Tests/**"],
            resources: [],
            dependencies: [.target(name: "iOSPracticeUI")]
        ),
    ]
)
