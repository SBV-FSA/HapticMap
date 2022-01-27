//
//  FeedbackOptionsView.swift
//  HapticMap
//
//  Created by Duran Timothée on 02.11.21.
//

import SwiftUI

/// View allowing users to fine tunes the categories that need to be sent to the user.
struct FeedbackOptionsView<VM: FeedbackOptionsVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    var body: some View {
        List {
            Section() {
                Toggle(isOn: $vm.feedbackIsOn.animation(), label: {
                    Text("state")
                })
                    .accessibilityLabel("state")
            }
            if vm.feedbackIsOn {
                Section(LocalizedStringKey("described_elements")) {
                    ForEach($vm.options, id: \.id) { categoryWrapper in
                        Toggle(isOn: categoryWrapper.isOn) {
                            Label {
                                Text(LocalizedStringKey(categoryWrapper.wrappedValue.category.rawValue))
                            } icon: {
                                if let color = categoryWrapper.wrappedValue.category.color {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(Color(color))
                                } else {
                                    Image(systemName: "circle.dotted")
                                        .foregroundColor(Color(UIColor.systemGray4))
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(LocalizedStringKey(vm.feedback.rawValue + "_feedback"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if !TESTING
struct FeedbackSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedbackOptionsView<FakeFeedbackOptionsVM>()
        }
        .environmentObject(FakeFeedbackOptionsVM())
    }
}
#endif
