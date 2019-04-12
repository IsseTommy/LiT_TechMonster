//
//  ButtleViewController.swift
//  TechMonster
//
//  Created by Tommy on 2019/04/12.
//  Copyright © 2019 Tommy. All rights reserved.
//

import UIKit

class ButtleViewController: UIViewController {
    
    var enemyAttackTimer: Timer!
    
    var enemy: Enemy!
    var player: Player!
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var attackButton: UIButton!
    
    @IBOutlet weak var enemyImageView: UIImageView!
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var enemyHPBar: UIProgressView!
    @IBOutlet weak var playerHPBar: UIProgressView!
    
    @IBOutlet weak var enemyNameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enemyHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        playerHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        playerNameLabel.text = player.name
        playerImageView.image = player.image
        playerHPBar.progress = player.currentHP / player.maxHP
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startButtle()
    }
    
    func startButtle() {
        TechDraUtil.playBGM(fileName: "BGM_battle001")
        
        enemy = Enemy()
        
        enemyNameLabel.text = enemy.name
        enemyImageView.image = enemy.image
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        
        attackButton.isHidden = false
        
        enemyAttackTimer = Timer.scheduledTimer(timeInterval: enemy.attackInterval, target: self, selector: #selector(self.enemyAttack), userInfo: nil, repeats: true)
    }
    
    @IBAction func playerAttack() {
        TechDraUtil.animateDamage(enemyImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        
        enemy.currentHP = enemy.currentHP - player.attackPower
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
        
        if enemy.currentHP <= 0 {
            TechDraUtil.animateVanish(enemyImageView)
            finichBattle(winPlayer: true)
        }
    }
    
    func finichBattle(winPlayer: Bool) {
        TechDraUtil.stopBGM()
        
        attackButton.isHidden = true
        
        let finishedMessage: String
        if winPlayer == true {
            TechDraUtil.playSE(fileName: "SE_fanfare")
            finishedMessage = "プレイヤーの勝利！"
        } else {
            TechDraUtil.playSE(fileName: "SE_gameover")
            finishedMessage = "プレイヤーの敗北..."
        }
        let alert = UIAlertController(title: "バトル終了！", message: finishedMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in self.dismiss(animated: true, completion: nil)})
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func enemyAttack() {
        TechDraUtil.animateDamage(playerImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        
        player.currentHP = player.currentHP - player.attackPower
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
        
        if player.currentHP <= 0 {
            TechDraUtil.animateVanish(playerImageView)
            finichBattle(winPlayer: false)
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
