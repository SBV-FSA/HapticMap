//
//  MapView.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import SwiftUI

/// A view that displays HapticMaps and controls.
struct MapView<VM: MapVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    var body: some View {
        MapContainer(mapImage: vm.map.wrappedImage)
            .onStarted { color in
                vm.touchBegan(with: color)
            }
            .onChanged { color in
                vm.touchMoved(with: color)
            }
            .onEnded { color in
                vm.touchEnded(with: color)
            }
            .accessibilityAddTraits([.allowsDirectInteraction])
            .navigationTitle(Text("map"))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        vm.showInfos.toggle()
                    } label: {
                        Label("actions.add", systemImage: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $vm.showInfos) {
                NavigationView {
                    MapInfoView<MapInfoVM>()
                        .environmentObject(MapInfoVM(map: vm.map))
                }
            }
            .onAppear {
                vm.refreshCategories()
            }
    }
    
}

#if !TESTING
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapView<MockMapVM>()
        }.environmentObject(MockMapVM())
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")
    }
}
#endif
