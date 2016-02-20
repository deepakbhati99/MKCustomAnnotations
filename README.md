# MKCustomAnnotations
customAnotaion on mkmap view with path joining two coordinates., setting region of annotations


#Creating Path
//cordinates is the array of CLLocation you want to join

    {
        MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
        [INMapView addOverlay:polyLine];
    }

#Creating Circle around my annotations

    {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(26.28, 73.02) radius:20];
        [INMapView addOverlay:circle];
    }


#Creating View accordingly

    -(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
     
        if ([overlay isKindOfClass:[MKPolyline class]]) {
          
          MKPolylineRenderer *polylineView = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
         polylineView.strokeColor = [[UIColor orangeColor]colorWithAlphaComponent:0.5];
          polylineView.lineWidth = 3.0;
          
          return polylineView;
          
      }else{
          
          MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithCircle:overlay];
          circleView.strokeColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
          circleView.lineWidth= 2.0;
          circleView.fillColor = [[UIColor orangeColor]colorWithAlphaComponent:0.5];
          
          
          return circleView;
      }
     }
