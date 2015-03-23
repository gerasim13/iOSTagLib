//
//  TagLib+AIFFCoverArt.h
//  Loopseque Twins
//
//  Created by Павел Литвиненко on 23.10.14.
//  Copyright (c) 2014 Casual Underground. All rights reserved.
//

//_______________________________________________________________________________________________________________

#ifndef __Loopseque_Twins__TagLib_CoverArt__
#define __Loopseque_Twins__TagLib_CoverArt__

//_______________________________________________________________________________________________________________

#include <CoreFoundation/CoreFoundation.h>

//_______________________________________________________________________________________________________________

CF_EXTERN_C_BEGIN

//_______________________________________________________________________________________________________________

Boolean CopyCoverArtDataFromFileAtPath(CFStringRef path, CFDataRef *data);
Boolean SetCoverArtDataToFileAtPath (CFStringRef path, CFDataRef  data);

//_______________________________________________________________________________________________________________

CF_EXTERN_C_END

//_______________________________________________________________________________________________________________

#endif /* defined(__Loopseque_Twins__TagLib_AIFFCoverArt__) */

//_______________________________________________________________________________________________________________