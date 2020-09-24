//
//  ImageViewModel.swift
//  CodeChallenge
//
//  Created by Rohan Aurora on 9/15/20.
//  Copyright © 2020 Hootsuite. All rights reserved.
//

import UIKit

class ImagesViewModel {
    var api: InterviewAPI?
    var datsource: ImageSet?
    
    var imageTags: String?
    var taggedImages: [TaggedImage]?
    
    public func loadData(completion: @escaping () -> Void) {
        if api == nil {
            api = InterviewAPI()
        }
        api?.getImageSet(completion: {[weak self] result in
            switch result {
            case .success(let imageSet):
                self?.datsource = imageSet
                self?.processImages()
                completion()
            case .failure( _): break
            }
        })
    }
    
    private func processImages() {
        self.updateTag()
        if let tag = imageTags {
            taggedImages = datsource?.sources.filter{ $0.tags.contains(tag.uppercased())}
        }
    }
    
    private func updateTag() {
        let listTags = datsource?.tags.filter { $0 != imageTags }
        let newTag = listTags?.randomElement() ?? ""
        imageTags = newTag
    }
}
