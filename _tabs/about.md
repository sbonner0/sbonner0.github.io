---
# the default layout is 'page'
icon: fas fa-info-circle
order: 4
---

Hi, I’m Stephen Bonner — a machine learning researcher currently working in pre-clinical drug discovery at AstraZeneca (Views expressed here are my own and do not represent my employer). I’m particularly interested in LLMs for scientific usecases, GPU performance, open-source software, and Linux-based systems. This blog is a place to document experiments, deep-dives, and lessons learned—especially when things don’t go quite as planned.

Outside of work, I enjoy cycling, skiing, photography, and tinkering with hardware and home lab setups - these topics may occasionally feature here as well.

Please feel free to contact me on [Linkedin](https://uk.linkedin.com/in/stephen-bonner-ml).

## Personal Metadata

**Location:** {{ site.data.profile.location }}  
**Timezone:** {{ site.data.profile.timezone }}

## Current Focus

Some current areas of focus and interest (outside of my day job) include:

{% for item in site.data.profile.current_focus %}
- {{ item }}
{% endfor %}

## Tools Stack

Some of the tools and technologies I enjoy using(in no particular order and by no means an exhaustive list) include:

{% for group in site.data.profile.tools_stack %}
### {{ group.section }}

{% for tool in group.items %}
- [{{ tool.name }}]({{ tool.url }}){% if tool.note %}: {{ tool.note }}{% endif %}
{% endfor %}

{% endfor %}
