//
//  ListVC.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var lossesData = [LossesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        title = "Russian losses"
        initTable()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    ///Load data to variable lossesData
    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            NetworkManager.shared.getData(fromFile: .equipment) { (equipmentData: [LossesEquipmentData]) in
                NetworkManager.shared.getData(fromFile: .personnel) { (personnelData: [LossesPersonnelData]) in
                    self.lossesData = self.combineData(equipments: equipmentData, personnels: personnelData)
                    DispatchQueue.main.async {
                        self.listTableView.reloadData()
                        self.listTableView.isHidden = false
                        self.statusLabel.isHidden = true
                    }
                } onError: { message in
                    self.showError(message: message)
                    self.statusLabel.text = "Crash"
                }
            } onError: { message in
                self.showError(message: message)
                self.statusLabel.text = "Crash"
            }
        }
    }
    
    ///Combine and sort equipment and personnel data
    private func combineData(equipments: [LossesEquipmentData], personnels: [LossesPersonnelData]) -> [LossesData] {
        var result = [LossesData]()
        let sortEquipments = equipments.sorted { firstElement, secondElement in
            return firstElement.day > secondElement.day
        }
        for equipmentData in sortEquipments {
            let index = personnels.firstIndex { personnelData in
                return equipmentData.day == personnelData.day
            }
            if let index = index {
                result.append(LossesData(
                    date: equipmentData.date,
                    day: equipmentData.day,
                    equipment: equipmentData,
                    personnel: personnels[index]
                ))
            }
        }
        return result
    }
    
    ///Load data to table
    private func initTable() {
        listTableView.register(UINib(nibName: DayCell.nibName, bundle: nil), forCellReuseIdentifier: DayCell.cellId)
        listTableView.delegate = self
        listTableView.dataSource = self
    }

}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lossesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.cellId, for: indexPath) as? DayCell {
            cell.uploadData(lossesData[indexPath.row])
            return cell
        } else {
            showError(message: "Something isn't good")
            statusLabel.text = "Crash"
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dayVC = DayVC(dayData: lossesData[indexPath.row])
        navigationController?.pushViewController(dayVC, animated: true)
    }
    
}
