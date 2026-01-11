[myuplink.com/documentation](http://myuplink.com/documentation)

<Introduction>

-   Documentation
-   Intro

The myUplink API is a [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) api, relying on established conventions from the [HTTP specification](https://tools.ietf.org/html/rfc2616). As an example, the API relies on the client to use HTTP methods such as GET, POST, PUT, DELETE to describe the action to perform on a resource and it indicates the success or failure of that action by returning a HTTP status code.

All access is over HTTPS, and is provided over the api.myuplink.com domain.

<Quick Start Guide>

-   Documentation
-   Intro
-   Quick Start Guide

This example is the quickest way to use or consume the API using the APIs already existing user interface, the swagger page. No external equipment or software is needed. This guide is written in a non-technical, step-by-step way so that anyone can get started. No previous programming skills required.

### Prerequisites:

-   A free myUplink account. Create an account, or use an existing myUplink account, and log in, which you can do here: [api.myuplink.com](https://dev.myuplink.com/)
-   You can only get data from your own equipment. Please ensure that the account used has active devices. Log in at [myUplink](https://dev.myuplink.com/) to verify.

### First request to the API

Ok, let's get started!

-   Create an app.
    -   Go to [Apps](https://dev.myuplink.com/apps) and create an app described in the documentation on [Authentication](https://dev.myuplink.com/documentation/auth?activeTab=auth) under "Client Registration".
    -   Client Identity and Client Secret is used in the next step.
-   Request a token.
    -   Go to [Swagger](https://api.myuplink.com/swagger/index.html) and click the green "Authorize" button.
    -   Enter Client Identity and Client Secret in their respective fields.
-   Close the form.
    -   Click Authorize and then Close button. The padlock icons to the right should now resemble locked padlocks
-   Send first request
    -   Scroll down to the Systems header and the endpoint GET /v2/systems/me
    -   Click the blue header area to open this endpoint.
    -   Click the black "Try it out" button to the right.
    -   Click the blue "Execute" bar. The three input fields can be left default.

#### First request response

Ok, let's see the status of the response!

-   If the request (asking the api to respond) is successful, the response code is 200 and the data is displayed in the Response body.
-   In the Response body, under "systems" associated systems data is displayed and can be downloaded to a json file or copied to the clipboard using the icons to the right.

### Used terms

#### Systems

The system object describes the entire installed and connected equipment in a specific building.

#### Devices

The device object describes a specific piece of equipment in a system. For example, a heat pump.

### Further requests

The system's id and device's id data retrieved from the initial request can be used in further requests. Omit the parentheses characters at the start and end of the value when pasting the values.

#### System endpoints examples

System details. The endpoint: GET /v2/systems/{systemId}/smart-home-mode uses a specific system id and returns the smart home mode for that system.

#### Device endpoints example

Device details. The endpoint: GET /v2/devices/{systemId} uses a specific device id and returns more detailed data on that specific device.

Outside temperature. The endpoint: GET /v2/devices/{deviceId}/points can return, for example, data on outside temperature.

### Further references

This quick start guide is the bare minimum instructions to get started.

For more details on the various topics involved the below topics might be a starting point.

#### REST APIs (myUplink Public API is a REST API)

[Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer)

#### JSON

[JSON](https://en.wikipedia.org/wiki/JSON)

#### HTTP Headers

[List of HTTP Header Fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields)

#### The myUplink documentation herein

[Introduction](https://dev.myuplink.com/intro)

<Data Format\>

-   Documentation
-   Intro
-   Data Format

All data is sent and received as [JSON](https://en.wikipedia.org/wiki/JSON). The client needs to specify the Content-Type and Accept headers as either application/json or text/json.

Blank fields are included as null instead of being omitted. All timestamps are returned with the ISO-8601 format (YYYY-MM-DDTHH:MM:SSZ) in UTC.

<Parameters\>

-   Documentation
-   Intro
-   Parameters

API functions have both required and optional parameters. For GET requests, parameters not specified in the request URL, no matter if they are required or optional, should be provided as query parameters.

For POST, PUT and DELETE requests, the same parameters should be provided as JSON in the request body.

* * *

#### Parameter example

The following API functions has one parameter specified in the request URL (systemId and type), and a couple of required and optional parameters which are not (type, active, page and itemsPerPage)

GET /v2/systems/{systemId}/notifications

And can therefore be called either with only the mandatory parameters or with any of the optional parameters

GET /v2/systems/435/notifications
GET /v2/systems/435/notifications?page=1&itemsPerPage=2

<Error Messages>

-   Documentation
-   Intro
-   Error Messages

The myUplink API uses HTTP response codes, as defined in the HTTP specification, to indicate the success or failure of a request. In general, response codes in the 2xx range indicate success, 4xx range indicate an error that resulted from the provided information (e.g. lack of access to resource, missing required parameter) and response codes in the 5xx range indicate an error with the myUplink servers.

All non-successful response messages contain an error message object to help troubleshoot the issue on the client side. For OAuth authorization and token requests this response message follows the convention specified in the [OAuth 2 specification](https://tools.ietf.org/html/rfc6749). Other requests responds with a JSON object with the following parameters.



<HTTP Redirects\>

-   Documentation
-   Intro
-   Http Redirects

Where appropriate, the API may use HTTP redirects. Clients should assume that any request may result in a redirection within the api.myuplink.com domain. Receiving a redirection does not imply that an error has occurred.



<Pagination\>

-   Documentation
-   Intro
-   Pagination

Functions that return multiple items are paginated. In the case of pagination the function reference documentation specifies which default values are used and how to access further pages.

<Rate Limiting and Client Abuse\>

-   Documentation
-   Intro
-   Rate Limiting Client Abuse

The myUplink API is rate limited. All requests reaching the myUplink API is counted and when the limit has been reached the following requests will get an error message with the HTTP status code 429 in return. The current limit for public API clients is 25 requests per minute. These limits can be be adjusted at any time without notice if deemed necessary.

If an application or client is found abusing the API in any way, myUpTech AB has the right to block it until the client owner has solved the issues highlighted by myUplink.

<Language\>

-   Documentation
-   Intro
-   Language

User facing strings provided by the API can be automatically translated to any of the languages supported by myUplink. This is achieved by specifying the Accept-Language HTTP header as specified in the [RFC 2616](https://tools.ietf.org/html/rfc2616#page-104) specification. The following languages are supported by the API:



<Versioning\>

-   Documentation
-   Intro
-   Versioning

All functionality within this version of the API are accessed with the URI prefix api/v2/\*.

Revisions to this API can be divided into major and minor revisions. The major revision is increased when there are breaking changes which makes the API not backwards-compatible, these changes are published with a different URI prefix than the current version. Minor revisions are smaller changes that do not interfere with the current version. These minor revisions are published with the same URI prefix as the current version and thereby replacing the current version.

The following changes are considered backwards-compatible:

-   Adding additional API resources / functions
-   Adding new optional request parameters to API functions
-   Adding new properties to existing API responses
-   Adding new values to existing enumerations
-   Adding or changing rate limitations of existing API functions
-   Adding additional supported languages
-   Changing the default value of optional parameters that do not change the overall behaviour of the function, e.g.: the itemsPerPage parameter on paged function calls
-   Changing the order of properties of existing API responses
-   Changes to the terms of use
-   Changes that are related to securing the API and the myUplink service
-   Modifications to the API that solves issues where the documentation and the implementation of the API differs (i.e. "bug fixes")
-   Renaming of functions with the use of HTTP 301 redirects to notify about the new name

Please see the change log for a complete list of updates made to the myUplink API.
