//
//  ViewController.swift
//  scrollview
//
//  Created by nenhall on 2021/9/18.
//

import Cocoa

class ViewController: NSViewController {
    let scrollView = NSScrollView()
    let documentView = NSView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.documentView = documentView
        scrollView.backgroundColor = .gray
        scrollView.verticalScrollElasticity = .none
        scrollView.horizontalScrollElasticity = .none
        documentView.wantsLayer = true
        documentView.layer?.backgroundColor = NSColor.purple.cgColor
      
        scrollViewConstraint()
        documentViewConstraint()
        addSubviews()

    }
    
    
    override func viewDidAppear() {
        super.viewDidAppear()
     

    }
    
    func scrollViewConstraint() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        /// 为了解决父视图比自己大的时候，这是scrollView应该不要拉伸
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).set { (constraint) in
            constraint.isActive = true
        }
        
        /// 为了父视图能拉伸
        scrollView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, constant: 0).set { (constraint) in
//            constraint.priority = .defaultLow
//            constraint.isActive = true
        }
        
        /// 给定一个最小的高，防止被父视图压缩
        scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).set { (constraint) in
//            constraint.isActive = true
        }
    }
    
    func documentViewConstraint() {
        documentView.translatesAutoresizingMaskIntoConstraints = false
        documentView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor, constant: 0).isActive = true
        documentView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor, constant: 0).isActive = true
        documentView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor, constant: 0).isActive = true
        documentView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.contentView.bottomAnchor, constant: 0).set { (constraint) in
            constraint.isActive = true
        }
        /// 设定一个基础高，不然会从下往上变高
        documentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.contentView.heightAnchor).set { (constraint) in
            constraint.priority = .defaultLow
            constraint.isActive = true
        }
    }
    
    func createSubview(relative: NSView?) -> NSView {
        let cView = NSView()
        documentView.addSubview(cView)
        cView.wantsLayer = true
        cView.layer?.backgroundColor = NSColor(red: CGFloat(arc4random() % 255), green: CGFloat(arc4random() % 255), blue: CGFloat(arc4random() % 255), alpha: 1).cgColor
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.leadingAnchor.constraint(equalTo: documentView.leadingAnchor, constant: 0).isActive = true
        cView.trailingAnchor.constraint(equalTo: documentView.trailingAnchor, constant: 0).set { (constraint) in
            constraint.priority = .defaultLow
            constraint.isActive = true
        }
        cView.bottomAnchor.constraint(equalTo: documentView.bottomAnchor, constant: -20).set { (constraint) in
            constraint.priority = .defaultLow
//            constraint.isActive = true
        }
        
        if let relative = relative {
            cView.topAnchor.constraint(equalTo: relative.bottomAnchor, constant: 0).isActive = true
            cView.bottomAnchor.constraint(equalTo: documentView.bottomAnchor, constant: -20).set { (constraint) in
    //            constraint.priority = .defaultLow
                constraint.isActive = true
            }
        } else {
            cView.topAnchor.constraint(equalTo: documentView.topAnchor, constant: 20).isActive = true

        }
   
        let button = NSButton()
        button.wantsLayer = true
        button.bezelStyle = .regularSquare
        button.isBordered = false
        button.layer?.backgroundColor = NSColor(red: CGFloat(arc4random() % 255), green: CGFloat(arc4random() % 255), blue: CGFloat(arc4random() % 255), alpha: 1).cgColor
        cView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
      
        if relative == nil {
            button.setContentHuggingPriority(.defaultHigh, for: .vertical)
            button.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            NSLayoutConstraint.activate([
//                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
                button.bottomAnchor.constraint(equalTo: cView.bottomAnchor, constant: 0),
                button.widthAnchor.constraint(equalToConstant: 100),
                button.topAnchor.constraint(equalTo: cView.topAnchor, constant: 0),
                button.bottomAnchor.constraint(equalTo: cView.bottomAnchor, constant: 0),
                button.leadingAnchor.constraint(equalTo: cView.leadingAnchor, constant: 0),
            ])
        } else {
            button.setContentHuggingPriority(.defaultLow, for: .vertical)
            button.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
                button.bottomAnchor.constraint(equalTo: cView.bottomAnchor, constant: 0),
                button.widthAnchor.constraint(equalToConstant: 100),
                button.topAnchor.constraint(equalTo: cView.topAnchor, constant: 0),
                button.bottomAnchor.constraint(equalTo: cView.bottomAnchor, constant: 0),
                button.leadingAnchor.constraint(equalTo: cView.leadingAnchor, constant: 0),
            ])
        }
       return cView
    }

    func addSubviews() {
        
        let view = createSubview(relative: nil)
        documentView.addSubview(view)
        
        let view2 = createSubview(relative: view)
        documentView.addSubview(view2)

    }


}



extension NSLayoutConstraint {
        
    @discardableResult
    @objc func set(config: (_ constraint: NSLayoutConstraint) ->()) -> NSLayoutConstraint {
         config(self)
        return self
    }
}
