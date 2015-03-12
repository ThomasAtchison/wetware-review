//
//  BiologicalPart.m
//  BioBrick Studio
//
//  Created by Cesar Rodriguez on 2/19/09.
//  Copyright 2009 Stanford University. All rights reserved.
//

#import "BiologicalPart.h"


@implementation BiologicalPart

@synthesize		identifier;
@synthesize		type;
@synthesize		size;
@synthesize		shortDescription;

- (id)init
{
	if(self = [super init])
	{
		identifier = @"";
		type = @"";
		size = 0;
		shortDescription = @"";
		longDescription = @"";
		sequence = @"";
		_isDNASequenceValid = NO;
	}
	
	return self;
}

- (id)initWithAttributes:(NSDictionary *)attributes
{
	if(self = [super init])
	{
		if(attributes)
		{
			[self setIdentifier:[attributes objectForKey:@"identifier"]];
			[self setType:[attributes objectForKey:@"type"]];
			[self setSize:[attributes objectForKey:@"size"]];
			[self setShortDescription:[attributes objectForKey:@"shortDescription"]];
			[self setLongDescription:[attributes objectForKey:@"longDescription"]];
			[self setSequence:[attributes objectForKey:@"sequence"]];
			_isDNASequenceValid = [[attributes objectForKey:@"isDNASequenceValid"] boolValue];
		}
		else
		{
			//@throw
		}
	}
	
	return self;
}

- (NSString*)longDescription
{
	return [longDescription copy];
}

- (void)setLongDescription:(NSString*)description
{
	NSString *modifiedString;
	
	modifiedString = [description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"/n" withString:@" "];
	longDescription = [modifiedString retain];
}

- (NSString *)sequence
{
	return [sequence copy];
}

- (void)setSequence:(NSString *)aSequence
{	
	NSString	*modifiedString;
	
	if(aSequence && [aSequence length] > 0)
	{
		//Verify that the incoming sequence is the correct size
		modifiedString = [aSequence stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"/n" withString:@""];
		modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
		modifiedString = [modifiedString uppercaseString];
		
		if([modifiedString length] == [size intValue])
		{
			sequence = [modifiedString retain];
			_isDNASequenceValid = YES;
		}
		else
		{
			_isDNASequenceValid = NO;
		}
	}
}

- (BOOL)isDNASequenceValid
{
	return _isDNASequenceValid;
}

- (NSDictionary *)attributes
{
	NSMutableDictionary		*dictionary;
	
	dictionary = [NSMutableDictionary dictionaryWithCapacity:7];
	[dictionary setObject:identifier forKey:@"identifier"];
	[dictionary setObject:type forKey:@"type"];
	[dictionary setObject:size forKey:@"size"];
	[dictionary setObject:shortDescription forKey:@"shortDescription"];
	[dictionary setObject:longDescription forKey:@"longDescription"];
	[dictionary setObject:sequence forKey:@"sequence"];
	[dictionary setObject:[NSNumber numberWithBool:_isDNASequenceValid] forKey:@"isDNASequenceValid"];
	
	return dictionary;
}

@end

