//
//  LobbyViewController.swift
//  TechMonster
//
//  Created by Tommy on 2019/04/12.
//  Copyright © 2019 Tommy. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    var maxStamina: Float = 100
    var stamina: Float = 100
    var player: Player = Player()
    var staminaTimer: Timer!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var staminaBar: UIProgressView!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv. %d", player.level)
        
        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
        
        staminaTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(self.cureStamina), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TechDraUtil.stopBGM()
    }
    
    @objc func cureStamina() {
        if stamina < maxStamina {
            stamina = min(stamina + 1, maxStamina)
            staminaBar.progress = stamina / maxStamina
        }
    }
    
    @IBAction func startButtle() {
        if stamina >= 20 {
            stamina = stamina - 20
            staminaBar.progress = stamina / maxStamina
            performSegue(withIdentifier: "startButtle", sender: nil)
        } else {
            let alert = UIAlertController(title: "スタミナ不足", message: "スタミナが20以上必要です", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startButtle" {
            let battleVC = segue.destination as! ButtleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
