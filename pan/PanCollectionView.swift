//
//  PanCollectionView.swift
//  pan
//
//  Created by lina on 2021/4/23.
//

import UIKit

@objc
class PanCollectionView: UIView {
    private let tagSize = CGSize(width: (UIScreen.width - 32 - 27) / 4, height: 40)

    @objc lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = tagSize
        flowLayout.minimumInteritemSpacing = 9
        flowLayout.minimumLineSpacing = 9;
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentOffset = CGPoint(x: 0, y: 200);
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.description())
        collectionView.register(HeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeadView.description())
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.collectionView)
        collectionView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// UICollectionViewDelegate
extension PanCollectionView : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.description(), for: indexPath) as! CollectionCell
        cell.label.text = "color"
        if indexPath.row % 2 == 0 {
            cell.label.backgroundColor = .red
            
        }else{
            cell.label.backgroundColor = .yellow
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        12
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let h = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeadView.description(), for: indexPath) as! HeadView
            h.titleLabel.text = "组 - \(indexPath.section)"
            return h
        }
        return UICollectionReusableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width, height: 6))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.width - 36, height: 52)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


/// views
extension PanCollectionView {
    fileprivate class HeadView: UICollectionReusableView {
        var titleLabel: UILabel!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setUpUI() {
            
            let v = UIView.init(frame: CGRect.init(x: 16, y: 24, width: 3, height: 12))
            v.backgroundColor = UIColor.lightGray
            v.layer.cornerRadius = 1.5
            v.clipsToBounds = true
            addSubview(v)
            
            titleLabel = UILabel(frame: CGRect(x: v.frame.maxY + 5, y: 20, width: UIScreen.width - 32, height: 20))
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = UIColor.black
            addSubview(titleLabel)
        }
    }
    
    fileprivate class CollectionCell: UICollectionViewCell {
    
        var label : UILabel!
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            label = UILabel.init(frame: self.bounds)
            label.backgroundColor = .yellow
            label.clipsToBounds = true
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            addSubview(label)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    func setSelected(isSelected : Bool){
        
        
    }


}


extension UIScreen {
    
    static let width = UIScreen.main.bounds.width
    
    static let height = UIScreen.main.bounds.height
    
    static let topEdge: CGFloat = UIDevice.isX ? 44 : 20
    
    static let bottomEdge: CGFloat = UIDevice.isX ? 34 : 0
    
}


extension UIDevice {
    
    static let isPad = UIDevice.current.model == "iPad"
    /// 带有刘海
    static var isX: Bool {
        var isiPhoneX = false
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first ?? nil,
               window.safeAreaInsets.bottom > 0.0 {
                isiPhoneX = true
            }
        }
        return isiPhoneX
    }
}


extension PanViewController : UIScrollViewDelegate{
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrolView {
            scrollDidEndDragging()
        }
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView === self.scrolView && !decelerate {
            scrollDidEndDragging()
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    private func scrollDidEndDragging() {
        let contentOffsetX = scrolView.contentOffset.x
        index = Int(contentOffsetX / UIScreen.width)
        self.scrolView.setContentOffset(CGPoint(x: UIScreen.width * CGFloat(index), y: 0), animated: false)

    }

}
