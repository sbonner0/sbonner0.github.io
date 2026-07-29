---
# the default layout is 'page'
icon: fas fa-info-circle
order: 4
---

Hi, I’m Stephen Bonner, a machine learning researcher based in Cambridge, UK, currently working in pre-clinical drug discovery at AstraZeneca. (Views expressed here are my own and don’t represent my employer.) I hold a PhD in machine learning from Durham University, and spent several years across postdoc and research roles, including a joint postdoc between AstraZeneca and Mila, before joining AstraZeneca full-time.

I’m particularly interested in applying LLMs to scientific problems, GPU performance, and Linux-based systems. This blog is where I document experiments, deep-dives, and lessons learned, especially when things don’t go quite as planned.

Outside of work, I enjoy cycling, skiing, photography, and tinkering with hardware and home lab setups. These topics may occasionally show up here too.

Feel free to get in touch on [LinkedIn](https://uk.linkedin.com/in/stephen-bonner-ml).

## Current Focus

A few things I’m currently digging into:

{% for item in site.data.profile.current_focus %}
- {{ item.text | default: item }}
{% endfor %}

## Tools Stack

Some of the tools and technologies I enjoy using (in no particular order and by no means an exhaustive list) include:

{% for group in site.data.profile.tools_stack %}
### {{ group.section }}

{% for tool in group.items %}
- [{{ tool.name }}]({{ tool.url }}){% if tool.note %}: {{ tool.note }}{% endif %}
{% endfor %}

{% endfor %}
