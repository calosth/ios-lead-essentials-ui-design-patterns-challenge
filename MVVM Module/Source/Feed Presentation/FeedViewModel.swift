//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

final class FeedViewModel {
	typealias Observer<T> = (T) -> Void
	
	private let feedLoader: FeedLoader
	
	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}
	
	var title: String {
		Localized.Feed.title
	}
	
	var errorConnectionrMessage: String {
		Localized.Feed.errorMessage
	}
	
	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
	var onErrorStatus: Observer<Bool>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
		onErrorStatus?(false)
		feedLoader.load { [weak self] result in
			switch result {
			case .success(let feed):
				self?.onFeedLoad?(feed)
			case .failure(_):
				self?.onErrorStatus?(true)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}

