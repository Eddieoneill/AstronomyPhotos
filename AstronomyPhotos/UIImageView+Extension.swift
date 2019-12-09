//
//  UIImageView+Extension.swift
//  AstronomyPhotos
//
//  Created by Edward O'Neill on 12/9/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // instance method
    func setImage(with urlString: String, complition: @escaping (Result<UIImage, AppError>) -> ()) {
        
        // configure UIActivityIndicatorView
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = center // center of the UIImageView
        addSubview(activityIndicator) // add the UIActivityIndicatorView to the UIImageView
        activityIndicator.startAnimating()
        
        NetworkHelper.shared.performDataTask(with: urlString) { [weak activityIndicator] (result) in
            
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            
            switch result {
            case .failure(let appError):
                complition(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    complition(.success(image))
                }
            }
        }
    }
    
}
