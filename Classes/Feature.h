//
//  Feature.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 3/18/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Feature : NSObject 
{
	NSString*	featureID;
	NSString*	label;
	NSString*	typeID;
	NSString*	typeCategory;
	NSString*	partID;
	NSNumber*	start;
	NSNumber*	end;
	NSString*	phase;
	NSString*	note;
}

@property(readwrite, copy) NSString* featureID;
@property(readwrite, copy) NSString* label;
@property(readwrite, copy) NSString* typeID;
@property(readwrite, copy) NSString* typeCategory;
@property(readwrite, copy) NSString* partID;
@property(readwrite, copy) NSNumber* start;
@property(readwrite, copy) NSNumber* end;
@property(readwrite, copy) NSString* phase;
@property(readwrite, copy) NSString* note;

@end
