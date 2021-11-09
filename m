Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598644B1E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhKIRYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 12:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhKIRYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:24:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E8DC0613F5
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 09:21:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id r5so22177170pls.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WZVtTWUO4YQALEKn/nFv3JRM1zczCT1JScaBak3yxVU=;
        b=ZZJN4/9yy68m0cz4UY6Le+bOn86nEDd5ylu6eCjn2j4xxEoU5Vh0+jvbyjAvS6r5ni
         Z+bTLF9bdwyqkM14TIZjZOf+5C0iJ8xqWb51+guBNuAGS4vxG7mYV26pG4olovDjDyES
         l5qreUYXaTVYTn8dVwnM+efLUr0yPaGJ978J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WZVtTWUO4YQALEKn/nFv3JRM1zczCT1JScaBak3yxVU=;
        b=tlpab4UN/uWTKta9HzN2vn6pKs9+wV7oMFknzqrj1U1VdlWHszifmYi63fv+hwtymI
         yqZp+S72fnDEv/xO/HW41P+3F/mTEpV05nCThGZgudKIrJjB+BXsLzXGSGRtCpiks55i
         1/KL82rkZsoFoaKhLgzPNvT7pDT3+0F1ivzAtU4Mqrs8H9x3LuIZh11i4WfUIvq2GQKm
         0zDXSyN9TzaeyBN4OL/uoa0CqmdZlE1gINT+Jke0XEDMPeRm0XAVYk80S766q4rdgqy9
         ZR1lblZAsjpTrdktul0+D3L37C/J+pHCfyeKBIrMDbrbOXGANVRoouhiZMkFXcAzr5NE
         z87Q==
X-Gm-Message-State: AOAM531ly6QDa3sEq7+IVe+ao6AykhN42QeN9KhITXfIX689v4JmQp23
        Au8z24zTJu4E1AAcpRHOT7AicQ==
X-Google-Smtp-Source: ABdhPJwXLb1mQj6pH0iuPAZME71n40uMkmTKWdVCBLhoWd7sY9G1mggH0msWnARP/4KtrairOs+JLA==
X-Received: by 2002:a17:90a:4801:: with SMTP id a1mr9044213pjh.156.1636478504324;
        Tue, 09 Nov 2021 09:21:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm9855706pgj.89.2021.11.09.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 09:21:43 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:21:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [fs]  a0918006f9:  netperf.Throughput_tps -11.6% regression
Message-ID: <202111090920.4958E610D1@keescook>
References: <20211012192410.2356090-2-mic@digikod.net>
 <20211105064159.GB17949@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211105064159.GB17949@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 05, 2021 at 02:41:59PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -11.6% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: a0918006f9284b77397ae4f163f055c3e0f987b2 ("[PATCH v15 1/3] fs: Add trusted_for(2) syscall implementation and related sysctl")
> url: https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Add-trusted_for-2-was-O_MAYEXEC/20211013-032533
> patch link: https://lore.kernel.org/kernel-hardening/20211012192410.2356090-2-mic@digikod.net
> 
> in testcase: netperf
> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 16
> 	cluster: cs-localhost
> 	test: TCP_CRR
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
> 
> please be noted we made out some further analysis/tests, as Fengwei mentioned:
> ==============================================================================
> Here is my investigation result of this regression:
> 
> If I add patch to make sure the kernel function address and data address is
> almost same even with this patch, there is almost no performance delta(0.1%)
> w/o the patch.
> 
> And if I only make sure function address same w/o the patch, the performance
> delta is about 5.1%.
> 
> So suppose this regression is triggered by different function and data address.
> We don't know why the different address could bring such kind of regression yet
> ===============================================================================
> 
> 
> we also tested on other platforms.
> on a Cooper Lake (Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory),
> we also observed regression but the gap is smaller:
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/16/debian-10.4-x86_64-20200603.cgz/300s/lkp-cpl-4sp1/TCP_CRR/netperf/0x700001e
> 
> commit:
>   v5.15-rc4
>   a0918006f9284b77397ae4f163f055c3e0f987b2
> 
>        v5.15-rc4 a0918006f9284b77397ae4f163f
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     333492            -5.7%     314346 ±  2%  netperf.Throughput_total_tps
>      20843            -4.5%      19896        netperf.Throughput_tps
> 
> 
> but no regression on a 96 threads 2 sockets Ice Lake with 256G memory:
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/16/debian-10.4-x86_64-20200603.cgz/300s/lkp-icl-2sp1/TCP_CRR/netperf/0xb000280
> 
> commit:
>   v5.15-rc4
>   a0918006f9284b77397ae4f163f055c3e0f987b2
> 
>        v5.15-rc4 a0918006f9284b77397ae4f163f
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     555600            -0.1%     555305        netperf.Throughput_total_tps
>      34725            -0.1%      34706        netperf.Throughput_tps
> 
> 
> Fengwei also helped review these results and commented:
> I suppose these three CPUs have different cache policy. It also could be
> related with netperf throughput testing.

Does moving the syscall implementation somewhere else change things?
That's a _huge_ performance change for something that isn't even called.
What's going on here?

-Kees

> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/16/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/TCP_CRR/netperf/0x5003006
> 
> commit: 
>   v5.15-rc4
>   a0918006f9 ("fs: Add trusted_for(2) syscall implementation and related sysctl")
> 
>        v5.15-rc4 a0918006f9284b77397ae4f163f 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     354692           -11.6%     313620        netperf.Throughput_total_tps
>      22168           -11.6%      19601        netperf.Throughput_tps
>  2.075e+08           -11.6%  1.834e+08        netperf.time.voluntary_context_switches
>  1.064e+08           -11.6%   94086163        netperf.workload
>       0.27 ± 35%      -0.1        0.22 ±  2%  mpstat.cpu.all.usr%
>    2207583            -6.3%    2068413        vmstat.system.cs
>    3029480 ±  6%     -23.3%    2324079 ±  7%  interrupts.CAL:Function_call_interrupts
>      13768 ± 25%     -35.6%       8872 ± 23%  interrupts.CPU30.CAL:Function_call_interrupts
>    2014617 ± 16%     -26.3%    1485200 ± 24%  softirqs.CPU180.NET_RX
>  3.268e+08           -12.1%  2.874e+08        softirqs.NET_RX
>     287881 ±  2%     +24.6%     358692        softirqs.TIMER
>    3207001            -9.6%    2899010        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
>       0.01 ± 15%     +67.1%       0.01 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__release_sock.release_sock.sk_wait_data
>       0.02 ±  2%     +23.3%       0.03 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_accept.do_accept
>       0.01           +20.0%       0.01        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>      63320 ±  2%     -10.6%      56615 ±  2%  slabinfo.sock_inode_cache.active_objs
>       1626 ±  2%     -10.6%       1454 ±  2%  slabinfo.sock_inode_cache.active_slabs
>      63445 ±  2%     -10.6%      56722 ±  2%  slabinfo.sock_inode_cache.num_objs
>       1626 ±  2%     -10.6%       1454 ±  2%  slabinfo.sock_inode_cache.num_slabs
>      49195            -3.2%      47624        proc-vmstat.nr_slab_reclaimable
>    4278441            -6.6%    3996109        proc-vmstat.numa_hit
>    4052317 ±  2%      -7.4%    3751341        proc-vmstat.numa_local
>    4285136            -6.5%    4006356        proc-vmstat.pgalloc_normal
>    1704913           -11.4%    1511123        proc-vmstat.pgfree
>  9.382e+09           -10.1%  8.438e+09        perf-stat.i.branch-instructions
>  1.391e+08           -10.0%  1.252e+08        perf-stat.i.branch-misses
>      13.98            +2.2       16.20        perf-stat.i.cache-miss-rate%
>   87082775           +14.0%   99273064        perf-stat.i.cache-misses
>    2231661            -6.4%    2088571        perf-stat.i.context-switches
>       1.65            +8.6%       1.79        perf-stat.i.cpi
>  7.603e+10            -2.1%  7.441e+10        perf-stat.i.cpu-cycles
>     907.53 ±  2%     -13.0%     789.92 ±  2%  perf-stat.i.cycles-between-cache-misses
>     920324 ± 19%     -20.3%     733572 ±  5%  perf-stat.i.dTLB-load-misses
>  1.417e+10           -10.3%  1.271e+10        perf-stat.i.dTLB-loads
>     182445 ± 16%     -57.6%      77419 ±  9%  perf-stat.i.dTLB-store-misses
>  8.254e+09           -10.3%  7.403e+09        perf-stat.i.dTLB-stores
>      88.23            -1.7       86.52        perf-stat.i.iTLB-load-miss-rate%
>   96633753           -11.0%   85983323        perf-stat.i.iTLB-load-misses
>   12277057            +4.0%   12766535        perf-stat.i.iTLB-loads
>  4.741e+10           -10.2%  4.259e+10        perf-stat.i.instructions
>       0.62            -8.2%       0.57        perf-stat.i.ipc
>       0.40            -2.1%       0.39        perf-stat.i.metric.GHz
>     168.88           -10.1%     151.87        perf-stat.i.metric.M/sec
>   16134360 ±  2%     +15.0%   18550862        perf-stat.i.node-load-misses
>    1576525 ±  2%     +10.0%    1734370 ±  2%  perf-stat.i.node-loads
>   10027868           -11.5%    8871598        perf-stat.i.node-store-misses
>     386034 ±  3%     -16.0%     324290 ±  7%  perf-stat.i.node-stores
>      13.15            +9.2%      14.36        perf-stat.overall.MPKI
>      13.97            +2.3       16.23        perf-stat.overall.cache-miss-rate%
>       1.60            +8.9%       1.75        perf-stat.overall.cpi
>     873.29           -14.2%     749.60        perf-stat.overall.cycles-between-cache-misses
>       0.00 ± 15%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
>      88.73            -1.7       87.07        perf-stat.overall.iTLB-load-miss-rate%
>       0.62            -8.2%       0.57        perf-stat.overall.ipc
>     135778            +1.7%     138069        perf-stat.overall.path-length
>  9.351e+09           -10.1%   8.41e+09        perf-stat.ps.branch-instructions
>  1.387e+08           -10.0%  1.248e+08        perf-stat.ps.branch-misses
>   86797490           +14.0%   98949207        perf-stat.ps.cache-misses
>    2224197            -6.4%    2081616        perf-stat.ps.context-switches
>  7.578e+10            -2.1%  7.416e+10        perf-stat.ps.cpu-cycles
>     917495 ± 19%     -20.3%     731365 ±  5%  perf-stat.ps.dTLB-load-misses
>  1.412e+10           -10.3%  1.267e+10        perf-stat.ps.dTLB-loads
>     181859 ± 16%     -57.6%      77179 ±  9%  perf-stat.ps.dTLB-store-misses
>  8.227e+09           -10.3%  7.379e+09        perf-stat.ps.dTLB-stores
>   96313891           -11.0%   85700283        perf-stat.ps.iTLB-load-misses
>   12236194            +4.0%   12724086        perf-stat.ps.iTLB-loads
>  4.726e+10           -10.2%  4.245e+10        perf-stat.ps.instructions
>   16081690 ±  2%     +15.0%   18490522        perf-stat.ps.node-load-misses
>    1571411 ±  2%     +10.0%    1728755 ±  2%  perf-stat.ps.node-loads
>    9995103           -11.5%    8842824        perf-stat.ps.node-store-misses
>     385193 ±  3%     -16.0%     323588 ±  7%  perf-stat.ps.node-stores
>  1.445e+13           -10.1%  1.299e+13        perf-stat.total.instructions
>       1.51 ±  7%      -0.2        1.29 ±  7%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
>       1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.calltrace.cycles-pp.ret_from_fork
>       1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>       1.48 ±  7%      -0.2        1.26 ±  7%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
>       1.49 ±  7%      -0.2        1.27 ±  7%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>       1.50 ±  7%      -0.2        1.27 ±  7%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>       1.47 ±  7%      -0.2        1.25 ±  7%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
>       1.41 ±  7%      -0.2        1.19 ±  7%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
>       1.25 ±  7%      -0.2        1.06 ±  7%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
>       1.21 ±  7%      -0.2        1.03 ±  7%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.rcu_do_batch.rcu_core
>       0.94 ±  7%      -0.1        0.80 ±  7%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.rcu_do_batch
>       0.62 ±  7%      +0.2        0.80 ±  9%  perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
>       1.51 ±  7%      -0.2        1.29 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
>       1.53 ±  7%      -0.2        1.31 ±  7%  perf-profile.children.cycles-pp.kthread
>       1.50 ±  7%      -0.2        1.27 ±  7%  perf-profile.children.cycles-pp.run_ksoftirqd
>       1.73 ±  6%      -0.2        1.51 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_bh
>       1.25 ±  5%      -0.2        1.07 ±  6%  perf-profile.children.cycles-pp.lock_sock_nested
>       1.03 ±  7%      -0.1        0.88 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.83 ±  6%      -0.1        0.72 ±  6%  perf-profile.children.cycles-pp.sk_clone_lock
>       0.84 ±  6%      -0.1        0.73 ±  6%  perf-profile.children.cycles-pp.inet_csk_clone_lock
>       0.45 ±  8%      -0.1        0.34 ±  6%  perf-profile.children.cycles-pp.__tcp_get_metrics
>       0.70 ±  6%      -0.1        0.60 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.52 ±  8%      -0.1        0.42 ±  6%  perf-profile.children.cycles-pp.tcp_get_metrics
>       0.72 ±  5%      -0.1        0.62 ±  6%  perf-profile.children.cycles-pp.sk_forced_mem_schedule
>       0.32 ±  7%      -0.1        0.24 ±  7%  perf-profile.children.cycles-pp.sk_filter_trim_cap
>       0.49 ±  7%      -0.1        0.41 ±  8%  perf-profile.children.cycles-pp.tcp_v4_destroy_sock
>       0.26 ±  7%      -0.0        0.22 ±  8%  perf-profile.children.cycles-pp.ip_finish_output
>       0.29 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.tcp_write_queue_purge
>       0.16 ± 10%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
>       0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__destroy_inode
>       0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.destroy_inode
>       0.10 ±  9%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.sock_put
>       0.10 ± 10%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.d_instantiate
>       0.08 ± 11%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_trace
>       0.11 ±  8%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__inet_lookup_listener
>       0.08 ±  9%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.inet_lhash2_lookup
>       0.10 ±  7%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.tcp_ca_openreq_child
>       0.08 ±  9%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.tcp_newly_delivered
>       0.08 ±  6%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.tcp_mtup_init
>       0.09 ±  8%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.tcp_stream_memory_free
>       0.24 ±  6%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.ip_rcv_core
>       0.06 ±  9%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.tcp_push
>       0.11 ±  9%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.tcp_synack_rtt_meas
>       0.00 ±412%      +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.tcp_rack_update_reo_wnd
>       0.20 ±  8%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.tcp_assign_congestion_control
>       0.34 ±  8%      +0.1        0.42 ±  6%  perf-profile.children.cycles-pp.tcp_init_metrics
>       0.14 ±  6%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.tcp_sync_mss
>       0.33 ±  5%      +0.1        0.41 ±  8%  perf-profile.children.cycles-pp.inet_csk_route_req
>       0.31 ±  6%      +0.1        0.40 ±  6%  perf-profile.children.cycles-pp.inet_csk_route_child_sock
>       0.13 ±  8%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.skb_entail
>       0.21 ±  6%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.ip_rcv_finish_core
>       0.24 ±  5%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.ip_rcv_finish
>       0.20 ±  7%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.tcp_select_initial_window
>       0.14 ±  5%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.secure_tcp_ts_off
>       0.45 ±  6%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.tcp_finish_connect
>       0.23 ±  5%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.tcp_parse_options
>       0.17 ±  7%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
>       0.20 ±  7%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.tcp_openreq_init_rwin
>       0.27 ±  9%      +0.1        0.42 ±  7%  perf-profile.children.cycles-pp.tcp_connect_init
>       0.45 ±  7%      +0.2        0.60 ±  5%  perf-profile.children.cycles-pp.tcp_v4_init_sock
>       0.44 ±  7%      +0.2        0.60 ±  6%  perf-profile.children.cycles-pp.tcp_init_sock
>       0.23 ±  7%      +0.2        0.39 ±  6%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
>       0.35 ±  6%      +0.2        0.57 ±  7%  perf-profile.children.cycles-pp.inet_sk_rebuild_header
>       0.25 ±  9%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.__tcp_select_window
>       0.35 ±  6%      +0.3        0.61 ±  6%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
>       0.76 ±  5%      +0.3        1.04 ±  6%  perf-profile.children.cycles-pp.ip_route_output_flow
>       0.78 ±  6%      +0.3        1.08 ±  6%  perf-profile.children.cycles-pp.tcp_init_transfer
>       1.78 ±  6%      +0.3        2.11 ±  6%  perf-profile.children.cycles-pp.tcp_conn_request
>       1.07 ±  4%      +0.4        1.44 ±  5%  perf-profile.children.cycles-pp.ip_route_output_key_hash
>       1.02 ±  5%      +0.4        1.40 ±  5%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
>       2.02 ±  5%      +0.5        2.50 ±  6%  perf-profile.children.cycles-pp.tcp_ack
>       1.04 ±  7%      +0.6        1.63 ±  7%  perf-profile.children.cycles-pp.__sk_dst_check
>       1.18 ±  7%      +0.7        1.86 ±  7%  perf-profile.children.cycles-pp.ipv4_dst_check
>       5.95 ±  5%      +0.9        6.87 ±  6%  perf-profile.children.cycles-pp.tcp_v4_connect
>       1.02 ±  7%      -0.2        0.87 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       0.44 ±  8%      -0.1        0.34 ±  6%  perf-profile.self.cycles-pp.__tcp_get_metrics
>       0.69 ±  6%      -0.1        0.59 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.71 ±  5%      -0.1        0.61 ±  6%  perf-profile.self.cycles-pp.sk_forced_mem_schedule
>       0.32 ±  6%      -0.1        0.26 ±  8%  perf-profile.self.cycles-pp.ip_finish_output2
>       0.35 ±  7%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
>       0.15 ±  7%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>       0.17 ±  6%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__skb_clone
>       0.07 ±  5%      -0.0        0.04 ± 43%  perf-profile.self.cycles-pp.sk_filter_trim_cap
>       0.09 ±  9%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.dequeue_task_fair
>       0.08 ±  7%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.release_sock
>       0.07 ± 10%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.tcp_create_openreq_child
>       0.11 ±  7%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.tcp_connect
>       0.08 ±  9%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.inet_lhash2_lookup
>       0.09 ±  9%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.inet_csk_get_port
>       0.08 ± 10%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.tcp_init_transfer
>       0.08 ±  9%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.tcp_newly_delivered
>       0.07 ±  7%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.tcp_mtup_init
>       0.35 ±  5%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.__ip_queue_xmit
>       0.16 ±  7%      +0.1        0.22 ±  6%  perf-profile.self.cycles-pp.__inet_bind
>       0.09 ±  8%      +0.1        0.15 ±  6%  perf-profile.self.cycles-pp.tcp_stream_memory_free
>       0.24 ±  6%      +0.1        0.30 ±  8%  perf-profile.self.cycles-pp.ip_rcv_core
>       0.06 ±  9%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.tcp_push
>       0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.tcp_rack_update_reo_wnd
>       0.23 ±  8%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.ip_output
>       0.20 ±  8%      +0.1        0.28 ±  5%  perf-profile.self.cycles-pp.tcp_assign_congestion_control
>       0.10 ±  8%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.tcp_v4_syn_recv_sock
>       0.09 ±  7%      +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.tcp_openreq_init_rwin
>       0.07 ± 10%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.tcp_v4_send_synack
>       0.13 ±  7%      +0.1        0.22 ±  7%  perf-profile.self.cycles-pp.tcp_sync_mss
>       0.12 ±  8%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.skb_entail
>       0.18 ±  8%      +0.1        0.27 ±  6%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
>       0.21 ±  5%      +0.1        0.31 ±  6%  perf-profile.self.cycles-pp.ip_rcv_finish_core
>       0.15 ±  9%      +0.1        0.26 ±  6%  perf-profile.self.cycles-pp.tcp_update_metrics
>       0.20 ±  8%      +0.1        0.31 ±  5%  perf-profile.self.cycles-pp.tcp_select_initial_window
>       0.12 ±  9%      +0.1        0.25 ±  8%  perf-profile.self.cycles-pp.tcp_connect_init
>       0.11 ±  8%      +0.1        0.24 ±  8%  perf-profile.self.cycles-pp.secure_tcp_ts_off
>       0.22 ±  5%      +0.1        0.35 ±  5%  perf-profile.self.cycles-pp.tcp_parse_options
>       0.13 ± 12%      +0.1        0.27 ±  7%  perf-profile.self.cycles-pp.tcp_init_metrics
>       0.17 ±  7%      +0.1        0.30 ±  7%  perf-profile.self.cycles-pp.tcp_update_pacing_rate
>       0.17 ± 10%      +0.2        0.32 ±  6%  perf-profile.self.cycles-pp.tcp_init_sock
>       0.18 ±  8%      +0.2        0.35 ±  6%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
>       0.42 ±  8%      +0.2        0.62 ±  7%  perf-profile.self.cycles-pp.tcp_write_xmit
>       0.25 ±  8%      +0.2        0.48 ±  7%  perf-profile.self.cycles-pp.__tcp_select_window
>       0.28 ±  8%      +0.3        0.56 ±  5%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
>       0.71 ±  5%      +0.4        1.09 ±  6%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
>       1.17 ±  7%      +0.7        1.84 ±  7%  perf-profile.self.cycles-pp.ipv4_dst_check
> 
> 
>                                                                                 
>                                netperf.Throughput_tps                           
>                                                                                 
>   22500 +-------------------------------------------------------------------+   
>         |        ...+......                           ...+......+.....+.....|   
>   22000 |.....+..          +.....+.....+.....+.....+..                      |   
>         |                                                                   |   
>         |                                                                   |   
>   21500 |-+                                                                 |   
>         |                                                                   |   
>   21000 |-+                                                                 |   
>         |                                                                   |   
>   20500 |-+                                                                 |   
>         |                                                                   |   
>         |                                                                   |   
>   20000 |-+                                                                 |   
>         |     O     O            O     O                 O                  |   
>   19500 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                             netperf.Throughput_total_tps                        
>                                                                                 
>   360000 +------------------------------------------------------------------+   
>   355000 |-+      ...+.....                ...+.....   ...+..         +.....|   
>          |.....+..         +.....+.....+...         +..                     |   
>   350000 |-+                                                                |   
>   345000 |-+                                                                |   
>          |                                                                  |   
>   340000 |-+                                                                |   
>   335000 |-+                                                                |   
>   330000 |-+                                                                |   
>          |                                                                  |   
>   325000 |-+                                                                |   
>   320000 |-+                                                                |   
>          |                                                                  |   
>   315000 |-+   O     O     O     O     O      O     O     O     O     O     |   
>   310000 +------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                    netperf.workload                             
>                                                                                 
>   1.08e+08 +----------------------------------------------------------------+   
>            |        ...+.....+.....         ..+.....   ...+..         +.....|   
>   1.06e+08 |.....+..               +.....+..        +..                     |   
>   1.04e+08 |-+                                                              |   
>            |                                                                |   
>   1.02e+08 |-+                                                              |   
>            |                                                                |   
>      1e+08 |-+                                                              |   
>            |                                                                |   
>    9.8e+07 |-+                                                              |   
>    9.6e+07 |-+                                                              |   
>            |                                                                |   
>    9.4e+07 |-+   O     O     O     O     O    O     O     O     O     O     |   
>            |                                                                |   
>    9.2e+07 +----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                         netperf.time.voluntary_context_switches                 
>                                                                                 
>    2.1e+08 +----------------------------------------------------------------+   
>            |.....+.....+.....+.....+.....+....+.....   ...+..         +.....|   
>   2.05e+08 |-+                                      +..                     |   
>            |                                                                |   
>            |                                                                |   
>      2e+08 |-+                                                              |   
>            |                                                                |   
>   1.95e+08 |-+                                                              |   
>            |                                                                |   
>    1.9e+08 |-+                                                              |   
>            |                                                                |   
>            |                                                                |   
>   1.85e+08 |-+   O     O     O     O     O          O     O                 |   
>            |                                  O                 O     O     |   
>    1.8e+08 +----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>    0.006 +------------------------------------------------------------------+   
>          |                                                                  |   
>          |                                                                  |   
>   0.0058 |-+                                                                |   
>          |                                                                  |   
>          |                                                                  |   
>   0.0056 |-+                                                                |   
>          |                                                                  |   
>   0.0054 |-+                                                                |   
>          |                                                                  |   
>          |                                                                  |   
>   0.0052 |-+                                                                |   
>          |                                                                  |   
>          |                                                                  |   
>    0.005 +------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   3.25e+06 +----------------------------------------------------------------+   
>            |.....   ...+....          ...+....+.....+.....+.....   ...+.....|   
>    3.2e+06 |-+   +..        .   ...+..                          +..         |   
>            |                 +..                                            |   
>   3.15e+06 |-+                                                              |   
>    3.1e+06 |-+                                                              |   
>            |                                                                |   
>   3.05e+06 |-+                                                              |   
>            |                                                                |   
>      3e+06 |-+                                                              |   
>   2.95e+06 |-+                                                              |   
>            |                                                                |   
>    2.9e+06 |-+   O     O     O           O    O     O     O     O     O     |   
>            |                       O                                        |   
>   2.85e+06 +----------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> ***************************************************************************************************
> lkp-icl-2sp1: 96 threads 2 sockets Ice Lake with 256G memory
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 


> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='netperf'
> 	export testcase='netperf'
> 	export category='benchmark'
> 	export disable_latency_stats=1
> 	export set_nic_irq_affinity=1
> 	export ip='ipv4'
> 	export runtime=300
> 	export nr_threads=16
> 	export cluster='cs-localhost'
> 	export job_origin='netperf-small-threads.yaml'
> 	export queue_cmdline_keys=
> 	export queue='vip'
> 	export testbox='lkp-csl-2ap3'
> 	export tbox_group='lkp-csl-2ap3'
> 	export kconfig='x86_64-rhel-8.3'
> 	export submit_id='617960e80b9a930a5af4f104'
> 	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-6.yaml'
> 	export id='fbecc857f957790eb9cfac7363705ffadfda23f9'
> 	export queuer_version='/lkp/xsang/.src-20211027-151141'
> 	export model='Cascade Lake'
> 	export nr_node=4
> 	export nr_cpu=192
> 	export memory='192G'
> 	export ssd_partitions=
> 	export rootfs_partition='LABEL=LKP-ROOTFS'
> 	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
> 	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
> 	export commit='a0918006f9284b77397ae4f163f055c3e0f987b2'
> 	export need_kconfig_hw='{"IGB"=>"y"}
> BLK_DEV_NVME'
> 	export ucode='0x5003006'
> 	export enqueue_time='2021-10-27 22:23:36 +0800'
> 	export _id='617960f00b9a930a5af4f10a'
> 	export _rt='/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2'
> 	export user='lkp'
> 	export compiler='gcc-9'
> 	export LKP_SERVER='internal-lkp-server'
> 	export head_commit='955f175760f41ad2a80b07a390bac9a0444a47a6'
> 	export base_commit='519d81956ee277b4419c723adfb154603c2565ba'
> 	export branch='linux-devel/devel-hourly-20211025-030231'
> 	export rootfs='debian-10.4-x86_64-20200603.cgz'
> 	export result_root='/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/8'
> 	export scheduler_version='/lkp/lkp/.src-20211027-140142'
> 	export arch='x86_64'
> 	export max_uptime=2100
> 	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-6.yaml
> ARCH=x86_64
> kconfig=x86_64-rhel-8.3
> branch=linux-devel/devel-hourly-20211025-030231
> commit=a0918006f9284b77397ae4f163f055c3e0f987b2
> BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928
> acpi_rsdp=0x67f44014
> max_uptime=2100
> RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/8
> LKP_SERVER=internal-lkp-server
> nokaslr
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/modules.cgz'
> 	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210930.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20211027.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d25f27432f80-1_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/cluster_20211026.cgz'
> 	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export last_kernel='5.15.0-rc6-wt-12022-g955f175760f4'
> 	export queue_at_least_once=0
> 	export schedule_notify_address=
> 	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928'
> 	export dequeue_time='2021-10-28 03:03:20 +0800'
> 	export node_roles='server client'
> 	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-6.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper uptime
> 	run_monitor $LKP_SRC/monitors/wrapper iostat
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper proc-stat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper slabinfo
> 	run_monitor $LKP_SRC/monitors/wrapper interrupts
> 	run_monitor $LKP_SRC/monitors/wrapper lock_stat
> 	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
> 	run_monitor $LKP_SRC/monitors/wrapper softirqs
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
> 	run_monitor $LKP_SRC/monitors/wrapper diskstats
> 	run_monitor $LKP_SRC/monitors/wrapper nfsstat
> 	run_monitor $LKP_SRC/monitors/wrapper cpuidle
> 	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
> 	run_monitor $LKP_SRC/monitors/wrapper turbostat
> 	run_monitor $LKP_SRC/monitors/wrapper sched_debug
> 	run_monitor $LKP_SRC/monitors/wrapper perf-stat
> 	run_monitor $LKP_SRC/monitors/wrapper mpstat
> 	run_monitor lite_mode=1 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	if role server
> 	then
> 		start_daemon $LKP_SRC/daemon/netserver
> 	fi
> 
> 	if role client
> 	then
> 		run_test test='TCP_CRR' $LKP_SRC/tests/wrapper netperf
> 	fi
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	env test='TCP_CRR' $LKP_SRC/stats/wrapper netperf
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper uptime
> 	$LKP_SRC/stats/wrapper iostat
> 	$LKP_SRC/stats/wrapper vmstat
> 	$LKP_SRC/stats/wrapper numa-numastat
> 	$LKP_SRC/stats/wrapper numa-vmstat
> 	$LKP_SRC/stats/wrapper numa-meminfo
> 	$LKP_SRC/stats/wrapper proc-vmstat
> 	$LKP_SRC/stats/wrapper meminfo
> 	$LKP_SRC/stats/wrapper slabinfo
> 	$LKP_SRC/stats/wrapper interrupts
> 	$LKP_SRC/stats/wrapper lock_stat
> 	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
> 	$LKP_SRC/stats/wrapper softirqs
> 	$LKP_SRC/stats/wrapper diskstats
> 	$LKP_SRC/stats/wrapper nfsstat
> 	$LKP_SRC/stats/wrapper cpuidle
> 	$LKP_SRC/stats/wrapper turbostat
> 	$LKP_SRC/stats/wrapper sched_debug
> 	$LKP_SRC/stats/wrapper perf-stat
> 	$LKP_SRC/stats/wrapper mpstat
> 	env lite_mode=1 $LKP_SRC/stats/wrapper perf-profile
> 
> 	$LKP_SRC/stats/wrapper time netperf.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"

> ---
> :#! jobs/netperf-small-threads.yaml:
> suite: netperf
> testcase: netperf
> category: benchmark
> :# upto 90% CPU cycles may be used by latency stats:
> disable_latency_stats: 1
> set_nic_irq_affinity: 1
> ip: ipv4
> runtime: 300s
> nr_threads: 16
> cluster: cs-localhost
> if role server:
>   netserver:
> if role client:
>   netperf:
>     test: TCP_CRR
> job_origin: netperf-small-threads.yaml
> :#! queue options:
> queue_cmdline_keys: []
> queue: vip
> testbox: lkp-csl-2ap3
> tbox_group: lkp-csl-2ap3
> kconfig: x86_64-rhel-8.3
> submit_id: 617960e80b9a930a5af4f104
> job_file: "/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-4.yaml"
> id: d804900eed74d058b23143a825d247e0f8d03392
> queuer_version: "/lkp/xsang/.src-20211027-151141"
> :#! hosts/lkp-csl-2ap3:
> model: Cascade Lake
> nr_node: 4
> nr_cpu: 192
> memory: 192G
> ssd_partitions:
> rootfs_partition: LABEL=LKP-ROOTFS
> kernel_cmdline_hw: acpi_rsdp=0x67f44014
> brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz
> :#! include/category/benchmark:
> kmsg:
> boot-time:
> uptime:
> iostat:
> heartbeat:
> vmstat:
> numa-numastat:
> numa-vmstat:
> numa-meminfo:
> proc-vmstat:
> proc-stat:
> meminfo:
> slabinfo:
> interrupts:
> lock_stat:
> perf-sched:
>   lite_mode: 1
> softirqs:
> bdi_dev_mapping:
> diskstats:
> nfsstat:
> cpuidle:
> cpufreq-stats:
> turbostat:
> sched_debug:
> perf-stat:
> mpstat:
> perf-profile:
>   lite_mode: 1
> :#! include/category/ALL:
> cpufreq_governor: performance
> :#! include/queue/cyclic:
> commit: a0918006f9284b77397ae4f163f055c3e0f987b2
> :#! include/testbox/lkp-csl-2ap3:
> need_kconfig_hw:
> - IGB: y
> - BLK_DEV_NVME
> ucode: '0x5003006'
> enqueue_time: 2021-10-27 22:23:36.647383432 +08:00
> _id: 617960f00b9a930a5af4f108
> _rt: "/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2"
> :#! schedule options:
> user: lkp
> compiler: gcc-9
> LKP_SERVER: internal-lkp-server
> head_commit: 955f175760f41ad2a80b07a390bac9a0444a47a6
> base_commit: 519d81956ee277b4419c723adfb154603c2565ba
> branch: linux-devel/devel-hourly-20211025-030231
> rootfs: debian-10.4-x86_64-20200603.cgz
> result_root: "/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/0"
> scheduler_version: "/lkp/lkp/.src-20211027-140142"
> arch: x86_64
> max_uptime: 2100
> initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
> bootloader_append:
> - root=/dev/ram0
> - user=lkp
> - job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-a0918006f9284b77397ae4f163-20211027-68186-ja0nr3-4.yaml
> - ARCH=x86_64
> - kconfig=x86_64-rhel-8.3
> - branch=linux-devel/devel-hourly-20211025-030231
> - commit=a0918006f9284b77397ae4f163f055c3e0f987b2
> - BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928
> - acpi_rsdp=0x67f44014
> - max_uptime=2100
> - RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-16-300s-TCP_CRR-ucode=0x5003006/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/0
> - LKP_SERVER=internal-lkp-server
> - nokaslr
> - selinux=0
> - debug
> - apic=debug
> - sysrq_always_enabled
> - rcupdate.rcu_cpu_stall_timeout=100
> - net.ifnames=0
> - printk.devkmsg=on
> - panic=-1
> - softlockup_panic=1
> - nmi_watchdog=panic
> - oops=panic
> - load_ramdisk=2
> - prompt_ramdisk=0
> - drbd.minor_count=8
> - systemd.log_level=err
> - ignore_loglevel
> - console=tty0
> - earlyprintk=ttyS0,115200
> - console=ttyS0,115200
> - vga=normal
> - rw
> modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/modules.cgz"
> bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210930.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20211025.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d25f27432f80-1_20211027.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/cluster_20211026.cgz"
> ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> site: inn
> :#! /lkp/lkp/.src-20211026-143536/include/site/inn:
> LKP_CGI_PORT: 80
> LKP_CIFS_PORT: 139
> oom-killer:
> watchdog:
> :#! runtime status:
> last_kernel: 5.15.0-rc6-wt-12022-g955f175760f4
> queue_at_least_once: 0
> :#! /lkp/lkp/.src-20211026-205023/include/site/inn:
> :#! user overrides:
> schedule_notify_address:
> kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/a0918006f9284b77397ae4f163f055c3e0f987b2/vmlinuz-5.15.0-rc4-00001-ga0918006f928"
> dequeue_time: 2021-10-28 02:02:15.174367353 +08:00
> :#! /lkp/lkp/.src-20211027-140142/include/site/inn:
> job_state: finished
> loadavg: 6.09 10.58 5.53 1/1355 19660
> start_time: '1635357811'
> end_time: '1635358116'
> version: "/lkp/lkp/.src-20211027-140222:5f87ddf4:8610dc698"

> 
> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
> do
> 	online_file="$cpu_dir"/online
> 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
> 
> 	file="$cpu_dir"/cpufreq/scaling_governor
> 	[ -f "$file" ] && echo "performance" > "$file"
> done
> 
> netserver -4 -D
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> netperf -4 -H 127.0.0.1 -t TCP_CRR -c -C -l 300  &
> wait


-- 
Kees Cook
