// -------------------------------------------------------------------------------------------------------------------------------
// RestSharp
//
// https://github.com/restsharp/RestSharp/blob/dev/docs/getting-started/getting-started.md
// https://restsharp.dev/usage/exceptions.html

using RestSharp;
using RestSharp.Authenticators;

var client = new RestClient("https://api.twitter.com/1.1");
client.Authenticator = new HttpBasicAuthenticator("username", "password");

var request = new RestRequest("statuses/home_timeline.json", DataFormat.Json);

var response = client.Get(request);



using RestSharp;
using RestSharp.Authenticators;

var client = new RestClient("https://api.twitter.com/1.1");
client.Authenticator = new HttpBasicAuthenticator("username", "password");

var request = new RestRequest("statuses/home_timeline.json", DataFormat.Json);

var timeline = await client.GetAsync<HomeTimeline>(request, cancellationToken);



var request = new RestRequest("address/update").AddJsonBody(updatedAddress);
var response = await client.PostAsync<AddressUpdateResponse>(request);

