//
//  MovieTheaterViewController.swift
//  TMDBProject
//
//  Created by 송황호 on 2022/08/11.
//

import CoreLocation
import MapKit
import UIKit


class MovieTheaterViewController: BaseViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    // Location2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        setRegionAndAnnotation()
    }
    
    func setRegionAndAnnotation() {
        let center = CLLocationCoordinate2D(latitude: 37.533910, longitude: 126.900574)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "인생 곱창집!!"
        mapView.addAnnotation(annotation)
    }
    
}
// CLLocationManagerDelegate
extension MovieTheaterViewController: CLLocationManagerDelegate {
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        <#code#>
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        <#code#>
    }
}

//
//// 위치 관련된 USer Defined 메서드
//extension MovieTheaterViewController {
//
//    func checkUserDeviceLocationServiceAuthorization() {
//        let authorizationStatus: CLAuthorizationStatus
//        print(#function)
//        if #available(iOS 14.0, *) {
//            // 프로퍼티를 통해 locationManager가 가지고 있는 상태를 가져옴
//            authorizationStatus = locationManager.authorizationStatus
//        } else {
//            authorizationStatus = CLLocationManager.authorizationStatus()
//        }
//
//        // iOS 위치 서비스 활성화 여부 체크: locationServicesEnabled()
//        if CLLocationManager.locationServicesEnabled() {
//            // 위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
//            checkUSerCurrentLocationAuthorization(authorizationStatus)
//        } else {
//            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
//
//        }
//    }
//
//    // Location8. 사용자의 위치 권한 상태 확인
//    // 사용자가 위치를 혀용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인 (단, 사전에 iOS 위치 서비스 활성화 꼭 확인)
//    func checkUSerCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
//        switch authorizationStatus {
//        case .notDetermined:
//            print("NOTDETERMINED")
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한을 요청
//            //plist WhenInUse -> request 메서드 OK
//            locationManager.startUpdatingLocation()
//
//        case .restricted, .denied:
//            print("DENIED, 아이폰 설정으로 유도")
//
//        case .authorizedWhenInUse:
//            print("WHEN IN USE")
//            // 사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
//            locationManager.startUpdatingLocation()
//        default:
//            print("DEFAULT")
//        }
//    }
//}
//
//extension MovieTheaterViewController: CLLocationManagerDelegate {
//    // Location5. 사용자의 위치를 성공적으로 가지고 온 경우
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if let coordinate = locations.last?.coordinate {
//            setRegionAndAnnotation()
//        }
//
////        locationManager.stopUpdatingLocation()
//    }
//
//    // Location6. 사용자의 위치를 가지고오지 못한 경우
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(#function)
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        print(#function)
//        checkUserDeviceLocationServiceAuthorization()
//    }
//    // iOS 14 미만
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//    }
//}
