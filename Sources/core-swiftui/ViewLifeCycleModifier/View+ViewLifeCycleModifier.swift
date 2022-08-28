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
    /// Assuming navigation from View1 to View2 the order of the lifecycle events is:
    ///
    /// - View2.onWillAppear()
    /// - View1.onWillDisappear()
    /// - View2.onAppear()
    /// - View1.onDisappear()
    ///
    /// - Parameter perform: das auszuführende Closure
    func onWillAppear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(ViewLifecycleModifier(onWillAppear: perform))
    }
    
    /// Runs the given closure prior to the removal of the view from the view hierarchy.
    ///
    /// The behavior deviates from onDisappear().
    ///
    /// - Example:
    /// Assuming navigation from View1 to View2 the order of the lifecycle events is:
    ///
    /// - View2.onWillAppear()
    /// - View1.onWillDisappear()
    /// - View2.onAppear()
    /// - View1.onDisappear()
    ///
    /// - Parameter perform: das auszuführende Closure
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(ViewLifecycleModifier(onWillDisappear: perform))
    }
}
