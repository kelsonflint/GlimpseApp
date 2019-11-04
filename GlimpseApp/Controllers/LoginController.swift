import UIKit
import Foundation
import ChameleonFramework

class LoginController : UIViewController, UITextFieldDelegate {
    
    var userId : String?
    var idTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setupNav()
        setupLogo()
        setupButton()
        setupIdField()
        setupCompanyName()
    }

    override open var shouldAutorotate: Bool {
        return false
    }
    
    @objc func buttonAction(sender: UIButton!) {
        //if empty prompt user for id
        self.userId = idTextField.text
        print("Button tapped")
        print("user \(userId!)")
        //let destinationView = EventController()
        let destinationView = HomeController()
        destinationView.userId = userId!
        self.navigationController?.pushViewController(destinationView, animated: true)
        
    }
    
    func setupCompanyName() {
        let company = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 150, y: view.frame.height / 2 - 100, width: 300, height: 80))
        company.text = "GlimpseCam"
        company.textColor = .white
        company.font = UIFont.boldSystemFont(ofSize: 40)
        company.textAlignment = .center
        self.view.addSubview(company)
    }
    
    func setupButton() {
        let button = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 150  , y: self.view.frame.height / 2 + 30, width: 300, height: 50))
        button.backgroundColor = FlatSkyBlueDark()
        button.setTitle("Enter Glimpse", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        self.view.addSubview(button)
    }
    func setupLogo() {
        let logo : UIImageView = {
            let image = UIImageView(frame: CGRect(x: 150, y: 0, width: 100, height: 100))
            image.image = UIImage(named: "Logo")
            image.backgroundColor = .black
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        self.view.addSubview(logo)
    }
    func setupIdField() {
        idTextField = UITextField(frame: CGRect(x: self.view.frame.width / 2 - 150, y: self.view.frame.height / 2 - 30, width: 300, height: 50))
        idTextField.backgroundColor = .white
        idTextField.placeholder = "Device ID"
        idTextField.borderStyle = .line
        //idTextField.keyboardType = .numberPad
        idTextField.returnKeyType = .done
        idTextField.delegate = self
        idTextField.minimumFontSize = 20
        idTextField.contentHorizontalAlignment = .center
        self.view.addSubview(idTextField)
    }
    
    func setupNav() {
        let navTitle = UILabel(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width - 32, height:70))
        navTitle.text = "Login"
        navTitle.textColor = UIColor.white
        navTitle.font = UIFont.boldSystemFont(ofSize: 35)
        navigationItem.titleView = navTitle
        navigationItem.title = "Login"
       
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.barTintColor  = UIColor.black;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTextField.resignFirstResponder()
        return true
    }
}
