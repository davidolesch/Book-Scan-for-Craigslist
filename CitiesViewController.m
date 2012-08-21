//
//  CitiesViewController.m
//  Book-Scan
//
//  Created by David on 6/17/12.
//

#import "CitiesViewController.h"

@interface CitiesViewController ()

@end

@implementation CitiesViewController

@synthesize cities, craigslistForm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentForm:(CraigslistFormViewController *)parentForm
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        cities = [NSMutableArray arrayWithObjects:
                                                   [NSArray arrayWithObjects:@"Alabama", @"Auburn, AL" ,@"Birmingham, AL" ,@"Dothan, AL" ,@"Florence, AL" ,@"Gadsden, AL" ,@"Huntsville, AL" ,@"Mobile, AL" ,@"Montgomery, AL" ,@"Tuscaloosa, AL", nil],
                  [NSArray arrayWithObjects:@"Alaska", @"Anchorage, AK" ,@"Fairbanks, AK" ,@"Kenai Peninsula, AK" ,@"Southeast AK", nil],
                  [NSArray arrayWithObjects:@"Arizona", @"Flagstaff, AZ" ,@"Mohave County, AZ" ,@"Phoenix, AZ" ,@"Prescott, AZ" ,@"Show Low, AZ" ,@"Sierra Vista, AZ" ,@"Tucson, AZ" ,@"Yuma, AZ", nil],
                  [NSArray arrayWithObjects:@"Arkansas", @"Fayettevillem, AR" ,@"Fort Smith, AR" ,@"Jonesboro, AR" ,@"Little Rock, AR" ,@"Texarkana, AR", nil],
                  [NSArray arrayWithObjects:@"California", @"Bakersfield, CA" ,@"Chico, CA" ,@"Fresno, CA" ,@"Gold Country, CA" ,@"Hanford, CA" ,@"Humboldt County, CA" ,@"Imperial County, CA" ,@"Inland Empire, CA" ,@"Los Angeles, CA" ,@"Mendocino County, CA" ,@"Merced, CA" ,@"Modesto, CA" ,@"Monterey Bay, CA" ,@"Orange County, CA" ,@"Palm Springs, CA" ,@"Redding, CA" ,@"Sacramento, CA" ,@"San Diego, CA" ,@"San Francisco, CA" ,@"San Luis Obispo, CA" ,@"Santa Barbara, CA" ,@"Santa Maria, CA" ,@"Siskiyou County, CA" ,@"Stockton, CA" ,@"Susanville, CA" ,@"Ventura County, CA" ,@"Visalia, CA" ,@"Yuba, CA", nil],
                  [NSArray arrayWithObjects:@"Colorado", @"Boulder, CO" ,@"Colorado Spings, CO" ,@"Denver, CO" ,@"Eastern CO" ,@"Fort Collins, CO" ,@"High Rockies, CO" ,@"Pueblo, CO" ,@"Western Slope, CO", nil],
                  [NSArray arrayWithObjects:@"Connecticut", @"Eastern CT" ,@"Hartford, CT" ,@"New Haven, CT" ,@"Northwest CT", nil],
                  [NSArray arrayWithObjects:@"Deleware", @"Dover DE", nil],
                  [NSArray arrayWithObjects:@"District of Columbia",@"Washington, DC", nil],
                  [NSArray arrayWithObjects:@"Florida", @"Daytona Beach, FL" ,@"Florida Keys, FL" ,@"Fort Lauderdale, FL" ,@"Ft. Myers, FL" ,@"Gainesville, FL" ,@"Heartland FL" ,@"Jacksonville, FL" ,@"Lakeland, FL" ,@"North Central FL" ,@"Ocala, FL" ,@"Okaloosa, FL" ,@"Orlando, FL" ,@"Panama City, FL" ,@"Pensacola, FL" ,@"Sarasota, FL" ,@"Southern FL" ,@"Space Coast FL" ,@"St. Augustine, FL" ,@"Tallahassee, FL" ,@"Tampa Bay, FL" ,@"Treasure Coast FL" ,@"West Palm Beach, FL", nil],
                  [NSArray arrayWithObjects:@"Georgia", @"Albany, GA" ,@"Athens, GA" ,@"Atlanta, GA" ,@"Augusta, GA" ,@"Brunswick, GA" ,@"Columbus, GA" ,@"Macon, GA" ,@"Northwest GA" ,@"Savannah, GA" ,@"Statesboro, GA" ,@"Valdosta, GA", nil],
                  [NSArray arrayWithObjects:@"Hawaii", @"Hawaii, HI", nil],
                  [NSArray arrayWithObjects:@"Idaho", @"Boise, ID" ,@"East ID" ,@"Lewiston, ID" ,@"Twin Falls, ID", nil],
                  [NSArray arrayWithObjects:@"Illinois", @"Bloomington, IL" ,@"Champaign Urbana, IL" ,@"Chicago, IL" ,@"Decatur, IL" ,@"La Salle Co, IL" ,@"Mattoon, IL" ,@"Peoria, IL" ,@"Rockford, IL" ,@"Southern IL" ,@"Springfield, IL" ,@"Western IL", nil],
                  [NSArray arrayWithObjects:@"Indiana", @"Bloomington, IN" ,@"Evansville, IN" ,@"Fort Wayne, IN" ,@"Indianapolis, IN" ,@"Kokomo, IN" ,@"Lafayette, IN" ,@"Muncie, IN" ,@"Richmond, IN" ,@"Southern Bend, IN" ,@"Terre Haute, IN", nil],
                  [NSArray arrayWithObjects:@"Iowa", @"Ames, IA" ,@"Cedar Rapids, IA" ,@"Des Moines, IA" ,@"Dubuque, IA" ,@"Fort Dodge, IA" ,@"Iowa City, IA" ,@"Mason City, IA" ,@"Quad Cities, IA" ,@"Sioux City, IA" ,@"Southeast IA" ,@"Waterloo, IA", nil],
                  [NSArray arrayWithObjects:@"Kansas", @"Lawrence, KS" ,@"Manhattan, KS" ,@"Northwest KS" ,@"Salina, KS" ,@"Southeast KS" ,@"Southwest KS" ,@"Topeka, KS" ,@"Wichita, KS", nil],
                  [NSArray arrayWithObjects:@"Kentucky"@"Bowling Green, KY" ,@"Eastern KY" ,@"Lexington, KY" ,@"Louisville, KY" ,@"Owensboro, KY" ,@"Western KY", nil],
                  [NSArray arrayWithObjects:@"Louisiana",@"Baton Rouge, LA" ,@"Central LA" ,@"Houma, LA" ,@"Lafayette, LA" ,@"Lake Charles, LA" ,@"Monroe, LA" ,@"New Oreans, LA" ,@"Shreveport, LA", nil],
                  [NSArray arrayWithObjects:@"Maine", @"Augusta, ME", nil],
                  [NSArray arrayWithObjects:@"Maryland", @"Annapolis, MD" ,@"Baltimore, MD" ,@"Eastern Shore, MD" ,@"Fredrick, MD" ,@"Southern MD" ,@"Western MD", nil],
                  [NSArray arrayWithObjects:@"Massachusetts", @"Boston, MA" ,@"Cape Cod, MA" ,@"Southern Coast, MA" ,@"Western MA" ,@"Central MA", nil],
                  [NSArray arrayWithObjects:@"Michigan", @"Ann Arbor, MI" ,@"Battle Creek, MI" ,@"Central MI" ,@"Detroit, MI" ,@"Flint, MI" ,@"Grand Rapids, MI" ,@"Holland, MI" ,@"Jackson, MI" ,@"Kalamazoo, MI" ,@"Lansing, MI" ,@"Monroe, MI" ,@"Muskegon, MI" ,@"Northern MI" ,@"Port Huron, MI" ,@"Saginaw, MI" ,@"Southern MI" ,@"The thumb, MI" ,@"Upper Peninsula, MI", nil],
                  [NSArray arrayWithObjects:@"Minnesota", @"Bemidji, MN" ,@"Brainerd, MN" ,@"Duluth, MN" ,@"Mankato, MN" ,@"Minneapolis, MN" ,@"Rochester, MN" ,@"Southern MN" ,@"St. Cloud, MN", nil],
                  [NSArray arrayWithObjects:@"Mississippi", @"Gulfport, MS" ,@"Hattiesburg, MS" ,@"Jackson, MS" ,@"Meridian, MS" ,@"Northern MS" ,@"Southwestern MS", nil],
                  [NSArray arrayWithObjects:@"Missouri", @"Columbia, MO" ,@"Joplin, MO" ,@"Kansas City, MO" ,@"Kirksville, MO" ,@"Lake of the Ozarks, MO" ,@"Southeastern, MO" ,@"Springfield, MO" ,@"St. Joseph, MO" ,@"St. Louis, MO", nil],
                  [NSArray arrayWithObjects:@"Montana", @"Billings, MT" ,@"Bozeman, MT" ,@"Butte, MT" ,@"Great Falls, MT" ,@"Helena, MT" ,@"Kalispell, MT" ,@"Missoula, MT", nil],
                  [NSArray arrayWithObjects:@"Nebraska", @"Grand Island, NE" ,@"Lincoln, NE" ,@"North Platte, NE" ,@"Omaha, NE" ,@"Scottsbluff, NE", nil],
                  [NSArray arrayWithObjects:@"Nevada", @"Elko, NV" ,@"Las Vegas, NV" ,@"Reno, NV", nil],
                  [NSArray arrayWithObjects:@"New Hampshire", @"Concord, NH", nil],
                  [NSArray arrayWithObjects:@"New Jersey", @"Central NJ" ,@"Jersey Shore, NJ" ,@"Northern NJ" ,@"Southern NJ", nil],
                  [NSArray arrayWithObjects:@"New Mexico", @"Albuquerque, NM" ,@"Clovis, NM" ,@"Farmington, NM" ,@"Las Cruces, NM" ,@"Roswell, NM" ,@"Santa Fe, NM", nil],
                  [NSArray arrayWithObjects:@"New York", @"Albany, NY" ,@"Binghamton, NY" ,@"Buffalo, NY" ,@"Catskills, NY" ,@"Chatauqua, NY" ,@"Elmira, NY" ,@"Finger Lakes, NY" ,@"Glens Falls, NY" ,@"Hudson Valley, NY" ,@"Ithaca, NY" ,@"Long Island, NY" ,@"New York City, NY" ,@"Oneonta, NY" ,@"Plattsburgh, NY" ,@"Potsdam, NY" ,@"Rochester, NY" ,@"Syracuse, NY" ,@"Twin Tiers NY" ,@"Utica, NY" ,@"Watertown, NY", nil],
                  [NSArray arrayWithObjects:@"North Carolina", @"Ashville, NC" ,@"Boone, NC" ,@"Charlotte, NC" ,@"Eastern NC" ,@"Fayetteville, NC" ,@"Greensboro, NC" ,@"Hickory, NC" ,@"Jacksonville, NC" ,@"Outer Banks, NC" ,@"Raleigh, NC" ,@"Wilmington, NC" ,@"Winston, NC", nil],
                  [NSArray arrayWithObjects:@"North Dakota", @"Bismarck, ND" ,@"Fargo, ND" ,@"Grand Forks, ND" ,@"North Dakota, ND", nil],
                  [NSArray arrayWithObjects:@"Ohio", @"Akron, OH" ,@"Ashtabula, OH" ,@"Athens, OH" ,@"Chillicothe" ,@"Cincinnati, OH" ,@"Cleveland, OH" ,@"Columbus, OH" ,@"Dayton, OH" ,@"Lima, OH" ,@"Mansfield, OH" ,@"Sandusky, OH" ,@"Toledo, OH" ,@"Tuscarawas Co, OH" ,@"Youngstown, OH" ,@"Zanesville, OH", nil],
                  [NSArray arrayWithObjects:@"Oklahoma", @"Lawton, OK" ,@"Northwest OK" ,@"Oklahoma City, OK" ,@"Stillwater, OK" ,@"Tulsa, OK", nil],
                  [NSArray arrayWithObjects:@"Oregon", @"Bend, OR" ,@"Corvallis, OR" ,@"East OR" ,@"Eugene, OR" ,@"Klamath Falls, OR" ,@"Medford, OR" ,@"OR Coast" ,@"Portland, OR" ,@"Roseburg, OR" ,@"Salem, OR", nil],
                  [NSArray arrayWithObjects:@"Pennsylvania", @"Altoona, PA" ,@"Cumberland Valley, PA" ,@"Erie, PA" ,@"Harrisburg, PA" ,@"Lancaster, PA" ,@"Lehigh Valley, PA" ,@"Meadville, PA" ,@"Philadelphia, PA" ,@"Pittsburgh, PA" ,@"Poconos, PA" ,@"Reading, PA" ,@"Scranton, PA" ,@"State College, PA" ,@"Williamsport, PA" ,@"York, PA", nil],
                  [NSArray arrayWithObjects:@"Rhode Island", @"Providence, RI", nil],
                  [NSArray arrayWithObjects:@"South Carolina", @"Charleston, SC" ,@"Columbia, SC" ,@"Florence, SC" ,@"Greenville, SC" ,@"Hilton Head, SC" ,@"Myrtle Beach, SC", nil],
                  [NSArray arrayWithObjects:@"South Dakota", @"Northeast SD" ,@"Pierre, SD" ,@"Rapid City, SD" ,@"Sioux Falls, SD", nil],
                  [NSArray arrayWithObjects:@"Tennessee", @"Chattanooga, TN", @"Clarksville, TN", @"Cookeville, TN", @"Jackson, TN", @"Knoxville, TN", @"Memphis, TN", @"Nashville, TN", @"Tri-cities, TN", nil],
                   [NSArray arrayWithObjects:@"Texas", @"Abilene, TX" ,@"Amarillo, TX" ,@"Austin, TX" ,@"Beaumont, TX" ,@"Brownsville, TX" ,@"College Station, TX" ,@"Corpus Christi, TX" ,@"DFW, TX" ,@"Deep East TX" ,@"Del Rio, TX" ,@"El Paso, TX" ,@"Galveston, TX" ,@"Houston, TX" ,@"Killeen, TX" ,@"Laredo, TX" ,@"Lubbock, TX" ,@"Mcallen, TX " ,@"Odessa, TX" ,@"San Angelo, TX" ,@"San Antonio, TX" ,@"San Marcos, TX" ,@"Southwest TX" ,@"Texoma, TX" ,@"Tyler, TX" ,@"Victoria, TX" ,@"Waco, TX" ,@"Wichita Falls, TX", nil],
                   [NSArray arrayWithObjects:@"Utah", @"Logan, UT" ,@"Ogden, UT" ,@"Provo, UT" ,@"Salt Lake City, UT" ,@"St. George, UT", nil],
                   [NSArray arrayWithObjects:@"Vermont", @"Montpelier, VT", nil],
                   [NSArray arrayWithObjects:@"Virginia", @"Charlottesville, VA" ,@"Danville, VA" ,@"Fredericksburg, VA" ,@"Hampton Roads, VA" ,@"Harrisonburg, VA" ,@"Lynchburg, VA" ,@"New River Valley, VA" ,@"Richmond, VA" ,@"Roanoke, VA" ,@"Southwest VA" ,@"Winchester, VA", nil],
                   [NSArray arrayWithObjects:@"Washington", @"Bellingham, WA" ,@"Kennewick, WA" ,@"Moses Lake, WA" ,@"Olympic Peninsula, WA" ,@"Pullman, WA" ,@"Seattle, WA" ,@"Skagit, WA" ,@"Spokane, WA" ,@"Wenachee, WA" ,@"Yakima, WA", nil],
                   [NSArray arrayWithObjects:@"Wet Virginia", @"Charleston, WV" ,@"Eastern Panhandle, WV" ,@"Huntington, WV" ,@"Morgantown, WV" ,@"Northern Panhandle, WV" ,@"Parkersburg, WV" ,@"Southern WV", nil],
                   [NSArray arrayWithObjects:@"Wisconsin", @"Appleton, WI" ,@"Wau Claire, WI" ,@"Green Bay, WI" ,@"Janesville, WI" ,@"Kenosha, WI" ,@"La Crosse, WI" ,@"Madison, WI" ,@"Millwaukee, WI" ,@"Northern WI" ,@"Sheboygan, WI" ,@"Wausau, WI", nil],
                   [NSArray arrayWithObjects:@"Wyoming", @"Cheyenne, WY", nil],
                    nil];
        craigslistForm = parentForm;
        int k = 0;
        for (NSArray *state in cities) {
            int kk = 0 - 1;
            for (NSString *city in state) {
                if ([city isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"Book-ScanCityNamePrefKey"]]) {
                    [self.craigslistForm setCityIndex:[NSIndexPath indexPathForRow:kk inSection:k]];
                }
                kk++;
            }
            k++;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.tableView scrollToRowAtIndexPath:[self.craigslistForm cityIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [cities count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[cities objectAtIndex:section] count] - 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[cities objectAtIndex:section] objectAtIndex:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[[cities objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]+1]];
    if ([indexPath isEqual:[self.craigslistForm cityIndex]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [NSArray arrayWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"DC",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VT",@"VA",@"WA",@"WV",@"WI",@"WY",nil];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[[[craigslistForm tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] detailTextLabel] setText:[[[self.tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
    [self.craigslistForm setCityIndex:indexPath];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setValue:[[[self.tableView cellForRowAtIndexPath:indexPath] textLabel] text] forKey:@"Book-ScanCityNamePrefKey"];
}

@end
