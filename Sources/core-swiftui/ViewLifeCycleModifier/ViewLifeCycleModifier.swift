//
//  File.swift
//
//
//  Created by Paavo Becker on 27.08.22.
//

import SwiftUI

/// View modifier that allows to react to the view's insertion into the view hierarchy as well as
/// its removal from the hierarchy.
struct ViewLifecycleModifier: ViewModifier {
    typealias Action = () -> Void
    
    let onWillAppear: Action?
    let onWillDisappear: Action?
    let onDidAppear: Action?
    let onDidDisappear: Action?
    
    init(
        onWillAppear: Action? = nil,
        onWillDisappear: Action? = nil,
        onDidAppear: Action? = nil,
        onDidDisappear: Action? = nil
    ) {
        self.onWillAppear = onWillAppear
        self.onWillDisappear = onWillDisappear
        self.onDidAppear = onDidAppear
        self.onDidDisappear = onDidDisappear
    }

    func body(content: Content) -> some View {
        content
            .background(
                ViewLifeCycleHelper(
                    onWillAppear: onWillAppear,
                    onWillDisappear: onWillDisappear,
                    onDidAppear: onDidAppear,
                    onDidDisappear: onDidDisappear
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
    let onDidAppear: (() -> Void)?
    let onDidDisappear: (() -> Void)?

    init(
        onWillAppear: (() -> Void)? = nil,
        onWillDisappear: (() -> Void)? = nil,
        onDidAppear: (() -> Void)? = nil,
        onDidDisappear: (() -> Void)? = nil
    ) {
        self.onWillAppear = onWillAppear
        self.onWillDisappear = onWillDisappear
        self.onDidAppear = onDidAppear
        self.onDidDisappear = onDidDisappear
    }

    func makeCoordinator() -> ViewLifeCycleHelper.Coordinator {
        Coordinator(
            onWillAppear: onWillAppear,
            onWillDisappear: onWillDisappear,
            onDidAppear: onDidAppear,
            onDidDisappear: onDidDisappear
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
        let onWillAppear: (() -> Void)?
        let onWillDisappear: (() -> Void)?
        let onDidAppear: (() -> Void)?
        let onDidDisappear: (() -> Void)?

        init(
            onWillAppear: (() -> Void)?,
            onWillDisappear: (() -> Void)?,
            onDidAppear: (() -> Void)?,
            onDidDisappear: (() -> Void)?
        ) {
            self.onWillDisappear = onWillDisappear
            self.onWillAppear = onWillAppear
            self.onDidAppear = onDidAppear
            self.onDidDisappear = onDidDisappear
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
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onDidAppear?()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDidDisappear?()
        }
    }
}
