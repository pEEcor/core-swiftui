//
//  File.swift
//
//
//  Created by Paavo Becker on 27.08.22.
//

import SwiftUI

/// View modifier that allows to react to the view's insertion into the view hierarchy as well as
/// its removal from the hierarchy.
///
/// The events are similar to onWillAppear and onWillDisappear from UIKit
struct ViewLifecycleModifier: ViewModifier {
    let onWillAppear: (() -> Void)?
    let onWillDisappear: (() -> Void)?
    
    init(
        onWillAppear: (() -> Void)? = nil,
        onWillDisappear: (() -> Void)? = nil
    ) {
        self.onWillAppear = onWillAppear
        self.onWillDisappear = onWillDisappear
    }

    func body(content: Content) -> some View {
        content
            .background(
                ViewLifeCycleHelper(
                    onWillAppear: onWillAppear,
                    onWillDisappear: onWillDisappear
                )
            )
    }
}

/// Helper to wrap UIKit lifecycle events
///
/// See `View.onWillDisappear` or `View.onWillAppear`
///
/// Credits to: https://stackoverflow.com/questions/59745663/is-there-a-swiftui-equivalent-for-viewwilldisappear-or-detect-when-a-view-is
private struct ViewLifeCycleHelper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    let onWillDisappear: (() -> Void)?
    let onWillAppear: (() -> Void)?

    init(
        onWillAppear: (() -> Void)? = nil,
        onWillDisappear: (() -> Void)? = nil
    ) {
        self.onWillAppear = onWillAppear
        self.onWillDisappear = onWillDisappear
    }

    func makeCoordinator() -> ViewLifeCycleHelper.Coordinator {
        Coordinator(
            onWillAppear: onWillAppear,
            onWillDisappear: onWillDisappear
        )
    }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ViewLifeCycleHelper>
    ) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(
        _: UIViewController,
        context _: UIViewControllerRepresentableContext<ViewLifeCycleHelper>
    ) {}

    class Coordinator: UIViewController {
        let onWillDisappear: (() -> Void)?
        let onWillAppear: (() -> Void)?

        init(
            onWillAppear: (() -> Void)?,
            onWillDisappear: (() -> Void)?
        ) {
            self.onWillDisappear = onWillDisappear
            self.onWillAppear = onWillAppear
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear?()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear?()
        }
    }
}
