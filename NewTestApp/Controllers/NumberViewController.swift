//
//  NumberViewController.swift
//  NewTestApp
//
//  Created by Димаш Алтынбек on 19.12.2023.
//

import Foundation
import UIKit
import SnapKit

class NumberViewController: UIViewController {
    //MARK: -Variables-
    let table: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemGray
        table.register(NumberTableViewCell.self, forCellReuseIdentifier: "NumberTableViewCell")
        return table
    }()
    
    var roomData: RoomData?
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Steigenberger Makadi"
        setUpViews()
        table.delegate = self
        table.dataSource = self
        fetchRoomData()
    }
    
    
    //MARK: -Functions-
    private func fetchRoomData() {
        NetworkService.shared.fetchRoomData { [weak self] fetchedRoomData in
            guard let self = self else { return }
            self.roomData = fetchedRoomData

            // Reload the table view on the main thread
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
}

//MARK: -extension setUpViews -
extension NumberViewController {
    private func setUpViews() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        view.addSubview(table)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        table.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

    //MARK: -Table View Delegate-
extension NumberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 1.48
    }
}

    //MARK: -Table View DataSource-
extension NumberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomData?.rooms.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberTableViewCell", for: indexPath) as? NumberTableViewCell,
            let room = roomData?.rooms[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureWithImageURLs(room.image_urls)

                // For peculiarities, you can do the same
        cell.setupPeculiarities(labels: room.peculiarities )

        DispatchQueue.main.async {
            if let room = self.roomData?.rooms[indexPath.row] {
                cell.nameLabel.text = room.name
                cell.priceLbl.text = "\(room.price)"
                cell.nightLbl.text = room.price_per
            }
        }
        return cell
    }
    
    
}
