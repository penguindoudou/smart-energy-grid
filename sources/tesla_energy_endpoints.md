📖 Reading: https://developer.tesla.com/docs/fleet-api/endpoints/energy
Title: Energy Endpoints | Tesla Fleet API

URL Source: https://developer.tesla.com/docs/fleet-api/endpoints/energy

Published Time: Sat, 10 Jan 2026 02:29:49 GMT

Markdown Content:
Endpoints
---------

Expand All Details

`GET /api/1/energy_sites/{energy_site_id}/calendar_history?kind=backup&start_date={start_date}&end_date={end_date}&period={period}&time_zone={time_zone}`
Returns the backup (off-grid) event history of the site in duration of seconds.

`GET /api/1/energy_sites/{energy_site_id}/telemetry_history?kind=charge&start_date={start_date}&end_date={end_date}&time_zone={time_zone}`
Returns the charging history of a wall connector.

*   Energy values are in watt hours.

`GET /api/1/energy_sites/{energy_site_id}/calendar_history?kind=energy&start_date={start_date}&end_date={end_date}&period={period}&time_zone={time_zone}`
Returns the energy measurements of the site, aggregated to the requested period.

*   Energy values are in watt hours.
*   Visit [https://www.tesla.com/support/energy/powerwall/mobile-app/energy-data](https://www.tesla.com/support/energy/powerwall/mobile-app/energy-data) for more info.

`GET /api/1/energy_sites/{energy_site_id}/live_status`
Returns the live status of the site (power, state of energy, grid status, storm mode).

*   Power values are in watts. 
*   Energy values are in watt hours.

`GET /api/1/products`
Returns products mapped to user.

`GET /api/1/energy_sites/{energy_site_id}/site_info`
Returns information about the site. Things like assets (has solar, etc), settings (backup reserve, etc), and features (storm_mode_capable, etc).

*   Power values are in watts.
*   Energy values are in watt hours.
*   _default\_real\_mode_ can be _autonomous_ for time-based control and _self\_consumption_ for self-powered mode.

`POST /api/1/energy_sites/{energy_site_id}/time_of_use_settings`
Update the time of use settings for the energy site. Visit [https://www.tesla.com/support/energy/powerwall/mobile-app/utility-rate-plans](https://www.tesla.com/support/energy/powerwall/mobile-app/utility-rate-plans) for more information about Utility Rate Plans. The payload for this request that should be passed in for _tou\_settings.tariff\_content\_v2_ is a tariff structure. Visit [](https://digitalassets-energy.tesla.com/raw/upload/app/fleet-api/example-tariff/PGE-EV2-A.json)[https://digitalassets-energy.tesla.com/raw/upload/app/fleet-api/example-tariff/PGE-EV2-A.json](https://digitalassets-energy.tesla.com/raw/upload/app/fleet-api/example-tariff/PGE-EV2-A.json) for an example. Please note the following when creating the payload:

*   At least one _season_ must be present. Seasons can have arbitrary names as they are just a way to distinguish rates for specific times of the year. Each season contains a tariff period specifying the start and end months/days along with its time of use periods.
*   _demand\_charges_ is for tariffs that charge a fee for peak power consumption. This is not common for residential systems. Typically residential customers are only charged for the energy that they consume, _energy\_charges_ should be used in this case.
*   Prices in _ALL_ in _energy\_charges_ or _demand\_charges_ apply to all time periods. It is recommended to use the _ALL_ field for flat/fixed tariffs instead of creating tariff periods.
*   The following are valid currency strings: _USD_, _EUR_, _GBP_
*   Time of use labels may be any string but the mobile app will only support displaying the following labels: _ON\_PEAK, OFF\_PEAK, PARTIAL\_PEAK_ or _SUPER\_OFF\_PEAK_.
*   The tariff must pass the following validation checks: 
    *   No overlaps of time periods
    *   No gaps in time periods
    *   No overlapping seasons or gaps between seasons
    *   All periods/seasons that have prices defined have time periods defined
    *   All periods/seasons that have time periods defined have prices
    *   No negative prices. Negative prices will be rounded to zero. Therefore use prices that include taxes. This will limit the frequency of negative prices occurring. 
    *   Buy price should be >= sell price at any given time. If not, the buy price will be set equal to the sell price.
