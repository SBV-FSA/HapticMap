//
//  NewItineraryView.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.10.21.
//

import SwiftUI

/// View containing the necessary interface for new itinerary creation.
struct NewItineraryView<VM: NewItineraryVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("name", text: $vm.itineraryName)
                .customTextField()
            Spacer()
        }
        .padding()
        .navigationTitle(vm.isEditing ? "actions.rename" : "new_itinerary")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("cancel")
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    vm.save()
                } label: {
                    Text("OK")
                }.disabled(vm.itineraryName == "")
            }
        }
        .alert(item: $vm.errorPacket) { errorPacket in
            Alert(title: Text("an_error_has_occured"), message: Text(errorPacket.error.localizedDescription))
        }
        .onReceive(vm.shouldDismissViewPublisher) { shouldDismiss in
            if shouldDismiss { dismiss() }
        }
        
    }
}

#if !TESTING
struct NewItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewItineraryView<FakeNewItineraryVM>()
        }
        .environmentObject(FakeNewItineraryVM())
    }
}
#endif
