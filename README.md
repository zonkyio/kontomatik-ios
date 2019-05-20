# Kontomatik for iOS (Swift)

The missing iOS SDK for Kontomatik written in Swift.  Compatible with Swift 5.

## Prerequirements
- None

Install with `Carthage`. Add this line to .Cartfile
    
    $ Kontomatik-iOS
    
Install with `Cocoapods`. Add this line to .Podfile
    
    $ Kontomatik-iOS

## Setting it up

There is an example project. But interesting parts are here:

```

final class ViewController: UIViewController {
   override func loadView() {
       super.loadView()
      
       let kontomatikView = KontomatikSignInView()
       view.addSubview(kontomatikView)
       self.kontomatikView = kontomatikView

       // Custom UIView extension, see the example project
       kontomatikView.bindFrameToSuperviewBounds()
   }

   override func viewDidLoad() {
       super.viewDidLoad()
       
       let kontomatikStyle = KontomatikSignInStyle(alertErrorBgColor: UIColor.white,
                                                   alertErrorBorderColor: UIColor.white,
                                                   alertErrorTextColor: UIColor.black,
                                                   bodyBgColor: UIColor.white,
                                                   borderRadius: 4,
                                                   btnBgColor: UIColor.blue,
                                                   btnBorderColor: UIColor.blue,
                                                   btnTextColor: UIColor.white,
                                                   btnPrimaryBgColor: UIColor.blue,
                                                   btnPrimaryBorderColor: UIColor.blue,
                                                   btnPrimaryTextColor: UIColor.white,
                                                   inputBgColor: UIColor.white,
                                                   inputBorderColor: UIColor.darkGray,
                                                   inputTextColor: UIColor.black,
                                                   inputDisabledTextColor: UIColor.darkGray,
                                                   inputBorderFocusColor: UIColor.darkGray,
                                                   menuHighlightBgColor: nil)

       let kontomatikConfig = KontomatikSignInConfiguration(client: kontomatikClientID,
                                                            clientIdentity: kontomatikClientIdentity,
                                                            country: .cz, locale: .cz,
                                                            style: kontomatikStyle,
                                                            target: bank)
       kontomatikView.delegate = self
       kontomatikView.showLoadingOverlay = true
       kontomatikView.configuration = kontomatikConfig
   }
}
```


