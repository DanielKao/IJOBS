//
//  iJobsAtLas.h
//  iJobs
//
//  Created by Daniel Kao on 2011/9/21.
//  Copyright 2011年 NCCUCS. All rights reserved.
//

#define kRootPath @"tt://root/"
#define kWorkListPath @"tt://workList/"
#define kWorkDetailPath @"tt://workDetail/"
#define kWorkDetailPathWithParameter @"tt://workDetail/(displayWorkDetailWithParameter:)/"
#define kWorkDetailPathWithParameterNumber @"tt://workDetail/%i/"
#define kMapPath @"tt://map/"
#define kCameraPath @"tt://camera/"


// const for passing workItem as parameter
#define kParameterWorkItem @"parameterWorkItem"

// iJobs APP API
//fieldworker.heroku.com

#define kLoginAPI @"http://fieldworker.heroku.com/iphone-signin"
#define kLogoutAPI @"http://fieldworker.heroku.com/signout"
#define kWorkListAPI @"http://fieldworker.heroku.com/microposts.json"
#define kUploadSignatureImageAPI @"http://fieldworker.heroku.com/uploadSignatureImage"
#define kUploadSituationImageAndDetailAPI @"http://fieldworker.heroku.com/uploadSituationImage"



//#define kLoginAPI @"http://localhost:3000/iphone-signin"
//#define kLogoutAPI @"http://localhost:3000/signout"
//#define kWorkListAPI @"http://localhost:3000/microposts.json"
//#define kUploadSignatureImageAPI @"http://localhost:3000/uploadSignatureImage"
//#define kUploadSituationImageAndDetailAPI @"http://localhost:3000/uploadSituationImage"

// notification name for login
#define kLoginNotification @"loginNotification"

// HTML for streetView
#define STREET_VIEW_HTML @"<html><head><meta name='viewport' content='width=320,user-scalable=no'/><script src='http://maps.google.com/maps/api/js?sensor=false' type='text/javascript'></script></head><body onload=\"new google.maps.StreetViewPanorama(document.getElementById('p'),{position:new google.maps.LatLng(%f, %f)});\" style='padding:0px;margin:0px;'><div id='p' style='height:100%%;width:100%%;'></div></body></html>"