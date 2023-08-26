# lsof.sh

List files open by process(es) written in shell script.

Author : Daniel Hoberecht

#### Why?

I wrote this because Synology devices (at time of writing) do not come with the lsof binary installed.

#### Usage:

```bash
## lsof.sh ##
Author: Daniel Hoberecht
Trimmed down version of lsof written in bash for devices without lsof
+------------------------------------+
| !! THIS APP MUST BE RUN AS ROOT !! |
+------------------------------------+
Usage: ./lsof.sh [-p <pid>] [-t <App Name>] [-a] [-c]
-a list all open files for all processes
-t list all open files for for grepped app.
-p list all open files for pid.
-c prints count of all files open by all processes
```

#### Example Output :

```shell
$> ./lsof.sh -t bash
15928 ; /usr/bin/bash ; danh ; /proc/15928/fd/0 ; /dev/pts/1
15928 ; /usr/bin/bash ; danh ; /proc/15928/fd/1 ; /dev/pts/1
15928 ; /usr/bin/bash ; danh ; /proc/15928/fd/2 ; /dev/pts/1
15928 ; /usr/bin/bash ; danh ; /proc/15928/fd/255 ; /dev/pts/1
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/0 ; /dev/null
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/1 ; socket:[137880]
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/2 ; socket:[137880]
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/255 ; /app/bin/discord
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/27 ; /home/danh/.local/share/gvfs-metadata/root (deleted)
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/28 ; /memfd:pulseaudio (deleted)
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/30 ; /home/danh/.local/share/gvfs-metadata/root-3373cc37.log (deleted)
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/34 ; /home/danh/.local/share/gvfs-metadata/home (deleted)
22994 ; /usr/bin/bash ; danh ; /proc/22994/fd/35 ; /home/danh/.local/share/gvfs-metadata/home-0057ac4d.log (deleted)
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/0 ; /dev/null
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/1 ; socket:[158483]
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/2 ; socket:[158483]
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/255 ; /app/share/zotero/zotero
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/27 ; /home/danh/.local/share/gvfs-metadata/root (deleted)
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/28 ; /memfd:pulseaudio (deleted)
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/30 ; /home/danh/.local/share/gvfs-metadata/root-3373cc37.log (deleted)
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/34 ; /home/danh/.local/share/gvfs-metadata/home (deleted)
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/35 ; /home/danh/.local/share/gvfs-metadata/home-0057ac4d.log (deleted)
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/41 ; /sys/devices/pci0000:00/0000:00:06.0/0000:01:00.0/nvme/nvme0/hwmon3/temp1_input
35406 ; /usr/bin/bash ; danh ; /proc/35406/fd/56 ; /sys/devices/system/cpu/cpufreq/policy9/scaling_cur_freq
42846 ; /usr/bin/bash ; danh ; /proc/42846/fd/0 ; /dev/pts/2
42846 ; /usr/bin/bash ; danh ; /proc/42846/fd/1 ; /dev/pts/2
42846 ; /usr/bin/bash ; danh ; /proc/42846/fd/2 ; /dev/pts/2
42846 ; /usr/bin/bash ; danh ; /proc/42846/fd/255 ; /dev/pts/2
57943 ; /usr/bin/bash ; root ; /proc/57943/fd/0 ; /dev/pts/3
57943 ; /usr/bin/bash ; root ; /proc/57943/fd/1 ; /dev/pts/3
57943 ; /usr/bin/bash ; root ; /proc/57943/fd/2 ; /dev/pts/3
57943 ; /usr/bin/bash ; root ; /proc/57943/fd/255 ; /home/danh/scripts/lsof.sh
57945 ; /usr/bin/bash ; root ; /proc/57945/fd/0 ; pipe:[224345]
57945 ; /usr/bin/bash ; root ; /proc/57945/fd/1 ; /dev/pts/3
57945 ; /usr/bin/bash ; root ; /proc/57945/fd/2 ; /dev/pts/3
57945 ; /usr/bin/bash ; root ; /proc/57945/fd/3 ; pipe:[223608]
9286 ; /usr/bin/bash ; danh ; /proc/9286/fd/0 ; /dev/pts/0
9286 ; /usr/bin/bash ; danh ; /proc/9286/fd/1 ; /dev/pts/0
9286 ; /usr/bin/bash ; danh ; /proc/9286/fd/2 ; /dev/pts/0
9286 ; /usr/bin/bash ; danh ; /proc/9286/fd/255 ; /dev/pts/0

```

#### Output Format

Output is semi-colon delimited in the following order: Pid;  exe name ; User permission ; path of symlink ; link target 
