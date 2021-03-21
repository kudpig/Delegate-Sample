//
//  SecondViewController.swift
//  Delegate-Sample
//
//  Created by Shinichiro Kudo on 2021/03/18.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let dataString = ["First", "Second", "Third", "Another", "More"]
    
    weak var delegate: ToPassDataProtocol?
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataString[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataString[indexPath.row] // delegateに渡す変数を用意
        delegate?.dataDidSelect(data: data) // ここで値を渡す
        self.navigationController?.popViewController(animated: true)
    }
    
}
