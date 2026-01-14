📖 Reading: https://teslemetry.com/blog/tesla-fleet-api-pay-per-use
Title: Tesla Fleet API "Pay Per Use" Pricing

URL Source: https://teslemetry.com/blog/tesla-fleet-api-pay-per-use

Markdown Content:
Yesterday [Tesla published](https://developer.tesla.com/) the prices it will be charging customers and third party services like Teslemetry to use the Tesla Fleet API. We knew these changes were coming sometime in 2024, and with 34 days left in the year, we finally know what they are. Originally we expected three different subscriptions with different rate limits, and charged per vehicle. However now we know that Tesla will be using a "pay per use" model, with the following prices:

*   Streaming Data: $0.0001 per signal
*   Vehicle Commands: $0.001 per request
*   Vehicle Data: $0.002 per request
*   Wake Up: $0.02 per request

Many of the early adopters of the Tesla Fleet API have had nearly unlimited access to the API since it launched in late 2023, and Teslemetry's customers have benefited from this with 20 second vehicle polling, and almost no restrictions on vehicle commands.

However, under the new pricing if Teslemetry was to continue operating exactly like it does today, our annual bill to Tesla would be over _$1,000,000 USD each year_. Clearly this is not sustainable on $2.50/month subscriptions, so we will have to make some changes to the way the service operates.

The [pricing page](https://teslemetry.com/pricing) has been updated with a new pricing model for Teslemetry in 2025.

In summary:

*   Teslemetry Subscription - As per usual, everyone needs a Teslemetry base subscription which starts at $2.50USD/month.
*   Vehicle Data Subscription - Starting January 2025, everyone needs a vehicle data subscription for each vehicle they want to see data for, which costs starts at $2.50USD/month.
*   Vehicle Commands - Starting January 2025, everyone who wants to run commands through Teslemetry will need to purchase packs of 2000 vehicle command credits for $2.50USD
*   Energy Sites - Tesla has made no announcements either way about the cost of this data in the future, so remains free with a Teslemetry subscription.

In the backend, anyone with a Vehicle Data Subscription will have the vehicle_data endpoint called intelligently for them 32 times a day with the response cached server side. You could however use 2 vehicle command credits to force a data refresh at any time, enabling high refresh if you need it.

The biggest cost here is the _wake up_ command, which has to consume 20 credits. I am going to go to significant lengths to ensure we never call wake up unless it's absolutely required.

What this change makes clear, is that the value of Teslemetry is no longer in being a low cost replacement to the Tesla Owners API. Cost conscious users can sign up to use the Fleet API directly and leverage the free $10 monthly credit to meet their needs in the [Home Assistant Tesla Fleet](https://www.home-assistant.io/integrations/tesla_fleet/) integration.

That's why starting today, along with the launch of the blog, Teslemetry is changing its headline to **Simple and secure access to the Tesla Fleet API**. Teslemetry handles the complexity of command signing, fleet telemetry configuration, and even adds unique features like server sent events and webhooks.

Teslemetry is for users who want something that just works, and that's what we are going to focus on delivering in 2025.

As always, I want to know what you think about these changes, and if you have any suggestions for how we can make this work better for you, please let me know on [Discord](https://discord.gg/7wZwHaZbWD).
