import UIKit

class ThirdTabViewController: UIViewController {

    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("3번", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        view.addSubview(readyButton)

        readyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            readyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            readyButton.widthAnchor.constraint(equalToConstant: 200),
            readyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        readyButton.addTarget(self, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapReadyButton(_ sender: Any) {
        //didSendEventClosure?(.ready)
    }

}
