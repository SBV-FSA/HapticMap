//
//  NewMapView.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import SwiftUI

/// View containing the necessary interface for new map creation.
struct NewMapView<VM: NewMapVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    @Environment(\.dismiss) private var dismiss
    
    private func save() {
        vm.save { error in
            switch error {
            case .success(_):
                dismiss()
            case .failure(let error):
                vm.errorPacket = ErrorPacket(error: error)
            }
        }
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else {
                VStack(alignment: .center) {
                    TextField("name", text: $vm.mapName)
                        .customTextField()
                    Button {
                        vm.isChoosingImportMethod.toggle()
                    } label: {
                        if let fileName = vm.fileName {
                            Label(fileName, systemImage: "checkmark.circle.fill").frame(maxWidth: .infinity)
                        } else {
                            Text("import_file").frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    Text("import_informations")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(Text("new_map"))
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
                    save()
                } label: {
                    Text("OK")
                }.disabled(vm.mapName == "" || vm.fileName == nil)
            }
        }
        .confirmationDialog("choose_a_location", isPresented: $vm.isChoosingImportMethod, titleVisibility: .visible, actions: {
            Button {
                vm.isImportingPhoto.toggle()
            } label: {
                Label("photo_library", systemImage: "photo")
            }
            Button {
                vm.isImportingFile.toggle()
            } label: {
                Label("files", systemImage: "folder")
            }
        })
        
        .sheet(isPresented: $vm.isImportingPhoto, onDismiss: nil) {
            ImagePicker(image: self.$vm.inputImage)
        }
        .fileImporter(isPresented: $vm.isImportingFile, allowedContentTypes: [.image]) { result in
            vm.loadFile(fileImporterResult: result)
        }
        .alert(item: $vm.errorPacket) { errorPacket in
            Alert(title: Text("an_error_has_occured"), message: Text(errorPacket.error.localizedDescription))
        }
    }
}

#if !TESTING
struct NewMapView_Previews: PreviewProvider {
    
    static var viewModelWithImportedFile: FakeNewMapVM {
        let vm = FakeNewMapVM()
        vm.mapName = "Train Station"
        vm.fileName = "train_station.png"
        return vm
    }
    
    static var previews: some View {
        
        NavigationView {
            NewMapView<FakeNewMapVM>()
                .environmentObject(FakeNewMapVM())
                
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13")
        
        NavigationView {
            NewMapView<FakeNewMapVM>()
                .environmentObject(FakeNewMapVM())
                
        }
        .environment(\.locale, .init(identifier: "fr"))
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13 - FR")
        
        NavigationView {
            NewMapView<FakeNewMapVM>()
                .environmentObject(viewModelWithImportedFile)
                
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13 - Filled")
        
        NavigationView {
            NewMapView<FakeNewMapVM>()
                .environmentObject(FakeNewMapVM())
        }
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        .environment(\._colorSchemeContrast, .increased)
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        .previewDisplayName("iPhone 13 - Accessible")
    }
}
#endif
