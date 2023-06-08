//
//  ImageViewController.swift
//  TableViewWithRxSwift
//
//  Created by cumulations on 08/06/23.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var bigImage: UIImageView!
    
    var imageName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        bigImage.image = UIImage.init(named: imageName)
    }

}
