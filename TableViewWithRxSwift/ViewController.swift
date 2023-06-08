//
//  ViewController.swift
//  TableViewWithRxSwift
//
//  Created by cumulations on 07/06/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    let sports = Observable.just([
    Sports(name: "Badminton", image: "badminton"),
    Sports(name: "Cricket", image: "cricket"),
    Sports(name: "Rugby", image: "rugby"),
    Sports(name: "Hockey", image: "hockey"),
    Sports(name: "Football", image: "football")
    ])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sports"
        tableView.register(UINib(nibName: "SportsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        sports.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: SportsTableViewCell.self)){
            (tv, item, cell) in
            cell.sportsName.text = item.name
            cell.imageName.image = UIImage(named: item.image)
        }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Sports.self)
            .subscribe(onNext: { sportsObject in
                let sportsVC = self.storyboard?.instantiateViewController(identifier: "SportsVC") as! ImageViewController
                sportsVC.imageName = sportsObject.image
                self.navigationController?.pushViewController(sportsVC, animated: true)
            }).disposed(by: disposeBag)
        
    }
    

    
}

