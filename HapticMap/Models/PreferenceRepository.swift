//
//  FeedbackPreferences.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Combine
import Foundation

/**
 * Repository representing user's preferences for the types of feedback given while exploring a map.
 *
 * You can listen for changes by conforming to ``PreferenceRepositoryDelegate`` and assign it to this repository's delegate.
 */
class PreferenceRepository: ObservableObject {
    
    
    /// A shared instance of the repository.
    static let shared = PreferenceRepository()
    
    /**
     * A dictionnary mapping each feedback types with categories. A category appearing in the set means that the user want to receive the given feedback for this category. An absence of category means that no feedback should be given for this.
     *
     * All available feedbacks are listed in this dictionnary and it does not reflects user's preferences. Use `activeFeedbacks` to know if a the feedback is active or not.
     */
    private(set) lazy var activeCategories = loadFeedbackCategories()
    
    /**
     * The set of feedback types that the user wants to receive. An absence of feedback in this set indicates that the user requested not to receive this type of feedback.
     */
    private(set) lazy var activeFeedbacks = loadPrefences()
    
    /**
     * Pushlisher for any catogories preferences changes
     *
     * Note that the delegate only reports changes that occurred in the given instance and does not notify its observer if changes occurred in the underlying permanent storage.
     */
    let categoriesPublisher = PassthroughSubject<(Feedback, Category, Bool), Never>()
    
    /**
     * Pushlisher for any feedback preferences changes
     *
     * Note that the delegate only reports changes that occurred in the given instance and does not notify its observer if changes occurred in the underlying permanent storage.
     */
    let feedbacksPublisher = PassthroughSubject<(Feedback, Bool), Never>()
    
    /// The UserDefaults database used as underlaying storage.
    private let defaults: UserDefaults
    
    /// Default initializer
    /// - Parameter defaults: The UserDefaults database used as underlaying storage.
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    /// Sets a feedback as active or not.
    /// - Parameters:
    ///   - feedback: The feedback to set.
    ///   - active: True if the feedback should be given, false otherwise.
    func set(feedback: Feedback, active: Bool) {
        if active {
            activeFeedbacks.insert(feedback)
        } else {
            activeFeedbacks.remove(feedback)
        }
        if defaults.bool(forKey:feedback.rawValue) != active {
            defaults.setValue(active, forKey: feedback.rawValue)
            feedbacksPublisher.send((feedback, active))
        }
    }
    
    /// Sets a category as active or not for a given feedback type.
    /// - Parameters:
    ///   - category: The category to set.
    ///   - feedback: The feedback to set.
    ///   - active: True if the feedback should be given for this category, false otherwise.
    func set(category: Category, for feedback: Feedback, to active: Bool) {
        if active {
            var categories = activeCategories[feedback] ?? Set<Category>()
            categories.insert(category)
            activeCategories[feedback] = categories
        } else {
            activeCategories[feedback]?.remove(category)
        }
        
        let defaultsKey = feedback.rawValue + "_" + category.rawValue
        if defaults.bool(forKey:defaultsKey) != active {
            defaults.setValue(active, forKey: defaultsKey)
            categoriesPublisher.send((feedback, category, active))
        }
    }
    
    /// Loads all the currently active feedbacks.
    /// - Returns: The set of active feedbacks.
    private func loadPrefences() -> Set<Feedback> {
        return Set(Feedback.allCases.compactMap{defaults.bool(forKey:$0.rawValue) ? $0 : nil})
    }
    
    /// Loads all the currently active categories for a given feedback type.
    /// - Parameter feedback: The feedback.
    /// - Returns: The set of active categories for the given feedbacks.
    private func loadCategories(for feedback: Feedback) -> Set<Category> {
        let defaultsKeyPrefix = feedback.rawValue + "_"
        return Set(Category.allCases.compactMap{defaults.bool(forKey: defaultsKeyPrefix + $0.rawValue) ? $0 : nil})
    }
    
    /// Builds a dictionnary assocaiting each feeback type available with a set containing all the categories that should trigger a feedback for it.
    /// - Returns: The resulting dictionnary.
    private func loadFeedbackCategories() -> [Feedback:Set<Category>] {
        return Feedback.allCases.reduce(into: [Feedback:Set<Category>]()) { partialResult, feedback in
            partialResult[feedback] = loadCategories(for: feedback)
        }
    }
    
}
