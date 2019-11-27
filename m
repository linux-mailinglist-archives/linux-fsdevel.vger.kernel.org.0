Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5510A98C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 05:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfK0E6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 23:58:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0E6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K9hTuzCHbAYzj1xCpMz13v3VR7aCPjv4f1pPE00Xhr0=; b=OWw7WqYIwWPvh2z/0Fk3Oob2R
        pZiwWjIp+Th1rxNo10mlyghAxKfE3qnapJvBSxrZqs5MT7DAnAAtIdtV2OiMwGi2TXyOfCZ3xp8dK
        IiR1Wxj9djGUOQ+anNt78JXxy44bYwunTKjtbOTLzWfayyWjCq9dtYTTpkBxWKobDfeJdDxO4TBos
        MVN1V09kQtz0p87yvzjEErA4qUyBLODFdtgiH8iikLCdaP3VL5wpvcRjrcW9xt4JUMq0lg1XmEUMk
        7POqYKGyBCag3/ApTHPHpW6/KPQFSlWnnepDK4vwkr3/UTMgyyiYZJJCB/aQk7GrY3KKUPscWTCOG
        JL3qGwOeQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZpPG-0007Xd-JQ; Wed, 27 Nov 2019 04:58:26 +0000
Subject: Re: [PATCH v2 3/3] sched/numa: documentation for per-cgroup numa stat
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <cc35a710-c2ec-6c61-e30e-ee707798c5e9@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ce01935-84ba-e8b4-461b-8be388433950@infradead.org>
Date:   Tue, 26 Nov 2019 20:58:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <cc35a710-c2ec-6c61-e30e-ee707798c5e9@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/26/19 5:50 PM, 王贇 wrote:
> Since v1:
>   * thanks to Iurii for the better sentence
>   * thanks to Jonathan for the better format
> 
> Add the description for 'cg_numa_stat', also a new doc to explain
> the details on how to deal with the per-cgroup numa statistics.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

Hi,
I have a few comments/corrections. Please see below.

> ---
>  Documentation/admin-guide/cg-numa-stat.rst      | 163 ++++++++++++++++++++++++
>  Documentation/admin-guide/index.rst             |   1 +
>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>  4 files changed, 177 insertions(+)
>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst
> 
> diff --git a/Documentation/admin-guide/cg-numa-stat.rst b/Documentation/admin-guide/cg-numa-stat.rst
> new file mode 100644
> index 000000000000..6f505f46fe00
> --- /dev/null
> +++ b/Documentation/admin-guide/cg-numa-stat.rst
> @@ -0,0 +1,163 @@
> +===============================
> +Per-cgroup NUMA statistics
> +===============================
> +
> +Background
> +----------
> +
> +On NUMA platforms, remote memory accessing always has a performance penalty,

                                                                       penalty.

> +although we have NUMA balancing working hard to maximize the access locality,

   Although

> +there are still situations it can't help.
> +
> +This could happen in modern production environment. When a large number of
> +cgroups are used to classify and control resources, this creates a complex
> +configuration for memory policy, CPUs and NUMA nodes. In such cases NUMA
> +balancing could end up with the wrong memory policy or exhausted local NUMA
> +node, which would lead to low percentage of local page accesses.
> +
> +We need to detect such cases, figure out which workloads from which cgroup
> +has introduced the issues, then we get chance to do adjustment to avoid

   have

> +performance degradation.
> +
> +However, there are no hardware counters for per-task local/remote accessing
> +info, we don't know how many remote page accesses have occurred for a
> +particular task.
> +
> +Statistics
> +----------
> +
> +Fortunately, we have NUMA Balancing which scans task's mapping and triggers PF
> +periodically, gives us the opportunity to record per-task page accessing info.

                 giving

> +
> +By "echo 1 > /proc/sys/kernel/cg_numa_stat" at runtime or adding boot parameter
> +'cg_numa_stat', we will enable the accounting of per-cgroup numa statistics,

                                                               NUMA

> +the 'cpu.numa_stat' entry of CPU cgroup will show statistics::
> +
> +  locality -- execution time sectioned by task NUMA locality (in ms)
> +  exectime -- execution time sectioned by NUMA node (in ms)
> +
> +We define 'task NUMA locality' as::
> +
> +  nr_local_page_access * 100 / (nr_local_page_access + nr_remote_page_access)
> +
> +this per-task percentage value will be updated on the ticks for current task,

   This

> +and the access counter will be updated on task's NUMA balancing PF, so only
> +the pages which NUMA Balancing paid attention to will be accounted.
> +
> +On each tick, we acquire the locality of current task on that CPU, accumulating
> +the ticks into the counter of corresponding locality region, tasks from the
> +same group sharing the counters, becoming the group locality.
> +
> +Similarly, we acquire the NUMA node of current CPU where the current task is
> +executing on, accumulating the ticks into the counter of corresponding node,
> +becoming the per-cgroup node execution time.
> +
> +Note that the accounting is hierarchical, which means the numa statistics for

                                                             NUMA

> +a given group represents not only the workload of this group, but also the

                 represent

> +workloads of all it's descendants.

                    its

> +
> +For example the 'cpu.numa_stat' show::
> +
> +  locality 39541 60962 36842 72519 118605 721778 946553
> +  exectime 1220127 1458684
> +
> +The locality is sectioned into 7 regions, approximately as::
> +
> +  0-13% 14-27% 28-42% 43-56% 57-71% 72-85% 86-100%
> +
> +And exectime is sectioned into 2 nodes, 0 and 1 in this case.
> +
> +Thus we know the workload of this group and it's descendants have totally

                                               its

> +executed 1220127ms on node_0 and 1458684ms on node_1, tasks with locality
> +around 0~13% executed for 39541 ms, and tasks with locality around 87~100%
> +executed for 946553 ms, which imply most of the memory access are local.
> +
> +Monitoring
> +----------
> +
> +By monitoring the increments of these statistics, we can easily know whether
> +NUMA balancing is working well for a particular workload.
> +
> +For example we take a 5 secs sample period, and consider locality under 27%

                           seconds

> +is bad, then on each sampling we have::
> +
> +  region_bad = region_1 + region_2
> +  region_all = region_1 + region_2 + ... + region_7
> +
> +and we have the increments as::
> +
> +  region_bad_diff = region_bad - last_region_bad
> +  region_all_diff = region_all - last_region_all
> +
> +which finally become::
> +
> +  region_bad_percent = region_bad_diff * 100 / region_all_diff
> +
> +we can plot a line for region_bad_percent, when the line close to 0 things

   We

> +are good, when getting close to 100% something is wrong, we can pick a proper
> +watermark to trigger warning message.
> +
> +You may want to drop the data if the region_all is too small, which implies
> +there are not many available pages for NUMA Balancing, ignoring would be fine
> +since most likely the workload is insensitive to NUMA.
> +
> +Monitoring root group helps you control the overall situation, while you may
> +also want to monitor all the leaf groups which contain the workloads, this
> +helps to catch the mouse.
> +
> +The exectime could be useful when NUMA Balancing is disabled, or when locality
> +becomes too small, for NUMA node X we have::

               small. For

> +
> +  exectime_X_diff = exectime_X - last_exectime_X
> +  exectime_all_diff = exectime_all - last_exectime_all
> +
> +try to put your workload into a memory cgroup which providing per-node memory

   Try                                                 provides


> +consumption by 'memory.numa_stat' entry, then we could get::
> +
> +  memory_percent_X = memory_X * 100 / memory_all
> +  exectime_percent_X = exectime_X_diff * 100 / exectime_all_diff
> +
> +These two percentages are usually matched on each node, workload should execute
> +mostly on the node contain most of it's memory, but it's not guaranteed.

                 node that contains most of its

> +
> +The workload may only access a small part of it's memory, in such cases although

                                                its

> +the majority of memory are remotely, locality could still be good.
> +
> +Thus to tell if things are fine or not depends on the understanding of system
> +resource deployment, however, if you find node X got 100% memory percent but 0%
> +exectime percent, definitely something is wrong.
> +
> +Troubleshooting
> +---------------
> +
> +After identifying which workload introduced the bad locality, check:
> +
> +1). Is the workload bound to a particular NUMA node?
> +2). Has any NUMA node run out of resources?
> +
> +There are several ways to bind task's memory with a NUMA node, the strict way
> +like the MPOL_BIND memory policy or 'cpuset.mems' will limiting the memory

                                                     will limit

> +node where to allocate pages, in this situation, admin should make sure the

                          pages. In

> +task is allowed to run on the CPUs of that NUMA node, and make sure there are
> +available CPU resource there.
> +
> +There are also ways to bind task's CPU with a NUMA node, like 'cpuset.cpus' or
> +sched_setaffinity() syscall, in this situation, NUMA Balancing help to migrate

                       syscall. In

> +pages into that node, admin should make sure there are available memory there.
> +
> +Admin could try rebind or unbind the NUMA node to erase the damage, make a

               try to

> +change then observe the statistics see if things get better until the situation

               observe the statistics to see if

> +is acceptable.
> +
> +Highlights
> +----------
> +
> +For some tasks, NUMA Balancing may found no necessary to scan pages, and
> +locality could always be 0 or small number, don't pay attention to them
> +since they most likely insensitive to NUMA.
> +
> +There are no accounting until the option turned on, so enable it in advance

         is no accounting until the option is turned on,

> +if you want to have the whole history.
> +
> +We have per-task migfailed counter to tell how many page migration has been

I can't find any occurrence of 'migfailed' in the entire kernel source tree.
Maybe it is misspelled?

> +failed for a particular task, you will find it in /proc/PID/sched entry.


HTH.

-- 
~Randy

