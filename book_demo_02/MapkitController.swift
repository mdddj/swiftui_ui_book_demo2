//
//  MapkitController.swift
//  book_demo_02
//
//  Created by ldd on 2022/2/19.
//

import Foundation
import UIKit
import MapKit
//通过代码来创建视图
class MapkitController : UIViewController {
    var mapView : MKMapView!
    
    
    /// 当视图控制器加载完毕后,他的view的属性初始值为nil,如果访问视图控制器的view属性并且为nil, 这时候就会调用loadView()方法了
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["基础视图","混合地图","卫星地图"])
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false // 兼容老系统的布局方式, 在引入自动布局之前, iOS应用使用autoresizing masks 在运行时动态拉伸视图布局
        
        view.addSubview(segmentedControl)
        
        // 使用constraint来建立约束
        
        
        //这种方法会让组件显示在状态栏上面
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor) // 设置约束和父视图上边距离锚点相同
        
        //修复在状态栏上显示
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8)
        
        //let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)// 设置左边的约束和父视图对齐
        //let trailingContraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor) //设置右边的约束和父视图对齐
        
        let margins = view.layoutMarginsGuide
        //设置边距
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingContraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        //激活约束
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingContraint.isActive = true
        
        //通过代码来实现事件
        // 老版本"mapTypeChanged:" 会运行报错
        //action: #selector(MapkitController.mapTypeChanged(segControl:)) 这样写是没有问题的
        segmentedControl.addTarget(self, action:#selector(MapkitController.mapTypeChanged(segControl:)), for: .valueChanged) // 运行报错
    }
    
    ///切换地图显示模式
    @objc func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("地图视图加载完成")
    }
}
