//
//  FeedbacksView.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import SwiftUI

/// View allowing the user to see all the feedback types available on device as well as its status. Pressing a type opens `FeedbackOptionsView`.
struct FeedbacksView<VM: FeedbacksVMProtocol>: View {
    
    /// The _ViewModel_ of the MVVM pattern.
    @EnvironmentObject var vm: VM
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ForEach($vm.states) { preference in
                if preference.wrappedValue.feedback.isAvailable {
                    NavigationLink {
                        FeedbackOptionsView<FeedbackOptionsVM>()
                            .environmentObject(FeedbackOptionsVM(feedbackPreferences: vm.preferenceRepository, feedback: preference.wrappedValue.feedback))
                    } label: {
                        HStack {
                            Label(LocalizedStringKey(preference.wrappedValue.feedback.rawValue + "_feedback"), systemImage: preference.wrappedValue.feedback.iconName)
                            Spacer()
                            Text(preference.wrappedValue.isOn ? "on" : "off")
                                .foregroundColor(.gray)
                        }
                        .accessibilityElement(children: .combine)
                    }
                    .accessibilityIdentifier(preference.wrappedValue.feedback.rawValue)
                }
            }
            if vm.states.contains(where: {!$0.feedback.isAvailable}) {
                Section(LocalizedStringKey("unavailable_on_this_device")) {
                    ForEach($vm.states) { preference in
                        if !preference.wrappedValue.feedback.isAvailable {
                            HStack {
                                Label(LocalizedStringKey(preference.wrappedValue.feedback.rawValue + "_feedback"), systemImage: preference.wrappedValue.feedback.iconName)
                                Spacer()
                                Text("unavailable").foregroundColor(Color.gray)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel(preference.wrappedValue.feedback.rawValue)
                        }
                    }
                }
                
            }
        }
        .navigationTitle("settings")
    }
}

#if !TESTING
struct FeedbackSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedbacksView<FakeFeedbackTypesVM>()
                .environmentObject(FakeFeedbackTypesVM())
        }
    }
}
#endif
