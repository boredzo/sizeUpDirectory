#import "PRHDirectoryWeigher.h"

int main(int argc, char *argv[]) {
	@autoreleasepool {
		PRHDirectoryWeigher *weigher = [PRHDirectoryWeigher new];

		bool acceptOptions = true;
		NSEnumerator *argsEnum = [[NSProcessInfo processInfo].arguments objectEnumerator];
		[argsEnum nextObject];
		for (NSString *argument in argsEnum) {
			if (acceptOptions) {
				if ([argument isEqualToString:@"--"]) {
					acceptOptions = false;
					continue;
				} else if ([argument caseInsensitiveCompare:@"--use-reference-urls"] == NSOrderedSame) {
					weigher.yieldReferenceURLs = true;
					continue;
				} else if ([argument caseInsensitiveCompare:@"--use-path-urls"] == NSOrderedSame) {
					weigher.yieldReferenceURLs = false;
					continue;
				} else if ([argument caseInsensitiveCompare:@"--verbose"] == NSOrderedSame) {
					weigher.verbose = true;
					continue;
				}
			}

			NSString *path = argument;
			NSURL *rootURL = [NSURL fileURLWithPath:path];
			printf("%llu\t%s\n", [weigher totalSizeOfDirectoryAtURL:rootURL], [path UTF8String]);
		}
	}
	return EXIT_SUCCESS;
}
