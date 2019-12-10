//
//  PlanetCell.swift
//  AstronomyPhotos
//
//  Created by Edward O'Neill on 12/9/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {

    @IBOutlet weak var planetImageView: UIImageView!
    
    private var urlString = ""
    
    func configureCell(with urlString: String) {
        
        // set the cell's urlString
        
        self.urlString = urlString
        planetImageView.setImage(with: urlString) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.planetImageView.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                
                if self?.urlString == urlString {
                    DispatchQueue.main.async {
                        self?.planetImageView.image = image
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //empty out the image view
        planetImageView.image = nil
    }

}


