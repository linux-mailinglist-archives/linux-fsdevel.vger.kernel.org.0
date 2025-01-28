Return-Path: <linux-fsdevel+bounces-40221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3AA20902
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C226D3A7572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4919E98D;
	Tue, 28 Jan 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/GGqjNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9619E96D;
	Tue, 28 Jan 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061514; cv=none; b=BM6tmeXAK4ohB3A0ujTsMl3hF3nd7x6uhK1I85TuquRHkGi78/txKO4JaKI91cY4/nrQl3PTe6GfSl8GIGp5wOE9ZyVXOVsv1HzpYn1eG+qw0zg5Mk5ZjIWgY5Mv0duSpfoEbQ8CO4PTTjyyDf72lDa8rwlmKyF6vOa4ukWZzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061514; c=relaxed/simple;
	bh=Podf92ThYxfJvCKr3yrobJOSzhke9vx/tde8/KpZLIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpNxUvhCtGmp6cyQ2HZAa55OnEAaET5g36q9cGdnSK8skoB2w+EkJa6tA02NDAVohLJnwM/cyJZ+AIx2ykWKyYhhU8R87aOBh/q3XPkVfVCWUPw8SJ9NC/g2JvWQpOW45BfAdv5Sc0YCpazoh5M6hTMaPQw6nr0Up+YtH3+qsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/GGqjNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F7BC4CED3;
	Tue, 28 Jan 2025 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738061513;
	bh=Podf92ThYxfJvCKr3yrobJOSzhke9vx/tde8/KpZLIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/GGqjNG7Gln6Z+/cb+2xNjtHfLulhbNx6MJaQGfJXUIC8I22o0Ke2n7Xi7GuFM7d
	 s6AYUPIZWHPzfs4xSAbMTdF9zkO7ndu8KTvnY1NoTsxZzIn4Z0c/WgoXYLgfuHBuz7
	 MCeMmb3P4/SvylXHTT2/UXgxRoC7lG6ECmhOmkmZGGb3FeMqQEoiuKSfYpeSF2WFig
	 0/PlQiQC8l/mlVeGThDKQ08FqssMm0tRUsHp3y/UmEbBLOOLz7j6DV5MRXBXGJwGFL
	 ZqWjipW7DnREUqJUL94EzRBoC/UNiqY8g6to2M825UxXlborO8oxXYD9nn4vCK8Nxu
	 RhYltltTTA++g==
Date: Tue, 28 Jan 2025 11:51:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [pidfs]  16ecd47cb0:  stress-ng.fstat.ops_per_sec
 12.6% regression
Message-ID: <20250128-machart-bemessen-edd873223e02@brauner>
References: <202501272257.a95372bc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501272257.a95372bc-lkp@intel.com>

On Mon, Jan 27, 2025 at 10:32:11PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 12.6% regression of stress-ng.fstat.ops_per_sec on:

I'm confused about how this would affect stat performance given that it
has absolutely nothing to do with stat. Is this stating pidfds at least?


> 
> 
> commit: 16ecd47cb0cd895c7c2f5dd5db50f6c005c51639 ("pidfs: lookup pid through rbtree")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      aa22f4da2a46b484a257d167c67a2adc1b7aaf68]
> [test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]
> 
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: btrfs
> 	test: fstat
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.pthread.ops_per_sec 23.7% regression                                   |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
> | test parameters  | cpufreq_governor=performance                                                                |
> |                  | nr_threads=100%                                                                             |
> |                  | test=pthread                                                                                |
> |                  | testtime=60s                                                                                |
> +------------------+---------------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202501272257.a95372bc-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250127/202501272257.a95372bc-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fstat/stress-ng/60s
> 
> commit: 
>   59a42b0e78 ("selftests/pidfd: add pidfs file handle selftests")
>   16ecd47cb0 ("pidfs: lookup pid through rbtree")
> 
> 59a42b0e78888e2d 16ecd47cb0cd895c7c2f5dd5db5 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    2813179 ±  2%     -30.7%    1948548        cpuidle..usage
>       7.22            -6.8%       6.73 ±  2%  iostat.cpu.user
>       0.38            -0.0        0.33        mpstat.cpu.all.irq%
>    5683055 ±  5%     -13.3%    4926006 ± 10%  numa-meminfo.node1.Active
>    5683055 ±  5%     -13.3%    4926006 ± 10%  numa-meminfo.node1.Active(anon)
>     681017           -13.0%     592632        vmstat.system.cs
>     262754            -8.6%     240105        vmstat.system.in
>   25349297           -14.3%   21728755        numa-numastat.node0.local_node
>   25389508           -14.3%   21770830        numa-numastat.node0.numa_hit
>   26719069           -14.2%   22919085        numa-numastat.node1.local_node
>   26746344           -14.2%   22943171        numa-numastat.node1.numa_hit
>   25391110           -14.3%   21771814        numa-vmstat.node0.numa_hit
>   25350899           -14.3%   21729738        numa-vmstat.node0.numa_local
>    1423040 ±  5%     -13.3%    1233884 ± 10%  numa-vmstat.node1.nr_active_anon
>    1423039 ±  5%     -13.3%    1233883 ± 10%  numa-vmstat.node1.nr_zone_active_anon
>   26748443           -14.2%   22948826        numa-vmstat.node1.numa_hit
>   26721168           -14.2%   22924740        numa-vmstat.node1.numa_local
>    4274794           -12.6%    3735109        stress-ng.fstat.ops
>      71246           -12.6%      62251        stress-ng.fstat.ops_per_sec
>   13044663           -10.2%   11715455        stress-ng.time.involuntary_context_switches
>       4590            -2.1%       4492        stress-ng.time.percent_of_cpu_this_job_got
>       2545            -1.6%       2503        stress-ng.time.system_time
>     212.55            -8.2%     195.17 ±  2%  stress-ng.time.user_time
>    6786385           -12.7%    5924000        stress-ng.time.voluntary_context_switches
>    9685654 ±  2%     +15.2%   11161628 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
>    4917374 ±  6%     +26.4%    6217585 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.min
>    9685655 ±  2%     +15.2%   11161628 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
>    4917374 ±  6%     +26.4%    6217586 ±  8%  sched_debug.cfs_rq:/.min_vruntime.min
>     319.78 ±  4%      -8.9%     291.47 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
>     331418           -12.3%     290724        sched_debug.cpu.nr_switches.avg
>     349777           -12.0%     307943        sched_debug.cpu.nr_switches.max
>     247719 ±  5%     -18.2%     202753 ±  2%  sched_debug.cpu.nr_switches.min
>    1681668            -5.8%    1584232        proc-vmstat.nr_active_anon
>    2335388            -4.2%    2237095        proc-vmstat.nr_file_pages
>    1434429            -6.9%    1336146        proc-vmstat.nr_shmem
>      50745            -2.5%      49497        proc-vmstat.nr_slab_unreclaimable
>    1681668            -5.8%    1584232        proc-vmstat.nr_zone_active_anon
>   52137742           -14.2%   44716504        proc-vmstat.numa_hit
>   52070256           -14.2%   44650343        proc-vmstat.numa_local
>   57420831           -13.4%   49744871        proc-vmstat.pgalloc_normal
>   54983559           -13.7%   47445719        proc-vmstat.pgfree
>       1.30           -10.6%       1.17        perf-stat.i.MPKI
>  2.797e+10            -7.0%    2.6e+10        perf-stat.i.branch-instructions
>       0.32 ±  4%      +0.0        0.33        perf-stat.i.branch-miss-rate%
>      24.15            -1.1       23.00        perf-stat.i.cache-miss-rate%
>  1.689e+08           -17.1%  1.401e+08        perf-stat.i.cache-misses
>   6.99e+08           -12.9%  6.085e+08        perf-stat.i.cache-references
>     708230           -12.7%     618047        perf-stat.i.context-switches
>       1.71            +8.2%       1.85        perf-stat.i.cpi
>     115482            -2.7%     112333        perf-stat.i.cpu-migrations
>       1311           +21.2%       1588        perf-stat.i.cycles-between-cache-misses
>  1.288e+11            -7.3%  1.195e+11        perf-stat.i.instructions
>       0.59            -7.4%       0.55        perf-stat.i.ipc
>      12.84           -11.0%      11.43        perf-stat.i.metric.K/sec
>       1.31           -10.5%       1.17        perf-stat.overall.MPKI
>       0.29 ±  4%      +0.0        0.30        perf-stat.overall.branch-miss-rate%
>      24.21            -1.1       23.07        perf-stat.overall.cache-miss-rate%
>       1.71            +8.2%       1.85        perf-stat.overall.cpi
>       1303           +21.0%       1576        perf-stat.overall.cycles-between-cache-misses
>       0.58            -7.6%       0.54        perf-stat.overall.ipc
>  2.724e+10            -6.8%  2.539e+10        perf-stat.ps.branch-instructions
>  1.648e+08           -16.8%  1.371e+08        perf-stat.ps.cache-misses
>  6.807e+08           -12.7%  5.943e+08        perf-stat.ps.cache-references
>     689389           -12.5%     603372        perf-stat.ps.context-switches
>  1.255e+11            -7.0%  1.167e+11        perf-stat.ps.instructions
>  7.621e+12            -6.9%  7.097e+12        perf-stat.total.instructions
>      56.06           -56.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      56.04           -56.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      31.25           -31.2        0.00        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      31.23           -31.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      31.22           -31.2        0.00        perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      27.58           -27.6        0.00        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
>      23.72           -23.7        0.00        perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      23.68           -23.7        0.00        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      20.15           -20.2        0.00        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      19.23           -19.2        0.00        perf-profile.calltrace.cycles-pp.fstatat64
>      16.51           -16.5        0.00        perf-profile.calltrace.cycles-pp.statx
>      14.81           -14.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
>      14.52           -14.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
>      14.52           -14.5        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
>      14.05           -14.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3
>      14.04           -14.0        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
>      13.55           -13.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit
>      13.24           -13.2        0.00        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
>      13.08           -13.1        0.00        perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
>      12.01           -12.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.statx
>      11.93           -11.9        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.__x64_sys_exit
>      11.76           -11.8        0.00        perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
>      11.72           -11.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
>      11.45           -11.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
>      10.27           -10.3        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_statx.do_syscall_64.entry_SYSCALL_64_after_hwframe.statx
>       7.21            -7.2        0.00        perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.25            -5.3        0.00        perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
>      86.11           -86.1        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      85.52           -85.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
>      41.40           -41.4        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>      40.49           -40.5        0.00        perf-profile.children.cycles-pp.queued_write_lock_slowpath
>      31.57           -31.6        0.00        perf-profile.children.cycles-pp.x64_sys_call
>      31.23           -31.2        0.00        perf-profile.children.cycles-pp.do_exit
>      31.23           -31.2        0.00        perf-profile.children.cycles-pp.__x64_sys_exit
>      27.59           -27.6        0.00        perf-profile.children.cycles-pp.exit_notify
>      23.72           -23.7        0.00        perf-profile.children.cycles-pp.__do_sys_clone3
>      23.69           -23.7        0.00        perf-profile.children.cycles-pp.kernel_clone
>      20.18           -20.2        0.00        perf-profile.children.cycles-pp.copy_process
>      19.70           -19.7        0.00        perf-profile.children.cycles-pp.fstatat64
>      16.58           -16.6        0.00        perf-profile.children.cycles-pp.statx
>      13.51           -13.5        0.00        perf-profile.children.cycles-pp.__do_sys_newfstatat
>      13.25           -13.2        0.00        perf-profile.children.cycles-pp.release_task
>      12.22           -12.2        0.00        perf-profile.children.cycles-pp.vfs_fstatat
>      11.38           -11.4        0.00        perf-profile.children.cycles-pp.vfs_statx
>      10.36           -10.4        0.00        perf-profile.children.cycles-pp.__x64_sys_statx
>       8.25            -8.3        0.00        perf-profile.children.cycles-pp.filename_lookup
>       7.89            -7.9        0.00        perf-profile.children.cycles-pp.getname_flags
>       7.74            -7.7        0.00        perf-profile.children.cycles-pp.path_lookupat
>      41.39           -41.4        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> 
> ***************************************************************************************************
> lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/pthread/stress-ng/60s
> 
> commit: 
>   59a42b0e78 ("selftests/pidfd: add pidfs file handle selftests")
>   16ecd47cb0 ("pidfs: lookup pid through rbtree")
> 
> 59a42b0e78888e2d 16ecd47cb0cd895c7c2f5dd5db5 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  6.458e+08 ±  3%     -20.7%  5.119e+08 ±  6%  cpuidle..time
>    4424460 ±  4%     -56.5%    1923713 ±  2%  cpuidle..usage
>       1916           +17.2%       2245 ±  2%  vmstat.procs.r
>     880095           -24.7%     662885        vmstat.system.cs
>     717291            -7.6%     662983        vmstat.system.in
>       4.81            -0.9        3.87 ±  2%  mpstat.cpu.all.idle%
>       0.48            -0.1        0.42        mpstat.cpu.all.irq%
>       0.32 ±  3%      -0.1        0.26 ±  2%  mpstat.cpu.all.soft%
>       1.77            -0.3        1.46        mpstat.cpu.all.usr%
>   43182538           -21.9%   33726626        numa-numastat.node0.local_node
>   43338607           -22.0%   33814109        numa-numastat.node0.numa_hit
>   43334202           -22.8%   33451907        numa-numastat.node1.local_node
>   43415892           -22.6%   33601910        numa-numastat.node1.numa_hit
>   43339112           -22.0%   33811967        numa-vmstat.node0.numa_hit
>   43183037           -21.9%   33724483        numa-vmstat.node0.numa_local
>   43416602           -22.6%   33599378        numa-vmstat.node1.numa_hit
>   43334912           -22.8%   33449374        numa-vmstat.node1.numa_local
>      13189 ± 14%     -24.0%      10022 ± 19%  perf-c2c.DRAM.local
>       9611 ± 16%     -28.8%       6844 ± 17%  perf-c2c.DRAM.remote
>      16436 ± 15%     -32.1%      11162 ± 19%  perf-c2c.HITM.local
>       4431 ± 16%     -30.8%       3064 ± 19%  perf-c2c.HITM.remote
>      20868 ± 15%     -31.8%      14226 ± 19%  perf-c2c.HITM.total
>     205629           +67.1%     343625        stress-ng.pthread.nanosecs_to_start_a_pthread
>   12690825           -23.7%    9689255        stress-ng.pthread.ops
>     210833           -23.7%     160924        stress-ng.pthread.ops_per_sec
>    5684649           -16.0%    4772378        stress-ng.time.involuntary_context_switches
>   26588792           -21.0%   20998281        stress-ng.time.minor_page_faults
>      12705            +5.1%      13353        stress-ng.time.percent_of_cpu_this_job_got
>       7559            +5.6%       7986        stress-ng.time.system_time
>     132.77           -24.1%     100.72        stress-ng.time.user_time
>   29099733           -22.3%   22601666        stress-ng.time.voluntary_context_switches
>     340547            +1.4%     345226        proc-vmstat.nr_mapped
>     150971            -3.2%     146184        proc-vmstat.nr_page_table_pages
>      48017            -2.0%      47078        proc-vmstat.nr_slab_reclaimable
>     540694 ±  9%     +50.6%     814286 ± 15%  proc-vmstat.numa_hint_faults
>     255145 ± 22%     +62.3%     414122 ± 17%  proc-vmstat.numa_hint_faults_local
>   86757062           -22.3%   67418409        proc-vmstat.numa_hit
>   86519300           -22.4%   67180920        proc-vmstat.numa_local
>   89935256           -22.2%   69939407        proc-vmstat.pgalloc_normal
>   27887502           -20.1%   22295448        proc-vmstat.pgfault
>   86343992           -22.7%   66777255        proc-vmstat.pgfree
>    1187131 ± 23%     -42.2%     686568 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
>   12970740 ± 42%     -49.3%    6577803 ± 11%  sched_debug.cfs_rq:/.left_deadline.max
>    2408752 ±  4%      -9.6%    2177658 ±  2%  sched_debug.cfs_rq:/.left_deadline.stddev
>   12970554 ± 42%     -49.3%    6577515 ± 11%  sched_debug.cfs_rq:/.left_vruntime.max
>    2408688 ±  4%      -9.6%    2177606 ±  2%  sched_debug.cfs_rq:/.left_vruntime.stddev
>    1187132 ± 23%     -42.2%     686568 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
>   12970563 ± 42%     -49.3%    6577516 ± 11%  sched_debug.cfs_rq:/.right_vruntime.max
>    2408788 ±  4%      -9.6%    2177610 ±  2%  sched_debug.cfs_rq:/.right_vruntime.stddev
>    2096120           -68.2%     665792        sched_debug.cpu.curr->pid.max
>     655956 ±  8%     -53.1%     307752        sched_debug.cpu.curr->pid.stddev
>     124008           -24.6%      93528        sched_debug.cpu.nr_switches.avg
>     270857 ±  4%     -38.9%     165624 ± 10%  sched_debug.cpu.nr_switches.max
>      27972 ± 13%     -67.5%       9102 ± 17%  sched_debug.cpu.nr_switches.stddev
>     179.43 ±  4%     +17.8%     211.44 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
>       4.21           -13.4%       3.65        perf-stat.i.MPKI
>   2.03e+10            -8.3%  1.863e+10        perf-stat.i.branch-instructions
>       0.66            -0.1        0.61        perf-stat.i.branch-miss-rate%
>  1.289e+08           -16.7%  1.074e+08        perf-stat.i.branch-misses
>      39.17            +0.7       39.92        perf-stat.i.cache-miss-rate%
>  3.806e+08           -21.8%  2.976e+08        perf-stat.i.cache-misses
>  9.691e+08           -23.3%  7.437e+08        perf-stat.i.cache-references
>     903142           -24.9%     678436        perf-stat.i.context-switches
>       6.89           +11.5%       7.69        perf-stat.i.cpi
>  6.239e+11            +1.0%  6.304e+11        perf-stat.i.cpu-cycles
>     311004           -18.5%     253387        perf-stat.i.cpu-migrations
>       1631           +29.1%       2106        perf-stat.i.cycles-between-cache-misses
>  9.068e+10            -9.7%  8.192e+10        perf-stat.i.instructions
>       0.15            -9.5%       0.14        perf-stat.i.ipc
>      10.41           -22.2%       8.11        perf-stat.i.metric.K/sec
>     462421           -19.7%     371144        perf-stat.i.minor-faults
>     668589           -21.0%     527974        perf-stat.i.page-faults
>       4.22           -13.6%       3.65        perf-stat.overall.MPKI
>       0.63            -0.1        0.57        perf-stat.overall.branch-miss-rate%
>      39.29            +0.7       40.04        perf-stat.overall.cache-miss-rate%
>       6.94           +11.7%       7.75        perf-stat.overall.cpi
>       1643           +29.3%       2125        perf-stat.overall.cycles-between-cache-misses
>       0.14           -10.5%       0.13        perf-stat.overall.ipc
>  1.971e+10            -8.6%  1.801e+10        perf-stat.ps.branch-instructions
>  1.237e+08           -17.2%  1.024e+08        perf-stat.ps.branch-misses
>  3.713e+08           -22.3%  2.887e+08        perf-stat.ps.cache-misses
>  9.451e+08           -23.7%   7.21e+08        perf-stat.ps.cache-references
>     883135           -25.3%     659967        perf-stat.ps.context-switches
>     304186           -18.9%     246645        perf-stat.ps.cpu-migrations
>  8.797e+10           -10.0%  7.916e+10        perf-stat.ps.instructions
>     445107           -20.6%     353509        perf-stat.ps.minor-faults
>     646755           -21.7%     506142        perf-stat.ps.page-faults
>  5.397e+12           -10.2%  4.846e+12        perf-stat.total.instructions
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
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

