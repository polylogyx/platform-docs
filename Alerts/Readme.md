Managing Alerts
=================================== 
An alert indicates an important occurrence in the enterprise. An alert is generated when incoming event data matches a predefined rule or when event data (for last 24 hours) matches the Threat Intel feed. 
The Alerts page is the central console that allows you to manage and review alerts.  Click SOC Operations | Alerts to view the Alerts page.

Review Event Traffic
--------------------
On the Alerts page, review the event timeline for your enterprise on the top bar to review the traffic trend. Each cluster on the timeline represents a collection of events. Hover over a cluster to see its details. Click the + button to zoom in and – button to zoom out. Use the arrow buttons to navigate the timeline. HOVER IS MISLEADING

Review Alerts 
--------------------
Click the AlientVault OTX, IBM X-Force, Rule, and VirusTotal tabs on the page to review the alerts based on the source generating the alerts. For example, when you click the Rule tab only the alerts generated based on predefined rules matching event data are displayed. 
Perform these steps to review alert information:
1.	Click the node name to view endpoint details. 
    When you click a node, the recent activity page is displayed where you can run various queries to view node-specific information. 
2.	Review the severity information.
    For rule-based alerts severity values are none, info, warning, and critical. For alerts based on the Threat Intel data, severity values are low, medium, and high. 
3.	Click Intel Data for an alert to view the source data based on which the alert was generated. 
4.	Click Alerted Entry for an alert to view the event associated with the alert.
5.	Optionally, use the Search field to filter alerts based on a criteria. NEED SPECIFICS

Investigating Alerts
--------------------
Deep dive or investigate an alert to determine the actions you might need to take. 
Perform these steps to investigate an alert:
1.	Click Investigate for an alert. 
    The Alert Data page is displayed. 
2.	Review alert details.
    a.	View alert-related details, such as node, severity, alert type, source, and intel data.
    b.	For rule-based alerts, the rule name field displays the rule that was matched for the generated alert. Click the rule name to view or update the predefined rule. 
    c.	If needed, click the node name to view endpoint details and run various queries to get node-specific information. Click recent activity to view latest node details.  Additionally, for node-specific information use the Search field available in the various tabs.   
    d.	Optionally, click View Intel Data to view the source data based on which the alert was generated. 
3.	Expand the Alerted Entry pane to view event-related details.
    a.	Review event-related details, such as ID, action, target path, and time. 
    b.	Optionally, click Alerted Entry to view the event. 
4.	Click the Host State tab to view node-related information. 
    a.	Click the uptime tab  
5.	Click the Host Events tab to 
