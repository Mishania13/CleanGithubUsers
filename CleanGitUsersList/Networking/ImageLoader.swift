//
//  ImageLoader.swift
//  CleanGitUsersList
//
//  Created by Михаил Звягинцев on 22.10.2021.
//

import Foundation

class ImageDataLoader {

    static let shared = ImageDataLoader()

    private let serialQueueForImagesData = DispatchQueue(label: "imagesData.queue", attributes: .concurrent)

    var loadedImages = [URL:Data]()
    private init() {}
    //TODO: Chek is session wiht this url is running
    func loadImage(url: URL, _ complition: @escaping(Result<Data, Error>) -> Void) {
        serialQueueForImagesData.sync {
            if let imageData = self.loadedImages[url] {
                complition(.success(imageData))
            }

            let task = URLSession.shared.dataTask(with: url) {data, _, error in
                if let data = data {
                    self.serialQueueForImagesData.sync(flags: .barrier) {
                        self.loadedImages[url] = data
                    }
                    complition(.success(data))
                    return
                }
                if let error = error {
                    complition(.failure(error))
                }
            }
            task.resume()
        }
    }
}
