//
//  ViewController.swift
//  calculactrice
//
//  Created by sg812131 on 01/03/2021.
//

import UIKit

class ViewController: UIViewController {
    var onEstAuDebuDunMot = true
    var onADejaUneVirgule = false
    
    var pileDeNombres = Array<Double>()
    var valeurAffichee : Double {
        get {
            return NumberFormatter().number(from: ecran.text!)!.doubleValue
        }
        set {
            ecran.text = "\(newValue)"
        }
    }

    @IBOutlet weak var ecran: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ajoutChiffre(_ sender: UIButton) {
        if let chiffre = sender.currentTitle {
            if onEstAuDebuDunMot {
                ecran.text! = chiffre
                onEstAuDebuDunMot = false
            } else {
                ecran.text! += chiffre
            }
            
        }
    }
    
    @IBAction func calcul(_ sender: UIButton) {
        switch sender.currentTitle {
        case "+":
            applique(operation: +)
            //valeurAffichee = pileDeNombres.popLast()! + pileDeNombres.popLast()!
        case "-":
            applique(operation: {
                (op1, op2) in op2 - op1
            })
            print("-")
        case "×":
            applique(operation: *)
            print("x")
        case "÷":
            applique(operation: {
                (op1, op2) in op2 / op1
            })
            print("/")
        default:
            print("operation non connu")
        }
    }
    
    @IBAction func enter(_ sender: Any) {
        pileDeNombres.append(valeurAffichee)
        onEstAuDebuDunMot = true
        print("la pile est \(pileDeNombres)")
    }
    
    func applique(operation: (Double, Double) -> Double) {
        if pileDeNombres.count > 1 {
            valeurAffichee = operation(pileDeNombres.popLast()!, pileDeNombres.popLast()!)
            enter(self)
        }
    }
    

}

