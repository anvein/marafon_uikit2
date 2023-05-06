
import UIKit


class ViewController: UIViewController {

   lazy var viewController: UIViewController = {
       let button = UIViewController()
       button.view.backgroundColor = .blue
   
       return button
   }()
   
   lazy var firstButton: UIButton = {
       let button = CustomButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(actionForFirstButton), for: .touchUpInside)
       button.setTitle("First Button", for: .normal)
       button.backgroundColor = .blue
   
       return button
   }()
   
   lazy var secondButton: UIButton = {
       let button = CustomButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(actionForSecondButton), for: .touchUpInside)
       button.setTitle("Second Medium Button", for: .normal)
       button.backgroundColor = .blue
       
       return button
   }()
   
   lazy var thirdButton: UIButton = {
       let button = CustomButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(actionForThirdButton), for: .touchUpInside)
       button.setTitle("Third Button", for: .normal)
       button.backgroundColor = .blue
       
       return button
   }()

   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       addSubview()
       setupViews()
       setupConstraints()
   }
   
   // MARK: - Создание и настройка интерфейса
   
   func addSubview() {
       view.addSubview(firstButton)
       view.addSubview(secondButton)
       view.addSubview(thirdButton)
   }
   
   func setupViews() {
       view.backgroundColor = .white
   }
   
   func setupConstraints() {
       firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true

       secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 16).isActive = true
       
       thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 16).isActive = true
   }
   
   // MARK: Actions
   
   @objc func actionForFirstButton() {

   }
   
   @objc func actionForSecondButton() {

   }
   
   @objc func actionForThirdButton() {
       present(viewController, animated: true)

   }

}

extension UIView {
    var isVisibleToUser: Bool {

        if isHidden || alpha == 0 || superview == nil {
            return false
        }

        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return false
        }

        let viewFrame = convert(bounds, to: rootViewController.view)

        let topSafeArea: CGFloat
        let bottomSafeArea: CGFloat

        if #available(iOS 11.0, *) {
            topSafeArea = rootViewController.view.safeAreaInsets.top
            bottomSafeArea = rootViewController.view.safeAreaInsets.bottom
        } else {
            topSafeArea = rootViewController.topLayoutGuide.length
            bottomSafeArea = rootViewController.bottomLayoutGuide.length
        }

        return viewFrame.minX >= 0 &&
            viewFrame.maxX <= rootViewController.view.bounds.width &&
            viewFrame.minY >= topSafeArea &&
            viewFrame.maxY <= rootViewController.view.bounds.height - bottomSafeArea

    }
}

class CustomButton: UIButton {
    
    func isDisplayedInScreen() -> Bool
    {
     if (self == nil) {
         return false
      }
        let screenRect = UIScreen.main.bounds
        //
        let rect = self.convert(self.frame, from: nil)
        if (rect.isEmpty || rect.isNull) {
            return false
        }
        // 若view 隐藏
        if (self.isHidden) {
            return false
        }

        //
        if (self.superview == nil) {
            return false
        }
        //
        if (rect.size.equalTo(CGSize.zero)) {
            return  false
        }
        //
        let intersectionRect = rect.intersection(screenRect)
        if (intersectionRect.isEmpty || intersectionRect.isNull) {
            return false
        }
        return true
    }
    
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setTitleColor(UIColor.white, for: .normal)
        setImage(.actions, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        clipsToBounds = true
        layer.cornerRadius = 10

        semanticContentAttribute = .forceRightToLeft
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 22, bottom: 10, right: 14)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 3)
    
        if #available(iOS 15.0, *) {
            if isVisibleToUser {
                self.backgroundColor = .systemRed
            } else {
                self.backgroundColor = .systemGreen
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    override var canBecomeFocused: Bool {

        
        
       return isVisibleToUser
     }
//
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addTarget(self, action: #selector(actionForTouchDown), for: .touchDown)
    }

    @objc func actionForTouchDown() {
       if let presentation = layer.presentation() {
           if let currentScale = presentation.value(forKeyPath: "transform.scale") {
               layer.removeAnimation(forKey: "transform.scale")
               
               let anim = CABasicAnimation(keyPath: "transform.scale")
               anim.fromValue = currentScale
               anim.toValue = 0.9
               anim.autoreverses = true
               anim.repeatCount = 0
               anim.duration = 0.1
               
               self.layer.add(anim, forKey: nil)
               
           }
       }
       
   }
   
}


class NewViewController: UIViewController {
   override func viewDidLoad() {
       super.viewDidLoad()
       
       view.backgroundColor = .white
   }
}
