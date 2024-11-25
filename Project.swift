import ProjectDescription

// MARK: Project
let project = Project(
    name: "PracticeProject",
    targets: Targets.allCases.map(\.target)
)

// MARK: Target
fileprivate enum Targets: String, CaseIterable {
    case app = "iOSPractice"
    case appTests = "iOSPracticeTests"
    case kit = "iOSPracticeKit"
    case kitTests = "iOSPracticeKitTests"
    case ui = "iOSPracticeUI"
    case uiTests = "iOSPracticeUITests"
    
    var target: Target {
        .target(
            name: name,
            destinations: .iOS,
            product: product,
            bundleId: bundleId,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )
    }
    
    private var name: String { rawValue }
    
    private var sources: SourceFilesList {
        switch self {
        case .app, .kit, .ui: ["\(name)/Sources/**"]
        case .appTests: ["\(Targets.app.name)/Tests/**"]
        case .kitTests: ["\(Targets.kit.name)/Tests/**"]
        case .uiTests: ["\(Targets.ui.name)/Tests/**"]
        }
    }
    
    private var resources: ResourceFileElements {
        switch self {
        case .app: ["\(name)/Resources/**"]
        case .kit: []
        case .ui: []
        case .appTests, .kitTests, .uiTests: []
        }
    }
    
    private var bundleId: String {
        "com.practice.\(name)"
    }
    
    private var product: Product {
        switch self {
        case .app: .app
        case .kit, .ui: .staticFramework
        case .appTests, .kitTests, .uiTests: .unitTests
        }
    }
    
    private var dependencies: [TargetDependency] {
        switch self {
        case .app: [
            .target(name: Targets.kit.name),
            .target(name: Targets.ui.name)
        ]
        case .appTests: [.target(name: Targets.app.name)]
        case .kit: []
        case .kitTests: [.target(name: Targets.kit.name)]
        case .ui: []
        case .uiTests: [.target(name: Targets.ui.name)]
        }
    }
    
    private var infoPlist: InfoPlist {
        switch self {
        case .app: .extendingDefault(with: ["UILaunchStoryboardName": "LaunchScreen.storyboard"])
        case .kit: .default
        case .ui: .default
        case .appTests, .kitTests, .uiTests: .default
        }
    }
}
