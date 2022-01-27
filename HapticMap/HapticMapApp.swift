//
//  HapticMapApp.swift
//  HapticMap
//
//  Created by Duran Timothée on 04.10.21.
//

import Combine
import SwiftUI

@main
struct HapticMapApp: App {
    
    let persistenceController: PersistenceController
    let contentView: AnyView
    private var cancellables = [AnyCancellable]()
    
    init() {
        
        #if TESTING
        persistenceController = PersistenceController(inMemory: true)
        
        // Scenarios
        let scenarioName = ProcessInfo.processInfo.environment["UI_TEST_SCENARIO"]
        switch scenarioName {
        case "scenarioFeedbackCategoriesView":
            let repo = PreferenceRepository(defaults: .makeClearedInstance())
            Feedback.allCases.forEach{ repo.set(feedback: $0, active: false)}
            contentView = AnyView(FeedbacksView<FeedbacksVM>()
                                    .environmentObject(FeedbacksVM(feedbackPreferences: repo)))
        case "scenarioFeedbackCategoriesViewAllOn":
            let repo = PreferenceRepository(defaults: .makeClearedInstance())
            Feedback.allCases.forEach{ repo.set(feedback: $0, active: true)}
            contentView = AnyView(FeedbacksView<FeedbacksVM>()
                                    .environmentObject(FeedbacksVM(feedbackPreferences: repo)))
        case "scenarioFeedbackSettingsView":
            contentView = AnyView(FeedbackOptionsView<FakeFeedbackOptionsVM>()
                                    .environmentObject(FakeFeedbackOptionsVM()))
        case "scenarioItinerariesView":
            contentView = AnyView(ItinerariesView<FakeItinerariesVM>()
                                    .environmentObject(FakeItinerariesVM()))
        case "scenarioItinerariesViewNoItineraries":
            contentView = AnyView(ItinerariesView<FakeItinerariesVM>()
                                    .environmentObject(FakeItinerariesVM(seed:false)))
        case "scenarioItinerariesViewWithRepositoryError":
            contentView = AnyView(ItinerariesView<FakeItinerariesVM>()
                                    .environmentObject(FakeItinerariesVM(failedOnRetreive: true)))
        case "scenarioItinerariesViewWithDeletionError":
            contentView = AnyView(ItinerariesView<FakeItinerariesVM>()
                                    .environmentObject(FakeItinerariesVM(failedOnDelete: true)))
        case "scenarioItineraryView":
            contentView = AnyView(ItineraryView<FakeItineraryVM>()
                                    .environmentObject(FakeItineraryVM()))
        case "scenarioMapView":
            contentView = AnyView(MapView<MockMapVM>()
                                    .environmentObject(MockMapVM()))
        case "scenarioNewMapView":
            contentView = AnyView(NewMapView<FakeNewMapVM>()
                                    .environmentObject(FakeNewMapVM()))
        case "scenarioNewMapViewErrorOnSave":
            let vm = FakeNewMapVM()
            vm.errorOnSave = NewMapVMError.savingFailed
            vm.fileName = "test.png"
            vm.mapName = "Test"
            contentView = AnyView(NewMapView<FakeNewMapVM>()
                                    .environmentObject(vm))
        case "scenarioNewMapViewNoFileWithName":
            let vm = FakeNewMapVM()
            vm.mapName = "Test"
            contentView = AnyView(NewMapView<FakeNewMapVM>()
                                    .environmentObject(vm))
        case "scenarioNewMapViewNoNameWithFile":
            let vm = FakeNewMapVM()
            vm.fileName = "test.png"
            contentView = AnyView(NewMapView<FakeNewMapVM>()
                                    .environmentObject(vm))
        case "scenarioNewMapViewPresentationMode":
            let vm = FakeNewMapVM()
            vm.fileName = "test.png"
            vm.mapName = "Test"
            let calledView = AnyView(NewMapView<FakeNewMapVM>()
                                        .environmentObject(vm))
            var callingView = SheetPresentationModeTesterView()
            callingView.viewToPresent = calledView
            contentView = AnyView(callingView)
            
            
        default:
            let itineraryRepository = Repository<Itinerary>(managedObjectContext: persistenceController.container.viewContext)
            contentView = AnyView(ItinerariesView<ItinariesVM<Repository<Itinerary>>>()
                                    .environmentObject(ItinariesVM(model: itineraryRepository)))
        }
        #else
        persistenceController = PersistenceController.shared
        let itineraryRepository = Repository<Itinerary>(managedObjectContext: persistenceController.container.viewContext)
        
        
        contentView = AnyView(TabView(content: {
            NavigationView {ItinerariesView<ItinariesVM<Repository<Itinerary>>>()
                    .environmentObject(ItinariesVM(model: itineraryRepository))
            }.tabItem {
                Label("itineraries", systemImage: "map.fill")
            }
            
            NavigationView {FeedbacksView<FeedbacksVM>()
                    .environmentObject(FeedbacksVM())
            }.tabItem {
                Label("settings", systemImage: "gearshape.fill")
            }
        }))
        #endif
        
    }
    
    var body: some Scene {
        
        WindowGroup {
            contentView
                .onOpenURL { url in
                    ImportManager.importItinerary(from: url, persistenceController: persistenceController)
                }
        }
        
    }
}

class ImportManager {
    
    static func importItinerary(from url: URL, persistenceController: PersistenceController) {
        do {
            let data = try Data(contentsOf: url)
            let itineraryDto = try JSONDecoder().decode(ItineraryDto.self, from: data)
            let context = persistenceController.container.viewContext
            let _ = Itinerary(context: context, dto: itineraryDto)
            try context.save()
        } catch {
            
        }
        
        try? FileManager.default.removeItem(at: url)
    }
    
}
