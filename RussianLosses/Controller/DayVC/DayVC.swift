//
//  DayVC.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import UIKit

class DayVC: UIViewController {
    
    let lossesData: [String:Int]
    let keys: [String]
    let date: String
    
    @IBOutlet weak var informationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        title = date
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //init table
        informationTableView.register(UINib(nibName: InfoCell.nibName, bundle: nil), forCellReuseIdentifier: InfoCell.cellId)
        informationTableView.delegate = self
        informationTableView.dataSource = self
    }
    
    init(dayData: LossesData) {
        lossesData = dayData.getDictionary()
        keys = lossesData.keys.sorted()
        date = dayData.date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DayVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.cellId, for: indexPath) as? InfoCell {
            let key = keys[indexPath.section]
            if let value = lossesData[key] {
                cell.uploadData(cellType: key, cellValue: value)
            } else {
                showError(message: "Something isn't good")
            }
            return cell
        } else {
            showError(message: "Something isn't good")
            return UITableViewCell()
        }
    }
    
}
