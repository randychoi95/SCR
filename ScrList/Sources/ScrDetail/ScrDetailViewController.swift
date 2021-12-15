//
//  ScrDetailViewController.swift
//  SCR
//
//  Created by 최제환 on 2021/12/01.
//

import ModernRIBs
import UIKit
import InventoryEntity
import MapKit

protocol ScrDetailPresentableListener: AnyObject {
    func detachScrDetail()
}

final class ScrDetailViewController: UIViewController, ScrDetailPresentable, ScrDetailViewControllable {
    
    weak var listener: ScrDetailPresentableListener?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let inventoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .darkGray
        label.text = "-"
        return label
    }()
    
    private let addrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .darkGray
        label.text = "-"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .darkGray
        label.text = "-"
        return label
    }()
    
    private let telLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .darkGray
        label.text = "-"
        return label
    }()
    
    private let regDtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .darkGray
        label.text = "-"
        return label
    }()
    
    private let openTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .darkGray
        label.text = "-"
        return label
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(inventoryLabel)
        stackView.addArrangedSubview(addrLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(telLabel)
        stackView.addArrangedSubview(regDtLabel)
        stackView.addArrangedSubview(openTimeLabel)
        
        view.addSubview(mapView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "chevron.backward",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            ),
            style: .plain,
            target: self,
            action: #selector(close)
        )
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            mapView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func close() {
        listener?.detachScrDetail()
    }
    
    func update(model: InventoryModel) {
        inventoryLabel.text = "재고량 : \(Formatter.priceFormatter.string(from: NSNumber(value: Int(model.inventory) ?? 0)) ?? "-")L"
        addrLabel.text = "주 소 : \(model.addr)"
        priceLabel.text = "가 격 : \(Formatter.priceFormatter.string(from: NSNumber(value: Int(model.price) ?? 0)) ?? "-")원"
        telLabel.text = "전화번호 : \(model.tel)"
        regDtLabel.text = "마지막 갱신날짜: \(model.regDt)"
        openTimeLabel.text = "영업시간 : \(model.openTime ?? "-")"
        
        title = model.name
        
        setMapView(model: model)
    }
    
    private func setMapView(model: InventoryModel) {
        if let lat = Double(model.lat), let lng = Double(model.lng) {
            // 위도와 경도를 가ㅣ고 2D(한 점) 정보
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            // 한 점에서부터 거리(m)를 반영하여 맵의 크기
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            
            // 위치 표시하기
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = location
            annotaion.title = model.name
            annotaion.subtitle = model.addr
            
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(annotaion)
        }
    }
}
