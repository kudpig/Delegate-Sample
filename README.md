# Delegate-Sample
Qiita用サンプル[Protocolを使ったDelegate]

## プレビュー
[![Image from Gyazo](https://i.gyazo.com/503e6c637bd67983bc1f82e8afb9f301.gif)](https://gyazo.com/503e6c637bd67983bc1f82e8afb9f301)

## ソースコード

### ViewController

```ViewController.swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stringLabel: UILabel! {
        didSet {
            stringLabel.text = "まだ選択されていません"
        }
    }

    @IBAction func tappedButton(_ sender: UIButton) {
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        let secondVC = secondStoryboard.instantiateInitialViewController() as! SecondViewController
        // SecondViewControllerで定義したdelegateにself(ViewController)を設定する
        secondVC.delegate = self
        let nav = self.navigationController!
        nav.pushViewController(secondVC, animated: true)
    }

}

extension ViewController: ToPassDataProtocol {

    func dataDidSelect(data: String) {
        stringLabel.text = data
    }


}
```

### SecondViewController

```swift
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
```

### ToPassDataProtocol

```swift
import Foundation

protocol ToPassDataProtocol: class {
    func dataDidSelect(data: String)
}
```
