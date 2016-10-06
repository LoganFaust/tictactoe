//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Logan Faust on 10/5/16.
//  Copyright © 2016 Logan Faust. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var playerOneLabel: UILabel!
    
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var board = [Int]()
    var currentPlayer = 1
    var numberOfPlays = 0
    var winningPlayer: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        initializeGame()
        
    }
    
    func initializeGame() {
        board = [Int](repeating: 0, count: 9)
        
        self.collectionView.reloadData()
        
        self.numberOfPlays = 0
        self.playerOneLabel.textColor = UIColor.black
        self.playerTwoLabel.textColor = UIColor.lightGray
        self.winningPlayer = nil
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let boardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath)
        as! BoardCollectionViewCell
        
        let boardMark = self.board[indexPath.row]
        
        if boardMark == 1 {
            boardCell.mark.text = "X"
        
        } else if boardMark == 2 {
            boardCell.mark.text = "O"
        } else {
            boardCell.mark.text = " "
        }
        
        return boardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("iOS course is awesome")
        print("indexPath - section: \(indexPath.section), row: \(indexPath.row)")
        
        if winningPlayer == nil {
            // Add a mark to the board
            if self.board[indexPath.row] == 0 { //cell is empty
                self.board[indexPath.row] = currentPlayer
                self.collectionView.reloadData()
                
                // Check if any player won
                switch true {
                case didWin(player: 1) :
                    print("Player 1 Won!")
                    self.winningPlayer = 1
                case didWin(player: 2) :
                    print("Player 2 Won!")
                    self.winningPlayer = 2
                case self.numberOfPlays == self.board.count-1:
                    print("Nobody won :(")
                    self.winningPlayer = 0
                default:
                    self.numberOfPlays += 1
                    self.ChangePlayer()
                }
                
                
            } else {
                print("There is already a mark at this cell, please try a different cell")
            }
            
        } else {
            print("The game is done")
            return
        }
    }
    
    @IBAction func onResetPressed(_ sender: UIButton) {
        self.initializeGame()
    }
    
    func ChangePlayer() {
        if self.currentPlayer == 1 {
            self.currentPlayer = 2
            self.playerOneLabel.textColor = UIColor.lightGray
            self.playerTwoLabel.textColor = UIColor.black
        } else {
            self.currentPlayer = 1
            self.playerOneLabel.textColor = UIColor.black
            self.playerTwoLabel.textColor = UIColor.lightGray
        }
        
    }
    
    func didWin(player: Int) -> Bool {
        
        let mark = player // mark and player are linked
        
        // Horizontal Wins
        if self.board[0] == mark && self.board[1] == mark && self.board[2] == mark {
            return true
        }else  if self.board[3] == mark && self.board[4] == mark && self.board[5] == mark {
            return true
        } else  if self.board[6] == mark && self.board[7] == mark && self.board[8] == mark {
            return true
        }
        
        // Veritcal Wins
        if self.board[0] == mark && self.board[3] == mark && self.board[6] == mark {
            return true
        } else  if self.board[1] == mark && self.board[4] == mark && self.board[7] == mark {
            return true
        } else  if self.board[2] == mark && self.board[5] == mark && self.board[8] == mark {
            return true
        }
        
        // Diagonal Wins
        if self.board[0] == mark && self.board[4] == mark && self.board[8] == mark {
            return true
        } else  if self.board[2] == mark && self.board[4] == mark && self.board[6] == mark {
            return true
        }

        
        return false
    }
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "New Game", style: UIAlertActionStyle.default){
            (UIAlertAction) in
            
            self.initializeGame()
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

