[Unit]
Description=Elasticsearch
Documentation=http://www.elastic.co
Wants=network-online.target
After=network-online.target

[Service]
{% if es_home_dir is defined %}
Environment=ES_HOME={{ es_home_dir }}
{% else %}
Environment=ES_HOME=/usr/share/elasticsearch
{% endif %}
{% if es_conf_dir is defined %}
Environment=CONF_DIR={{ es_conf_dir }}
{% else %}
Environment=CONF_DIR=/etc/elasticsearch
{% endif %}
{% if es_data_dir is defined %}
Environment=DATA_DIR={{ es_data_dir }}
{% else %}
Environment=DATA_DIR=/var/lib/elasticsearch
{% endif %}
{% if es_log_dir is defined %}
Environment=LOG_DIR={{ es_log_dir }}
{% else %}
Environment=LOG_DIR=/var/log/elasticsearch
{% endif %}
{% if es_pid_dir is defined %}
Environment=PID_DIR={{ es_pid_dir }}
{% else %}
Environment=PID_DIR=/var/run/elasticsearch
{% endif %}
EnvironmentFile=-/etc/default/{{ es_environment_filename }}
WorkingDirectory=/usr/share/elasticsearch

User={{ es_username }}
Group={{ es_groupname }}

{% if es_version|version_compare("2.0.0",'>=') %}
ExecStartPre=/usr/share/elasticsearch/bin/elasticsearch-systemd-pre-exec
{% endif %}

{% if es_version|version_compare("5.0.0",'<') %}
ExecStart=/usr/share/elasticsearch/bin/elasticsearch \
                                                -Des.pidfile=${PID_DIR}/elasticsearch.pid \
                                                -Des.default.path.home=${ES_HOME} \
                                                -Des.default.path.logs=${LOG_DIR} \
                                                -Des.default.path.data=${DATA_DIR} \
                                                -Des.default.path.conf=${CONF_DIR}
{% else %}
ExecStart=/usr/share/elasticsearch/bin/elasticsearch \
                                                -p ${PID_DIR}/elasticsearch.pid \
                                                --quiet \
                                                -Edefault.path.logs=${LOG_DIR} \
                                                -Edefault.path.data=${DATA_DIR} \
                                                -Edefault.path.conf=${CONF_DIR}

{% endif %}



StandardOutput=journal
StandardError=inherit

# Specifies the maximum file descriptor number that can be opened by this process
LimitNOFILE=65536

# Specifies the maximum number of bytes of memory that may be locked into RAM
# Set to "infinity" if you use the 'bootstrap.memory_lock: true' option
# in elasticsearch.yml and 'MAX_LOCKED_MEMORY=unlimited' in /etc/default/elasticsearch
{% if es_old_lock_memory == 0 %}
LimitMEMLOCK=infinity
{% endif %}
#LimitMEMLOCK=infinity

# Disable timeout logic and wait until process is stopped
TimeoutStopSec=0

# SIGTERM signal is used to stop the Java process
KillSignal=SIGTERM

# Java process is never killed
SendSIGKILL=no

# When a JVM receives a SIGTERM signal it exits with code 143
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target

# Built for distribution-5.4.0 (distribution)
