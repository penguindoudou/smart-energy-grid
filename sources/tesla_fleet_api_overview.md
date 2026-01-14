📖 Reading: https://developer.tesla.com/docs/fleet-api
Title: What is Fleet API? | Tesla Fleet API

URL Source: https://developer.tesla.com/docs/fleet-api

Published Time: Sat, 10 Jan 2026 02:29:49 GMT

Markdown Content:
Fleet API is a data and command service providing access to Tesla vehicles and energy devices. Partners can interact with their own devices or devices for which they have been granted access by a customer.

Follow the onboarding process below to register and get an API key to interact with Tesla's API endpoints. Applications can request vehicle owners for permission to view account information, get vehicle status or even issue remote commands. Vehicle owners maintain control over which application they grant access to, and can change these settings at any time.

Create a Tesla account and ensure it has a verified email and multi-factor authentication enabled.

[Create Account](https://developer.tesla.com/teslaaccount)
Click the button below to request app access. Provide legal business details, application name, description, and purpose of usage.

While requesting access, select the scopes used by the application. Reference the [authentication overview page](https://developer.tesla.com/docs/fleet-api/authentication/overview#scopes) for a list of available scopes.

> Note: account creation requests can be automatically rejected if the application name already exists.

[Create Application and Access Dashboard](https://developer.tesla.com/dashboard)
A public key must be hosted on the application's domain before making calls to Fleet API.

The key is used to validate ownership of the domain and provide additional security when using [Vehicle Commands](https://developer.tesla.com/docs/fleet-api/endpoints/vehicle-commands) and [Fleet Telemetry](https://developer.tesla.com/docs/fleet-api/fleet-telemetry).

To create a private key, run:

```
openssl ecparam -name prime256v1 -genkey -noout -out private-key.pem
```

Then, generate the associated public key.

```
openssl ec -in private-key.pem -pubout -out public-key.pem
```

This public key should be available at:

```
https://developer-domain.com/.well-known/appspecific/com.tesla.3p.public-key.pem
```

> Note: private-key.pem needs to be kept secret and should not be hosted on a domain.

Next, generate a [partner authentication token](https://developer.tesla.com/docs/fleet-api/authentication/partner-tokens) and use it to call the [register endpoint](https://developer.tesla.com/docs/fleet-api/endpoints/partner-endpoints#register) to complete registration with Fleet API. _Note: The register call needs to be completed in each [region](https://developer.tesla.com/docs/fleet-api/getting-started/regions-countries) of operation._

Now that the register endpoint has been called, Fleet API is configured and ready to receive requests.

Next steps to take:

*   Selecting the proper authentication token type and generating tokens. [Authentication overview](https://developer.tesla.com/docs/fleet-api/authentication/overview).
*   [Pairing a public key to a vehicle](https://developer.tesla.com/docs/fleet-api/virtual-keys/developer-guide#adding-to-a-vehicle). This is required to send [Vehicle Commands](https://developer.tesla.com/docs/fleet-api/endpoints/vehicle-commands) and setup [Fleet Telemetry](https://developer.tesla.com/docs/fleet-api/fleet-telemetry).
*   Configuring [Fleet Telemetry](https://developer.tesla.com/docs/fleet-api/fleet-telemetry) which streams data directly to a server.
