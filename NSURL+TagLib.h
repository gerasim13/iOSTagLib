//
//  NSURL+TagLib.h
//  Loopseque Twins
//
//  Created by Павел Литвиненко on 25.09.14.
//  Copyright (c) 2014 Casual Underground. All rights reserved.
//

//_______________________________________________________________________________________________________________

#import <Foundation/Foundation.h>

//_______________________________________________________________________________________________________________

@interface NSURL (TagLib)

@property (nonatomic, assign) UIImage  *artwork;
@property (nonatomic, assign) NSString *trackTitle;
@property (nonatomic, assign) NSString *artistName;
@property (nonatomic, readonly) NSUInteger trackLength;
@end

//_______________________________________________________________________________________________________________
