//
//  ItinerariesView.swift
//  HapticMap
//
//  Created by Duran Timothée on 04.10.21.
//

import SwiftUI
import UniformTypeIdentifiers

/// Displays an editable list of all the user's itineraries.
struct ItinerariesView<VM: ItinariesVMProtocol>: View {
    
    /// The ViewModel of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    @StateObject private var itineraryViewModel = ItineraryVM(repository: Repository<Map>(managedObjectContext: PersistenceController.shared.container.viewContext))
    
    var body: some View {
        ZStack {
            if vm.itineraries.isEmpty {
                MessageView(message: "no_itineraries", systemImage: "map.fill")
            } else {
                List {
                    ForEach(vm.itineraries, id: \.self) { itinerary in
                        NavigationLink {
                            ItineraryView<ItineraryVM<Repository<Map>>>()
                                .onAppear(perform: {
                                    itineraryViewModel.itinerary = itinerary
                                })
                                .environmentObject(itineraryViewModel)
                        } label: {
                            HStack {
                                if let name = itinerary.name {
                                    Text(name)
                                } else {
                                    Text("unnamed_itinerary").italic()
                                }
                                Spacer()
                            }
                        }
                        .contextMenu {
                            Button {
                                vm.editingItinerary = itinerary
                            } label: {
                                Label("actions.rename", systemImage: "pencil")
                            }
                            Button {
                                guard let url = itinerary.exportToURL() else { return }
                                self.vm.activityItem = ActivityItemWrapper(element: url)
                            } label: {
                                Label("actions.share", systemImage: "square.and.arrow.up")
                            }
                            Button(role: .destructive) {
                                vm.delete(itinaries: [itinerary])
                            } label: {
                                Label("actions.delete", systemImage: "trash")
                            }
                        }
                        .onDrop(of: [Map.typeIdentifier], delegate: MapDropDelegate(itinerary: itinerary))
                        .accessibilityAction(named: "actions.rename") {
                            vm.editingItinerary = itinerary
                        }
                    }
                    .onDelete(perform: deleteItinerary)
                }
            }
        }
        .navigationTitle(Text("itineraries"))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton().disabled(vm.itineraries.isEmpty)
                Button {
                    vm.showNewItinerarySheet.toggle()
                } label: {
                    Label("actions.add", systemImage: "plus")
                }
            }
        }
        .sheet(item: $vm.editingItinerary, onDismiss: {
            vm.editingItinerary = nil
        }) { itinerary in
            NavigationView {
                let vm = NewItineraryVM(repository: Repository<Itinerary>(managedObjectContext: PersistenceController.shared.container.viewContext), itinerary: itinerary)
                NewItineraryView<NewItineraryVM<Repository<Itinerary>>>()
                    .environmentObject(vm)
            }
        }
        .sheet(item: $vm.activityItem) { item in
            ActivityView(activityItems: [item.element])
        }
        .sheet(isPresented: $vm.showNewItinerarySheet) {
            NavigationView {
                let vm = NewItineraryVM(repository: Repository<Itinerary>(managedObjectContext: PersistenceController.shared.container.viewContext))
                NewItineraryView<NewItineraryVM<Repository<Itinerary>>>()
                    .environmentObject(vm)
            }
        }
        .alert(item: $vm.errorPacket) { errorPacket in
            Alert(title: Text("an_error_has_occured"), message: Text(errorPacket.error.localizedDescription))
        }
    }
    
    /// Deleted the itineraries present at the given indexes.
    /// - Parameter indexSet: The indexes of the itineraries to delete in `itineraries` list.
    func deleteItinerary(indexSet: IndexSet) {
        let _itineraries = indexSet.map({vm.itineraries[$0]})
        vm.delete(itinaries: _itineraries)
    }
    
}

#if !TESTING
struct ItinariesView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NavigationView {
            ItinerariesView<FakeItinerariesVM>()
        }
        .environmentObject(FakeItinerariesVM())
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13")
        
        NavigationView {
            ItinerariesView<FakeItinerariesVM>()
        }
        .environmentObject(FakeItinerariesVM())
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        .previewDisplayName("iPhone SE (2nd generation)")
        
        NavigationView {
            ItinerariesView<FakeItinerariesVM>()
        }
        .environmentObject(FakeItinerariesVM())
        .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        .previewDisplayName("iPad Air (4th generation)")
        
        NavigationView {
            ItinerariesView<FakeItinerariesVM>()
        }
        .environmentObject(FakeItinerariesVM(failedOnDelete: true))
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("Fail on delete")
        
    }
    
}
#endif
