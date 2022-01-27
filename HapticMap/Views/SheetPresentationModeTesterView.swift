//
//  SheetPresentationModeTesterView.swift
//  HapticMap
//
//  Created by Duran Timothée on 25.10.21.
//

import SwiftUI

/// View for UITesting purposes. Presents the given view into a NavigationView through a sheet after pressing a button. This can be usefull to test that a given view includes the necessary toolbar controls when presented from a sheet.
struct SheetPresentationModeTesterView: View {
    
    var viewToPresent: AnyView = AnyView(Text("Hello World!"))
    
    @State var showingSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("SheetPresentationModeTesterView")
            Button {
                showingSheet.toggle()
            } label: {
                Text("open")
            }
        }
        .sheet(isPresented: $showingSheet) {
            NavigationView {
                viewToPresent
            }
        }
    }
}

#if !TESTING
struct PresentationModeTesterView_Previews: PreviewProvider {
    static var previews: some View {
        SheetPresentationModeTesterView()
    }
}
#endif
