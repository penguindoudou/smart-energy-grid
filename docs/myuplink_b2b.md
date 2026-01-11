<Introduction>

-   Pro Documentation
-   Intro

The myUplink PRO API is a [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) api, relying on established conventions from the [HTTP specification](https://tools.ietf.org/html/rfc2616), meant to be used by the myUplink PRO users. As an example, the API relies on the client to use HTTP methods such as GET, POST, PUT, DELETE to describe the action to perform on a resource and it indicates the success or failure of that action by returning a HTTP status code.

All access is over HTTPS, and is provided over the api-pro.myuplink.com domain.

<Quick Start Guide>

-   Pro Documentation
-   Intro
-   Quick Start Guide

This example is the quickest way to use or consume the API using the [Swagger](https://api-pro.myuplink.com/swagger/index.html) page. This guide is written in a step-by-step way so that anyone can get started. No previous programming skills required.

### Prerequisites:

-   A myUplink PRO account with premium subscription.
-   Log in here: [api-pro.myuplink.com](https://dev.myuplink.com/)
-   You can only get data from the devices you have access to. Please ensure that the account used has active devices. Log in at [myUplink PRO](https://dev.myuplink.com/) to verify.

### First request to the API

Ok, let's get started!

1.  Create an app.
    -   Go to [Applications](https://dev.myuplink.com/apps) and then on the Create new PRO Application tab, create an app.
    -   Your credentials will be generated. Client Identifier and Client Secret is used in the next step.
2.  Authenticate user in your application.
    -   See [Authentication](https://dev.myuplink.com/pro-documentation/auth?activeTab=auth) section.
3.  Authorize on swagger.
    -   Go to [Swagger](https://api-pro.myuplink.com/swagger/index.html) and click the green "Authorize" button.
    -   Enter the bearer token.



4.  Close the form.
    -   Click Authorize and then Close button. The padlock icons to the right should now resemble locked padlocks
-   Send first request
    -   Scroll down to the Groups header and the endpoint GET /v2/groups/me
    -   Click the blue header area to open this endpoint.
    -   Click the black “Try it out” button to the right.



-   Click the blue "Execute" bar.



-   If the request is successful, the response code is 200 and the data is displayed in the Response body.
-   In the Response body, your groups data is displayed and can be downloaded to a JSON file or copied to the clipboard using the icons to the right.

### Used terms

#### Groups

The group object describes the group of devices that the service partner has created. A group may contain more group(s) in it.

#### Devices

The device object describes a specific piece of equipment in a group. For example, a heat pump.

### Further requests

The group’s id and device’s id data retrieved from the initial requests can be used in further requests. Omit the braces from the start and end of the value when pasting the values.

#### Groups endpoints

Groups endpoints can help you fetch the groups of an account and even let you update devices settings in those groups.

Example - The endpoint: GET /v2/groups/me returns the list of groups created by the service partner.

#### Device Info endpoints

The device info endpoints can help you fetch details about a device like it’s connection state, firmware info, smart home support, etc.

Example - The endpoint: GET /v2/devices/{deviceId} uses a specific device id and returns more detailed data on that specific device.

#### Device points endpoints

The device points endpoints helps you fetch the telemetry data points from the device as well as update them.

Example - The endpoint: GET /v2/devices/{deviceId}/points can return data about any of the data points that device has, like outdoor temperature.

### Further references

This quick start guide is the bare minimum instructions to get started.

For more details on the various topics involved the below topics might be a starting point.

#### REST APIs (myUplink PRO API is a REST API)

[Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer)

#### JSON

[JSON](https://en.wikipedia.org/wiki/JSON)

#### HTTP Headers

[List of HTTP Header Fields](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields)

#### The myUplink documentation here in

[Introduction](https://dev.myuplink.com/pro/intro)

<Data Format>

-   Pro Documentation
-   Intro
-   Data Format
-   All data is sent and received as [JSON](https://en.wikipedia.org/wiki/JSON). The client needs to specify the Content-Type and Accept headers as either application/json or text/json.
-   Blank fields are included as null instead of being omitted. However, it is advised to always write null safe code on the client side and have correct error checks.
-   All timestamps are returned with the ISO-8601 format (YYYY-MM-DDTHH:MM:SSZ) in UTC.

<Parameters>

-   Pro Documentation
-   Intro
-   Parameters

API functions have both required and optional parameters. For GET requests, parameters that are not specified in the request URL, weather required or optional, should be provided as query parameters.

For POST, PUT and DELETE requests, the same parameters should be provided as JSON in the request body.

* * *

#### Parameter example

The following API has one parameter specified in the request URL (deviceId), and a couple of required and optional parameters which are not (type, active, page and itemsPerPage)

GET /v2/devices/{deviceId}/notifications

And can therefore be called either with only the mandatory parameters or with any of the optional parameters

GET /v2/devices/U223250839250a799-f63a-44a0-84b5-0a980245cf67/notifications
GET /v2/devices/U223250839250a799-f63a-44a0-84b5-0a980245cf67/notifications?page=1&itemsPerPage=2

<Error Messages>

-   Pro Documentation
-   Intro
-   Error Messages

The myUplink PRO API uses HTTP response codes, as defined in the HTTP specification, to indicate the success or failure of a request. In general, response codes in the 2xx range indicate success, 4xx range indicate an error that resulted from the provided information (e.g. lack of access to resource, missing required parameter) and response codes in the 5xx range indicate an error with the myUplink servers.

All non-successful response messages contains an error message object to help troubleshoot the issue on the client side. For OAuth authorization and token requests this response message follows the convention specified in the [OAuth 2 specification](https://tools.ietf.org/html/rfc6749). Other requests responds with a JSON object with the following parameters.



<HTTP Redirects>

-   Pro Documentation
-   Intro
-   Http Redirects

Where appropriate, the API may use HTTP redirects. Clients should assume that any request may result in a redirection within the api-pro.myuplink.com domain. Receiving a redirection does not imply that an error has occurred.



<Pagination>

-   Pro Documentation
-   Intro
-   Pagination

Functions that return multiple items are paginated. In the case of pagination, the function reference documentation specifies which default values are used and how to access further pages.

<Rate Limiting and Client Abuse>

-   Pro Documentation
-   Intro
-   Rate Limiting Client Abuse

The myUplink PRO API is rate limited. All requests reaching the myUplink PRO API is counted and when the limit has been reached, the subsequent requests will get an error message with the HTTP status code 429 in return. The current limit for PRO API clients is 25 requests per minute. These limits can be adjusted at any time without notice if deemed necessary.

If an application or client is found abusing the API in any way, myUpTech AB has the right to block it until the client owner has solved the issues highlighted by myUpTech AB.

-   Pro Documentation
-   Intro
-   Language

User facing strings provided by the API can be automatically translated to any of the languages supported by myUplink. This is achieved by specifying the Accept-Language HTTP header as specified in the [RFC 2616](https://tools.ietf.org/html/rfc2616#page-104) specification. The following languages are supported by the API:


-   Pro Documentation
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

Please see the [change log](https://dev.myuplink.com/pro-documentation/updates?activeTab=changelog) for a complete list of updates made to the myUplink PRO API.
