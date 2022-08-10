//
//  MainDetailViewController.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/07.
//

import UIKit

class MainDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.register(UINib(nibName: "MainDetailPosterTableViewCell", bundle: nil), forCellReuseIdentifier: "MainDetailPosterTableViewCell")
        tableView.register(UINib(nibName: "MainDetailOverViewTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "MainDetailOverViewTableViewCell")
        tableView.register(UINib(nibName: "MainDetailCastTableViewCell", bundle: nil), forCellReuseIdentifier: "MainDetailCastTableViewCell")
    }

}


// MARK: TableView DataSource, Delegate

extension MainDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let castCell = tableView.dequeueReusableCell(withIdentifier: "MainDetailCastTableViewCell", for: indexPath) as? MainDetailCastTableViewCell else
        { return UITableViewCell() }
         
        return castCell
    }
}









enum MainDetailType {
    case poseter
    case overview
    case cast
}



struct costModel {
    var titleImage: String
    var realMame: String
    var castingName: String
}
