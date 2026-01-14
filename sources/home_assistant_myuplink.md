📖 Reading: https://www.home-assistant.io/integrations/myuplink/
Title: myUplink

URL Source: https://www.home-assistant.io/integrations/myuplink/

Markdown Content:
myUplink - Home Assistant
===============

[](https://www.home-assistant.io/)[2026.1.0](https://www.home-assistant.io/blog/2026/01/07/release-20261/ "Latest version 2026.1.0 released January  7, 2026")

- [x] 
*   [Getting started](https://www.home-assistant.io/installation/)
*   [Documentation](https://www.home-assistant.io/docs/)
    *   [Installation](https://www.home-assistant.io/installation/)
    *   [Automations](https://www.home-assistant.io/docs/automation/)
    *   [Dashboards](https://www.home-assistant.io/dashboards/)
    *   [Voice assistants](https://www.home-assistant.io/voice_control/)
    *   [Device organization](https://www.home-assistant.io/docs/organizing/)
    *   [Energy management](https://www.home-assistant.io/docs/energy/)
    *   [Advanced configuration](https://www.home-assistant.io/docs/configuration/)

*   [Our hardware](https://www.home-assistant.io/integrations/myuplink/#)
    *   [Home Assistant Green](https://www.home-assistant.io/green/)
    *   [Connect ZBT-2](https://www.home-assistant.io/connect/zbt-2/)
    *   [Connect ZWA-2](https://www.home-assistant.io/connect/zwa-2/)
    *   [Voice Preview Edition](https://www.home-assistant.io/voice-pe/)

*   [Integrations](https://www.home-assistant.io/integrations/)
*   [Blog](https://www.home-assistant.io/blog/)
*   [Need help?](https://www.home-assistant.io/help/)
*    

On this page
============

*   [Prerequisites](https://www.home-assistant.io/integrations/myuplink/#prerequisites)
*   [Configuration](https://www.home-assistant.io/integrations/myuplink/#configuration)
*   [Supported heat-pump systems](https://www.home-assistant.io/integrations/myuplink/#supported-heat-pump-systems)
*   [Use cases](https://www.home-assistant.io/integrations/myuplink/#use-cases)
*   [Example](https://www.home-assistant.io/integrations/myuplink/#example)
*   [Data updates](https://www.home-assistant.io/integrations/myuplink/#data-updates)
*   [Known limitations](https://www.home-assistant.io/integrations/myuplink/#known-limitations)
*   [Troubleshooting](https://www.home-assistant.io/integrations/myuplink/#troubleshooting)
*   [Removing the integration](https://www.home-assistant.io/integrations/myuplink/#removing-the-integration)
    *   [To remove an integration instance from Home Assistant](https://www.home-assistant.io/integrations/myuplink/#to-remove-an-integration-instance-from-home-assistant)

*   [Related links](https://www.home-assistant.io/integrations/myuplink/#related-links)

[Home](https://www.home-assistant.io/) ▸ [Integrations](https://www.home-assistant.io/integrations/) ▸ 

myUplink
========

The **myUplink**integration Integrations connect and integrate Home Assistant with your devices, services, and more.[[Learn more]](https://www.home-assistant.io/getting-started/concepts-terminology/#integrations) lets you get information about and control heat-pump devices supporting myUplink using the [official cloud API](https://dev.myuplink.com/).

The integration will connect to your account and download all available data from the API. The downloaded information will be used to create devices and entities in Home Assistant. There can be from a few entities up to many hundreds depending on the type of equipment. The integration will make the best effort to map the data-points in the API to sensors, switches, number, and select entities.

Note

You may need a valid subscription with myUplink to control your equipment with switch, select, and number entities.

Prerequisites [](https://www.home-assistant.io/integrations/myuplink/#prerequisites)
------------------------------------------------------------------------------------

1.   Visit [https://myuplink.com/register](https://myuplink.com/register) and sign up for a user account.
2.   Go to [**Applications**](https://dev.myuplink.com/apps), and register a new App:

*   **Application Name**: Home Assistant (or whatever name makes sense to you)
*   **Description**: A brief description of how you’ll use this application (e.g., “Home Assistant integration for controlling my heat pump”)
*   **Callback URL**: `https://my.home-assistant.io/redirect/oauth`

I have manually disabled My Home Assistant

If you don’t have [My Home Assistant](https://www.home-assistant.io/integrations/my) on your installation, you can use `<HOME_ASSISTANT_URL>/auth/external/callback` as the redirect URI instead.

The `<HOME_ASSISTANT_URL>` must be the same as used during the configuration/ authentication process.

Internal examples: `http://192.168.0.2:8123/auth/external/callback`, `http://homeassistant.local:8123/auth/external/callback`.”

Configuration [](https://www.home-assistant.io/integrations/myuplink/#configuration)
------------------------------------------------------------------------------------

To add the **myUplink** hub to your Home Assistant instance, use this My button:

[![Image 1](https://my.home-assistant.io/badges/config_flow_start.svg)](https://my.home-assistant.io/redirect/config_flow_start?domain=myuplink)

 Manual configuration steps

If the above My button doesn’t work, you can also perform the following steps manually:

*   Browse to your Home Assistant instance.

*   Go to **[Settings > Devices & services](https://my.home-assistant.io/redirect/integrations)**.

*   In the bottom right corner, select the **[Add Integration](https://my.home-assistant.io/redirect/config_flow_start?domain=myuplink)** button.

*   From the list, select **myUplink**.

*   Follow the instructions on screen to complete the setup.

The integration configuration will require the **Client ID** and **Client Secret** created above. See [Application Credentials](https://www.home-assistant.io/integrations/application_credentials) for more details.

Supported heat-pump systems [](https://www.home-assistant.io/integrations/myuplink/#supported-heat-pump-systems)
----------------------------------------------------------------------------------------------------------------

The integration supports all heat-pump devices that can be connected to the myUplink cloud service. See [Works with myUplink](https://myuplink.com/legal/works-with/en). However, the representation in Home Assistant depends on how and to what extent the manufacturer has implemented the service.

Use cases [](https://www.home-assistant.io/integrations/myuplink/#use-cases)
----------------------------------------------------------------------------

Common use cases include:

*   **System Monitoring**: Display the current operation state of the pump (heating house, pool, or hot water)
*   **Smart Notifications**: Get alerts when the water temperature is low in the heater tank
*   **Automation**: Adjust the temperature curve offset during holiday mode
*   **Analytics**: View long-term statistics and graphs for the relevant sensors

Example [](https://www.home-assistant.io/integrations/myuplink/#example)
------------------------------------------------------------------------

Automation that will send a notification to a smartphone when the hot water reserve is getting low. In this example a temperature below 42°C in the middle of the water tank will trigger the notification. Note that actual entity name varies between models of heat pumps. You will have to adapt the yaml code to your own installation.

```
automation:
  - alias: "Notify on low hot water reserve"
    triggers:
      - trigger: numeric_state
        entity_id:
          - sensor.your_pump_hot_water_charging_bt6
        below: 42
    actions:
      - action: notify.mobile_app_your_device
        data:
          message: "Hot water reserve is getting low."
          title: "Water heater"
```

Data updates [](https://www.home-assistant.io/integrations/myuplink/#data-updates)
----------------------------------------------------------------------------------

The integration will poll the API for data every 60 seconds. This polling interval is designed to work within the rate limits of myUplink APIs while providing timely updates.

Known limitations [](https://www.home-assistant.io/integrations/myuplink/#known-limitations)
--------------------------------------------------------------------------------------------

*   The integration makes the best effort to map data-points from the API to relevant entities in Home Assistant. However, some sensors may not appear for certain heat-pump models, or in other cases, numerous irrelevant entities might be created. Please create an issue on GitHub and include a diagnostic download file from your installation if you believe that the mapping can be improved.
*   Entity names are available in English and cannot be automatically translated by Home Assistant. The reason is that the names are defined by the API and can be changed by updates of the API or the firmware in the appliance. However, most entity names are self-explanatory, e.g., “Room temperature (BT50)”.

Troubleshooting [](https://www.home-assistant.io/integrations/myuplink/#troubleshooting)
----------------------------------------------------------------------------------------

Can't log in to myUplink API

 Make sure that you have entered the application credentials correctly. A common problem is that leading or trailing spaces are included in the entered credential strings. You may have to delete the application credentials from Home Assistant and install the integration again to get everything right. 

Removing the integration [](https://www.home-assistant.io/integrations/myuplink/#removing-the-integration)
----------------------------------------------------------------------------------------------------------

After removing the integration, go to the myUplink [developer site](https://dev.myuplink.com/apps) and remove the credentials unless you will use them again.

### To remove an integration instance from Home Assistant [](https://www.home-assistant.io/integrations/myuplink/#to-remove-an-integration-instance-from-home-assistant)

1.   Go to [**Settings**>**Devices & services**](https://my.home-assistant.io/redirect/integrations) and select the integration card.
2.   From the list of devices, select the integration instance you want to remove.
3.   Next to the entry, select the three dots  menu. Then, select **Delete**.

Related links[](https://www.home-assistant.io/integrations/myuplink/#related-links)
-----------------------------------------------------------------------------------

*   [myUplink web portal](https://myuplink.com/)

#### **Help us improve our documentation**[](https://www.home-assistant.io/integrations/myuplink/#feedback_section)

 Suggest an edit to this page, or provide/view feedback for this page. 

*   [Edit](https://github.com/home-assistant/home-assistant.io/tree/current/source/_integrations/myuplink.markdown "Edit this page")
*   [Provide feedback](https://github.com/home-assistant/home-assistant.io/issues/new?template=feedback.yml&url=https%3A%2F%2Fwww.home-assistant.io%2Fintegrations%2Fmyuplink%2F&version=2026.1.0&labels=current,integration%3A%20myuplink "Provide feedback on this page")
*   [View pending feedback](https://github.com/home-assistant/home-assistant.io/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc+label%3A%22integration%3A+myuplink%22 "View pending feedback for this page")

![Image 2](https://brands.home-assistant.io/_/myuplink//logo.png)[![Image 3](https://my.home-assistant.io/badges/config_flow_start.svg)](https://my.home-assistant.io/redirect/config_flow_start?domain=myuplink)

The myUplink hub was introduced in Home Assistant 2024.2, and it's used by [1048](https://analytics.home-assistant.io/integrations "Open analytics.home-assistant.io") active installations. 

Its IoT class is [Cloud Polling.](https://www.home-assistant.io/blog/2016/02/12/classifying-the-internet-of-things/#classifiers)

[🥈 Silver quality](https://www.home-assistant.io/docs/quality_scale/#-silver)

[View source on GitHub](https://github.com/home-assistant/core/tree/dev/homeassistant/components/myuplink)

[View known issues](https://github.com/home-assistant/core/issues?q=is%3Aissue+label%3A%22integration%3A+myuplink%22)

[View feature requests](https://github.com/orgs/home-assistant/discussions?discussions_q=label%3A%22integration%3A+myuplink%22)

Integration owners
==================

 We are incredibly grateful to the following contributors who currently maintain this integration:

[![Image 4: @pajzo](https://avatars.githubusercontent.com/pajzo?size=96) @pajzo](https://github.com/pajzo)

[![Image 5: @astrandb](https://avatars.githubusercontent.com/astrandb?size=96) @astrandb](https://github.com/astrandb)

On this page
============

*   [Prerequisites](https://www.home-assistant.io/integrations/myuplink/#prerequisites)
*   [Configuration](https://www.home-assistant.io/integrations/myuplink/#configuration)
*   [Supported heat-pump systems](https://www.home-assistant.io/integrations/myuplink/#supported-heat-pump-systems)
*   [Use cases](https://www.home-assistant.io/integrations/myuplink/#use-cases)
*   [Example](https://www.home-assistant.io/integrations/myuplink/#example)
*   [Data updates](https://www.home-assistant.io/integrations/myuplink/#data-updates)
*   [Known limitations](https://www.home-assistant.io/integrations/myuplink/#known-limitations)
*   [Troubleshooting](https://www.home-assistant.io/integrations/myuplink/#troubleshooting)
*   [Removing the integration](https://www.home-assistant.io/integrations/myuplink/#removing-the-integration)
    *   [To remove an integration instance from Home Assistant](https://www.home-assistant.io/integrations/myuplink/#to-remove-an-integration-instance-from-home-assistant)

*   [Related links](https://www.home-assistant.io/integrations/myuplink/#related-links)

Categories
==========

*   [Binary sensor](https://www.home-assistant.io/integrations/#binary-sensor)
*   [Number](https://www.home-assistant.io/integrations/#number)
*   [Select](https://www.home-assistant.io/integrations/#select)
*   [Sensor](https://www.home-assistant.io/integrations/#sensor)
*   [Switch](https://www.home-assistant.io/integrations/#switch)
*   [Update](https://www.home-assistant.io/integrations/#update)

![Image 6: Home Assistant](https://www.home-assistant.io/images/footer-logo-text.svg)

Home Assistant is a project from the [Open Home Foundation](https://www.openhomefoundation.org/), sponsored by [Nabu Casa](https://www.nabucasa.com/).

### Join us and contribute!

*   [GitHub repo](https://github.com/home-assistant/)
*   [Developers Portal](https://developers.home-assistant.io/)
*   [Design Portal](https://design.home-assistant.io/)
*   [Data Science Portal](https://data.home-assistant.io/)
*   [Community Forum](https://community.home-assistant.io/)
*   [Creator Network](https://creators.home-assistant.io/)
*   [Works With Home Assistant](https://works-with.home-assistant.io/)
*   [Our community](https://www.home-assistant.io/community)
*   [Reporting issues](https://www.home-assistant.io/help/reporting_issues/)

### System status

*   [Integration Alerts](https://alerts.home-assistant.io/)
*   [Security Alerts](https://www.home-assistant.io/security/)
*   [System Status](https://status.home-assistant.io/)

### Companion apps

*   [iOS and Apple devices](https://apps.apple.com/app/id1099568401)
*   [Android and Wear OS](https://play.google.com/store/apps/details?id=io.homeassistant.companion.android)
*   [...and more!](https://companion.home-assistant.io/)

### Governance

*   [Privacy Notices](https://www.home-assistant.io/privacy/)
*   [Contributor License Agreement](https://www.home-assistant.io/developers/cla/)
*   [Terms of Service](https://www.home-assistant.io/tos/)
*   [Code of Conduct](https://www.home-assistant.io/code_of_conduct/)
*   [Credits](https://www.home-assistant.io/developers/credits/)
*   [License](https://www.home-assistant.io/developers/license/)

### Follow us

[Sign up for our newsletter](https://newsletter.openhomefoundation.org/#/portal)

[](https://youtube.com/@home_assistant "YouTube")[](https://reddit.com/r/homeassistant "Reddit")[](https://github.com/home-assistant "GitHub")

[](https://fosstodon.org/@homeassistant "Mastodon")[](https://bsky.app/profile/home-assistant.io "Bluesky")[](https://x.com/home_assistant "X")

[](https://www.facebook.com/homeassistantio "Facebook")[](https://www.instagram.com/homeassistant/ "Instagram")[](https://www.linkedin.com/company/home-assistant "LinkedIn")

For partnership inquiries please check out [Works With Home Assistant](https://works-with.home-assistant.io/). For media, get in touch [here](https://www.home-assistant.io/cdn-cgi/l/email-protection#86ebe3e2efe7c6e9f6e3e8eee9ebe3e0e9f3e8e2e7f2efe9e8a8e9f4e1). For other questions, you can contact us [here](https://www.home-assistant.io/cdn-cgi/l/email-protection#5d35383131321d35323038703c2e2e342e293c3329733432) (No technical support!)

Website powered by [Jekyll](https://jekyllrb.com/)

 Originally based on the [Oscailte theme](https://github.com/coogie/oscailte)

[![Image 7: Deploys by Netlify Badge](https://www.home-assistant.io/images/frontpage/netlify.svg)](https://www.netlify.com/)
