

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

