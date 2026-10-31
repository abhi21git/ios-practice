import XCTest
import UIKit
@testable import iOSPracticeUI

final class ConstraintTests: XCTestCase {
    private let parent = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    private let child = UIView()

    private func layout(_ constraints: Constraints) -> CGRect {
        constraints.activate()
        parent.layoutIfNeeded()
        return child.frame
    }

    func test_leadingTop_insetFromParent() {
        let frame = layout(parent.addSubview(child) {
            .leading(20)
            .top(10)
            .width(50)
            .height(40)
        })
        XCTAssertEqual(frame, CGRect(x: 20, y: 10, width: 50, height: 40))
    }

    func test_trailingBottom_insetFromParent() {
        let frame = layout(parent.addSubview(child) {
            .trailing(20)
            .bottom(10)
            .width(50)
            .height(40)
        })
        XCTAssertEqual(frame, CGRect(x: 230, y: 250, width: 50, height: 40))
    }

    func test_centerOffsets_followUIKitDirection() {
        let frame = layout(parent.addSubview(child) {
            .centerX(20)
            .centerY(-10)
            .width(50)
            .height(40)
        })
        XCTAssertEqual(frame.midX, 170)
        XCTAssertEqual(frame.midY, 140)
    }

    func test_fill_insetsAllEdges() {
        let frame = layout(parent.addSubview(child) { .fill(10) })
        XCTAssertEqual(frame, CGRect(x: 10, y: 10, width: 280, height: 280))
    }

    func test_widthMultiplier_andAspectRatio() {
        let frame = layout(parent.addSubview(child) {
            .leading
            .top
            .width(to: parent.widthAnchor, multiplier: 0.5)
            .aspectRatio(2)
        })
        XCTAssertEqual(frame.size, CGSize(width: 150, height: 75))
    }

    func test_relation_appliesToSpacing() {
        let frame = layout(parent.addSubview(child) {
            .leading
            .top
            .trailing(20, relation: .greaterThanOrEqual)
            .width(500, priority: .defaultHigh)
            .height(10)
        })
        XCTAssertEqual(frame.width, 280)
    }

    func test_safeArea_perConstraintOverridesBlock() {
        let constraints = parent.addSubview(child, considerSafeArea: false) {
            .top(safeArea: true)
            .leading
        }
        XCTAssertTrue(constraints[0].secondItem === parent.safeAreaLayoutGuide)
        XCTAssertTrue(constraints[1].secondItem === parent)
    }
}
