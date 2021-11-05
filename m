Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB42B445FD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 07:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhKEGo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 02:44:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:18726 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhKEGo4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:44:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231698210"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="yaml'?old'?scan'208";a="231698210"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 23:42:15 -0700
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="yaml'?old'?scan'208";a="668155211"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 23:42:02 -0700
Date:   Fri, 5 Nov 2021 14:41:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: [fs]  a0918006f9:  netperf.Throughput_tps -11.6% regression
Message-ID: <20211105064159.GB17949@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012192410.2356090-2-mic@digikod.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -11.6% regression of netperf.Throughput_tps due to commit:


commit: a0918006f9284b77397ae4f163f055c3e0f987b2 ("[PATCH v15 1/3] fs: Add trusted_for(2) syscall implementation and related sysctl")
url: https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Add-trusted_for-2-was-O_MAYEXEC/20211013-032533
patch link: https://lore.kernel.org/kernel-hardening/20211012192410.2356090-2-mic@digikod.net

in testcase: netperf
on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 16
	cluster: cs-localhost
	test: TCP_CRR
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/


please be noted we made out some further analysis/tests, as Fengwei mentioned:
==============================================================================
Here is my investigation result of this regression:

If I add patch to make sure the kernel function address and data address is
almost same even with this patch, there is almost no performance delta(0.1%)
w/o the patch.

And if I only make sure function address same w/o the patch, the performance
delta is about 5.1%.

So suppose this regression is triggered by different function and data address.
We don't know why the different address could bring such kind of regression yet
===============================================================================


we also tested on other platforms.
on a Cooper Lake (Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory),
we also observed regression but the gap is smaller:
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/16/debian-10.4-x86_64-20200603.cgz/300s/lkp-cpl-4sp1/TCP_CRR/netperf/0x700001e

commit:
  v5.15-rc4
  a0918006f9284b77397ae4f163f055c3e0f987b2

       v5.15-rc4 a0918006f9284b77397ae4f163f
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    333492            -5.7%     314346 ±  2%  netperf.Throughput_total_tps
     20843            -4.5%      19896        netperf.Throughput_tps


but no regression on a 96 threads 2 sockets Ice Lake with 256G memory:
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/16/debian-10.4-x86_64-20200603.cgz/300s/lkp-icl-2sp1/TCP_CRR/netperf/0xb000280

commit:
  v5.15-rc4
  a0918006f9284b77397ae4f163f055c3e0f987b2

       v5.15-rc4 a0918006f9284b77397ae4f163f
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    555600            -0.1%     555305        netperf.Throughput_total_tps
     34725            -0.1%      34706        netperf.Throughput_tps


Fengwei also helped review these results and commented:
I suppose these three CPUs have different cache policy. It also could be
related with netperf throughput testing.


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/16/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/TCP_CRR/netperf/0x5003006

commit: 
  v5.15-rc4
  a0918006f9 ("fs: Add trusted_for(2) syscall implementation and related sysctl")

       v5.15-rc4 a0918006f9284b77397ae4f163f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    354692           -11.6%     313620        netperf.Throughput_total_tps
     22168           -11.6%      19601        netperf.Throughput_tps
 2.075e+08           -11.6%  1.834e+08        netperf.time.voluntary_context_switches
 1.064e+08           -11.6%   94086163        netperf.workload
      0.27 ± 35%      -0.1        0.22 ±  2%  mpstat.cpu.all.usr%
   2207583            -6.3%    2068413        vmstat.system.cs
   3029480 ±  6%     -23.3%    2324079 ±  7%  interrupts.CAL:Function_call_interrupts
     13768 ± 25%     -35.6%       8872 ± 23%  interrupts.CPU30.CAL:Function_call_interrupts
   2014617 ± 16%     -26.3%    1485200 ± 24%  softirqs.CPU180.NET_RX
 3.268e+08           -12.1%  2.874e+08        softirqs.NET_RX
    287881 ±  2%     +24.6%     358692        softirqs.TIMER
   3207001            -9.6%    2899010        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.01 ± 15%     +67.1%       0.01 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__release_sock.release_sock.sk_wait_data
      0.02 ±  2%     +23.3%       0.03 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_accept.do_accept
      0.01           +20.0%       0.01        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     63320 ±  2%     -10.6%      56615 ±  2%  slabinfo.sock_inode_cache.active_objs
      1626 ±  2%     -10.6%       1454 ±  2%  slabinfo.sock_inode_cache.active_slabs
     63445 ±  2%     -10.6%      56722 ±  2%  slabinfo.sock_inode_cache.num_objs
      1626 ±  2%     -10.6%       1454 ±  2%  slabinfo.sock_inode_cache.num_slabs
     49195            -3.2%      47624        proc-vmstat.nr_slab_reclaimable
   4278441            -6.6%    3996109        proc-vmstat.numa_hit
   4052317 ±  2%      -7.4%    3751341        proc-vmstat.numa_local
   4285136            -6.5%    4006356        proc-vmstat.pgalloc_normal
   1704913           -11.4%    1511123        proc-vmstat.pgfree
 9.382e+09           -10.1%  8.438e+09        perf-stat.i.branch-instructions
 1.391e+08           -10.0%  1.252e+08        perf-stat.i.branch-misses
     13.98            +2.2       16.20        perf-stat.i.cache-miss-rate%
  87082775           +14.0%   99273064        perf-stat.i.cache-misses
   2231661            -6.4%    2088571        perf-stat.i.context-switches
      1.65            +8.6%       1.79        perf-stat.i.cpi
 7.603e+10            -2.1%  7.441e+10        perf-stat.i.cpu-cycles
    907.53 ±  2%     -13.0%     789.92 ±  2%  perf-stat.i.cycles-between-cache-misses
    920324 ± 19%     -20.3%     733572 ±  5%  perf-stat.i.dTLB-load-misses
 1.417e+10           -10.3%  1.271e+10        perf-stat.i.dTLB-loads
    182445 ± 16%     -57.6%      77419 ±  9%  perf-stat.i.dTLB-store-misses
 8.254e+09           -10.3%  7.403e+09        perf-stat.i.dTLB-stores
     88.23            -1.7       86.52        perf-stat.i.iTLB-load-miss-rate%
  96633753           -11.0%   85983323        perf-stat.i.iTLB-load-misses
  12277057            +4.0%   12766535        perf-stat.i.iTLB-loads
 4.741e+10           -10.2%  4.259e+10        perf-stat.i.instructions
      0.62            -8.2%       0.57        perf-stat.i.ipc
      0.40            -2.1%       0.39        perf-stat.i.metric.GHz
    168.88           -10.1%     151.87        perf-stat.i.metric.M/sec
  16134360 ±  2%     +15.0%   18550862        perf-stat.i.node-load-misses
   1576525 ±  2%     +10.0%    1734370 ±  2%  perf-stat.i.node-loads
  10027868           -11.5%    8871598        perf-stat.i.node-store-misses
    386034 ±  3%     -16.0%     324290 ±  7%  perf-stat.i.node-stores
     13.15            +9.2%      14.36        perf-stat.overall.MPKI
     13.97            +2.3       16.23        perf-stat.overall.cache-miss-rate%
      1.60            +8.9%       1.75        perf-stat.overall.cpi
    873.29           -14.2%     749.60        perf-stat.overall.cycles-between-cache-misses
      0.00 ± 15%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     88.73            -1.7       87.07        perf-stat.overall.iTLB-load-miss-rate%
      0.62            -8.2%       0.57        perf-stat.overall.ipc
    135778            +1.7%     138069        perf-stat.overall.path-length
 9.351e+09           -10.1%   8.41e+09        perf-stat.ps.branch-instructions
 1.387e+08           -10.0%  1.248e+08        perf-stat.ps.branch-misses
  86797490           +14.0%   98949207        perf-stat.ps.cache-misses
   2224197            -6.4%    2081616        perf-stat.ps.context-switches
 7.578e+10            -2.1%  7.416e+10        perf-stat.ps.cpu-cycles
    917495 ± 19%     -20.3%     731365 ±  5%  perf-stat.ps.dTLB-load-misses
 1.412e+10           -10.3%  1.267e+10        perf-stat.ps.dTLB-loads
    181859 ± 16%     -57.6%      77179 ±  9%  perf-stat.ps.dTLB-store-misses
 8.227e+09           -10.3%  7.379e+09        perf-stat.ps.dTLB-stores
  96313891           -11.0%   85700283        perf-stat.ps.iTLB-load-misses
  12236194            +4.0%   12724086        perf-stat.ps.iTLB-loads
 4.726e+10           -10.2%  4.245e+10        perf-stat.ps.instructions
  16081690 ±  2%     +15.0%   18490522        perf-stat.ps.node-load-misses
   1571411 ±  2%     +10.0%    1728755 ±  2%  perf-stat.ps.node-loads
   9995103           -11.5%    8842824        perf-stat.ps.node-store-misses
    385193 ±  3%     -16.0%     323588 ±  7%  perf-stat.ps.node-stores
 1.445e+13           -10.1%  1.299e+13        perf-stat.total.instructions
      1.51 ±  7%      -0.2        1.29 ±  7%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.48 ±  7%      -0.2        1.26 ±  7%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      1.49 ±  7%      -0.2        1.27 ±  7%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.50 ±  7%      -0.2        1.27 ±  7%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.47 ±  7%      -0.2        1.25 ±  7%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      1.41 ±  7%      -0.2        1.19 ±  7%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      1.25 ±  7%      -0.2        1.06 ±  7%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      1.21 ±  7%      -0.2        1.03 ±  7%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.rcu_do_batch.rcu_core
      0.94 ±  7%      -0.1        0.80 ±  7%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.rcu_do_batch
      0.62 ±  7%      +0.2        0.80 ±  9%  perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.51 ±  7%      -0.2        1.29 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.children.cycles-pp.kthread
      1.50 ±  7%      -0.2        1.27 ±  7%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.73 ±  6%      -0.2        1.51 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      1.25 ±  5%      -0.2        1.07 ±  6%  perf-profile.children.cycles-pp.lock_sock_nested
      1.03 ±  7%      -0.1        0.88 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.83 ±  6%      -0.1        0.72 ±  6%  perf-profile.children.cycles-pp.sk_clone_lock
      0.84 ±  6%      -0.1        0.73 ±  6%  perf-profile.children.cycles-pp.inet_csk_clone_lock
      0.45 ±  8%      -0.1        0.34 ±  6%  perf-profile.children.cycles-pp.__tcp_get_metrics
      0.70 ±  6%      -0.1        0.60 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.52 ±  8%      -0.1        0.42 ±  6%  perf-profile.children.cycles-pp.tcp_get_metrics
      0.72 ±  5%      -0.1        0.62 ±  6%  perf-profile.children.cycles-pp.sk_forced_mem_schedule
      0.32 ±  7%      -0.1        0.24 ±  7%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.49 ±  7%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.tcp_v4_destroy_sock
      0.26 ±  7%      -0.0        0.22 ±  8%  perf-profile.children.cycles-pp.ip_finish_output
      0.29 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.tcp_write_queue_purge
      0.16 ± 10%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__destroy_inode
      0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.destroy_inode
      0.10 ±  9%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.sock_put
      0.10 ± 10%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.d_instantiate
      0.08 ± 11%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_trace
      0.11 ±  8%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__inet_lookup_listener
      0.08 ±  9%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.inet_lhash2_lookup
      0.10 ±  7%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.tcp_ca_openreq_child
      0.08 ±  9%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.tcp_newly_delivered
      0.08 ±  6%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.tcp_mtup_init
      0.09 ±  8%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.tcp_stream_memory_free
      0.24 ±  6%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.ip_rcv_core
      0.06 ±  9%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.tcp_push
      0.11 ±  9%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.tcp_synack_rtt_meas
      0.00 ±412%      +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.tcp_rack_update_reo_wnd
      0.20 ±  8%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.tcp_assign_congestion_control
      0.34 ±  8%      +0.1        0.42 ±  6%  perf-profile.children.cycles-pp.tcp_init_metrics
      0.14 ±  6%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.tcp_sync_mss
      0.33 ±  5%      +0.1        0.41 ±  8%  perf-profile.children.cycles-pp.inet_csk_route_req
      0.31 ±  6%      +0.1        0.40 ±  6%  perf-profile.children.cycles-pp.inet_csk_route_child_sock
      0.13 ±  8%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.skb_entail
      0.21 ±  6%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.24 ±  5%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.ip_rcv_finish
      0.20 ±  7%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.tcp_select_initial_window
      0.14 ±  5%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.secure_tcp_ts_off
      0.45 ±  6%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.tcp_finish_connect
      0.23 ±  5%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.tcp_parse_options
      0.17 ±  7%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
      0.20 ±  7%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.tcp_openreq_init_rwin
      0.27 ±  9%      +0.1        0.42 ±  7%  perf-profile.children.cycles-pp.tcp_connect_init
      0.45 ±  7%      +0.2        0.60 ±  5%  perf-profile.children.cycles-pp.tcp_v4_init_sock
      0.44 ±  7%      +0.2        0.60 ±  6%  perf-profile.children.cycles-pp.tcp_init_sock
      0.23 ±  7%      +0.2        0.39 ±  6%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.35 ±  6%      +0.2        0.57 ±  7%  perf-profile.children.cycles-pp.inet_sk_rebuild_header
      0.25 ±  9%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.__tcp_select_window
      0.35 ±  6%      +0.3        0.61 ±  6%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.76 ±  5%      +0.3        1.04 ±  6%  perf-profile.children.cycles-pp.ip_route_output_flow
      0.78 ±  6%      +0.3        1.08 ±  6%  perf-profile.children.cycles-pp.tcp_init_transfer
      1.78 ±  6%      +0.3        2.11 ±  6%  perf-profile.children.cycles-pp.tcp_conn_request
      1.07 ±  4%      +0.4        1.44 ±  5%  perf-profile.children.cycles-pp.ip_route_output_key_hash
      1.02 ±  5%      +0.4        1.40 ±  5%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      2.02 ±  5%      +0.5        2.50 ±  6%  perf-profile.children.cycles-pp.tcp_ack
      1.04 ±  7%      +0.6        1.63 ±  7%  perf-profile.children.cycles-pp.__sk_dst_check
      1.18 ±  7%      +0.7        1.86 ±  7%  perf-profile.children.cycles-pp.ipv4_dst_check
      5.95 ±  5%      +0.9        6.87 ±  6%  perf-profile.children.cycles-pp.tcp_v4_connect
      1.02 ±  7%      -0.2        0.87 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.44 ±  8%      -0.1        0.34 ±  6%  perf-profile.self.cycles-pp.__tcp_get_metrics
      0.69 ±  6%      -0.1        0.59 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.71 ±  5%      -0.1        0.61 ±  6%  perf-profile.self.cycles-pp.sk_forced_mem_schedule
      0.32 ±  6%      -0.1        0.26 ±  8%  perf-profile.self.cycles-pp.ip_finish_output2
      0.35 ±  7%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.15 ±  7%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.17 ±  6%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__skb_clone
      0.07 ±  5%      -0.0        0.04 ± 43%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.09 ±  9%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.08 ±  7%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.release_sock
      0.07 ± 10%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.tcp_create_openreq_child
      0.11 ±  7%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.tcp_connect
      0.08 ±  9%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.inet_lhash2_lookup
      0.09 ±  9%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.inet_csk_get_port
      0.08 ± 10%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.tcp_init_transfer
      0.08 ±  9%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.tcp_newly_delivered
      0.07 ±  7%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.tcp_mtup_init
      0.35 ±  5%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.16 ±  7%      +0.1        0.22 ±  6%  perf-profile.self.cycles-pp.__inet_bind
      0.09 ±  8%      +0.1        0.15 ±  6%  perf-profile.self.cycles-pp.tcp_stream_memory_free
      0.24 ±  6%      +0.1        0.30 ±  8%  perf-profile.self.cycles-pp.ip_rcv_core
      0.06 ±  9%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.tcp_push
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.tcp_rack_update_reo_wnd
      0.23 ±  8%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.ip_output
      0.20 ±  8%      +0.1        0.28 ±  5%  perf-profile.self.cycles-pp.tcp_assign_congestion_control
      0.10 ±  8%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.tcp_v4_syn_recv_sock
      0.09 ±  7%      +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.tcp_openreq_init_rwin
      0.07 ± 10%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.tcp_v4_send_synack
      0.13 ±  7%      +0.1        0.22 ±  7%  perf-profile.self.cycles-pp.tcp_sync_mss
      0.12 ±  8%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.skb_entail
      0.18 ±  8%      +0.1        0.27 ±  6%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.21 ±  5%      +0.1        0.31 ±  6%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.15 ±  9%      +0.1        0.26 ±  6%  perf-profile.self.cycles-pp.tcp_update_metrics
      0.20 ±  8%      +0.1        0.31 ±  5%  perf-profile.self.cycles-pp.tcp_select_initial_window
      0.12 ±  9%      +0.1        0.25 ±  8%  perf-profile.self.cycles-pp.tcp_connect_init
      0.11 ±  8%      +0.1        0.24 ±  8%  perf-profile.self.cycles-pp.secure_tcp_ts_off
      0.22 ±  5%      +0.1        0.35 ±  5%  perf-profile.self.cycles-pp.tcp_parse_options
      0.13 ± 12%      +0.1        0.27 ±  7%  perf-profile.self.cycles-pp.tcp_init_metrics
      0.17 ±  7%      +0.1        0.30 ±  7%  perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.17 ± 10%      +0.2        0.32 ±  6%  perf-profile.self.cycles-pp.tcp_init_sock
      0.18 ±  8%      +0.2        0.35 ±  6%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.42 ±  8%      +0.2        0.62 ±  7%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.25 ±  8%      +0.2        0.48 ±  7%  perf-profile.self.cycles-pp.__tcp_select_window
      0.28 ±  8%      +0.3        0.56 ±  5%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.71 ±  5%      +0.4        1.09 ±  6%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      1.17 ±  7%      +0.7        1.84 ±  7%  perf-profile.self.cycles-pp.ipv4_dst_check


                                                                                
                               netperf.Throughput_tps                           
                                                                                
  22500 +-------------------------------------------------------------------+   
        |        ...+......                           ...+......+.....+.....|   
  22000 |.....+..          +.....+.....+.....+.....+..                      |   
        |                                                                   |   
        |                                                                   |   
  21500 |-+                                                                 |   
        |                                                                   |   
  21000 |-+                                                                 |   
        |                                                                   |   
  20500 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  20000 |-+                                                                 |   
        |     O     O            O     O                 O                  |   
  19500 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            netperf.Throughput_total_tps                        
                                                                                
  360000 +------------------------------------------------------------------+   
  355000 |-+      ...+.....                ...+.....   ...+..         +.....|   
         |.....+..         +.....+.....+...         +..                     |   
  350000 |-+                                                                |   
  345000 |-+                                                                |   
         |                                                                  |   
  340000 |-+                                                                |   
  335000 |-+                                                                |   
  330000 |-+                                                                |   
         |                                                                  |   
  325000 |-+                                                                |   
  320000 |-+                                                                |   
         |                                                                  |   
  315000 |-+   O     O     O     O     O      O     O     O     O     O     |   
  310000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   netperf.workload                             
                                                                                
  1.08e+08 +----------------------------------------------------------------+   
           |        ...+.....+.....         ..+.....   ...+..         +.....|   
  1.06e+08 |.....+..               +.....+..        +..                     |   
  1.04e+08 |-+                                                              |   
           |                                                                |   
  1.02e+08 |-+                                                              |   
           |                                                                |   
     1e+08 |-+                                                              |   
           |                                                                |   
   9.8e+07 |-+                                                              |   
   9.6e+07 |-+                                                              |   
           |                                                                |   
   9.4e+07 |-+   O     O     O     O     O    O     O     O     O     O     |   
           |                                                                |   
   9.2e+07 +----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        netperf.time.voluntary_context_switches                 
                                                                                
   2.1e+08 +----------------------------------------------------------------+   
           |.....+.....+.....+.....+.....+....+.....   ...+..         +.....|   
  2.05e+08 |-+                                      +..                     |   
           |                                                                |   
           |                                                                |   
     2e+08 |-+                                                              |   
           |                                                                |   
  1.95e+08 |-+                                                              |   
           |                                                                |   
   1.9e+08 |-+                                                              |   
           |                                                                |   
           |                                                                |   
  1.85e+08 |-+   O     O     O     O     O          O     O                 |   
           |                                  O                 O     O     |   
   1.8e+08 +----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   0.006 +------------------------------------------------------------------+   
         |                                                                  |   
         |                                                                  |   
  0.0058 |-+                                                                |   
         |                                                                  |   
         |                                                                  |   
  0.0056 |-+                                                                |   
         |                                                                  |   
  0.0054 |-+                                                                |   
         |                                                                  |   
         |                                                                  |   
  0.0052 |-+                                                                |   
         |                                                                  |   
         |                                                                  |   
   0.005 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  3.25e+06 +----------------------------------------------------------------+   
           |.....   ...+....          ...+....+.....+.....+.....   ...+.....|   
   3.2e+06 |-+   +..        .   ...+..                          +..         |   
           |                 +..                                            |   
  3.15e+06 |-+                                                              |   
   3.1e+06 |-+                                                              |   
           |                                                                |   
  3.05e+06 |-+                                                              |   
           |                                                                |   
     3e+06 |-+                                                              |   
  2.95e+06 |-+                                                              |   
           |                                                                |   
   2.9e+06 |-+   O     O     O           O    O     O     O     O     O     |   
           |                       O                                        |   
  2.85e+06 +----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-icl-2sp1: 96 threads 2 sockets Ice Lake with 256G memory





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--dc+cDN39EJAMEtIO
Content-Type: application/x-trash
Content-Disposition: attachment; filename="config-5.15.0-rc4-00001-ga0918006f928.old"
Content-Transfer-Encoding: quoted-printable

#=0A# Automatically generated file; DO NOT EDIT.=0A# Linux/x86_64 5.15.0-rc=
4 Kernel Configuration=0A#=0ACONFIG_CC_VERSION_TEXT=3D"gcc-9 (Debian 9.3.0-=
22) 9.3.0"=0ACONFIG_CC_IS_GCC=3Dy=0ACONFIG_GCC_VERSION=3D90300=0ACONFIG_CLA=
NG_VERSION=3D0=0ACONFIG_AS_IS_GNU=3Dy=0ACONFIG_AS_VERSION=3D23502=0ACONFIG_=
LD_IS_BFD=3Dy=0ACONFIG_LD_VERSION=3D23502=0ACONFIG_LLD_VERSION=3D0=0ACONFIG=
_CC_CAN_LINK=3Dy=0ACONFIG_CC_CAN_LINK_STATIC=3Dy=0ACONFIG_CC_HAS_ASM_GOTO=
=3Dy=0ACONFIG_CC_HAS_ASM_INLINE=3Dy=0ACONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy=
=0ACONFIG_IRQ_WORK=3Dy=0ACONFIG_BUILDTIME_TABLE_SORT=3Dy=0ACONFIG_THREAD_IN=
FO_IN_TASK=3Dy=0A=0A#=0A# General setup=0A#=0ACONFIG_INIT_ENV_ARG_LIMIT=3D3=
2=0A# CONFIG_COMPILE_TEST is not set=0A# CONFIG_WERROR is not set=0ACONFIG_=
LOCALVERSION=3D""=0ACONFIG_LOCALVERSION_AUTO=3Dy=0ACONFIG_BUILD_SALT=3D""=
=0ACONFIG_HAVE_KERNEL_GZIP=3Dy=0ACONFIG_HAVE_KERNEL_BZIP2=3Dy=0ACONFIG_HAVE=
_KERNEL_LZMA=3Dy=0ACONFIG_HAVE_KERNEL_XZ=3Dy=0ACONFIG_HAVE_KERNEL_LZO=3Dy=
=0ACONFIG_HAVE_KERNEL_LZ4=3Dy=0ACONFIG_HAVE_KERNEL_ZSTD=3Dy=0ACONFIG_KERNEL=
_GZIP=3Dy=0A# CONFIG_KERNEL_BZIP2 is not set=0A# CONFIG_KERNEL_LZMA is not =
set=0A# CONFIG_KERNEL_XZ is not set=0A# CONFIG_KERNEL_LZO is not set=0A# CO=
NFIG_KERNEL_LZ4 is not set=0A# CONFIG_KERNEL_ZSTD is not set=0ACONFIG_DEFAU=
LT_INIT=3D""=0ACONFIG_DEFAULT_HOSTNAME=3D"(none)"=0ACONFIG_SWAP=3Dy=0ACONFI=
G_SYSVIPC=3Dy=0ACONFIG_SYSVIPC_SYSCTL=3Dy=0ACONFIG_POSIX_MQUEUE=3Dy=0ACONFI=
G_POSIX_MQUEUE_SYSCTL=3Dy=0A# CONFIG_WATCH_QUEUE is not set=0ACONFIG_CROSS_=
MEMORY_ATTACH=3Dy=0A# CONFIG_USELIB is not set=0ACONFIG_AUDIT=3Dy=0ACONFIG_=
HAVE_ARCH_AUDITSYSCALL=3Dy=0ACONFIG_AUDITSYSCALL=3Dy=0A=0A#=0A# IRQ subsyst=
em=0A#=0ACONFIG_GENERIC_IRQ_PROBE=3Dy=0ACONFIG_GENERIC_IRQ_SHOW=3Dy=0ACONFI=
G_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy=0ACONFIG_GENERIC_PENDING_IRQ=3Dy=0ACON=
FIG_GENERIC_IRQ_MIGRATION=3Dy=0ACONFIG_GENERIC_IRQ_INJECTION=3Dy=0ACONFIG_H=
ARDIRQS_SW_RESEND=3Dy=0ACONFIG_IRQ_DOMAIN=3Dy=0ACONFIG_IRQ_DOMAIN_HIERARCHY=
=3Dy=0ACONFIG_GENERIC_MSI_IRQ=3Dy=0ACONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy=0ACON=
FIG_IRQ_MSI_IOMMU=3Dy=0ACONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy=0ACONFIG_GE=
NERIC_IRQ_RESERVATION_MODE=3Dy=0ACONFIG_IRQ_FORCED_THREADING=3Dy=0ACONFIG_S=
PARSE_IRQ=3Dy=0A# CONFIG_GENERIC_IRQ_DEBUGFS is not set=0A# end of IRQ subs=
ystem=0A=0ACONFIG_CLOCKSOURCE_WATCHDOG=3Dy=0ACONFIG_ARCH_CLOCKSOURCE_INIT=
=3Dy=0ACONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy=0ACONFIG_GENERIC_TIME_VSY=
SCALL=3Dy=0ACONFIG_GENERIC_CLOCKEVENTS=3Dy=0ACONFIG_GENERIC_CLOCKEVENTS_BRO=
ADCAST=3Dy=0ACONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy=0ACONFIG_GENERIC_CMO=
S_UPDATE=3Dy=0ACONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy=0ACONFIG_POSIX_CP=
U_TIMERS_TASK_WORK=3Dy=0ACONFIG_TIME_KUNIT_TEST=3Dm=0A=0A#=0A# Timers subsy=
stem=0A#=0ACONFIG_TICK_ONESHOT=3Dy=0ACONFIG_NO_HZ_COMMON=3Dy=0A# CONFIG_HZ_=
PERIODIC is not set=0A# CONFIG_NO_HZ_IDLE is not set=0ACONFIG_NO_HZ_FULL=3D=
y=0ACONFIG_CONTEXT_TRACKING=3Dy=0A# CONFIG_CONTEXT_TRACKING_FORCE is not se=
t=0ACONFIG_NO_HZ=3Dy=0ACONFIG_HIGH_RES_TIMERS=3Dy=0A# end of Timers subsyst=
em=0A=0ACONFIG_BPF=3Dy=0ACONFIG_HAVE_EBPF_JIT=3Dy=0ACONFIG_ARCH_WANT_DEFAUL=
T_BPF_JIT=3Dy=0A=0A#=0A# BPF subsystem=0A#=0ACONFIG_BPF_SYSCALL=3Dy=0ACONFI=
G_BPF_JIT=3Dy=0ACONFIG_BPF_JIT_ALWAYS_ON=3Dy=0ACONFIG_BPF_JIT_DEFAULT_ON=3D=
y=0A# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set=0A# CONFIG_BPF_PRELOAD is no=
t set=0A# CONFIG_BPF_LSM is not set=0A# end of BPF subsystem=0A=0A# CONFIG_=
PREEMPT_NONE is not set=0ACONFIG_PREEMPT_VOLUNTARY=3Dy=0A# CONFIG_PREEMPT i=
s not set=0ACONFIG_PREEMPT_COUNT=3Dy=0A# CONFIG_SCHED_CORE is not set=0A=0A=
#=0A# CPU/Task time and stats accounting=0A#=0ACONFIG_VIRT_CPU_ACCOUNTING=
=3Dy=0ACONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy=0ACONFIG_IRQ_TIME_ACCOUNTING=3Dy=
=0ACONFIG_HAVE_SCHED_AVG_IRQ=3Dy=0ACONFIG_BSD_PROCESS_ACCT=3Dy=0ACONFIG_BSD=
_PROCESS_ACCT_V3=3Dy=0ACONFIG_TASKSTATS=3Dy=0ACONFIG_TASK_DELAY_ACCT=3Dy=0A=
CONFIG_TASK_XACCT=3Dy=0ACONFIG_TASK_IO_ACCOUNTING=3Dy=0A# CONFIG_PSI is not=
 set=0A# end of CPU/Task time and stats accounting=0A=0ACONFIG_CPU_ISOLATIO=
N=3Dy=0A=0A#=0A# RCU Subsystem=0A#=0ACONFIG_TREE_RCU=3Dy=0A# CONFIG_RCU_EXP=
ERT is not set=0ACONFIG_SRCU=3Dy=0ACONFIG_TREE_SRCU=3Dy=0ACONFIG_TASKS_RCU_=
GENERIC=3Dy=0ACONFIG_TASKS_RCU=3Dy=0ACONFIG_TASKS_RUDE_RCU=3Dy=0ACONFIG_TAS=
KS_TRACE_RCU=3Dy=0ACONFIG_RCU_STALL_COMMON=3Dy=0ACONFIG_RCU_NEED_SEGCBLIST=
=3Dy=0ACONFIG_RCU_NOCB_CPU=3Dy=0A# end of RCU Subsystem=0A=0ACONFIG_BUILD_B=
IN2C=3Dy=0ACONFIG_IKCONFIG=3Dy=0ACONFIG_IKCONFIG_PROC=3Dy=0A# CONFIG_IKHEAD=
ERS is not set=0ACONFIG_LOG_BUF_SHIFT=3D20=0ACONFIG_LOG_CPU_MAX_BUF_SHIFT=
=3D12=0ACONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13=0A# CONFIG_PRINTK_INDEX is no=
t set=0ACONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy=0A=0A#=0A# Scheduler features=
=0A#=0A# CONFIG_UCLAMP_TASK is not set=0A# end of Scheduler features=0A=0AC=
ONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy=0ACONFIG_ARCH_WANT_BATCHED_UNMAP_TLB=
_FLUSH=3Dy=0ACONFIG_CC_HAS_INT128=3Dy=0ACONFIG_ARCH_SUPPORTS_INT128=3Dy=0AC=
ONFIG_NUMA_BALANCING=3Dy=0ACONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy=0ACONF=
IG_CGROUPS=3Dy=0ACONFIG_PAGE_COUNTER=3Dy=0ACONFIG_MEMCG=3Dy=0ACONFIG_MEMCG_=
SWAP=3Dy=0ACONFIG_MEMCG_KMEM=3Dy=0ACONFIG_BLK_CGROUP=3Dy=0ACONFIG_CGROUP_WR=
ITEBACK=3Dy=0ACONFIG_CGROUP_SCHED=3Dy=0ACONFIG_FAIR_GROUP_SCHED=3Dy=0ACONFI=
G_CFS_BANDWIDTH=3Dy=0ACONFIG_RT_GROUP_SCHED=3Dy=0ACONFIG_CGROUP_PIDS=3Dy=0A=
CONFIG_CGROUP_RDMA=3Dy=0ACONFIG_CGROUP_FREEZER=3Dy=0ACONFIG_CGROUP_HUGETLB=
=3Dy=0ACONFIG_CPUSETS=3Dy=0ACONFIG_PROC_PID_CPUSET=3Dy=0ACONFIG_CGROUP_DEVI=
CE=3Dy=0ACONFIG_CGROUP_CPUACCT=3Dy=0ACONFIG_CGROUP_PERF=3Dy=0ACONFIG_CGROUP=
_BPF=3Dy=0A# CONFIG_CGROUP_MISC is not set=0A# CONFIG_CGROUP_DEBUG is not s=
et=0ACONFIG_SOCK_CGROUP_DATA=3Dy=0ACONFIG_NAMESPACES=3Dy=0ACONFIG_UTS_NS=3D=
y=0ACONFIG_TIME_NS=3Dy=0ACONFIG_IPC_NS=3Dy=0ACONFIG_USER_NS=3Dy=0ACONFIG_PI=
D_NS=3Dy=0ACONFIG_NET_NS=3Dy=0ACONFIG_CHECKPOINT_RESTORE=3Dy=0ACONFIG_SCHED=
_AUTOGROUP=3Dy=0A# CONFIG_SYSFS_DEPRECATED is not set=0ACONFIG_RELAY=3Dy=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0ACONFIG_INITRAMFS_SOURCE=3D""=0ACONFIG_RD_GZIP=
=3Dy=0ACONFIG_RD_BZIP2=3Dy=0ACONFIG_RD_LZMA=3Dy=0ACONFIG_RD_XZ=3Dy=0ACONFIG=
_RD_LZO=3Dy=0ACONFIG_RD_LZ4=3Dy=0ACONFIG_RD_ZSTD=3Dy=0A# CONFIG_BOOT_CONFIG=
 is not set=0ACONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy=0A# CONFIG_CC_OPTIMIZE=
_FOR_SIZE is not set=0ACONFIG_LD_ORPHAN_WARN=3Dy=0ACONFIG_SYSCTL=3Dy=0ACONF=
IG_HAVE_UID16=3Dy=0ACONFIG_SYSCTL_EXCEPTION_TRACE=3Dy=0ACONFIG_HAVE_PCSPKR_=
PLATFORM=3Dy=0A# CONFIG_EXPERT is not set=0ACONFIG_UID16=3Dy=0ACONFIG_MULTI=
USER=3Dy=0ACONFIG_SGETMASK_SYSCALL=3Dy=0ACONFIG_SYSFS_SYSCALL=3Dy=0ACONFIG_=
FHANDLE=3Dy=0ACONFIG_POSIX_TIMERS=3Dy=0ACONFIG_PRINTK=3Dy=0ACONFIG_BUG=3Dy=
=0ACONFIG_ELF_CORE=3Dy=0ACONFIG_PCSPKR_PLATFORM=3Dy=0ACONFIG_BASE_FULL=3Dy=
=0ACONFIG_FUTEX=3Dy=0ACONFIG_FUTEX_PI=3Dy=0ACONFIG_EPOLL=3Dy=0ACONFIG_SIGNA=
LFD=3Dy=0ACONFIG_TIMERFD=3Dy=0ACONFIG_EVENTFD=3Dy=0ACONFIG_SHMEM=3Dy=0ACONF=
IG_AIO=3Dy=0ACONFIG_IO_URING=3Dy=0ACONFIG_ADVISE_SYSCALLS=3Dy=0ACONFIG_HAVE=
_ARCH_USERFAULTFD_WP=3Dy=0ACONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy=0ACONFIG_=
MEMBARRIER=3Dy=0ACONFIG_KALLSYMS=3Dy=0ACONFIG_KALLSYMS_ALL=3Dy=0ACONFIG_KAL=
LSYMS_ABSOLUTE_PERCPU=3Dy=0ACONFIG_KALLSYMS_BASE_RELATIVE=3Dy=0ACONFIG_USER=
FAULTFD=3Dy=0ACONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy=0ACONFIG_KCMP=3Dy=0A=
CONFIG_RSEQ=3Dy=0A# CONFIG_EMBEDDED is not set=0ACONFIG_HAVE_PERF_EVENTS=3D=
y=0A=0A#=0A# Kernel Performance Events And Counters=0A#=0ACONFIG_PERF_EVENT=
S=3Dy=0A# CONFIG_DEBUG_PERF_USE_VMALLOC is not set=0A# end of Kernel Perfor=
mance Events And Counters=0A=0ACONFIG_VM_EVENT_COUNTERS=3Dy=0ACONFIG_SLUB_D=
EBUG=3Dy=0A# CONFIG_COMPAT_BRK is not set=0A# CONFIG_SLAB is not set=0ACONF=
IG_SLUB=3Dy=0ACONFIG_SLAB_MERGE_DEFAULT=3Dy=0ACONFIG_SLAB_FREELIST_RANDOM=
=3Dy=0A# CONFIG_SLAB_FREELIST_HARDENED is not set=0ACONFIG_SHUFFLE_PAGE_ALL=
OCATOR=3Dy=0ACONFIG_SLUB_CPU_PARTIAL=3Dy=0ACONFIG_SYSTEM_DATA_VERIFICATION=
=3Dy=0ACONFIG_PROFILING=3Dy=0ACONFIG_TRACEPOINTS=3Dy=0A# end of General set=
up=0A=0ACONFIG_64BIT=3Dy=0ACONFIG_X86_64=3Dy=0ACONFIG_X86=3Dy=0ACONFIG_INST=
RUCTION_DECODER=3Dy=0ACONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"=0ACONFIG_LOCKDE=
P_SUPPORT=3Dy=0ACONFIG_STACKTRACE_SUPPORT=3Dy=0ACONFIG_MMU=3Dy=0ACONFIG_ARC=
H_MMAP_RND_BITS_MIN=3D28=0ACONFIG_ARCH_MMAP_RND_BITS_MAX=3D32=0ACONFIG_ARCH=
_MMAP_RND_COMPAT_BITS_MIN=3D8=0ACONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16=
=0ACONFIG_GENERIC_ISA_DMA=3Dy=0ACONFIG_GENERIC_BUG=3Dy=0ACONFIG_GENERIC_BUG=
_RELATIVE_POINTERS=3Dy=0ACONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy=0ACONFIG_GENERIC_C=
ALIBRATE_DELAY=3Dy=0ACONFIG_ARCH_HAS_CPU_RELAX=3Dy=0ACONFIG_ARCH_HAS_FILTER=
_PGPROT=3Dy=0ACONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy=0ACONFIG_NEED_PER_CPU_EMBE=
D_FIRST_CHUNK=3Dy=0ACONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy=0ACONFIG_ARCH_=
HIBERNATION_POSSIBLE=3Dy=0ACONFIG_ARCH_NR_GPIO=3D1024=0ACONFIG_ARCH_SUSPEND=
_POSSIBLE=3Dy=0ACONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy=0ACONFIG_AUDIT_ARCH=3D=
y=0ACONFIG_HAVE_INTEL_TXT=3Dy=0ACONFIG_X86_64_SMP=3Dy=0ACONFIG_ARCH_SUPPORT=
S_UPROBES=3Dy=0ACONFIG_FIX_EARLYCON_MEM=3Dy=0ACONFIG_PGTABLE_LEVELS=3D5=0AC=
ONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy=0A=0A#=0A# Processor type and features=
=0A#=0ACONFIG_SMP=3Dy=0ACONFIG_X86_FEATURE_NAMES=3Dy=0ACONFIG_X86_X2APIC=3D=
y=0ACONFIG_X86_MPPARSE=3Dy=0A# CONFIG_GOLDFISH is not set=0ACONFIG_RETPOLIN=
E=3Dy=0A# CONFIG_X86_CPU_RESCTRL is not set=0ACONFIG_X86_EXTENDED_PLATFORM=
=3Dy=0A# CONFIG_X86_NUMACHIP is not set=0A# CONFIG_X86_VSMP is not set=0ACO=
NFIG_X86_UV=3Dy=0A# CONFIG_X86_GOLDFISH is not set=0A# CONFIG_X86_INTEL_MID=
 is not set=0ACONFIG_X86_INTEL_LPSS=3Dy=0A# CONFIG_X86_AMD_PLATFORM_DEVICE =
is not set=0ACONFIG_IOSF_MBI=3Dy=0A# CONFIG_IOSF_MBI_DEBUG is not set=0ACON=
FIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy=0A# CONFIG_SCHED_OMIT_FRAME_POINTER is =
not set=0ACONFIG_HYPERVISOR_GUEST=3Dy=0ACONFIG_PARAVIRT=3Dy=0A# CONFIG_PARA=
VIRT_DEBUG is not set=0ACONFIG_PARAVIRT_SPINLOCKS=3Dy=0ACONFIG_X86_HV_CALLB=
ACK_VECTOR=3Dy=0A# CONFIG_XEN is not set=0ACONFIG_KVM_GUEST=3Dy=0ACONFIG_AR=
CH_CPUIDLE_HALTPOLL=3Dy=0A# CONFIG_PVH is not set=0ACONFIG_PARAVIRT_TIME_AC=
COUNTING=3Dy=0ACONFIG_PARAVIRT_CLOCK=3Dy=0A# CONFIG_JAILHOUSE_GUEST is not =
set=0A# CONFIG_ACRN_GUEST is not set=0A# CONFIG_MK8 is not set=0A# CONFIG_M=
PSC is not set=0A# CONFIG_MCORE2 is not set=0A# CONFIG_MATOM is not set=0AC=
ONFIG_GENERIC_CPU=3Dy=0ACONFIG_X86_INTERNODE_CACHE_SHIFT=3D6=0ACONFIG_X86_L=
1_CACHE_SHIFT=3D6=0ACONFIG_X86_TSC=3Dy=0ACONFIG_X86_CMPXCHG64=3Dy=0ACONFIG_=
X86_CMOV=3Dy=0ACONFIG_X86_MINIMUM_CPU_FAMILY=3D64=0ACONFIG_X86_DEBUGCTLMSR=
=3Dy=0ACONFIG_IA32_FEAT_CTL=3Dy=0ACONFIG_X86_VMX_FEATURE_NAMES=3Dy=0ACONFIG=
_CPU_SUP_INTEL=3Dy=0ACONFIG_CPU_SUP_AMD=3Dy=0ACONFIG_CPU_SUP_HYGON=3Dy=0ACO=
NFIG_CPU_SUP_CENTAUR=3Dy=0ACONFIG_CPU_SUP_ZHAOXIN=3Dy=0ACONFIG_HPET_TIMER=
=3Dy=0ACONFIG_HPET_EMULATE_RTC=3Dy=0ACONFIG_DMI=3Dy=0A# CONFIG_GART_IOMMU i=
s not set=0ACONFIG_MAXSMP=3Dy=0ACONFIG_NR_CPUS_RANGE_BEGIN=3D8192=0ACONFIG_=
NR_CPUS_RANGE_END=3D8192=0ACONFIG_NR_CPUS_DEFAULT=3D8192=0ACONFIG_NR_CPUS=
=3D8192=0ACONFIG_SCHED_SMT=3Dy=0ACONFIG_SCHED_MC=3Dy=0ACONFIG_SCHED_MC_PRIO=
=3Dy=0ACONFIG_X86_LOCAL_APIC=3Dy=0ACONFIG_X86_IO_APIC=3Dy=0ACONFIG_X86_RERO=
UTE_FOR_BROKEN_BOOT_IRQS=3Dy=0ACONFIG_X86_MCE=3Dy=0ACONFIG_X86_MCELOG_LEGAC=
Y=3Dy=0ACONFIG_X86_MCE_INTEL=3Dy=0ACONFIG_X86_MCE_AMD=3Dy=0ACONFIG_X86_MCE_=
THRESHOLD=3Dy=0ACONFIG_X86_MCE_INJECT=3Dm=0A=0A#=0A# Performance monitoring=
=0A#=0ACONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm=0ACONFIG_PERF_EVENTS_INTEL_RAPL=
=3Dm=0ACONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm=0A# CONFIG_PERF_EVENTS_AMD_POWER=
 is not set=0ACONFIG_PERF_EVENTS_AMD_UNCORE=3Dy=0A# end of Performance moni=
toring=0A=0ACONFIG_X86_16BIT=3Dy=0ACONFIG_X86_ESPFIX64=3Dy=0ACONFIG_X86_VSY=
SCALL_EMULATION=3Dy=0ACONFIG_X86_IOPL_IOPERM=3Dy=0ACONFIG_I8K=3Dm=0ACONFIG_=
MICROCODE=3Dy=0ACONFIG_MICROCODE_INTEL=3Dy=0ACONFIG_MICROCODE_AMD=3Dy=0ACON=
FIG_MICROCODE_OLD_INTERFACE=3Dy=0ACONFIG_X86_MSR=3Dy=0ACONFIG_X86_CPUID=3Dy=
=0ACONFIG_X86_5LEVEL=3Dy=0ACONFIG_X86_DIRECT_GBPAGES=3Dy=0A# CONFIG_X86_CPA=
_STATISTICS is not set=0A# CONFIG_AMD_MEM_ENCRYPT is not set=0ACONFIG_NUMA=
=3Dy=0A# CONFIG_AMD_NUMA is not set=0ACONFIG_X86_64_ACPI_NUMA=3Dy=0ACONFIG_=
NUMA_EMU=3Dy=0ACONFIG_NODES_SHIFT=3D10=0ACONFIG_ARCH_SPARSEMEM_ENABLE=3Dy=
=0ACONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy=0ACONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy=
=0A# CONFIG_ARCH_MEMORY_PROBE is not set=0ACONFIG_ARCH_PROC_KCORE_TEXT=3Dy=
=0ACONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000=0ACONFIG_X86_PMEM_LEGA=
CY_DEVICE=3Dy=0ACONFIG_X86_PMEM_LEGACY=3Dm=0ACONFIG_X86_CHECK_BIOS_CORRUPTI=
ON=3Dy=0A# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set=0ACONFIG=
_MTRR=3Dy=0ACONFIG_MTRR_SANITIZER=3Dy=0ACONFIG_MTRR_SANITIZER_ENABLE_DEFAUL=
T=3D1=0ACONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1=0ACONFIG_X86_PAT=3Dy=
=0ACONFIG_ARCH_USES_PG_UNCACHED=3Dy=0ACONFIG_ARCH_RANDOM=3Dy=0ACONFIG_X86_S=
MAP=3Dy=0ACONFIG_X86_UMIP=3Dy=0ACONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy=
=0ACONFIG_X86_INTEL_TSX_MODE_OFF=3Dy=0A# CONFIG_X86_INTEL_TSX_MODE_ON is no=
t set=0A# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set=0A# CONFIG_X86_SGX is n=
ot set=0ACONFIG_EFI=3Dy=0ACONFIG_EFI_STUB=3Dy=0ACONFIG_EFI_MIXED=3Dy=0A# CO=
NFIG_HZ_100 is not set=0A# CONFIG_HZ_250 is not set=0A# CONFIG_HZ_300 is no=
t set=0ACONFIG_HZ_1000=3Dy=0ACONFIG_HZ=3D1000=0ACONFIG_SCHED_HRTICK=3Dy=0AC=
ONFIG_KEXEC=3Dy=0ACONFIG_KEXEC_FILE=3Dy=0ACONFIG_ARCH_HAS_KEXEC_PURGATORY=
=3Dy=0A# CONFIG_KEXEC_SIG is not set=0ACONFIG_CRASH_DUMP=3Dy=0ACONFIG_KEXEC=
_JUMP=3Dy=0ACONFIG_PHYSICAL_START=3D0x1000000=0ACONFIG_RELOCATABLE=3Dy=0ACO=
NFIG_RANDOMIZE_BASE=3Dy=0ACONFIG_X86_NEED_RELOCS=3Dy=0ACONFIG_PHYSICAL_ALIG=
N=3D0x200000=0ACONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy=0ACONFIG_RANDOMIZE_MEMORY=
=3Dy=0ACONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa=0ACONFIG_HOTPLUG_CPU=
=3Dy=0ACONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy=0A# CONFIG_DEBUG_HOTPLUG_CPU0 is n=
ot set=0A# CONFIG_COMPAT_VDSO is not set=0ACONFIG_LEGACY_VSYSCALL_EMULATE=
=3Dy=0A# CONFIG_LEGACY_VSYSCALL_XONLY is not set=0A# CONFIG_LEGACY_VSYSCALL=
_NONE is not set=0A# CONFIG_CMDLINE_BOOL is not set=0ACONFIG_MODIFY_LDT_SYS=
CALL=3Dy=0ACONFIG_HAVE_LIVEPATCH=3Dy=0ACONFIG_LIVEPATCH=3Dy=0A# end of Proc=
essor type and features=0A=0ACONFIG_ARCH_HAS_ADD_PAGES=3Dy=0ACONFIG_ARCH_MH=
P_MEMMAP_ON_MEMORY_ENABLE=3Dy=0ACONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy=0A=0A#=
=0A# Power management and ACPI options=0A#=0ACONFIG_ARCH_HIBERNATION_HEADER=
=3Dy=0ACONFIG_SUSPEND=3Dy=0ACONFIG_SUSPEND_FREEZER=3Dy=0ACONFIG_HIBERNATE_C=
ALLBACKS=3Dy=0ACONFIG_HIBERNATION=3Dy=0ACONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy=
=0ACONFIG_PM_STD_PARTITION=3D""=0ACONFIG_PM_SLEEP=3Dy=0ACONFIG_PM_SLEEP_SMP=
=3Dy=0A# CONFIG_PM_AUTOSLEEP is not set=0A# CONFIG_PM_WAKELOCKS is not set=
=0ACONFIG_PM=3Dy=0ACONFIG_PM_DEBUG=3Dy=0A# CONFIG_PM_ADVANCED_DEBUG is not =
set=0A# CONFIG_PM_TEST_SUSPEND is not set=0ACONFIG_PM_SLEEP_DEBUG=3Dy=0A# C=
ONFIG_PM_TRACE_RTC is not set=0ACONFIG_PM_CLK=3Dy=0A# CONFIG_WQ_POWER_EFFIC=
IENT_DEFAULT is not set=0A# CONFIG_ENERGY_MODEL is not set=0ACONFIG_ARCH_SU=
PPORTS_ACPI=3Dy=0ACONFIG_ACPI=3Dy=0ACONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy=0A=
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy=0ACONFIG_ACPI_SYSTEM_POWER_STATES_SUPPO=
RT=3Dy=0A# CONFIG_ACPI_DEBUGGER is not set=0ACONFIG_ACPI_SPCR_TABLE=3Dy=0A#=
 CONFIG_ACPI_FPDT is not set=0ACONFIG_ACPI_LPIT=3Dy=0ACONFIG_ACPI_SLEEP=3Dy=
=0ACONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy=0ACONFIG_ACPI_EC_DEBUGFS=3Dm=0ACON=
FIG_ACPI_AC=3Dy=0ACONFIG_ACPI_BATTERY=3Dy=0ACONFIG_ACPI_BUTTON=3Dy=0ACONFIG=
_ACPI_VIDEO=3Dm=0ACONFIG_ACPI_FAN=3Dy=0ACONFIG_ACPI_TAD=3Dm=0ACONFIG_ACPI_D=
OCK=3Dy=0ACONFIG_ACPI_CPU_FREQ_PSS=3Dy=0ACONFIG_ACPI_PROCESSOR_CSTATE=3Dy=
=0ACONFIG_ACPI_PROCESSOR_IDLE=3Dy=0ACONFIG_ACPI_CPPC_LIB=3Dy=0ACONFIG_ACPI_=
PROCESSOR=3Dy=0ACONFIG_ACPI_IPMI=3Dm=0ACONFIG_ACPI_HOTPLUG_CPU=3Dy=0ACONFIG=
_ACPI_PROCESSOR_AGGREGATOR=3Dm=0ACONFIG_ACPI_THERMAL=3Dy=0ACONFIG_ACPI_PLAT=
FORM_PROFILE=3Dm=0ACONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy=0ACONFIG_ACPI_TAB=
LE_UPGRADE=3Dy=0A# CONFIG_ACPI_DEBUG is not set=0ACONFIG_ACPI_PCI_SLOT=3Dy=
=0ACONFIG_ACPI_CONTAINER=3Dy=0ACONFIG_ACPI_HOTPLUG_MEMORY=3Dy=0ACONFIG_ACPI=
_HOTPLUG_IOAPIC=3Dy=0ACONFIG_ACPI_SBS=3Dm=0ACONFIG_ACPI_HED=3Dy=0A# CONFIG_=
ACPI_CUSTOM_METHOD is not set=0ACONFIG_ACPI_BGRT=3Dy=0ACONFIG_ACPI_NFIT=3Dm=
=0A# CONFIG_NFIT_SECURITY_DEBUG is not set=0ACONFIG_ACPI_NUMA=3Dy=0A# CONFI=
G_ACPI_HMAT is not set=0ACONFIG_HAVE_ACPI_APEI=3Dy=0ACONFIG_HAVE_ACPI_APEI_=
NMI=3Dy=0ACONFIG_ACPI_APEI=3Dy=0ACONFIG_ACPI_APEI_GHES=3Dy=0ACONFIG_ACPI_AP=
EI_PCIEAER=3Dy=0ACONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy=0ACONFIG_ACPI_APEI_EIN=
J=3Dm=0A# CONFIG_ACPI_APEI_ERST_DEBUG is not set=0A# CONFIG_ACPI_DPTF is no=
t set=0ACONFIG_ACPI_WATCHDOG=3Dy=0ACONFIG_ACPI_EXTLOG=3Dm=0ACONFIG_ACPI_ADX=
L=3Dy=0A# CONFIG_ACPI_CONFIGFS is not set=0ACONFIG_PMIC_OPREGION=3Dy=0ACONF=
IG_X86_PM_TIMER=3Dy=0ACONFIG_ACPI_PRMT=3Dy=0A=0A#=0A# CPU Frequency scaling=
=0A#=0ACONFIG_CPU_FREQ=3Dy=0ACONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy=0ACONFIG_CPU_=
FREQ_GOV_COMMON=3Dy=0ACONFIG_CPU_FREQ_STAT=3Dy=0ACONFIG_CPU_FREQ_DEFAULT_GO=
V_PERFORMANCE=3Dy=0A# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set=0A# =
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set=0A# CONFIG_CPU_FREQ_DEFAUL=
T_GOV_SCHEDUTIL is not set=0ACONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy=0ACONFIG_C=
PU_FREQ_GOV_POWERSAVE=3Dy=0ACONFIG_CPU_FREQ_GOV_USERSPACE=3Dy=0ACONFIG_CPU_=
FREQ_GOV_ONDEMAND=3Dy=0ACONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy=0ACONFIG_CPU_F=
REQ_GOV_SCHEDUTIL=3Dy=0A=0A#=0A# CPU frequency scaling drivers=0A#=0ACONFIG=
_X86_INTEL_PSTATE=3Dy=0A# CONFIG_X86_PCC_CPUFREQ is not set=0ACONFIG_X86_AC=
PI_CPUFREQ=3Dm=0ACONFIG_X86_ACPI_CPUFREQ_CPB=3Dy=0ACONFIG_X86_POWERNOW_K8=
=3Dm=0A# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set=0A# CONFIG_X86_SPEEDSTE=
P_CENTRINO is not set=0ACONFIG_X86_P4_CLOCKMOD=3Dm=0A=0A#=0A# shared option=
s=0A#=0ACONFIG_X86_SPEEDSTEP_LIB=3Dm=0A# end of CPU Frequency scaling=0A=0A=
#=0A# CPU Idle=0A#=0ACONFIG_CPU_IDLE=3Dy=0A# CONFIG_CPU_IDLE_GOV_LADDER is =
not set=0ACONFIG_CPU_IDLE_GOV_MENU=3Dy=0A# CONFIG_CPU_IDLE_GOV_TEO is not s=
et=0A# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set=0ACONFIG_HALTPOLL_CPUIDLE=3D=
y=0A# end of CPU Idle=0A=0ACONFIG_INTEL_IDLE=3Dy=0A# end of Power managemen=
t and ACPI options=0A=0A#=0A# Bus options (PCI etc.)=0A#=0ACONFIG_PCI_DIREC=
T=3Dy=0ACONFIG_PCI_MMCONFIG=3Dy=0ACONFIG_MMCONF_FAM10H=3Dy=0ACONFIG_ISA_DMA=
_API=3Dy=0ACONFIG_AMD_NB=3Dy=0A# end of Bus options (PCI etc.)=0A=0A#=0A# B=
inary Emulations=0A#=0ACONFIG_IA32_EMULATION=3Dy=0A# CONFIG_X86_X32 is not =
set=0ACONFIG_COMPAT_32=3Dy=0ACONFIG_COMPAT=3Dy=0ACONFIG_COMPAT_FOR_U64_ALIG=
NMENT=3Dy=0ACONFIG_SYSVIPC_COMPAT=3Dy=0A# end of Binary Emulations=0A=0A#=
=0A# Firmware Drivers=0A#=0A=0A#=0A# ARM System Control and Management Inte=
rface Protocol=0A#=0A# end of ARM System Control and Management Interface P=
rotocol=0A=0ACONFIG_EDD=3Dm=0A# CONFIG_EDD_OFF is not set=0ACONFIG_FIRMWARE=
_MEMMAP=3Dy=0ACONFIG_DMIID=3Dy=0ACONFIG_DMI_SYSFS=3Dy=0ACONFIG_DMI_SCAN_MAC=
HINE_NON_EFI_FALLBACK=3Dy=0A# CONFIG_ISCSI_IBFT is not set=0ACONFIG_FW_CFG_=
SYSFS=3Dy=0A# CONFIG_FW_CFG_SYSFS_CMDLINE is not set=0ACONFIG_SYSFB=3Dy=0A#=
 CONFIG_SYSFB_SIMPLEFB is not set=0A# CONFIG_GOOGLE_FIRMWARE is not set=0A=
=0A#=0A# EFI (Extensible Firmware Interface) Support=0A#=0ACONFIG_EFI_VARS=
=3Dy=0ACONFIG_EFI_ESRT=3Dy=0ACONFIG_EFI_VARS_PSTORE=3Dy=0ACONFIG_EFI_VARS_P=
STORE_DEFAULT_DISABLE=3Dy=0ACONFIG_EFI_RUNTIME_MAP=3Dy=0A# CONFIG_EFI_FAKE_=
MEMMAP is not set=0ACONFIG_EFI_RUNTIME_WRAPPERS=3Dy=0ACONFIG_EFI_GENERIC_ST=
UB_INITRD_CMDLINE_LOADER=3Dy=0A# CONFIG_EFI_BOOTLOADER_CONTROL is not set=
=0A# CONFIG_EFI_CAPSULE_LOADER is not set=0A# CONFIG_EFI_TEST is not set=0A=
CONFIG_APPLE_PROPERTIES=3Dy=0A# CONFIG_RESET_ATTACK_MITIGATION is not set=
=0A# CONFIG_EFI_RCI2_TABLE is not set=0A# CONFIG_EFI_DISABLE_PCI_DMA is not=
 set=0A# end of EFI (Extensible Firmware Interface) Support=0A=0ACONFIG_UEF=
I_CPER=3Dy=0ACONFIG_UEFI_CPER_X86=3Dy=0ACONFIG_EFI_DEV_PATH_PARSER=3Dy=0ACO=
NFIG_EFI_EARLYCON=3Dy=0ACONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy=0A=0A#=0A# Tegr=
a firmware driver=0A#=0A# end of Tegra firmware driver=0A# end of Firmware =
Drivers=0A=0ACONFIG_HAVE_KVM=3Dy=0ACONFIG_HAVE_KVM_IRQCHIP=3Dy=0ACONFIG_HAV=
E_KVM_IRQFD=3Dy=0ACONFIG_HAVE_KVM_IRQ_ROUTING=3Dy=0ACONFIG_HAVE_KVM_EVENTFD=
=3Dy=0ACONFIG_KVM_MMIO=3Dy=0ACONFIG_KVM_ASYNC_PF=3Dy=0ACONFIG_HAVE_KVM_MSI=
=3Dy=0ACONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy=0ACONFIG_KVM_VFIO=3Dy=0ACONF=
IG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy=0ACONFIG_KVM_COMPAT=3Dy=0ACONFIG_H=
AVE_KVM_IRQ_BYPASS=3Dy=0ACONFIG_HAVE_KVM_NO_POLL=3Dy=0ACONFIG_KVM_XFER_TO_G=
UEST_WORK=3Dy=0ACONFIG_HAVE_KVM_PM_NOTIFIER=3Dy=0ACONFIG_VIRTUALIZATION=3Dy=
=0ACONFIG_KVM=3Dm=0ACONFIG_KVM_INTEL=3Dm=0A# CONFIG_KVM_AMD is not set=0A# =
CONFIG_KVM_XEN is not set=0ACONFIG_KVM_MMU_AUDIT=3Dy=0ACONFIG_AS_AVX512=3Dy=
=0ACONFIG_AS_SHA1_NI=3Dy=0ACONFIG_AS_SHA256_NI=3Dy=0ACONFIG_AS_TPAUSE=3Dy=
=0A=0A#=0A# General architecture-dependent options=0A#=0ACONFIG_CRASH_CORE=
=3Dy=0ACONFIG_KEXEC_CORE=3Dy=0ACONFIG_HOTPLUG_SMT=3Dy=0ACONFIG_GENERIC_ENTR=
Y=3Dy=0ACONFIG_KPROBES=3Dy=0ACONFIG_JUMP_LABEL=3Dy=0A# CONFIG_STATIC_KEYS_S=
ELFTEST is not set=0A# CONFIG_STATIC_CALL_SELFTEST is not set=0ACONFIG_OPTP=
ROBES=3Dy=0ACONFIG_KPROBES_ON_FTRACE=3Dy=0ACONFIG_UPROBES=3Dy=0ACONFIG_HAVE=
_EFFICIENT_UNALIGNED_ACCESS=3Dy=0ACONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy=0ACONFI=
G_KRETPROBES=3Dy=0ACONFIG_USER_RETURN_NOTIFIER=3Dy=0ACONFIG_HAVE_IOREMAP_PR=
OT=3Dy=0ACONFIG_HAVE_KPROBES=3Dy=0ACONFIG_HAVE_KRETPROBES=3Dy=0ACONFIG_HAVE=
_OPTPROBES=3Dy=0ACONFIG_HAVE_KPROBES_ON_FTRACE=3Dy=0ACONFIG_HAVE_FUNCTION_E=
RROR_INJECTION=3Dy=0ACONFIG_HAVE_NMI=3Dy=0ACONFIG_TRACE_IRQFLAGS_SUPPORT=3D=
y=0ACONFIG_HAVE_ARCH_TRACEHOOK=3Dy=0ACONFIG_HAVE_DMA_CONTIGUOUS=3Dy=0ACONFI=
G_GENERIC_SMP_IDLE_THREAD=3Dy=0ACONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy=0ACONFIG=
_ARCH_HAS_SET_MEMORY=3Dy=0ACONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy=0ACONFIG_HAVE=
_ARCH_THREAD_STRUCT_WHITELIST=3Dy=0ACONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=
=3Dy=0ACONFIG_ARCH_WANTS_NO_INSTR=3Dy=0ACONFIG_HAVE_ASM_MODVERSIONS=3Dy=0AC=
ONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy=0ACONFIG_HAVE_RSEQ=3Dy=0ACONFIG_HA=
VE_FUNCTION_ARG_ACCESS_API=3Dy=0ACONFIG_HAVE_HW_BREAKPOINT=3Dy=0ACONFIG_HAV=
E_MIXED_BREAKPOINTS_REGS=3Dy=0ACONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy=0ACONFI=
G_HAVE_PERF_EVENTS_NMI=3Dy=0ACONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy=0ACON=
FIG_HAVE_PERF_REGS=3Dy=0ACONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy=0ACONFIG_HAVE=
_ARCH_JUMP_LABEL=3Dy=0ACONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy=0ACONFIG_MM=
U_GATHER_TABLE_FREE=3Dy=0ACONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy=0ACONFIG_ARC=
H_HAVE_NMI_SAFE_CMPXCHG=3Dy=0ACONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy=0ACONFIG_=
HAVE_CMPXCHG_LOCAL=3Dy=0ACONFIG_HAVE_CMPXCHG_DOUBLE=3Dy=0ACONFIG_ARCH_WANT_=
COMPAT_IPC_PARSE_VERSION=3Dy=0ACONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy=0ACONFIG=
_HAVE_ARCH_SECCOMP=3Dy=0ACONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy=0ACONFIG_SECCO=
MP=3Dy=0ACONFIG_SECCOMP_FILTER=3Dy=0A# CONFIG_SECCOMP_CACHE_DEBUG is not se=
t=0ACONFIG_HAVE_ARCH_STACKLEAK=3Dy=0ACONFIG_HAVE_STACKPROTECTOR=3Dy=0ACONFI=
G_STACKPROTECTOR=3Dy=0ACONFIG_STACKPROTECTOR_STRONG=3Dy=0ACONFIG_ARCH_SUPPO=
RTS_LTO_CLANG=3Dy=0ACONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy=0ACONFIG_LTO_NO=
NE=3Dy=0ACONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy=0ACONFIG_HAVE_CONTEXT_TRA=
CKING=3Dy=0ACONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=3Dy=0ACONFIG_HAVE_VIRT_CP=
U_ACCOUNTING_GEN=3Dy=0ACONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy=0ACONFIG_HAVE_MO=
VE_PUD=3Dy=0ACONFIG_HAVE_MOVE_PMD=3Dy=0ACONFIG_HAVE_ARCH_TRANSPARENT_HUGEPA=
GE=3Dy=0ACONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy=0ACONFIG_HAVE_ARCH_H=
UGE_VMAP=3Dy=0ACONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy=0ACONFIG_HAVE_ARCH_SOFT_=
DIRTY=3Dy=0ACONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy=0ACONFIG_MODULES_USE_ELF_RELA=
=3Dy=0ACONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy=0ACONFIG_HAVE_SOFTIRQ_ON_OWN_S=
TACK=3Dy=0ACONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy=0ACONFIG_HAVE_ARCH_MMAP_RND_BI=
TS=3Dy=0ACONFIG_HAVE_EXIT_THREAD=3Dy=0ACONFIG_ARCH_MMAP_RND_BITS=3D28=0ACON=
FIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy=0ACONFIG_ARCH_MMAP_RND_COMPAT_BITS=
=3D8=0ACONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy=0ACONFIG_HAVE_STACK_VALIDATIO=
N=3Dy=0ACONFIG_HAVE_RELIABLE_STACKTRACE=3Dy=0ACONFIG_OLD_SIGSUSPEND3=3Dy=0A=
CONFIG_COMPAT_OLD_SIGACTION=3Dy=0ACONFIG_COMPAT_32BIT_TIME=3Dy=0ACONFIG_HAV=
E_ARCH_VMAP_STACK=3Dy=0ACONFIG_VMAP_STACK=3Dy=0ACONFIG_HAVE_ARCH_RANDOMIZE_=
KSTACK_OFFSET=3Dy=0A# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set=0AC=
ONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy=0ACONFIG_STRICT_KERNEL_RWX=3Dy=0ACONFI=
G_ARCH_HAS_STRICT_MODULE_RWX=3Dy=0ACONFIG_STRICT_MODULE_RWX=3Dy=0ACONFIG_HA=
VE_ARCH_PREL32_RELOCATIONS=3Dy=0ACONFIG_ARCH_USE_MEMREMAP_PROT=3Dy=0A# CONF=
IG_LOCK_EVENT_COUNTS is not set=0ACONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy=0ACONFIG_=
HAVE_STATIC_CALL=3Dy=0ACONFIG_HAVE_STATIC_CALL_INLINE=3Dy=0ACONFIG_HAVE_PRE=
EMPT_DYNAMIC=3Dy=0ACONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy=0ACONFIG_ARCH_SUPPOR=
TS_DEBUG_PAGEALLOC=3Dy=0ACONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy=0ACONFIG_ARCH_H=
AS_PARANOID_L1D_FLUSH=3Dy=0A=0A#=0A# GCOV-based kernel profiling=0A#=0A# CO=
NFIG_GCOV_KERNEL is not set=0ACONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy=0A# end =
of GCOV-based kernel profiling=0A=0ACONFIG_HAVE_GCC_PLUGINS=3Dy=0A# end of =
General architecture-dependent options=0A=0ACONFIG_RT_MUTEXES=3Dy=0ACONFIG_=
BASE_SMALL=3D0=0ACONFIG_MODULE_SIG_FORMAT=3Dy=0ACONFIG_MODULES=3Dy=0ACONFIG=
_MODULE_FORCE_LOAD=3Dy=0ACONFIG_MODULE_UNLOAD=3Dy=0A# CONFIG_MODULE_FORCE_U=
NLOAD is not set=0A# CONFIG_MODVERSIONS is not set=0A# CONFIG_MODULE_SRCVER=
SION_ALL is not set=0ACONFIG_MODULE_SIG=3Dy=0A# CONFIG_MODULE_SIG_FORCE is =
not set=0ACONFIG_MODULE_SIG_ALL=3Dy=0A# CONFIG_MODULE_SIG_SHA1 is not set=
=0A# CONFIG_MODULE_SIG_SHA224 is not set=0ACONFIG_MODULE_SIG_SHA256=3Dy=0A#=
 CONFIG_MODULE_SIG_SHA384 is not set=0A# CONFIG_MODULE_SIG_SHA512 is not se=
t=0ACONFIG_MODULE_SIG_HASH=3D"sha256"=0ACONFIG_MODULE_COMPRESS_NONE=3Dy=0A#=
 CONFIG_MODULE_COMPRESS_GZIP is not set=0A# CONFIG_MODULE_COMPRESS_XZ is no=
t set=0A# CONFIG_MODULE_COMPRESS_ZSTD is not set=0A# CONFIG_MODULE_ALLOW_MI=
SSING_NAMESPACE_IMPORTS is not set=0ACONFIG_MODPROBE_PATH=3D"/sbin/modprobe=
"=0ACONFIG_MODULES_TREE_LOOKUP=3Dy=0ACONFIG_BLOCK=3Dy=0ACONFIG_BLK_CGROUP_R=
WSTAT=3Dy=0ACONFIG_BLK_DEV_BSG_COMMON=3Dy=0ACONFIG_BLK_DEV_BSGLIB=3Dy=0ACON=
FIG_BLK_DEV_INTEGRITY=3Dy=0ACONFIG_BLK_DEV_INTEGRITY_T10=3Dm=0ACONFIG_BLK_D=
EV_ZONED=3Dy=0ACONFIG_BLK_DEV_THROTTLING=3Dy=0A# CONFIG_BLK_DEV_THROTTLING_=
LOW is not set=0ACONFIG_BLK_WBT=3Dy=0ACONFIG_BLK_WBT_MQ=3Dy=0A# CONFIG_BLK_=
CGROUP_IOLATENCY is not set=0A# CONFIG_BLK_CGROUP_FC_APPID is not set=0A# C=
ONFIG_BLK_CGROUP_IOCOST is not set=0A# CONFIG_BLK_CGROUP_IOPRIO is not set=
=0ACONFIG_BLK_DEBUG_FS=3Dy=0ACONFIG_BLK_DEBUG_FS_ZONED=3Dy=0A# CONFIG_BLK_S=
ED_OPAL is not set=0A# CONFIG_BLK_INLINE_ENCRYPTION is not set=0A=0A#=0A# P=
artition Types=0A#=0ACONFIG_PARTITION_ADVANCED=3Dy=0A# CONFIG_ACORN_PARTITI=
ON is not set=0A# CONFIG_AIX_PARTITION is not set=0ACONFIG_OSF_PARTITION=3D=
y=0ACONFIG_AMIGA_PARTITION=3Dy=0A# CONFIG_ATARI_PARTITION is not set=0ACONF=
IG_MAC_PARTITION=3Dy=0ACONFIG_MSDOS_PARTITION=3Dy=0ACONFIG_BSD_DISKLABEL=3D=
y=0ACONFIG_MINIX_SUBPARTITION=3Dy=0ACONFIG_SOLARIS_X86_PARTITION=3Dy=0ACONF=
IG_UNIXWARE_DISKLABEL=3Dy=0A# CONFIG_LDM_PARTITION is not set=0ACONFIG_SGI_=
PARTITION=3Dy=0A# CONFIG_ULTRIX_PARTITION is not set=0ACONFIG_SUN_PARTITION=
=3Dy=0ACONFIG_KARMA_PARTITION=3Dy=0ACONFIG_EFI_PARTITION=3Dy=0A# CONFIG_SYS=
V68_PARTITION is not set=0A# CONFIG_CMDLINE_PARTITION is not set=0A# end of=
 Partition Types=0A=0ACONFIG_BLOCK_COMPAT=3Dy=0ACONFIG_BLK_MQ_PCI=3Dy=0ACON=
FIG_BLK_MQ_VIRTIO=3Dy=0ACONFIG_BLK_MQ_RDMA=3Dy=0ACONFIG_BLK_PM=3Dy=0ACONFIG=
_BLOCK_HOLDER_DEPRECATED=3Dy=0A=0A#=0A# IO Schedulers=0A#=0ACONFIG_MQ_IOSCH=
ED_DEADLINE=3Dy=0ACONFIG_MQ_IOSCHED_KYBER=3Dy=0ACONFIG_IOSCHED_BFQ=3Dy=0ACO=
NFIG_BFQ_GROUP_IOSCHED=3Dy=0A# CONFIG_BFQ_CGROUP_DEBUG is not set=0A# end o=
f IO Schedulers=0A=0ACONFIG_PREEMPT_NOTIFIERS=3Dy=0ACONFIG_PADATA=3Dy=0ACON=
FIG_ASN1=3Dy=0ACONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy=0ACONFIG_INLINE_READ_UNLOC=
K=3Dy=0ACONFIG_INLINE_READ_UNLOCK_IRQ=3Dy=0ACONFIG_INLINE_WRITE_UNLOCK=3Dy=
=0ACONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy=0ACONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy=
=0ACONFIG_MUTEX_SPIN_ON_OWNER=3Dy=0ACONFIG_RWSEM_SPIN_ON_OWNER=3Dy=0ACONFIG=
_LOCK_SPIN_ON_OWNER=3Dy=0ACONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy=0ACONFIG_QUE=
UED_SPINLOCKS=3Dy=0ACONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy=0ACONFIG_QUEUED_RWLO=
CKS=3Dy=0ACONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy=0ACONFIG_ARCH_H=
AS_SYNC_CORE_BEFORE_USERMODE=3Dy=0ACONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy=0ACO=
NFIG_FREEZER=3Dy=0A=0A#=0A# Executable file formats=0A#=0ACONFIG_BINFMT_ELF=
=3Dy=0ACONFIG_COMPAT_BINFMT_ELF=3Dy=0ACONFIG_ELFCORE=3Dy=0ACONFIG_CORE_DUMP=
_DEFAULT_ELF_HEADERS=3Dy=0ACONFIG_BINFMT_SCRIPT=3Dy=0ACONFIG_BINFMT_MISC=3D=
m=0ACONFIG_COREDUMP=3Dy=0A# end of Executable file formats=0A=0A#=0A# Memor=
y Management options=0A#=0ACONFIG_SELECT_MEMORY_MODEL=3Dy=0ACONFIG_SPARSEME=
M_MANUAL=3Dy=0ACONFIG_SPARSEMEM=3Dy=0ACONFIG_SPARSEMEM_EXTREME=3Dy=0ACONFIG=
_SPARSEMEM_VMEMMAP_ENABLE=3Dy=0ACONFIG_SPARSEMEM_VMEMMAP=3Dy=0ACONFIG_HAVE_=
FAST_GUP=3Dy=0ACONFIG_NUMA_KEEP_MEMINFO=3Dy=0ACONFIG_MEMORY_ISOLATION=3Dy=
=0ACONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy=0ACONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3D=
y=0ACONFIG_MEMORY_HOTPLUG=3Dy=0ACONFIG_MEMORY_HOTPLUG_SPARSE=3Dy=0A# CONFIG=
_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set=0ACONFIG_ARCH_ENABLE_MEMORY_HOTRE=
MOVE=3Dy=0ACONFIG_MEMORY_HOTREMOVE=3Dy=0ACONFIG_MHP_MEMMAP_ON_MEMORY=3Dy=0A=
CONFIG_SPLIT_PTLOCK_CPUS=3D4=0ACONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy=0ACO=
NFIG_MEMORY_BALLOON=3Dy=0ACONFIG_BALLOON_COMPACTION=3Dy=0ACONFIG_COMPACTION=
=3Dy=0ACONFIG_PAGE_REPORTING=3Dy=0ACONFIG_MIGRATION=3Dy=0ACONFIG_ARCH_ENABL=
E_HUGEPAGE_MIGRATION=3Dy=0ACONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy=0ACONFIG_CO=
NTIG_ALLOC=3Dy=0ACONFIG_PHYS_ADDR_T_64BIT=3Dy=0ACONFIG_VIRT_TO_BUS=3Dy=0ACO=
NFIG_MMU_NOTIFIER=3Dy=0ACONFIG_KSM=3Dy=0ACONFIG_DEFAULT_MMAP_MIN_ADDR=3D409=
6=0ACONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy=0ACONFIG_MEMORY_FAILURE=3Dy=0AC=
ONFIG_HWPOISON_INJECT=3Dm=0ACONFIG_TRANSPARENT_HUGEPAGE=3Dy=0ACONFIG_TRANSP=
ARENT_HUGEPAGE_ALWAYS=3Dy=0A# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not se=
t=0ACONFIG_ARCH_WANTS_THP_SWAP=3Dy=0ACONFIG_THP_SWAP=3Dy=0ACONFIG_CLEANCACH=
E=3Dy=0ACONFIG_FRONTSWAP=3Dy=0ACONFIG_CMA=3Dy=0A# CONFIG_CMA_DEBUG is not s=
et=0A# CONFIG_CMA_DEBUGFS is not set=0A# CONFIG_CMA_SYSFS is not set=0ACONF=
IG_CMA_AREAS=3D19=0A# CONFIG_MEM_SOFT_DIRTY is not set=0ACONFIG_ZSWAP=3Dy=
=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set=0ACONFIG_ZSWAP_COMP=
RESSOR_DEFAULT_LZO=3Dy=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set=
=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set=0A# CONFIG_ZSWAP_COMPRE=
SSOR_DEFAULT_LZ4HC is not set=0A# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is n=
ot set=0ACONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"=0ACONFIG_ZSWAP_ZPOOL_DEFAU=
LT_ZBUD=3Dy=0A# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set=0A# CONFIG_ZSW=
AP_ZPOOL_DEFAULT_ZSMALLOC is not set=0ACONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"=
=0A# CONFIG_ZSWAP_DEFAULT_ON is not set=0ACONFIG_ZPOOL=3Dy=0ACONFIG_ZBUD=3D=
y=0A# CONFIG_Z3FOLD is not set=0ACONFIG_ZSMALLOC=3Dy=0ACONFIG_ZSMALLOC_STAT=
=3Dy=0ACONFIG_GENERIC_EARLY_IOREMAP=3Dy=0ACONFIG_DEFERRED_STRUCT_PAGE_INIT=
=3Dy=0ACONFIG_PAGE_IDLE_FLAG=3Dy=0ACONFIG_IDLE_PAGE_TRACKING=3Dy=0ACONFIG_A=
RCH_HAS_CACHE_LINE_SIZE=3Dy=0ACONFIG_ARCH_HAS_PTE_DEVMAP=3Dy=0ACONFIG_ZONE_=
DMA=3Dy=0ACONFIG_ZONE_DMA32=3Dy=0ACONFIG_ZONE_DEVICE=3Dy=0ACONFIG_DEV_PAGEM=
AP_OPS=3Dy=0ACONFIG_HMM_MIRROR=3Dy=0ACONFIG_DEVICE_PRIVATE=3Dy=0ACONFIG_VMA=
P_PFN=3Dy=0ACONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy=0ACONFIG_ARCH_HAS_PKEYS=3Dy=
=0A# CONFIG_PERCPU_STATS is not set=0A# CONFIG_GUP_TEST is not set=0A# CONF=
IG_READ_ONLY_THP_FOR_FS is not set=0ACONFIG_ARCH_HAS_PTE_SPECIAL=3Dy=0ACONF=
IG_SECRETMEM=3Dy=0A=0A#=0A# Data Access Monitoring=0A#=0A# CONFIG_DAMON is =
not set=0A# end of Data Access Monitoring=0A# end of Memory Management opti=
ons=0A=0ACONFIG_NET=3Dy=0ACONFIG_COMPAT_NETLINK_MESSAGES=3Dy=0ACONFIG_NET_I=
NGRESS=3Dy=0ACONFIG_NET_EGRESS=3Dy=0ACONFIG_SKB_EXTENSIONS=3Dy=0A=0A#=0A# N=
etworking options=0A#=0ACONFIG_PACKET=3Dy=0ACONFIG_PACKET_DIAG=3Dm=0ACONFIG=
_UNIX=3Dy=0ACONFIG_UNIX_SCM=3Dy=0ACONFIG_AF_UNIX_OOB=3Dy=0ACONFIG_UNIX_DIAG=
=3Dm=0ACONFIG_TLS=3Dm=0ACONFIG_TLS_DEVICE=3Dy=0A# CONFIG_TLS_TOE is not set=
=0ACONFIG_XFRM=3Dy=0ACONFIG_XFRM_OFFLOAD=3Dy=0ACONFIG_XFRM_ALGO=3Dy=0ACONFI=
G_XFRM_USER=3Dy=0A# CONFIG_XFRM_USER_COMPAT is not set=0A# CONFIG_XFRM_INTE=
RFACE is not set=0ACONFIG_XFRM_SUB_POLICY=3Dy=0ACONFIG_XFRM_MIGRATE=3Dy=0AC=
ONFIG_XFRM_STATISTICS=3Dy=0ACONFIG_XFRM_AH=3Dm=0ACONFIG_XFRM_ESP=3Dm=0ACONF=
IG_XFRM_IPCOMP=3Dm=0ACONFIG_NET_KEY=3Dm=0ACONFIG_NET_KEY_MIGRATE=3Dy=0A# CO=
NFIG_SMC is not set=0ACONFIG_XDP_SOCKETS=3Dy=0A# CONFIG_XDP_SOCKETS_DIAG is=
 not set=0ACONFIG_INET=3Dy=0ACONFIG_IP_MULTICAST=3Dy=0ACONFIG_IP_ADVANCED_R=
OUTER=3Dy=0ACONFIG_IP_FIB_TRIE_STATS=3Dy=0ACONFIG_IP_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_ROUTE_MULTIPATH=3Dy=0ACONFIG_IP_ROUTE_VERBOSE=3Dy=0ACONFIG_IP_ROU=
TE_CLASSID=3Dy=0ACONFIG_IP_PNP=3Dy=0ACONFIG_IP_PNP_DHCP=3Dy=0A# CONFIG_IP_P=
NP_BOOTP is not set=0A# CONFIG_IP_PNP_RARP is not set=0ACONFIG_NET_IPIP=3Dm=
=0ACONFIG_NET_IPGRE_DEMUX=3Dm=0ACONFIG_NET_IP_TUNNEL=3Dm=0ACONFIG_NET_IPGRE=
=3Dm=0ACONFIG_NET_IPGRE_BROADCAST=3Dy=0ACONFIG_IP_MROUTE_COMMON=3Dy=0ACONFI=
G_IP_MROUTE=3Dy=0ACONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy=0ACONFIG_IP_PIMSM_V1=
=3Dy=0ACONFIG_IP_PIMSM_V2=3Dy=0ACONFIG_SYN_COOKIES=3Dy=0ACONFIG_NET_IPVTI=
=3Dm=0ACONFIG_NET_UDP_TUNNEL=3Dm=0A# CONFIG_NET_FOU is not set=0A# CONFIG_N=
ET_FOU_IP_TUNNELS is not set=0ACONFIG_INET_AH=3Dm=0ACONFIG_INET_ESP=3Dm=0AC=
ONFIG_INET_ESP_OFFLOAD=3Dm=0A# CONFIG_INET_ESPINTCP is not set=0ACONFIG_INE=
T_IPCOMP=3Dm=0ACONFIG_INET_XFRM_TUNNEL=3Dm=0ACONFIG_INET_TUNNEL=3Dm=0ACONFI=
G_INET_DIAG=3Dm=0ACONFIG_INET_TCP_DIAG=3Dm=0ACONFIG_INET_UDP_DIAG=3Dm=0ACON=
FIG_INET_RAW_DIAG=3Dm=0A# CONFIG_INET_DIAG_DESTROY is not set=0ACONFIG_TCP_=
CONG_ADVANCED=3Dy=0ACONFIG_TCP_CONG_BIC=3Dm=0ACONFIG_TCP_CONG_CUBIC=3Dy=0AC=
ONFIG_TCP_CONG_WESTWOOD=3Dm=0ACONFIG_TCP_CONG_HTCP=3Dm=0ACONFIG_TCP_CONG_HS=
TCP=3Dm=0ACONFIG_TCP_CONG_HYBLA=3Dm=0ACONFIG_TCP_CONG_VEGAS=3Dm=0ACONFIG_TC=
P_CONG_NV=3Dm=0ACONFIG_TCP_CONG_SCALABLE=3Dm=0ACONFIG_TCP_CONG_LP=3Dm=0ACON=
FIG_TCP_CONG_VENO=3Dm=0ACONFIG_TCP_CONG_YEAH=3Dm=0ACONFIG_TCP_CONG_ILLINOIS=
=3Dm=0ACONFIG_TCP_CONG_DCTCP=3Dm=0A# CONFIG_TCP_CONG_CDG is not set=0ACONFI=
G_TCP_CONG_BBR=3Dm=0ACONFIG_DEFAULT_CUBIC=3Dy=0A# CONFIG_DEFAULT_RENO is no=
t set=0ACONFIG_DEFAULT_TCP_CONG=3D"cubic"=0ACONFIG_TCP_MD5SIG=3Dy=0ACONFIG_=
IPV6=3Dy=0ACONFIG_IPV6_ROUTER_PREF=3Dy=0ACONFIG_IPV6_ROUTE_INFO=3Dy=0ACONFI=
G_IPV6_OPTIMISTIC_DAD=3Dy=0ACONFIG_INET6_AH=3Dm=0ACONFIG_INET6_ESP=3Dm=0ACO=
NFIG_INET6_ESP_OFFLOAD=3Dm=0A# CONFIG_INET6_ESPINTCP is not set=0ACONFIG_IN=
ET6_IPCOMP=3Dm=0ACONFIG_IPV6_MIP6=3Dm=0A# CONFIG_IPV6_ILA is not set=0ACONF=
IG_INET6_XFRM_TUNNEL=3Dm=0ACONFIG_INET6_TUNNEL=3Dm=0ACONFIG_IPV6_VTI=3Dm=0A=
CONFIG_IPV6_SIT=3Dm=0ACONFIG_IPV6_SIT_6RD=3Dy=0ACONFIG_IPV6_NDISC_NODETYPE=
=3Dy=0ACONFIG_IPV6_TUNNEL=3Dm=0ACONFIG_IPV6_GRE=3Dm=0ACONFIG_IPV6_MULTIPLE_=
TABLES=3Dy=0A# CONFIG_IPV6_SUBTREES is not set=0ACONFIG_IPV6_MROUTE=3Dy=0AC=
ONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy=0ACONFIG_IPV6_PIMSM_V2=3Dy=0A# CONFIG=
_IPV6_SEG6_LWTUNNEL is not set=0A# CONFIG_IPV6_SEG6_HMAC is not set=0A# CON=
FIG_IPV6_RPL_LWTUNNEL is not set=0A# CONFIG_IPV6_IOAM6_LWTUNNEL is not set=
=0ACONFIG_NETLABEL=3Dy=0ACONFIG_MPTCP=3Dy=0ACONFIG_INET_MPTCP_DIAG=3Dm=0ACO=
NFIG_MPTCP_IPV6=3Dy=0ACONFIG_MPTCP_KUNIT_TEST=3Dm=0ACONFIG_NETWORK_SECMARK=
=3Dy=0ACONFIG_NET_PTP_CLASSIFY=3Dy=0ACONFIG_NETWORK_PHY_TIMESTAMPING=3Dy=0A=
CONFIG_NETFILTER=3Dy=0ACONFIG_NETFILTER_ADVANCED=3Dy=0ACONFIG_BRIDGE_NETFIL=
TER=3Dm=0A=0A#=0A# Core Netfilter Configuration=0A#=0ACONFIG_NETFILTER_INGR=
ESS=3Dy=0ACONFIG_NETFILTER_NETLINK=3Dm=0ACONFIG_NETFILTER_FAMILY_BRIDGE=3Dy=
=0ACONFIG_NETFILTER_FAMILY_ARP=3Dy=0A# CONFIG_NETFILTER_NETLINK_HOOK is not=
 set=0A# CONFIG_NETFILTER_NETLINK_ACCT is not set=0ACONFIG_NETFILTER_NETLIN=
K_QUEUE=3Dm=0ACONFIG_NETFILTER_NETLINK_LOG=3Dm=0ACONFIG_NETFILTER_NETLINK_O=
SF=3Dm=0ACONFIG_NF_CONNTRACK=3Dm=0ACONFIG_NF_LOG_SYSLOG=3Dm=0ACONFIG_NETFIL=
TER_CONNCOUNT=3Dm=0ACONFIG_NF_CONNTRACK_MARK=3Dy=0ACONFIG_NF_CONNTRACK_SECM=
ARK=3Dy=0ACONFIG_NF_CONNTRACK_ZONES=3Dy=0ACONFIG_NF_CONNTRACK_PROCFS=3Dy=0A=
CONFIG_NF_CONNTRACK_EVENTS=3Dy=0ACONFIG_NF_CONNTRACK_TIMEOUT=3Dy=0ACONFIG_N=
F_CONNTRACK_TIMESTAMP=3Dy=0ACONFIG_NF_CONNTRACK_LABELS=3Dy=0ACONFIG_NF_CT_P=
ROTO_DCCP=3Dy=0ACONFIG_NF_CT_PROTO_GRE=3Dy=0ACONFIG_NF_CT_PROTO_SCTP=3Dy=0A=
CONFIG_NF_CT_PROTO_UDPLITE=3Dy=0ACONFIG_NF_CONNTRACK_AMANDA=3Dm=0ACONFIG_NF=
_CONNTRACK_FTP=3Dm=0ACONFIG_NF_CONNTRACK_H323=3Dm=0ACONFIG_NF_CONNTRACK_IRC=
=3Dm=0ACONFIG_NF_CONNTRACK_BROADCAST=3Dm=0ACONFIG_NF_CONNTRACK_NETBIOS_NS=
=3Dm=0ACONFIG_NF_CONNTRACK_SNMP=3Dm=0ACONFIG_NF_CONNTRACK_PPTP=3Dm=0ACONFIG=
_NF_CONNTRACK_SANE=3Dm=0ACONFIG_NF_CONNTRACK_SIP=3Dm=0ACONFIG_NF_CONNTRACK_=
TFTP=3Dm=0ACONFIG_NF_CT_NETLINK=3Dm=0ACONFIG_NF_CT_NETLINK_TIMEOUT=3Dm=0ACO=
NFIG_NF_CT_NETLINK_HELPER=3Dm=0ACONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy=0ACONF=
IG_NF_NAT=3Dm=0ACONFIG_NF_NAT_AMANDA=3Dm=0ACONFIG_NF_NAT_FTP=3Dm=0ACONFIG_N=
F_NAT_IRC=3Dm=0ACONFIG_NF_NAT_SIP=3Dm=0ACONFIG_NF_NAT_TFTP=3Dm=0ACONFIG_NF_=
NAT_REDIRECT=3Dy=0ACONFIG_NF_NAT_MASQUERADE=3Dy=0ACONFIG_NETFILTER_SYNPROXY=
=3Dm=0ACONFIG_NF_TABLES=3Dm=0ACONFIG_NF_TABLES_INET=3Dy=0ACONFIG_NF_TABLES_=
NETDEV=3Dy=0ACONFIG_NFT_NUMGEN=3Dm=0ACONFIG_NFT_CT=3Dm=0ACONFIG_NFT_COUNTER=
=3Dm=0ACONFIG_NFT_CONNLIMIT=3Dm=0ACONFIG_NFT_LOG=3Dm=0ACONFIG_NFT_LIMIT=3Dm=
=0ACONFIG_NFT_MASQ=3Dm=0ACONFIG_NFT_REDIR=3Dm=0ACONFIG_NFT_NAT=3Dm=0A# CONF=
IG_NFT_TUNNEL is not set=0ACONFIG_NFT_OBJREF=3Dm=0ACONFIG_NFT_QUEUE=3Dm=0AC=
ONFIG_NFT_QUOTA=3Dm=0ACONFIG_NFT_REJECT=3Dm=0ACONFIG_NFT_REJECT_INET=3Dm=0A=
CONFIG_NFT_COMPAT=3Dm=0ACONFIG_NFT_HASH=3Dm=0ACONFIG_NFT_FIB=3Dm=0ACONFIG_N=
FT_FIB_INET=3Dm=0A# CONFIG_NFT_XFRM is not set=0ACONFIG_NFT_SOCKET=3Dm=0A# =
CONFIG_NFT_OSF is not set=0A# CONFIG_NFT_TPROXY is not set=0A# CONFIG_NFT_S=
YNPROXY is not set=0ACONFIG_NF_DUP_NETDEV=3Dm=0ACONFIG_NFT_DUP_NETDEV=3Dm=
=0ACONFIG_NFT_FWD_NETDEV=3Dm=0ACONFIG_NFT_FIB_NETDEV=3Dm=0A# CONFIG_NFT_REJ=
ECT_NETDEV is not set=0A# CONFIG_NF_FLOW_TABLE is not set=0ACONFIG_NETFILTE=
R_XTABLES=3Dy=0ACONFIG_NETFILTER_XTABLES_COMPAT=3Dy=0A=0A#=0A# Xtables comb=
ined modules=0A#=0ACONFIG_NETFILTER_XT_MARK=3Dm=0ACONFIG_NETFILTER_XT_CONNM=
ARK=3Dm=0ACONFIG_NETFILTER_XT_SET=3Dm=0A=0A#=0A# Xtables targets=0A#=0ACONF=
IG_NETFILTER_XT_TARGET_AUDIT=3Dm=0ACONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm=
=0ACONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm=0ACONFIG_NETFILTER_XT_TARGET_CON=
NMARK=3Dm=0ACONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm=0ACONFIG_NETFILTER_X=
T_TARGET_CT=3Dm=0ACONFIG_NETFILTER_XT_TARGET_DSCP=3Dm=0ACONFIG_NETFILTER_XT=
_TARGET_HL=3Dm=0ACONFIG_NETFILTER_XT_TARGET_HMARK=3Dm=0ACONFIG_NETFILTER_XT=
_TARGET_IDLETIMER=3Dm=0A# CONFIG_NETFILTER_XT_TARGET_LED is not set=0ACONFI=
G_NETFILTER_XT_TARGET_LOG=3Dm=0ACONFIG_NETFILTER_XT_TARGET_MARK=3Dm=0ACONFI=
G_NETFILTER_XT_NAT=3Dm=0ACONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm=0ACONFIG_NET=
FILTER_XT_TARGET_NFLOG=3Dm=0ACONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm=0ACONFI=
G_NETFILTER_XT_TARGET_NOTRACK=3Dm=0ACONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm=
=0ACONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm=0ACONFIG_NETFILTER_XT_TARGET_MAS=
QUERADE=3Dm=0ACONFIG_NETFILTER_XT_TARGET_TEE=3Dm=0ACONFIG_NETFILTER_XT_TARG=
ET_TPROXY=3Dm=0ACONFIG_NETFILTER_XT_TARGET_TRACE=3Dm=0ACONFIG_NETFILTER_XT_=
TARGET_SECMARK=3Dm=0ACONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm=0ACONFIG_NETFILT=
ER_XT_TARGET_TCPOPTSTRIP=3Dm=0A=0A#=0A# Xtables matches=0A#=0ACONFIG_NETFIL=
TER_XT_MATCH_ADDRTYPE=3Dm=0ACONFIG_NETFILTER_XT_MATCH_BPF=3Dm=0ACONFIG_NETF=
ILTER_XT_MATCH_CGROUP=3Dm=0ACONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm=0ACONFIG_=
NETFILTER_XT_MATCH_COMMENT=3Dm=0ACONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm=0A=
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm=0ACONFIG_NETFILTER_XT_MATCH_CONNLIM=
IT=3Dm=0ACONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm=0ACONFIG_NETFILTER_XT_MATCH=
_CONNTRACK=3Dm=0ACONFIG_NETFILTER_XT_MATCH_CPU=3Dm=0ACONFIG_NETFILTER_XT_MA=
TCH_DCCP=3Dm=0ACONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm=0ACONFIG_NETFILTER_XT=
_MATCH_DSCP=3Dm=0ACONFIG_NETFILTER_XT_MATCH_ECN=3Dm=0ACONFIG_NETFILTER_XT_M=
ATCH_ESP=3Dm=0ACONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm=0ACONFIG_NETFILTER_X=
T_MATCH_HELPER=3Dm=0ACONFIG_NETFILTER_XT_MATCH_HL=3Dm=0A# CONFIG_NETFILTER_=
XT_MATCH_IPCOMP is not set=0ACONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm=0ACONFIG=
_NETFILTER_XT_MATCH_IPVS=3Dm=0A# CONFIG_NETFILTER_XT_MATCH_L2TP is not set=
=0ACONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm=0ACONFIG_NETFILTER_XT_MATCH_LIMIT=
=3Dm=0ACONFIG_NETFILTER_XT_MATCH_MAC=3Dm=0ACONFIG_NETFILTER_XT_MATCH_MARK=
=3Dm=0ACONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm=0A# CONFIG_NETFILTER_XT_MATC=
H_NFACCT is not set=0ACONFIG_NETFILTER_XT_MATCH_OSF=3Dm=0ACONFIG_NETFILTER_=
XT_MATCH_OWNER=3Dm=0ACONFIG_NETFILTER_XT_MATCH_POLICY=3Dm=0ACONFIG_NETFILTE=
R_XT_MATCH_PHYSDEV=3Dm=0ACONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm=0ACONFIG_NET=
FILTER_XT_MATCH_QUOTA=3Dm=0ACONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm=0ACONFIG_=
NETFILTER_XT_MATCH_REALM=3Dm=0ACONFIG_NETFILTER_XT_MATCH_RECENT=3Dm=0ACONFI=
G_NETFILTER_XT_MATCH_SCTP=3Dm=0ACONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm=0ACONF=
IG_NETFILTER_XT_MATCH_STATE=3Dm=0ACONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm=
=0ACONFIG_NETFILTER_XT_MATCH_STRING=3Dm=0ACONFIG_NETFILTER_XT_MATCH_TCPMSS=
=3Dm=0A# CONFIG_NETFILTER_XT_MATCH_TIME is not set=0A# CONFIG_NETFILTER_XT_=
MATCH_U32 is not set=0A# end of Core Netfilter Configuration=0A=0ACONFIG_IP=
_SET=3Dm=0ACONFIG_IP_SET_MAX=3D256=0ACONFIG_IP_SET_BITMAP_IP=3Dm=0ACONFIG_I=
P_SET_BITMAP_IPMAC=3Dm=0ACONFIG_IP_SET_BITMAP_PORT=3Dm=0ACONFIG_IP_SET_HASH=
_IP=3Dm=0ACONFIG_IP_SET_HASH_IPMARK=3Dm=0ACONFIG_IP_SET_HASH_IPPORT=3Dm=0AC=
ONFIG_IP_SET_HASH_IPPORTIP=3Dm=0ACONFIG_IP_SET_HASH_IPPORTNET=3Dm=0ACONFIG_=
IP_SET_HASH_IPMAC=3Dm=0ACONFIG_IP_SET_HASH_MAC=3Dm=0ACONFIG_IP_SET_HASH_NET=
PORTNET=3Dm=0ACONFIG_IP_SET_HASH_NET=3Dm=0ACONFIG_IP_SET_HASH_NETNET=3Dm=0A=
CONFIG_IP_SET_HASH_NETPORT=3Dm=0ACONFIG_IP_SET_HASH_NETIFACE=3Dm=0ACONFIG_I=
P_SET_LIST_SET=3Dm=0ACONFIG_IP_VS=3Dm=0ACONFIG_IP_VS_IPV6=3Dy=0A# CONFIG_IP=
_VS_DEBUG is not set=0ACONFIG_IP_VS_TAB_BITS=3D12=0A=0A#=0A# IPVS transport=
 protocol load balancing support=0A#=0ACONFIG_IP_VS_PROTO_TCP=3Dy=0ACONFIG_=
IP_VS_PROTO_UDP=3Dy=0ACONFIG_IP_VS_PROTO_AH_ESP=3Dy=0ACONFIG_IP_VS_PROTO_ES=
P=3Dy=0ACONFIG_IP_VS_PROTO_AH=3Dy=0ACONFIG_IP_VS_PROTO_SCTP=3Dy=0A=0A#=0A# =
IPVS scheduler=0A#=0ACONFIG_IP_VS_RR=3Dm=0ACONFIG_IP_VS_WRR=3Dm=0ACONFIG_IP=
_VS_LC=3Dm=0ACONFIG_IP_VS_WLC=3Dm=0ACONFIG_IP_VS_FO=3Dm=0ACONFIG_IP_VS_OVF=
=3Dm=0ACONFIG_IP_VS_LBLC=3Dm=0ACONFIG_IP_VS_LBLCR=3Dm=0ACONFIG_IP_VS_DH=3Dm=
=0ACONFIG_IP_VS_SH=3Dm=0A# CONFIG_IP_VS_MH is not set=0ACONFIG_IP_VS_SED=3D=
m=0ACONFIG_IP_VS_NQ=3Dm=0A# CONFIG_IP_VS_TWOS is not set=0A=0A#=0A# IPVS SH=
 scheduler=0A#=0ACONFIG_IP_VS_SH_TAB_BITS=3D8=0A=0A#=0A# IPVS MH scheduler=
=0A#=0ACONFIG_IP_VS_MH_TAB_INDEX=3D12=0A=0A#=0A# IPVS application helper=0A=
#=0ACONFIG_IP_VS_FTP=3Dm=0ACONFIG_IP_VS_NFCT=3Dy=0ACONFIG_IP_VS_PE_SIP=3Dm=
=0A=0A#=0A# IP: Netfilter Configuration=0A#=0ACONFIG_NF_DEFRAG_IPV4=3Dm=0AC=
ONFIG_NF_SOCKET_IPV4=3Dm=0ACONFIG_NF_TPROXY_IPV4=3Dm=0ACONFIG_NF_TABLES_IPV=
4=3Dy=0ACONFIG_NFT_REJECT_IPV4=3Dm=0ACONFIG_NFT_DUP_IPV4=3Dm=0ACONFIG_NFT_F=
IB_IPV4=3Dm=0ACONFIG_NF_TABLES_ARP=3Dy=0ACONFIG_NF_DUP_IPV4=3Dm=0ACONFIG_NF=
_LOG_ARP=3Dm=0ACONFIG_NF_LOG_IPV4=3Dm=0ACONFIG_NF_REJECT_IPV4=3Dm=0ACONFIG_=
NF_NAT_SNMP_BASIC=3Dm=0ACONFIG_NF_NAT_PPTP=3Dm=0ACONFIG_NF_NAT_H323=3Dm=0AC=
ONFIG_IP_NF_IPTABLES=3Dm=0ACONFIG_IP_NF_MATCH_AH=3Dm=0ACONFIG_IP_NF_MATCH_E=
CN=3Dm=0ACONFIG_IP_NF_MATCH_RPFILTER=3Dm=0ACONFIG_IP_NF_MATCH_TTL=3Dm=0ACON=
FIG_IP_NF_FILTER=3Dm=0ACONFIG_IP_NF_TARGET_REJECT=3Dm=0ACONFIG_IP_NF_TARGET=
_SYNPROXY=3Dm=0ACONFIG_IP_NF_NAT=3Dm=0ACONFIG_IP_NF_TARGET_MASQUERADE=3Dm=
=0ACONFIG_IP_NF_TARGET_NETMAP=3Dm=0ACONFIG_IP_NF_TARGET_REDIRECT=3Dm=0ACONF=
IG_IP_NF_MANGLE=3Dm=0A# CONFIG_IP_NF_TARGET_CLUSTERIP is not set=0ACONFIG_I=
P_NF_TARGET_ECN=3Dm=0ACONFIG_IP_NF_TARGET_TTL=3Dm=0ACONFIG_IP_NF_RAW=3Dm=0A=
CONFIG_IP_NF_SECURITY=3Dm=0ACONFIG_IP_NF_ARPTABLES=3Dm=0ACONFIG_IP_NF_ARPFI=
LTER=3Dm=0ACONFIG_IP_NF_ARP_MANGLE=3Dm=0A# end of IP: Netfilter Configurati=
on=0A=0A#=0A# IPv6: Netfilter Configuration=0A#=0ACONFIG_NF_SOCKET_IPV6=3Dm=
=0ACONFIG_NF_TPROXY_IPV6=3Dm=0ACONFIG_NF_TABLES_IPV6=3Dy=0ACONFIG_NFT_REJEC=
T_IPV6=3Dm=0ACONFIG_NFT_DUP_IPV6=3Dm=0ACONFIG_NFT_FIB_IPV6=3Dm=0ACONFIG_NF_=
DUP_IPV6=3Dm=0ACONFIG_NF_REJECT_IPV6=3Dm=0ACONFIG_NF_LOG_IPV6=3Dm=0ACONFIG_=
IP6_NF_IPTABLES=3Dm=0ACONFIG_IP6_NF_MATCH_AH=3Dm=0ACONFIG_IP6_NF_MATCH_EUI6=
4=3Dm=0ACONFIG_IP6_NF_MATCH_FRAG=3Dm=0ACONFIG_IP6_NF_MATCH_OPTS=3Dm=0ACONFI=
G_IP6_NF_MATCH_HL=3Dm=0ACONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm=0ACONFIG_IP6_NF_=
MATCH_MH=3Dm=0ACONFIG_IP6_NF_MATCH_RPFILTER=3Dm=0ACONFIG_IP6_NF_MATCH_RT=3D=
m=0A# CONFIG_IP6_NF_MATCH_SRH is not set=0A# CONFIG_IP6_NF_TARGET_HL is not=
 set=0ACONFIG_IP6_NF_FILTER=3Dm=0ACONFIG_IP6_NF_TARGET_REJECT=3Dm=0ACONFIG_=
IP6_NF_TARGET_SYNPROXY=3Dm=0ACONFIG_IP6_NF_MANGLE=3Dm=0ACONFIG_IP6_NF_RAW=
=3Dm=0ACONFIG_IP6_NF_SECURITY=3Dm=0ACONFIG_IP6_NF_NAT=3Dm=0ACONFIG_IP6_NF_T=
ARGET_MASQUERADE=3Dm=0ACONFIG_IP6_NF_TARGET_NPT=3Dm=0A# end of IPv6: Netfil=
ter Configuration=0A=0ACONFIG_NF_DEFRAG_IPV6=3Dm=0ACONFIG_NF_TABLES_BRIDGE=
=3Dm=0A# CONFIG_NFT_BRIDGE_META is not set=0ACONFIG_NFT_BRIDGE_REJECT=3Dm=
=0A# CONFIG_NF_CONNTRACK_BRIDGE is not set=0ACONFIG_BRIDGE_NF_EBTABLES=3Dm=
=0ACONFIG_BRIDGE_EBT_BROUTE=3Dm=0ACONFIG_BRIDGE_EBT_T_FILTER=3Dm=0ACONFIG_B=
RIDGE_EBT_T_NAT=3Dm=0ACONFIG_BRIDGE_EBT_802_3=3Dm=0ACONFIG_BRIDGE_EBT_AMONG=
=3Dm=0ACONFIG_BRIDGE_EBT_ARP=3Dm=0ACONFIG_BRIDGE_EBT_IP=3Dm=0ACONFIG_BRIDGE=
_EBT_IP6=3Dm=0ACONFIG_BRIDGE_EBT_LIMIT=3Dm=0ACONFIG_BRIDGE_EBT_MARK=3Dm=0AC=
ONFIG_BRIDGE_EBT_PKTTYPE=3Dm=0ACONFIG_BRIDGE_EBT_STP=3Dm=0ACONFIG_BRIDGE_EB=
T_VLAN=3Dm=0ACONFIG_BRIDGE_EBT_ARPREPLY=3Dm=0ACONFIG_BRIDGE_EBT_DNAT=3Dm=0A=
CONFIG_BRIDGE_EBT_MARK_T=3Dm=0ACONFIG_BRIDGE_EBT_REDIRECT=3Dm=0ACONFIG_BRID=
GE_EBT_SNAT=3Dm=0ACONFIG_BRIDGE_EBT_LOG=3Dm=0ACONFIG_BRIDGE_EBT_NFLOG=3Dm=
=0A# CONFIG_BPFILTER is not set=0ACONFIG_IP_DCCP=3Dy=0ACONFIG_INET_DCCP_DIA=
G=3Dm=0A=0A#=0A# DCCP CCIDs Configuration=0A#=0A# CONFIG_IP_DCCP_CCID2_DEBU=
G is not set=0ACONFIG_IP_DCCP_CCID3=3Dy=0A# CONFIG_IP_DCCP_CCID3_DEBUG is n=
ot set=0ACONFIG_IP_DCCP_TFRC_LIB=3Dy=0A# end of DCCP CCIDs Configuration=0A=
=0A#=0A# DCCP Kernel Hacking=0A#=0A# CONFIG_IP_DCCP_DEBUG is not set=0A# en=
d of DCCP Kernel Hacking=0A=0ACONFIG_IP_SCTP=3Dm=0A# CONFIG_SCTP_DBG_OBJCNT=
 is not set=0A# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set=0ACONFIG_SCT=
P_DEFAULT_COOKIE_HMAC_SHA1=3Dy=0A# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is =
not set=0ACONFIG_SCTP_COOKIE_HMAC_MD5=3Dy=0ACONFIG_SCTP_COOKIE_HMAC_SHA1=3D=
y=0ACONFIG_INET_SCTP_DIAG=3Dm=0A# CONFIG_RDS is not set=0ACONFIG_TIPC=3Dm=
=0A# CONFIG_TIPC_MEDIA_IB is not set=0ACONFIG_TIPC_MEDIA_UDP=3Dy=0ACONFIG_T=
IPC_CRYPTO=3Dy=0ACONFIG_TIPC_DIAG=3Dm=0ACONFIG_ATM=3Dm=0ACONFIG_ATM_CLIP=3D=
m=0A# CONFIG_ATM_CLIP_NO_ICMP is not set=0ACONFIG_ATM_LANE=3Dm=0A# CONFIG_A=
TM_MPOA is not set=0ACONFIG_ATM_BR2684=3Dm=0A# CONFIG_ATM_BR2684_IPFILTER i=
s not set=0ACONFIG_L2TP=3Dm=0ACONFIG_L2TP_DEBUGFS=3Dm=0ACONFIG_L2TP_V3=3Dy=
=0ACONFIG_L2TP_IP=3Dm=0ACONFIG_L2TP_ETH=3Dm=0ACONFIG_STP=3Dm=0ACONFIG_GARP=
=3Dm=0ACONFIG_MRP=3Dm=0ACONFIG_BRIDGE=3Dm=0ACONFIG_BRIDGE_IGMP_SNOOPING=3Dy=
=0ACONFIG_BRIDGE_VLAN_FILTERING=3Dy=0A# CONFIG_BRIDGE_MRP is not set=0A# CO=
NFIG_BRIDGE_CFM is not set=0A# CONFIG_NET_DSA is not set=0ACONFIG_VLAN_8021=
Q=3Dm=0ACONFIG_VLAN_8021Q_GVRP=3Dy=0ACONFIG_VLAN_8021Q_MVRP=3Dy=0A# CONFIG_=
DECNET is not set=0ACONFIG_LLC=3Dm=0A# CONFIG_LLC2 is not set=0A# CONFIG_AT=
ALK is not set=0A# CONFIG_X25 is not set=0A# CONFIG_LAPB is not set=0A# CON=
FIG_PHONET is not set=0ACONFIG_6LOWPAN=3Dm=0A# CONFIG_6LOWPAN_DEBUGFS is no=
t set=0A# CONFIG_6LOWPAN_NHC is not set=0ACONFIG_IEEE802154=3Dm=0A# CONFIG_=
IEEE802154_NL802154_EXPERIMENTAL is not set=0ACONFIG_IEEE802154_SOCKET=3Dm=
=0ACONFIG_IEEE802154_6LOWPAN=3Dm=0ACONFIG_MAC802154=3Dm=0ACONFIG_NET_SCHED=
=3Dy=0A=0A#=0A# Queueing/Scheduling=0A#=0ACONFIG_NET_SCH_CBQ=3Dm=0ACONFIG_N=
ET_SCH_HTB=3Dm=0ACONFIG_NET_SCH_HFSC=3Dm=0ACONFIG_NET_SCH_ATM=3Dm=0ACONFIG_=
NET_SCH_PRIO=3Dm=0ACONFIG_NET_SCH_MULTIQ=3Dm=0ACONFIG_NET_SCH_RED=3Dm=0ACON=
FIG_NET_SCH_SFB=3Dm=0ACONFIG_NET_SCH_SFQ=3Dm=0ACONFIG_NET_SCH_TEQL=3Dm=0ACO=
NFIG_NET_SCH_TBF=3Dm=0A# CONFIG_NET_SCH_CBS is not set=0A# CONFIG_NET_SCH_E=
TF is not set=0A# CONFIG_NET_SCH_TAPRIO is not set=0ACONFIG_NET_SCH_GRED=3D=
m=0ACONFIG_NET_SCH_DSMARK=3Dm=0ACONFIG_NET_SCH_NETEM=3Dm=0ACONFIG_NET_SCH_D=
RR=3Dm=0ACONFIG_NET_SCH_MQPRIO=3Dm=0A# CONFIG_NET_SCH_SKBPRIO is not set=0A=
CONFIG_NET_SCH_CHOKE=3Dm=0ACONFIG_NET_SCH_QFQ=3Dm=0ACONFIG_NET_SCH_CODEL=3D=
m=0ACONFIG_NET_SCH_FQ_CODEL=3Dy=0A# CONFIG_NET_SCH_CAKE is not set=0ACONFIG=
_NET_SCH_FQ=3Dm=0ACONFIG_NET_SCH_HHF=3Dm=0ACONFIG_NET_SCH_PIE=3Dm=0A# CONFI=
G_NET_SCH_FQ_PIE is not set=0ACONFIG_NET_SCH_INGRESS=3Dm=0ACONFIG_NET_SCH_P=
LUG=3Dm=0A# CONFIG_NET_SCH_ETS is not set=0ACONFIG_NET_SCH_DEFAULT=3Dy=0A# =
CONFIG_DEFAULT_FQ is not set=0A# CONFIG_DEFAULT_CODEL is not set=0ACONFIG_D=
EFAULT_FQ_CODEL=3Dy=0A# CONFIG_DEFAULT_SFQ is not set=0A# CONFIG_DEFAULT_PF=
IFO_FAST is not set=0ACONFIG_DEFAULT_NET_SCH=3D"fq_codel"=0A=0A#=0A# Classi=
fication=0A#=0ACONFIG_NET_CLS=3Dy=0ACONFIG_NET_CLS_BASIC=3Dm=0ACONFIG_NET_C=
LS_TCINDEX=3Dm=0ACONFIG_NET_CLS_ROUTE4=3Dm=0ACONFIG_NET_CLS_FW=3Dm=0ACONFIG=
_NET_CLS_U32=3Dm=0ACONFIG_CLS_U32_PERF=3Dy=0ACONFIG_CLS_U32_MARK=3Dy=0ACONF=
IG_NET_CLS_RSVP=3Dm=0ACONFIG_NET_CLS_RSVP6=3Dm=0ACONFIG_NET_CLS_FLOW=3Dm=0A=
CONFIG_NET_CLS_CGROUP=3Dy=0ACONFIG_NET_CLS_BPF=3Dm=0ACONFIG_NET_CLS_FLOWER=
=3Dm=0ACONFIG_NET_CLS_MATCHALL=3Dm=0ACONFIG_NET_EMATCH=3Dy=0ACONFIG_NET_EMA=
TCH_STACK=3D32=0ACONFIG_NET_EMATCH_CMP=3Dm=0ACONFIG_NET_EMATCH_NBYTE=3Dm=0A=
CONFIG_NET_EMATCH_U32=3Dm=0ACONFIG_NET_EMATCH_META=3Dm=0ACONFIG_NET_EMATCH_=
TEXT=3Dm=0A# CONFIG_NET_EMATCH_CANID is not set=0ACONFIG_NET_EMATCH_IPSET=
=3Dm=0A# CONFIG_NET_EMATCH_IPT is not set=0ACONFIG_NET_CLS_ACT=3Dy=0ACONFIG=
_NET_ACT_POLICE=3Dm=0ACONFIG_NET_ACT_GACT=3Dm=0ACONFIG_GACT_PROB=3Dy=0ACONF=
IG_NET_ACT_MIRRED=3Dm=0ACONFIG_NET_ACT_SAMPLE=3Dm=0A# CONFIG_NET_ACT_IPT is=
 not set=0ACONFIG_NET_ACT_NAT=3Dm=0ACONFIG_NET_ACT_PEDIT=3Dm=0ACONFIG_NET_A=
CT_SIMP=3Dm=0ACONFIG_NET_ACT_SKBEDIT=3Dm=0ACONFIG_NET_ACT_CSUM=3Dm=0A# CONF=
IG_NET_ACT_MPLS is not set=0ACONFIG_NET_ACT_VLAN=3Dm=0ACONFIG_NET_ACT_BPF=
=3Dm=0A# CONFIG_NET_ACT_CONNMARK is not set=0A# CONFIG_NET_ACT_CTINFO is no=
t set=0ACONFIG_NET_ACT_SKBMOD=3Dm=0A# CONFIG_NET_ACT_IFE is not set=0ACONFI=
G_NET_ACT_TUNNEL_KEY=3Dm=0A# CONFIG_NET_ACT_GATE is not set=0A# CONFIG_NET_=
TC_SKB_EXT is not set=0ACONFIG_NET_SCH_FIFO=3Dy=0ACONFIG_DCB=3Dy=0ACONFIG_D=
NS_RESOLVER=3Dm=0A# CONFIG_BATMAN_ADV is not set=0ACONFIG_OPENVSWITCH=3Dm=
=0ACONFIG_OPENVSWITCH_GRE=3Dm=0ACONFIG_VSOCKETS=3Dm=0ACONFIG_VSOCKETS_DIAG=
=3Dm=0ACONFIG_VSOCKETS_LOOPBACK=3Dm=0ACONFIG_VMWARE_VMCI_VSOCKETS=3Dm=0ACON=
FIG_VIRTIO_VSOCKETS=3Dm=0ACONFIG_VIRTIO_VSOCKETS_COMMON=3Dm=0ACONFIG_HYPERV=
_VSOCKETS=3Dm=0ACONFIG_NETLINK_DIAG=3Dm=0ACONFIG_MPLS=3Dy=0ACONFIG_NET_MPLS=
_GSO=3Dy=0ACONFIG_MPLS_ROUTING=3Dm=0ACONFIG_MPLS_IPTUNNEL=3Dm=0ACONFIG_NET_=
NSH=3Dy=0A# CONFIG_HSR is not set=0ACONFIG_NET_SWITCHDEV=3Dy=0ACONFIG_NET_L=
3_MASTER_DEV=3Dy=0A# CONFIG_QRTR is not set=0A# CONFIG_NET_NCSI is not set=
=0ACONFIG_PCPU_DEV_REFCNT=3Dy=0ACONFIG_RPS=3Dy=0ACONFIG_RFS_ACCEL=3Dy=0ACON=
FIG_SOCK_RX_QUEUE_MAPPING=3Dy=0ACONFIG_XPS=3Dy=0ACONFIG_CGROUP_NET_PRIO=3Dy=
=0ACONFIG_CGROUP_NET_CLASSID=3Dy=0ACONFIG_NET_RX_BUSY_POLL=3Dy=0ACONFIG_BQL=
=3Dy=0ACONFIG_BPF_STREAM_PARSER=3Dy=0ACONFIG_NET_FLOW_LIMIT=3Dy=0A=0A#=0A# =
Network testing=0A#=0ACONFIG_NET_PKTGEN=3Dm=0ACONFIG_NET_DROP_MONITOR=3Dy=
=0A# end of Network testing=0A# end of Networking options=0A=0A# CONFIG_HAM=
RADIO is not set=0ACONFIG_CAN=3Dm=0ACONFIG_CAN_RAW=3Dm=0ACONFIG_CAN_BCM=3Dm=
=0ACONFIG_CAN_GW=3Dm=0A# CONFIG_CAN_J1939 is not set=0A# CONFIG_CAN_ISOTP i=
s not set=0A=0A#=0A# CAN Device Drivers=0A#=0ACONFIG_CAN_VCAN=3Dm=0A# CONFI=
G_CAN_VXCAN is not set=0ACONFIG_CAN_SLCAN=3Dm=0ACONFIG_CAN_DEV=3Dm=0ACONFIG=
_CAN_CALC_BITTIMING=3Dy=0A# CONFIG_CAN_KVASER_PCIEFD is not set=0ACONFIG_CA=
N_C_CAN=3Dm=0ACONFIG_CAN_C_CAN_PLATFORM=3Dm=0ACONFIG_CAN_C_CAN_PCI=3Dm=0ACO=
NFIG_CAN_CC770=3Dm=0A# CONFIG_CAN_CC770_ISA is not set=0ACONFIG_CAN_CC770_P=
LATFORM=3Dm=0A# CONFIG_CAN_IFI_CANFD is not set=0A# CONFIG_CAN_M_CAN is not=
 set=0A# CONFIG_CAN_PEAK_PCIEFD is not set=0ACONFIG_CAN_SJA1000=3Dm=0ACONFI=
G_CAN_EMS_PCI=3Dm=0A# CONFIG_CAN_F81601 is not set=0ACONFIG_CAN_KVASER_PCI=
=3Dm=0ACONFIG_CAN_PEAK_PCI=3Dm=0ACONFIG_CAN_PEAK_PCIEC=3Dy=0ACONFIG_CAN_PLX=
_PCI=3Dm=0A# CONFIG_CAN_SJA1000_ISA is not set=0ACONFIG_CAN_SJA1000_PLATFOR=
M=3Dm=0ACONFIG_CAN_SOFTING=3Dm=0A=0A#=0A# CAN SPI interfaces=0A#=0A# CONFIG=
_CAN_HI311X is not set=0A# CONFIG_CAN_MCP251X is not set=0A# CONFIG_CAN_MCP=
251XFD is not set=0A# end of CAN SPI interfaces=0A=0A#=0A# CAN USB interfac=
es=0A#=0A# CONFIG_CAN_8DEV_USB is not set=0A# CONFIG_CAN_EMS_USB is not set=
=0A# CONFIG_CAN_ESD_USB2 is not set=0A# CONFIG_CAN_ETAS_ES58X is not set=0A=
# CONFIG_CAN_GS_USB is not set=0A# CONFIG_CAN_KVASER_USB is not set=0A# CON=
FIG_CAN_MCBA_USB is not set=0A# CONFIG_CAN_PEAK_USB is not set=0A# CONFIG_C=
AN_UCAN is not set=0A# end of CAN USB interfaces=0A=0A# CONFIG_CAN_DEBUG_DE=
VICES is not set=0A# end of CAN Device Drivers=0A=0ACONFIG_BT=3Dm=0ACONFIG_=
BT_BREDR=3Dy=0ACONFIG_BT_RFCOMM=3Dm=0ACONFIG_BT_RFCOMM_TTY=3Dy=0ACONFIG_BT_=
BNEP=3Dm=0ACONFIG_BT_BNEP_MC_FILTER=3Dy=0ACONFIG_BT_BNEP_PROTO_FILTER=3Dy=
=0ACONFIG_BT_HIDP=3Dm=0ACONFIG_BT_HS=3Dy=0ACONFIG_BT_LE=3Dy=0A# CONFIG_BT_6=
LOWPAN is not set=0A# CONFIG_BT_LEDS is not set=0A# CONFIG_BT_MSFTEXT is no=
t set=0A# CONFIG_BT_AOSPEXT is not set=0ACONFIG_BT_DEBUGFS=3Dy=0A# CONFIG_B=
T_SELFTEST is not set=0A=0A#=0A# Bluetooth device drivers=0A#=0A# CONFIG_BT=
_HCIBTUSB is not set=0A# CONFIG_BT_HCIBTSDIO is not set=0ACONFIG_BT_HCIUART=
=3Dm=0ACONFIG_BT_HCIUART_H4=3Dy=0ACONFIG_BT_HCIUART_BCSP=3Dy=0ACONFIG_BT_HC=
IUART_ATH3K=3Dy=0A# CONFIG_BT_HCIUART_INTEL is not set=0A# CONFIG_BT_HCIUAR=
T_AG6XX is not set=0A# CONFIG_BT_HCIBCM203X is not set=0A# CONFIG_BT_HCIBPA=
10X is not set=0A# CONFIG_BT_HCIBFUSB is not set=0ACONFIG_BT_HCIVHCI=3Dm=0A=
CONFIG_BT_MRVL=3Dm=0A# CONFIG_BT_MRVL_SDIO is not set=0A# CONFIG_BT_MTKSDIO=
 is not set=0A# CONFIG_BT_VIRTIO is not set=0A# end of Bluetooth device dri=
vers=0A=0A# CONFIG_AF_RXRPC is not set=0A# CONFIG_AF_KCM is not set=0ACONFI=
G_STREAM_PARSER=3Dy=0A# CONFIG_MCTP is not set=0ACONFIG_FIB_RULES=3Dy=0ACON=
FIG_WIRELESS=3Dy=0ACONFIG_WEXT_CORE=3Dy=0ACONFIG_WEXT_PROC=3Dy=0ACONFIG_CFG=
80211=3Dm=0A# CONFIG_NL80211_TESTMODE is not set=0A# CONFIG_CFG80211_DEVELO=
PER_WARNINGS is not set=0ACONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy=0ACONFIG=
_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy=0ACONFIG_CFG80211_DEFAULT_PS=3Dy=0A# CO=
NFIG_CFG80211_DEBUGFS is not set=0ACONFIG_CFG80211_CRDA_SUPPORT=3Dy=0ACONFI=
G_CFG80211_WEXT=3Dy=0ACONFIG_MAC80211=3Dm=0ACONFIG_MAC80211_HAS_RC=3Dy=0ACO=
NFIG_MAC80211_RC_MINSTREL=3Dy=0ACONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy=0AC=
ONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"=0ACONFIG_MAC80211_MESH=3Dy=0ACONF=
IG_MAC80211_LEDS=3Dy=0ACONFIG_MAC80211_DEBUGFS=3Dy=0A# CONFIG_MAC80211_MESS=
AGE_TRACING is not set=0A# CONFIG_MAC80211_DEBUG_MENU is not set=0ACONFIG_M=
AC80211_STA_HASH_MAX_SIZE=3D0=0ACONFIG_RFKILL=3Dm=0ACONFIG_RFKILL_LEDS=3Dy=
=0ACONFIG_RFKILL_INPUT=3Dy=0A# CONFIG_RFKILL_GPIO is not set=0ACONFIG_NET_9=
P=3Dy=0ACONFIG_NET_9P_VIRTIO=3Dy=0A# CONFIG_NET_9P_RDMA is not set=0A# CONF=
IG_NET_9P_DEBUG is not set=0A# CONFIG_CAIF is not set=0ACONFIG_CEPH_LIB=3Dm=
=0A# CONFIG_CEPH_LIB_PRETTYDEBUG is not set=0ACONFIG_CEPH_LIB_USE_DNS_RESOL=
VER=3Dy=0A# CONFIG_NFC is not set=0ACONFIG_PSAMPLE=3Dm=0A# CONFIG_NET_IFE i=
s not set=0ACONFIG_LWTUNNEL=3Dy=0ACONFIG_LWTUNNEL_BPF=3Dy=0ACONFIG_DST_CACH=
E=3Dy=0ACONFIG_GRO_CELLS=3Dy=0ACONFIG_SOCK_VALIDATE_XMIT=3Dy=0ACONFIG_NET_S=
ELFTESTS=3Dy=0ACONFIG_NET_SOCK_MSG=3Dy=0ACONFIG_FAILOVER=3Dm=0ACONFIG_ETHTO=
OL_NETLINK=3Dy=0A=0A#=0A# Device Drivers=0A#=0ACONFIG_HAVE_EISA=3Dy=0A# CON=
FIG_EISA is not set=0ACONFIG_HAVE_PCI=3Dy=0ACONFIG_PCI=3Dy=0ACONFIG_PCI_DOM=
AINS=3Dy=0ACONFIG_PCIEPORTBUS=3Dy=0ACONFIG_HOTPLUG_PCI_PCIE=3Dy=0ACONFIG_PC=
IEAER=3Dy=0ACONFIG_PCIEAER_INJECT=3Dm=0ACONFIG_PCIE_ECRC=3Dy=0ACONFIG_PCIEA=
SPM=3Dy=0ACONFIG_PCIEASPM_DEFAULT=3Dy=0A# CONFIG_PCIEASPM_POWERSAVE is not =
set=0A# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set=0A# CONFIG_PCIEASPM_PERF=
ORMANCE is not set=0ACONFIG_PCIE_PME=3Dy=0ACONFIG_PCIE_DPC=3Dy=0A# CONFIG_P=
CIE_PTM is not set=0A# CONFIG_PCIE_EDR is not set=0ACONFIG_PCI_MSI=3Dy=0ACO=
NFIG_PCI_MSI_IRQ_DOMAIN=3Dy=0ACONFIG_PCI_QUIRKS=3Dy=0A# CONFIG_PCI_DEBUG is=
 not set=0A# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set=0ACONFIG_PCI_STUB=3D=
y=0ACONFIG_PCI_PF_STUB=3Dm=0ACONFIG_PCI_ATS=3Dy=0ACONFIG_PCI_LOCKLESS_CONFI=
G=3Dy=0ACONFIG_PCI_IOV=3Dy=0ACONFIG_PCI_PRI=3Dy=0ACONFIG_PCI_PASID=3Dy=0A# =
CONFIG_PCI_P2PDMA is not set=0ACONFIG_PCI_LABEL=3Dy=0ACONFIG_PCI_HYPERV=3Dm=
=0ACONFIG_HOTPLUG_PCI=3Dy=0ACONFIG_HOTPLUG_PCI_ACPI=3Dy=0ACONFIG_HOTPLUG_PC=
I_ACPI_IBM=3Dm=0A# CONFIG_HOTPLUG_PCI_CPCI is not set=0ACONFIG_HOTPLUG_PCI_=
SHPC=3Dy=0A=0A#=0A# PCI controller drivers=0A#=0ACONFIG_VMD=3Dy=0ACONFIG_PC=
I_HYPERV_INTERFACE=3Dm=0A=0A#=0A# DesignWare PCI Core Support=0A#=0A# CONFI=
G_PCIE_DW_PLAT_HOST is not set=0A# CONFIG_PCI_MESON is not set=0A# end of D=
esignWare PCI Core Support=0A=0A#=0A# Mobiveil PCIe Core Support=0A#=0A# en=
d of Mobiveil PCIe Core Support=0A=0A#=0A# Cadence PCIe controllers support=
=0A#=0A# end of Cadence PCIe controllers support=0A# end of PCI controller =
drivers=0A=0A#=0A# PCI Endpoint=0A#=0A# CONFIG_PCI_ENDPOINT is not set=0A# =
end of PCI Endpoint=0A=0A#=0A# PCI switch controller drivers=0A#=0A# CONFIG=
_PCI_SW_SWITCHTEC is not set=0A# end of PCI switch controller drivers=0A=0A=
# CONFIG_CXL_BUS is not set=0A# CONFIG_PCCARD is not set=0A# CONFIG_RAPIDIO=
 is not set=0A=0A#=0A# Generic Driver Options=0A#=0ACONFIG_AUXILIARY_BUS=3D=
y=0A# CONFIG_UEVENT_HELPER is not set=0ACONFIG_DEVTMPFS=3Dy=0ACONFIG_DEVTMP=
FS_MOUNT=3Dy=0ACONFIG_STANDALONE=3Dy=0ACONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
=0A#=0A# Firmware loader=0A#=0ACONFIG_FW_LOADER=3Dy=0ACONFIG_FW_LOADER_PAGE=
D_BUF=3Dy=0ACONFIG_EXTRA_FIRMWARE=3D""=0ACONFIG_FW_LOADER_USER_HELPER=3Dy=
=0A# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set=0A# CONFIG_FW_LOADER_=
COMPRESS is not set=0ACONFIG_FW_CACHE=3Dy=0A# end of Firmware loader=0A=0AC=
ONFIG_ALLOW_DEV_COREDUMP=3Dy=0A# CONFIG_DEBUG_DRIVER is not set=0A# CONFIG_=
DEBUG_DEVRES is not set=0A# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set=0ACO=
NFIG_PM_QOS_KUNIT_TEST=3Dy=0A# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set=0A=
CONFIG_DRIVER_PE_KUNIT_TEST=3Dy=0ACONFIG_GENERIC_CPU_AUTOPROBE=3Dy=0ACONFIG=
_GENERIC_CPU_VULNERABILITIES=3Dy=0ACONFIG_REGMAP=3Dy=0ACONFIG_REGMAP_I2C=3D=
m=0ACONFIG_REGMAP_SPI=3Dm=0ACONFIG_DMA_SHARED_BUFFER=3Dy=0A# CONFIG_DMA_FEN=
CE_TRACE is not set=0A# end of Generic Driver Options=0A=0A#=0A# Bus device=
s=0A#=0A# CONFIG_MHI_BUS is not set=0A# end of Bus devices=0A=0ACONFIG_CONN=
ECTOR=3Dy=0ACONFIG_PROC_EVENTS=3Dy=0A# CONFIG_GNSS is not set=0A# CONFIG_MT=
D is not set=0A# CONFIG_OF is not set=0ACONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=
=3Dy=0ACONFIG_PARPORT=3Dm=0ACONFIG_PARPORT_PC=3Dm=0ACONFIG_PARPORT_SERIAL=
=3Dm=0A# CONFIG_PARPORT_PC_FIFO is not set=0A# CONFIG_PARPORT_PC_SUPERIO is=
 not set=0A# CONFIG_PARPORT_AX88796 is not set=0ACONFIG_PARPORT_1284=3Dy=0A=
CONFIG_PNP=3Dy=0A# CONFIG_PNP_DEBUG_MESSAGES is not set=0A=0A#=0A# Protocol=
s=0A#=0ACONFIG_PNPACPI=3Dy=0ACONFIG_BLK_DEV=3Dy=0ACONFIG_BLK_DEV_NULL_BLK=
=3Dm=0ACONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=3Dy=0A# CONFIG_BLK_DEV_FD is=
 not set=0ACONFIG_CDROM=3Dm=0A# CONFIG_PARIDE is not set=0A# CONFIG_BLK_DEV=
_PCIESSD_MTIP32XX is not set=0ACONFIG_ZRAM=3Dm=0ACONFIG_ZRAM_DEF_COMP_LZORL=
E=3Dy=0A# CONFIG_ZRAM_DEF_COMP_LZO is not set=0ACONFIG_ZRAM_DEF_COMP=3D"lzo=
-rle"=0ACONFIG_ZRAM_WRITEBACK=3Dy=0A# CONFIG_ZRAM_MEMORY_TRACKING is not se=
t=0ACONFIG_BLK_DEV_LOOP=3Dm=0ACONFIG_BLK_DEV_LOOP_MIN_COUNT=3D0=0A# CONFIG_=
BLK_DEV_CRYPTOLOOP is not set=0A# CONFIG_BLK_DEV_DRBD is not set=0ACONFIG_B=
LK_DEV_NBD=3Dm=0A# CONFIG_BLK_DEV_SX8 is not set=0ACONFIG_BLK_DEV_RAM=3Dm=
=0ACONFIG_BLK_DEV_RAM_COUNT=3D16=0ACONFIG_BLK_DEV_RAM_SIZE=3D16384=0ACONFIG=
_CDROM_PKTCDVD=3Dm=0ACONFIG_CDROM_PKTCDVD_BUFFERS=3D8=0A# CONFIG_CDROM_PKTC=
DVD_WCACHE is not set=0A# CONFIG_ATA_OVER_ETH is not set=0ACONFIG_VIRTIO_BL=
K=3Dm=0ACONFIG_BLK_DEV_RBD=3Dm=0A# CONFIG_BLK_DEV_RSXX is not set=0A=0A#=0A=
# NVME Support=0A#=0ACONFIG_NVME_CORE=3Dm=0ACONFIG_BLK_DEV_NVME=3Dm=0ACONFI=
G_NVME_MULTIPATH=3Dy=0A# CONFIG_NVME_HWMON is not set=0ACONFIG_NVME_FABRICS=
=3Dm=0A# CONFIG_NVME_RDMA is not set=0ACONFIG_NVME_FC=3Dm=0A# CONFIG_NVME_T=
CP is not set=0ACONFIG_NVME_TARGET=3Dm=0A# CONFIG_NVME_TARGET_PASSTHRU is n=
ot set=0ACONFIG_NVME_TARGET_LOOP=3Dm=0A# CONFIG_NVME_TARGET_RDMA is not set=
=0ACONFIG_NVME_TARGET_FC=3Dm=0ACONFIG_NVME_TARGET_FCLOOP=3Dm=0A# CONFIG_NVM=
E_TARGET_TCP is not set=0A# end of NVME Support=0A=0A#=0A# Misc devices=0A#=
=0ACONFIG_SENSORS_LIS3LV02D=3Dm=0A# CONFIG_AD525X_DPOT is not set=0A# CONFI=
G_DUMMY_IRQ is not set=0A# CONFIG_IBM_ASM is not set=0A# CONFIG_PHANTOM is =
not set=0ACONFIG_TIFM_CORE=3Dm=0ACONFIG_TIFM_7XX1=3Dm=0A# CONFIG_ICS932S401=
 is not set=0ACONFIG_ENCLOSURE_SERVICES=3Dm=0ACONFIG_SGI_XP=3Dm=0ACONFIG_HP=
_ILO=3Dm=0ACONFIG_SGI_GRU=3Dm=0A# CONFIG_SGI_GRU_DEBUG is not set=0ACONFIG_=
APDS9802ALS=3Dm=0ACONFIG_ISL29003=3Dm=0ACONFIG_ISL29020=3Dm=0ACONFIG_SENSOR=
S_TSL2550=3Dm=0ACONFIG_SENSORS_BH1770=3Dm=0ACONFIG_SENSORS_APDS990X=3Dm=0A#=
 CONFIG_HMC6352 is not set=0A# CONFIG_DS1682 is not set=0ACONFIG_VMWARE_BAL=
LOON=3Dm=0A# CONFIG_LATTICE_ECP3_CONFIG is not set=0A# CONFIG_SRAM is not s=
et=0A# CONFIG_DW_XDATA_PCIE is not set=0A# CONFIG_PCI_ENDPOINT_TEST is not =
set=0A# CONFIG_XILINX_SDFEC is not set=0ACONFIG_MISC_RTSX=3Dm=0A# CONFIG_C2=
PORT is not set=0A=0A#=0A# EEPROM support=0A#=0A# CONFIG_EEPROM_AT24 is not=
 set=0A# CONFIG_EEPROM_AT25 is not set=0ACONFIG_EEPROM_LEGACY=3Dm=0ACONFIG_=
EEPROM_MAX6875=3Dm=0ACONFIG_EEPROM_93CX6=3Dm=0A# CONFIG_EEPROM_93XX46 is no=
t set=0A# CONFIG_EEPROM_IDT_89HPESX is not set=0A# CONFIG_EEPROM_EE1004 is =
not set=0A# end of EEPROM support=0A=0ACONFIG_CB710_CORE=3Dm=0A# CONFIG_CB7=
10_DEBUG is not set=0ACONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy=0A=0A#=0A# Texas I=
nstruments shared transport line discipline=0A#=0A# CONFIG_TI_ST is not set=
=0A# end of Texas Instruments shared transport line discipline=0A=0ACONFIG_=
SENSORS_LIS3_I2C=3Dm=0ACONFIG_ALTERA_STAPL=3Dm=0ACONFIG_INTEL_MEI=3Dm=0ACON=
FIG_INTEL_MEI_ME=3Dm=0A# CONFIG_INTEL_MEI_TXE is not set=0A# CONFIG_INTEL_M=
EI_HDCP is not set=0ACONFIG_VMWARE_VMCI=3Dm=0A# CONFIG_GENWQE is not set=0A=
# CONFIG_ECHO is not set=0A# CONFIG_BCM_VK is not set=0A# CONFIG_MISC_ALCOR=
_PCI is not set=0ACONFIG_MISC_RTSX_PCI=3Dm=0A# CONFIG_MISC_RTSX_USB is not =
set=0A# CONFIG_HABANA_AI is not set=0A# CONFIG_UACCE is not set=0ACONFIG_PV=
PANIC=3Dy=0A# CONFIG_PVPANIC_MMIO is not set=0A# CONFIG_PVPANIC_PCI is not =
set=0A# end of Misc devices=0A=0A#=0A# SCSI device support=0A#=0ACONFIG_SCS=
I_MOD=3Dy=0ACONFIG_RAID_ATTRS=3Dm=0ACONFIG_SCSI_COMMON=3Dy=0ACONFIG_SCSI=3D=
y=0ACONFIG_SCSI_DMA=3Dy=0ACONFIG_SCSI_NETLINK=3Dy=0ACONFIG_SCSI_PROC_FS=3Dy=
=0A=0A#=0A# SCSI support type (disk, tape, CD-ROM)=0A#=0ACONFIG_BLK_DEV_SD=
=3Dm=0ACONFIG_CHR_DEV_ST=3Dm=0ACONFIG_BLK_DEV_SR=3Dm=0ACONFIG_CHR_DEV_SG=3D=
m=0ACONFIG_BLK_DEV_BSG=3Dy=0ACONFIG_CHR_DEV_SCH=3Dm=0ACONFIG_SCSI_ENCLOSURE=
=3Dm=0ACONFIG_SCSI_CONSTANTS=3Dy=0ACONFIG_SCSI_LOGGING=3Dy=0ACONFIG_SCSI_SC=
AN_ASYNC=3Dy=0A=0A#=0A# SCSI Transports=0A#=0ACONFIG_SCSI_SPI_ATTRS=3Dm=0AC=
ONFIG_SCSI_FC_ATTRS=3Dm=0ACONFIG_SCSI_ISCSI_ATTRS=3Dm=0ACONFIG_SCSI_SAS_ATT=
RS=3Dm=0ACONFIG_SCSI_SAS_LIBSAS=3Dm=0ACONFIG_SCSI_SAS_ATA=3Dy=0ACONFIG_SCSI=
_SAS_HOST_SMP=3Dy=0ACONFIG_SCSI_SRP_ATTRS=3Dm=0A# end of SCSI Transports=0A=
=0ACONFIG_SCSI_LOWLEVEL=3Dy=0A# CONFIG_ISCSI_TCP is not set=0A# CONFIG_ISCS=
I_BOOT_SYSFS is not set=0A# CONFIG_SCSI_CXGB3_ISCSI is not set=0A# CONFIG_S=
CSI_CXGB4_ISCSI is not set=0A# CONFIG_SCSI_BNX2_ISCSI is not set=0A# CONFIG=
_BE2ISCSI is not set=0A# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A# CONFIG_=
SCSI_HPSA is not set=0A# CONFIG_SCSI_3W_9XXX is not set=0A# CONFIG_SCSI_3W_=
SAS is not set=0A# CONFIG_SCSI_ACARD is not set=0A# CONFIG_SCSI_AACRAID is =
not set=0A# CONFIG_SCSI_AIC7XXX is not set=0A# CONFIG_SCSI_AIC79XX is not s=
et=0A# CONFIG_SCSI_AIC94XX is not set=0A# CONFIG_SCSI_MVSAS is not set=0A# =
CONFIG_SCSI_MVUMI is not set=0A# CONFIG_SCSI_DPT_I2O is not set=0A# CONFIG_=
SCSI_ADVANSYS is not set=0A# CONFIG_SCSI_ARCMSR is not set=0A# CONFIG_SCSI_=
ESAS2R is not set=0A# CONFIG_MEGARAID_NEWGEN is not set=0A# CONFIG_MEGARAID=
_LEGACY is not set=0A# CONFIG_MEGARAID_SAS is not set=0ACONFIG_SCSI_MPT3SAS=
=3Dm=0ACONFIG_SCSI_MPT2SAS_MAX_SGE=3D128=0ACONFIG_SCSI_MPT3SAS_MAX_SGE=3D12=
8=0A# CONFIG_SCSI_MPT2SAS is not set=0A# CONFIG_SCSI_MPI3MR is not set=0A# =
CONFIG_SCSI_SMARTPQI is not set=0A# CONFIG_SCSI_UFSHCD is not set=0A# CONFI=
G_SCSI_HPTIOP is not set=0A# CONFIG_SCSI_BUSLOGIC is not set=0A# CONFIG_SCS=
I_MYRB is not set=0A# CONFIG_SCSI_MYRS is not set=0A# CONFIG_VMWARE_PVSCSI =
is not set=0ACONFIG_HYPERV_STORAGE=3Dm=0A# CONFIG_LIBFC is not set=0A# CONF=
IG_SCSI_SNIC is not set=0A# CONFIG_SCSI_DMX3191D is not set=0A# CONFIG_SCSI=
_FDOMAIN_PCI is not set=0ACONFIG_SCSI_ISCI=3Dm=0A# CONFIG_SCSI_IPS is not s=
et=0A# CONFIG_SCSI_INITIO is not set=0A# CONFIG_SCSI_INIA100 is not set=0A#=
 CONFIG_SCSI_PPA is not set=0A# CONFIG_SCSI_IMM is not set=0A# CONFIG_SCSI_=
STEX is not set=0A# CONFIG_SCSI_SYM53C8XX_2 is not set=0A# CONFIG_SCSI_IPR =
is not set=0A# CONFIG_SCSI_QLOGIC_1280 is not set=0A# CONFIG_SCSI_QLA_FC is=
 not set=0A# CONFIG_SCSI_QLA_ISCSI is not set=0A# CONFIG_SCSI_LPFC is not s=
et=0A# CONFIG_SCSI_EFCT is not set=0A# CONFIG_SCSI_DC395x is not set=0A# CO=
NFIG_SCSI_AM53C974 is not set=0A# CONFIG_SCSI_WD719X is not set=0ACONFIG_SC=
SI_DEBUG=3Dm=0A# CONFIG_SCSI_PMCRAID is not set=0A# CONFIG_SCSI_PM8001 is n=
ot set=0A# CONFIG_SCSI_BFA_FC is not set=0A# CONFIG_SCSI_VIRTIO is not set=
=0A# CONFIG_SCSI_CHELSIO_FCOE is not set=0ACONFIG_SCSI_DH=3Dy=0ACONFIG_SCSI=
_DH_RDAC=3Dy=0ACONFIG_SCSI_DH_HP_SW=3Dy=0ACONFIG_SCSI_DH_EMC=3Dy=0ACONFIG_S=
CSI_DH_ALUA=3Dy=0A# end of SCSI device support=0A=0ACONFIG_ATA=3Dm=0ACONFIG=
_SATA_HOST=3Dy=0ACONFIG_PATA_TIMINGS=3Dy=0ACONFIG_ATA_VERBOSE_ERROR=3Dy=0AC=
ONFIG_ATA_FORCE=3Dy=0ACONFIG_ATA_ACPI=3Dy=0A# CONFIG_SATA_ZPODD is not set=
=0ACONFIG_SATA_PMP=3Dy=0A=0A#=0A# Controllers with non-SFF native interface=
=0A#=0ACONFIG_SATA_AHCI=3Dm=0ACONFIG_SATA_MOBILE_LPM_POLICY=3D0=0ACONFIG_SA=
TA_AHCI_PLATFORM=3Dm=0A# CONFIG_SATA_INIC162X is not set=0A# CONFIG_SATA_AC=
ARD_AHCI is not set=0A# CONFIG_SATA_SIL24 is not set=0ACONFIG_ATA_SFF=3Dy=
=0A=0A#=0A# SFF controllers with custom DMA interface=0A#=0A# CONFIG_PDC_AD=
MA is not set=0A# CONFIG_SATA_QSTOR is not set=0A# CONFIG_SATA_SX4 is not s=
et=0ACONFIG_ATA_BMDMA=3Dy=0A=0A#=0A# SATA SFF controllers with BMDMA=0A#=0A=
CONFIG_ATA_PIIX=3Dm=0A# CONFIG_SATA_DWC is not set=0A# CONFIG_SATA_MV is no=
t set=0A# CONFIG_SATA_NV is not set=0A# CONFIG_SATA_PROMISE is not set=0A# =
CONFIG_SATA_SIL is not set=0A# CONFIG_SATA_SIS is not set=0A# CONFIG_SATA_S=
VW is not set=0A# CONFIG_SATA_ULI is not set=0A# CONFIG_SATA_VIA is not set=
=0A# CONFIG_SATA_VITESSE is not set=0A=0A#=0A# PATA SFF controllers with BM=
DMA=0A#=0A# CONFIG_PATA_ALI is not set=0A# CONFIG_PATA_AMD is not set=0A# C=
ONFIG_PATA_ARTOP is not set=0A# CONFIG_PATA_ATIIXP is not set=0A# CONFIG_PA=
TA_ATP867X is not set=0A# CONFIG_PATA_CMD64X is not set=0A# CONFIG_PATA_CYP=
RESS is not set=0A# CONFIG_PATA_EFAR is not set=0A# CONFIG_PATA_HPT366 is n=
ot set=0A# CONFIG_PATA_HPT37X is not set=0A# CONFIG_PATA_HPT3X2N is not set=
=0A# CONFIG_PATA_HPT3X3 is not set=0A# CONFIG_PATA_IT8213 is not set=0A# CO=
NFIG_PATA_IT821X is not set=0A# CONFIG_PATA_JMICRON is not set=0A# CONFIG_P=
ATA_MARVELL is not set=0A# CONFIG_PATA_NETCELL is not set=0A# CONFIG_PATA_N=
INJA32 is not set=0A# CONFIG_PATA_NS87415 is not set=0A# CONFIG_PATA_OLDPII=
X is not set=0A# CONFIG_PATA_OPTIDMA is not set=0A# CONFIG_PATA_PDC2027X is=
 not set=0A# CONFIG_PATA_PDC_OLD is not set=0A# CONFIG_PATA_RADISYS is not =
set=0A# CONFIG_PATA_RDC is not set=0A# CONFIG_PATA_SCH is not set=0A# CONFI=
G_PATA_SERVERWORKS is not set=0A# CONFIG_PATA_SIL680 is not set=0A# CONFIG_=
PATA_SIS is not set=0A# CONFIG_PATA_TOSHIBA is not set=0A# CONFIG_PATA_TRIF=
LEX is not set=0A# CONFIG_PATA_VIA is not set=0A# CONFIG_PATA_WINBOND is no=
t set=0A=0A#=0A# PIO-only SFF controllers=0A#=0A# CONFIG_PATA_CMD640_PCI is=
 not set=0A# CONFIG_PATA_MPIIX is not set=0A# CONFIG_PATA_NS87410 is not se=
t=0A# CONFIG_PATA_OPTI is not set=0A# CONFIG_PATA_RZ1000 is not set=0A=0A#=
=0A# Generic fallback / legacy drivers=0A#=0A# CONFIG_PATA_ACPI is not set=
=0ACONFIG_ATA_GENERIC=3Dm=0A# CONFIG_PATA_LEGACY is not set=0ACONFIG_MD=3Dy=
=0ACONFIG_BLK_DEV_MD=3Dy=0ACONFIG_MD_AUTODETECT=3Dy=0ACONFIG_MD_LINEAR=3Dm=
=0ACONFIG_MD_RAID0=3Dm=0ACONFIG_MD_RAID1=3Dm=0ACONFIG_MD_RAID10=3Dm=0ACONFI=
G_MD_RAID456=3Dm=0ACONFIG_MD_MULTIPATH=3Dm=0ACONFIG_MD_FAULTY=3Dm=0ACONFIG_=
MD_CLUSTER=3Dm=0A# CONFIG_BCACHE is not set=0ACONFIG_BLK_DEV_DM_BUILTIN=3Dy=
=0ACONFIG_BLK_DEV_DM=3Dm=0ACONFIG_DM_DEBUG=3Dy=0ACONFIG_DM_BUFIO=3Dm=0A# CO=
NFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set=0ACONFIG_DM_BIO_PRISON=3Dm=
=0ACONFIG_DM_PERSISTENT_DATA=3Dm=0A# CONFIG_DM_UNSTRIPED is not set=0ACONFI=
G_DM_CRYPT=3Dm=0ACONFIG_DM_SNAPSHOT=3Dm=0ACONFIG_DM_THIN_PROVISIONING=3Dm=
=0ACONFIG_DM_CACHE=3Dm=0ACONFIG_DM_CACHE_SMQ=3Dm=0ACONFIG_DM_WRITECACHE=3Dm=
=0A# CONFIG_DM_EBS is not set=0ACONFIG_DM_ERA=3Dm=0A# CONFIG_DM_CLONE is no=
t set=0ACONFIG_DM_MIRROR=3Dm=0ACONFIG_DM_LOG_USERSPACE=3Dm=0ACONFIG_DM_RAID=
=3Dm=0ACONFIG_DM_ZERO=3Dm=0ACONFIG_DM_MULTIPATH=3Dm=0ACONFIG_DM_MULTIPATH_Q=
L=3Dm=0ACONFIG_DM_MULTIPATH_ST=3Dm=0A# CONFIG_DM_MULTIPATH_HST is not set=
=0A# CONFIG_DM_MULTIPATH_IOA is not set=0ACONFIG_DM_DELAY=3Dm=0A# CONFIG_DM=
_DUST is not set=0ACONFIG_DM_UEVENT=3Dy=0ACONFIG_DM_FLAKEY=3Dm=0ACONFIG_DM_=
VERITY=3Dm=0A# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set=0A# CONFIG_D=
M_VERITY_FEC is not set=0ACONFIG_DM_SWITCH=3Dm=0ACONFIG_DM_LOG_WRITES=3Dm=
=0ACONFIG_DM_INTEGRITY=3Dm=0A# CONFIG_DM_ZONED is not set=0ACONFIG_TARGET_C=
ORE=3Dm=0ACONFIG_TCM_IBLOCK=3Dm=0ACONFIG_TCM_FILEIO=3Dm=0ACONFIG_TCM_PSCSI=
=3Dm=0ACONFIG_TCM_USER2=3Dm=0ACONFIG_LOOPBACK_TARGET=3Dm=0ACONFIG_ISCSI_TAR=
GET=3Dm=0A# CONFIG_SBP_TARGET is not set=0A# CONFIG_FUSION is not set=0A=0A=
#=0A# IEEE 1394 (FireWire) support=0A#=0ACONFIG_FIREWIRE=3Dm=0ACONFIG_FIREW=
IRE_OHCI=3Dm=0ACONFIG_FIREWIRE_SBP2=3Dm=0ACONFIG_FIREWIRE_NET=3Dm=0A# CONFI=
G_FIREWIRE_NOSY is not set=0A# end of IEEE 1394 (FireWire) support=0A=0ACON=
FIG_MACINTOSH_DRIVERS=3Dy=0ACONFIG_MAC_EMUMOUSEBTN=3Dy=0ACONFIG_NETDEVICES=
=3Dy=0ACONFIG_MII=3Dy=0ACONFIG_NET_CORE=3Dy=0A# CONFIG_BONDING is not set=
=0ACONFIG_DUMMY=3Dm=0A# CONFIG_WIREGUARD is not set=0A# CONFIG_EQUALIZER is=
 not set=0A# CONFIG_NET_FC is not set=0A# CONFIG_IFB is not set=0A# CONFIG_=
NET_TEAM is not set=0A# CONFIG_MACVLAN is not set=0A# CONFIG_IPVLAN is not =
set=0A# CONFIG_VXLAN is not set=0A# CONFIG_GENEVE is not set=0A# CONFIG_BAR=
EUDP is not set=0A# CONFIG_GTP is not set=0A# CONFIG_MACSEC is not set=0ACO=
NFIG_NETCONSOLE=3Dm=0ACONFIG_NETCONSOLE_DYNAMIC=3Dy=0ACONFIG_NETPOLL=3Dy=0A=
CONFIG_NET_POLL_CONTROLLER=3Dy=0ACONFIG_TUN=3Dm=0A# CONFIG_TUN_VNET_CROSS_L=
E is not set=0ACONFIG_VETH=3Dm=0ACONFIG_VIRTIO_NET=3Dm=0A# CONFIG_NLMON is =
not set=0A# CONFIG_NET_VRF is not set=0A# CONFIG_VSOCKMON is not set=0A# CO=
NFIG_ARCNET is not set=0ACONFIG_ATM_DRIVERS=3Dy=0A# CONFIG_ATM_DUMMY is not=
 set=0A# CONFIG_ATM_TCP is not set=0A# CONFIG_ATM_LANAI is not set=0A# CONF=
IG_ATM_ENI is not set=0A# CONFIG_ATM_FIRESTREAM is not set=0A# CONFIG_ATM_Z=
ATM is not set=0A# CONFIG_ATM_NICSTAR is not set=0A# CONFIG_ATM_IDT77252 is=
 not set=0A# CONFIG_ATM_AMBASSADOR is not set=0A# CONFIG_ATM_HORIZON is not=
 set=0A# CONFIG_ATM_IA is not set=0A# CONFIG_ATM_FORE200E is not set=0A# CO=
NFIG_ATM_HE is not set=0A# CONFIG_ATM_SOLOS is not set=0ACONFIG_ETHERNET=3D=
y=0ACONFIG_MDIO=3Dy=0A# CONFIG_NET_VENDOR_3COM is not set=0ACONFIG_NET_VEND=
OR_ADAPTEC=3Dy=0A# CONFIG_ADAPTEC_STARFIRE is not set=0ACONFIG_NET_VENDOR_A=
GERE=3Dy=0A# CONFIG_ET131X is not set=0ACONFIG_NET_VENDOR_ALACRITECH=3Dy=0A=
# CONFIG_SLICOSS is not set=0ACONFIG_NET_VENDOR_ALTEON=3Dy=0A# CONFIG_ACENI=
C is not set=0A# CONFIG_ALTERA_TSE is not set=0ACONFIG_NET_VENDOR_AMAZON=3D=
y=0A# CONFIG_ENA_ETHERNET is not set=0ACONFIG_NET_VENDOR_AMD=3Dy=0A# CONFIG=
_AMD8111_ETH is not set=0A# CONFIG_PCNET32 is not set=0A# CONFIG_AMD_XGBE i=
s not set=0ACONFIG_NET_VENDOR_AQUANTIA=3Dy=0A# CONFIG_AQTION is not set=0AC=
ONFIG_NET_VENDOR_ARC=3Dy=0ACONFIG_NET_VENDOR_ATHEROS=3Dy=0A# CONFIG_ATL2 is=
 not set=0A# CONFIG_ATL1 is not set=0A# CONFIG_ATL1E is not set=0A# CONFIG_=
ATL1C is not set=0A# CONFIG_ALX is not set=0ACONFIG_NET_VENDOR_BROADCOM=3Dy=
=0A# CONFIG_B44 is not set=0A# CONFIG_BCMGENET is not set=0A# CONFIG_BNX2 i=
s not set=0A# CONFIG_CNIC is not set=0A# CONFIG_TIGON3 is not set=0A# CONFI=
G_BNX2X is not set=0A# CONFIG_SYSTEMPORT is not set=0A# CONFIG_BNXT is not =
set=0ACONFIG_NET_VENDOR_BROCADE=3Dy=0A# CONFIG_BNA is not set=0ACONFIG_NET_=
VENDOR_CADENCE=3Dy=0A# CONFIG_MACB is not set=0ACONFIG_NET_VENDOR_CAVIUM=3D=
y=0A# CONFIG_THUNDER_NIC_PF is not set=0A# CONFIG_THUNDER_NIC_VF is not set=
=0A# CONFIG_THUNDER_NIC_BGX is not set=0A# CONFIG_THUNDER_NIC_RGX is not se=
t=0ACONFIG_CAVIUM_PTP=3Dy=0A# CONFIG_LIQUIDIO is not set=0A# CONFIG_LIQUIDI=
O_VF is not set=0ACONFIG_NET_VENDOR_CHELSIO=3Dy=0A# CONFIG_CHELSIO_T1 is no=
t set=0A# CONFIG_CHELSIO_T3 is not set=0A# CONFIG_CHELSIO_T4 is not set=0A#=
 CONFIG_CHELSIO_T4VF is not set=0ACONFIG_NET_VENDOR_CISCO=3Dy=0A# CONFIG_EN=
IC is not set=0ACONFIG_NET_VENDOR_CORTINA=3Dy=0A# CONFIG_CX_ECAT is not set=
=0A# CONFIG_DNET is not set=0ACONFIG_NET_VENDOR_DEC=3Dy=0A# CONFIG_NET_TULI=
P is not set=0ACONFIG_NET_VENDOR_DLINK=3Dy=0A# CONFIG_DL2K is not set=0A# C=
ONFIG_SUNDANCE is not set=0ACONFIG_NET_VENDOR_EMULEX=3Dy=0A# CONFIG_BE2NET =
is not set=0ACONFIG_NET_VENDOR_EZCHIP=3Dy=0ACONFIG_NET_VENDOR_GOOGLE=3Dy=0A=
# CONFIG_GVE is not set=0ACONFIG_NET_VENDOR_HUAWEI=3Dy=0A# CONFIG_HINIC is =
not set=0ACONFIG_NET_VENDOR_I825XX=3Dy=0ACONFIG_NET_VENDOR_INTEL=3Dy=0A# CO=
NFIG_E100 is not set=0ACONFIG_E1000=3Dy=0ACONFIG_E1000E=3Dy=0ACONFIG_E1000E=
_HWTS=3Dy=0ACONFIG_IGB=3Dy=0ACONFIG_IGB_HWMON=3Dy=0A# CONFIG_IGBVF is not s=
et=0A# CONFIG_IXGB is not set=0ACONFIG_IXGBE=3Dy=0ACONFIG_IXGBE_HWMON=3Dy=
=0A# CONFIG_IXGBE_DCB is not set=0ACONFIG_IXGBE_IPSEC=3Dy=0A# CONFIG_IXGBEV=
F is not set=0ACONFIG_I40E=3Dy=0A# CONFIG_I40E_DCB is not set=0A# CONFIG_I4=
0EVF is not set=0A# CONFIG_ICE is not set=0A# CONFIG_FM10K is not set=0ACON=
FIG_IGC=3Dy=0ACONFIG_NET_VENDOR_MICROSOFT=3Dy=0A# CONFIG_MICROSOFT_MANA is =
not set=0A# CONFIG_JME is not set=0ACONFIG_NET_VENDOR_LITEX=3Dy=0ACONFIG_NE=
T_VENDOR_MARVELL=3Dy=0A# CONFIG_MVMDIO is not set=0A# CONFIG_SKGE is not se=
t=0A# CONFIG_SKY2 is not set=0A# CONFIG_PRESTERA is not set=0ACONFIG_NET_VE=
NDOR_MELLANOX=3Dy=0A# CONFIG_MLX4_EN is not set=0A# CONFIG_MLX5_CORE is not=
 set=0A# CONFIG_MLXSW_CORE is not set=0A# CONFIG_MLXFW is not set=0ACONFIG_=
NET_VENDOR_MICREL=3Dy=0A# CONFIG_KS8842 is not set=0A# CONFIG_KS8851 is not=
 set=0A# CONFIG_KS8851_MLL is not set=0A# CONFIG_KSZ884X_PCI is not set=0AC=
ONFIG_NET_VENDOR_MICROCHIP=3Dy=0A# CONFIG_ENC28J60 is not set=0A# CONFIG_EN=
CX24J600 is not set=0A# CONFIG_LAN743X is not set=0ACONFIG_NET_VENDOR_MICRO=
SEMI=3Dy=0ACONFIG_NET_VENDOR_MYRI=3Dy=0A# CONFIG_MYRI10GE is not set=0A# CO=
NFIG_FEALNX is not set=0ACONFIG_NET_VENDOR_NATSEMI=3Dy=0A# CONFIG_NATSEMI i=
s not set=0A# CONFIG_NS83820 is not set=0ACONFIG_NET_VENDOR_NETERION=3Dy=0A=
# CONFIG_S2IO is not set=0A# CONFIG_VXGE is not set=0ACONFIG_NET_VENDOR_NET=
RONOME=3Dy=0A# CONFIG_NFP is not set=0ACONFIG_NET_VENDOR_NI=3Dy=0A# CONFIG_=
NI_XGE_MANAGEMENT_ENET is not set=0ACONFIG_NET_VENDOR_8390=3Dy=0A# CONFIG_N=
E2K_PCI is not set=0ACONFIG_NET_VENDOR_NVIDIA=3Dy=0A# CONFIG_FORCEDETH is n=
ot set=0ACONFIG_NET_VENDOR_OKI=3Dy=0A# CONFIG_ETHOC is not set=0ACONFIG_NET=
_VENDOR_PACKET_ENGINES=3Dy=0A# CONFIG_HAMACHI is not set=0A# CONFIG_YELLOWF=
IN is not set=0ACONFIG_NET_VENDOR_PENSANDO=3Dy=0A# CONFIG_IONIC is not set=
=0ACONFIG_NET_VENDOR_QLOGIC=3Dy=0A# CONFIG_QLA3XXX is not set=0A# CONFIG_QL=
CNIC is not set=0A# CONFIG_NETXEN_NIC is not set=0A# CONFIG_QED is not set=
=0ACONFIG_NET_VENDOR_QUALCOMM=3Dy=0A# CONFIG_QCOM_EMAC is not set=0A# CONFI=
G_RMNET is not set=0ACONFIG_NET_VENDOR_RDC=3Dy=0A# CONFIG_R6040 is not set=
=0ACONFIG_NET_VENDOR_REALTEK=3Dy=0A# CONFIG_ATP is not set=0A# CONFIG_8139C=
P is not set=0A# CONFIG_8139TOO is not set=0ACONFIG_R8169=3Dy=0ACONFIG_NET_=
VENDOR_RENESAS=3Dy=0ACONFIG_NET_VENDOR_ROCKER=3Dy=0A# CONFIG_ROCKER is not =
set=0ACONFIG_NET_VENDOR_SAMSUNG=3Dy=0A# CONFIG_SXGBE_ETH is not set=0ACONFI=
G_NET_VENDOR_SEEQ=3Dy=0ACONFIG_NET_VENDOR_SOLARFLARE=3Dy=0A# CONFIG_SFC is =
not set=0A# CONFIG_SFC_FALCON is not set=0ACONFIG_NET_VENDOR_SILAN=3Dy=0A# =
CONFIG_SC92031 is not set=0ACONFIG_NET_VENDOR_SIS=3Dy=0A# CONFIG_SIS900 is =
not set=0A# CONFIG_SIS190 is not set=0ACONFIG_NET_VENDOR_SMSC=3Dy=0A# CONFI=
G_EPIC100 is not set=0A# CONFIG_SMSC911X is not set=0A# CONFIG_SMSC9420 is =
not set=0ACONFIG_NET_VENDOR_SOCIONEXT=3Dy=0ACONFIG_NET_VENDOR_STMICRO=3Dy=
=0A# CONFIG_STMMAC_ETH is not set=0ACONFIG_NET_VENDOR_SUN=3Dy=0A# CONFIG_HA=
PPYMEAL is not set=0A# CONFIG_SUNGEM is not set=0A# CONFIG_CASSINI is not s=
et=0A# CONFIG_NIU is not set=0ACONFIG_NET_VENDOR_SYNOPSYS=3Dy=0A# CONFIG_DW=
C_XLGMAC is not set=0ACONFIG_NET_VENDOR_TEHUTI=3Dy=0A# CONFIG_TEHUTI is not=
 set=0ACONFIG_NET_VENDOR_TI=3Dy=0A# CONFIG_TI_CPSW_PHY_SEL is not set=0A# C=
ONFIG_TLAN is not set=0ACONFIG_NET_VENDOR_VIA=3Dy=0A# CONFIG_VIA_RHINE is n=
ot set=0A# CONFIG_VIA_VELOCITY is not set=0ACONFIG_NET_VENDOR_WIZNET=3Dy=0A=
# CONFIG_WIZNET_W5100 is not set=0A# CONFIG_WIZNET_W5300 is not set=0ACONFI=
G_NET_VENDOR_XILINX=3Dy=0A# CONFIG_XILINX_EMACLITE is not set=0A# CONFIG_XI=
LINX_AXI_EMAC is not set=0A# CONFIG_XILINX_LL_TEMAC is not set=0A# CONFIG_F=
DDI is not set=0A# CONFIG_HIPPI is not set=0A# CONFIG_NET_SB1000 is not set=
=0ACONFIG_PHYLIB=3Dy=0ACONFIG_SWPHY=3Dy=0A# CONFIG_LED_TRIGGER_PHY is not s=
et=0ACONFIG_FIXED_PHY=3Dy=0A=0A#=0A# MII PHY device drivers=0A#=0A# CONFIG_=
AMD_PHY is not set=0A# CONFIG_ADIN_PHY is not set=0A# CONFIG_AQUANTIA_PHY i=
s not set=0ACONFIG_AX88796B_PHY=3Dy=0A# CONFIG_BROADCOM_PHY is not set=0A# =
CONFIG_BCM54140_PHY is not set=0A# CONFIG_BCM7XXX_PHY is not set=0A# CONFIG=
_BCM84881_PHY is not set=0A# CONFIG_BCM87XX_PHY is not set=0A# CONFIG_CICAD=
A_PHY is not set=0A# CONFIG_CORTINA_PHY is not set=0A# CONFIG_DAVICOM_PHY i=
s not set=0A# CONFIG_ICPLUS_PHY is not set=0A# CONFIG_LXT_PHY is not set=0A=
# CONFIG_INTEL_XWAY_PHY is not set=0A# CONFIG_LSI_ET1011C_PHY is not set=0A=
# CONFIG_MARVELL_PHY is not set=0A# CONFIG_MARVELL_10G_PHY is not set=0A# C=
ONFIG_MARVELL_88X2222_PHY is not set=0A# CONFIG_MAXLINEAR_GPHY is not set=
=0A# CONFIG_MEDIATEK_GE_PHY is not set=0A# CONFIG_MICREL_PHY is not set=0A#=
 CONFIG_MICROCHIP_PHY is not set=0A# CONFIG_MICROCHIP_T1_PHY is not set=0A#=
 CONFIG_MICROSEMI_PHY is not set=0A# CONFIG_MOTORCOMM_PHY is not set=0A# CO=
NFIG_NATIONAL_PHY is not set=0A# CONFIG_NXP_C45_TJA11XX_PHY is not set=0A# =
CONFIG_NXP_TJA11XX_PHY is not set=0A# CONFIG_QSEMI_PHY is not set=0ACONFIG_=
REALTEK_PHY=3Dy=0A# CONFIG_RENESAS_PHY is not set=0A# CONFIG_ROCKCHIP_PHY i=
s not set=0A# CONFIG_SMSC_PHY is not set=0A# CONFIG_STE10XP is not set=0A# =
CONFIG_TERANETICS_PHY is not set=0A# CONFIG_DP83822_PHY is not set=0A# CONF=
IG_DP83TC811_PHY is not set=0A# CONFIG_DP83848_PHY is not set=0A# CONFIG_DP=
83867_PHY is not set=0A# CONFIG_DP83869_PHY is not set=0A# CONFIG_VITESSE_P=
HY is not set=0A# CONFIG_XILINX_GMII2RGMII is not set=0A# CONFIG_MICREL_KS8=
995MA is not set=0ACONFIG_MDIO_DEVICE=3Dy=0ACONFIG_MDIO_BUS=3Dy=0ACONFIG_FW=
NODE_MDIO=3Dy=0ACONFIG_ACPI_MDIO=3Dy=0ACONFIG_MDIO_DEVRES=3Dy=0A# CONFIG_MD=
IO_BITBANG is not set=0A# CONFIG_MDIO_BCM_UNIMAC is not set=0A# CONFIG_MDIO=
_MVUSB is not set=0A# CONFIG_MDIO_MSCC_MIIM is not set=0A# CONFIG_MDIO_THUN=
DER is not set=0A=0A#=0A# MDIO Multiplexers=0A#=0A=0A#=0A# PCS device drive=
rs=0A#=0A# CONFIG_PCS_XPCS is not set=0A# end of PCS device drivers=0A=0A# =
CONFIG_PLIP is not set=0A# CONFIG_PPP is not set=0A# CONFIG_SLIP is not set=
=0ACONFIG_USB_NET_DRIVERS=3Dy=0A# CONFIG_USB_CATC is not set=0A# CONFIG_USB=
_KAWETH is not set=0A# CONFIG_USB_PEGASUS is not set=0A# CONFIG_USB_RTL8150=
 is not set=0ACONFIG_USB_RTL8152=3Dy=0A# CONFIG_USB_LAN78XX is not set=0ACO=
NFIG_USB_USBNET=3Dy=0ACONFIG_USB_NET_AX8817X=3Dy=0ACONFIG_USB_NET_AX88179_1=
78A=3Dy=0A# CONFIG_USB_NET_CDCETHER is not set=0A# CONFIG_USB_NET_CDC_EEM i=
s not set=0A# CONFIG_USB_NET_CDC_NCM is not set=0A# CONFIG_USB_NET_HUAWEI_C=
DC_NCM is not set=0A# CONFIG_USB_NET_CDC_MBIM is not set=0A# CONFIG_USB_NET=
_DM9601 is not set=0A# CONFIG_USB_NET_SR9700 is not set=0A# CONFIG_USB_NET_=
SR9800 is not set=0A# CONFIG_USB_NET_SMSC75XX is not set=0A# CONFIG_USB_NET=
_SMSC95XX is not set=0A# CONFIG_USB_NET_GL620A is not set=0A# CONFIG_USB_NE=
T_NET1080 is not set=0A# CONFIG_USB_NET_PLUSB is not set=0A# CONFIG_USB_NET=
_MCS7830 is not set=0A# CONFIG_USB_NET_RNDIS_HOST is not set=0A# CONFIG_USB=
_NET_CDC_SUBSET is not set=0A# CONFIG_USB_NET_ZAURUS is not set=0A# CONFIG_=
USB_NET_CX82310_ETH is not set=0A# CONFIG_USB_NET_KALMIA is not set=0A# CON=
FIG_USB_NET_QMI_WWAN is not set=0A# CONFIG_USB_HSO is not set=0A# CONFIG_US=
B_NET_INT51X1 is not set=0A# CONFIG_USB_IPHETH is not set=0A# CONFIG_USB_SI=
ERRA_NET is not set=0A# CONFIG_USB_NET_CH9200 is not set=0A# CONFIG_USB_NET=
_AQC111 is not set=0ACONFIG_WLAN=3Dy=0ACONFIG_WLAN_VENDOR_ADMTEK=3Dy=0A# CO=
NFIG_ADM8211 is not set=0ACONFIG_WLAN_VENDOR_ATH=3Dy=0A# CONFIG_ATH_DEBUG i=
s not set=0A# CONFIG_ATH5K is not set=0A# CONFIG_ATH5K_PCI is not set=0A# C=
ONFIG_ATH9K is not set=0A# CONFIG_ATH9K_HTC is not set=0A# CONFIG_CARL9170 =
is not set=0A# CONFIG_ATH6KL is not set=0A# CONFIG_AR5523 is not set=0A# CO=
NFIG_WIL6210 is not set=0A# CONFIG_ATH10K is not set=0A# CONFIG_WCN36XX is =
not set=0A# CONFIG_ATH11K is not set=0ACONFIG_WLAN_VENDOR_ATMEL=3Dy=0A# CON=
FIG_ATMEL is not set=0A# CONFIG_AT76C50X_USB is not set=0ACONFIG_WLAN_VENDO=
R_BROADCOM=3Dy=0A# CONFIG_B43 is not set=0A# CONFIG_B43LEGACY is not set=0A=
# CONFIG_BRCMSMAC is not set=0A# CONFIG_BRCMFMAC is not set=0ACONFIG_WLAN_V=
ENDOR_CISCO=3Dy=0A# CONFIG_AIRO is not set=0ACONFIG_WLAN_VENDOR_INTEL=3Dy=
=0A# CONFIG_IPW2100 is not set=0A# CONFIG_IPW2200 is not set=0A# CONFIG_IWL=
4965 is not set=0A# CONFIG_IWL3945 is not set=0A# CONFIG_IWLWIFI is not set=
=0ACONFIG_WLAN_VENDOR_INTERSIL=3Dy=0A# CONFIG_HOSTAP is not set=0A# CONFIG_=
HERMES is not set=0A# CONFIG_P54_COMMON is not set=0ACONFIG_WLAN_VENDOR_MAR=
VELL=3Dy=0A# CONFIG_LIBERTAS is not set=0A# CONFIG_LIBERTAS_THINFIRM is not=
 set=0A# CONFIG_MWIFIEX is not set=0A# CONFIG_MWL8K is not set=0A# CONFIG_W=
LAN_VENDOR_MEDIATEK is not set=0ACONFIG_WLAN_VENDOR_MICROCHIP=3Dy=0A# CONFI=
G_WILC1000_SDIO is not set=0A# CONFIG_WILC1000_SPI is not set=0ACONFIG_WLAN=
_VENDOR_RALINK=3Dy=0A# CONFIG_RT2X00 is not set=0ACONFIG_WLAN_VENDOR_REALTE=
K=3Dy=0A# CONFIG_RTL8180 is not set=0A# CONFIG_RTL8187 is not set=0ACONFIG_=
RTL_CARDS=3Dm=0A# CONFIG_RTL8192CE is not set=0A# CONFIG_RTL8192SE is not s=
et=0A# CONFIG_RTL8192DE is not set=0A# CONFIG_RTL8723AE is not set=0A# CONF=
IG_RTL8723BE is not set=0A# CONFIG_RTL8188EE is not set=0A# CONFIG_RTL8192E=
E is not set=0A# CONFIG_RTL8821AE is not set=0A# CONFIG_RTL8192CU is not se=
t=0A# CONFIG_RTL8XXXU is not set=0A# CONFIG_RTW88 is not set=0ACONFIG_WLAN_=
VENDOR_RSI=3Dy=0A# CONFIG_RSI_91X is not set=0ACONFIG_WLAN_VENDOR_ST=3Dy=0A=
# CONFIG_CW1200 is not set=0ACONFIG_WLAN_VENDOR_TI=3Dy=0A# CONFIG_WL1251 is=
 not set=0A# CONFIG_WL12XX is not set=0A# CONFIG_WL18XX is not set=0A# CONF=
IG_WLCORE is not set=0ACONFIG_WLAN_VENDOR_ZYDAS=3Dy=0A# CONFIG_USB_ZD1201 i=
s not set=0A# CONFIG_ZD1211RW is not set=0ACONFIG_WLAN_VENDOR_QUANTENNA=3Dy=
=0A# CONFIG_QTNFMAC_PCIE is not set=0ACONFIG_MAC80211_HWSIM=3Dm=0A# CONFIG_=
USB_NET_RNDIS_WLAN is not set=0A# CONFIG_VIRT_WIFI is not set=0A# CONFIG_WA=
N is not set=0ACONFIG_IEEE802154_DRIVERS=3Dm=0A# CONFIG_IEEE802154_FAKELB i=
s not set=0A# CONFIG_IEEE802154_AT86RF230 is not set=0A# CONFIG_IEEE802154_=
MRF24J40 is not set=0A# CONFIG_IEEE802154_CC2520 is not set=0A# CONFIG_IEEE=
802154_ATUSB is not set=0A# CONFIG_IEEE802154_ADF7242 is not set=0A# CONFIG=
_IEEE802154_CA8210 is not set=0A# CONFIG_IEEE802154_MCR20A is not set=0A# C=
ONFIG_IEEE802154_HWSIM is not set=0A=0A#=0A# Wireless WAN=0A#=0A# CONFIG_WW=
AN is not set=0A# end of Wireless WAN=0A=0A# CONFIG_VMXNET3 is not set=0A# =
CONFIG_FUJITSU_ES is not set=0A# CONFIG_HYPERV_NET is not set=0A# CONFIG_NE=
TDEVSIM is not set=0ACONFIG_NET_FAILOVER=3Dm=0A# CONFIG_ISDN is not set=0A=
=0A#=0A# Input device support=0A#=0ACONFIG_INPUT=3Dy=0ACONFIG_INPUT_LEDS=3D=
y=0ACONFIG_INPUT_FF_MEMLESS=3Dm=0ACONFIG_INPUT_SPARSEKMAP=3Dm=0A# CONFIG_IN=
PUT_MATRIXKMAP is not set=0A=0A#=0A# Userland interfaces=0A#=0ACONFIG_INPUT=
_MOUSEDEV=3Dy=0A# CONFIG_INPUT_MOUSEDEV_PSAUX is not set=0ACONFIG_INPUT_MOU=
SEDEV_SCREEN_X=3D1024=0ACONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0ACONFIG_INPUT=
_JOYDEV=3Dm=0ACONFIG_INPUT_EVDEV=3Dy=0A# CONFIG_INPUT_EVBUG is not set=0A=
=0A#=0A# Input Device Drivers=0A#=0ACONFIG_INPUT_KEYBOARD=3Dy=0A# CONFIG_KE=
YBOARD_ADP5588 is not set=0A# CONFIG_KEYBOARD_ADP5589 is not set=0A# CONFIG=
_KEYBOARD_APPLESPI is not set=0ACONFIG_KEYBOARD_ATKBD=3Dy=0A# CONFIG_KEYBOA=
RD_QT1050 is not set=0A# CONFIG_KEYBOARD_QT1070 is not set=0A# CONFIG_KEYBO=
ARD_QT2160 is not set=0A# CONFIG_KEYBOARD_DLINK_DIR685 is not set=0A# CONFI=
G_KEYBOARD_LKKBD is not set=0A# CONFIG_KEYBOARD_GPIO is not set=0A# CONFIG_=
KEYBOARD_GPIO_POLLED is not set=0A# CONFIG_KEYBOARD_TCA6416 is not set=0A# =
CONFIG_KEYBOARD_TCA8418 is not set=0A# CONFIG_KEYBOARD_MATRIX is not set=0A=
# CONFIG_KEYBOARD_LM8323 is not set=0A# CONFIG_KEYBOARD_LM8333 is not set=
=0A# CONFIG_KEYBOARD_MAX7359 is not set=0A# CONFIG_KEYBOARD_MCS is not set=
=0A# CONFIG_KEYBOARD_MPR121 is not set=0A# CONFIG_KEYBOARD_NEWTON is not se=
t=0A# CONFIG_KEYBOARD_OPENCORES is not set=0A# CONFIG_KEYBOARD_SAMSUNG is n=
ot set=0A# CONFIG_KEYBOARD_STOWAWAY is not set=0A# CONFIG_KEYBOARD_SUNKBD i=
s not set=0A# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set=0A# CONFIG_KEYBOARD_X=
TKBD is not set=0ACONFIG_INPUT_MOUSE=3Dy=0ACONFIG_MOUSE_PS2=3Dy=0ACONFIG_MO=
USE_PS2_ALPS=3Dy=0ACONFIG_MOUSE_PS2_BYD=3Dy=0ACONFIG_MOUSE_PS2_LOGIPS2PP=3D=
y=0ACONFIG_MOUSE_PS2_SYNAPTICS=3Dy=0ACONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy=
=0ACONFIG_MOUSE_PS2_CYPRESS=3Dy=0ACONFIG_MOUSE_PS2_LIFEBOOK=3Dy=0ACONFIG_MO=
USE_PS2_TRACKPOINT=3Dy=0ACONFIG_MOUSE_PS2_ELANTECH=3Dy=0ACONFIG_MOUSE_PS2_E=
LANTECH_SMBUS=3Dy=0ACONFIG_MOUSE_PS2_SENTELIC=3Dy=0A# CONFIG_MOUSE_PS2_TOUC=
HKIT is not set=0ACONFIG_MOUSE_PS2_FOCALTECH=3Dy=0ACONFIG_MOUSE_PS2_VMMOUSE=
=3Dy=0ACONFIG_MOUSE_PS2_SMBUS=3Dy=0ACONFIG_MOUSE_SERIAL=3Dm=0A# CONFIG_MOUS=
E_APPLETOUCH is not set=0A# CONFIG_MOUSE_BCM5974 is not set=0ACONFIG_MOUSE_=
CYAPA=3Dm=0ACONFIG_MOUSE_ELAN_I2C=3Dm=0ACONFIG_MOUSE_ELAN_I2C_I2C=3Dy=0ACON=
FIG_MOUSE_ELAN_I2C_SMBUS=3Dy=0ACONFIG_MOUSE_VSXXXAA=3Dm=0A# CONFIG_MOUSE_GP=
IO is not set=0ACONFIG_MOUSE_SYNAPTICS_I2C=3Dm=0A# CONFIG_MOUSE_SYNAPTICS_U=
SB is not set=0A# CONFIG_INPUT_JOYSTICK is not set=0A# CONFIG_INPUT_TABLET =
is not set=0A# CONFIG_INPUT_TOUCHSCREEN is not set=0ACONFIG_INPUT_MISC=3Dy=
=0A# CONFIG_INPUT_AD714X is not set=0A# CONFIG_INPUT_BMA150 is not set=0A# =
CONFIG_INPUT_E3X0_BUTTON is not set=0A# CONFIG_INPUT_PCSPKR is not set=0A# =
CONFIG_INPUT_MMA8450 is not set=0A# CONFIG_INPUT_APANEL is not set=0A# CONF=
IG_INPUT_GPIO_BEEPER is not set=0A# CONFIG_INPUT_GPIO_DECODER is not set=0A=
# CONFIG_INPUT_GPIO_VIBRA is not set=0A# CONFIG_INPUT_ATLAS_BTNS is not set=
=0A# CONFIG_INPUT_ATI_REMOTE2 is not set=0A# CONFIG_INPUT_KEYSPAN_REMOTE is=
 not set=0A# CONFIG_INPUT_KXTJ9 is not set=0A# CONFIG_INPUT_POWERMATE is no=
t set=0A# CONFIG_INPUT_YEALINK is not set=0A# CONFIG_INPUT_CM109 is not set=
=0ACONFIG_INPUT_UINPUT=3Dy=0A# CONFIG_INPUT_PCF8574 is not set=0A# CONFIG_I=
NPUT_PWM_BEEPER is not set=0A# CONFIG_INPUT_PWM_VIBRA is not set=0A# CONFIG=
_INPUT_GPIO_ROTARY_ENCODER is not set=0A# CONFIG_INPUT_DA7280_HAPTICS is no=
t set=0A# CONFIG_INPUT_ADXL34X is not set=0A# CONFIG_INPUT_IMS_PCU is not s=
et=0A# CONFIG_INPUT_IQS269A is not set=0A# CONFIG_INPUT_IQS626A is not set=
=0A# CONFIG_INPUT_CMA3000 is not set=0A# CONFIG_INPUT_IDEAPAD_SLIDEBAR is n=
ot set=0A# CONFIG_INPUT_DRV260X_HAPTICS is not set=0A# CONFIG_INPUT_DRV2665=
_HAPTICS is not set=0A# CONFIG_INPUT_DRV2667_HAPTICS is not set=0ACONFIG_RM=
I4_CORE=3Dm=0ACONFIG_RMI4_I2C=3Dm=0ACONFIG_RMI4_SPI=3Dm=0ACONFIG_RMI4_SMB=
=3Dm=0ACONFIG_RMI4_F03=3Dy=0ACONFIG_RMI4_F03_SERIO=3Dm=0ACONFIG_RMI4_2D_SEN=
SOR=3Dy=0ACONFIG_RMI4_F11=3Dy=0ACONFIG_RMI4_F12=3Dy=0ACONFIG_RMI4_F30=3Dy=
=0ACONFIG_RMI4_F34=3Dy=0A# CONFIG_RMI4_F3A is not set=0A# CONFIG_RMI4_F54 i=
s not set=0ACONFIG_RMI4_F55=3Dy=0A=0A#=0A# Hardware I/O ports=0A#=0ACONFIG_=
SERIO=3Dy=0ACONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy=0ACONFIG_SERIO_I8042=3Dy=0A=
CONFIG_SERIO_SERPORT=3Dy=0A# CONFIG_SERIO_CT82C710 is not set=0A# CONFIG_SE=
RIO_PARKBD is not set=0A# CONFIG_SERIO_PCIPS2 is not set=0ACONFIG_SERIO_LIB=
PS2=3Dy=0ACONFIG_SERIO_RAW=3Dm=0ACONFIG_SERIO_ALTERA_PS2=3Dm=0A# CONFIG_SER=
IO_PS2MULT is not set=0ACONFIG_SERIO_ARC_PS2=3Dm=0ACONFIG_HYPERV_KEYBOARD=
=3Dm=0A# CONFIG_SERIO_GPIO_PS2 is not set=0A# CONFIG_USERIO is not set=0A# =
CONFIG_GAMEPORT is not set=0A# end of Hardware I/O ports=0A# end of Input d=
evice support=0A=0A#=0A# Character devices=0A#=0ACONFIG_TTY=3Dy=0ACONFIG_VT=
=3Dy=0ACONFIG_CONSOLE_TRANSLATIONS=3Dy=0ACONFIG_VT_CONSOLE=3Dy=0ACONFIG_VT_=
CONSOLE_SLEEP=3Dy=0ACONFIG_HW_CONSOLE=3Dy=0ACONFIG_VT_HW_CONSOLE_BINDING=3D=
y=0ACONFIG_UNIX98_PTYS=3Dy=0A# CONFIG_LEGACY_PTYS is not set=0ACONFIG_LDISC=
_AUTOLOAD=3Dy=0A=0A#=0A# Serial drivers=0A#=0ACONFIG_SERIAL_EARLYCON=3Dy=0A=
CONFIG_SERIAL_8250=3Dy=0A# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set=
=0ACONFIG_SERIAL_8250_PNP=3Dy=0A# CONFIG_SERIAL_8250_16550A_VARIANTS is not=
 set=0A# CONFIG_SERIAL_8250_FINTEK is not set=0ACONFIG_SERIAL_8250_CONSOLE=
=3Dy=0ACONFIG_SERIAL_8250_DMA=3Dy=0ACONFIG_SERIAL_8250_PCI=3Dy=0ACONFIG_SER=
IAL_8250_EXAR=3Dy=0ACONFIG_SERIAL_8250_NR_UARTS=3D64=0ACONFIG_SERIAL_8250_R=
UNTIME_UARTS=3D4=0ACONFIG_SERIAL_8250_EXTENDED=3Dy=0ACONFIG_SERIAL_8250_MAN=
Y_PORTS=3Dy=0ACONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0A# CONFIG_SERIAL_8250_DETEC=
T_IRQ is not set=0ACONFIG_SERIAL_8250_RSA=3Dy=0ACONFIG_SERIAL_8250_DWLIB=3D=
y=0ACONFIG_SERIAL_8250_DW=3Dy=0A# CONFIG_SERIAL_8250_RT288X is not set=0ACO=
NFIG_SERIAL_8250_LPSS=3Dy=0ACONFIG_SERIAL_8250_MID=3Dy=0A=0A#=0A# Non-8250 =
serial port support=0A#=0A# CONFIG_SERIAL_MAX3100 is not set=0A# CONFIG_SER=
IAL_MAX310X is not set=0A# CONFIG_SERIAL_UARTLITE is not set=0ACONFIG_SERIA=
L_CORE=3Dy=0ACONFIG_SERIAL_CORE_CONSOLE=3Dy=0ACONFIG_SERIAL_JSM=3Dm=0A# CON=
FIG_SERIAL_LANTIQ is not set=0A# CONFIG_SERIAL_SCCNXP is not set=0A# CONFIG=
_SERIAL_SC16IS7XX is not set=0A# CONFIG_SERIAL_BCM63XX is not set=0A# CONFI=
G_SERIAL_ALTERA_JTAGUART is not set=0A# CONFIG_SERIAL_ALTERA_UART is not se=
t=0ACONFIG_SERIAL_ARC=3Dm=0ACONFIG_SERIAL_ARC_NR_PORTS=3D1=0A# CONFIG_SERIA=
L_RP2 is not set=0A# CONFIG_SERIAL_FSL_LPUART is not set=0A# CONFIG_SERIAL_=
FSL_LINFLEXUART is not set=0A# CONFIG_SERIAL_SPRD is not set=0A# end of Ser=
ial drivers=0A=0ACONFIG_SERIAL_MCTRL_GPIO=3Dy=0ACONFIG_SERIAL_NONSTANDARD=
=3Dy=0A# CONFIG_MOXA_INTELLIO is not set=0A# CONFIG_MOXA_SMARTIO is not set=
=0ACONFIG_SYNCLINK_GT=3Dm=0ACONFIG_N_HDLC=3Dm=0ACONFIG_N_GSM=3Dm=0ACONFIG_N=
OZOMI=3Dm=0A# CONFIG_NULL_TTY is not set=0ACONFIG_HVC_DRIVER=3Dy=0A# CONFIG=
_SERIAL_DEV_BUS is not set=0ACONFIG_PRINTER=3Dm=0A# CONFIG_LP_CONSOLE is no=
t set=0ACONFIG_PPDEV=3Dm=0ACONFIG_VIRTIO_CONSOLE=3Dm=0ACONFIG_IPMI_HANDLER=
=3Dm=0ACONFIG_IPMI_DMI_DECODE=3Dy=0ACONFIG_IPMI_PLAT_DATA=3Dy=0ACONFIG_IPMI=
_PANIC_EVENT=3Dy=0ACONFIG_IPMI_PANIC_STRING=3Dy=0ACONFIG_IPMI_DEVICE_INTERF=
ACE=3Dm=0ACONFIG_IPMI_SI=3Dm=0ACONFIG_IPMI_SSIF=3Dm=0ACONFIG_IPMI_WATCHDOG=
=3Dm=0ACONFIG_IPMI_POWEROFF=3Dm=0ACONFIG_HW_RANDOM=3Dy=0ACONFIG_HW_RANDOM_T=
IMERIOMEM=3Dm=0ACONFIG_HW_RANDOM_INTEL=3Dm=0ACONFIG_HW_RANDOM_AMD=3Dm=0A# C=
ONFIG_HW_RANDOM_BA431 is not set=0ACONFIG_HW_RANDOM_VIA=3Dm=0ACONFIG_HW_RAN=
DOM_VIRTIO=3Dy=0A# CONFIG_HW_RANDOM_XIPHERA is not set=0A# CONFIG_APPLICOM =
is not set=0A# CONFIG_MWAVE is not set=0ACONFIG_DEVMEM=3Dy=0ACONFIG_NVRAM=
=3Dy=0ACONFIG_DEVPORT=3Dy=0ACONFIG_HPET=3Dy=0ACONFIG_HPET_MMAP=3Dy=0A# CONF=
IG_HPET_MMAP_DEFAULT is not set=0ACONFIG_HANGCHECK_TIMER=3Dm=0ACONFIG_UV_MM=
TIMER=3Dm=0ACONFIG_TCG_TPM=3Dy=0ACONFIG_HW_RANDOM_TPM=3Dy=0ACONFIG_TCG_TIS_=
CORE=3Dy=0ACONFIG_TCG_TIS=3Dy=0A# CONFIG_TCG_TIS_SPI is not set=0A# CONFIG_=
TCG_TIS_I2C_CR50 is not set=0ACONFIG_TCG_TIS_I2C_ATMEL=3Dm=0ACONFIG_TCG_TIS=
_I2C_INFINEON=3Dm=0ACONFIG_TCG_TIS_I2C_NUVOTON=3Dm=0ACONFIG_TCG_NSC=3Dm=0AC=
ONFIG_TCG_ATMEL=3Dm=0ACONFIG_TCG_INFINEON=3Dm=0ACONFIG_TCG_CRB=3Dy=0A# CONF=
IG_TCG_VTPM_PROXY is not set=0ACONFIG_TCG_TIS_ST33ZP24=3Dm=0ACONFIG_TCG_TIS=
_ST33ZP24_I2C=3Dm=0A# CONFIG_TCG_TIS_ST33ZP24_SPI is not set=0ACONFIG_TELCL=
OCK=3Dm=0A# CONFIG_XILLYBUS is not set=0A# CONFIG_XILLYUSB is not set=0A# C=
ONFIG_RANDOM_TRUST_CPU is not set=0A# CONFIG_RANDOM_TRUST_BOOTLOADER is not=
 set=0A# end of Character devices=0A=0A#=0A# I2C support=0A#=0ACONFIG_I2C=
=3Dy=0ACONFIG_ACPI_I2C_OPREGION=3Dy=0ACONFIG_I2C_BOARDINFO=3Dy=0ACONFIG_I2C=
_COMPAT=3Dy=0ACONFIG_I2C_CHARDEV=3Dm=0ACONFIG_I2C_MUX=3Dm=0A=0A#=0A# Multip=
lexer I2C Chip support=0A#=0A# CONFIG_I2C_MUX_GPIO is not set=0A# CONFIG_I2=
C_MUX_LTC4306 is not set=0A# CONFIG_I2C_MUX_PCA9541 is not set=0A# CONFIG_I=
2C_MUX_PCA954x is not set=0A# CONFIG_I2C_MUX_REG is not set=0ACONFIG_I2C_MU=
X_MLXCPLD=3Dm=0A# end of Multiplexer I2C Chip support=0A=0ACONFIG_I2C_HELPE=
R_AUTO=3Dy=0ACONFIG_I2C_SMBUS=3Dy=0ACONFIG_I2C_ALGOBIT=3Dy=0ACONFIG_I2C_ALG=
OPCA=3Dm=0A=0A#=0A# I2C Hardware Bus support=0A#=0A=0A#=0A# PC SMBus host c=
ontroller drivers=0A#=0A# CONFIG_I2C_ALI1535 is not set=0A# CONFIG_I2C_ALI1=
563 is not set=0A# CONFIG_I2C_ALI15X3 is not set=0ACONFIG_I2C_AMD756=3Dm=0A=
CONFIG_I2C_AMD756_S4882=3Dm=0ACONFIG_I2C_AMD8111=3Dm=0A# CONFIG_I2C_AMD_MP2=
 is not set=0ACONFIG_I2C_I801=3Dy=0ACONFIG_I2C_ISCH=3Dm=0ACONFIG_I2C_ISMT=
=3Dm=0ACONFIG_I2C_PIIX4=3Dm=0ACONFIG_I2C_NFORCE2=3Dm=0ACONFIG_I2C_NFORCE2_S=
4985=3Dm=0A# CONFIG_I2C_NVIDIA_GPU is not set=0A# CONFIG_I2C_SIS5595 is not=
 set=0A# CONFIG_I2C_SIS630 is not set=0ACONFIG_I2C_SIS96X=3Dm=0ACONFIG_I2C_=
VIA=3Dm=0ACONFIG_I2C_VIAPRO=3Dm=0A=0A#=0A# ACPI drivers=0A#=0ACONFIG_I2C_SC=
MI=3Dm=0A=0A#=0A# I2C system bus drivers (mostly embedded / system-on-chip)=
=0A#=0A# CONFIG_I2C_CBUS_GPIO is not set=0ACONFIG_I2C_DESIGNWARE_CORE=3Dm=
=0A# CONFIG_I2C_DESIGNWARE_SLAVE is not set=0ACONFIG_I2C_DESIGNWARE_PLATFOR=
M=3Dm=0ACONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy=0A# CONFIG_I2C_DESIGNWARE_PCI is=
 not set=0A# CONFIG_I2C_EMEV2 is not set=0A# CONFIG_I2C_GPIO is not set=0A#=
 CONFIG_I2C_OCORES is not set=0ACONFIG_I2C_PCA_PLATFORM=3Dm=0ACONFIG_I2C_SI=
MTEC=3Dm=0A# CONFIG_I2C_XILINX is not set=0A=0A#=0A# External I2C/SMBus ada=
pter drivers=0A#=0A# CONFIG_I2C_DIOLAN_U2C is not set=0A# CONFIG_I2C_CP2615=
 is not set=0ACONFIG_I2C_PARPORT=3Dm=0A# CONFIG_I2C_ROBOTFUZZ_OSIF is not s=
et=0A# CONFIG_I2C_TAOS_EVM is not set=0A# CONFIG_I2C_TINY_USB is not set=0A=
=0A#=0A# Other I2C/SMBus bus drivers=0A#=0ACONFIG_I2C_MLXCPLD=3Dm=0A# CONFI=
G_I2C_VIRTIO is not set=0A# end of I2C Hardware Bus support=0A=0ACONFIG_I2C=
_STUB=3Dm=0A# CONFIG_I2C_SLAVE is not set=0A# CONFIG_I2C_DEBUG_CORE is not =
set=0A# CONFIG_I2C_DEBUG_ALGO is not set=0A# CONFIG_I2C_DEBUG_BUS is not se=
t=0A# end of I2C support=0A=0A# CONFIG_I3C is not set=0ACONFIG_SPI=3Dy=0A# =
CONFIG_SPI_DEBUG is not set=0ACONFIG_SPI_MASTER=3Dy=0A# CONFIG_SPI_MEM is n=
ot set=0A=0A#=0A# SPI Master Controller Drivers=0A#=0A# CONFIG_SPI_ALTERA i=
s not set=0A# CONFIG_SPI_AXI_SPI_ENGINE is not set=0A# CONFIG_SPI_BITBANG i=
s not set=0A# CONFIG_SPI_BUTTERFLY is not set=0A# CONFIG_SPI_CADENCE is not=
 set=0A# CONFIG_SPI_DESIGNWARE is not set=0A# CONFIG_SPI_NXP_FLEXSPI is not=
 set=0A# CONFIG_SPI_GPIO is not set=0A# CONFIG_SPI_LM70_LLP is not set=0A# =
CONFIG_SPI_LANTIQ_SSC is not set=0A# CONFIG_SPI_OC_TINY is not set=0A# CONF=
IG_SPI_PXA2XX is not set=0A# CONFIG_SPI_ROCKCHIP is not set=0A# CONFIG_SPI_=
SC18IS602 is not set=0A# CONFIG_SPI_SIFIVE is not set=0A# CONFIG_SPI_MXIC i=
s not set=0A# CONFIG_SPI_XCOMM is not set=0A# CONFIG_SPI_XILINX is not set=
=0A# CONFIG_SPI_ZYNQMP_GQSPI is not set=0A# CONFIG_SPI_AMD is not set=0A=0A=
#=0A# SPI Multiplexer support=0A#=0A# CONFIG_SPI_MUX is not set=0A=0A#=0A# =
SPI Protocol Masters=0A#=0A# CONFIG_SPI_SPIDEV is not set=0A# CONFIG_SPI_LO=
OPBACK_TEST is not set=0A# CONFIG_SPI_TLE62X0 is not set=0A# CONFIG_SPI_SLA=
VE is not set=0ACONFIG_SPI_DYNAMIC=3Dy=0A# CONFIG_SPMI is not set=0A# CONFI=
G_HSI is not set=0ACONFIG_PPS=3Dy=0A# CONFIG_PPS_DEBUG is not set=0A=0A#=0A=
# PPS clients support=0A#=0A# CONFIG_PPS_CLIENT_KTIMER is not set=0ACONFIG_=
PPS_CLIENT_LDISC=3Dm=0ACONFIG_PPS_CLIENT_PARPORT=3Dm=0ACONFIG_PPS_CLIENT_GP=
IO=3Dm=0A=0A#=0A# PPS generators support=0A#=0A=0A#=0A# PTP clock support=
=0A#=0ACONFIG_PTP_1588_CLOCK=3Dy=0ACONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy=0A# C=
ONFIG_DP83640_PHY is not set=0A# CONFIG_PTP_1588_CLOCK_INES is not set=0ACO=
NFIG_PTP_1588_CLOCK_KVM=3Dm=0A# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set=
=0A# CONFIG_PTP_1588_CLOCK_IDTCM is not set=0A# CONFIG_PTP_1588_CLOCK_VMW i=
s not set=0A# end of PTP clock support=0A=0ACONFIG_PINCTRL=3Dy=0ACONFIG_PIN=
MUX=3Dy=0ACONFIG_PINCONF=3Dy=0ACONFIG_GENERIC_PINCONF=3Dy=0A# CONFIG_DEBUG_=
PINCTRL is not set=0ACONFIG_PINCTRL_AMD=3Dm=0A# CONFIG_PINCTRL_MCP23S08 is =
not set=0A# CONFIG_PINCTRL_SX150X is not set=0ACONFIG_PINCTRL_BAYTRAIL=3Dy=
=0A# CONFIG_PINCTRL_CHERRYVIEW is not set=0A# CONFIG_PINCTRL_LYNXPOINT is n=
ot set=0ACONFIG_PINCTRL_INTEL=3Dy=0A# CONFIG_PINCTRL_ALDERLAKE is not set=
=0ACONFIG_PINCTRL_BROXTON=3Dm=0ACONFIG_PINCTRL_CANNONLAKE=3Dm=0ACONFIG_PINC=
TRL_CEDARFORK=3Dm=0ACONFIG_PINCTRL_DENVERTON=3Dm=0A# CONFIG_PINCTRL_ELKHART=
LAKE is not set=0A# CONFIG_PINCTRL_EMMITSBURG is not set=0ACONFIG_PINCTRL_G=
EMINILAKE=3Dm=0A# CONFIG_PINCTRL_ICELAKE is not set=0A# CONFIG_PINCTRL_JASP=
ERLAKE is not set=0A# CONFIG_PINCTRL_LAKEFIELD is not set=0ACONFIG_PINCTRL_=
LEWISBURG=3Dm=0ACONFIG_PINCTRL_SUNRISEPOINT=3Dm=0A# CONFIG_PINCTRL_TIGERLAK=
E is not set=0A=0A#=0A# Renesas pinctrl drivers=0A#=0A# end of Renesas pinc=
trl drivers=0A=0ACONFIG_GPIOLIB=3Dy=0ACONFIG_GPIOLIB_FASTPATH_LIMIT=3D512=
=0ACONFIG_GPIO_ACPI=3Dy=0ACONFIG_GPIOLIB_IRQCHIP=3Dy=0A# CONFIG_DEBUG_GPIO =
is not set=0ACONFIG_GPIO_CDEV=3Dy=0ACONFIG_GPIO_CDEV_V1=3Dy=0ACONFIG_GPIO_G=
ENERIC=3Dm=0A=0A#=0A# Memory mapped GPIO drivers=0A#=0ACONFIG_GPIO_AMDPT=3D=
m=0A# CONFIG_GPIO_DWAPB is not set=0A# CONFIG_GPIO_EXAR is not set=0A# CONF=
IG_GPIO_GENERIC_PLATFORM is not set=0ACONFIG_GPIO_ICH=3Dm=0A# CONFIG_GPIO_M=
B86S7X is not set=0A# CONFIG_GPIO_VX855 is not set=0A# CONFIG_GPIO_AMD_FCH =
is not set=0A# end of Memory mapped GPIO drivers=0A=0A#=0A# Port-mapped I/O=
 GPIO drivers=0A#=0A# CONFIG_GPIO_F7188X is not set=0A# CONFIG_GPIO_IT87 is=
 not set=0A# CONFIG_GPIO_SCH is not set=0A# CONFIG_GPIO_SCH311X is not set=
=0A# CONFIG_GPIO_WINBOND is not set=0A# CONFIG_GPIO_WS16C48 is not set=0A# =
end of Port-mapped I/O GPIO drivers=0A=0A#=0A# I2C GPIO expanders=0A#=0A# C=
ONFIG_GPIO_ADP5588 is not set=0A# CONFIG_GPIO_MAX7300 is not set=0A# CONFIG=
_GPIO_MAX732X is not set=0A# CONFIG_GPIO_PCA953X is not set=0A# CONFIG_GPIO=
_PCA9570 is not set=0A# CONFIG_GPIO_PCF857X is not set=0A# CONFIG_GPIO_TPIC=
2810 is not set=0A# end of I2C GPIO expanders=0A=0A#=0A# MFD GPIO expanders=
=0A#=0A# end of MFD GPIO expanders=0A=0A#=0A# PCI GPIO expanders=0A#=0A# CO=
NFIG_GPIO_AMD8111 is not set=0A# CONFIG_GPIO_BT8XX is not set=0A# CONFIG_GP=
IO_ML_IOH is not set=0A# CONFIG_GPIO_PCI_IDIO_16 is not set=0A# CONFIG_GPIO=
_PCIE_IDIO_24 is not set=0A# CONFIG_GPIO_RDC321X is not set=0A# end of PCI =
GPIO expanders=0A=0A#=0A# SPI GPIO expanders=0A#=0A# CONFIG_GPIO_MAX3191X i=
s not set=0A# CONFIG_GPIO_MAX7301 is not set=0A# CONFIG_GPIO_MC33880 is not=
 set=0A# CONFIG_GPIO_PISOSR is not set=0A# CONFIG_GPIO_XRA1403 is not set=
=0A# end of SPI GPIO expanders=0A=0A#=0A# USB GPIO expanders=0A#=0A# end of=
 USB GPIO expanders=0A=0A#=0A# Virtual GPIO drivers=0A#=0A# CONFIG_GPIO_AGG=
REGATOR is not set=0A# CONFIG_GPIO_MOCKUP is not set=0A# CONFIG_GPIO_VIRTIO=
 is not set=0A# end of Virtual GPIO drivers=0A=0A# CONFIG_W1 is not set=0AC=
ONFIG_POWER_RESET=3Dy=0A# CONFIG_POWER_RESET_RESTART is not set=0ACONFIG_PO=
WER_SUPPLY=3Dy=0A# CONFIG_POWER_SUPPLY_DEBUG is not set=0ACONFIG_POWER_SUPP=
LY_HWMON=3Dy=0A# CONFIG_PDA_POWER is not set=0A# CONFIG_TEST_POWER is not s=
et=0A# CONFIG_CHARGER_ADP5061 is not set=0A# CONFIG_BATTERY_CW2015 is not s=
et=0A# CONFIG_BATTERY_DS2780 is not set=0A# CONFIG_BATTERY_DS2781 is not se=
t=0A# CONFIG_BATTERY_DS2782 is not set=0A# CONFIG_BATTERY_SBS is not set=0A=
# CONFIG_CHARGER_SBS is not set=0A# CONFIG_MANAGER_SBS is not set=0A# CONFI=
G_BATTERY_BQ27XXX is not set=0A# CONFIG_BATTERY_MAX17040 is not set=0A# CON=
FIG_BATTERY_MAX17042 is not set=0A# CONFIG_CHARGER_MAX8903 is not set=0A# C=
ONFIG_CHARGER_LP8727 is not set=0A# CONFIG_CHARGER_GPIO is not set=0A# CONF=
IG_CHARGER_LT3651 is not set=0A# CONFIG_CHARGER_LTC4162L is not set=0A# CON=
FIG_CHARGER_BQ2415X is not set=0A# CONFIG_CHARGER_BQ24257 is not set=0A# CO=
NFIG_CHARGER_BQ24735 is not set=0A# CONFIG_CHARGER_BQ2515X is not set=0A# C=
ONFIG_CHARGER_BQ25890 is not set=0A# CONFIG_CHARGER_BQ25980 is not set=0A# =
CONFIG_CHARGER_BQ256XX is not set=0A# CONFIG_BATTERY_GAUGE_LTC2941 is not s=
et=0A# CONFIG_BATTERY_GOLDFISH is not set=0A# CONFIG_BATTERY_RT5033 is not =
set=0A# CONFIG_CHARGER_RT9455 is not set=0A# CONFIG_CHARGER_BD99954 is not =
set=0ACONFIG_HWMON=3Dy=0ACONFIG_HWMON_VID=3Dm=0A# CONFIG_HWMON_DEBUG_CHIP i=
s not set=0A=0A#=0A# Native drivers=0A#=0ACONFIG_SENSORS_ABITUGURU=3Dm=0ACO=
NFIG_SENSORS_ABITUGURU3=3Dm=0A# CONFIG_SENSORS_AD7314 is not set=0ACONFIG_S=
ENSORS_AD7414=3Dm=0ACONFIG_SENSORS_AD7418=3Dm=0ACONFIG_SENSORS_ADM1021=3Dm=
=0ACONFIG_SENSORS_ADM1025=3Dm=0ACONFIG_SENSORS_ADM1026=3Dm=0ACONFIG_SENSORS=
_ADM1029=3Dm=0ACONFIG_SENSORS_ADM1031=3Dm=0A# CONFIG_SENSORS_ADM1177 is not=
 set=0ACONFIG_SENSORS_ADM9240=3Dm=0ACONFIG_SENSORS_ADT7X10=3Dm=0A# CONFIG_S=
ENSORS_ADT7310 is not set=0ACONFIG_SENSORS_ADT7410=3Dm=0ACONFIG_SENSORS_ADT=
7411=3Dm=0ACONFIG_SENSORS_ADT7462=3Dm=0ACONFIG_SENSORS_ADT7470=3Dm=0ACONFIG=
_SENSORS_ADT7475=3Dm=0A# CONFIG_SENSORS_AHT10 is not set=0A# CONFIG_SENSORS=
_AQUACOMPUTER_D5NEXT is not set=0A# CONFIG_SENSORS_AS370 is not set=0ACONFI=
G_SENSORS_ASC7621=3Dm=0A# CONFIG_SENSORS_AXI_FAN_CONTROL is not set=0ACONFI=
G_SENSORS_K8TEMP=3Dm=0ACONFIG_SENSORS_K10TEMP=3Dm=0ACONFIG_SENSORS_FAM15H_P=
OWER=3Dm=0ACONFIG_SENSORS_APPLESMC=3Dm=0ACONFIG_SENSORS_ASB100=3Dm=0A# CONF=
IG_SENSORS_ASPEED is not set=0ACONFIG_SENSORS_ATXP1=3Dm=0A# CONFIG_SENSORS_=
CORSAIR_CPRO is not set=0A# CONFIG_SENSORS_CORSAIR_PSU is not set=0A# CONFI=
G_SENSORS_DRIVETEMP is not set=0ACONFIG_SENSORS_DS620=3Dm=0ACONFIG_SENSORS_=
DS1621=3Dm=0ACONFIG_SENSORS_DELL_SMM=3Dm=0ACONFIG_SENSORS_I5K_AMB=3Dm=0ACON=
FIG_SENSORS_F71805F=3Dm=0ACONFIG_SENSORS_F71882FG=3Dm=0ACONFIG_SENSORS_F753=
75S=3Dm=0ACONFIG_SENSORS_FSCHMD=3Dm=0A# CONFIG_SENSORS_FTSTEUTATES is not s=
et=0ACONFIG_SENSORS_GL518SM=3Dm=0ACONFIG_SENSORS_GL520SM=3Dm=0ACONFIG_SENSO=
RS_G760A=3Dm=0A# CONFIG_SENSORS_G762 is not set=0A# CONFIG_SENSORS_HIH6130 =
is not set=0ACONFIG_SENSORS_IBMAEM=3Dm=0ACONFIG_SENSORS_IBMPEX=3Dm=0ACONFIG=
_SENSORS_I5500=3Dm=0ACONFIG_SENSORS_CORETEMP=3Dm=0ACONFIG_SENSORS_IT87=3Dm=
=0ACONFIG_SENSORS_JC42=3Dm=0A# CONFIG_SENSORS_POWR1220 is not set=0ACONFIG_=
SENSORS_LINEAGE=3Dm=0A# CONFIG_SENSORS_LTC2945 is not set=0A# CONFIG_SENSOR=
S_LTC2947_I2C is not set=0A# CONFIG_SENSORS_LTC2947_SPI is not set=0A# CONF=
IG_SENSORS_LTC2990 is not set=0A# CONFIG_SENSORS_LTC2992 is not set=0ACONFI=
G_SENSORS_LTC4151=3Dm=0ACONFIG_SENSORS_LTC4215=3Dm=0A# CONFIG_SENSORS_LTC42=
22 is not set=0ACONFIG_SENSORS_LTC4245=3Dm=0A# CONFIG_SENSORS_LTC4260 is no=
t set=0ACONFIG_SENSORS_LTC4261=3Dm=0A# CONFIG_SENSORS_MAX1111 is not set=0A=
# CONFIG_SENSORS_MAX127 is not set=0ACONFIG_SENSORS_MAX16065=3Dm=0ACONFIG_S=
ENSORS_MAX1619=3Dm=0ACONFIG_SENSORS_MAX1668=3Dm=0ACONFIG_SENSORS_MAX197=3Dm=
=0A# CONFIG_SENSORS_MAX31722 is not set=0A# CONFIG_SENSORS_MAX31730 is not =
set=0A# CONFIG_SENSORS_MAX6621 is not set=0ACONFIG_SENSORS_MAX6639=3Dm=0ACO=
NFIG_SENSORS_MAX6642=3Dm=0ACONFIG_SENSORS_MAX6650=3Dm=0ACONFIG_SENSORS_MAX6=
697=3Dm=0A# CONFIG_SENSORS_MAX31790 is not set=0ACONFIG_SENSORS_MCP3021=3Dm=
=0A# CONFIG_SENSORS_MLXREG_FAN is not set=0A# CONFIG_SENSORS_TC654 is not s=
et=0A# CONFIG_SENSORS_TPS23861 is not set=0A# CONFIG_SENSORS_MR75203 is not=
 set=0A# CONFIG_SENSORS_ADCXX is not set=0ACONFIG_SENSORS_LM63=3Dm=0A# CONF=
IG_SENSORS_LM70 is not set=0ACONFIG_SENSORS_LM73=3Dm=0ACONFIG_SENSORS_LM75=
=3Dm=0ACONFIG_SENSORS_LM77=3Dm=0ACONFIG_SENSORS_LM78=3Dm=0ACONFIG_SENSORS_L=
M80=3Dm=0ACONFIG_SENSORS_LM83=3Dm=0ACONFIG_SENSORS_LM85=3Dm=0ACONFIG_SENSOR=
S_LM87=3Dm=0ACONFIG_SENSORS_LM90=3Dm=0ACONFIG_SENSORS_LM92=3Dm=0ACONFIG_SEN=
SORS_LM93=3Dm=0ACONFIG_SENSORS_LM95234=3Dm=0ACONFIG_SENSORS_LM95241=3Dm=0AC=
ONFIG_SENSORS_LM95245=3Dm=0ACONFIG_SENSORS_PC87360=3Dm=0ACONFIG_SENSORS_PC8=
7427=3Dm=0ACONFIG_SENSORS_NTC_THERMISTOR=3Dm=0A# CONFIG_SENSORS_NCT6683 is =
not set=0ACONFIG_SENSORS_NCT6775=3Dm=0A# CONFIG_SENSORS_NCT7802 is not set=
=0A# CONFIG_SENSORS_NCT7904 is not set=0A# CONFIG_SENSORS_NPCM7XX is not se=
t=0A# CONFIG_SENSORS_NZXT_KRAKEN2 is not set=0ACONFIG_SENSORS_PCF8591=3Dm=
=0ACONFIG_PMBUS=3Dm=0ACONFIG_SENSORS_PMBUS=3Dm=0A# CONFIG_SENSORS_ADM1266 i=
s not set=0ACONFIG_SENSORS_ADM1275=3Dm=0A# CONFIG_SENSORS_BEL_PFE is not se=
t=0A# CONFIG_SENSORS_BPA_RS600 is not set=0A# CONFIG_SENSORS_FSP_3Y is not =
set=0A# CONFIG_SENSORS_IBM_CFFPS is not set=0A# CONFIG_SENSORS_DPS920AB is =
not set=0A# CONFIG_SENSORS_INSPUR_IPSPS is not set=0A# CONFIG_SENSORS_IR352=
21 is not set=0A# CONFIG_SENSORS_IR36021 is not set=0A# CONFIG_SENSORS_IR38=
064 is not set=0A# CONFIG_SENSORS_IRPS5401 is not set=0A# CONFIG_SENSORS_IS=
L68137 is not set=0ACONFIG_SENSORS_LM25066=3Dm=0ACONFIG_SENSORS_LTC2978=3Dm=
=0A# CONFIG_SENSORS_LTC3815 is not set=0A# CONFIG_SENSORS_MAX15301 is not s=
et=0ACONFIG_SENSORS_MAX16064=3Dm=0A# CONFIG_SENSORS_MAX16601 is not set=0A#=
 CONFIG_SENSORS_MAX20730 is not set=0A# CONFIG_SENSORS_MAX20751 is not set=
=0A# CONFIG_SENSORS_MAX31785 is not set=0ACONFIG_SENSORS_MAX34440=3Dm=0ACON=
FIG_SENSORS_MAX8688=3Dm=0A# CONFIG_SENSORS_MP2888 is not set=0A# CONFIG_SEN=
SORS_MP2975 is not set=0A# CONFIG_SENSORS_PIM4328 is not set=0A# CONFIG_SEN=
SORS_PM6764TR is not set=0A# CONFIG_SENSORS_PXE1610 is not set=0A# CONFIG_S=
ENSORS_Q54SJ108A2 is not set=0A# CONFIG_SENSORS_STPDDC60 is not set=0A# CON=
FIG_SENSORS_TPS40422 is not set=0A# CONFIG_SENSORS_TPS53679 is not set=0ACO=
NFIG_SENSORS_UCD9000=3Dm=0ACONFIG_SENSORS_UCD9200=3Dm=0A# CONFIG_SENSORS_XD=
PE122 is not set=0ACONFIG_SENSORS_ZL6100=3Dm=0A# CONFIG_SENSORS_SBTSI is no=
t set=0A# CONFIG_SENSORS_SBRMI is not set=0ACONFIG_SENSORS_SHT15=3Dm=0ACONF=
IG_SENSORS_SHT21=3Dm=0A# CONFIG_SENSORS_SHT3x is not set=0A# CONFIG_SENSORS=
_SHT4x is not set=0A# CONFIG_SENSORS_SHTC1 is not set=0ACONFIG_SENSORS_SIS5=
595=3Dm=0ACONFIG_SENSORS_DME1737=3Dm=0ACONFIG_SENSORS_EMC1403=3Dm=0A# CONFI=
G_SENSORS_EMC2103 is not set=0ACONFIG_SENSORS_EMC6W201=3Dm=0ACONFIG_SENSORS=
_SMSC47M1=3Dm=0ACONFIG_SENSORS_SMSC47M192=3Dm=0ACONFIG_SENSORS_SMSC47B397=
=3Dm=0ACONFIG_SENSORS_SCH56XX_COMMON=3Dm=0ACONFIG_SENSORS_SCH5627=3Dm=0ACON=
FIG_SENSORS_SCH5636=3Dm=0A# CONFIG_SENSORS_STTS751 is not set=0A# CONFIG_SE=
NSORS_SMM665 is not set=0A# CONFIG_SENSORS_ADC128D818 is not set=0ACONFIG_S=
ENSORS_ADS7828=3Dm=0A# CONFIG_SENSORS_ADS7871 is not set=0ACONFIG_SENSORS_A=
MC6821=3Dm=0ACONFIG_SENSORS_INA209=3Dm=0ACONFIG_SENSORS_INA2XX=3Dm=0A# CONF=
IG_SENSORS_INA3221 is not set=0A# CONFIG_SENSORS_TC74 is not set=0ACONFIG_S=
ENSORS_THMC50=3Dm=0ACONFIG_SENSORS_TMP102=3Dm=0A# CONFIG_SENSORS_TMP103 is =
not set=0A# CONFIG_SENSORS_TMP108 is not set=0ACONFIG_SENSORS_TMP401=3Dm=0A=
CONFIG_SENSORS_TMP421=3Dm=0A# CONFIG_SENSORS_TMP513 is not set=0ACONFIG_SEN=
SORS_VIA_CPUTEMP=3Dm=0ACONFIG_SENSORS_VIA686A=3Dm=0ACONFIG_SENSORS_VT1211=
=3Dm=0ACONFIG_SENSORS_VT8231=3Dm=0A# CONFIG_SENSORS_W83773G is not set=0ACO=
NFIG_SENSORS_W83781D=3Dm=0ACONFIG_SENSORS_W83791D=3Dm=0ACONFIG_SENSORS_W837=
92D=3Dm=0ACONFIG_SENSORS_W83793=3Dm=0ACONFIG_SENSORS_W83795=3Dm=0A# CONFIG_=
SENSORS_W83795_FANCTRL is not set=0ACONFIG_SENSORS_W83L785TS=3Dm=0ACONFIG_S=
ENSORS_W83L786NG=3Dm=0ACONFIG_SENSORS_W83627HF=3Dm=0ACONFIG_SENSORS_W83627E=
HF=3Dm=0A# CONFIG_SENSORS_XGENE is not set=0A=0A#=0A# ACPI drivers=0A#=0ACO=
NFIG_SENSORS_ACPI_POWER=3Dm=0ACONFIG_SENSORS_ATK0110=3Dm=0ACONFIG_THERMAL=
=3Dy=0A# CONFIG_THERMAL_NETLINK is not set=0A# CONFIG_THERMAL_STATISTICS is=
 not set=0ACONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0=0ACONFIG_THERMAL_=
HWMON=3Dy=0ACONFIG_THERMAL_WRITABLE_TRIPS=3Dy=0ACONFIG_THERMAL_DEFAULT_GOV_=
STEP_WISE=3Dy=0A# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set=0A# CONF=
IG_THERMAL_DEFAULT_GOV_USER_SPACE is not set=0ACONFIG_THERMAL_GOV_FAIR_SHAR=
E=3Dy=0ACONFIG_THERMAL_GOV_STEP_WISE=3Dy=0ACONFIG_THERMAL_GOV_BANG_BANG=3Dy=
=0ACONFIG_THERMAL_GOV_USER_SPACE=3Dy=0A# CONFIG_THERMAL_EMULATION is not se=
t=0A=0A#=0A# Intel thermal drivers=0A#=0ACONFIG_INTEL_POWERCLAMP=3Dm=0ACONF=
IG_X86_THERMAL_VECTOR=3Dy=0ACONFIG_X86_PKG_TEMP_THERMAL=3Dm=0ACONFIG_INTEL_=
SOC_DTS_IOSF_CORE=3Dm=0A# CONFIG_INTEL_SOC_DTS_THERMAL is not set=0A=0A#=0A=
# ACPI INT340X thermal drivers=0A#=0ACONFIG_INT340X_THERMAL=3Dm=0ACONFIG_AC=
PI_THERMAL_REL=3Dm=0A# CONFIG_INT3406_THERMAL is not set=0ACONFIG_PROC_THER=
MAL_MMIO_RAPL=3Dm=0A# end of ACPI INT340X thermal drivers=0A=0ACONFIG_INTEL=
_PCH_THERMAL=3Dm=0A# CONFIG_INTEL_TCC_COOLING is not set=0A# CONFIG_INTEL_M=
ENLOW is not set=0A# end of Intel thermal drivers=0A=0ACONFIG_WATCHDOG=3Dy=
=0ACONFIG_WATCHDOG_CORE=3Dy=0A# CONFIG_WATCHDOG_NOWAYOUT is not set=0ACONFI=
G_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy=0ACONFIG_WATCHDOG_OPEN_TIMEOUT=3D0=0ACON=
FIG_WATCHDOG_SYSFS=3Dy=0A# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set=0A=
=0A#=0A# Watchdog Pretimeout Governors=0A#=0A# CONFIG_WATCHDOG_PRETIMEOUT_G=
OV is not set=0A=0A#=0A# Watchdog Device Drivers=0A#=0ACONFIG_SOFT_WATCHDOG=
=3Dm=0ACONFIG_WDAT_WDT=3Dm=0A# CONFIG_XILINX_WATCHDOG is not set=0A# CONFIG=
_ZIIRAVE_WATCHDOG is not set=0A# CONFIG_MLX_WDT is not set=0A# CONFIG_CADEN=
CE_WATCHDOG is not set=0A# CONFIG_DW_WATCHDOG is not set=0A# CONFIG_MAX63XX=
_WATCHDOG is not set=0A# CONFIG_ACQUIRE_WDT is not set=0A# CONFIG_ADVANTECH=
_WDT is not set=0ACONFIG_ALIM1535_WDT=3Dm=0ACONFIG_ALIM7101_WDT=3Dm=0A# CON=
FIG_EBC_C384_WDT is not set=0ACONFIG_F71808E_WDT=3Dm=0ACONFIG_SP5100_TCO=3D=
m=0ACONFIG_SBC_FITPC2_WATCHDOG=3Dm=0A# CONFIG_EUROTECH_WDT is not set=0ACON=
FIG_IB700_WDT=3Dm=0ACONFIG_IBMASR=3Dm=0A# CONFIG_WAFER_WDT is not set=0ACON=
FIG_I6300ESB_WDT=3Dy=0ACONFIG_IE6XX_WDT=3Dm=0ACONFIG_ITCO_WDT=3Dy=0ACONFIG_=
ITCO_VENDOR_SUPPORT=3Dy=0ACONFIG_IT8712F_WDT=3Dm=0ACONFIG_IT87_WDT=3Dm=0ACO=
NFIG_HP_WATCHDOG=3Dm=0ACONFIG_HPWDT_NMI_DECODING=3Dy=0A# CONFIG_SC1200_WDT =
is not set=0A# CONFIG_PC87413_WDT is not set=0ACONFIG_NV_TCO=3Dm=0A# CONFIG=
_60XX_WDT is not set=0A# CONFIG_CPU5_WDT is not set=0ACONFIG_SMSC_SCH311X_W=
DT=3Dm=0A# CONFIG_SMSC37B787_WDT is not set=0A# CONFIG_TQMX86_WDT is not se=
t=0ACONFIG_VIA_WDT=3Dm=0ACONFIG_W83627HF_WDT=3Dm=0ACONFIG_W83877F_WDT=3Dm=
=0ACONFIG_W83977F_WDT=3Dm=0ACONFIG_MACHZ_WDT=3Dm=0A# CONFIG_SBC_EPX_C3_WATC=
HDOG is not set=0ACONFIG_INTEL_MEI_WDT=3Dm=0A# CONFIG_NI903X_WDT is not set=
=0A# CONFIG_NIC7018_WDT is not set=0A# CONFIG_MEN_A21_WDT is not set=0A=0A#=
=0A# PCI-based Watchdog Cards=0A#=0ACONFIG_PCIPCWATCHDOG=3Dm=0ACONFIG_WDTPC=
I=3Dm=0A=0A#=0A# USB-based Watchdog Cards=0A#=0A# CONFIG_USBPCWATCHDOG is n=
ot set=0ACONFIG_SSB_POSSIBLE=3Dy=0A# CONFIG_SSB is not set=0ACONFIG_BCMA_PO=
SSIBLE=3Dy=0ACONFIG_BCMA=3Dm=0ACONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy=0ACONFIG_B=
CMA_HOST_PCI=3Dy=0A# CONFIG_BCMA_HOST_SOC is not set=0ACONFIG_BCMA_DRIVER_P=
CI=3Dy=0ACONFIG_BCMA_DRIVER_GMAC_CMN=3Dy=0ACONFIG_BCMA_DRIVER_GPIO=3Dy=0A# =
CONFIG_BCMA_DEBUG is not set=0A=0A#=0A# Multifunction device drivers=0A#=0A=
CONFIG_MFD_CORE=3Dy=0A# CONFIG_MFD_AS3711 is not set=0A# CONFIG_PMIC_ADP552=
0 is not set=0A# CONFIG_MFD_AAT2870_CORE is not set=0A# CONFIG_MFD_BCM590XX=
 is not set=0A# CONFIG_MFD_BD9571MWV is not set=0A# CONFIG_MFD_AXP20X_I2C i=
s not set=0A# CONFIG_MFD_MADERA is not set=0A# CONFIG_PMIC_DA903X is not se=
t=0A# CONFIG_MFD_DA9052_SPI is not set=0A# CONFIG_MFD_DA9052_I2C is not set=
=0A# CONFIG_MFD_DA9055 is not set=0A# CONFIG_MFD_DA9062 is not set=0A# CONF=
IG_MFD_DA9063 is not set=0A# CONFIG_MFD_DA9150 is not set=0A# CONFIG_MFD_DL=
N2 is not set=0A# CONFIG_MFD_MC13XXX_SPI is not set=0A# CONFIG_MFD_MC13XXX_=
I2C is not set=0A# CONFIG_MFD_MP2629 is not set=0A# CONFIG_HTC_PASIC3 is no=
t set=0A# CONFIG_HTC_I2CPLD is not set=0A# CONFIG_MFD_INTEL_QUARK_I2C_GPIO =
is not set=0ACONFIG_LPC_ICH=3Dy=0ACONFIG_LPC_SCH=3Dm=0A# CONFIG_INTEL_SOC_P=
MIC_CHTDC_TI is not set=0ACONFIG_MFD_INTEL_LPSS=3Dy=0ACONFIG_MFD_INTEL_LPSS=
_ACPI=3Dy=0ACONFIG_MFD_INTEL_LPSS_PCI=3Dy=0A# CONFIG_MFD_INTEL_PMC_BXT is n=
ot set=0A# CONFIG_MFD_INTEL_PMT is not set=0A# CONFIG_MFD_IQS62X is not set=
=0A# CONFIG_MFD_JANZ_CMODIO is not set=0A# CONFIG_MFD_KEMPLD is not set=0A#=
 CONFIG_MFD_88PM800 is not set=0A# CONFIG_MFD_88PM805 is not set=0A# CONFIG=
_MFD_88PM860X is not set=0A# CONFIG_MFD_MAX14577 is not set=0A# CONFIG_MFD_=
MAX77693 is not set=0A# CONFIG_MFD_MAX77843 is not set=0A# CONFIG_MFD_MAX89=
07 is not set=0A# CONFIG_MFD_MAX8925 is not set=0A# CONFIG_MFD_MAX8997 is n=
ot set=0A# CONFIG_MFD_MAX8998 is not set=0A# CONFIG_MFD_MT6360 is not set=
=0A# CONFIG_MFD_MT6397 is not set=0A# CONFIG_MFD_MENF21BMC is not set=0A# C=
ONFIG_EZX_PCAP is not set=0A# CONFIG_MFD_VIPERBOARD is not set=0A# CONFIG_M=
FD_RETU is not set=0A# CONFIG_MFD_PCF50633 is not set=0A# CONFIG_MFD_RDC321=
X is not set=0A# CONFIG_MFD_RT4831 is not set=0A# CONFIG_MFD_RT5033 is not =
set=0A# CONFIG_MFD_RC5T583 is not set=0A# CONFIG_MFD_SI476X_CORE is not set=
=0ACONFIG_MFD_SM501=3Dm=0ACONFIG_MFD_SM501_GPIO=3Dy=0A# CONFIG_MFD_SKY81452=
 is not set=0A# CONFIG_MFD_SYSCON is not set=0A# CONFIG_MFD_TI_AM335X_TSCAD=
C is not set=0A# CONFIG_MFD_LP3943 is not set=0A# CONFIG_MFD_LP8788 is not =
set=0A# CONFIG_MFD_TI_LMU is not set=0A# CONFIG_MFD_PALMAS is not set=0A# C=
ONFIG_TPS6105X is not set=0A# CONFIG_TPS65010 is not set=0A# CONFIG_TPS6507=
X is not set=0A# CONFIG_MFD_TPS65086 is not set=0A# CONFIG_MFD_TPS65090 is =
not set=0A# CONFIG_MFD_TI_LP873X is not set=0A# CONFIG_MFD_TPS6586X is not =
set=0A# CONFIG_MFD_TPS65910 is not set=0A# CONFIG_MFD_TPS65912_I2C is not s=
et=0A# CONFIG_MFD_TPS65912_SPI is not set=0A# CONFIG_MFD_TPS80031 is not se=
t=0A# CONFIG_TWL4030_CORE is not set=0A# CONFIG_TWL6040_CORE is not set=0A#=
 CONFIG_MFD_WL1273_CORE is not set=0A# CONFIG_MFD_LM3533 is not set=0A# CON=
FIG_MFD_TQMX86 is not set=0ACONFIG_MFD_VX855=3Dm=0A# CONFIG_MFD_ARIZONA_I2C=
 is not set=0A# CONFIG_MFD_ARIZONA_SPI is not set=0A# CONFIG_MFD_WM8400 is =
not set=0A# CONFIG_MFD_WM831X_I2C is not set=0A# CONFIG_MFD_WM831X_SPI is n=
ot set=0A# CONFIG_MFD_WM8350_I2C is not set=0A# CONFIG_MFD_WM8994 is not se=
t=0A# CONFIG_MFD_ATC260X_I2C is not set=0A# CONFIG_MFD_INTEL_M10_BMC is not=
 set=0A# end of Multifunction device drivers=0A=0A# CONFIG_REGULATOR is not=
 set=0ACONFIG_RC_CORE=3Dm=0ACONFIG_RC_MAP=3Dm=0ACONFIG_LIRC=3Dy=0ACONFIG_RC=
_DECODERS=3Dy=0ACONFIG_IR_NEC_DECODER=3Dm=0ACONFIG_IR_RC5_DECODER=3Dm=0ACON=
FIG_IR_RC6_DECODER=3Dm=0ACONFIG_IR_JVC_DECODER=3Dm=0ACONFIG_IR_SONY_DECODER=
=3Dm=0ACONFIG_IR_SANYO_DECODER=3Dm=0A# CONFIG_IR_SHARP_DECODER is not set=
=0ACONFIG_IR_MCE_KBD_DECODER=3Dm=0A# CONFIG_IR_XMP_DECODER is not set=0ACON=
FIG_IR_IMON_DECODER=3Dm=0A# CONFIG_IR_RCMM_DECODER is not set=0ACONFIG_RC_D=
EVICES=3Dy=0A# CONFIG_RC_ATI_REMOTE is not set=0ACONFIG_IR_ENE=3Dm=0A# CONF=
IG_IR_IMON is not set=0A# CONFIG_IR_IMON_RAW is not set=0A# CONFIG_IR_MCEUS=
B is not set=0ACONFIG_IR_ITE_CIR=3Dm=0ACONFIG_IR_FINTEK=3Dm=0ACONFIG_IR_NUV=
OTON=3Dm=0A# CONFIG_IR_REDRAT3 is not set=0A# CONFIG_IR_STREAMZAP is not se=
t=0ACONFIG_IR_WINBOND_CIR=3Dm=0A# CONFIG_IR_IGORPLUGUSB is not set=0A# CONF=
IG_IR_IGUANA is not set=0A# CONFIG_IR_TTUSBIR is not set=0A# CONFIG_RC_LOOP=
BACK is not set=0ACONFIG_IR_SERIAL=3Dm=0ACONFIG_IR_SERIAL_TRANSMITTER=3Dy=
=0ACONFIG_IR_SIR=3Dm=0A# CONFIG_RC_XBOX_DVD is not set=0A# CONFIG_IR_TOY is=
 not set=0ACONFIG_MEDIA_CEC_SUPPORT=3Dy=0A# CONFIG_CEC_CH7322 is not set=0A=
# CONFIG_CEC_SECO is not set=0A# CONFIG_USB_PULSE8_CEC is not set=0A# CONFI=
G_USB_RAINSHADOW_CEC is not set=0ACONFIG_MEDIA_SUPPORT=3Dm=0A# CONFIG_MEDIA=
_SUPPORT_FILTER is not set=0A# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set=0A=
=0A#=0A# Media device types=0A#=0ACONFIG_MEDIA_CAMERA_SUPPORT=3Dy=0ACONFIG_=
MEDIA_ANALOG_TV_SUPPORT=3Dy=0ACONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy=0ACONFIG_=
MEDIA_RADIO_SUPPORT=3Dy=0ACONFIG_MEDIA_SDR_SUPPORT=3Dy=0ACONFIG_MEDIA_PLATF=
ORM_SUPPORT=3Dy=0ACONFIG_MEDIA_TEST_SUPPORT=3Dy=0A# end of Media device typ=
es=0A=0A#=0A# Media core support=0A#=0ACONFIG_VIDEO_DEV=3Dm=0ACONFIG_MEDIA_=
CONTROLLER=3Dy=0ACONFIG_DVB_CORE=3Dm=0A# end of Media core support=0A=0A#=
=0A# Video4Linux options=0A#=0ACONFIG_VIDEO_V4L2=3Dm=0ACONFIG_VIDEO_V4L2_I2=
C=3Dy=0ACONFIG_VIDEO_V4L2_SUBDEV_API=3Dy=0A# CONFIG_VIDEO_ADV_DEBUG is not =
set=0A# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set=0A# end of Video4Linux o=
ptions=0A=0A#=0A# Media controller options=0A#=0A# CONFIG_MEDIA_CONTROLLER_=
DVB is not set=0A# end of Media controller options=0A=0A#=0A# Digital TV op=
tions=0A#=0A# CONFIG_DVB_MMAP is not set=0ACONFIG_DVB_NET=3Dy=0ACONFIG_DVB_=
MAX_ADAPTERS=3D16=0ACONFIG_DVB_DYNAMIC_MINORS=3Dy=0A# CONFIG_DVB_DEMUX_SECT=
ION_LOSS_LOG is not set=0A# CONFIG_DVB_ULE_DEBUG is not set=0A# end of Digi=
tal TV options=0A=0A#=0A# Media drivers=0A#=0A# CONFIG_MEDIA_USB_SUPPORT is=
 not set=0A# CONFIG_MEDIA_PCI_SUPPORT is not set=0ACONFIG_RADIO_ADAPTERS=3D=
y=0A# CONFIG_RADIO_SI470X is not set=0A# CONFIG_RADIO_SI4713 is not set=0A#=
 CONFIG_USB_MR800 is not set=0A# CONFIG_USB_DSBR is not set=0A# CONFIG_RADI=
O_MAXIRADIO is not set=0A# CONFIG_RADIO_SHARK is not set=0A# CONFIG_RADIO_S=
HARK2 is not set=0A# CONFIG_USB_KEENE is not set=0A# CONFIG_USB_RAREMONO is=
 not set=0A# CONFIG_USB_MA901 is not set=0A# CONFIG_RADIO_TEA5764 is not se=
t=0A# CONFIG_RADIO_SAA7706H is not set=0A# CONFIG_RADIO_TEF6862 is not set=
=0A# CONFIG_RADIO_WL1273 is not set=0ACONFIG_VIDEOBUF2_CORE=3Dm=0ACONFIG_VI=
DEOBUF2_V4L2=3Dm=0ACONFIG_VIDEOBUF2_MEMOPS=3Dm=0ACONFIG_VIDEOBUF2_VMALLOC=
=3Dm=0A# CONFIG_V4L_PLATFORM_DRIVERS is not set=0A# CONFIG_V4L_MEM2MEM_DRIV=
ERS is not set=0A# CONFIG_DVB_PLATFORM_DRIVERS is not set=0A# CONFIG_SDR_PL=
ATFORM_DRIVERS is not set=0A=0A#=0A# MMC/SDIO DVB adapters=0A#=0A# CONFIG_S=
MS_SDIO_DRV is not set=0A# CONFIG_V4L_TEST_DRIVERS is not set=0A# CONFIG_DV=
B_TEST_DRIVERS is not set=0A=0A#=0A# FireWire (IEEE 1394) Adapters=0A#=0A# =
CONFIG_DVB_FIREDTV is not set=0A# end of Media drivers=0A=0A#=0A# Media anc=
illary drivers=0A#=0ACONFIG_MEDIA_ATTACH=3Dy=0ACONFIG_VIDEO_IR_I2C=3Dm=0A=
=0A#=0A# Audio decoders, processors and mixers=0A#=0A# CONFIG_VIDEO_TVAUDIO=
 is not set=0A# CONFIG_VIDEO_TDA7432 is not set=0A# CONFIG_VIDEO_TDA9840 is=
 not set=0A# CONFIG_VIDEO_TEA6415C is not set=0A# CONFIG_VIDEO_TEA6420 is n=
ot set=0A# CONFIG_VIDEO_MSP3400 is not set=0A# CONFIG_VIDEO_CS3308 is not s=
et=0A# CONFIG_VIDEO_CS5345 is not set=0A# CONFIG_VIDEO_CS53L32A is not set=
=0A# CONFIG_VIDEO_TLV320AIC23B is not set=0A# CONFIG_VIDEO_UDA1342 is not s=
et=0A# CONFIG_VIDEO_WM8775 is not set=0A# CONFIG_VIDEO_WM8739 is not set=0A=
# CONFIG_VIDEO_VP27SMPX is not set=0A# CONFIG_VIDEO_SONY_BTF_MPX is not set=
=0A# end of Audio decoders, processors and mixers=0A=0A#=0A# RDS decoders=
=0A#=0A# CONFIG_VIDEO_SAA6588 is not set=0A# end of RDS decoders=0A=0A#=0A#=
 Video decoders=0A#=0A# CONFIG_VIDEO_ADV7180 is not set=0A# CONFIG_VIDEO_AD=
V7183 is not set=0A# CONFIG_VIDEO_ADV7604 is not set=0A# CONFIG_VIDEO_ADV78=
42 is not set=0A# CONFIG_VIDEO_BT819 is not set=0A# CONFIG_VIDEO_BT856 is n=
ot set=0A# CONFIG_VIDEO_BT866 is not set=0A# CONFIG_VIDEO_KS0127 is not set=
=0A# CONFIG_VIDEO_ML86V7667 is not set=0A# CONFIG_VIDEO_SAA7110 is not set=
=0A# CONFIG_VIDEO_SAA711X is not set=0A# CONFIG_VIDEO_TC358743 is not set=
=0A# CONFIG_VIDEO_TVP514X is not set=0A# CONFIG_VIDEO_TVP5150 is not set=0A=
# CONFIG_VIDEO_TVP7002 is not set=0A# CONFIG_VIDEO_TW2804 is not set=0A# CO=
NFIG_VIDEO_TW9903 is not set=0A# CONFIG_VIDEO_TW9906 is not set=0A# CONFIG_=
VIDEO_TW9910 is not set=0A# CONFIG_VIDEO_VPX3220 is not set=0A=0A#=0A# Vide=
o and audio decoders=0A#=0A# CONFIG_VIDEO_SAA717X is not set=0A# CONFIG_VID=
EO_CX25840 is not set=0A# end of Video decoders=0A=0A#=0A# Video encoders=
=0A#=0A# CONFIG_VIDEO_SAA7127 is not set=0A# CONFIG_VIDEO_SAA7185 is not se=
t=0A# CONFIG_VIDEO_ADV7170 is not set=0A# CONFIG_VIDEO_ADV7175 is not set=
=0A# CONFIG_VIDEO_ADV7343 is not set=0A# CONFIG_VIDEO_ADV7393 is not set=0A=
# CONFIG_VIDEO_ADV7511 is not set=0A# CONFIG_VIDEO_AD9389B is not set=0A# C=
ONFIG_VIDEO_AK881X is not set=0A# CONFIG_VIDEO_THS8200 is not set=0A# end o=
f Video encoders=0A=0A#=0A# Video improvement chips=0A#=0A# CONFIG_VIDEO_UP=
D64031A is not set=0A# CONFIG_VIDEO_UPD64083 is not set=0A# end of Video im=
provement chips=0A=0A#=0A# Audio/Video compression chips=0A#=0A# CONFIG_VID=
EO_SAA6752HS is not set=0A# end of Audio/Video compression chips=0A=0A#=0A#=
 SDR tuner chips=0A#=0A# CONFIG_SDR_MAX2175 is not set=0A# end of SDR tuner=
 chips=0A=0A#=0A# Miscellaneous helper chips=0A#=0A# CONFIG_VIDEO_THS7303 i=
s not set=0A# CONFIG_VIDEO_M52790 is not set=0A# CONFIG_VIDEO_I2C is not se=
t=0A# CONFIG_VIDEO_ST_MIPID02 is not set=0A# end of Miscellaneous helper ch=
ips=0A=0A#=0A# Camera sensor devices=0A#=0A# CONFIG_VIDEO_HI556 is not set=
=0A# CONFIG_VIDEO_IMX208 is not set=0A# CONFIG_VIDEO_IMX214 is not set=0A# =
CONFIG_VIDEO_IMX219 is not set=0A# CONFIG_VIDEO_IMX258 is not set=0A# CONFI=
G_VIDEO_IMX274 is not set=0A# CONFIG_VIDEO_IMX290 is not set=0A# CONFIG_VID=
EO_IMX319 is not set=0A# CONFIG_VIDEO_IMX355 is not set=0A# CONFIG_VIDEO_OV=
02A10 is not set=0A# CONFIG_VIDEO_OV2640 is not set=0A# CONFIG_VIDEO_OV2659=
 is not set=0A# CONFIG_VIDEO_OV2680 is not set=0A# CONFIG_VIDEO_OV2685 is n=
ot set=0A# CONFIG_VIDEO_OV2740 is not set=0A# CONFIG_VIDEO_OV5647 is not se=
t=0A# CONFIG_VIDEO_OV5648 is not set=0A# CONFIG_VIDEO_OV6650 is not set=0A#=
 CONFIG_VIDEO_OV5670 is not set=0A# CONFIG_VIDEO_OV5675 is not set=0A# CONF=
IG_VIDEO_OV5695 is not set=0A# CONFIG_VIDEO_OV7251 is not set=0A# CONFIG_VI=
DEO_OV772X is not set=0A# CONFIG_VIDEO_OV7640 is not set=0A# CONFIG_VIDEO_O=
V7670 is not set=0A# CONFIG_VIDEO_OV7740 is not set=0A# CONFIG_VIDEO_OV8856=
 is not set=0A# CONFIG_VIDEO_OV8865 is not set=0A# CONFIG_VIDEO_OV9640 is n=
ot set=0A# CONFIG_VIDEO_OV9650 is not set=0A# CONFIG_VIDEO_OV9734 is not se=
t=0A# CONFIG_VIDEO_OV13858 is not set=0A# CONFIG_VIDEO_VS6624 is not set=0A=
# CONFIG_VIDEO_MT9M001 is not set=0A# CONFIG_VIDEO_MT9M032 is not set=0A# C=
ONFIG_VIDEO_MT9M111 is not set=0A# CONFIG_VIDEO_MT9P031 is not set=0A# CONF=
IG_VIDEO_MT9T001 is not set=0A# CONFIG_VIDEO_MT9T112 is not set=0A# CONFIG_=
VIDEO_MT9V011 is not set=0A# CONFIG_VIDEO_MT9V032 is not set=0A# CONFIG_VID=
EO_MT9V111 is not set=0A# CONFIG_VIDEO_SR030PC30 is not set=0A# CONFIG_VIDE=
O_NOON010PC30 is not set=0A# CONFIG_VIDEO_M5MOLS is not set=0A# CONFIG_VIDE=
O_RDACM20 is not set=0A# CONFIG_VIDEO_RDACM21 is not set=0A# CONFIG_VIDEO_R=
J54N1 is not set=0A# CONFIG_VIDEO_S5K6AA is not set=0A# CONFIG_VIDEO_S5K6A3=
 is not set=0A# CONFIG_VIDEO_S5K4ECGX is not set=0A# CONFIG_VIDEO_S5K5BAF i=
s not set=0A# CONFIG_VIDEO_CCS is not set=0A# CONFIG_VIDEO_ET8EK8 is not se=
t=0A# CONFIG_VIDEO_S5C73M3 is not set=0A# end of Camera sensor devices=0A=
=0A#=0A# Lens drivers=0A#=0A# CONFIG_VIDEO_AD5820 is not set=0A# CONFIG_VID=
EO_AK7375 is not set=0A# CONFIG_VIDEO_DW9714 is not set=0A# CONFIG_VIDEO_DW=
9768 is not set=0A# CONFIG_VIDEO_DW9807_VCM is not set=0A# end of Lens driv=
ers=0A=0A#=0A# Flash devices=0A#=0A# CONFIG_VIDEO_ADP1653 is not set=0A# CO=
NFIG_VIDEO_LM3560 is not set=0A# CONFIG_VIDEO_LM3646 is not set=0A# end of =
Flash devices=0A=0A#=0A# SPI helper chips=0A#=0A# CONFIG_VIDEO_GS1662 is no=
t set=0A# end of SPI helper chips=0A=0A#=0A# Media SPI Adapters=0A#=0ACONFI=
G_CXD2880_SPI_DRV=3Dm=0A# end of Media SPI Adapters=0A=0ACONFIG_MEDIA_TUNER=
=3Dm=0A=0A#=0A# Customize TV tuners=0A#=0ACONFIG_MEDIA_TUNER_SIMPLE=3Dm=0AC=
ONFIG_MEDIA_TUNER_TDA18250=3Dm=0ACONFIG_MEDIA_TUNER_TDA8290=3Dm=0ACONFIG_ME=
DIA_TUNER_TDA827X=3Dm=0ACONFIG_MEDIA_TUNER_TDA18271=3Dm=0ACONFIG_MEDIA_TUNE=
R_TDA9887=3Dm=0ACONFIG_MEDIA_TUNER_TEA5761=3Dm=0ACONFIG_MEDIA_TUNER_TEA5767=
=3Dm=0ACONFIG_MEDIA_TUNER_MSI001=3Dm=0ACONFIG_MEDIA_TUNER_MT20XX=3Dm=0ACONF=
IG_MEDIA_TUNER_MT2060=3Dm=0ACONFIG_MEDIA_TUNER_MT2063=3Dm=0ACONFIG_MEDIA_TU=
NER_MT2266=3Dm=0ACONFIG_MEDIA_TUNER_MT2131=3Dm=0ACONFIG_MEDIA_TUNER_QT1010=
=3Dm=0ACONFIG_MEDIA_TUNER_XC2028=3Dm=0ACONFIG_MEDIA_TUNER_XC5000=3Dm=0ACONF=
IG_MEDIA_TUNER_XC4000=3Dm=0ACONFIG_MEDIA_TUNER_MXL5005S=3Dm=0ACONFIG_MEDIA_=
TUNER_MXL5007T=3Dm=0ACONFIG_MEDIA_TUNER_MC44S803=3Dm=0ACONFIG_MEDIA_TUNER_M=
AX2165=3Dm=0ACONFIG_MEDIA_TUNER_TDA18218=3Dm=0ACONFIG_MEDIA_TUNER_FC0011=3D=
m=0ACONFIG_MEDIA_TUNER_FC0012=3Dm=0ACONFIG_MEDIA_TUNER_FC0013=3Dm=0ACONFIG_=
MEDIA_TUNER_TDA18212=3Dm=0ACONFIG_MEDIA_TUNER_E4000=3Dm=0ACONFIG_MEDIA_TUNE=
R_FC2580=3Dm=0ACONFIG_MEDIA_TUNER_M88RS6000T=3Dm=0ACONFIG_MEDIA_TUNER_TUA90=
01=3Dm=0ACONFIG_MEDIA_TUNER_SI2157=3Dm=0ACONFIG_MEDIA_TUNER_IT913X=3Dm=0ACO=
NFIG_MEDIA_TUNER_R820T=3Dm=0ACONFIG_MEDIA_TUNER_MXL301RF=3Dm=0ACONFIG_MEDIA=
_TUNER_QM1D1C0042=3Dm=0ACONFIG_MEDIA_TUNER_QM1D1B0004=3Dm=0A# end of Custom=
ize TV tuners=0A=0A#=0A# Customise DVB Frontends=0A#=0A=0A#=0A# Multistanda=
rd (satellite) frontends=0A#=0ACONFIG_DVB_STB0899=3Dm=0ACONFIG_DVB_STB6100=
=3Dm=0ACONFIG_DVB_STV090x=3Dm=0ACONFIG_DVB_STV0910=3Dm=0ACONFIG_DVB_STV6110=
x=3Dm=0ACONFIG_DVB_STV6111=3Dm=0ACONFIG_DVB_MXL5XX=3Dm=0ACONFIG_DVB_M88DS31=
03=3Dm=0A=0A#=0A# Multistandard (cable + terrestrial) frontends=0A#=0ACONFI=
G_DVB_DRXK=3Dm=0ACONFIG_DVB_TDA18271C2DD=3Dm=0ACONFIG_DVB_SI2165=3Dm=0ACONF=
IG_DVB_MN88472=3Dm=0ACONFIG_DVB_MN88473=3Dm=0A=0A#=0A# DVB-S (satellite) fr=
ontends=0A#=0ACONFIG_DVB_CX24110=3Dm=0ACONFIG_DVB_CX24123=3Dm=0ACONFIG_DVB_=
MT312=3Dm=0ACONFIG_DVB_ZL10036=3Dm=0ACONFIG_DVB_ZL10039=3Dm=0ACONFIG_DVB_S5=
H1420=3Dm=0ACONFIG_DVB_STV0288=3Dm=0ACONFIG_DVB_STB6000=3Dm=0ACONFIG_DVB_ST=
V0299=3Dm=0ACONFIG_DVB_STV6110=3Dm=0ACONFIG_DVB_STV0900=3Dm=0ACONFIG_DVB_TD=
A8083=3Dm=0ACONFIG_DVB_TDA10086=3Dm=0ACONFIG_DVB_TDA8261=3Dm=0ACONFIG_DVB_V=
ES1X93=3Dm=0ACONFIG_DVB_TUNER_ITD1000=3Dm=0ACONFIG_DVB_TUNER_CX24113=3Dm=0A=
CONFIG_DVB_TDA826X=3Dm=0ACONFIG_DVB_TUA6100=3Dm=0ACONFIG_DVB_CX24116=3Dm=0A=
CONFIG_DVB_CX24117=3Dm=0ACONFIG_DVB_CX24120=3Dm=0ACONFIG_DVB_SI21XX=3Dm=0AC=
ONFIG_DVB_TS2020=3Dm=0ACONFIG_DVB_DS3000=3Dm=0ACONFIG_DVB_MB86A16=3Dm=0ACON=
FIG_DVB_TDA10071=3Dm=0A=0A#=0A# DVB-T (terrestrial) frontends=0A#=0ACONFIG_=
DVB_SP887X=3Dm=0ACONFIG_DVB_CX22700=3Dm=0ACONFIG_DVB_CX22702=3Dm=0ACONFIG_D=
VB_S5H1432=3Dm=0ACONFIG_DVB_DRXD=3Dm=0ACONFIG_DVB_L64781=3Dm=0ACONFIG_DVB_T=
DA1004X=3Dm=0ACONFIG_DVB_NXT6000=3Dm=0ACONFIG_DVB_MT352=3Dm=0ACONFIG_DVB_ZL=
10353=3Dm=0ACONFIG_DVB_DIB3000MB=3Dm=0ACONFIG_DVB_DIB3000MC=3Dm=0ACONFIG_DV=
B_DIB7000M=3Dm=0ACONFIG_DVB_DIB7000P=3Dm=0ACONFIG_DVB_DIB9000=3Dm=0ACONFIG_=
DVB_TDA10048=3Dm=0ACONFIG_DVB_AF9013=3Dm=0ACONFIG_DVB_EC100=3Dm=0ACONFIG_DV=
B_STV0367=3Dm=0ACONFIG_DVB_CXD2820R=3Dm=0ACONFIG_DVB_CXD2841ER=3Dm=0ACONFIG=
_DVB_RTL2830=3Dm=0ACONFIG_DVB_RTL2832=3Dm=0ACONFIG_DVB_RTL2832_SDR=3Dm=0ACO=
NFIG_DVB_SI2168=3Dm=0ACONFIG_DVB_ZD1301_DEMOD=3Dm=0ACONFIG_DVB_CXD2880=3Dm=
=0A=0A#=0A# DVB-C (cable) frontends=0A#=0ACONFIG_DVB_VES1820=3Dm=0ACONFIG_D=
VB_TDA10021=3Dm=0ACONFIG_DVB_TDA10023=3Dm=0ACONFIG_DVB_STV0297=3Dm=0A=0A#=
=0A# ATSC (North American/Korean Terrestrial/Cable DTV) frontends=0A#=0ACON=
FIG_DVB_NXT200X=3Dm=0ACONFIG_DVB_OR51211=3Dm=0ACONFIG_DVB_OR51132=3Dm=0ACON=
FIG_DVB_BCM3510=3Dm=0ACONFIG_DVB_LGDT330X=3Dm=0ACONFIG_DVB_LGDT3305=3Dm=0AC=
ONFIG_DVB_LGDT3306A=3Dm=0ACONFIG_DVB_LG2160=3Dm=0ACONFIG_DVB_S5H1409=3Dm=0A=
CONFIG_DVB_AU8522=3Dm=0ACONFIG_DVB_AU8522_DTV=3Dm=0ACONFIG_DVB_AU8522_V4L=
=3Dm=0ACONFIG_DVB_S5H1411=3Dm=0ACONFIG_DVB_MXL692=3Dm=0A=0A#=0A# ISDB-T (te=
rrestrial) frontends=0A#=0ACONFIG_DVB_S921=3Dm=0ACONFIG_DVB_DIB8000=3Dm=0AC=
ONFIG_DVB_MB86A20S=3Dm=0A=0A#=0A# ISDB-S (satellite) & ISDB-T (terrestrial)=
 frontends=0A#=0ACONFIG_DVB_TC90522=3Dm=0ACONFIG_DVB_MN88443X=3Dm=0A=0A#=0A=
# Digital terrestrial only tuners/PLL=0A#=0ACONFIG_DVB_PLL=3Dm=0ACONFIG_DVB=
_TUNER_DIB0070=3Dm=0ACONFIG_DVB_TUNER_DIB0090=3Dm=0A=0A#=0A# SEC control de=
vices for DVB-S=0A#=0ACONFIG_DVB_DRX39XYJ=3Dm=0ACONFIG_DVB_LNBH25=3Dm=0ACON=
FIG_DVB_LNBH29=3Dm=0ACONFIG_DVB_LNBP21=3Dm=0ACONFIG_DVB_LNBP22=3Dm=0ACONFIG=
_DVB_ISL6405=3Dm=0ACONFIG_DVB_ISL6421=3Dm=0ACONFIG_DVB_ISL6423=3Dm=0ACONFIG=
_DVB_A8293=3Dm=0ACONFIG_DVB_LGS8GL5=3Dm=0ACONFIG_DVB_LGS8GXX=3Dm=0ACONFIG_D=
VB_ATBM8830=3Dm=0ACONFIG_DVB_TDA665x=3Dm=0ACONFIG_DVB_IX2505V=3Dm=0ACONFIG_=
DVB_M88RS2000=3Dm=0ACONFIG_DVB_AF9033=3Dm=0ACONFIG_DVB_HORUS3A=3Dm=0ACONFIG=
_DVB_ASCOT2E=3Dm=0ACONFIG_DVB_HELENE=3Dm=0A=0A#=0A# Common Interface (EN502=
21) controller drivers=0A#=0ACONFIG_DVB_CXD2099=3Dm=0ACONFIG_DVB_SP2=3Dm=0A=
# end of Customise DVB Frontends=0A=0A#=0A# Tools to develop new frontends=
=0A#=0A# CONFIG_DVB_DUMMY_FE is not set=0A# end of Media ancillary drivers=
=0A=0A#=0A# Graphics support=0A#=0A# CONFIG_AGP is not set=0ACONFIG_INTEL_G=
TT=3Dm=0ACONFIG_VGA_ARB=3Dy=0ACONFIG_VGA_ARB_MAX_GPUS=3D64=0ACONFIG_VGA_SWI=
TCHEROO=3Dy=0ACONFIG_DRM=3Dm=0ACONFIG_DRM_MIPI_DSI=3Dy=0ACONFIG_DRM_DP_AUX_=
CHARDEV=3Dy=0A# CONFIG_DRM_DEBUG_SELFTEST is not set=0ACONFIG_DRM_KMS_HELPE=
R=3Dm=0ACONFIG_DRM_FBDEV_EMULATION=3Dy=0ACONFIG_DRM_FBDEV_OVERALLOC=3D100=
=0ACONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy=0A# CONFIG_DRM_DP_CEC is not set=0ACON=
FIG_DRM_TTM=3Dm=0ACONFIG_DRM_VRAM_HELPER=3Dm=0ACONFIG_DRM_TTM_HELPER=3Dm=0A=
CONFIG_DRM_GEM_SHMEM_HELPER=3Dy=0A=0A#=0A# I2C encoder or helper chips=0A#=
=0ACONFIG_DRM_I2C_CH7006=3Dm=0ACONFIG_DRM_I2C_SIL164=3Dm=0A# CONFIG_DRM_I2C=
_NXP_TDA998X is not set=0A# CONFIG_DRM_I2C_NXP_TDA9950 is not set=0A# end o=
f I2C encoder or helper chips=0A=0A#=0A# ARM devices=0A#=0A# end of ARM dev=
ices=0A=0A# CONFIG_DRM_RADEON is not set=0A# CONFIG_DRM_AMDGPU is not set=
=0A# CONFIG_DRM_NOUVEAU is not set=0ACONFIG_DRM_I915=3Dm=0ACONFIG_DRM_I915_=
FORCE_PROBE=3D""=0ACONFIG_DRM_I915_CAPTURE_ERROR=3Dy=0ACONFIG_DRM_I915_COMP=
RESS_ERROR=3Dy=0ACONFIG_DRM_I915_USERPTR=3Dy=0ACONFIG_DRM_I915_GVT=3Dy=0A# =
CONFIG_DRM_I915_GVT_KVMGT is not set=0ACONFIG_DRM_I915_REQUEST_TIMEOUT=3D20=
000=0ACONFIG_DRM_I915_FENCE_TIMEOUT=3D10000=0ACONFIG_DRM_I915_USERFAULT_AUT=
OSUSPEND=3D250=0ACONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500=0ACONFIG_DRM_I91=
5_PREEMPT_TIMEOUT=3D640=0ACONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000=0ACON=
FIG_DRM_I915_STOP_TIMEOUT=3D100=0ACONFIG_DRM_I915_TIMESLICE_DURATION=3D1=0A=
# CONFIG_DRM_VGEM is not set=0A# CONFIG_DRM_VKMS is not set=0A# CONFIG_DRM_=
VMWGFX is not set=0ACONFIG_DRM_GMA500=3Dm=0A# CONFIG_DRM_UDL is not set=0AC=
ONFIG_DRM_AST=3Dm=0ACONFIG_DRM_MGAG200=3Dm=0ACONFIG_DRM_QXL=3Dm=0ACONFIG_DR=
M_VIRTIO_GPU=3Dm=0ACONFIG_DRM_PANEL=3Dy=0A=0A#=0A# Display Panels=0A#=0A# C=
ONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set=0A# CONFIG_DRM_PANEL_WID=
ECHIPS_WS2401 is not set=0A# end of Display Panels=0A=0ACONFIG_DRM_BRIDGE=
=3Dy=0ACONFIG_DRM_PANEL_BRIDGE=3Dy=0A=0A#=0A# Display Interface Bridges=0A#=
=0A# CONFIG_DRM_ANALOGIX_ANX78XX is not set=0A# end of Display Interface Br=
idges=0A=0A# CONFIG_DRM_ETNAVIV is not set=0ACONFIG_DRM_BOCHS=3Dm=0ACONFIG_=
DRM_CIRRUS_QEMU=3Dm=0A# CONFIG_DRM_GM12U320 is not set=0A# CONFIG_DRM_SIMPL=
EDRM is not set=0A# CONFIG_TINYDRM_HX8357D is not set=0A# CONFIG_TINYDRM_IL=
I9225 is not set=0A# CONFIG_TINYDRM_ILI9341 is not set=0A# CONFIG_TINYDRM_I=
LI9486 is not set=0A# CONFIG_TINYDRM_MI0283QT is not set=0A# CONFIG_TINYDRM=
_REPAPER is not set=0A# CONFIG_TINYDRM_ST7586 is not set=0A# CONFIG_TINYDRM=
_ST7735R is not set=0A# CONFIG_DRM_VBOXVIDEO is not set=0A# CONFIG_DRM_GUD =
is not set=0A# CONFIG_DRM_HYPERV is not set=0A# CONFIG_DRM_LEGACY is not se=
t=0ACONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy=0A=0A#=0A# Frame buffer Devices=
=0A#=0ACONFIG_FB_CMDLINE=3Dy=0ACONFIG_FB_NOTIFY=3Dy=0ACONFIG_FB=3Dy=0A# CON=
FIG_FIRMWARE_EDID is not set=0ACONFIG_FB_BOOT_VESA_SUPPORT=3Dy=0ACONFIG_FB_=
CFB_FILLRECT=3Dy=0ACONFIG_FB_CFB_COPYAREA=3Dy=0ACONFIG_FB_CFB_IMAGEBLIT=3Dy=
=0ACONFIG_FB_SYS_FILLRECT=3Dm=0ACONFIG_FB_SYS_COPYAREA=3Dm=0ACONFIG_FB_SYS_=
IMAGEBLIT=3Dm=0A# CONFIG_FB_FOREIGN_ENDIAN is not set=0ACONFIG_FB_SYS_FOPS=
=3Dm=0ACONFIG_FB_DEFERRED_IO=3Dy=0A# CONFIG_FB_MODE_HELPERS is not set=0ACO=
NFIG_FB_TILEBLITTING=3Dy=0A=0A#=0A# Frame buffer hardware drivers=0A#=0A# C=
ONFIG_FB_CIRRUS is not set=0A# CONFIG_FB_PM2 is not set=0A# CONFIG_FB_CYBER=
2000 is not set=0A# CONFIG_FB_ARC is not set=0A# CONFIG_FB_ASILIANT is not =
set=0A# CONFIG_FB_IMSTT is not set=0A# CONFIG_FB_VGA16 is not set=0A# CONFI=
G_FB_UVESA is not set=0ACONFIG_FB_VESA=3Dy=0ACONFIG_FB_EFI=3Dy=0A# CONFIG_F=
B_N411 is not set=0A# CONFIG_FB_HGA is not set=0A# CONFIG_FB_OPENCORES is n=
ot set=0A# CONFIG_FB_S1D13XXX is not set=0A# CONFIG_FB_NVIDIA is not set=0A=
# CONFIG_FB_RIVA is not set=0A# CONFIG_FB_I740 is not set=0A# CONFIG_FB_LE8=
0578 is not set=0A# CONFIG_FB_MATROX is not set=0A# CONFIG_FB_RADEON is not=
 set=0A# CONFIG_FB_ATY128 is not set=0A# CONFIG_FB_ATY is not set=0A# CONFI=
G_FB_S3 is not set=0A# CONFIG_FB_SAVAGE is not set=0A# CONFIG_FB_SIS is not=
 set=0A# CONFIG_FB_VIA is not set=0A# CONFIG_FB_NEOMAGIC is not set=0A# CON=
FIG_FB_KYRO is not set=0A# CONFIG_FB_3DFX is not set=0A# CONFIG_FB_VOODOO1 =
is not set=0A# CONFIG_FB_VT8623 is not set=0A# CONFIG_FB_TRIDENT is not set=
=0A# CONFIG_FB_ARK is not set=0A# CONFIG_FB_PM3 is not set=0A# CONFIG_FB_CA=
RMINE is not set=0A# CONFIG_FB_SM501 is not set=0A# CONFIG_FB_SMSCUFX is no=
t set=0A# CONFIG_FB_UDL is not set=0A# CONFIG_FB_IBM_GXT4500 is not set=0A#=
 CONFIG_FB_VIRTUAL is not set=0A# CONFIG_FB_METRONOME is not set=0A# CONFIG=
_FB_MB862XX is not set=0ACONFIG_FB_HYPERV=3Dm=0A# CONFIG_FB_SIMPLE is not s=
et=0A# CONFIG_FB_SSD1307 is not set=0A# CONFIG_FB_SM712 is not set=0A# end =
of Frame buffer Devices=0A=0A#=0A# Backlight & LCD device support=0A#=0ACON=
FIG_LCD_CLASS_DEVICE=3Dm=0A# CONFIG_LCD_L4F00242T03 is not set=0A# CONFIG_L=
CD_LMS283GF05 is not set=0A# CONFIG_LCD_LTV350QV is not set=0A# CONFIG_LCD_=
ILI922X is not set=0A# CONFIG_LCD_ILI9320 is not set=0A# CONFIG_LCD_TDO24M =
is not set=0A# CONFIG_LCD_VGG2432A4 is not set=0ACONFIG_LCD_PLATFORM=3Dm=0A=
# CONFIG_LCD_AMS369FG06 is not set=0A# CONFIG_LCD_LMS501KF03 is not set=0A#=
 CONFIG_LCD_HX8357 is not set=0A# CONFIG_LCD_OTM3225A is not set=0ACONFIG_B=
ACKLIGHT_CLASS_DEVICE=3Dy=0A# CONFIG_BACKLIGHT_KTD253 is not set=0A# CONFIG=
_BACKLIGHT_PWM is not set=0ACONFIG_BACKLIGHT_APPLE=3Dm=0A# CONFIG_BACKLIGHT=
_QCOM_WLED is not set=0A# CONFIG_BACKLIGHT_SAHARA is not set=0A# CONFIG_BAC=
KLIGHT_ADP8860 is not set=0A# CONFIG_BACKLIGHT_ADP8870 is not set=0A# CONFI=
G_BACKLIGHT_LM3630A is not set=0A# CONFIG_BACKLIGHT_LM3639 is not set=0ACON=
FIG_BACKLIGHT_LP855X=3Dm=0A# CONFIG_BACKLIGHT_GPIO is not set=0A# CONFIG_BA=
CKLIGHT_LV5207LP is not set=0A# CONFIG_BACKLIGHT_BD6107 is not set=0A# CONF=
IG_BACKLIGHT_ARCXCNN is not set=0A# end of Backlight & LCD device support=
=0A=0ACONFIG_HDMI=3Dy=0A=0A#=0A# Console display driver support=0A#=0ACONFI=
G_VGA_CONSOLE=3Dy=0ACONFIG_DUMMY_CONSOLE=3Dy=0ACONFIG_DUMMY_CONSOLE_COLUMNS=
=3D80=0ACONFIG_DUMMY_CONSOLE_ROWS=3D25=0ACONFIG_FRAMEBUFFER_CONSOLE=3Dy=0AC=
ONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy=0ACONFIG_FRAMEBUFFER_CONSOLE_R=
OTATION=3Dy=0A# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set=0A#=
 end of Console display driver support=0A=0ACONFIG_LOGO=3Dy=0A# CONFIG_LOGO=
_LINUX_MONO is not set=0A# CONFIG_LOGO_LINUX_VGA16 is not set=0ACONFIG_LOGO=
_LINUX_CLUT224=3Dy=0A# end of Graphics support=0A=0A# CONFIG_SOUND is not s=
et=0A=0A#=0A# HID support=0A#=0ACONFIG_HID=3Dy=0ACONFIG_HID_BATTERY_STRENGT=
H=3Dy=0ACONFIG_HIDRAW=3Dy=0ACONFIG_UHID=3Dm=0ACONFIG_HID_GENERIC=3Dy=0A=0A#=
=0A# Special HID drivers=0A#=0ACONFIG_HID_A4TECH=3Dm=0A# CONFIG_HID_ACCUTOU=
CH is not set=0ACONFIG_HID_ACRUX=3Dm=0A# CONFIG_HID_ACRUX_FF is not set=0AC=
ONFIG_HID_APPLE=3Dm=0A# CONFIG_HID_APPLEIR is not set=0ACONFIG_HID_ASUS=3Dm=
=0ACONFIG_HID_AUREAL=3Dm=0ACONFIG_HID_BELKIN=3Dm=0A# CONFIG_HID_BETOP_FF is=
 not set=0A# CONFIG_HID_BIGBEN_FF is not set=0ACONFIG_HID_CHERRY=3Dm=0ACONF=
IG_HID_CHICONY=3Dm=0A# CONFIG_HID_CORSAIR is not set=0A# CONFIG_HID_COUGAR =
is not set=0A# CONFIG_HID_MACALLY is not set=0ACONFIG_HID_CMEDIA=3Dm=0A# CO=
NFIG_HID_CP2112 is not set=0A# CONFIG_HID_CREATIVE_SB0540 is not set=0ACONF=
IG_HID_CYPRESS=3Dm=0ACONFIG_HID_DRAGONRISE=3Dm=0A# CONFIG_DRAGONRISE_FF is =
not set=0A# CONFIG_HID_EMS_FF is not set=0A# CONFIG_HID_ELAN is not set=0AC=
ONFIG_HID_ELECOM=3Dm=0A# CONFIG_HID_ELO is not set=0ACONFIG_HID_EZKEY=3Dm=
=0A# CONFIG_HID_FT260 is not set=0ACONFIG_HID_GEMBIRD=3Dm=0ACONFIG_HID_GFRM=
=3Dm=0A# CONFIG_HID_GLORIOUS is not set=0A# CONFIG_HID_HOLTEK is not set=0A=
# CONFIG_HID_VIVALDI is not set=0A# CONFIG_HID_GT683R is not set=0ACONFIG_H=
ID_KEYTOUCH=3Dm=0ACONFIG_HID_KYE=3Dm=0A# CONFIG_HID_UCLOGIC is not set=0ACO=
NFIG_HID_WALTOP=3Dm=0A# CONFIG_HID_VIEWSONIC is not set=0ACONFIG_HID_GYRATI=
ON=3Dm=0ACONFIG_HID_ICADE=3Dm=0ACONFIG_HID_ITE=3Dm=0ACONFIG_HID_JABRA=3Dm=
=0ACONFIG_HID_TWINHAN=3Dm=0ACONFIG_HID_KENSINGTON=3Dm=0ACONFIG_HID_LCPOWER=
=3Dm=0ACONFIG_HID_LED=3Dm=0ACONFIG_HID_LENOVO=3Dm=0ACONFIG_HID_LOGITECH=3Dm=
=0ACONFIG_HID_LOGITECH_DJ=3Dm=0ACONFIG_HID_LOGITECH_HIDPP=3Dm=0A# CONFIG_LO=
GITECH_FF is not set=0A# CONFIG_LOGIRUMBLEPAD2_FF is not set=0A# CONFIG_LOG=
IG940_FF is not set=0A# CONFIG_LOGIWHEELS_FF is not set=0ACONFIG_HID_MAGICM=
OUSE=3Dy=0A# CONFIG_HID_MALTRON is not set=0A# CONFIG_HID_MAYFLASH is not s=
et=0A# CONFIG_HID_REDRAGON is not set=0ACONFIG_HID_MICROSOFT=3Dm=0ACONFIG_H=
ID_MONTEREY=3Dm=0ACONFIG_HID_MULTITOUCH=3Dm=0ACONFIG_HID_NTI=3Dm=0A# CONFIG=
_HID_NTRIG is not set=0ACONFIG_HID_ORTEK=3Dm=0ACONFIG_HID_PANTHERLORD=3Dm=
=0A# CONFIG_PANTHERLORD_FF is not set=0A# CONFIG_HID_PENMOUNT is not set=0A=
CONFIG_HID_PETALYNX=3Dm=0ACONFIG_HID_PICOLCD=3Dm=0ACONFIG_HID_PICOLCD_FB=3D=
y=0ACONFIG_HID_PICOLCD_BACKLIGHT=3Dy=0ACONFIG_HID_PICOLCD_LCD=3Dy=0ACONFIG_=
HID_PICOLCD_LEDS=3Dy=0ACONFIG_HID_PICOLCD_CIR=3Dy=0ACONFIG_HID_PLANTRONICS=
=3Dm=0A# CONFIG_HID_PLAYSTATION is not set=0ACONFIG_HID_PRIMAX=3Dm=0A# CONF=
IG_HID_RETRODE is not set=0A# CONFIG_HID_ROCCAT is not set=0ACONFIG_HID_SAI=
TEK=3Dm=0ACONFIG_HID_SAMSUNG=3Dm=0A# CONFIG_HID_SEMITEK is not set=0A# CONF=
IG_HID_SONY is not set=0ACONFIG_HID_SPEEDLINK=3Dm=0A# CONFIG_HID_STEAM is n=
ot set=0ACONFIG_HID_STEELSERIES=3Dm=0ACONFIG_HID_SUNPLUS=3Dm=0ACONFIG_HID_R=
MI=3Dm=0ACONFIG_HID_GREENASIA=3Dm=0A# CONFIG_GREENASIA_FF is not set=0ACONF=
IG_HID_HYPERV_MOUSE=3Dm=0ACONFIG_HID_SMARTJOYPLUS=3Dm=0A# CONFIG_SMARTJOYPL=
US_FF is not set=0ACONFIG_HID_TIVO=3Dm=0ACONFIG_HID_TOPSEED=3Dm=0ACONFIG_HI=
D_THINGM=3Dm=0ACONFIG_HID_THRUSTMASTER=3Dm=0A# CONFIG_THRUSTMASTER_FF is no=
t set=0A# CONFIG_HID_UDRAW_PS3 is not set=0A# CONFIG_HID_U2FZERO is not set=
=0A# CONFIG_HID_WACOM is not set=0ACONFIG_HID_WIIMOTE=3Dm=0ACONFIG_HID_XINM=
O=3Dm=0ACONFIG_HID_ZEROPLUS=3Dm=0A# CONFIG_ZEROPLUS_FF is not set=0ACONFIG_=
HID_ZYDACRON=3Dm=0ACONFIG_HID_SENSOR_HUB=3Dy=0ACONFIG_HID_SENSOR_CUSTOM_SEN=
SOR=3Dm=0ACONFIG_HID_ALPS=3Dm=0A# CONFIG_HID_MCP2221 is not set=0A# end of =
Special HID drivers=0A=0A#=0A# USB HID support=0A#=0ACONFIG_USB_HID=3Dy=0A#=
 CONFIG_HID_PID is not set=0A# CONFIG_USB_HIDDEV is not set=0A# end of USB =
HID support=0A=0A#=0A# I2C HID support=0A#=0A# CONFIG_I2C_HID_ACPI is not s=
et=0A# end of I2C HID support=0A=0A#=0A# Intel ISH HID support=0A#=0ACONFIG=
_INTEL_ISH_HID=3Dm=0A# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set=0A# =
end of Intel ISH HID support=0A=0A#=0A# AMD SFH HID Support=0A#=0A# CONFIG_=
AMD_SFH_HID is not set=0A# end of AMD SFH HID Support=0A# end of HID suppor=
t=0A=0ACONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy=0ACONFIG_USB_SUPPORT=3Dy=0ACONFIG_=
USB_COMMON=3Dy=0A# CONFIG_USB_LED_TRIG is not set=0A# CONFIG_USB_ULPI_BUS i=
s not set=0A# CONFIG_USB_CONN_GPIO is not set=0ACONFIG_USB_ARCH_HAS_HCD=3Dy=
=0ACONFIG_USB=3Dy=0ACONFIG_USB_PCI=3Dy=0ACONFIG_USB_ANNOUNCE_NEW_DEVICES=3D=
y=0A=0A#=0A# Miscellaneous USB options=0A#=0ACONFIG_USB_DEFAULT_PERSIST=3Dy=
=0A# CONFIG_USB_FEW_INIT_RETRIES is not set=0A# CONFIG_USB_DYNAMIC_MINORS i=
s not set=0A# CONFIG_USB_OTG is not set=0A# CONFIG_USB_OTG_PRODUCTLIST is n=
ot set=0ACONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy=0ACONFIG_USB_AUTOSUSPEND_DELAY=
=3D2=0ACONFIG_USB_MON=3Dy=0A=0A#=0A# USB Host Controller Drivers=0A#=0A# CO=
NFIG_USB_C67X00_HCD is not set=0ACONFIG_USB_XHCI_HCD=3Dy=0A# CONFIG_USB_XHC=
I_DBGCAP is not set=0ACONFIG_USB_XHCI_PCI=3Dy=0A# CONFIG_USB_XHCI_PCI_RENES=
AS is not set=0A# CONFIG_USB_XHCI_PLATFORM is not set=0ACONFIG_USB_EHCI_HCD=
=3Dy=0ACONFIG_USB_EHCI_ROOT_HUB_TT=3Dy=0ACONFIG_USB_EHCI_TT_NEWSCHED=3Dy=0A=
CONFIG_USB_EHCI_PCI=3Dy=0A# CONFIG_USB_EHCI_FSL is not set=0A# CONFIG_USB_E=
HCI_HCD_PLATFORM is not set=0A# CONFIG_USB_OXU210HP_HCD is not set=0A# CONF=
IG_USB_ISP116X_HCD is not set=0A# CONFIG_USB_FOTG210_HCD is not set=0A# CON=
FIG_USB_MAX3421_HCD is not set=0ACONFIG_USB_OHCI_HCD=3Dy=0ACONFIG_USB_OHCI_=
HCD_PCI=3Dy=0A# CONFIG_USB_OHCI_HCD_PLATFORM is not set=0ACONFIG_USB_UHCI_H=
CD=3Dy=0A# CONFIG_USB_SL811_HCD is not set=0A# CONFIG_USB_R8A66597_HCD is n=
ot set=0A# CONFIG_USB_HCD_BCMA is not set=0A# CONFIG_USB_HCD_TEST_MODE is n=
ot set=0A=0A#=0A# USB Device Class drivers=0A#=0A# CONFIG_USB_ACM is not se=
t=0A# CONFIG_USB_PRINTER is not set=0A# CONFIG_USB_WDM is not set=0A# CONFI=
G_USB_TMC is not set=0A=0A#=0A# NOTE: USB_STORAGE depends on SCSI but BLK_D=
EV_SD may=0A#=0A=0A#=0A# also be needed; see USB_STORAGE Help for more info=
=0A#=0ACONFIG_USB_STORAGE=3Dm=0A# CONFIG_USB_STORAGE_DEBUG is not set=0A# C=
ONFIG_USB_STORAGE_REALTEK is not set=0A# CONFIG_USB_STORAGE_DATAFAB is not =
set=0A# CONFIG_USB_STORAGE_FREECOM is not set=0A# CONFIG_USB_STORAGE_ISD200=
 is not set=0A# CONFIG_USB_STORAGE_USBAT is not set=0A# CONFIG_USB_STORAGE_=
SDDR09 is not set=0A# CONFIG_USB_STORAGE_SDDR55 is not set=0A# CONFIG_USB_S=
TORAGE_JUMPSHOT is not set=0A# CONFIG_USB_STORAGE_ALAUDA is not set=0A# CON=
FIG_USB_STORAGE_ONETOUCH is not set=0A# CONFIG_USB_STORAGE_KARMA is not set=
=0A# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set=0A# CONFIG_USB_STORAGE_ENE=
_UB6250 is not set=0A# CONFIG_USB_UAS is not set=0A=0A#=0A# USB Imaging dev=
ices=0A#=0A# CONFIG_USB_MDC800 is not set=0A# CONFIG_USB_MICROTEK is not se=
t=0A# CONFIG_USBIP_CORE is not set=0A# CONFIG_USB_CDNS_SUPPORT is not set=
=0A# CONFIG_USB_MUSB_HDRC is not set=0A# CONFIG_USB_DWC3 is not set=0A# CON=
FIG_USB_DWC2 is not set=0A# CONFIG_USB_CHIPIDEA is not set=0A# CONFIG_USB_I=
SP1760 is not set=0A=0A#=0A# USB port drivers=0A#=0A# CONFIG_USB_USS720 is =
not set=0ACONFIG_USB_SERIAL=3Dm=0ACONFIG_USB_SERIAL_GENERIC=3Dy=0A# CONFIG_=
USB_SERIAL_SIMPLE is not set=0A# CONFIG_USB_SERIAL_AIRCABLE is not set=0A# =
CONFIG_USB_SERIAL_ARK3116 is not set=0A# CONFIG_USB_SERIAL_BELKIN is not se=
t=0A# CONFIG_USB_SERIAL_CH341 is not set=0A# CONFIG_USB_SERIAL_WHITEHEAT is=
 not set=0A# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set=0A# CONFIG_USB_SE=
RIAL_CP210X is not set=0A# CONFIG_USB_SERIAL_CYPRESS_M8 is not set=0A# CONF=
IG_USB_SERIAL_EMPEG is not set=0A# CONFIG_USB_SERIAL_FTDI_SIO is not set=0A=
# CONFIG_USB_SERIAL_VISOR is not set=0A# CONFIG_USB_SERIAL_IPAQ is not set=
=0A# CONFIG_USB_SERIAL_IR is not set=0A# CONFIG_USB_SERIAL_EDGEPORT is not =
set=0A# CONFIG_USB_SERIAL_EDGEPORT_TI is not set=0A# CONFIG_USB_SERIAL_F812=
32 is not set=0A# CONFIG_USB_SERIAL_F8153X is not set=0A# CONFIG_USB_SERIAL=
_GARMIN is not set=0A# CONFIG_USB_SERIAL_IPW is not set=0A# CONFIG_USB_SERI=
AL_IUU is not set=0A# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set=0A# CONFIG_U=
SB_SERIAL_KEYSPAN is not set=0A# CONFIG_USB_SERIAL_KLSI is not set=0A# CONF=
IG_USB_SERIAL_KOBIL_SCT is not set=0A# CONFIG_USB_SERIAL_MCT_U232 is not se=
t=0A# CONFIG_USB_SERIAL_METRO is not set=0A# CONFIG_USB_SERIAL_MOS7720 is n=
ot set=0A# CONFIG_USB_SERIAL_MOS7840 is not set=0A# CONFIG_USB_SERIAL_MXUPO=
RT is not set=0A# CONFIG_USB_SERIAL_NAVMAN is not set=0A# CONFIG_USB_SERIAL=
_PL2303 is not set=0A# CONFIG_USB_SERIAL_OTI6858 is not set=0A# CONFIG_USB_=
SERIAL_QCAUX is not set=0A# CONFIG_USB_SERIAL_QUALCOMM is not set=0A# CONFI=
G_USB_SERIAL_SPCP8X5 is not set=0A# CONFIG_USB_SERIAL_SAFE is not set=0A# C=
ONFIG_USB_SERIAL_SIERRAWIRELESS is not set=0A# CONFIG_USB_SERIAL_SYMBOL is =
not set=0A# CONFIG_USB_SERIAL_TI is not set=0A# CONFIG_USB_SERIAL_CYBERJACK=
 is not set=0A# CONFIG_USB_SERIAL_OPTION is not set=0A# CONFIG_USB_SERIAL_O=
MNINET is not set=0A# CONFIG_USB_SERIAL_OPTICON is not set=0A# CONFIG_USB_S=
ERIAL_XSENS_MT is not set=0A# CONFIG_USB_SERIAL_WISHBONE is not set=0A# CON=
FIG_USB_SERIAL_SSU100 is not set=0A# CONFIG_USB_SERIAL_QT2 is not set=0A# C=
ONFIG_USB_SERIAL_UPD78F0730 is not set=0A# CONFIG_USB_SERIAL_XR is not set=
=0ACONFIG_USB_SERIAL_DEBUG=3Dm=0A=0A#=0A# USB Miscellaneous drivers=0A#=0A#=
 CONFIG_USB_EMI62 is not set=0A# CONFIG_USB_EMI26 is not set=0A# CONFIG_USB=
_ADUTUX is not set=0A# CONFIG_USB_SEVSEG is not set=0A# CONFIG_USB_LEGOTOWE=
R is not set=0A# CONFIG_USB_LCD is not set=0A# CONFIG_USB_CYPRESS_CY7C63 is=
 not set=0A# CONFIG_USB_CYTHERM is not set=0A# CONFIG_USB_IDMOUSE is not se=
t=0A# CONFIG_USB_FTDI_ELAN is not set=0A# CONFIG_USB_APPLEDISPLAY is not se=
t=0A# CONFIG_APPLE_MFI_FASTCHARGE is not set=0A# CONFIG_USB_SISUSBVGA is no=
t set=0A# CONFIG_USB_LD is not set=0A# CONFIG_USB_TRANCEVIBRATOR is not set=
=0A# CONFIG_USB_IOWARRIOR is not set=0A# CONFIG_USB_TEST is not set=0A# CON=
FIG_USB_EHSET_TEST_FIXTURE is not set=0A# CONFIG_USB_ISIGHTFW is not set=0A=
# CONFIG_USB_YUREX is not set=0A# CONFIG_USB_EZUSB_FX2 is not set=0A# CONFI=
G_USB_HUB_USB251XB is not set=0A# CONFIG_USB_HSIC_USB3503 is not set=0A# CO=
NFIG_USB_HSIC_USB4604 is not set=0A# CONFIG_USB_LINK_LAYER_TEST is not set=
=0A# CONFIG_USB_CHAOSKEY is not set=0A# CONFIG_USB_ATM is not set=0A=0A#=0A=
# USB Physical Layer drivers=0A#=0A# CONFIG_NOP_USB_XCEIV is not set=0A# CO=
NFIG_USB_GPIO_VBUS is not set=0A# CONFIG_USB_ISP1301 is not set=0A# end of =
USB Physical Layer drivers=0A=0A# CONFIG_USB_GADGET is not set=0ACONFIG_TYP=
EC=3Dy=0A# CONFIG_TYPEC_TCPM is not set=0ACONFIG_TYPEC_UCSI=3Dy=0A# CONFIG_=
UCSI_CCG is not set=0ACONFIG_UCSI_ACPI=3Dy=0A# CONFIG_TYPEC_TPS6598X is not=
 set=0A# CONFIG_TYPEC_STUSB160X is not set=0A=0A#=0A# USB Type-C Multiplexe=
r/DeMultiplexer Switch support=0A#=0A# CONFIG_TYPEC_MUX_PI3USB30532 is not =
set=0A# end of USB Type-C Multiplexer/DeMultiplexer Switch support=0A=0A#=
=0A# USB Type-C Alternate Mode drivers=0A#=0A# CONFIG_TYPEC_DP_ALTMODE is n=
ot set=0A# end of USB Type-C Alternate Mode drivers=0A=0A# CONFIG_USB_ROLE_=
SWITCH is not set=0ACONFIG_MMC=3Dm=0ACONFIG_MMC_BLOCK=3Dm=0ACONFIG_MMC_BLOC=
K_MINORS=3D8=0ACONFIG_SDIO_UART=3Dm=0A# CONFIG_MMC_TEST is not set=0A=0A#=
=0A# MMC/SD/SDIO Host Controller Drivers=0A#=0A# CONFIG_MMC_DEBUG is not se=
t=0ACONFIG_MMC_SDHCI=3Dm=0ACONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy=0ACONFIG_MMC_S=
DHCI_PCI=3Dm=0ACONFIG_MMC_RICOH_MMC=3Dy=0ACONFIG_MMC_SDHCI_ACPI=3Dm=0ACONFI=
G_MMC_SDHCI_PLTFM=3Dm=0A# CONFIG_MMC_SDHCI_F_SDH30 is not set=0A# CONFIG_MM=
C_WBSD is not set=0A# CONFIG_MMC_TIFM_SD is not set=0A# CONFIG_MMC_SPI is n=
ot set=0A# CONFIG_MMC_CB710 is not set=0A# CONFIG_MMC_VIA_SDMMC is not set=
=0A# CONFIG_MMC_VUB300 is not set=0A# CONFIG_MMC_USHC is not set=0A# CONFIG=
_MMC_USDHI6ROL0 is not set=0A# CONFIG_MMC_REALTEK_PCI is not set=0ACONFIG_M=
MC_CQHCI=3Dm=0A# CONFIG_MMC_HSQ is not set=0A# CONFIG_MMC_TOSHIBA_PCI is no=
t set=0A# CONFIG_MMC_MTK is not set=0A# CONFIG_MMC_SDHCI_XENON is not set=
=0A# CONFIG_MEMSTICK is not set=0ACONFIG_NEW_LEDS=3Dy=0ACONFIG_LEDS_CLASS=
=3Dy=0A# CONFIG_LEDS_CLASS_FLASH is not set=0A# CONFIG_LEDS_CLASS_MULTICOLO=
R is not set=0A# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set=0A=0A#=0A# LE=
D drivers=0A#=0A# CONFIG_LEDS_APU is not set=0ACONFIG_LEDS_LM3530=3Dm=0A# C=
ONFIG_LEDS_LM3532 is not set=0A# CONFIG_LEDS_LM3642 is not set=0A# CONFIG_L=
EDS_PCA9532 is not set=0A# CONFIG_LEDS_GPIO is not set=0ACONFIG_LEDS_LP3944=
=3Dm=0A# CONFIG_LEDS_LP3952 is not set=0A# CONFIG_LEDS_LP50XX is not set=0A=
CONFIG_LEDS_CLEVO_MAIL=3Dm=0A# CONFIG_LEDS_PCA955X is not set=0A# CONFIG_LE=
DS_PCA963X is not set=0A# CONFIG_LEDS_DAC124S085 is not set=0A# CONFIG_LEDS=
_PWM is not set=0A# CONFIG_LEDS_BD2802 is not set=0ACONFIG_LEDS_INTEL_SS420=
0=3Dm=0ACONFIG_LEDS_LT3593=3Dm=0A# CONFIG_LEDS_TCA6507 is not set=0A# CONFI=
G_LEDS_TLC591XX is not set=0A# CONFIG_LEDS_LM355x is not set=0A=0A#=0A# LED=
 driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)=
=0A#=0ACONFIG_LEDS_BLINKM=3Dm=0ACONFIG_LEDS_MLXCPLD=3Dm=0A# CONFIG_LEDS_MLX=
REG is not set=0A# CONFIG_LEDS_USER is not set=0A# CONFIG_LEDS_NIC78BX is n=
ot set=0A# CONFIG_LEDS_TI_LMU_COMMON is not set=0A=0A#=0A# Flash and Torch =
LED drivers=0A#=0A=0A#=0A# LED Triggers=0A#=0ACONFIG_LEDS_TRIGGERS=3Dy=0ACO=
NFIG_LEDS_TRIGGER_TIMER=3Dm=0ACONFIG_LEDS_TRIGGER_ONESHOT=3Dm=0A# CONFIG_LE=
DS_TRIGGER_DISK is not set=0ACONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm=0ACONFIG_LED=
S_TRIGGER_BACKLIGHT=3Dm=0A# CONFIG_LEDS_TRIGGER_CPU is not set=0A# CONFIG_L=
EDS_TRIGGER_ACTIVITY is not set=0ACONFIG_LEDS_TRIGGER_GPIO=3Dm=0ACONFIG_LED=
S_TRIGGER_DEFAULT_ON=3Dm=0A=0A#=0A# iptables trigger is under Netfilter con=
fig (LED target)=0A#=0ACONFIG_LEDS_TRIGGER_TRANSIENT=3Dm=0ACONFIG_LEDS_TRIG=
GER_CAMERA=3Dm=0A# CONFIG_LEDS_TRIGGER_PANIC is not set=0A# CONFIG_LEDS_TRI=
GGER_NETDEV is not set=0A# CONFIG_LEDS_TRIGGER_PATTERN is not set=0ACONFIG_=
LEDS_TRIGGER_AUDIO=3Dm=0A# CONFIG_LEDS_TRIGGER_TTY is not set=0A# CONFIG_AC=
CESSIBILITY is not set=0ACONFIG_INFINIBAND=3Dm=0ACONFIG_INFINIBAND_USER_MAD=
=3Dm=0ACONFIG_INFINIBAND_USER_ACCESS=3Dm=0ACONFIG_INFINIBAND_USER_MEM=3Dy=
=0ACONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy=0ACONFIG_INFINIBAND_ADDR_TRANS=3D=
y=0ACONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy=0ACONFIG_INFINIBAND_VIRT_DMA=
=3Dy=0A# CONFIG_INFINIBAND_MTHCA is not set=0A# CONFIG_INFINIBAND_EFA is no=
t set=0A# CONFIG_MLX4_INFINIBAND is not set=0A# CONFIG_INFINIBAND_OCRDMA is=
 not set=0A# CONFIG_INFINIBAND_USNIC is not set=0A# CONFIG_INFINIBAND_RDMAV=
T is not set=0ACONFIG_RDMA_RXE=3Dm=0ACONFIG_RDMA_SIW=3Dm=0ACONFIG_INFINIBAN=
D_IPOIB=3Dm=0A# CONFIG_INFINIBAND_IPOIB_CM is not set=0ACONFIG_INFINIBAND_I=
POIB_DEBUG=3Dy=0A# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set=0ACONFIG_I=
NFINIBAND_SRP=3Dm=0ACONFIG_INFINIBAND_SRPT=3Dm=0A# CONFIG_INFINIBAND_ISER i=
s not set=0A# CONFIG_INFINIBAND_ISERT is not set=0A# CONFIG_INFINIBAND_RTRS=
_CLIENT is not set=0A# CONFIG_INFINIBAND_RTRS_SERVER is not set=0A# CONFIG_=
INFINIBAND_OPA_VNIC is not set=0ACONFIG_EDAC_ATOMIC_SCRUB=3Dy=0ACONFIG_EDAC=
_SUPPORT=3Dy=0ACONFIG_EDAC=3Dy=0ACONFIG_EDAC_LEGACY_SYSFS=3Dy=0A# CONFIG_ED=
AC_DEBUG is not set=0ACONFIG_EDAC_DECODE_MCE=3Dm=0ACONFIG_EDAC_GHES=3Dy=0AC=
ONFIG_EDAC_AMD64=3Dm=0ACONFIG_EDAC_E752X=3Dm=0ACONFIG_EDAC_I82975X=3Dm=0ACO=
NFIG_EDAC_I3000=3Dm=0ACONFIG_EDAC_I3200=3Dm=0ACONFIG_EDAC_IE31200=3Dm=0ACON=
FIG_EDAC_X38=3Dm=0ACONFIG_EDAC_I5400=3Dm=0ACONFIG_EDAC_I7CORE=3Dm=0ACONFIG_=
EDAC_I5000=3Dm=0ACONFIG_EDAC_I5100=3Dm=0ACONFIG_EDAC_I7300=3Dm=0ACONFIG_EDA=
C_SBRIDGE=3Dm=0ACONFIG_EDAC_SKX=3Dm=0A# CONFIG_EDAC_I10NM is not set=0ACONF=
IG_EDAC_PND2=3Dm=0A# CONFIG_EDAC_IGEN6 is not set=0ACONFIG_RTC_LIB=3Dy=0ACO=
NFIG_RTC_MC146818_LIB=3Dy=0ACONFIG_RTC_CLASS=3Dy=0ACONFIG_RTC_HCTOSYS=3Dy=
=0ACONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"=0A# CONFIG_RTC_SYSTOHC is not set=0A#=
 CONFIG_RTC_DEBUG is not set=0ACONFIG_RTC_LIB_KUNIT_TEST=3Dm=0ACONFIG_RTC_N=
VMEM=3Dy=0A=0A#=0A# RTC interfaces=0A#=0ACONFIG_RTC_INTF_SYSFS=3Dy=0ACONFIG=
_RTC_INTF_PROC=3Dy=0ACONFIG_RTC_INTF_DEV=3Dy=0A# CONFIG_RTC_INTF_DEV_UIE_EM=
UL is not set=0A# CONFIG_RTC_DRV_TEST is not set=0A=0A#=0A# I2C RTC drivers=
=0A#=0A# CONFIG_RTC_DRV_ABB5ZES3 is not set=0A# CONFIG_RTC_DRV_ABEOZ9 is no=
t set=0A# CONFIG_RTC_DRV_ABX80X is not set=0ACONFIG_RTC_DRV_DS1307=3Dm=0A# =
CONFIG_RTC_DRV_DS1307_CENTURY is not set=0ACONFIG_RTC_DRV_DS1374=3Dm=0A# CO=
NFIG_RTC_DRV_DS1374_WDT is not set=0ACONFIG_RTC_DRV_DS1672=3Dm=0ACONFIG_RTC=
_DRV_MAX6900=3Dm=0ACONFIG_RTC_DRV_RS5C372=3Dm=0ACONFIG_RTC_DRV_ISL1208=3Dm=
=0ACONFIG_RTC_DRV_ISL12022=3Dm=0ACONFIG_RTC_DRV_X1205=3Dm=0ACONFIG_RTC_DRV_=
PCF8523=3Dm=0A# CONFIG_RTC_DRV_PCF85063 is not set=0A# CONFIG_RTC_DRV_PCF85=
363 is not set=0ACONFIG_RTC_DRV_PCF8563=3Dm=0ACONFIG_RTC_DRV_PCF8583=3Dm=0A=
CONFIG_RTC_DRV_M41T80=3Dm=0ACONFIG_RTC_DRV_M41T80_WDT=3Dy=0ACONFIG_RTC_DRV_=
BQ32K=3Dm=0A# CONFIG_RTC_DRV_S35390A is not set=0ACONFIG_RTC_DRV_FM3130=3Dm=
=0A# CONFIG_RTC_DRV_RX8010 is not set=0ACONFIG_RTC_DRV_RX8581=3Dm=0ACONFIG_=
RTC_DRV_RX8025=3Dm=0ACONFIG_RTC_DRV_EM3027=3Dm=0A# CONFIG_RTC_DRV_RV3028 is=
 not set=0A# CONFIG_RTC_DRV_RV3032 is not set=0A# CONFIG_RTC_DRV_RV8803 is =
not set=0A# CONFIG_RTC_DRV_SD3078 is not set=0A=0A#=0A# SPI RTC drivers=0A#=
=0A# CONFIG_RTC_DRV_M41T93 is not set=0A# CONFIG_RTC_DRV_M41T94 is not set=
=0A# CONFIG_RTC_DRV_DS1302 is not set=0A# CONFIG_RTC_DRV_DS1305 is not set=
=0A# CONFIG_RTC_DRV_DS1343 is not set=0A# CONFIG_RTC_DRV_DS1347 is not set=
=0A# CONFIG_RTC_DRV_DS1390 is not set=0A# CONFIG_RTC_DRV_MAX6916 is not set=
=0A# CONFIG_RTC_DRV_R9701 is not set=0ACONFIG_RTC_DRV_RX4581=3Dm=0A# CONFIG=
_RTC_DRV_RS5C348 is not set=0A# CONFIG_RTC_DRV_MAX6902 is not set=0A# CONFI=
G_RTC_DRV_PCF2123 is not set=0A# CONFIG_RTC_DRV_MCP795 is not set=0ACONFIG_=
RTC_I2C_AND_SPI=3Dy=0A=0A#=0A# SPI and I2C RTC drivers=0A#=0ACONFIG_RTC_DRV=
_DS3232=3Dm=0ACONFIG_RTC_DRV_DS3232_HWMON=3Dy=0A# CONFIG_RTC_DRV_PCF2127 is=
 not set=0ACONFIG_RTC_DRV_RV3029C2=3Dm=0A# CONFIG_RTC_DRV_RV3029_HWMON is n=
ot set=0A# CONFIG_RTC_DRV_RX6110 is not set=0A=0A#=0A# Platform RTC drivers=
=0A#=0ACONFIG_RTC_DRV_CMOS=3Dy=0ACONFIG_RTC_DRV_DS1286=3Dm=0ACONFIG_RTC_DRV=
_DS1511=3Dm=0ACONFIG_RTC_DRV_DS1553=3Dm=0A# CONFIG_RTC_DRV_DS1685_FAMILY is=
 not set=0ACONFIG_RTC_DRV_DS1742=3Dm=0ACONFIG_RTC_DRV_DS2404=3Dm=0ACONFIG_R=
TC_DRV_STK17TA8=3Dm=0A# CONFIG_RTC_DRV_M48T86 is not set=0ACONFIG_RTC_DRV_M=
48T35=3Dm=0ACONFIG_RTC_DRV_M48T59=3Dm=0ACONFIG_RTC_DRV_MSM6242=3Dm=0ACONFIG=
_RTC_DRV_BQ4802=3Dm=0ACONFIG_RTC_DRV_RP5C01=3Dm=0ACONFIG_RTC_DRV_V3020=3Dm=
=0A=0A#=0A# on-CPU RTC drivers=0A#=0A# CONFIG_RTC_DRV_FTRTC010 is not set=
=0A=0A#=0A# HID Sensor RTC drivers=0A#=0A# CONFIG_RTC_DRV_GOLDFISH is not s=
et=0ACONFIG_DMADEVICES=3Dy=0A# CONFIG_DMADEVICES_DEBUG is not set=0A=0A#=0A=
# DMA Devices=0A#=0ACONFIG_DMA_ENGINE=3Dy=0ACONFIG_DMA_VIRTUAL_CHANNELS=3Dy=
=0ACONFIG_DMA_ACPI=3Dy=0A# CONFIG_ALTERA_MSGDMA is not set=0ACONFIG_INTEL_I=
DMA64=3Dm=0A# CONFIG_INTEL_IDXD is not set=0A# CONFIG_INTEL_IDXD_COMPAT is =
not set=0ACONFIG_INTEL_IOATDMA=3Dm=0A# CONFIG_PLX_DMA is not set=0A# CONFIG=
_AMD_PTDMA is not set=0A# CONFIG_QCOM_HIDMA_MGMT is not set=0A# CONFIG_QCOM=
_HIDMA is not set=0ACONFIG_DW_DMAC_CORE=3Dy=0ACONFIG_DW_DMAC=3Dm=0ACONFIG_D=
W_DMAC_PCI=3Dy=0A# CONFIG_DW_EDMA is not set=0A# CONFIG_DW_EDMA_PCIE is not=
 set=0ACONFIG_HSU_DMA=3Dy=0A# CONFIG_SF_PDMA is not set=0A# CONFIG_INTEL_LD=
MA is not set=0A=0A#=0A# DMA Clients=0A#=0ACONFIG_ASYNC_TX_DMA=3Dy=0ACONFIG=
_DMATEST=3Dm=0ACONFIG_DMA_ENGINE_RAID=3Dy=0A=0A#=0A# DMABUF options=0A#=0AC=
ONFIG_SYNC_FILE=3Dy=0A# CONFIG_SW_SYNC is not set=0A# CONFIG_UDMABUF is not=
 set=0A# CONFIG_DMABUF_MOVE_NOTIFY is not set=0A# CONFIG_DMABUF_DEBUG is no=
t set=0A# CONFIG_DMABUF_SELFTESTS is not set=0A# CONFIG_DMABUF_HEAPS is not=
 set=0A# CONFIG_DMABUF_SYSFS_STATS is not set=0A# end of DMABUF options=0A=
=0ACONFIG_DCA=3Dm=0A# CONFIG_AUXDISPLAY is not set=0A# CONFIG_PANEL is not =
set=0ACONFIG_UIO=3Dm=0ACONFIG_UIO_CIF=3Dm=0ACONFIG_UIO_PDRV_GENIRQ=3Dm=0A# =
CONFIG_UIO_DMEM_GENIRQ is not set=0ACONFIG_UIO_AEC=3Dm=0ACONFIG_UIO_SERCOS3=
=3Dm=0ACONFIG_UIO_PCI_GENERIC=3Dm=0A# CONFIG_UIO_NETX is not set=0A# CONFIG=
_UIO_PRUSS is not set=0A# CONFIG_UIO_MF624 is not set=0ACONFIG_UIO_HV_GENER=
IC=3Dm=0ACONFIG_VFIO=3Dm=0ACONFIG_VFIO_IOMMU_TYPE1=3Dm=0ACONFIG_VFIO_VIRQFD=
=3Dm=0ACONFIG_VFIO_NOIOMMU=3Dy=0ACONFIG_VFIO_PCI_CORE=3Dm=0ACONFIG_VFIO_PCI=
_MMAP=3Dy=0ACONFIG_VFIO_PCI_INTX=3Dy=0ACONFIG_VFIO_PCI=3Dm=0A# CONFIG_VFIO_=
PCI_VGA is not set=0A# CONFIG_VFIO_PCI_IGD is not set=0ACONFIG_VFIO_MDEV=3D=
m=0ACONFIG_IRQ_BYPASS_MANAGER=3Dm=0A# CONFIG_VIRT_DRIVERS is not set=0ACONF=
IG_VIRTIO=3Dy=0ACONFIG_VIRTIO_PCI_LIB=3Dy=0ACONFIG_VIRTIO_MENU=3Dy=0ACONFIG=
_VIRTIO_PCI=3Dy=0ACONFIG_VIRTIO_PCI_LEGACY=3Dy=0A# CONFIG_VIRTIO_PMEM is no=
t set=0ACONFIG_VIRTIO_BALLOON=3Dm=0ACONFIG_VIRTIO_MEM=3Dm=0ACONFIG_VIRTIO_I=
NPUT=3Dm=0A# CONFIG_VIRTIO_MMIO is not set=0ACONFIG_VIRTIO_DMA_SHARED_BUFFE=
R=3Dm=0A# CONFIG_VDPA is not set=0ACONFIG_VHOST_IOTLB=3Dm=0ACONFIG_VHOST=3D=
m=0ACONFIG_VHOST_MENU=3Dy=0ACONFIG_VHOST_NET=3Dm=0A# CONFIG_VHOST_SCSI is n=
ot set=0ACONFIG_VHOST_VSOCK=3Dm=0A# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not=
 set=0A=0A#=0A# Microsoft Hyper-V guest support=0A#=0ACONFIG_HYPERV=3Dm=0AC=
ONFIG_HYPERV_TIMER=3Dy=0ACONFIG_HYPERV_UTILS=3Dm=0ACONFIG_HYPERV_BALLOON=3D=
m=0A# end of Microsoft Hyper-V guest support=0A=0A# CONFIG_GREYBUS is not s=
et=0A# CONFIG_COMEDI is not set=0A# CONFIG_STAGING is not set=0ACONFIG_X86_=
PLATFORM_DEVICES=3Dy=0ACONFIG_ACPI_WMI=3Dm=0ACONFIG_WMI_BMOF=3Dm=0A# CONFIG=
_HUAWEI_WMI is not set=0A# CONFIG_UV_SYSFS is not set=0ACONFIG_MXM_WMI=3Dm=
=0A# CONFIG_PEAQ_WMI is not set=0A# CONFIG_XIAOMI_WMI is not set=0A# CONFIG=
_GIGABYTE_WMI is not set=0ACONFIG_ACERHDF=3Dm=0A# CONFIG_ACER_WIRELESS is n=
ot set=0ACONFIG_ACER_WMI=3Dm=0A# CONFIG_AMD_PMC is not set=0A# CONFIG_ADV_S=
WBUTTON is not set=0ACONFIG_APPLE_GMUX=3Dm=0ACONFIG_ASUS_LAPTOP=3Dm=0A# CON=
FIG_ASUS_WIRELESS is not set=0ACONFIG_ASUS_WMI=3Dm=0ACONFIG_ASUS_NB_WMI=3Dm=
=0A# CONFIG_MERAKI_MX100 is not set=0ACONFIG_EEEPC_LAPTOP=3Dm=0ACONFIG_EEEP=
C_WMI=3Dm=0A# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set=0ACONFIG_AMILO_RF=
KILL=3Dm=0ACONFIG_FUJITSU_LAPTOP=3Dm=0ACONFIG_FUJITSU_TABLET=3Dm=0A# CONFIG=
_GPD_POCKET_FAN is not set=0ACONFIG_HP_ACCEL=3Dm=0A# CONFIG_WIRELESS_HOTKEY=
 is not set=0ACONFIG_HP_WMI=3Dm=0A# CONFIG_IBM_RTL is not set=0ACONFIG_IDEA=
PAD_LAPTOP=3Dm=0ACONFIG_SENSORS_HDAPS=3Dm=0ACONFIG_THINKPAD_ACPI=3Dm=0A# CO=
NFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set=0A# CONFIG_THINKPAD_ACPI_DEBU=
G is not set=0A# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set=0ACONFIG_THINK=
PAD_ACPI_VIDEO=3Dy=0ACONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy=0A# CONFIG_THINKP=
AD_LMI is not set=0ACONFIG_X86_PLATFORM_DRIVERS_INTEL=3Dy=0A# CONFIG_INTEL_=
ATOMISP2_PM is not set=0A# CONFIG_INTEL_SAR_INT1092 is not set=0ACONFIG_INT=
EL_PMC_CORE=3Dm=0A=0A#=0A# Intel Speed Select Technology interface support=
=0A#=0A# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set=0A# end of Intel Sp=
eed Select Technology interface support=0A=0ACONFIG_INTEL_WMI=3Dy=0A# CONFI=
G_INTEL_WMI_SBL_FW_UPDATE is not set=0ACONFIG_INTEL_WMI_THUNDERBOLT=3Dm=0AC=
ONFIG_INTEL_HID_EVENT=3Dm=0ACONFIG_INTEL_VBTN=3Dm=0A# CONFIG_INTEL_INT0002_=
VGPIO is not set=0ACONFIG_INTEL_OAKTRAIL=3Dm=0A# CONFIG_INTEL_PUNIT_IPC is =
not set=0ACONFIG_INTEL_RST=3Dm=0A# CONFIG_INTEL_SMARTCONNECT is not set=0AC=
ONFIG_INTEL_TURBO_MAX_3=3Dy=0A# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set=
=0ACONFIG_MSI_LAPTOP=3Dm=0ACONFIG_MSI_WMI=3Dm=0A# CONFIG_PCENGINES_APU2 is =
not set=0ACONFIG_SAMSUNG_LAPTOP=3Dm=0ACONFIG_SAMSUNG_Q10=3Dm=0ACONFIG_TOSHI=
BA_BT_RFKILL=3Dm=0A# CONFIG_TOSHIBA_HAPS is not set=0A# CONFIG_TOSHIBA_WMI =
is not set=0ACONFIG_ACPI_CMPC=3Dm=0ACONFIG_COMPAL_LAPTOP=3Dm=0A# CONFIG_LG_=
LAPTOP is not set=0ACONFIG_PANASONIC_LAPTOP=3Dm=0ACONFIG_SONY_LAPTOP=3Dm=0A=
CONFIG_SONYPI_COMPAT=3Dy=0A# CONFIG_SYSTEM76_ACPI is not set=0ACONFIG_TOPST=
AR_LAPTOP=3Dm=0A# CONFIG_I2C_MULTI_INSTANTIATE is not set=0ACONFIG_MLX_PLAT=
FORM=3Dm=0ACONFIG_INTEL_IPS=3Dm=0A# CONFIG_INTEL_SCU_PCI is not set=0A# CON=
FIG_INTEL_SCU_PLATFORM is not set=0ACONFIG_PMC_ATOM=3Dy=0A# CONFIG_CHROME_P=
LATFORMS is not set=0ACONFIG_MELLANOX_PLATFORM=3Dy=0ACONFIG_MLXREG_HOTPLUG=
=3Dm=0A# CONFIG_MLXREG_IO is not set=0ACONFIG_SURFACE_PLATFORMS=3Dy=0A# CON=
FIG_SURFACE3_WMI is not set=0A# CONFIG_SURFACE_3_POWER_OPREGION is not set=
=0A# CONFIG_SURFACE_GPE is not set=0A# CONFIG_SURFACE_HOTPLUG is not set=0A=
# CONFIG_SURFACE_PRO3_BUTTON is not set=0ACONFIG_HAVE_CLK=3Dy=0ACONFIG_HAVE=
_CLK_PREPARE=3Dy=0ACONFIG_COMMON_CLK=3Dy=0A=0A#=0A# Clock driver for ARM Re=
ference designs=0A#=0A# CONFIG_ICST is not set=0A# CONFIG_CLK_SP810 is not =
set=0A# end of Clock driver for ARM Reference designs=0A=0A# CONFIG_LMK0483=
2 is not set=0A# CONFIG_COMMON_CLK_MAX9485 is not set=0A# CONFIG_COMMON_CLK=
_SI5341 is not set=0A# CONFIG_COMMON_CLK_SI5351 is not set=0A# CONFIG_COMMO=
N_CLK_SI544 is not set=0A# CONFIG_COMMON_CLK_CDCE706 is not set=0A# CONFIG_=
COMMON_CLK_CS2000_CP is not set=0A# CONFIG_COMMON_CLK_PWM is not set=0A# CO=
NFIG_XILINX_VCU is not set=0ACONFIG_HWSPINLOCK=3Dy=0A=0A#=0A# Clock Source =
drivers=0A#=0ACONFIG_CLKEVT_I8253=3Dy=0ACONFIG_I8253_LOCK=3Dy=0ACONFIG_CLKB=
LD_I8253=3Dy=0A# end of Clock Source drivers=0A=0ACONFIG_MAILBOX=3Dy=0ACONF=
IG_PCC=3Dy=0A# CONFIG_ALTERA_MBOX is not set=0ACONFIG_IOMMU_IOVA=3Dy=0ACONF=
IG_IOASID=3Dy=0ACONFIG_IOMMU_API=3Dy=0ACONFIG_IOMMU_SUPPORT=3Dy=0A=0A#=0A# =
Generic IOMMU Pagetable Support=0A#=0A# end of Generic IOMMU Pagetable Supp=
ort=0A=0A# CONFIG_IOMMU_DEBUGFS is not set=0A# CONFIG_IOMMU_DEFAULT_DMA_STR=
ICT is not set=0ACONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy=0A# CONFIG_IOMMU_DEFAULT=
_PASSTHROUGH is not set=0ACONFIG_IOMMU_DMA=3Dy=0A# CONFIG_AMD_IOMMU is not =
set=0ACONFIG_DMAR_TABLE=3Dy=0ACONFIG_INTEL_IOMMU=3Dy=0A# CONFIG_INTEL_IOMMU=
_SVM is not set=0A# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set=0ACONFIG_INTEL=
_IOMMU_FLOPPY_WA=3Dy=0ACONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy=0ACO=
NFIG_IRQ_REMAP=3Dy=0ACONFIG_HYPERV_IOMMU=3Dy=0A# CONFIG_VIRTIO_IOMMU is not=
 set=0A=0A#=0A# Remoteproc drivers=0A#=0A# CONFIG_REMOTEPROC is not set=0A#=
 end of Remoteproc drivers=0A=0A#=0A# Rpmsg drivers=0A#=0A# CONFIG_RPMSG_QC=
OM_GLINK_RPM is not set=0A# CONFIG_RPMSG_VIRTIO is not set=0A# end of Rpmsg=
 drivers=0A=0A# CONFIG_SOUNDWIRE is not set=0A=0A#=0A# SOC (System On Chip)=
 specific Drivers=0A#=0A=0A#=0A# Amlogic SoC drivers=0A#=0A# end of Amlogic=
 SoC drivers=0A=0A#=0A# Broadcom SoC drivers=0A#=0A# end of Broadcom SoC dr=
ivers=0A=0A#=0A# NXP/Freescale QorIQ SoC drivers=0A#=0A# end of NXP/Freesca=
le QorIQ SoC drivers=0A=0A#=0A# i.MX SoC drivers=0A#=0A# end of i.MX SoC dr=
ivers=0A=0A#=0A# Enable LiteX SoC Builder specific drivers=0A#=0A# end of E=
nable LiteX SoC Builder specific drivers=0A=0A#=0A# Qualcomm SoC drivers=0A=
#=0A# end of Qualcomm SoC drivers=0A=0A# CONFIG_SOC_TI is not set=0A=0A#=0A=
# Xilinx SoC drivers=0A#=0A# end of Xilinx SoC drivers=0A# end of SOC (Syst=
em On Chip) specific Drivers=0A=0A# CONFIG_PM_DEVFREQ is not set=0A# CONFIG=
_EXTCON is not set=0A# CONFIG_MEMORY is not set=0A# CONFIG_IIO is not set=
=0ACONFIG_NTB=3Dm=0A# CONFIG_NTB_MSI is not set=0A# CONFIG_NTB_AMD is not s=
et=0A# CONFIG_NTB_IDT is not set=0A# CONFIG_NTB_INTEL is not set=0A# CONFIG=
_NTB_EPF is not set=0A# CONFIG_NTB_SWITCHTEC is not set=0A# CONFIG_NTB_PING=
PONG is not set=0A# CONFIG_NTB_TOOL is not set=0A# CONFIG_NTB_PERF is not s=
et=0A# CONFIG_NTB_TRANSPORT is not set=0A# CONFIG_VME_BUS is not set=0ACONF=
IG_PWM=3Dy=0ACONFIG_PWM_SYSFS=3Dy=0A# CONFIG_PWM_DEBUG is not set=0A# CONFI=
G_PWM_DWC is not set=0ACONFIG_PWM_LPSS=3Dm=0ACONFIG_PWM_LPSS_PCI=3Dm=0ACONF=
IG_PWM_LPSS_PLATFORM=3Dm=0A# CONFIG_PWM_PCA9685 is not set=0A=0A#=0A# IRQ c=
hip support=0A#=0A# end of IRQ chip support=0A=0A# CONFIG_IPACK_BUS is not =
set=0A# CONFIG_RESET_CONTROLLER is not set=0A=0A#=0A# PHY Subsystem=0A#=0A#=
 CONFIG_GENERIC_PHY is not set=0A# CONFIG_USB_LGM_PHY is not set=0A# CONFIG=
_PHY_CAN_TRANSCEIVER is not set=0A# CONFIG_BCM_KONA_USB2_PHY is not set=0A#=
 CONFIG_PHY_PXA_28NM_HSIC is not set=0A# CONFIG_PHY_PXA_28NM_USB2 is not se=
t=0A# CONFIG_PHY_INTEL_LGM_EMMC is not set=0A# end of PHY Subsystem=0A=0ACO=
NFIG_POWERCAP=3Dy=0ACONFIG_INTEL_RAPL_CORE=3Dm=0ACONFIG_INTEL_RAPL=3Dm=0A# =
CONFIG_IDLE_INJECT is not set=0A# CONFIG_DTPM is not set=0A# CONFIG_MCB is =
not set=0A=0A#=0A# Performance monitor support=0A#=0A# end of Performance m=
onitor support=0A=0ACONFIG_RAS=3Dy=0A# CONFIG_RAS_CEC is not set=0A# CONFIG=
_USB4 is not set=0A=0A#=0A# Android=0A#=0A# CONFIG_ANDROID is not set=0A# e=
nd of Android=0A=0ACONFIG_LIBNVDIMM=3Dm=0ACONFIG_BLK_DEV_PMEM=3Dm=0ACONFIG_=
ND_BLK=3Dm=0ACONFIG_ND_CLAIM=3Dy=0ACONFIG_ND_BTT=3Dm=0ACONFIG_BTT=3Dy=0ACON=
FIG_ND_PFN=3Dm=0ACONFIG_NVDIMM_PFN=3Dy=0ACONFIG_NVDIMM_DAX=3Dy=0ACONFIG_NVD=
IMM_KEYS=3Dy=0ACONFIG_DAX_DRIVER=3Dy=0ACONFIG_DAX=3Dy=0ACONFIG_DEV_DAX=3Dm=
=0ACONFIG_DEV_DAX_PMEM=3Dm=0ACONFIG_DEV_DAX_KMEM=3Dm=0ACONFIG_DEV_DAX_PMEM_=
COMPAT=3Dm=0ACONFIG_NVMEM=3Dy=0ACONFIG_NVMEM_SYSFS=3Dy=0A# CONFIG_NVMEM_RME=
M is not set=0A=0A#=0A# HW tracing support=0A#=0ACONFIG_STM=3Dm=0A# CONFIG_=
STM_PROTO_BASIC is not set=0A# CONFIG_STM_PROTO_SYS_T is not set=0ACONFIG_S=
TM_DUMMY=3Dm=0ACONFIG_STM_SOURCE_CONSOLE=3Dm=0ACONFIG_STM_SOURCE_HEARTBEAT=
=3Dm=0ACONFIG_STM_SOURCE_FTRACE=3Dm=0ACONFIG_INTEL_TH=3Dm=0ACONFIG_INTEL_TH=
_PCI=3Dm=0ACONFIG_INTEL_TH_ACPI=3Dm=0ACONFIG_INTEL_TH_GTH=3Dm=0ACONFIG_INTE=
L_TH_STH=3Dm=0ACONFIG_INTEL_TH_MSU=3Dm=0ACONFIG_INTEL_TH_PTI=3Dm=0A# CONFIG=
_INTEL_TH_DEBUG is not set=0A# end of HW tracing support=0A=0A# CONFIG_FPGA=
 is not set=0A# CONFIG_TEE is not set=0A# CONFIG_UNISYS_VISORBUS is not set=
=0A# CONFIG_SIOX is not set=0A# CONFIG_SLIMBUS is not set=0A# CONFIG_INTERC=
ONNECT is not set=0A# CONFIG_COUNTER is not set=0A# CONFIG_MOST is not set=
=0A# end of Device Drivers=0A=0A#=0A# File systems=0A#=0ACONFIG_DCACHE_WORD=
_ACCESS=3Dy=0A# CONFIG_VALIDATE_FS_PARSER is not set=0ACONFIG_FS_IOMAP=3Dy=
=0ACONFIG_EXT2_FS=3Dm=0ACONFIG_EXT2_FS_XATTR=3Dy=0ACONFIG_EXT2_FS_POSIX_ACL=
=3Dy=0ACONFIG_EXT2_FS_SECURITY=3Dy=0A# CONFIG_EXT3_FS is not set=0ACONFIG_E=
XT4_FS=3Dy=0ACONFIG_EXT4_FS_POSIX_ACL=3Dy=0ACONFIG_EXT4_FS_SECURITY=3Dy=0A#=
 CONFIG_EXT4_DEBUG is not set=0ACONFIG_EXT4_KUNIT_TESTS=3Dm=0ACONFIG_JBD2=
=3Dy=0A# CONFIG_JBD2_DEBUG is not set=0ACONFIG_FS_MBCACHE=3Dy=0A# CONFIG_RE=
ISERFS_FS is not set=0A# CONFIG_JFS_FS is not set=0ACONFIG_XFS_FS=3Dm=0ACON=
FIG_XFS_SUPPORT_V4=3Dy=0ACONFIG_XFS_QUOTA=3Dy=0ACONFIG_XFS_POSIX_ACL=3Dy=0A=
CONFIG_XFS_RT=3Dy=0ACONFIG_XFS_ONLINE_SCRUB=3Dy=0ACONFIG_XFS_ONLINE_REPAIR=
=3Dy=0ACONFIG_XFS_DEBUG=3Dy=0ACONFIG_XFS_ASSERT_FATAL=3Dy=0ACONFIG_GFS2_FS=
=3Dm=0ACONFIG_GFS2_FS_LOCKING_DLM=3Dy=0ACONFIG_OCFS2_FS=3Dm=0ACONFIG_OCFS2_=
FS_O2CB=3Dm=0ACONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm=0ACONFIG_OCFS2_FS_STATS=
=3Dy=0ACONFIG_OCFS2_DEBUG_MASKLOG=3Dy=0A# CONFIG_OCFS2_DEBUG_FS is not set=
=0ACONFIG_BTRFS_FS=3Dm=0ACONFIG_BTRFS_FS_POSIX_ACL=3Dy=0A# CONFIG_BTRFS_FS_=
CHECK_INTEGRITY is not set=0A# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set=
=0A# CONFIG_BTRFS_DEBUG is not set=0A# CONFIG_BTRFS_ASSERT is not set=0A# C=
ONFIG_BTRFS_FS_REF_VERIFY is not set=0A# CONFIG_NILFS2_FS is not set=0ACONF=
IG_F2FS_FS=3Dm=0ACONFIG_F2FS_STAT_FS=3Dy=0ACONFIG_F2FS_FS_XATTR=3Dy=0ACONFI=
G_F2FS_FS_POSIX_ACL=3Dy=0ACONFIG_F2FS_FS_SECURITY=3Dy=0A# CONFIG_F2FS_CHECK=
_FS is not set=0A# CONFIG_F2FS_FAULT_INJECTION is not set=0A# CONFIG_F2FS_F=
S_COMPRESSION is not set=0ACONFIG_F2FS_IOSTAT=3Dy=0A# CONFIG_ZONEFS_FS is n=
ot set=0ACONFIG_FS_DAX=3Dy=0ACONFIG_FS_DAX_PMD=3Dy=0ACONFIG_FS_POSIX_ACL=3D=
y=0ACONFIG_EXPORTFS=3Dy=0ACONFIG_EXPORTFS_BLOCK_OPS=3Dy=0ACONFIG_FILE_LOCKI=
NG=3Dy=0ACONFIG_FS_ENCRYPTION=3Dy=0ACONFIG_FS_ENCRYPTION_ALGS=3Dy=0A# CONFI=
G_FS_VERITY is not set=0ACONFIG_FSNOTIFY=3Dy=0ACONFIG_DNOTIFY=3Dy=0ACONFIG_=
INOTIFY_USER=3Dy=0ACONFIG_FANOTIFY=3Dy=0ACONFIG_FANOTIFY_ACCESS_PERMISSIONS=
=3Dy=0ACONFIG_QUOTA=3Dy=0ACONFIG_QUOTA_NETLINK_INTERFACE=3Dy=0ACONFIG_PRINT=
_QUOTA_WARNING=3Dy=0A# CONFIG_QUOTA_DEBUG is not set=0ACONFIG_QUOTA_TREE=3D=
y=0A# CONFIG_QFMT_V1 is not set=0ACONFIG_QFMT_V2=3Dy=0ACONFIG_QUOTACTL=3Dy=
=0ACONFIG_AUTOFS4_FS=3Dy=0ACONFIG_AUTOFS_FS=3Dy=0ACONFIG_FUSE_FS=3Dm=0ACONF=
IG_CUSE=3Dm=0A# CONFIG_VIRTIO_FS is not set=0ACONFIG_OVERLAY_FS=3Dm=0A# CON=
FIG_OVERLAY_FS_REDIRECT_DIR is not set=0A# CONFIG_OVERLAY_FS_REDIRECT_ALWAY=
S_FOLLOW is not set=0A# CONFIG_OVERLAY_FS_INDEX is not set=0A# CONFIG_OVERL=
AY_FS_XINO_AUTO is not set=0A# CONFIG_OVERLAY_FS_METACOPY is not set=0A=0A#=
=0A# Caches=0A#=0ACONFIG_NETFS_SUPPORT=3Dm=0ACONFIG_NETFS_STATS=3Dy=0ACONFI=
G_FSCACHE=3Dm=0ACONFIG_FSCACHE_STATS=3Dy=0A# CONFIG_FSCACHE_DEBUG is not se=
t=0ACONFIG_CACHEFILES=3Dm=0A# CONFIG_CACHEFILES_DEBUG is not set=0A# end of=
 Caches=0A=0A#=0A# CD-ROM/DVD Filesystems=0A#=0ACONFIG_ISO9660_FS=3Dm=0ACON=
FIG_JOLIET=3Dy=0ACONFIG_ZISOFS=3Dy=0ACONFIG_UDF_FS=3Dm=0A# end of CD-ROM/DV=
D Filesystems=0A=0A#=0A# DOS/FAT/EXFAT/NT Filesystems=0A#=0ACONFIG_FAT_FS=
=3Dm=0ACONFIG_MSDOS_FS=3Dm=0ACONFIG_VFAT_FS=3Dm=0ACONFIG_FAT_DEFAULT_CODEPA=
GE=3D437=0ACONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"=0A# CONFIG_FAT_DEFAULT_UT=
F8 is not set=0ACONFIG_FAT_KUNIT_TEST=3Dm=0A# CONFIG_EXFAT_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A# CONFIG_NTFS3_FS is not set=0A# end of DOS/F=
AT/EXFAT/NT Filesystems=0A=0A#=0A# Pseudo filesystems=0A#=0ACONFIG_PROC_FS=
=3Dy=0ACONFIG_PROC_KCORE=3Dy=0ACONFIG_PROC_VMCORE=3Dy=0ACONFIG_PROC_VMCORE_=
DEVICE_DUMP=3Dy=0ACONFIG_PROC_SYSCTL=3Dy=0ACONFIG_PROC_PAGE_MONITOR=3Dy=0AC=
ONFIG_PROC_CHILDREN=3Dy=0ACONFIG_PROC_PID_ARCH_STATUS=3Dy=0ACONFIG_KERNFS=
=3Dy=0ACONFIG_SYSFS=3Dy=0ACONFIG_TMPFS=3Dy=0ACONFIG_TMPFS_POSIX_ACL=3Dy=0AC=
ONFIG_TMPFS_XATTR=3Dy=0A# CONFIG_TMPFS_INODE64 is not set=0ACONFIG_HUGETLBF=
S=3Dy=0ACONFIG_HUGETLB_PAGE=3Dy=0ACONFIG_HUGETLB_PAGE_FREE_VMEMMAP=3Dy=0A# =
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set=0ACONFIG_MEMFD_CREAT=
E=3Dy=0ACONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy=0ACONFIG_CONFIGFS_FS=3Dy=0ACONFIG=
_EFIVAR_FS=3Dy=0A# end of Pseudo filesystems=0A=0ACONFIG_MISC_FILESYSTEMS=
=3Dy=0A# CONFIG_ORANGEFS_FS is not set=0A# CONFIG_ADFS_FS is not set=0A# CO=
NFIG_AFFS_FS is not set=0A# CONFIG_ECRYPT_FS is not set=0A# CONFIG_HFS_FS i=
s not set=0A# CONFIG_HFSPLUS_FS is not set=0A# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A# CONFIG_EFS_FS is not set=0ACONFIG_CRAMFS=3Dm=
=0ACONFIG_CRAMFS_BLOCKDEV=3Dy=0ACONFIG_SQUASHFS=3Dm=0A# CONFIG_SQUASHFS_FIL=
E_CACHE is not set=0ACONFIG_SQUASHFS_FILE_DIRECT=3Dy=0A# CONFIG_SQUASHFS_DE=
COMP_SINGLE is not set=0A# CONFIG_SQUASHFS_DECOMP_MULTI is not set=0ACONFIG=
_SQUASHFS_DECOMP_MULTI_PERCPU=3Dy=0ACONFIG_SQUASHFS_XATTR=3Dy=0ACONFIG_SQUA=
SHFS_ZLIB=3Dy=0A# CONFIG_SQUASHFS_LZ4 is not set=0ACONFIG_SQUASHFS_LZO=3Dy=
=0ACONFIG_SQUASHFS_XZ=3Dy=0A# CONFIG_SQUASHFS_ZSTD is not set=0A# CONFIG_SQ=
UASHFS_4K_DEVBLK_SIZE is not set=0A# CONFIG_SQUASHFS_EMBEDDED is not set=0A=
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3=0A# CONFIG_VXFS_FS is not set=0ACON=
FIG_MINIX_FS=3Dm=0A# CONFIG_OMFS_FS is not set=0A# CONFIG_HPFS_FS is not se=
t=0A# CONFIG_QNX4FS_FS is not set=0A# CONFIG_QNX6FS_FS is not set=0A# CONFI=
G_ROMFS_FS is not set=0ACONFIG_PSTORE=3Dy=0ACONFIG_PSTORE_DEFAULT_KMSG_BYTE=
S=3D10240=0ACONFIG_PSTORE_DEFLATE_COMPRESS=3Dy=0A# CONFIG_PSTORE_LZO_COMPRE=
SS is not set=0A# CONFIG_PSTORE_LZ4_COMPRESS is not set=0A# CONFIG_PSTORE_L=
Z4HC_COMPRESS is not set=0A# CONFIG_PSTORE_842_COMPRESS is not set=0A# CONF=
IG_PSTORE_ZSTD_COMPRESS is not set=0ACONFIG_PSTORE_COMPRESS=3Dy=0ACONFIG_PS=
TORE_DEFLATE_COMPRESS_DEFAULT=3Dy=0ACONFIG_PSTORE_COMPRESS_DEFAULT=3D"defla=
te"=0A# CONFIG_PSTORE_CONSOLE is not set=0A# CONFIG_PSTORE_PMSG is not set=
=0A# CONFIG_PSTORE_FTRACE is not set=0ACONFIG_PSTORE_RAM=3Dm=0A# CONFIG_SYS=
V_FS is not set=0A# CONFIG_UFS_FS is not set=0A# CONFIG_EROFS_FS is not set=
=0ACONFIG_NETWORK_FILESYSTEMS=3Dy=0ACONFIG_NFS_FS=3Dy=0A# CONFIG_NFS_V2 is =
not set=0ACONFIG_NFS_V3=3Dy=0ACONFIG_NFS_V3_ACL=3Dy=0ACONFIG_NFS_V4=3Dm=0A#=
 CONFIG_NFS_SWAP is not set=0ACONFIG_NFS_V4_1=3Dy=0ACONFIG_NFS_V4_2=3Dy=0AC=
ONFIG_PNFS_FILE_LAYOUT=3Dm=0ACONFIG_PNFS_BLOCK=3Dm=0ACONFIG_PNFS_FLEXFILE_L=
AYOUT=3Dm=0ACONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"=0A# CON=
FIG_NFS_V4_1_MIGRATION is not set=0ACONFIG_NFS_V4_SECURITY_LABEL=3Dy=0ACONF=
IG_ROOT_NFS=3Dy=0A# CONFIG_NFS_USE_LEGACY_DNS is not set=0ACONFIG_NFS_USE_K=
ERNEL_DNS=3Dy=0ACONFIG_NFS_DEBUG=3Dy=0ACONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy=
=0A# CONFIG_NFS_V4_2_READ_PLUS is not set=0ACONFIG_NFSD=3Dm=0ACONFIG_NFSD_V=
2_ACL=3Dy=0ACONFIG_NFSD_V3=3Dy=0ACONFIG_NFSD_V3_ACL=3Dy=0ACONFIG_NFSD_V4=3D=
y=0ACONFIG_NFSD_PNFS=3Dy=0A# CONFIG_NFSD_BLOCKLAYOUT is not set=0ACONFIG_NF=
SD_SCSILAYOUT=3Dy=0A# CONFIG_NFSD_FLEXFILELAYOUT is not set=0A# CONFIG_NFSD=
_V4_2_INTER_SSC is not set=0ACONFIG_NFSD_V4_SECURITY_LABEL=3Dy=0ACONFIG_GRA=
CE_PERIOD=3Dy=0ACONFIG_LOCKD=3Dy=0ACONFIG_LOCKD_V4=3Dy=0ACONFIG_NFS_ACL_SUP=
PORT=3Dy=0ACONFIG_NFS_COMMON=3Dy=0ACONFIG_NFS_V4_2_SSC_HELPER=3Dy=0ACONFIG_=
SUNRPC=3Dy=0ACONFIG_SUNRPC_GSS=3Dm=0ACONFIG_SUNRPC_BACKCHANNEL=3Dy=0ACONFIG=
_RPCSEC_GSS_KRB5=3Dm=0A# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set=
=0ACONFIG_SUNRPC_DEBUG=3Dy=0ACONFIG_SUNRPC_XPRT_RDMA=3Dm=0ACONFIG_CEPH_FS=
=3Dm=0A# CONFIG_CEPH_FSCACHE is not set=0ACONFIG_CEPH_FS_POSIX_ACL=3Dy=0A# =
CONFIG_CEPH_FS_SECURITY_LABEL is not set=0ACONFIG_CIFS=3Dm=0ACONFIG_CIFS_ST=
ATS2=3Dy=0ACONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy=0ACONFIG_CIFS_UPCALL=3Dy=
=0ACONFIG_CIFS_XATTR=3Dy=0ACONFIG_CIFS_POSIX=3Dy=0ACONFIG_CIFS_DEBUG=3Dy=0A=
# CONFIG_CIFS_DEBUG2 is not set=0A# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set=
=0ACONFIG_CIFS_DFS_UPCALL=3Dy=0A# CONFIG_CIFS_SWN_UPCALL is not set=0A# CON=
FIG_CIFS_SMB_DIRECT is not set=0A# CONFIG_CIFS_FSCACHE is not set=0A# CONFI=
G_SMB_SERVER is not set=0ACONFIG_SMBFS_COMMON=3Dm=0A# CONFIG_CODA_FS is not=
 set=0A# CONFIG_AFS_FS is not set=0ACONFIG_9P_FS=3Dy=0ACONFIG_9P_FS_POSIX_A=
CL=3Dy=0A# CONFIG_9P_FS_SECURITY is not set=0ACONFIG_NLS=3Dy=0ACONFIG_NLS_D=
EFAULT=3D"utf8"=0ACONFIG_NLS_CODEPAGE_437=3Dy=0ACONFIG_NLS_CODEPAGE_737=3Dm=
=0ACONFIG_NLS_CODEPAGE_775=3Dm=0ACONFIG_NLS_CODEPAGE_850=3Dm=0ACONFIG_NLS_C=
ODEPAGE_852=3Dm=0ACONFIG_NLS_CODEPAGE_855=3Dm=0ACONFIG_NLS_CODEPAGE_857=3Dm=
=0ACONFIG_NLS_CODEPAGE_860=3Dm=0ACONFIG_NLS_CODEPAGE_861=3Dm=0ACONFIG_NLS_C=
ODEPAGE_862=3Dm=0ACONFIG_NLS_CODEPAGE_863=3Dm=0ACONFIG_NLS_CODEPAGE_864=3Dm=
=0ACONFIG_NLS_CODEPAGE_865=3Dm=0ACONFIG_NLS_CODEPAGE_866=3Dm=0ACONFIG_NLS_C=
ODEPAGE_869=3Dm=0ACONFIG_NLS_CODEPAGE_936=3Dm=0ACONFIG_NLS_CODEPAGE_950=3Dm=
=0ACONFIG_NLS_CODEPAGE_932=3Dm=0ACONFIG_NLS_CODEPAGE_949=3Dm=0ACONFIG_NLS_C=
ODEPAGE_874=3Dm=0ACONFIG_NLS_ISO8859_8=3Dm=0ACONFIG_NLS_CODEPAGE_1250=3Dm=
=0ACONFIG_NLS_CODEPAGE_1251=3Dm=0ACONFIG_NLS_ASCII=3Dy=0ACONFIG_NLS_ISO8859=
_1=3Dm=0ACONFIG_NLS_ISO8859_2=3Dm=0ACONFIG_NLS_ISO8859_3=3Dm=0ACONFIG_NLS_I=
SO8859_4=3Dm=0ACONFIG_NLS_ISO8859_5=3Dm=0ACONFIG_NLS_ISO8859_6=3Dm=0ACONFIG=
_NLS_ISO8859_7=3Dm=0ACONFIG_NLS_ISO8859_9=3Dm=0ACONFIG_NLS_ISO8859_13=3Dm=
=0ACONFIG_NLS_ISO8859_14=3Dm=0ACONFIG_NLS_ISO8859_15=3Dm=0ACONFIG_NLS_KOI8_=
R=3Dm=0ACONFIG_NLS_KOI8_U=3Dm=0ACONFIG_NLS_MAC_ROMAN=3Dm=0ACONFIG_NLS_MAC_C=
ELTIC=3Dm=0ACONFIG_NLS_MAC_CENTEURO=3Dm=0ACONFIG_NLS_MAC_CROATIAN=3Dm=0ACON=
FIG_NLS_MAC_CYRILLIC=3Dm=0ACONFIG_NLS_MAC_GAELIC=3Dm=0ACONFIG_NLS_MAC_GREEK=
=3Dm=0ACONFIG_NLS_MAC_ICELAND=3Dm=0ACONFIG_NLS_MAC_INUIT=3Dm=0ACONFIG_NLS_M=
AC_ROMANIAN=3Dm=0ACONFIG_NLS_MAC_TURKISH=3Dm=0ACONFIG_NLS_UTF8=3Dm=0ACONFIG=
_DLM=3Dm=0ACONFIG_DLM_DEBUG=3Dy=0A# CONFIG_UNICODE is not set=0ACONFIG_IO_W=
Q=3Dy=0A# end of File systems=0A=0A#=0A# Security options=0A#=0ACONFIG_KEYS=
=3Dy=0A# CONFIG_KEYS_REQUEST_CACHE is not set=0ACONFIG_PERSISTENT_KEYRINGS=
=3Dy=0ACONFIG_TRUSTED_KEYS=3Dy=0ACONFIG_ENCRYPTED_KEYS=3Dy=0A# CONFIG_KEY_D=
H_OPERATIONS is not set=0A# CONFIG_SECURITY_DMESG_RESTRICT is not set=0ACON=
FIG_SECURITY=3Dy=0ACONFIG_SECURITY_WRITABLE_HOOKS=3Dy=0ACONFIG_SECURITYFS=
=3Dy=0ACONFIG_SECURITY_NETWORK=3Dy=0ACONFIG_PAGE_TABLE_ISOLATION=3Dy=0A# CO=
NFIG_SECURITY_INFINIBAND is not set=0ACONFIG_SECURITY_NETWORK_XFRM=3Dy=0ACO=
NFIG_SECURITY_PATH=3Dy=0ACONFIG_INTEL_TXT=3Dy=0ACONFIG_LSM_MMAP_MIN_ADDR=3D=
65535=0ACONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy=0ACONFIG_HARDENED_USERC=
OPY=3Dy=0ACONFIG_HARDENED_USERCOPY_FALLBACK=3Dy=0ACONFIG_FORTIFY_SOURCE=3Dy=
=0A# CONFIG_STATIC_USERMODEHELPER is not set=0ACONFIG_SECURITY_SELINUX=3Dy=
=0ACONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy=0ACONFIG_SECURITY_SELINUX_DISABLE=
=3Dy=0ACONFIG_SECURITY_SELINUX_DEVELOP=3Dy=0ACONFIG_SECURITY_SELINUX_AVC_ST=
ATS=3Dy=0ACONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1=0ACONFIG_SECURITY_=
SELINUX_SIDTAB_HASH_BITS=3D9=0ACONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=
=3D256=0A# CONFIG_SECURITY_SMACK is not set=0A# CONFIG_SECURITY_TOMOYO is n=
ot set=0ACONFIG_SECURITY_APPARMOR=3Dy=0ACONFIG_SECURITY_APPARMOR_HASH=3Dy=
=0ACONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy=0A# CONFIG_SECURITY_APPARMOR_D=
EBUG is not set=0ACONFIG_SECURITY_APPARMOR_KUNIT_TEST=3Dy=0A# CONFIG_SECURI=
TY_LOADPIN is not set=0ACONFIG_SECURITY_YAMA=3Dy=0A# CONFIG_SECURITY_SAFESE=
TID is not set=0A# CONFIG_SECURITY_LOCKDOWN_LSM is not set=0A# CONFIG_SECUR=
ITY_LANDLOCK is not set=0ACONFIG_INTEGRITY=3Dy=0ACONFIG_INTEGRITY_SIGNATURE=
=3Dy=0ACONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy=0ACONFIG_INTEGRITY_TRUSTED_KEYR=
ING=3Dy=0A# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set=0ACONFIG_INTEGRITY=
_AUDIT=3Dy=0ACONFIG_IMA=3Dy=0ACONFIG_IMA_MEASURE_PCR_IDX=3D10=0ACONFIG_IMA_=
LSM_RULES=3Dy=0A# CONFIG_IMA_TEMPLATE is not set=0ACONFIG_IMA_NG_TEMPLATE=
=3Dy=0A# CONFIG_IMA_SIG_TEMPLATE is not set=0ACONFIG_IMA_DEFAULT_TEMPLATE=
=3D"ima-ng"=0ACONFIG_IMA_DEFAULT_HASH_SHA1=3Dy=0A# CONFIG_IMA_DEFAULT_HASH_=
SHA256 is not set=0A# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set=0ACONFIG_IM=
A_DEFAULT_HASH=3D"sha1"=0ACONFIG_IMA_WRITE_POLICY=3Dy=0A# CONFIG_IMA_READ_P=
OLICY is not set=0ACONFIG_IMA_APPRAISE=3Dy=0A# CONFIG_IMA_ARCH_POLICY is no=
t set=0A# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set=0ACONFIG_IMA_APPRAISE=
_BOOTPARAM=3Dy=0A# CONFIG_IMA_APPRAISE_MODSIG is not set=0ACONFIG_IMA_TRUST=
ED_KEYRING=3Dy=0A# CONFIG_IMA_BLACKLIST_KEYRING is not set=0A# CONFIG_IMA_L=
OAD_X509 is not set=0ACONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy=0ACONFIG_IMA_Q=
UEUE_EARLY_BOOT_KEYS=3Dy=0A# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not s=
et=0A# CONFIG_IMA_DISABLE_HTABLE is not set=0ACONFIG_EVM=3Dy=0ACONFIG_EVM_A=
TTR_FSUUID=3Dy=0A# CONFIG_EVM_ADD_XATTRS is not set=0A# CONFIG_EVM_LOAD_X50=
9 is not set=0ACONFIG_DEFAULT_SECURITY_SELINUX=3Dy=0A# CONFIG_DEFAULT_SECUR=
ITY_APPARMOR is not set=0A# CONFIG_DEFAULT_SECURITY_DAC is not set=0ACONFIG=
_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,to=
moyo,apparmor,bpf"=0A=0A#=0A# Kernel hardening options=0A#=0A=0A#=0A# Memor=
y initialization=0A#=0ACONFIG_INIT_STACK_NONE=3Dy=0A# CONFIG_INIT_ON_ALLOC_=
DEFAULT_ON is not set=0A# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set=0A# end=
 of Memory initialization=0A# end of Kernel hardening options=0A# end of Se=
curity options=0A=0ACONFIG_XOR_BLOCKS=3Dm=0ACONFIG_ASYNC_CORE=3Dm=0ACONFIG_=
ASYNC_MEMCPY=3Dm=0ACONFIG_ASYNC_XOR=3Dm=0ACONFIG_ASYNC_PQ=3Dm=0ACONFIG_ASYN=
C_RAID6_RECOV=3Dm=0ACONFIG_CRYPTO=3Dy=0A=0A#=0A# Crypto core or helper=0A#=
=0ACONFIG_CRYPTO_ALGAPI=3Dy=0ACONFIG_CRYPTO_ALGAPI2=3Dy=0ACONFIG_CRYPTO_AEA=
D=3Dy=0ACONFIG_CRYPTO_AEAD2=3Dy=0ACONFIG_CRYPTO_SKCIPHER=3Dy=0ACONFIG_CRYPT=
O_SKCIPHER2=3Dy=0ACONFIG_CRYPTO_HASH=3Dy=0ACONFIG_CRYPTO_HASH2=3Dy=0ACONFIG=
_CRYPTO_RNG=3Dy=0ACONFIG_CRYPTO_RNG2=3Dy=0ACONFIG_CRYPTO_RNG_DEFAULT=3Dy=0A=
CONFIG_CRYPTO_AKCIPHER2=3Dy=0ACONFIG_CRYPTO_AKCIPHER=3Dy=0ACONFIG_CRYPTO_KP=
P2=3Dy=0ACONFIG_CRYPTO_KPP=3Dm=0ACONFIG_CRYPTO_ACOMP2=3Dy=0ACONFIG_CRYPTO_M=
ANAGER=3Dy=0ACONFIG_CRYPTO_MANAGER2=3Dy=0ACONFIG_CRYPTO_USER=3Dm=0ACONFIG_C=
RYPTO_MANAGER_DISABLE_TESTS=3Dy=0ACONFIG_CRYPTO_GF128MUL=3Dy=0ACONFIG_CRYPT=
O_NULL=3Dy=0ACONFIG_CRYPTO_NULL2=3Dy=0ACONFIG_CRYPTO_PCRYPT=3Dm=0ACONFIG_CR=
YPTO_CRYPTD=3Dy=0ACONFIG_CRYPTO_AUTHENC=3Dm=0ACONFIG_CRYPTO_TEST=3Dm=0ACONF=
IG_CRYPTO_SIMD=3Dy=0A=0A#=0A# Public-key cryptography=0A#=0ACONFIG_CRYPTO_R=
SA=3Dy=0ACONFIG_CRYPTO_DH=3Dm=0ACONFIG_CRYPTO_ECC=3Dm=0ACONFIG_CRYPTO_ECDH=
=3Dm=0A# CONFIG_CRYPTO_ECDSA is not set=0A# CONFIG_CRYPTO_ECRDSA is not set=
=0A# CONFIG_CRYPTO_SM2 is not set=0A# CONFIG_CRYPTO_CURVE25519 is not set=
=0A# CONFIG_CRYPTO_CURVE25519_X86 is not set=0A=0A#=0A# Authenticated Encry=
ption with Associated Data=0A#=0ACONFIG_CRYPTO_CCM=3Dm=0ACONFIG_CRYPTO_GCM=
=3Dy=0ACONFIG_CRYPTO_CHACHA20POLY1305=3Dm=0A# CONFIG_CRYPTO_AEGIS128 is not=
 set=0A# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set=0ACONFIG_CRYPTO_SEQIV=
=3Dy=0ACONFIG_CRYPTO_ECHAINIV=3Dm=0A=0A#=0A# Block modes=0A#=0ACONFIG_CRYPT=
O_CBC=3Dy=0ACONFIG_CRYPTO_CFB=3Dy=0ACONFIG_CRYPTO_CTR=3Dy=0ACONFIG_CRYPTO_C=
TS=3Dm=0ACONFIG_CRYPTO_ECB=3Dy=0ACONFIG_CRYPTO_LRW=3Dm=0A# CONFIG_CRYPTO_OF=
B is not set=0ACONFIG_CRYPTO_PCBC=3Dm=0ACONFIG_CRYPTO_XTS=3Dm=0A# CONFIG_CR=
YPTO_KEYWRAP is not set=0A# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set=0A# CO=
NFIG_CRYPTO_NHPOLY1305_AVX2 is not set=0A# CONFIG_CRYPTO_ADIANTUM is not se=
t=0ACONFIG_CRYPTO_ESSIV=3Dm=0A=0A#=0A# Hash modes=0A#=0ACONFIG_CRYPTO_CMAC=
=3Dm=0ACONFIG_CRYPTO_HMAC=3Dy=0ACONFIG_CRYPTO_XCBC=3Dm=0ACONFIG_CRYPTO_VMAC=
=3Dm=0A=0A#=0A# Digest=0A#=0ACONFIG_CRYPTO_CRC32C=3Dy=0ACONFIG_CRYPTO_CRC32=
C_INTEL=3Dm=0ACONFIG_CRYPTO_CRC32=3Dm=0ACONFIG_CRYPTO_CRC32_PCLMUL=3Dm=0ACO=
NFIG_CRYPTO_XXHASH=3Dm=0ACONFIG_CRYPTO_BLAKE2B=3Dm=0A# CONFIG_CRYPTO_BLAKE2=
S is not set=0A# CONFIG_CRYPTO_BLAKE2S_X86 is not set=0ACONFIG_CRYPTO_CRCT1=
0DIF=3Dy=0ACONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm=0ACONFIG_CRYPTO_GHASH=3Dy=0AC=
ONFIG_CRYPTO_POLY1305=3Dm=0ACONFIG_CRYPTO_POLY1305_X86_64=3Dm=0ACONFIG_CRYP=
TO_MD4=3Dm=0ACONFIG_CRYPTO_MD5=3Dy=0ACONFIG_CRYPTO_MICHAEL_MIC=3Dm=0ACONFIG=
_CRYPTO_RMD160=3Dm=0ACONFIG_CRYPTO_SHA1=3Dy=0ACONFIG_CRYPTO_SHA1_SSSE3=3Dy=
=0ACONFIG_CRYPTO_SHA256_SSSE3=3Dy=0ACONFIG_CRYPTO_SHA512_SSSE3=3Dm=0ACONFIG=
_CRYPTO_SHA256=3Dy=0ACONFIG_CRYPTO_SHA512=3Dy=0ACONFIG_CRYPTO_SHA3=3Dm=0A# =
CONFIG_CRYPTO_SM3 is not set=0A# CONFIG_CRYPTO_STREEBOG is not set=0ACONFIG=
_CRYPTO_WP512=3Dm=0ACONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm=0A=0A#=0A# Ciphe=
rs=0A#=0ACONFIG_CRYPTO_AES=3Dy=0A# CONFIG_CRYPTO_AES_TI is not set=0ACONFIG=
_CRYPTO_AES_NI_INTEL=3Dy=0ACONFIG_CRYPTO_ANUBIS=3Dm=0ACONFIG_CRYPTO_ARC4=3D=
m=0ACONFIG_CRYPTO_BLOWFISH=3Dm=0ACONFIG_CRYPTO_BLOWFISH_COMMON=3Dm=0ACONFIG=
_CRYPTO_BLOWFISH_X86_64=3Dm=0ACONFIG_CRYPTO_CAMELLIA=3Dm=0ACONFIG_CRYPTO_CA=
MELLIA_X86_64=3Dm=0ACONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm=0ACONFIG_CR=
YPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm=0ACONFIG_CRYPTO_CAST_COMMON=3Dm=0ACONFI=
G_CRYPTO_CAST5=3Dm=0ACONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm=0ACONFIG_CRYPTO_CAS=
T6=3Dm=0ACONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm=0ACONFIG_CRYPTO_DES=3Dm=0A# CON=
FIG_CRYPTO_DES3_EDE_X86_64 is not set=0ACONFIG_CRYPTO_FCRYPT=3Dm=0ACONFIG_C=
RYPTO_KHAZAD=3Dm=0ACONFIG_CRYPTO_CHACHA20=3Dm=0ACONFIG_CRYPTO_CHACHA20_X86_=
64=3Dm=0ACONFIG_CRYPTO_SEED=3Dm=0ACONFIG_CRYPTO_SERPENT=3Dm=0ACONFIG_CRYPTO=
_SERPENT_SSE2_X86_64=3Dm=0ACONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm=0ACONFIG_CR=
YPTO_SERPENT_AVX2_X86_64=3Dm=0A# CONFIG_CRYPTO_SM4 is not set=0A# CONFIG_CR=
YPTO_SM4_AESNI_AVX_X86_64 is not set=0A# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_6=
4 is not set=0ACONFIG_CRYPTO_TEA=3Dm=0ACONFIG_CRYPTO_TWOFISH=3Dm=0ACONFIG_C=
RYPTO_TWOFISH_COMMON=3Dm=0ACONFIG_CRYPTO_TWOFISH_X86_64=3Dm=0ACONFIG_CRYPTO=
_TWOFISH_X86_64_3WAY=3Dm=0ACONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm=0A=0A#=0A# =
Compression=0A#=0ACONFIG_CRYPTO_DEFLATE=3Dy=0ACONFIG_CRYPTO_LZO=3Dy=0A# CON=
FIG_CRYPTO_842 is not set=0A# CONFIG_CRYPTO_LZ4 is not set=0A# CONFIG_CRYPT=
O_LZ4HC is not set=0A# CONFIG_CRYPTO_ZSTD is not set=0A=0A#=0A# Random Numb=
er Generation=0A#=0ACONFIG_CRYPTO_ANSI_CPRNG=3Dm=0ACONFIG_CRYPTO_DRBG_MENU=
=3Dy=0ACONFIG_CRYPTO_DRBG_HMAC=3Dy=0ACONFIG_CRYPTO_DRBG_HASH=3Dy=0ACONFIG_C=
RYPTO_DRBG_CTR=3Dy=0ACONFIG_CRYPTO_DRBG=3Dy=0ACONFIG_CRYPTO_JITTERENTROPY=
=3Dy=0ACONFIG_CRYPTO_USER_API=3Dy=0ACONFIG_CRYPTO_USER_API_HASH=3Dy=0ACONFI=
G_CRYPTO_USER_API_SKCIPHER=3Dy=0ACONFIG_CRYPTO_USER_API_RNG=3Dy=0A# CONFIG_=
CRYPTO_USER_API_RNG_CAVP is not set=0ACONFIG_CRYPTO_USER_API_AEAD=3Dy=0ACON=
FIG_CRYPTO_USER_API_ENABLE_OBSOLETE=3Dy=0A# CONFIG_CRYPTO_STATS is not set=
=0ACONFIG_CRYPTO_HASH_INFO=3Dy=0A=0A#=0A# Crypto library routines=0A#=0ACON=
FIG_CRYPTO_LIB_AES=3Dy=0ACONFIG_CRYPTO_LIB_ARC4=3Dm=0A# CONFIG_CRYPTO_LIB_B=
LAKE2S is not set=0ACONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm=0ACONFIG_CRYPTO_=
LIB_CHACHA_GENERIC=3Dm=0A# CONFIG_CRYPTO_LIB_CHACHA is not set=0A# CONFIG_C=
RYPTO_LIB_CURVE25519 is not set=0ACONFIG_CRYPTO_LIB_DES=3Dm=0ACONFIG_CRYPTO=
_LIB_POLY1305_RSIZE=3D11=0ACONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dm=0ACONFI=
G_CRYPTO_LIB_POLY1305_GENERIC=3Dm=0A# CONFIG_CRYPTO_LIB_POLY1305 is not set=
=0A# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set=0ACONFIG_CRYPTO_LIB_SHA2=
56=3Dy=0ACONFIG_CRYPTO_HW=3Dy=0ACONFIG_CRYPTO_DEV_PADLOCK=3Dm=0ACONFIG_CRYP=
TO_DEV_PADLOCK_AES=3Dm=0ACONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm=0A# CONFIG_CRYPT=
O_DEV_ATMEL_ECC is not set=0A# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set=
=0ACONFIG_CRYPTO_DEV_CCP=3Dy=0ACONFIG_CRYPTO_DEV_CCP_DD=3Dm=0ACONFIG_CRYPTO=
_DEV_SP_CCP=3Dy=0ACONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm=0ACONFIG_CRYPTO_DEV_SP_P=
SP=3Dy=0A# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set=0ACONFIG_CRYPTO_DEV_QAT=
=3Dm=0ACONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm=0ACONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm=
=0ACONFIG_CRYPTO_DEV_QAT_C62X=3Dm=0A# CONFIG_CRYPTO_DEV_QAT_4XXX is not set=
=0ACONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm=0ACONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm=
=0ACONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm=0ACONFIG_CRYPTO_DEV_NITROX=3Dm=0ACONFIG=
_CRYPTO_DEV_NITROX_CNN55XX=3Dm=0A# CONFIG_CRYPTO_DEV_VIRTIO is not set=0A# =
CONFIG_CRYPTO_DEV_SAFEXCEL is not set=0A# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is =
not set=0ACONFIG_ASYMMETRIC_KEY_TYPE=3Dy=0ACONFIG_ASYMMETRIC_PUBLIC_KEY_SUB=
TYPE=3Dy=0A# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set=0ACONFIG_X509_CER=
TIFICATE_PARSER=3Dy=0A# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set=0ACONFIG=
_PKCS7_MESSAGE_PARSER=3Dy=0A# CONFIG_PKCS7_TEST_KEY is not set=0ACONFIG_SIG=
NED_PE_FILE_VERIFICATION=3Dy=0A=0A#=0A# Certificates for signature checking=
=0A#=0ACONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"=0ACONFIG_MODULE_SIG_=
KEY_TYPE_RSA=3Dy=0A# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set=0ACONFIG_S=
YSTEM_TRUSTED_KEYRING=3Dy=0ACONFIG_SYSTEM_TRUSTED_KEYS=3D""=0A# CONFIG_SYST=
EM_EXTRA_CERTIFICATE is not set=0A# CONFIG_SECONDARY_TRUSTED_KEYRING is not=
 set=0ACONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy=0ACONFIG_SYSTEM_BLACKLIST_HASH_L=
IST=3D""=0A# CONFIG_SYSTEM_REVOCATION_LIST is not set=0A# end of Certificat=
es for signature checking=0A=0ACONFIG_BINARY_PRINTF=3Dy=0A=0A#=0A# Library =
routines=0A#=0ACONFIG_RAID6_PQ=3Dm=0ACONFIG_RAID6_PQ_BENCHMARK=3Dy=0ACONFIG=
_LINEAR_RANGES=3Dm=0A# CONFIG_PACKING is not set=0ACONFIG_BITREVERSE=3Dy=0A=
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy=0ACONFIG_GENERIC_STRNLEN_USER=3Dy=0ACO=
NFIG_GENERIC_NET_UTILS=3Dy=0ACONFIG_GENERIC_FIND_FIRST_BIT=3Dy=0ACONFIG_COR=
DIC=3Dm=0A# CONFIG_PRIME_NUMBERS is not set=0ACONFIG_RATIONAL=3Dy=0ACONFIG_=
GENERIC_PCI_IOMAP=3Dy=0ACONFIG_GENERIC_IOMAP=3Dy=0ACONFIG_ARCH_USE_CMPXCHG_=
LOCKREF=3Dy=0ACONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy=0ACONFIG_ARCH_USE_SYM_ANN=
OTATIONS=3Dy=0ACONFIG_CRC_CCITT=3Dy=0ACONFIG_CRC16=3Dy=0ACONFIG_CRC_T10DIF=
=3Dy=0ACONFIG_CRC_ITU_T=3Dm=0ACONFIG_CRC32=3Dy=0A# CONFIG_CRC32_SELFTEST is=
 not set=0ACONFIG_CRC32_SLICEBY8=3Dy=0A# CONFIG_CRC32_SLICEBY4 is not set=
=0A# CONFIG_CRC32_SARWATE is not set=0A# CONFIG_CRC32_BIT is not set=0A# CO=
NFIG_CRC64 is not set=0A# CONFIG_CRC4 is not set=0ACONFIG_CRC7=3Dm=0ACONFIG=
_LIBCRC32C=3Dm=0ACONFIG_CRC8=3Dm=0ACONFIG_XXHASH=3Dy=0A# CONFIG_RANDOM32_SE=
LFTEST is not set=0ACONFIG_ZLIB_INFLATE=3Dy=0ACONFIG_ZLIB_DEFLATE=3Dy=0ACON=
FIG_LZO_COMPRESS=3Dy=0ACONFIG_LZO_DECOMPRESS=3Dy=0ACONFIG_LZ4_DECOMPRESS=3D=
y=0ACONFIG_ZSTD_COMPRESS=3Dm=0ACONFIG_ZSTD_DECOMPRESS=3Dy=0ACONFIG_XZ_DEC=
=3Dy=0ACONFIG_XZ_DEC_X86=3Dy=0ACONFIG_XZ_DEC_POWERPC=3Dy=0ACONFIG_XZ_DEC_IA=
64=3Dy=0ACONFIG_XZ_DEC_ARM=3Dy=0ACONFIG_XZ_DEC_ARMTHUMB=3Dy=0ACONFIG_XZ_DEC=
_SPARC=3Dy=0ACONFIG_XZ_DEC_BCJ=3Dy=0A# CONFIG_XZ_DEC_TEST is not set=0ACONF=
IG_DECOMPRESS_GZIP=3Dy=0ACONFIG_DECOMPRESS_BZIP2=3Dy=0ACONFIG_DECOMPRESS_LZ=
MA=3Dy=0ACONFIG_DECOMPRESS_XZ=3Dy=0ACONFIG_DECOMPRESS_LZO=3Dy=0ACONFIG_DECO=
MPRESS_LZ4=3Dy=0ACONFIG_DECOMPRESS_ZSTD=3Dy=0ACONFIG_GENERIC_ALLOCATOR=3Dy=
=0ACONFIG_REED_SOLOMON=3Dm=0ACONFIG_REED_SOLOMON_ENC8=3Dy=0ACONFIG_REED_SOL=
OMON_DEC8=3Dy=0ACONFIG_TEXTSEARCH=3Dy=0ACONFIG_TEXTSEARCH_KMP=3Dm=0ACONFIG_=
TEXTSEARCH_BM=3Dm=0ACONFIG_TEXTSEARCH_FSM=3Dm=0ACONFIG_INTERVAL_TREE=3Dy=0A=
CONFIG_XARRAY_MULTI=3Dy=0ACONFIG_ASSOCIATIVE_ARRAY=3Dy=0ACONFIG_HAS_IOMEM=
=3Dy=0ACONFIG_HAS_IOPORT_MAP=3Dy=0ACONFIG_HAS_DMA=3Dy=0ACONFIG_DMA_OPS=3Dy=
=0ACONFIG_NEED_SG_DMA_LENGTH=3Dy=0ACONFIG_NEED_DMA_MAP_STATE=3Dy=0ACONFIG_A=
RCH_DMA_ADDR_T_64BIT=3Dy=0ACONFIG_SWIOTLB=3Dy=0ACONFIG_DMA_CMA=3Dy=0A# CONF=
IG_DMA_PERNUMA_CMA is not set=0A=0A#=0A# Default contiguous memory area siz=
e:=0A#=0ACONFIG_CMA_SIZE_MBYTES=3D0=0ACONFIG_CMA_SIZE_SEL_MBYTES=3Dy=0A# CO=
NFIG_CMA_SIZE_SEL_PERCENTAGE is not set=0A# CONFIG_CMA_SIZE_SEL_MIN is not =
set=0A# CONFIG_CMA_SIZE_SEL_MAX is not set=0ACONFIG_CMA_ALIGNMENT=3D8=0A# C=
ONFIG_DMA_API_DEBUG is not set=0A# CONFIG_DMA_MAP_BENCHMARK is not set=0ACO=
NFIG_SGL_ALLOC=3Dy=0ACONFIG_CHECK_SIGNATURE=3Dy=0ACONFIG_CPUMASK_OFFSTACK=
=3Dy=0ACONFIG_CPU_RMAP=3Dy=0ACONFIG_DQL=3Dy=0ACONFIG_GLOB=3Dy=0A# CONFIG_GL=
OB_SELFTEST is not set=0ACONFIG_NLATTR=3Dy=0ACONFIG_CLZ_TAB=3Dy=0ACONFIG_IR=
Q_POLL=3Dy=0ACONFIG_MPILIB=3Dy=0ACONFIG_SIGNATURE=3Dy=0ACONFIG_DIMLIB=3Dy=
=0ACONFIG_OID_REGISTRY=3Dy=0ACONFIG_UCS2_STRING=3Dy=0ACONFIG_HAVE_GENERIC_V=
DSO=3Dy=0ACONFIG_GENERIC_GETTIMEOFDAY=3Dy=0ACONFIG_GENERIC_VDSO_TIME_NS=3Dy=
=0ACONFIG_FONT_SUPPORT=3Dy=0A# CONFIG_FONTS is not set=0ACONFIG_FONT_8x8=3D=
y=0ACONFIG_FONT_8x16=3Dy=0ACONFIG_SG_POOL=3Dy=0ACONFIG_ARCH_HAS_PMEM_API=3D=
y=0ACONFIG_MEMREGION=3Dy=0ACONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy=0ACONFIG_=
ARCH_HAS_COPY_MC=3Dy=0ACONFIG_ARCH_STACKWALK=3Dy=0ACONFIG_SBITMAP=3Dy=0A# e=
nd of Library routines=0A=0ACONFIG_ASN1_ENCODER=3Dy=0A=0A#=0A# Kernel hacki=
ng=0A#=0A=0A#=0A# printk and dmesg options=0A#=0ACONFIG_PRINTK_TIME=3Dy=0AC=
ONFIG_PRINTK_CALLER=3Dy=0A# CONFIG_STACKTRACE_BUILD_ID is not set=0ACONFIG_=
CONSOLE_LOGLEVEL_DEFAULT=3D7=0ACONFIG_CONSOLE_LOGLEVEL_QUIET=3D4=0ACONFIG_M=
ESSAGE_LOGLEVEL_DEFAULT=3D4=0ACONFIG_BOOT_PRINTK_DELAY=3Dy=0ACONFIG_DYNAMIC=
_DEBUG=3Dy=0ACONFIG_DYNAMIC_DEBUG_CORE=3Dy=0ACONFIG_SYMBOLIC_ERRNAME=3Dy=0A=
CONFIG_DEBUG_BUGVERBOSE=3Dy=0A# end of printk and dmesg options=0A=0A#=0A# =
Compile-time checks and compiler options=0A#=0ACONFIG_DEBUG_INFO=3Dy=0ACONF=
IG_DEBUG_INFO_REDUCED=3Dy=0A# CONFIG_DEBUG_INFO_COMPRESSED is not set=0A# C=
ONFIG_DEBUG_INFO_SPLIT is not set=0A# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEF=
AULT is not set=0ACONFIG_DEBUG_INFO_DWARF4=3Dy=0A# CONFIG_DEBUG_INFO_DWARF5=
 is not set=0ACONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy=0A# CONFIG_GDB_SCRIPTS is not=
 set=0ACONFIG_FRAME_WARN=3D2048=0ACONFIG_STRIP_ASM_SYMS=3Dy=0A# CONFIG_READ=
ABLE_ASM is not set=0A# CONFIG_HEADERS_INSTALL is not set=0ACONFIG_DEBUG_SE=
CTION_MISMATCH=3Dy=0ACONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy=0ACONFIG_STACK_V=
ALIDATION=3Dy=0A# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set=0A# end of Com=
pile-time checks and compiler options=0A=0A#=0A# Generic Kernel Debugging I=
nstruments=0A#=0ACONFIG_MAGIC_SYSRQ=3Dy=0ACONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=
=3D0x1=0ACONFIG_MAGIC_SYSRQ_SERIAL=3Dy=0ACONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=
=3D""=0ACONFIG_DEBUG_FS=3Dy=0ACONFIG_DEBUG_FS_ALLOW_ALL=3Dy=0A# CONFIG_DEBU=
G_FS_DISALLOW_MOUNT is not set=0A# CONFIG_DEBUG_FS_ALLOW_NONE is not set=0A=
CONFIG_HAVE_ARCH_KGDB=3Dy=0A# CONFIG_KGDB is not set=0ACONFIG_ARCH_HAS_UBSA=
N_SANITIZE_ALL=3Dy=0A# CONFIG_UBSAN is not set=0ACONFIG_HAVE_ARCH_KCSAN=3Dy=
=0A# end of Generic Kernel Debugging Instruments=0A=0ACONFIG_DEBUG_KERNEL=
=3Dy=0ACONFIG_DEBUG_MISC=3Dy=0A=0A#=0A# Memory Debugging=0A#=0A# CONFIG_PAG=
E_EXTENSION is not set=0A# CONFIG_DEBUG_PAGEALLOC is not set=0A# CONFIG_PAG=
E_OWNER is not set=0A# CONFIG_PAGE_POISONING is not set=0A# CONFIG_DEBUG_PA=
GE_REF is not set=0A# CONFIG_DEBUG_RODATA_TEST is not set=0ACONFIG_ARCH_HAS=
_DEBUG_WX=3Dy=0A# CONFIG_DEBUG_WX is not set=0ACONFIG_GENERIC_PTDUMP=3Dy=0A=
# CONFIG_PTDUMP_DEBUGFS is not set=0A# CONFIG_DEBUG_OBJECTS is not set=0A# =
CONFIG_SLUB_DEBUG_ON is not set=0A# CONFIG_SLUB_STATS is not set=0ACONFIG_H=
AVE_DEBUG_KMEMLEAK=3Dy=0A# CONFIG_DEBUG_KMEMLEAK is not set=0A# CONFIG_DEBU=
G_STACK_USAGE is not set=0A# CONFIG_SCHED_STACK_END_CHECK is not set=0ACONF=
IG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy=0A# CONFIG_DEBUG_VM is not set=0A# CONFIG_=
DEBUG_VM_PGTABLE is not set=0ACONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy=0A# CONFIG_=
DEBUG_VIRTUAL is not set=0ACONFIG_DEBUG_MEMORY_INIT=3Dy=0A# CONFIG_DEBUG_PE=
R_CPU_MAPS is not set=0ACONFIG_HAVE_ARCH_KASAN=3Dy=0ACONFIG_HAVE_ARCH_KASAN=
_VMALLOC=3Dy=0ACONFIG_CC_HAS_KASAN_GENERIC=3Dy=0ACONFIG_CC_HAS_WORKING_NOSA=
NITIZE_ADDRESS=3Dy=0A# CONFIG_KASAN is not set=0ACONFIG_HAVE_ARCH_KFENCE=3D=
y=0A# CONFIG_KFENCE is not set=0A# end of Memory Debugging=0A=0ACONFIG_DEBU=
G_SHIRQ=3Dy=0A=0A#=0A# Debug Oops, Lockups and Hangs=0A#=0ACONFIG_PANIC_ON_=
OOPS=3Dy=0ACONFIG_PANIC_ON_OOPS_VALUE=3D1=0ACONFIG_PANIC_TIMEOUT=3D0=0ACONF=
IG_LOCKUP_DETECTOR=3Dy=0ACONFIG_SOFTLOCKUP_DETECTOR=3Dy=0A# CONFIG_BOOTPARA=
M_SOFTLOCKUP_PANIC is not set=0ACONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0=
=0ACONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy=0ACONFIG_HARDLOCKUP_CHECK_TIMESTAMP=
=3Dy=0ACONFIG_HARDLOCKUP_DETECTOR=3Dy=0ACONFIG_BOOTPARAM_HARDLOCKUP_PANIC=
=3Dy=0ACONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1=0ACONFIG_DETECT_HUNG_TAS=
K=3Dy=0ACONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D480=0A# CONFIG_BOOTPARAM_HUNG_TA=
SK_PANIC is not set=0ACONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0=0ACONFIG_W=
Q_WATCHDOG=3Dy=0A# CONFIG_TEST_LOCKUP is not set=0A# end of Debug Oops, Loc=
kups and Hangs=0A=0A#=0A# Scheduler Debugging=0A#=0ACONFIG_SCHED_DEBUG=3Dy=
=0ACONFIG_SCHED_INFO=3Dy=0ACONFIG_SCHEDSTATS=3Dy=0A# end of Scheduler Debug=
ging=0A=0A# CONFIG_DEBUG_TIMEKEEPING is not set=0A=0A#=0A# Lock Debugging (=
spinlocks, mutexes, etc...)=0A#=0ACONFIG_LOCK_DEBUGGING_SUPPORT=3Dy=0A# CON=
FIG_PROVE_LOCKING is not set=0A# CONFIG_LOCK_STAT is not set=0A# CONFIG_DEB=
UG_RT_MUTEXES is not set=0A# CONFIG_DEBUG_SPINLOCK is not set=0A# CONFIG_DE=
BUG_MUTEXES is not set=0A# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set=0A# CO=
NFIG_DEBUG_RWSEMS is not set=0A# CONFIG_DEBUG_LOCK_ALLOC is not set=0ACONFI=
G_DEBUG_ATOMIC_SLEEP=3Dy=0A# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set=
=0A# CONFIG_LOCK_TORTURE_TEST is not set=0A# CONFIG_WW_MUTEX_SELFTEST is no=
t set=0A# CONFIG_SCF_TORTURE_TEST is not set=0A# CONFIG_CSD_LOCK_WAIT_DEBUG=
 is not set=0A# end of Lock Debugging (spinlocks, mutexes, etc...)=0A=0A# C=
ONFIG_DEBUG_IRQFLAGS is not set=0ACONFIG_STACKTRACE=3Dy=0A# CONFIG_WARN_ALL=
_UNSEEDED_RANDOM is not set=0A# CONFIG_DEBUG_KOBJECT is not set=0A=0A#=0A# =
Debug kernel data structures=0A#=0ACONFIG_DEBUG_LIST=3Dy=0A# CONFIG_DEBUG_P=
LIST is not set=0A# CONFIG_DEBUG_SG is not set=0A# CONFIG_DEBUG_NOTIFIERS i=
s not set=0ACONFIG_BUG_ON_DATA_CORRUPTION=3Dy=0A# end of Debug kernel data =
structures=0A=0A# CONFIG_DEBUG_CREDENTIALS is not set=0A=0A#=0A# RCU Debugg=
ing=0A#=0ACONFIG_TORTURE_TEST=3Dm=0A# CONFIG_RCU_SCALE_TEST is not set=0A# =
CONFIG_RCU_TORTURE_TEST is not set=0ACONFIG_RCU_REF_SCALE_TEST=3Dm=0ACONFIG=
_RCU_CPU_STALL_TIMEOUT=3D60=0A# CONFIG_RCU_TRACE is not set=0A# CONFIG_RCU_=
EQS_DEBUG is not set=0A# end of RCU Debugging=0A=0A# CONFIG_DEBUG_WQ_FORCE_=
RR_CPU is not set=0A# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set=0ACONFIG_=
LATENCYTOP=3Dy=0ACONFIG_USER_STACKTRACE_SUPPORT=3Dy=0ACONFIG_NOP_TRACER=3Dy=
=0ACONFIG_HAVE_FUNCTION_TRACER=3Dy=0ACONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy=
=0ACONFIG_HAVE_DYNAMIC_FTRACE=3Dy=0ACONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3D=
y=0ACONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy=0ACONFIG_HAVE_DYNAMIC_=
FTRACE_WITH_ARGS=3Dy=0ACONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy=0ACONFIG_HAVE_S=
YSCALL_TRACEPOINTS=3Dy=0ACONFIG_HAVE_FENTRY=3Dy=0ACONFIG_HAVE_OBJTOOL_MCOUN=
T=3Dy=0ACONFIG_HAVE_C_RECORDMCOUNT=3Dy=0ACONFIG_TRACER_MAX_TRACE=3Dy=0ACONF=
IG_TRACE_CLOCK=3Dy=0ACONFIG_RING_BUFFER=3Dy=0ACONFIG_EVENT_TRACING=3Dy=0ACO=
NFIG_CONTEXT_SWITCH_TRACER=3Dy=0ACONFIG_TRACING=3Dy=0ACONFIG_GENERIC_TRACER=
=3Dy=0ACONFIG_TRACING_SUPPORT=3Dy=0ACONFIG_FTRACE=3Dy=0A# CONFIG_BOOTTIME_T=
RACING is not set=0ACONFIG_FUNCTION_TRACER=3Dy=0ACONFIG_FUNCTION_GRAPH_TRAC=
ER=3Dy=0ACONFIG_DYNAMIC_FTRACE=3Dy=0ACONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy=0A=
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy=0ACONFIG_DYNAMIC_FTRACE_WITH_AR=
GS=3Dy=0ACONFIG_FUNCTION_PROFILER=3Dy=0ACONFIG_STACK_TRACER=3Dy=0A# CONFIG_=
IRQSOFF_TRACER is not set=0ACONFIG_SCHED_TRACER=3Dy=0ACONFIG_HWLAT_TRACER=
=3Dy=0A# CONFIG_OSNOISE_TRACER is not set=0A# CONFIG_TIMERLAT_TRACER is not=
 set=0A# CONFIG_MMIOTRACE is not set=0ACONFIG_FTRACE_SYSCALLS=3Dy=0ACONFIG_=
TRACER_SNAPSHOT=3Dy=0A# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set=0ACO=
NFIG_BRANCH_PROFILE_NONE=3Dy=0A# CONFIG_PROFILE_ANNOTATED_BRANCHES is not s=
et=0ACONFIG_BLK_DEV_IO_TRACE=3Dy=0ACONFIG_KPROBE_EVENTS=3Dy=0A# CONFIG_KPRO=
BE_EVENTS_ON_NOTRACE is not set=0ACONFIG_UPROBE_EVENTS=3Dy=0ACONFIG_BPF_EVE=
NTS=3Dy=0ACONFIG_DYNAMIC_EVENTS=3Dy=0ACONFIG_PROBE_EVENTS=3Dy=0A# CONFIG_BP=
F_KPROBE_OVERRIDE is not set=0ACONFIG_FTRACE_MCOUNT_RECORD=3Dy=0ACONFIG_FTR=
ACE_MCOUNT_USE_CC=3Dy=0ACONFIG_TRACING_MAP=3Dy=0ACONFIG_SYNTH_EVENTS=3Dy=0A=
CONFIG_HIST_TRIGGERS=3Dy=0A# CONFIG_TRACE_EVENT_INJECT is not set=0A# CONFI=
G_TRACEPOINT_BENCHMARK is not set=0ACONFIG_RING_BUFFER_BENCHMARK=3Dm=0A# CO=
NFIG_TRACE_EVAL_MAP_FILE is not set=0A# CONFIG_FTRACE_RECORD_RECURSION is n=
ot set=0A# CONFIG_FTRACE_STARTUP_TEST is not set=0A# CONFIG_RING_BUFFER_STA=
RTUP_TEST is not set=0A# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set=
=0A# CONFIG_PREEMPTIRQ_DELAY_TEST is not set=0A# CONFIG_SYNTH_EVENT_GEN_TES=
T is not set=0A# CONFIG_KPROBE_EVENT_GEN_TEST is not set=0A# CONFIG_HIST_TR=
IGGERS_DEBUG is not set=0ACONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy=0A# CONFIG_S=
AMPLES is not set=0ACONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy=0ACONFIG_STRICT_D=
EVMEM=3Dy=0A# CONFIG_IO_STRICT_DEVMEM is not set=0A=0A#=0A# x86 Debugging=
=0A#=0ACONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy=0ACONFIG_EARLY_PRINTK_USB=3Dy=
=0ACONFIG_X86_VERBOSE_BOOTUP=3Dy=0ACONFIG_EARLY_PRINTK=3Dy=0ACONFIG_EARLY_P=
RINTK_DBGP=3Dy=0ACONFIG_EARLY_PRINTK_USB_XDBC=3Dy=0A# CONFIG_EFI_PGT_DUMP i=
s not set=0A# CONFIG_DEBUG_TLBFLUSH is not set=0ACONFIG_HAVE_MMIOTRACE_SUPP=
ORT=3Dy=0ACONFIG_X86_DECODER_SELFTEST=3Dy=0ACONFIG_IO_DELAY_0X80=3Dy=0A# CO=
NFIG_IO_DELAY_0XED is not set=0A# CONFIG_IO_DELAY_UDELAY is not set=0A# CON=
FIG_IO_DELAY_NONE is not set=0ACONFIG_DEBUG_BOOT_PARAMS=3Dy=0A# CONFIG_CPA_=
DEBUG is not set=0A# CONFIG_DEBUG_ENTRY is not set=0A# CONFIG_DEBUG_NMI_SEL=
FTEST is not set=0A# CONFIG_X86_DEBUG_FPU is not set=0A# CONFIG_PUNIT_ATOM_=
DEBUG is not set=0ACONFIG_UNWINDER_ORC=3Dy=0A# CONFIG_UNWINDER_FRAME_POINTE=
R is not set=0A# end of x86 Debugging=0A=0A#=0A# Kernel Testing and Coverag=
e=0A#=0ACONFIG_KUNIT=3Dy=0ACONFIG_KUNIT_DEBUGFS=3Dy=0A# CONFIG_KUNIT_TEST i=
s not set=0A# CONFIG_KUNIT_EXAMPLE_TEST is not set=0ACONFIG_KUNIT_ALL_TESTS=
=3Dm=0A# CONFIG_NOTIFIER_ERROR_INJECTION is not set=0ACONFIG_FUNCTION_ERROR=
_INJECTION=3Dy=0ACONFIG_FAULT_INJECTION=3Dy=0A# CONFIG_FAILSLAB is not set=
=0A# CONFIG_FAIL_PAGE_ALLOC is not set=0A# CONFIG_FAULT_INJECTION_USERCOPY =
is not set=0ACONFIG_FAIL_MAKE_REQUEST=3Dy=0A# CONFIG_FAIL_IO_TIMEOUT is not=
 set=0A# CONFIG_FAIL_FUTEX is not set=0ACONFIG_FAULT_INJECTION_DEBUG_FS=3Dy=
=0A# CONFIG_FAIL_FUNCTION is not set=0A# CONFIG_FAIL_MMC_REQUEST is not set=
=0A# CONFIG_FAIL_SUNRPC is not set=0ACONFIG_ARCH_HAS_KCOV=3Dy=0ACONFIG_CC_H=
AS_SANCOV_TRACE_PC=3Dy=0A# CONFIG_KCOV is not set=0ACONFIG_RUNTIME_TESTING_=
MENU=3Dy=0A# CONFIG_LKDTM is not set=0A# CONFIG_TEST_LIST_SORT is not set=
=0A# CONFIG_TEST_MIN_HEAP is not set=0A# CONFIG_TEST_SORT is not set=0A# CO=
NFIG_TEST_DIV64 is not set=0A# CONFIG_KPROBES_SANITY_TEST is not set=0A# CO=
NFIG_BACKTRACE_SELF_TEST is not set=0A# CONFIG_RBTREE_TEST is not set=0A# C=
ONFIG_REED_SOLOMON_TEST is not set=0A# CONFIG_INTERVAL_TREE_TEST is not set=
=0A# CONFIG_PERCPU_TEST is not set=0ACONFIG_ATOMIC64_SELFTEST=3Dy=0A# CONFI=
G_ASYNC_RAID6_TEST is not set=0A# CONFIG_TEST_HEXDUMP is not set=0A# CONFIG=
_STRING_SELFTEST is not set=0A# CONFIG_TEST_STRING_HELPERS is not set=0A# C=
ONFIG_TEST_STRSCPY is not set=0A# CONFIG_TEST_KSTRTOX is not set=0A# CONFIG=
_TEST_PRINTF is not set=0A# CONFIG_TEST_SCANF is not set=0A# CONFIG_TEST_BI=
TMAP is not set=0A# CONFIG_TEST_UUID is not set=0A# CONFIG_TEST_XARRAY is n=
ot set=0A# CONFIG_TEST_OVERFLOW is not set=0A# CONFIG_TEST_RHASHTABLE is no=
t set=0A# CONFIG_TEST_HASH is not set=0A# CONFIG_TEST_IDA is not set=0A# CO=
NFIG_TEST_LKM is not set=0A# CONFIG_TEST_BITOPS is not set=0A# CONFIG_TEST_=
VMALLOC is not set=0A# CONFIG_TEST_USER_COPY is not set=0ACONFIG_TEST_BPF=
=3Dm=0A# CONFIG_TEST_BLACKHOLE_DEV is not set=0A# CONFIG_FIND_BIT_BENCHMARK=
 is not set=0A# CONFIG_TEST_FIRMWARE is not set=0A# CONFIG_TEST_SYSCTL is n=
ot set=0ACONFIG_BITFIELD_KUNIT=3Dm=0ACONFIG_RESOURCE_KUNIT_TEST=3Dm=0ACONFI=
G_SYSCTL_KUNIT_TEST=3Dm=0ACONFIG_LIST_KUNIT_TEST=3Dm=0ACONFIG_LINEAR_RANGES=
_TEST=3Dm=0ACONFIG_CMDLINE_KUNIT_TEST=3Dm=0ACONFIG_BITS_TEST=3Dm=0ACONFIG_S=
LUB_KUNIT_TEST=3Dm=0ACONFIG_RATIONAL_KUNIT_TEST=3Dm=0A# CONFIG_TEST_UDELAY =
is not set=0A# CONFIG_TEST_STATIC_KEYS is not set=0A# CONFIG_TEST_KMOD is n=
ot set=0A# CONFIG_TEST_MEMCAT_P is not set=0A# CONFIG_TEST_LIVEPATCH is not=
 set=0A# CONFIG_TEST_STACKINIT is not set=0A# CONFIG_TEST_MEMINIT is not se=
t=0A# CONFIG_TEST_HMM is not set=0A# CONFIG_TEST_FREE_PAGES is not set=0A# =
CONFIG_TEST_FPU is not set=0A# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set=
=0ACONFIG_ARCH_USE_MEMTEST=3Dy=0A# CONFIG_MEMTEST is not set=0A# CONFIG_HYP=
ERV_TESTING is not set=0A# end of Kernel Testing and Coverage=0A# end of Ke=
rnel hacking=0A
--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='netperf'
	export testcase='netperf'
	export category='benchmark'
	export disable_latency_stats=1
	export set_nic_irq_affinity=1
	export ip='ipv4'
	export runtime=300
	export nr_threads=16
	export cluster='cs-localhost'
	export job_origin='netperf-small-threads.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-csl-2ap3'
	export tbox_group='lkp-csl-2ap3'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='617960e80b9a930a5af4f104'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-6.yaml'
	export id='fbecc857f957790eb9cfac7363705ffadfda23f9'
	export queuer_version='/lkp/xsang/.src-20211027-151141'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='a0918006f9284b77397ae4f163f055c3e0f987b2'
	export need_kconfig_hw='{"IGB"=>"y"}
BLK_DEV_NVME'
	export ucode='0x5003006'
	export enqueue_time='2021-10-27 22:23:36 +0800'
	export _id='617960f00b9a930a5af4f10a'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='955f175760f41ad2a80b07a390bac9a0444a47a6'
	export base_commit='519d81956ee277b4419c723adfb154603c2565ba'
	export branch='linux-devel/devel-hourly-20211025-030231'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/8'
	export scheduler_version='/lkp/lkp/.src-20211027-140142'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-6.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-devel/devel-hourly-20211025-030231
commit=a0918006f9284b77397ae4f163f055c3e0f987b2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/8
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210930.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20211027.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d25f27432f80-1_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/cluster_20211026.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.15.0-rc6-wt-12022-g955f175760f4'
	export queue_at_least_once=0
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928'
	export dequeue_time='2021-10-28 03:03:20 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-6.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor lite_mode=1 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test test='TCP_CRR' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='TCP_CRR' $LKP_SRC/stats/wrapper netperf
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/netperf-small-threads.yaml:
suite: netperf
testcase: netperf
category: benchmark
:# upto 90% CPU cycles may be used by latency stats:
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 300s
nr_threads: 16
cluster: cs-localhost
if role server:
  netserver:
if role client:
  netperf:
    test: TCP_CRR
job_origin: netperf-small-threads.yaml
:#! queue options:
queue_cmdline_keys: []
queue: vip
testbox: lkp-csl-2ap3
tbox_group: lkp-csl-2ap3
kconfig: x86_64-rhel-8.3
submit_id: 617960e80b9a930a5af4f104
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-4.yaml"
id: d804900eed74d058b23143a825d247e0f8d03392
queuer_version: "/lkp/xsang/.src-20211027-151141"
:#! hosts/lkp-csl-2ap3:
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions:
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  lite_mode: 1
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: a0918006f9284b77397ae4f163f055c3e0f987b2
:#! include/testbox/lkp-csl-2ap3:
need_kconfig_hw:
- IGB: y
- BLK_DEV_NVME
ucode: '0x5003006'
enqueue_time: 2021-10-27 22:23:36.647383432 +08:00
_id: 617960f00b9a930a5af4f108
_rt: "/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 955f175760f41ad2a80b07a390bac9a0444a47a6
base_commit: 519d81956ee277b4419c723adfb154603c2565ba
branch: linux-devel/devel-hourly-20211025-030231
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/0"
scheduler_version: "/lkp/lkp/.src-20211027-140142"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-4.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20211025-030231
- commit=a0918006f9284b77397ae4f163f055c3e0f987b2
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210930.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20211025.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d25f27432f80-1_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/cluster_20211026.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20211026-143536/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.15.0-rc6-wt-12022-g955f175760f4
queue_at_least_once: 0
:#! /lkp/lkp/.src-20211026-205023/include/site/inn:
:#! user overrides:
schedule_notify_address:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928"
dequeue_time: 2021-10-28 02:02:15.174367353 +08:00
:#! /lkp/lkp/.src-20211027-140142/include/site/inn:
job_state: finished
loadavg: 6.09 10.58 5.53 1/1355 19660
start_time: '1635357811'
end_time: '1635358116'
version: "/lkp/lkp/.src-20211027-140222:5f87ddf4:8610dc698"

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

netserver -4 -D
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
wait

--dc+cDN39EJAMEtIO--
