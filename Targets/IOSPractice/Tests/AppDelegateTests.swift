import Foundation
import XCTest

final class AppDelegateTests: XCTestCase {
    private(set) var didFinishLaunchingWithOptionsCalled = false
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) {
        didFinishLaunchingWithOptionsCalled = true
        XCTAssertTrue(didFinishLaunchingWithOptionsCalled)
    }
}
