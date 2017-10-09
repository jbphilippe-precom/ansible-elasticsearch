################################
# Elasticsearch
################################
{% if es_home_dir is defined %}
ES_HOME={{ es_home_dir }}
{% endif %}
# Elasticsearch home directory
#ES_HOME=/usr/share/elasticsearch

{% if es_conf_dir is defined %}
CONF_DIR={{ es_conf_dir }}
{% endif %}
# Elasticsearch configuration directory
#CONF_DIR=/etc/elasticsearch

{% if es_data_dir is defined %}
DATA_DIR={{ es_data_dir }}
{% endif %}
# Elasticsearch data directory
#DATA_DIR=/var/lib/elasticsearch

{% if es_log_dir is defined %}
LOG_DIR={{ es_log_dir }}
{% endif %}
# Elasticsearch logs directory
#LOG_DIR=/var/log/elasticsearch

{% if es_pid_dir is defined %}
PID_DIR={{ es_pid_dir }}
{% endif %}
# Elasticsearch PID directory
#PID_DIR=/var/run/elasticsearch

{% if es_heap_size is defined and es_version|version_compare("5.0.0",'<') %}
ES_HEAP_SIZE={{ es_heap_size }}
# Heap size defaults to 256m min, 1g max
# Set ES_HEAP_SIZE to 50% of available RAM, but no more than 31g
#ES_HEAP_SIZE=2g
{% endif %}

{% if es_heap_newsize is defined and es_version|version_compare("5.0.0",'<') %}
ES_HEAP_NEWSIZE={{ es_heap_newsize }}
# Heap new generation
#ES_HEAP_NEWSIZE=
{% endif %}

{% if es_direct_size is defined and es_version|version_compare("5.0.0",'<') %}
ES_DIRECT_SIZE={{ es_direct_size }}
# Maximum direct memory
#ES_DIRECT_SIZE=
{% endif %}

{% if es_java_opts is defined %}
ES_JAVA_OPTS="{{ es_java_opts }}"
{% endif %}
# Additional Java OPTS
#ES_JAVA_OPTS=

{% if es_restart_on_upgrade is defined %}
RESTART_ON_UPGRADE=true
{% endif %}
# Configure restart on package upgrade (true, every other setting will lead to not restarting)
#RESTART_ON_UPGRADE=true

{% if es_gc_log_file is defined %}
ES_GC_LOG_FILE={{ es_gc_log_file }}
{% endif %}
# Path to the GC log file
#ES_GC_LOG_FILE=/var/log/elasticsearch/gc.log

################################
# Elasticsearch service
################################

# SysV init.d
#
# When executing the init script, this user will be used to run the elasticsearch service.
# The default value is 'elasticsearch' and is declared in the init.d file.
# Note that this setting is only used by the init script. If changed, make sure that
# the configured user can read and write into the data, work, plugins and log directories.
# For systemd service, the user is usually configured in file /usr/lib/systemd/system/elasticsearch.service
{% if es_username is defined %}
ES_USER={{ es_username }}
{% endif %}
#ES_USER=elasticsearch
{% if es_groupname is defined %}
ES_GROUP={{ es_groupname }}
{% endif %}
#ES_GROUP=elasticsearch

# The number of seconds to wait before checking if Elasticsearch started successfully as a daemon process
{% if es_startup_stime is defined %}
ES_STARTUP_SLEEP_TIME={{ es_startup_stime }}
{% else %}
ES_STARTUP_SLEEP_TIME=5
{% endif %}

################################
# System properties
################################

# Specifies the maximum file descriptor number that can be opened by this process
# When using Systemd, this setting is ignored and the LimitNOFILE defined in
# /usr/lib/systemd/system/elasticsearch.service takes precedence
{% if es_max_open_files is defined %}
MAX_OPEN_FILES={{ es_max_open_files }}
{% endif %}
#MAX_OPEN_FILES=65536

# The maximum number of bytes of memory that may be locked into RAM
# Set to "unlimited" if you use the 'bootstrap.memory_lock: true' option
# in elasticsearch.yml (ES_HEAP_SIZE  must also be set).
# When using Systemd, the LimitMEMLOCK property must be set
# in /usr/lib/systemd/system/elasticsearch.service
{% if es_max_locked_memory is defined %}
MAX_LOCKED_MEMORY={{ es_max_locked_memory }}
{% endif %}
#MAX_LOCKED_MEMORY=unlimited

# Maximum number of VMA (Virtual Memory Areas) a process can own
# When using Systemd, this setting is ignored and the 'vm.max_map_count'
# property is set at boot time in /usr/lib/sysctl.d/elasticsearch.conf
{% if es_max_map_count is defined %}
MAX_MAP_COUNT={{ es_max_map_count }}
{% endif %}
#MAX_MAP_COUNT=262144
