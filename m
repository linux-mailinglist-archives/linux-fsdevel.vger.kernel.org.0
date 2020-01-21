Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D11143580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 02:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAUB6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 20:58:47 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34051 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727144AbgAUB6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:58:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0ToGDWNz_1579571920;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0ToGDWNz_1579571920)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 09:58:41 +0800
Subject: Re: [PATCH v7 2/2] sched/numa: documentation for per-cgroup numa,
 statistics
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <443641e7-f968-0954-5ff6-3b7e7fed0e83@linux.alibaba.com>
 <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
 <a95a7e05-ad60-b9ee-ca39-f46c8e08887d@linux.alibaba.com>
 <628ab349-af6e-10a5-af56-2e30ab178539@linux.alibaba.com>
 <6ece8405-650c-69a0-09eb-e7f1f84c0c3f@infradead.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <fa57a70b-dfbc-7f2a-0953-89614bd98a6e@linux.alibaba.com>
Date:   Tue, 21 Jan 2020 09:58:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <6ece8405-650c-69a0-09eb-e7f1f84c0c3f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/21 上午8:12, Randy Dunlap wrote:
> Hi,
> 
> Documentation edits below...
> 

Thx Randy :-) I've send v8 which should have included all the
edits below.

Regards,
Michael Wang

> On 1/18/20 10:09 PM, 王贇 wrote:
>> Add the description for 'numa_locality', also a new doc to explain
>> the details on how to deal with the per-cgroup numa statistics.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Michal Koutný <mkoutny@suse.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Iurii Zaikin <yzaikin@google.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>> ---
>>  Documentation/admin-guide/cg-numa-stat.rst      | 178 ++++++++++++++++++++++++
>>  Documentation/admin-guide/index.rst             |   1 +
>>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>>  init/Kconfig                                    |   2 +
>>  5 files changed, 194 insertions(+)
>>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst
>>
>> diff --git a/Documentation/admin-guide/cg-numa-stat.rst b/Documentation/admin-guide/cg-numa-stat.rst
>> new file mode 100644
>> index 000000000000..30ebe5d6404f
>> --- /dev/null
>> +++ b/Documentation/admin-guide/cg-numa-stat.rst
>> @@ -0,0 +1,178 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===============================
>> +Per-cgroup NUMA statistics
>> +===============================
>> +
>> +Background
>> +----------
>> +
>> +On NUMA platforms, remote memory accessing always has a performance penalty.
>> +Although we have NUMA balancing working hard to maximize the access locality,
>> +there are still situations it can't help.
>> +
>> +This could happen in modern production environment. When a large number of
>> +cgroups are used to classify and control resources, this creates a complex
>> +configuration for memory policy, CPUs and NUMA nodes. In such cases NUMA
>> +balancing could end up with the wrong memory policy or exhausted local NUMA
>> +node, which would lead to low percentage of local page accesses.
>> +
>> +We need to detect such cases, figure out which workloads from which cgroup
>> +have introduced the issues, then we get chance to do adjustment to avoid
>> +performance degradation.
>> +
>> +However, there are no hardware counters for per-task local/remote accessing
>> +info, we don't know how many remote page accesses have occurred for a
>> +particular task.
>> +
>> +NUMA Locality
>> +-------------
>> +
>> +Fortunately, we have NUMA Balancing which scans task's mapping and triggers
>> +page fault periodically, giving us the opportunity to record per-task page
>> +accessing info, when the CPU fall into PF is from the same node of pages, we
>> +consider task as doing local page accessing, otherwise the remote page
>> +accessing, we call these two counter the locality info.
> 
>                                 counters
> 
>> +
>> +On each tick, we acquire the locality info of current task on that CPU, update
>> +the increments into its cgroup, becoming the group locality info.
>> +
>> +By "echo 1 > /proc/sys/kernel/numa_locality" at runtime or adding boot parameter
>> +'numa_locality', we will enable the accounting of per-cgroup NUMA locality info,
>> +the 'cpu.numa_stat' entry of CPU cgroup will show statistics::
>> +
>> +  page_access local=NR_LOCAL_PAGE_ACCESS remote=NR_REMOTE_PAGE_ACCESS
>> +
>> +We define 'NUMA locality' as::
>> +
>> +  NR_LOCAL_PAGE_ACCESS * 100 / (NR_LOCAL_PAGE_ACCESS + NR_REMOTE_PAGE_ACCESS)
>> +
>> +This per-cgroup percentage number helps to represent the NUMA Balancing behavior.
>> +
>> +Note that the accounting is hierarchical, which means the NUMA locality info for
>> +a given group represent not only the workload of this group, but also the
> 
>                  represents
> 
>> +workloads of all its descendants.
>> +
>> +For example the 'cpu.numa_stat' shows::
>> +
>> +  page_access local=129909383 remote=18265810
>> +
>> +The NUMA locality calculated as::
>> +
>> +  129909383 * 100 / (129909383 + 18265810) = 87.67
>> +
>> +Thus we know the workload of this group and its descendants have totally done
>> +129909383 times of local page accessing and 18265810 times of remotes, locality
>> +is 87.67% which imply most of the memory access are local.
> 
>                    implies
> 
>> +
>> +NUMA Consumption
>> +----------------
>> +
>> +There are also other cgroup entry help us to estimate NUMA efficiency, which is
> 
>                                entries which help us to estimate NUMA efficiency. They are
> 
>> +'cpuacct.usage_percpu' and 'memory.numa_stat'.
>> +
>> +By reading 'cpuacct.usage_percpu' we will get per-cpu runtime (in nanoseconds)
>> +info (in hierarchy) as::
>> +
>> +  CPU_0_RUNTIME CPU_1_RUNTIME CPU_2_RUNTIME ... CPU_X_RUNTIME
>> +
>> +Combined with the info from::
>> +
>> +  cat /sys/devices/system/node/nodeX/cpulist
>> +
>> +We would be able to accumulate the runtime of CPUs into NUMA nodes, to get the
>> +per-cgroup node runtime info.
>> +
>> +By reading 'memory.numa_stat' we will get per-cgroup node memory consumption
>> +info as::
>> +
>> +  total=TOTAL_MEM N0=MEM_ON_NODE0 N1=MEM_ON_NODE1 ... NX=MEM_ON_NODEX
>> +
>> +Together we call these the per-cgroup NUMA consumption info, tell us how many
> 
>                                                                 telling us
> 
>> +resources a particular workload has consumed, on a particular NUMA node.
>> +
>> +Monitoring
>> +----------
>> +
>> +By monitoring the increments of locality info, we can easily know whether NUMA
>> +Balancing is working well for a particular workload.
>> +
>> +For example we take a 5 seconds sample period, then on each sampling we have::
>> +
>> +  local_diff = last_nr_local_page_access - nr_local_page_access
>> +  remote_diff = last_nr_remote_page_access - nr_remote_page_access
>> +
>> +and we get the locality in this period as::
>> +
>> +  locality = local_diff * 100 / (local_diff + remote_diff)
>> +
>> +We can plot a line for locality, when the line close to 100% things are good,
> 
>                           locality. When the line is close to 100%, things are good;
> 
>> +when getting close to 0% something is wrong, we can pick a proper watermark to
> 
>                                          wrong. We can pick
> 
>> +trigger warning message.
>> +
>> +You may want to drop the data if the local/remote_diff is too small, which
>> +implies there are not many available pages for NUMA Balancing to scan, ignoring
>> +would be fine since most likely the workload is insensitive to NUMA, or the
>> +memory topology is already good enough.
>> +
>> +Monitoring root group helps you control the overall situation, while you may
>> +also want to monitor all the leaf groups which contain the workloads, this
>> +helps to catch the mouse.
>> +
>> +Try to put your workload into also the cpuacct & memory cgroup, when NUMA
>> +Balancing is disabled or locality becomes too small, we may want to monitor
>> +the per-node runtime & memory info to see if the node consumption meet the
>> +requirements.
>> +
>> +For NUMA node X on each sampling we have::
>> +
>> +  runtime_X_diff = runtime_X - last_runtime_X
>> +  runtime_all_diff = runtime_all - last_runtime_all
>> +
>> +  runtime_percent_X = runtime_X_diff * 100 / runtime_all_diff
>> +  memory_percent_X = memory_X * 100 / memory_all
>> +
>> +These two percentages are usually matched on each node, workload should execute
>> +mostly on the node that contains most of its memory, but it's not guaranteed.
>> +
>> +The workload may only access a small part of its memory, in such cases although
>> +the majority of memory are remotely, locality could still be good.
> 
>                           are remote,
> 
>> +
>> +Thus to tell if things are fine or not depends on the understanding of system
>> +resource deployment, however, if you find node X got 100% memory percent but 0%
>> +runtime percent, definitely something is wrong.
>> +
>> +Troubleshooting
>> +---------------
>> +
>> +After identifying which workload introduced the bad locality, check:
>> +
>> +1). Is the workload bound to a particular NUMA node?
>> +2). Has any NUMA node run out of resources?
>> +
>> +There are several ways to bind task's memory with a NUMA node, the strict way
>> +like the MPOL_BIND memory policy or 'cpuset.mems' will limit the memory
>> +node where to allocate pages. In this situation, admin should make sure the
>> +task is allowed to run on the CPUs of that NUMA node, and make sure there are
>> +available CPU resource there.
> 
>                  resources
> 
>> +
>> +There are also ways to bind task's CPU with a NUMA node, like 'cpuset.cpus' or
>> +sched_setaffinity() syscall. In this situation, NUMA Balancing help to migrate
> 
>                                                                   helps
> 
>> +pages into that node, admin should make sure there are available memory there.
> 
>                                                       is
> 
>> +
>> +Admin could try to rebind or unbind the NUMA node to erase the damage, make a
>> +change then observe the statistics to see if things get better until the
>> +situation is acceptable.
>> +
>> +Highlights
>> +----------
>> +
>> +For some tasks, NUMA Balancing may be found to be unnecessary to scan pages,
>> +and locality could always be 0 or small number, don't pay attention to them
>> +since they most likely insensitive to NUMA.
>> +
>> +There is no accounting until the option is turned on, so enable it in advance
>> +if you want to have the whole history.
>> +
>> +We have per-task migfailed counter to tell how many page migration has been
> 
>                                                             migrations have   {drop: been}
> 
>> +failed for a particular task, you will find it in /proc/PID/sched entry.
> 
>                            task; you
> 
> 
> HTH.
> 
