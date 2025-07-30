
const url = new URL("https://example.com?foo=1&bar=2&foo=3");
const params = new URLSearchParams(url.search);
console.log(`Query string (before):\t ${params}`);
params.delete("foo");
console.log(`Query string (after):\t ${params}`);


const url = new URL("https://example.com?foo=1&bar=2&foo=3&foo=1");
const params = new URLSearchParams(url.search);
console.log(`Query string (before):\t ${params}`);
params.delete("foo", "1");
console.log(`Query string (after):\t ${params}`);


	// 	const k = params.k;
	// 	// Remove the token from the url so it doesn't get bookmarked
	// 	delete params.sso;
	// 	delete params.k;
	// 	// Remove the token from the url so it doesn't get bookmarked
	// 	delete params.accessToken;

/*

TL;DR

    To modify current URL and add / inject it (the new modified URL) as a new URL entry to history list, use pushState:

    window.history.pushState({}, document.title, "/" + "my-new-url.html");

    To replace current URL without adding it to history entries, use replaceState:

    window.history.replaceState({}, document.title, "/" + "my-new-url.html");

    Depending on your business logic, pushState will be useful in cases such as:

        you want to support the browser's back button
        you want to create a new URL, add/insert/push the new URL to history entries, and make it current URL
        allowing users to bookmark the page with the same parameters (to show the same contents)
        to programmatically access the data through the stateObj then parse from the anchor

As I understood from your comment, you want to clean your URL without redirecting again.

Note that you cannot change the whole URL. You can just change what comes after the domain's name. This means that you cannot change www.example.com/ but you can change what comes after .com/

www.example.com/old-page-name => can become =>  www.example.com/myNewPaage20180322.php

Background

We can use:

    The pushState() method if you want to add a new modified URL to history entries.

    The replaceState() method if you want to update/replace current history entry.

        .replaceState() operates exactly like .pushState() except that .replaceState() modifies the current history entry instead of creating a new one. Note that this doesn't prevent the creation of a new entry in the global browser history.

        .replaceState() is particularly useful when you want to update the state object or URL of the current history entry in response to some user action.

Code

To do that I will use The pushState() method for this example which works similarly to the following format:

var myNewURL = "my-new-URL.php";//the new URL
window.history.pushState("object or string", "Title", "/" + myNewURL );

Feel free to replace pushState with replaceState based on your requirements.

You can substitute the paramter "object or string" with {} and "Title" with document.title so the final statment will become:

window.history.pushState({}, document.title, "/" + myNewURL );

Results

The previous two lines of code will make a URL such as:

https://domain.tld/some/randome/url/which/will/be/deleted/

To become:

https://domain.tld/my-new-url.php

Action

Now let's try a different approach. Say you need to keep the file's name. The file name comes after the last / and before the query string ?.

http://www.someDomain.com/really/long/address/keepThisLastOne.php?name=john

Will be:

http://www.someDomain.com/keepThisLastOne.php

Something like this will get it working:

 //fetch new URL
 //refineURL() gives you the freedom to alter the URL string based on your needs.
var myNewURL = refineURL();

//here you pass the new URL extension you want to appear after the domains '/'. Note that the previous identifiers or "query string" will be replaced.
window.history.pushState("object or string", "Title", "/" + myNewURL );


//Helper function to extract the URL between the last '/' and before '?'
//If URL is www.example.com/one/two/file.php?user=55 this function will return 'file.php'
 //pseudo code: edit to match your URL settings

   function refineURL()
{
    //get full URL
    var currURL= window.location.href; //get current address

    //Get the URL between what's after '/' and befor '?'
    //1- get URL after'/'
    var afterDomain= currURL.substring(currURL.lastIndexOf('/') + 1);
    //2- get the part before '?'
    var beforeQueryString= afterDomain.split("?")[0];

    return beforeQueryString;
}

UPDATE:

For one liner fans, try this out in your console/firebug and this page URL will change:

    window.history.pushState("object or string", "Title", "/"+window.location.href.substring(window.location.href.lastIndexOf('/') + 1).split("?")[0]);

This page URL will change from:

http://stackoverflow.com/questions/22753052/remove-url-parameters-without-refreshing-page/22753103#22753103

To

http://stackoverflow.com/22753103#22753103

Note: as Samuel Liew indicated in the comments below, this feature has been introduced only for HTML5.

An alternative approach would be to actually redirect your page (but you will lose the query string '?', is it still needed or the data has been processed?).

window.location.href =  window.location.href.split("?")[0]; //"http://www.newurl.com";

*/