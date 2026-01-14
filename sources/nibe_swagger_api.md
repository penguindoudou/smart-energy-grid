📖 Reading: https://api.myuplink.com/swagger/index.html
Title: Swagger UI

URL Source: https://api.myuplink.com/swagger/index.html

Markdown Content:
Swagger UI
===============

[](https://api.myuplink.com/swagger/index.html)Select a definition 

myUplink Public API v2 OAS 3.0
------------------------------

[/swagger/docs/public-v2/swagger.json](https://api.myuplink.com/swagger/docs/public-v2/swagger.json)

Authorize

### [AidMode](https://api.myuplink.com/swagger/index.html)

GET

[/v2/devices/{deviceId}/aidMode](https://api.myuplink.com/swagger/index.html)

Get aid mode state.

### [DeviceInfo](https://api.myuplink.com/swagger/index.html)

GET

[/v2/devices/{deviceId}](https://api.myuplink.com/swagger/index.html)

Device querying endpoint.

GET

[/v2/devices/{deviceId}/smart-home-categories](https://api.myuplink.com/swagger/index.html)

Gets the availability of smart home categories in a device.

GET

[/v2/devices/{deviceId}/smart-home-zones](https://api.myuplink.com/swagger/index.html)

Gets the available smart home zones for a device.

### [DevicePoints](https://api.myuplink.com/swagger/index.html)

GET

[/v2/devices/{deviceId}/points](https://api.myuplink.com/swagger/index.html)

Get data points for device.

PATCH

[/v2/devices/{deviceId}/points](https://api.myuplink.com/swagger/index.html)

Change settings on device.

PATCH

[/v2/devices/{deviceId}/zones/{zoneId}](https://api.myuplink.com/swagger/index.html)

Updates zone settings.

GET

[/v3/devices/{deviceId}/points](https://api.myuplink.com/swagger/index.html)

Get scaled data point for device.

### [Firmware](https://api.myuplink.com/swagger/index.html)

GET

[/v2/devices/{deviceId}/firmware-info](https://api.myuplink.com/swagger/index.html)

Gets brief information about the specified device's firmware.

GET

[/v2/firmware/{firmwareTypeId}/version/{version}/download](https://api.myuplink.com/swagger/index.html)

Download specified firmware file.

GET

[/v2/brands/{brandId}/firmware/{firmwareTypeId}/version/{version}/download](https://api.myuplink.com/swagger/index.html)

Download specified firmware file and update firmware metrics (i.e. download count).

### [Identity](https://api.myuplink.com/swagger/index.html)

POST

[/oauth/token](https://api.myuplink.com/swagger/index.html)

Token endpoint that can be used to programmatically request tokens.

POST

[/user/validate](https://api.myuplink.com/swagger/index.html)

Validate endpoint

GET

[/oauth/authorize](https://api.myuplink.com/swagger/index.html)

Authorize endpoint that can be used to request tokens or authorization codes via the browser.

POST

[/oauth/authorize](https://api.myuplink.com/swagger/index.html)

Authorize endpoint that can be used to request tokens or authorization codes via the browser.

GET

[/connect/authorize/callback](https://api.myuplink.com/swagger/index.html)

Callback endpoint for authorization code flow (OAuth).

GET

[/oauth/login](https://api.myuplink.com/swagger/index.html)

Login endpoints for IdentityServer Authorization code flow (OAuth).

POST

[/oauth/login](https://api.myuplink.com/swagger/index.html)

Login endpoints for IdentityServer Authorization code flow (OAuth).

GET

[/oauth/consent](https://api.myuplink.com/swagger/index.html)

Consent endpoints where users confirms permissions to 3rd party app (OAuth).

POST

[/oauth/consent](https://api.myuplink.com/swagger/index.html)

Consent endpoints where users confirms permissions to 3rd party app (OAuth).

GET

[/oauth/error](https://api.myuplink.com/swagger/index.html)

Error endpoint for html page with user-friendly error details (OAuth).

GET

[/assets/identity-server/{any}](https://api.myuplink.com/swagger/index.html)

Serving assets (css, js etc.) for identity server pages.

GET

[/.well-known/openid-configuration](https://api.myuplink.com/swagger/index.html)

The discovery endpoint that is used to retrieve metadata about the IdentityServer.

GET

[/.well-known/openid-configuration/jwks](https://api.myuplink.com/swagger/index.html)

The JSON Web Key Set (JWKS) is a set of keys which contains the public keys used to verify any JSON Web Token (JWT) issued by the authorization server and signed using the RS256 signing algorithm. See https://auth0.com/docs/tokens/concepts/jwks.

### [Notification](https://api.myuplink.com/swagger/index.html)

GET

[/v2/systems/{systemId}/notifications/active](https://api.myuplink.com/swagger/index.html)

Retrieve active alarms for specified system.

GET

[/v2/systems/{systemId}/notifications](https://api.myuplink.com/swagger/index.html)

Retrieve all (active, inactive and archived) alarms for specified system.

### [Ping](https://api.myuplink.com/swagger/index.html)

GET

[/v2/protected-ping](https://api.myuplink.com/swagger/index.html)

Tests the API availability with authorization header.

GET

[/v2/ping](https://api.myuplink.com/swagger/index.html)

Tests the API availability.

### [Premium](https://api.myuplink.com/swagger/index.html)

GET

[/v2/systems/{systemId}/subscriptions](https://api.myuplink.com/swagger/index.html)

Finds out whether the specified system has any active premium subscriptions.

### [Systems](https://api.myuplink.com/swagger/index.html)

GET

[/v2/systems/me](https://api.myuplink.com/swagger/index.html)

Get user systems.

PUT

[/v2/systems/{systemId}/smart-home-mode](https://api.myuplink.com/swagger/index.html)

Set smart home mode for a system.

GET

[/v2/systems/{systemId}/smart-home-mode](https://api.myuplink.com/swagger/index.html)

Get current smart home mode of a system.

#### Schemas

Address

AddressResponseModel

AggregationMethod

AggregationUnit

AidMode

AidModeResponseModel

Alarm

AlarmSeverity

AlarmStatus

AlarmsPaged

AvailableMethods

CloudToDeviceMethodResult

Country

Curve

DataPoint

DataPointPagedResult

DeviceCategoriesModel

DeviceCategory

DeviceCategoryModel

DeviceConnectionState

DeviceFirmwareInfoResponse

DeviceInfoResponseModel

DeviceInfoResponseModelPagedResult

DeviceInfoSyncResponseModel

DeviceParameterData

DevicePremiumResponse

DeviceResponseModel

EnumValues

FirmwareResponseModel

GroupedDeviceParameterData

LimitedUserProfile

PagedSystemResult

ParameterData

ParameterDetail

PatchSystemModel

PremiumFeatureResponseModel

PremiumFeatures

Product

ProductRegistrationAddress

ProductRegistrationResponse

ProductRegistrationResponseWithAddress

ProductResponseModel

Properties

Reported

ReportedFirmware

SearchGroupSSG

SecurityLevel

SmartHomeModeModel

SmartMode

SpotPriceDeliveryModel

SsqGroupDevice

Status

StoreSet

StoreSetEntry

SystemDevice

SystemWithDevices

UpdateGroupRequest

UserWithAddress

VoucherManyRequest

VoucherSingleRequest

VoucherType

ZonePatchRequest

ZoneResponse
