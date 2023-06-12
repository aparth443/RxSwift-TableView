//
//  ViewController.swift
//  TableViewWithRxSwift
//
//  Created by cumulations on 07/06/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class ViewController: UIViewController,UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let sportsItemsSectioned = BehaviorRelay.init(value: [
    SectionModel(header: "Ball Games", items: [
        Sports(name: "Cricket", image: "cricket"),
        Sports(name: "Hockey", image: "hockey"),
        Sports(name: "Football", image: "football")
    ]),
    SectionModel(header: "Without Ball Games", items: [
        Sports(name: "Badminton", image: "badminton"),
        Sports(name: "Rugby", image: "rugby"),
    ])
    ])
    
    let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: {
        datasource, tv, indexpath, item in
        let cell: SportsTableViewCell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexpath) as! SportsTableViewCell
        cell.sportsName.text = item.name
        cell.imageName.image = UIImage.init(named: item.image)
        
        return cell
    },
    titleForHeaderInSection: {
        datasource, index in
        return datasource.sectionModels[index].header
    }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sports"
        
        tableView.register(UINib(nibName: "SportsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let searchQuery = searchBar.rx.text.orEmpty.throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map ({ query in
                self.sportsItemsSectioned.value.map({
                    sectionModel in
                    SectionModel(header: sectionModel.header, items: sectionModel.items.filter({
                        sport in
                        query.isEmpty || sport.name.lowercased().contains(query.lowercased())
                    }))
                })
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)   
        
        
        tableView.rx.modelSelected(Sports.self)
            .subscribe(onNext: { sportsObject in
                let sportsVC = self.storyboard?.instantiateViewController(identifier: "SportsVC") as! ImageViewController
                sportsVC.imageName.accept(sportsObject.image)
                self.navigationController?.pushViewController(sportsVC, animated: true)
            }).disposed(by: disposeBag)
        
    }
    

    
}

