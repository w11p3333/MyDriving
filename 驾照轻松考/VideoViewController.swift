//
//  SubjectTwoViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/18.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {


    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = bgGrayColor
        
        // Do any additional setup after loading the view.
    }

  
  

}


extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource
{

   
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section == 0 ? 2 : 5
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath) as! VideoCollectionViewCell
        cell.rightLabel.text = "独家实拍"
        cell.rightLabel.backgroundColor = bgcolor
        cell.image_view.image = UIImage(named: "videoAblum")
        cell.timeLabel.text = "4:40"
        cell.descLabel.text = "倒车入库"
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
   
        
       
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView", forIndexPath: indexPath) as! CollectionHeaderView
        let label = UILabel(frame:CGRectMake(8, 0, 100, 20))
        label.text =  "科目二"
        label.textColor = bgcolor
        header.addSubview(label)
        return header
       
      
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let path = NSBundle.mainBundle().pathForResource("shipin", ofType: "mp4")
        playerView = AVPlayer(URL: NSURL(fileURLWithPath: path!))
        playViewController.player = playerView
        self.presentViewController(playViewController, animated: true) {
            self.playViewController.player?.play()
        }

    }

}
