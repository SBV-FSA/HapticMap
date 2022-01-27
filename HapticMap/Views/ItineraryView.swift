//
//  ItineraryView.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//

import SwiftUI

/// Displayes an editable list of maps for a given itinerary.
struct ItineraryView<VM: ItineraryVMProtocol>: View {

    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    var body: some View {
        ZStack {
            if vm.maps.isEmpty {
                MessageView(message: "no_maps", systemImage: "map.fill")
            } else {
                List {
                    ForEach(vm.maps, id: \.self) { map in
                        NavigationLink(destination: MapView<MapVM>().environmentObject(MapVM(map: map))) {
                            HStack {
                                if let name = map.name {
                                    Text(name)
                                } else {
                                    Text("unnamed_map").italic()
                                }
                            }
                        }
                        .onDrag{
                            return NSItemProvider(object: map)
                        }
                        .accessibilityAction(named: "actions.edit") {
                            vm.selectedMap = map
                        }
                        .contextMenu {
                            Button {
                                vm.selectedMap = map
                            } label: {
                                Label("actions.edit", systemImage: "pencil")
                            }
                        }
                    }
                    .onMove(perform: vm.move)
                    .onDelete(perform: vm.delete)
                }
            }
        }
        .navigationTitle(Text("maps"))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton().disabled(vm.maps.isEmpty)
                Button {
                    vm.showNewMapSheet.toggle()
                } label: {
                    Label("actions.add", systemImage: "plus")
                }
            }
        }
        .sheet(item: $vm.selectedMap, onDismiss: {
            vm.selectedMap = nil
            vm.reloadMaps()
        }) { map in
            NavigationView {
                let mapRepo = Repository<Map>(managedObjectContext: PersistenceController.shared.container.viewContext)
                let elementsRepo = Repository<Element>(managedObjectContext: PersistenceController.shared.container.viewContext)
                let vm = NewMapVM(repository: mapRepo, elementRepository: elementsRepo, itinerary: vm.itinerary, map: map)
                NewMapView<NewMapVM<Repository<Map>, Repository<Element>>>().environmentObject(vm)
            }
        }
        .sheet(isPresented: $vm.showNewMapSheet, onDismiss: {
            vm.reloadMaps()
        }, content: {
            NavigationView {
                let mapRepo = Repository<Map>(managedObjectContext: PersistenceController.shared.container.viewContext)
                let elementsRepo = Repository<Element>(managedObjectContext: PersistenceController.shared.container.viewContext)
                NewMapView<NewMapVM<Repository<Map>, Repository<Element>>>().environmentObject(NewMapVM(repository: mapRepo, elementRepository: elementsRepo, itinerary: vm.itinerary, map: nil))
            }
        })
        .alert(item: $vm.errorPacket) { errorPacket in
            Alert(title: Text("an_error_has_occured"), message: Text(errorPacket.error.localizedDescription))
        }
    }
}

#if !TESTING
struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItineraryView<FakeItineraryVM>()
                .environmentObject(FakeItineraryVM())
                .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
                .previewDisplayName("iPhone 13")
        }
        NavigationView {
            ItineraryView<FakeItineraryVM>().environmentObject(FakeItineraryVM())
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE (2nd generation)")
        }
    }
}
#endif
