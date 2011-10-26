//
//  IJobsWorkListItem.h
//  iJobs
//
//  Created by Daniel Kao on 2011/10/26.
//  Copyright (c) 2011年 NCCUCS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IJobsWorkListItem : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * missionTitle;
@property (nonatomic, retain) NSString * missionDetail;
@property (nonatomic, retain) NSString * customerID;
@property (nonatomic, retain) NSString * customerName;
@property (nonatomic, retain) NSString * workerID;
@property (nonatomic, retain) NSString * workerName;
@property (nonatomic, retain) NSString * missionDate;
@property (nonatomic, retain) NSString * missionLocationAddress;
@property (nonatomic, retain) NSString * missionLocation;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSData * clientSignatureImageData;
@property (nonatomic) Boolean isWorkDone;

/*initWithTitle:@"會見政大老闆" Detail:@"洽談政大資訊教室電腦裝配外包事宜" Location:@"國立政治大學" address:@"台北市文山區指南路2段64號" date:@"2012/10/03 15:00" workerName:@"王小華" workerID:@"w11111" customerName:@"吳濕華" customerID:@"c11111"*/
/*
- (id)initWithTitle:(NSString *)missionTitle detail:(NSString *)missionDetail location:(NSString *)missionLocation locationAddress:(NSString *)missionLocationAddreee date:(NSString *)dateString workerName:(NSString *)workerName workerID:(NSString *)workerID customerName:(NSString *)customerName customerID:(NSString *)customerID;

- (void)setclientSignatureImageData:(UIImage *)signatureImage;
*/
@end
