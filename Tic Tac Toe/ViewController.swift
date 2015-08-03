//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by lapacino on 8/1/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userResultLabel: UILabel!
    
   
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
  
    var plays = Dictionary<Int,Int>()
    var aiDecided = false
    var done = false
    var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func resetButton(sender: UIButton) {
        reset()
        
         }
    
    
    
    @IBAction func buttonClicked(sender: UIButton) {
        
        if plays[sender.tag] == nil && !aiDecided && !done {
            setSpotImage(sender.tag, player: 1)
        }
        checkWin()
        aiTurn()
    }
    
    func setSpotImage(spot:Int, player:Int) {
       
        var playerMaker = player == 1 ? "X" : "O"
        plays[spot] = player
        
        switch spot {
        case 1: imageView1.image = UIImage(named: playerMaker)
        case 2: imageView2.image = UIImage(named: playerMaker)
        case 3: imageView3.image = UIImage(named: playerMaker)
        case 4: imageView4.image = UIImage(named: playerMaker)
        case 5: imageView5.image = UIImage(named: playerMaker)
        case 6: imageView6.image = UIImage(named: playerMaker)
        case 7: imageView7.image = UIImage(named: playerMaker)
        case 8: imageView8.image = UIImage(named: playerMaker)
        case 9: imageView9.image = UIImage(named: playerMaker)
        default: imageView1.image = UIImage(named: playerMaker)
 
        }
    }
    
    func checkWin() {
        var whoWon = ["I":0, "YOU":1]
        for (key,value) in whoWon {
            if (plays[7] == value && plays[8] == value && plays[9] == value) ||
                (plays[4] == value && plays[5] == value && plays[6] == value) ||
                (plays[1] == value && plays[2] == value && plays[3] == value) ||
                (plays[7] == value && plays[4] == value && plays[1] == value) ||
                (plays[8] == value && plays[5] == value && plays[2] == value) ||
                (plays[9] == value && plays[6] == value && plays[3] == value) ||
                (plays[7] == value && plays[5] == value && plays[3] == value) ||
                (plays[9] == value && plays[5] == value && plays[1] == value) {
                    
                    userResultLabel.hidden = false
                    userResultLabel.text = "It look like \(key) won"
                    resetButton.hidden = false
                    done = true
            }
        }
     
    }
    
    func reset() {
        plays = [:]
        
         imageView1.image = nil
         imageView2.image = nil
         imageView3.image = nil
         imageView4.image = nil
         imageView5.image = nil
         imageView6.image = nil
         imageView7.image = nil
         imageView8.image = nil
         imageView9.image = nil
        
        userResultLabel.hidden = true
        resetButton.hidden = true
        done = false
    }
    
    func isOccupied(spot:Int) -> Bool {
        if plays[spot] != nil {
            return true
        }
        
        return false
    }
    
    func aiTurn() {
        if done {
            return
        }
        
            //computer played position
            aiDecided = true
        if let result = checkRow(value: 0) {
            var whereToPlayResult = whereToPlay(result.location, pattern: result.pattern)
            if !isOccupied(whereToPlayResult) {
                setSpotImage(whereToPlayResult, player: 0)
                aiDecided = false
                checkWin()
                return
            }
        }
        // user played position
        if let result = checkRow(value: 1) {
            var whereToPlayResult = whereToPlay(result.location, pattern: result.pattern)
            if !isOccupied(whereToPlayResult) {
                setSpotImage(whereToPlayResult, player: 0)
                aiDecided = false
                checkWin()
                return
            }
        }
        
        //is center available
        if !isOccupied(5) {
            setSpotImage(5, player: 0)
            aiDecided = false
            checkWin()
            return
        }
        
        func firstAvailable(#isCorner:Bool) -> Int? {
            var spots = isCorner ? [1, 3, 7, 9] : [2, 4, 6, 8]
            for spot in spots {
                if !isOccupied(spot) {
                    return spot
                }
            }
            return nil
            
        }
        
        
        //check corner 
        if let cornerAvailable = firstAvailable(isCorner: true) {
        setSpotImage(cornerAvailable, player: 0)
        aiDecided = false
        checkWin()
        return
        }
        
        
        // check side
        if  let sideAvailable = firstAvailable(isCorner: false) {
        setSpotImage(sideAvailable, player: 0)
        aiDecided = false
        checkWin()
        return
        }
        
            userResultLabel.hidden = false
            userResultLabel.text = "It look like a tie"
            reset()
            
            aiDecided = false
            
            
    }
    
    func whereToPlay(location:String, pattern:String) -> Int {
       
        let rightPattern = "011"
        let middlePattern = "101"
        let leftPattern = "110"
        
        switch location {
            
            case "Top":
                if pattern == rightPattern {
                    return 1
            }
                else if pattern == middlePattern {
                    return 2
            }
                else {
                    return 3
            }
            
        case "Botton":
            if pattern == rightPattern {
                return 7
            }
            else if pattern == middlePattern {
                return 8
            }
            else {
                return 9
            }
            
        case "MiddelCross":
            if pattern == rightPattern {
                return 4
            }
            else if pattern == middlePattern {
                return 5
            }
            else {
                return 6
            }
            
        case "Left":
            if pattern == rightPattern {
                return 1
            }
            else if pattern == middlePattern {
                return 4
            }
            else {
                return 7
            }
            
        case "Right":
            if pattern == rightPattern {
                return 3
            }
            else if pattern == middlePattern {
                return 6
            }
            else {
                return 9
            }
            
        case "MiddelDown":
            if pattern == rightPattern {
                return 2
            }
            else if pattern == middlePattern {
                return 5
            }
            else {
                return 8
            }
            
        case "DiagRightLeft":
            if pattern == rightPattern {
                return 3
            }
            else if pattern == middlePattern {
                return 5
            }
            else {
                return 7
            }
            
        case "DiagLeftRight":
            if pattern == rightPattern {
                return 1
            }
            else if pattern == middlePattern {
                return 5
            }
            else {
                return 9
            }
        default:
            return 4
        }
        
    }
    
    
    
    func checkTop(#value:Int) -> (location:String, pattern:String) {
        return ("Top", checkFor(value, inList: [1, 2, 3]))
    }
    func checkBotton(#value:Int) -> (location:String, pattern:String) {
        return ("Botton", checkFor(value, inList: [7, 8, 9]))
    }
    func checkMiddelCross(#value:Int) -> (location:String, pattern:String) {
        return ("MiddelCross", checkFor(value, inList: [4, 5, 6]))
    }
    func checkLeft(#value:Int) -> (location:String, pattern:String) {
        return ("Left", checkFor(value, inList: [1, 4, 7]))
    }
    func checkRight(#value:Int) -> (location:String, pattern:String) {
        return ("Right", checkFor(value, inList: [3, 6, 9]))
    }
    func checkMiddelDown(#value:Int) -> (location:String, pattern:String) {
        return ("MiddelDown", checkFor(value, inList: [2, 5, 8]))
    }
    func checkDiagRightLeft(#value:Int) -> (location:String, pattern:String) {
        return ("DiagRightLeft", checkFor(value, inList: [3, 5, 7]))
    }
    func checkDiagLeftRight(#value:Int) -> (location:String, pattern:String) {
        return ("DiagLeftRight", checkFor(value, inList: [1, 5, 9]))
    }
  
    
    
    
    
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }
            else {
                conclusion += "0"
            }
        }
        
        return conclusion
    }
    
    func checkRow(#value:Int) -> (location:String, pattern:String)? {
        var acceptedFinds = ["011","101","110"]
        var findFuncs = [checkTop, checkBotton, checkMiddelCross, checkLeft, checkRight, checkMiddelDown, checkDiagRightLeft, checkDiagLeftRight]
        for algorithm in findFuncs {
            var algorithmResult = algorithm(value: value)
            
            if (find(acceptedFinds, algorithmResult.pattern) != nil) {
                return algorithmResult
            }
        }
        
        
        
        return nil
    }

}

