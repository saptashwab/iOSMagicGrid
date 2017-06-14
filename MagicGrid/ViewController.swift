//
//  ViewController.swift
//  MagicGrid
//
//  Created by Saptashwa Bandyopadhyay on 12/06/17.
//  Copyright © 2017 Saptashwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var width: CGFloat = 0
    var cellMap = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numPerRow = 15
        width = view.frame.width / CGFloat(numPerRow)
        let numPerColumn = Int(view.frame.height / width)
        
        for j in 0...numPerColumn {
            for i in 0...numPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: width * CGFloat(i), y: width * CGFloat(j), width: width, height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                cellMap["\(i)|\(j)"] = cellView
                
                view.addSubview(cellView)
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    var selectedCell: UIView?
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let row = Int(location.x/width)
        let column = Int(location.y/width)
        
        let key = "\(row)|\(column)"
        guard let cellView = cellMap[key] else { return }
        
        view.bringSubview(toFront: cellView)
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.selectedCell?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                cellView.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        //print("\(location)\t\(row)\t\(column)")
    }
    
    private func randomColor() -> UIColor {
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        //print("\(red)\t\(green)\t\(blue)")
        return UIColor(displayP3Red: red, green:green, blue: blue, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

