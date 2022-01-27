//
//  MapInfoView.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.11.21.
//

import SwiftUI

/// A view used to display informations about the map such as categories found in it.
struct MapInfoView<VM: MapInfoVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        return List {
            if !vm.officialCategories.isEmpty {
                Section(header: Text("official_categories")) {
                    ForEach(vm.officialCategories) { category in
                        Label {
                            Text(LocalizedStringKey(category.category.rawValue))
                        } icon: {
                            Image(systemName: "circle.fill")
                                .foregroundColor(category.wrappedColor)
                        }
                    }
                }
            }
            
            if !vm.customCategories.isEmpty {
                Section(header: Text("custom_categories")) {
                    ForEach(vm.customCategories) { category in
                        NavigationLink {
                            LocalizedTextsView<LocalizedTextsVM<Repository<LocalizedText>>>()
                                .environmentObject(LocalizedTextsVM(element: category, repository: Repository<LocalizedText>(managedObjectContext: PersistenceController.shared.container.viewContext)))
                        } label: {
                            Label {
                                Text(category.localizedDescription?.value ?? "")
                            } icon: {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(category.wrappedColor)
                            }
                        }
                    }
                }
            }
            
            if !vm.unassignedCategories.isEmpty {
                Section(header: Text("unassigned_colors")) {
                    ForEach(vm.unassignedCategories) { category in
                        NavigationLink {
                            LocalizedTextsView<LocalizedTextsVM<Repository<LocalizedText>>>()
                                .environmentObject(LocalizedTextsVM(element: category, repository: Repository<LocalizedText>(managedObjectContext: PersistenceController.shared.container.viewContext)))
                        } label: {
                            Label {
                                Text(LocalizedStringKey("#\(category.color ?? "")"))
                            } icon: {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(category.wrappedColor)
                            }
                        }
                    }
                }
            }
            
            
        }
        .navigationTitle(Text("categories"))
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("actions.done") {
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            vm.loadColors()
        }
    }
}

#if !TESTING
struct MapInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MapInfoView<FakeMapInfoVM>()
            .environmentObject(FakeMapInfoVM())
    }
}
#endif
