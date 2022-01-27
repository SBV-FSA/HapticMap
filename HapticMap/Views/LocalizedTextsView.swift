//
//  LocalizedTextsView.swift
//  HapticMap
//
//  Created by Duran Timothée on 07.12.21.
//

import SwiftUI

/// A list of all the translations associated to the given element.
struct LocalizedTextsView<VM: LocalizedTextsVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    var body: some View {
        List {
            Section {
                Label {
                    Text(vm.hexString)
                } icon: {
                    Image(systemName: "circle.fill")
                        .foregroundColor(vm.element.wrappedColor)
                }
            }
            Section(header: Text("translations")) {
                if vm.translations.isEmpty {
                    HStack {
                        Spacer()
                        Text("no_description")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                } else {
                    ForEach(vm.translations, id: \.self) { translation in
                        HStack {
                            Text(translation.wrappedReadableLanguage.capitalized)
                                .bold()
                            Spacer()
                            Text(translation.wrappedValue)
                        }
                    }
                    .onDelete(perform: vm.delete)
                }
            }
        }
        .navigationTitle("translations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    vm.showNewLocalizedText.toggle()
                } label: {
                    Label("actions.add", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $vm.showNewLocalizedText) {
            NewLocalizedTextView<NewLocalizedTextVM<Repository<LocalizedText>>>()
                .environmentObject(NewLocalizedTextVM(category: vm.element, repository: Repository<LocalizedText>(managedObjectContext: PersistenceController.shared.container.viewContext)))
        }
    }
}

#if !TESTING
struct LocalizedTextsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocalizedTextsView<FakeLocalizedTextsVM>()
                .environmentObject(FakeLocalizedTextsVM())
        }
        NavigationView {
            LocalizedTextsView<FakeLocalizedTextsVM>()
                .environmentObject(FakeLocalizedTextsVM(isEmtpy: true))
        }
        
    }
}
#endif
