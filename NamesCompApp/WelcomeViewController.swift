//
//  WelcomeViewController.swift
//  NamesCompApp
//
//  Created by Денис Ільницький on 24/08/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var partnersNameTF: UITextField!
    
    @IBOutlet weak var showResultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResultButton.layer.cornerRadius = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.yourName = yourNameTF.text
        destinationVC.partnersName = partnersNameTF.text
    }

    @IBAction func showResultButtonPressed() {
        guard let firstName = yourNameTF.text, let secondName = partnersNameTF.text else { return }
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(tittle: "Names are missing", message: "Please enter both names 😅")
            return
           }
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToWelcomeVC(segue: UIStoryboardSegue) {
        yourNameTF.text = ""
        partnersNameTF.text = ""
    }
}

 
extension WelcomeViewController {
    private func showAlert(tittle: String, message: String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension WelcomeViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnersNameTF.becomeFirstResponder()
        } else {
            showResultButtonPressed()
        }
        return true
    }
}

