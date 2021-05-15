//
//  ImageLoader.swift
//  HealthTips
//
//  Created by Arshad Khan on 5/27/21.
//
import UIKit
import RxSwift

protocol ImageLoadable {
    func loadImage(from urlString: String, completion: @escaping(UIImage) -> ())
    func loadImageObservable(from urlString: String) -> Observable<UIImage>
}

class ImageLoader: ImageLoadable {
    let imageCache = NSCache<NSString, UIImage>()
    func loadImage(from urlString: String, completion: @escaping(UIImage) -> ()) {
        guard  let url = URL(string: urlString) else { return completion(UIImage()) }
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            completion(imageFromCache)
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
                let imageToCache = UIImage(data: data!)
                if let image = imageToCache {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                }
        }.resume()
    }
    
    func loadImageObservable(from urlString: String) -> Observable<UIImage> {
        guard  let url = URL(string: urlString) else { return .error(ImageLoadingError.urlNotFound) }
        return Observable.create { observer  in
            let disposable = Disposables.create()
            if let imageFromCache = self.imageCache.object(forKey: urlString as NSString) {
                observer.onNext(imageFromCache)
                observer.onCompleted()
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    observer.onError(ImageLoadingError.unknown)
                }
                    let imageToCache = UIImage(data: data!)
                    if let image = imageToCache {
                        self.imageCache.setObject(image, forKey: urlString as NSString)
                        observer.onNext(image)
                        observer.onCompleted()
                    }
            }.resume()
            return disposable
        }
        
    }
}

enum ImageLoadingError: Error {
    case unknown
    case urlNotFound
}

