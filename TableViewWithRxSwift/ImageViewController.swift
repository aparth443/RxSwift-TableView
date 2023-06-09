//
//  ImageViewController.swift
//  TableViewWithRxSwift
//
//  Created by cumulations on 08/06/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ImageViewController: UIViewController {

    @IBOutlet weak var bigImage: UIImageView!
    
    var imageName: BehaviorRelay = BehaviorRelay<String>(value: "")
    let disposeBag2 = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageName
            .map ({
                name in
                UIImage.init(named: name)
            })
            .bind(to: bigImage
                .rx
                .image)
            .disposed(by: disposeBag2)
    }

}
