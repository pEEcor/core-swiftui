//
//  File.swift
//
//
//  Created by Paavo Becker on 27.08.22.
//

import SwiftUI

public extension View {
    /// Runs the given closure prior to the insertion of the view into the view hierarchy.
    ///
    /// - View2.onAppear()
    /// - View2.onWillAppear()
    /// - View2.onDidAppear()
    ///
    /// - Parameter perform: das auszuführende Closure
    func onWillAppear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(ViewLifecycleModifier(onWillAppear: perform))
    }
    
    /// Runs the given closure prior to the removal of the view from the view hierarchy.
    ///
    /// - Example:
    /// Assuming backward navigation from View2 to View1, the order of the lifecycle events is:
    ///
    /// - View2.onWillDisappear()
    /// - View2.onDidDisappear()
    /// - View2.onDisappear()
    ///
    /// - Parameter perform: das auszuführende Closure
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(ViewLifecycleModifier(onWillDisappear: perform))
    }
    
    /// Runs the given closure after to the insertion of the view from the view hierarchy.
    ///
    /// - Example:
    /// Assuming navigation from View1 to View2, the order of the lifecycle events is:
    ///
    /// - View2.onAppear()
    /// - View2.onWillAppear()
    /// - View2.onDidAppear()
    ///
    /// - Parameter perform: das auszuführende Closure
    func onDidAppear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(ViewLifecycleModifier(onDidAppear: perform))
    }
    
    /// Runs the given closure after to the removal of the view from the view hierarchy.
    ///
    /// - Example:
    /// Assuming backward navigation from View2 to View1, the order of the lifecycle events is:
    ///
    /// - View2.onWillDisappear()
    /// - View2.onDidDisappear()
    /// - View2.onDisappear()
    ///
    /// - Parameter perform: das auszuführende Closure
    func onDidDisappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(ViewLifecycleModifier(onDidDisappear: perform))
    }
}

