//
//  IJobsWorkListItem.m
//  iJobs
//
//  Created by Daniel Kao on 2011/10/26.
//  Copyright (c) 2011年 NCCUCS. All rights reserved.
//

#import "IJobsWorkListItem.h"


@implementation IJobsWorkListItem
@dynamic missionTitle;
@dynamic missionDetail;
@dynamic latitude;
@dynamic longitude;
@dynamic clientSignatureImageData;
@dynamic customerID;
@dynamic customerName;
@dynamic workerID;
@dynamic workerName;
@dynamic missionDate;
@dynamic missionLocationAddress;
@dynamic missionLocation;

- (id)initWithTitle:(NSString *)missionTitle detail:(NSString *)missionDetail location:(NSString *)missionLocation locationAddress:(NSString *)missionLocationAddreee date:(NSString *)dateString workerName:(NSString *)workerName workerID:(NSString *)workerID customerName:(NSString *)customerName customerID:(NSString *)customerID {

}

- (void)setclientSignatureImageData:(UIImage *)signatureImage {

}

@end
