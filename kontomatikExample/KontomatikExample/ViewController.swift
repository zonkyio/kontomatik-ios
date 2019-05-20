//
//  ViewController.swift
//  KontomatikExamaple
//
//  Created by Lukas Gergel on 20/05/2019.
//  Copyright © 2019 Zonky a.s. All rights reserved.
//

import UIKit
import kontomatik

final class ViewController: UIViewController {
    
    private weak var kontomatikView: KontomatikSignInView!
    
    // These properties are given by Kontomatik company
    private let kontomatikClientID =  "xxxxxx"
    private let kontomatikClientIdentity = "xxxxxx"
    
    // pre-selected bank
    private let bank = KontomatikBank.AirBank.rawValue
    
    private var isLoading: Bool = false {
        didSet {
            // some overlay logic comes here
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.lightGray
        
        let kontomatikView = KontomatikSignInView()
        view.addSubview(kontomatikView)
        kontomatikView.bindFrameToSuperviewBounds(inset: 16)
        self.kontomatikView = kontomatikView
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

extension ViewController: KontomatikSignInDelegate {
    func onKontomatikInitialized(in view: KontomatikSignInView) {
        isLoading = false
    }
    
    func loadingStarted(in view: KontomatikSignInView) {
        isLoading = true
    }
    
    func loadingCompleted(in view: KontomatikSignInView) {
        
    }
    
    func signInCompleted(in view: KontomatikSignInView, target: String, sessionId: String, sessionIdSignature: String) {
        // sign-in completed action
        print("sessionId: \(sessionId), sessionIdSignature: \(sessionIdSignature)")
    }
    
    func onError(in view: KontomatikSignInView, error: Error) {
        isLoading = false
        // sign-in failed action
        print("error: \(error)")
    }
}


public enum KontomatikBank: String, Codable {
    case Sporitelna = "Sporitelna_cz"
    case AirBank = "Airbank_cz"
    case KB = "Kb_cz"
    case CSOB = "Csob_cz"
    case Moneta = "Gemoney_cz"
    case MBank = "MBank_cz"
    case Fio = "Fio_cz"
    case Raiffeisen = "Raiffeisen_cz"
    case EquaBank = "Equa_cz"
    case UniCredit = "Unicredit_cz"
    case Era = "Era_cz"
}

private extension UIView {

    func bindFrameToSuperviewBounds(inset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -inset).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: inset).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -inset).isActive = true
    }
}
