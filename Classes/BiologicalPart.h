//
//  BiologicalPart.h
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/19/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BiologicalPart : NSObject 
{
	NSString	*identifier;
	NSString	*type;
	NSNumber	*size;
	NSString	*shortDescription;
	NSString	*longDescription;
	NSString	*sequence;
	BOOL		_isDNASequenceValid;
}

@property(readwrite, copy) NSString* identifier;
@property(readwrite, copy) NSString* type;
@property(readwrite, copy) NSNumber* size;
@property(readwrite, copy) NSString* shortDescription;
@property(readwrite, copy) NSString* longDescription;
@property(readwrite, copy) NSString* sequence;

- (id)initWithAttributes:(NSDictionary *)attributes;

- (BOOL)isDNASequenceValid;
- (NSDictionary *)attributes;

@end
