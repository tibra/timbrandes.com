---
layout: post
title: "Debugging missing remote clients in Uchiwa with Sensu, RabbitMQ and Redis"
date:   2015-11-25 10:20:00 +0100
categories: guide
comments: true
old_disqus_id: 4349164631
---


## The 10 hours bug hunt because of a missing comma aka understand the system to debug your configuration

It all happend once my sensu-server was all set up and functioning well. The local sensu-client shows up in a dashboard and I moved on to configure the first remote client. So I've closely followed (in retrospect multiple times) the documentation on how to install and configure the sensu-client. I've self-signed the SSL certificates on the sensu-server, distributed the client.key and client.pem files to the server and even managed to install the client directly with the [sensu-chef Cookbook](https://github.com/sensu/sensu-chef). Then, I restarted the client and looked at the Uchiwa Dashboard on the server: nothing except my local client. I've restarted all services on the server like api, server, uchiwa in case I had miss-interpreted how Sensu works and which philosophy it follows. Unfurtunately to the effect of: nothing. The remote just wouldn't show up. So searching the Internet began and with it some suggestions which log files to consult for help. 

<blockquote>
<a href="/assets/2015-11-sensu.png"><img src="/assets/2015-11-sensu.png" /></a>
</blockquote>

### Make sure SSL is setup correctly
Since all my remote clients should talk to the sensu master server via SSL, I wanted to make sure this SSL connection with self-signed certs would work as I intented. It did not, instead, I was getting TLS handshake failures all over the RabbitMQ logs. By the way, each sensu-client has a config hash that specifies how it talks to RabbitMQ on the sensu master server. The remote client will talk directly to RabbitMQ, so this is probably a good first place to look for failures when a remote client doesn't show up in Uchiwa. On the client, I was checking the sensu-client logs unter */var/log/sensu/sensu-client.log*. It said something like *reconnecting to transport* and just hang there. The RabbitMQ logs on the server under */var/log/rabbitmq/rabbit@sensu.log* displayed the TLS error. 

And this is how it looked like on the remote client
{% highlight ruby %}
{"timestamp":"2015-11-23T11:17:04.318751+0100","level":"warn","message":"loading config file","file":"/etc/sensu/config.json"}
{"timestamp":"2015-11-23T11:17:04.318847+0100","level":"warn","message":"loading config files from directory","directory":"/etc/sensu/conf.d"}
{"timestamp":"2015-11-23T11:17:04.321103+0100","level":"warn","message":"loading extension files from directory","directory":"/etc/sensu/extensions"}
{"timestamp":"2015-11-23T11:17:04.407738+0100","level":"warn","message":"reconnecting to transport"}
{"timestamp":"2015-11-23T11:22:14.426687+0100","level":"error","message":"[amqp] Detected TCP connection failure"}
{% endhighlight %}

Here is the RabbitMQ Server log
{% highlight ruby %}
=INFO REPORT==== 23-Nov-2015::11:22:33 ===
accepting AMQP connection <0.248.0> (SENSU_REMOTE_CLIENT_IP:33954 -> SENSU_SERVER_IP:5671)

=ERROR REPORT==== 23-Nov-2015::11:22:33 ===
Error on AMQP connection <0.244.0>:
{ssl_upgrade_error,{tls_alert,"record overflow"}}
{% endhighlight %}


So instead of cheating by telling RabbitMQ to not validate my certs, I've set them up from scratch again. This time it worked. So it was probably a mistake on my side where I falsly copied some files or forgot a step. It looked like this now:

Sensu remote client log
{% highlight ruby %}
{"timestamp":"2015-11-23T13:47:09.656492+0100","level":"info","message":"reconnected to transport"}
{"timestamp":"2015-11-23T13:47:10.657438+0100","level":"debug","message":"scheduling keepalives"}
{"timestamp":"2015-11-23T13:47:10.657671+0100","level":"debug","message":"publishing keepalive","payload":{"name":"errbit","address":"localhost","subscriptions":["ALL"],"version":"0.20.6","timestamp":1448282830}}
{"timestamp":"2015-11-23T13:47:10.658116+0100","level":"debug","message":"subscribing to client subscriptions"}
{"timestamp":"2015-11-23T13:47:10.658210+0100","level":"debug","message":"subscribing to a subscription","subscription":"ALL"}
{"timestamp":"2015-11-23T13:47:10.658602+0100","level":"debug","message":"scheduling standalone checks"}
{"timestamp":"2015-11-23T13:47:30.658960+0100","level":"debug","message":"publishing keepalive","payload":{"name":"errbit","address":"localhost","subscriptions":["ALL"],"version":"0.20.6","timestamp":1448282850}}
{% endhighlight %}

RabbitMQ Server log
{% highlight ruby %}
=INFO REPORT==== 23-Nov-2015::13:47:08 ===
accepting AMQP connection <0.301.0> (SENSU_REMOTE_CLIENT_IP:34272 -> SENSU_MASTER_SERVER_IP:5671)
{% endhighlight %}

## However, the sensu remote client was still not visible in Uchiwa

So this is where things seemed so strange to me that after I've spent another 4 hours looking for clues on what was wrong with my setup, I've decided to check in to the #sensu IRC channel. *rob_* was kind and pointed me towards redis and run "redis-cli keys '\*'" on the sensu server to check if redis was saving anything for that client. It did not, the name of name remote sensu client wasn't in that list. Since a remote client talks to the Sensu API which again talks to Redis-Server (thank you *warmfusion* for helping get the connections right on IRC), something was probably wrong on the transport between the remote client and the sensu server. But this was OK, however, still no remote client in sensu. I've decided to head over to the sensu master server again. Then, in the sensu-server log it hit me:
{% highlight ruby %}
{"timestamp":"2015-11-23T17:30:42.501290+0100","level":"warn","message":"config file must be valid json","file":"/etc/sensu/config.json","error":"parse error: after key and value, inside map, I expect ',' or '}'\n          ,     \"vhost\": \"/sensu\"     \"ssl\": {       \"cert_chain_file\"\n                     (right here) ------^\n"}
{% endhighlight %}

Checking the */etc/sensu/config.json*, I've added the missing comma, restarted the server via *service sensu-server restart* and everything was well and good. Still, I can't believe why the system didn't warn me about it, I've used the restarting service command a dozen times at least that day.  So my takeaway from this is: if anything seems strange, check ALL the log files from sensu, redis, rabbitmq and the sensu-client first and don't from hypothesis about was might be wrong when the fault isn't isolated well enough.

The resulting diagramm shows not only the interplay of the sensu master server and the sensu remote clients but also the integration of configuration management (chef/puppet) and how to use the sensu community plugins in a DRY-way. I'll might follow up with another post on that topic soon.
