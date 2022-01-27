//
//  NewLocalizedTextView.swift
//  HapticMap
//
//  Created by Duran Timothée on 07.12.21.
//

import SwiftUI

/// Dispalys an interface to add a new description of an element on the map. Asks for a text input and a language.
struct NewLocalizedTextView<VM: NewLocalizedTextVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    @Environment(\.presentationMode) var presentation
    
    private func save() {
        vm.save { error in
            switch error {
            case .success(_):
                self.presentation.wrappedValue.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        print(Self._printChanges())
        return NavigationView {
            Form {
                if vm.availableLanguages.isEmpty {
                    Section {
                        VStack(alignment: .center, spacing: 20) {
                            Image(systemName: "exclamationmark.circle")
                                .font(.largeTitle)
                            Text("all_translations_already_exists")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                        }.padding(.vertical, 50)
                    }
                } else {
                    Section {
                        TextField("description", text: $vm.description)
                        Picker("language", selection: $vm.selectedLanguage) {
                            ForEach(vm.availableLanguages, id: \.self) {
                                Text(Locale.current.localizedString(forLanguageCode: $0) ?? $0)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                
            }
            .navigationTitle("new_translation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("actions.add") {
                        save()
                    }.disabled(vm.description == "")
                }
            }
            .navigationViewStyle(.stack)
            
        }
    }
}

// `.pickerStyle(.wheel)` causes a bug in previews.
/* struct NewLocalizedTextView_Previews: PreviewProvider {
 static var previews: some View {
 NewLocalizedTextView()
 }
 } */
