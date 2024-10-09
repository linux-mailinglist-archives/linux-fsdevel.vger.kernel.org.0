Return-Path: <linux-fsdevel+bounces-31429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8529966C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 12:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9ECB296E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB028189520;
	Wed,  9 Oct 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEFNio7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092D185949;
	Wed,  9 Oct 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468786; cv=none; b=c06F5mVXZGim41JJjPHNrFagqHrHh9eXdoyhwh/p2pkQzzt0tlESqqJ1sFPhPhLe1TV+/3cEbxXYeSVqOdCergs3TuNj0zUW1nRYAhdUS14yrnjiRySPcWE1HxsLiiXWvT65M8NuqNP6vFO6oQLqEjn3myX4TmK7U0Ps9Ec1PoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468786; c=relaxed/simple;
	bh=az+rruHdF8P844YqXUcm7w8MLFj0jnkdyDyySTRZxgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXFP8Bir+TjgslyRrOWl1QBkyr4IbbvSK9+6z9SaYhx75SR2oqPcshp+ukhpcacGZvHxtByg9NX3BRqzznX7PRI9of/0nLd4Zxq0QQI0Ic4bzrDTrlKnpUuadbGGH/ySJaBIcg6nvfpCzh5iY3Jcfqr8scn7S86sayNTtLmlRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEFNio7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DC5C4CEC5;
	Wed,  9 Oct 2024 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728468785;
	bh=az+rruHdF8P844YqXUcm7w8MLFj0jnkdyDyySTRZxgA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nEFNio7fhwE7REu2yU8krOUUWDv8DYxiP4Zw2x0lXjJcn7S28pom+I405O6hCTb2Z
	 l4V8qWNIj731xHm2eD7tvMdQc8PWaDYNi7AFVKJbiDElDA+9Q/Lf05SSr/Stsbqviv
	 pboI7xsjBixI6ml44hCD9hHYYmfR+k7f9yXJGwd7QOeSEi9PbzbEkCLLQwbrYag7Wx
	 kvPeClWl1+xYulQ0yNc40aflSoJNifpET8LJfTvX2QORv8qK/oNvNnMd3/v5gne7kn
	 55geiilII9jO2NsY2RSK8q7k17p9AgUjFtqf1fUEipNVNsihSY7qA/oyQxGPqcc5Av
	 QyS+bR5h9NwQw==
Message-ID: <e92fb0fb1fe716659319007fcecd0afc98c3839b.camel@kernel.org>
Subject: Re: [linux-next:master] [fs]  2e4c6e78f4: 
 will-it-scale.per_thread_ops -5.7% regression
From: Jeff Layton <jlayton@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Linux Memory Management List
 <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jan Kara
 <jack@suse.cz>,  linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
 feng.tang@intel.com,  fengwei.yin@intel.com
Date: Wed, 09 Oct 2024 06:13:03 -0400
In-Reply-To: <202410091041.6f5d221e-oliver.sang@intel.com>
References: <202410091041.6f5d221e-oliver.sang@intel.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 10:53 +0800, kernel test robot wrote:
> hi, Jeff Layton,
>=20
> we reported
> "[brauner-vfs:vfs.mgtime] [fs]  a037d5e7f8: will-it-scale.per_thread_ops =
-5.5% regression"
> for this commit about one month ago.
>=20
> we also saw you sent out patch for it.
>=20
> now we noticed the commit is merged into linux-next/master now. besides
> will-it-scale, we also captured a hackbench regression. so we report this=
 again
> FYI what we observed in our tests. thanks
>=20
>=20
>=20
> Hello,
>=20
> kernel test robot noticed a -5.7% regression of will-it-scale.per_thread_=
ops on:
>=20

This is consistent with the results I was getting in my own testing.
The multigrain series does cause a small performance hit in this sort
of microbenchmark as fetching the floor and manipulating it has a cost.
I don't think there is much we can do to mitigate that unfortunately.

>=20
> commit: 2e4c6e78f41afefb7a2b825b7aa4d90070720992 ("fs: add infrastructure=
 for multigrain timestamps")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
> testcase: will-it-scale
> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @=
 2.90GHz (Cooper Lake) with 192G memory
> parameters:
>=20
> 	nr_task: 100%
> 	mode: thread
> 	test: pipe1
> 	cpufreq_governor: performance
>=20
>=20
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>=20
> +------------------+-----------------------------------------------------=
---------------------------------------+
> > testcase: change | hackbench: hackbench.throughput -4.5% regression    =
                                       |
> > test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU=
 @ 2.00GHz (Ice Lake) with 256G memory |
> > test parameters  | cpufreq_governor=3Dperformance                      =
                                         |
> >                  | ipc=3Dpipe                                          =
                                         |
> >                  | iterations=3D4                                      =
                                         |
> >                  | mode=3Dthreads                                      =
                                         |
> >                  | nr_threads=3D800%                                   =
                                         |
> +------------------+-----------------------------------------------------=
---------------------------------------+
> > testcase: change | will-it-scale: will-it-scale.per_process_ops -2.0% r=
egression                              |
> > test machine     | 104 threads 2 sockets (Skylake) with 192G memory    =
                                       |
> > test parameters  | cpufreq_governor=3Dperformance                      =
                                         |
> >                  | mode=3Dprocess                                      =
                                         |
> >                  | nr_task=3D100%                                      =
                                         |
> >                  | test=3Dpipe1                                        =
                                         |
> +------------------+-----------------------------------------------------=
---------------------------------------+
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202410091041.6f5d221e-oliver.san=
g@intel.com
>=20
>=20
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241009/202410091041.6f5d221e-ol=
iver.sang@intel.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-2024020=
6.cgz/lkp-cpl-4sp2/pipe1/will-it-scale
>=20
> commit:=20
>   v6.12-rc1
>   2e4c6e78f4 ("fs: add infrastructure for multigrain timestamps")
>=20
>        v6.12-rc1 2e4c6e78f41afefb7a2b825b7aa=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>     806865 =C2=B1 12%    +127.6%    1836795 =C2=B1 68%  numa-meminfo.node=
3.FilePages
>      32494 =C2=B1  7%     +39.2%      45235 =C2=B1 25%  numa-meminfo.node=
3.Mapped
>     201722 =C2=B1 12%    +127.7%     459227 =C2=B1 68%  numa-vmstat.node3=
.nr_file_pages
>       8032 =C2=B1  7%     +38.6%      11136 =C2=B1 26%  numa-vmstat.node3=
.nr_mapped
>    2657388 =C2=B1 13%     -28.2%    1907049 =C2=B1 11%  sched_debug.cfs_r=
q:/.avg_vruntime.stddev
>    2657388 =C2=B1 13%     -28.2%    1907049 =C2=B1 11%  sched_debug.cfs_r=
q:/.min_vruntime.stddev
>  2.921e+08            -5.7%  2.754e+08        will-it-scale.224.threads
>    1303879            -5.7%    1229301        will-it-scale.per_thread_op=
s
>  2.921e+08            -5.7%  2.754e+08        will-it-scale.workload
>     210109            +1.5%     213268        proc-vmstat.nr_active_anon
>     222111            +1.5%     225492        proc-vmstat.nr_shmem
>     210109            +1.5%     213268        proc-vmstat.nr_zone_active_=
anon
>     164529            +1.6%     167080        proc-vmstat.pgactivate
>       1.52 =C2=B1 82%     -78.7%       0.32 =C2=B1 18%  perf-sched.sch_de=
lay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unkn=
own].[unknown]
>       3.03 =C2=B1 82%     -78.7%       0.65 =C2=B1 18%  perf-sched.wait_a=
nd_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.=
[unknown].[unknown]
>      28.66 =C2=B1 95%     -75.5%       7.01 =C2=B1  5%  perf-sched.wait_a=
nd_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_stat=
e.kernel_clone
>       1.52 =C2=B1 82%     -78.7%       0.32 =C2=B1 18%  perf-sched.wait_t=
ime.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unkn=
own].[unknown]
>      27.97 =C2=B1 98%     -76.0%       6.72 =C2=B1  5%  perf-sched.wait_t=
ime.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>  1.971e+08 =C2=B1  4%     +13.2%  2.231e+08 =C2=B1  2%  perf-stat.i.branc=
h-misses
>       1.11            -2.3%       1.09        perf-stat.i.cpi
>  6.697e+11            +2.2%  6.842e+11        perf-stat.i.instructions
>       0.90            +2.3%       0.92        perf-stat.i.ipc
>       0.00 =C2=B1141%    +162.1%       0.01 =C2=B1 38%  perf-stat.i.major=
-faults
>       0.12 =C2=B1  4%      +0.0        0.14 =C2=B1  2%  perf-stat.overall=
.branch-miss-rate%
>       1.11            -2.2%       1.09        perf-stat.overall.cpi
>       0.90            +2.3%       0.92        perf-stat.overall.ipc
>     695559            +8.3%     753229        perf-stat.overall.path-leng=
th
>  1.964e+08 =C2=B1  4%     +13.2%  2.223e+08 =C2=B1  2%  perf-stat.ps.bran=
ch-misses
>  6.676e+11            +2.2%   6.82e+11        perf-stat.ps.instructions
>       0.00 =C2=B1141%    +167.2%       0.01 =C2=B1 41%  perf-stat.ps.majo=
r-faults
>  2.032e+14            +2.1%  2.074e+14        perf-stat.total.instruction=
s
>       7.01            -0.4        6.62        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.write
>       7.02            -0.4        6.66        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.read
>       5.52            -0.4        5.17        perf-profile.calltrace.cycl=
es-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
>       5.47            -0.3        5.15        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.read
>       5.47            -0.3        5.16        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.write
>       4.27            -0.2        4.02        perf-profile.calltrace.cycl=
es-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
>       3.87            -0.2        3.64 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_wr=
ite
>       3.16            -0.2        3.00        perf-profile.calltrace.cycl=
es-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
>      53.32            -0.1       53.18        perf-profile.calltrace.cycl=
es-pp.write
>       2.12            -0.1        1.98        perf-profile.calltrace.cycl=
es-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1.59            -0.1        1.48        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock_irqsave.__wake_up_sync_key.pipe_write.vfs_write.ksys_w=
rite
>       1.12            -0.1        1.03        perf-profile.calltrace.cycl=
es-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.read
>       0.97            -0.1        0.89        perf-profile.calltrace.cycl=
es-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.72            -0.1        1.64        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1.67            -0.1        1.60        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.18            -0.1        1.11        perf-profile.calltrace.cycl=
es-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.98            -0.1        0.90        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.17            -0.1        1.10 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.write
>       0.98            -0.1        0.92        perf-profile.calltrace.cycl=
es-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.98            -0.1        0.92        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.97            -0.1        0.92        perf-profile.calltrace.cycl=
es-pp.fput.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.63 =C2=B1  3%      -0.1        0.58        perf-profile.calltrace=
.cycles-pp.testcase
>       0.00            +0.5        0.54 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.timestamp_truncate.current_time.inode_needs_update_time.file_upd=
ate_time.pipe_write
>       0.00            +0.5        0.55 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.timestamp_truncate.current_time.atime_needs_update.touch_atime.p=
ipe_read
>       0.00            +0.7        0.68 =C2=B1 11%  perf-profile.calltrace=
.cycles-pp.ktime_get_coarse_ts64.coarse_ctime.current_time.atime_needs_upda=
te.touch_atime
>      35.70            +0.9       36.58        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.write
>      34.80            +0.9       35.74        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>      32.06            +1.0       33.08        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.read
>      31.16            +1.1       32.24        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.00            +1.1        1.10 =C2=B1 16%  perf-profile.calltrace=
.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_ti=
me.pipe_write
>      30.51            +1.2       31.73        perf-profile.calltrace.cycl=
es-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>      25.27            +1.3       26.57        perf-profile.calltrace.cycl=
es-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>      27.06            +1.4       28.44        perf-profile.calltrace.cycl=
es-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      22.04            +1.5       23.51        perf-profile.calltrace.cycl=
es-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.00            +1.5        1.48 =C2=B1  3%  perf-profile.calltrace=
.cycles-pp.coarse_ctime.current_time.atime_needs_update.touch_atime.pipe_re=
ad
>      17.63            +1.8       19.44        perf-profile.calltrace.cycl=
es-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>      14.70            +2.0       16.71        perf-profile.calltrace.cycl=
es-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
>       4.15            +2.3        6.50        perf-profile.calltrace.cycl=
es-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.79            +2.4        4.15        perf-profile.calltrace.cycl=
es-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
>       3.76            +2.4        6.13        perf-profile.calltrace.cycl=
es-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
>       2.04 =C2=B1 12%      +2.5        4.53 =C2=B1  5%  perf-profile.call=
trace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall=
_64
>       1.76 =C2=B1 14%      +2.5        4.26 =C2=B1  5%  perf-profile.call=
trace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_wri=
te.ksys_write
>       0.00            +3.5        3.46 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write=
.vfs_write
>      14.13            -0.8       13.36        perf-profile.children.cycle=
s-pp.clear_bhb_loop
>       7.00            -0.4        6.60        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>       5.64            -0.4        5.28        perf-profile.children.cycle=
s-pp.copy_page_from_iter
>       4.19            -0.3        3.94        perf-profile.children.cycle=
s-pp._copy_from_iter
>       4.34            -0.2        4.08        perf-profile.children.cycle=
s-pp.copy_page_to_iter
>       4.12            -0.2        3.88        perf-profile.children.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>       3.42            -0.2        3.25        perf-profile.children.cycle=
s-pp._copy_to_iter
>       3.51            -0.2        3.35        perf-profile.children.cycle=
s-pp.mutex_lock
>       2.15            -0.2        1.99        perf-profile.children.cycle=
s-pp.x64_sys_call
>      53.53            -0.2       53.38        perf-profile.children.cycle=
s-pp.write
>       2.41            -0.2        2.26        perf-profile.children.cycle=
s-pp.syscall_exit_to_user_mode
>       2.21            -0.1        2.07        perf-profile.children.cycle=
s-pp.__wake_up_sync_key
>       2.16            -0.1        2.02        perf-profile.children.cycle=
s-pp.fput
>       2.03            -0.1        1.90        perf-profile.children.cycle=
s-pp.mutex_unlock
>       1.60            -0.1        1.50        perf-profile.children.cycle=
s-pp._raw_spin_lock_irqsave
>       0.73 =C2=B1  4%      -0.1        0.67        perf-profile.children.=
cycles-pp.testcase
>       0.64 =C2=B1  4%      -0.0        0.60 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.aa_file_perm
>       0.77            -0.0        0.74        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_safe_stack
>       0.38            -0.0        0.35        perf-profile.children.cycle=
s-pp.__x64_sys_read
>       0.40            -0.0        0.38        perf-profile.children.cycle=
s-pp.__x64_sys_write
>       0.32            -0.0        0.30        perf-profile.children.cycle=
s-pp.kill_fasync
>       0.16 =C2=B1  3%      -0.0        0.14 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.make_vfsgid
>       0.30            -0.0        0.29        perf-profile.children.cycle=
s-pp._raw_spin_unlock_irqrestore
>       0.00            +0.4        0.41 =C2=B1 26%  perf-profile.children.=
cycles-pp.set_normalized_timespec64
>       0.43 =C2=B1 13%      +0.7        1.14 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.timestamp_truncate
>       0.00            +1.0        0.95 =C2=B1  4%  perf-profile.children.=
cycles-pp.ktime_get_coarse_with_offset
>       0.00            +1.1        1.06        perf-profile.children.cycle=
s-pp.ns_to_timespec64
>       0.00            +1.2        1.17 =C2=B1  3%  perf-profile.children.=
cycles-pp.ktime_get_coarse_ts64
>      30.76            +1.2       31.97        perf-profile.children.cycle=
s-pp.ksys_write
>      25.47            +1.3       26.75        perf-profile.children.cycle=
s-pp.vfs_write
>      27.19            +1.4       28.55        perf-profile.children.cycle=
s-pp.ksys_read
>      22.13            +1.4       23.57        perf-profile.children.cycle=
s-pp.vfs_read
>      17.81            +1.8       19.60        perf-profile.children.cycle=
s-pp.pipe_write
>      68.06            +1.9       69.94        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      15.02            +2.0       17.01        perf-profile.children.cycle=
s-pp.pipe_read
>      66.19            +2.0       68.19        perf-profile.children.cycle=
s-pp.do_syscall_64
>       4.24            +2.3        6.58        perf-profile.children.cycle=
s-pp.touch_atime
>       3.86            +2.4        6.23        perf-profile.children.cycle=
s-pp.atime_needs_update
>       1.88 =C2=B1 13%      +2.5        4.34 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.inode_needs_update_time
>       2.11 =C2=B1 12%      +2.5        4.60 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.file_update_time
>       0.00            +2.7        2.66 =C2=B1  6%  perf-profile.children.=
cycles-pp.coarse_ctime
>       1.82            +6.2        8.04 =C2=B1  2%  perf-profile.children.=
cycles-pp.current_time
>      14.05            -0.8       13.28        perf-profile.self.cycles-pp=
.clear_bhb_loop
>       1.06 =C2=B1  8%      -0.4        0.67        perf-profile.self.cycl=
es-pp.inode_needs_update_time
>       5.00 =C2=B1  3%      -0.3        4.67 =C2=B1  3%  perf-profile.self=
.cycles-pp.vfs_write
>       4.10 =C2=B1  3%      -0.3        3.78 =C2=B1  3%  perf-profile.self=
.cycles-pp.vfs_read
>       3.71            -0.2        3.48 =C2=B1  2%  perf-profile.self.cycl=
es-pp._copy_from_iter
>       3.98            -0.2        3.75        perf-profile.self.cycles-pp=
.entry_SYSRETQ_unsafe_stack
>       2.89            -0.2        2.68        perf-profile.self.cycles-pp=
.do_syscall_64
>       3.38            -0.2        3.17        perf-profile.self.cycles-pp=
.read
>       2.91            -0.2        2.71 =C2=B1  2%  perf-profile.self.cycl=
es-pp._copy_to_iter
>       3.48            -0.2        3.28        perf-profile.self.cycles-pp=
.write
>       3.06            -0.2        2.88        perf-profile.self.cycles-pp=
.entry_SYSCALL_64
>       1.76            -0.2        1.60        perf-profile.self.cycles-pp=
.atime_needs_update
>       2.03            -0.2        1.88        perf-profile.self.cycles-pp=
.x64_sys_call
>       1.90            -0.1        1.78        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       2.18            -0.1        2.07        perf-profile.self.cycles-pp=
.mutex_lock
>       1.93            -0.1        1.82        perf-profile.self.cycles-pp=
.mutex_unlock
>       1.92            -0.1        1.81        perf-profile.self.cycles-pp=
.fput
>       1.46            -0.1        1.36        perf-profile.self.cycles-pp=
.syscall_exit_to_user_mode
>       1.54            -0.1        1.45        perf-profile.self.cycles-pp=
._raw_spin_lock_irqsave
>       1.06            -0.1        0.98        perf-profile.self.cycles-pp=
.ksys_read
>       1.19            -0.1        1.11        perf-profile.self.cycles-pp=
.ksys_write
>       0.58 =C2=B1  4%      -0.1        0.53        perf-profile.self.cycl=
es-pp.testcase
>       0.77            -0.0        0.74        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_safe_stack
>       0.38            -0.0        0.36 =C2=B1  2%  perf-profile.self.cycl=
es-pp.touch_atime
>       0.30            -0.0        0.28        perf-profile.self.cycles-pp=
.__x64_sys_write
>       0.35            -0.0        0.33        perf-profile.self.cycles-pp=
.__wake_up_sync_key
>       0.28            -0.0        0.26        perf-profile.self.cycles-pp=
.__x64_sys_read
>       0.25            -0.0        0.24        perf-profile.self.cycles-pp=
.kill_fasync
>       0.26            +0.0        0.29        perf-profile.self.cycles-pp=
.file_update_time
>       0.00            +0.4        0.40 =C2=B1 25%  perf-profile.self.cycl=
es-pp.set_normalized_timespec64
>       0.40 =C2=B1 11%      +0.7        1.06 =C2=B1  4%  perf-profile.self=
.cycles-pp.timestamp_truncate
>       0.00            +0.9        0.89        perf-profile.self.cycles-pp=
.ns_to_timespec64
>       0.00            +0.9        0.91 =C2=B1  4%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_with_offset
>       0.00            +1.1        1.10 =C2=B1  5%  perf-profile.self.cycl=
es-pp.coarse_ctime
>       0.00            +1.1        1.11 =C2=B1  3%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_ts64
>       1.06 =C2=B1  5%      +1.4        2.44 =C2=B1  2%  perf-profile.self=
.cycles-pp.current_time
>=20
>=20
> *************************************************************************=
**************************
> lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00=
GHz (Ice Lake) with 256G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/t=
box_group/testcase:
>   gcc-12/performance/pipe/4/x86_64-rhel-8.3/threads/800%/debian-12-x86_64=
-20240206.cgz/lkp-icl-2sp2/hackbench
>=20
> commit:=20
>   v6.12-rc1
>   2e4c6e78f4 ("fs: add infrastructure for multigrain timestamps")
>=20
>        v6.12-rc1 2e4c6e78f41afefb7a2b825b7aa=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>     561190 =C2=B1 49%     -33.6%     372781 =C2=B1 77%  numa-meminfo.node=
0.SUnreclaim
>     137108 =C2=B1 48%     -35.9%      87915 =C2=B1 74%  numa-vmstat.node0=
.nr_slab_unreclaimable
>  2.263e+08 =C2=B1  3%     -13.7%  1.954e+08 =C2=B1  7%  perf-stat.i.cache=
-misses
>  7.636e+08 =C2=B1  5%     -14.5%  6.531e+08 =C2=B1  9%  perf-stat.i.cache=
-references
>      18.89 =C2=B1 18%     -31.6%      12.92 =C2=B1 21%  perf-stat.i.metri=
c.K/sec
>     246747            -3.4%     238348        proc-vmstat.nr_anon_pages
>     383468 =C2=B1 36%     -19.0%     310490 =C2=B1  2%  proc-vmstat.nr_in=
active_anon
>       2246 =C2=B1  3%      -4.9%       2135 =C2=B1  2%  proc-vmstat.nr_pa=
ge_table_pages
>     383468 =C2=B1 36%     -19.0%     310490 =C2=B1  2%  proc-vmstat.nr_zo=
ne_inactive_anon
>    1231417            -4.5%    1175946        hackbench.throughput
>    1179456            -3.7%    1136004        hackbench.throughput_avg
>    1231417            -4.5%    1175946        hackbench.throughput_best
>       5279            +4.8%       5530        hackbench.time.system_time
>     954.46            -0.8%     946.55        hackbench.time.user_time
>       0.12 =C2=B1  8%     -36.0%       0.08 =C2=B1 23%  sched_debug.cfs_r=
q:/.h_nr_running.avg
>       0.33 =C2=B1  4%     -21.5%       0.26 =C2=B1 11%  sched_debug.cfs_r=
q:/.h_nr_running.stddev
>      77.21 =C2=B1 38%     -50.7%      38.06 =C2=B1 60%  sched_debug.cfs_r=
q:/.load_avg.avg
>       1421 =C2=B1 27%     -49.9%     712.70 =C2=B1 26%  sched_debug.cfs_r=
q:/.load_avg.max
>     251.26 =C2=B1 25%     -45.5%     137.06 =C2=B1 44%  sched_debug.cfs_r=
q:/.load_avg.stddev
>       0.12 =C2=B1  8%     -36.0%       0.08 =C2=B1 23%  sched_debug.cfs_r=
q:/.nr_running.avg
>       0.33 =C2=B1  4%     -21.5%       0.26 =C2=B1 11%  sched_debug.cfs_r=
q:/.nr_running.stddev
>     221.71 =C2=B1 26%     -49.9%     111.18 =C2=B1 60%  sched_debug.cfs_r=
q:/.removed.load_avg.stddev
>     253.34 =C2=B1  7%     -37.5%     158.42 =C2=B1 28%  sched_debug.cfs_r=
q:/.runnable_avg.avg
>     297.62 =C2=B1  4%     -20.9%     235.28 =C2=B1 11%  sched_debug.cfs_r=
q:/.runnable_avg.stddev
>     252.17 =C2=B1  7%     -37.6%     157.31 =C2=B1 28%  sched_debug.cfs_r=
q:/.util_avg.avg
>     297.28 =C2=B1  4%     -21.0%     234.70 =C2=B1 11%  sched_debug.cfs_r=
q:/.util_avg.stddev
>     335.27 =C2=B1 11%     -33.2%     224.09 =C2=B1 23%  sched_debug.cpu.c=
urr->pid.avg
>     941.56 =C2=B1  4%     -10.3%     844.57 =C2=B1  6%  sched_debug.cpu.c=
urr->pid.stddev
>       0.11 =C2=B1 12%     -35.9%       0.07 =C2=B1 25%  sched_debug.cpu.n=
r_running.avg
>       0.32 =C2=B1  6%     -21.6%       0.25 =C2=B1 12%  sched_debug.cpu.n=
r_running.stddev
>     131.67 =C2=B1  4%    +1e+05%     134061 =C2=B1 52%  sched_debug.cpu.n=
r_switches.min
>       0.01 =C2=B1 28%     -64.0%       0.00 =C2=B1 33%  sched_debug.cpu.n=
r_uninterruptible.avg
>      12.54 =C2=B1 84%     -12.5        0.00        perf-profile.calltrace=
.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
>      12.54 =C2=B1 84%     -12.5        0.00        perf-profile.calltrace=
.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>      12.54 =C2=B1 84%     -12.5        0.00        perf-profile.calltrace=
.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
>      12.66 =C2=B1 83%     -12.4        0.29 =C2=B1129%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>      12.66 =C2=B1 83%     -12.4        0.29 =C2=B1129%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>      12.66 =C2=B1 83%     -12.4        0.29 =C2=B1129%  perf-profile.call=
trace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>      12.66 =C2=B1 83%     -12.4        0.29 =C2=B1129%  perf-profile.call=
trace.cycles-pp.write
>      11.78 =C2=B1 84%     -11.8        0.00        perf-profile.calltrace=
.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
>      11.78 =C2=B1 84%     -11.8        0.00        perf-profile.calltrace=
.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkm=
sg_write
>      11.10 =C2=B1 84%     -11.1        0.00        perf-profile.calltrace=
.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprint=
k_emit.devkmsg_emit
>       7.42 =C2=B1 61%      -5.0        2.40 =C2=B1 83%  perf-profile.call=
trace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_=
flush_all.console_unlock
>       0.30 =C2=B1150%      +1.1        1.43 =C2=B1 43%  perf-profile.call=
trace.cycles-pp.number.vsnprintf.seq_printf.show_interrupts.seq_read_iter
>       8.40 =C2=B1 41%      +5.9       14.30 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>       8.36 =C2=B1 42%      +5.9       14.30 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       8.60 =C2=B1 40%      +5.9       14.54 =C2=B1 16%  perf-profile.call=
trace.cycles-pp.read
>       8.23 =C2=B1 41%      +6.1       14.30 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       8.10 =C2=B1 41%      +6.1       14.18 =C2=B1 14%  perf-profile.call=
trace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.read
>      12.54 =C2=B1 84%     -12.5        0.00        perf-profile.children.=
cycles-pp.devkmsg_emit
>      12.54 =C2=B1 84%     -12.5        0.00        perf-profile.children.=
cycles-pp.devkmsg_write
>       9.02 =C2=B1 58%      -6.3        2.74 =C2=B1 83%  perf-profile.chil=
dren.cycles-pp.io_serial_in
>       1.49 =C2=B1 35%      -0.7        0.77 =C2=B1 39%  perf-profile.chil=
dren.cycles-pp.d_alloc_parallel
>       1.20 =C2=B1 30%      -0.6        0.57 =C2=B1 26%  perf-profile.chil=
dren.cycles-pp.d_alloc
>       7.51 =C2=B1101%      -0.5        7.04 =C2=B1123%  perf-profile.chil=
dren.cycles-pp.__ordered_events__flush
>       0.70 =C2=B1 38%      -0.4        0.30 =C2=B1 72%  perf-profile.chil=
dren.cycles-pp.lookup_open
>       3.15 =C2=B1104%      -0.4        2.79 =C2=B1127%  perf-profile.chil=
dren.cycles-pp.build_id__mark_dso_hit
>       6.78 =C2=B1103%      -0.0        6.75 =C2=B1122%  perf-profile.chil=
dren.cycles-pp.perf_session__deliver_event
>       0.11 =C2=B1119%      +0.3        0.41 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.free_unref_page
>       0.54 =C2=B1 35%      +0.9        1.39 =C2=B1 48%  perf-profile.chil=
dren.cycles-pp.__dentry_kill
>       0.70 =C2=B1 47%      +1.1        1.81 =C2=B1 36%  perf-profile.chil=
dren.cycles-pp.dput
>       7.71 =C2=B1 43%      +5.8       13.46 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.seq_read_iter
>       8.60 =C2=B1 40%      +5.9       14.54 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.read
>       8.29 =C2=B1 40%      +6.0       14.30 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.ksys_read
>       8.15 =C2=B1 40%      +6.1       14.23 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.vfs_read
>      10.49 =C2=B1 58%     +11.5       21.94 =C2=B1 29%  perf-profile.chil=
dren.cycles-pp.__cmd_record
>       9.02 =C2=B1 58%      -6.3        2.74 =C2=B1 83%  perf-profile.self=
.cycles-pp.io_serial_in
>       0.15 =C2=B1107%      +1.0        1.19 =C2=B1 53%  perf-profile.self=
.cycles-pp.show_interrupts
>       0.01 =C2=B1169%    +635.4%       0.05 =C2=B1 46%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_=
fork_asm
>     506.03 =C2=B1223%   +1038.0%       5758 =C2=B1 92%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64=
_sys_call
>       2527 =C2=B1 37%     +34.6%       3402 =C2=B1 17%  perf-sched.sch_de=
lay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_all=
owed_ptr.__sched_setaffinity
>       5433 =C2=B1 62%    +111.9%      11512 =C2=B1  8%  perf-sched.sch_de=
lay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
>       8727 =C2=B1 28%     +41.7%      12368 =C2=B1  6%  perf-sched.sch_de=
lay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>       0.16 =C2=B1221%   +1222.8%       2.11 =C2=B1101%  perf-sched.sch_de=
lay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_=
fork_asm
>       1543 =C2=B1223%    +338.6%       6770 =C2=B1 82%  perf-sched.sch_de=
lay.max.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64=
_sys_call
>       8967 =C2=B1 26%     +36.1%      12200 =C2=B1  7%  perf-sched.sch_de=
lay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unkn=
own].[unknown]
>      65.76 =C2=B1 67%   +3435.0%       2324 =C2=B1184%  perf-sched.sch_de=
lay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[=
unknown]
>       9232 =C2=B1 26%     +36.5%      12600 =C2=B1  6%  perf-sched.sch_de=
lay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       9419 =C2=B1 25%     +33.7%      12597 =C2=B1  5%  perf-sched.sch_de=
lay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
>       8740 =C2=B1 27%     +43.0%      12498 =C2=B1  4%  perf-sched.sch_de=
lay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
>       8472 =C2=B1 39%     +48.9%      12613 =C2=B1  5%  perf-sched.sch_de=
lay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exi=
t_mm
>       9034 =C2=B1 27%     +40.2%      12667 =C2=B1  4%  perf-sched.sch_de=
lay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.[unknown]
>       9461 =C2=B1 25%     +36.4%      12905 =C2=B1  4%  perf-sched.total_=
sch_delay.max.ms
>      18705 =C2=B1 25%     +37.6%      25730 =C2=B1  5%  perf-sched.total_=
wait_and_delay.max.ms
>       9525 =C2=B1 23%     +38.6%      13204 =C2=B1  7%  perf-sched.total_=
wait_time.max.ms
>      17493 =C2=B1 28%     +41.3%      24713 =C2=B1  6%  perf-sched.wait_a=
nd_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>      17105 =C2=B1 27%     +42.1%      24316 =C2=B1  8%  perf-sched.wait_a=
nd_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.=
[unknown].[unknown]
>      17952 =C2=B1 26%     +39.7%      25074 =C2=B1  6%  perf-sched.wait_a=
nd_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>      18587 =C2=B1 25%     +36.2%      25322 =C2=B1  5%  perf-sched.wait_a=
nd_delay.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
>      17333 =C2=B1 29%     +44.3%      25016 =C2=B1  4%  perf-sched.wait_a=
nd_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_wri=
te
>      16951 =C2=B1 39%     +48.4%      25149 =C2=B1  5%  perf-sched.wait_a=
nd_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_rea=
d.exit_mm
>      17996 =C2=B1 27%     +40.2%      25232 =C2=B1  5%  perf-sched.wait_a=
nd_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.[unknown]
>     163.71 =C2=B1203%    +576.0%       1106 =C2=B1 90%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.pipe_write.vfs_write.ksys_write.do_syscall_64
>      18.58 =C2=B1223%    +986.5%     201.88 =C2=B1 64%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_=
fork_asm
>       1478 =C2=B1223%    +391.5%       7267 =C2=B1 71%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64=
_sys_call
>       0.15 =C2=B1223%   +2351.7%       3.74 =C2=B1 70%  perf-sched.wait_t=
ime.avg.ms.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
>       2619 =C2=B1 27%     +29.9%       3402 =C2=B1 17%  perf-sched.wait_t=
ime.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_all=
owed_ptr.__sched_setaffinity
>       1593 =C2=B1223%    +360.5%       7337 =C2=B1 81%  perf-sched.wait_t=
ime.max.ms.__cond_resched.mmput.exit_mm.do_exit.__x64_sys_exit
>       7248 =C2=B1 40%     +60.1%      11605 =C2=B1  8%  perf-sched.wait_t=
ime.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
>       8913 =C2=B1 27%     +41.0%      12567 =C2=B1  8%  perf-sched.wait_t=
ime.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>       1658 =C2=B1217%    +301.5%       6658 =C2=B1 81%  perf-sched.wait_t=
ime.max.ms.__cond_resched.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1671 =C2=B1223%    +498.0%       9998 =C2=B1 50%  perf-sched.wait_t=
ime.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_=
fork_asm
>       1581 =C2=B1223%    +473.2%       9064 =C2=B1 50%  perf-sched.wait_t=
ime.max.ms.__cond_resched.switch_task_namespaces.do_exit.__x64_sys_exit.x64=
_sys_call
>       8915 =C2=B1 25%     +39.1%      12405 =C2=B1  7%  perf-sched.wait_t=
ime.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unkn=
own].[unknown]
>       9200 =C2=B1 26%     +40.4%      12920 =C2=B1  7%  perf-sched.wait_t=
ime.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       9433 =C2=B1 23%     +36.3%      12857 =C2=B1  7%  perf-sched.wait_t=
ime.max.ms.pipe_write.vfs_write.ksys_write.do_syscall_64
>       8838 =C2=B1 28%     +42.4%      12582 =C2=B1  4%  perf-sched.wait_t=
ime.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.pipe_write
>       8520 =C2=B1 39%     +48.5%      12654 =C2=B1  5%  perf-sched.wait_t=
ime.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.exi=
t_mm
>       8819 =C2=B1 26%     +45.3%      12815 =C2=B1  7%  perf-sched.wait_t=
ime.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       9176 =C2=B1 26%     +39.6%      12813 =C2=B1  7%  perf-sched.wait_t=
ime.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.[unknown]
>       8699 =C2=B1 25%     +48.7%      12937 =C2=B1  8%  perf-sched.wait_t=
ime.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>=20
>=20
>=20
> *************************************************************************=
**************************
> lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-202402=
06.cgz/lkp-skl-fpga01/pipe1/will-it-scale
>=20
> commit:=20
>   v6.12-rc1
>   2e4c6e78f4 ("fs: add infrastructure for multigrain timestamps")
>=20
>        v6.12-rc1 2e4c6e78f41afefb7a2b825b7aa=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>     816.00 =C2=B1  6%     -11.4%     722.72 =C2=B1  5%  sched_debug.cfs_r=
q:/.util_est.max
>   33816990            -2.0%   33148227        will-it-scale.104.processes
>     325162            -2.0%     318732        will-it-scale.per_process_o=
ps
>   33816990            -2.0%   33148227        will-it-scale.workload
>       0.70 =C2=B1 63%     +68.4%       1.18 =C2=B1  4%  perf-sched.sch_de=
lay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>     506.90 =C2=B1 11%     -14.5%     433.43 =C2=B1  3%  perf-sched.wait_a=
nd_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>     281.17 =C2=B1 50%     -51.7%     135.83 =C2=B1 19%  perf-sched.wait_a=
nd_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[=
unknown]
>       1000           -79.4%     206.38 =C2=B1171%  perf-sched.wait_and_de=
lay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.[unknown]
>       2.27 =C2=B1 52%  +18623.0%     424.45 =C2=B1117%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio=
.shmem_get_folio_gfp.shmem_write_begin
>     506.20 =C2=B1 11%     -14.6%     432.25 =C2=B1  3%  perf-sched.wait_t=
ime.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>     999.76           -80.5%     195.04 =C2=B1183%  perf-sched.wait_time.m=
ax.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.[unknown]
>    1.3e+10            +8.0%  1.404e+10        perf-stat.i.branch-instruct=
ions
>       1.10            -0.1        1.00        perf-stat.i.branch-miss-rat=
e%
>       4.14            -6.8%       3.86        perf-stat.i.cpi
>     425295            -5.1%     403763        perf-stat.i.cycles-between-=
cache-misses
>   6.96e+10            +7.2%  7.461e+10        perf-stat.i.instructions
>       0.24            +7.0%       0.26        perf-stat.i.ipc
>       0.01 =C2=B1  2%      -7.0%       0.01 =C2=B1  5%  perf-stat.overall=
.MPKI
>       1.09            -0.1        0.99        perf-stat.overall.branch-mi=
ss-rate%
>       4.15            -6.8%       3.87        perf-stat.overall.cpi
>       0.24            +7.3%       0.26        perf-stat.overall.ipc
>     622217            +9.4%     680897        perf-stat.overall.path-leng=
th
>  1.296e+10            +8.0%    1.4e+10        perf-stat.ps.branch-instruc=
tions
>  6.937e+10            +7.2%  7.436e+10        perf-stat.ps.instructions
>  2.104e+13            +7.3%  2.257e+13        perf-stat.total.instruction=
s
>       1.62            -0.5        1.15        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>      11.67            -0.3       11.34        perf-profile.calltrace.cycl=
es-pp.syscall_return_via_sysret.write
>      11.68            -0.1       11.56        perf-profile.calltrace.cycl=
es-pp.syscall_return_via_sysret.read
>       8.36            -0.1        8.25        perf-profile.calltrace.cycl=
es-pp.entry_SYSRETQ_unsafe_stack.write
>       4.06            -0.1        3.95        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.write
>       1.46            -0.1        1.37        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       4.02            -0.1        3.93        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.read
>       0.73            +0.0        0.75        perf-profile.calltrace.cycl=
es-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_sysca=
ll_64
>       0.65            +0.0        0.68        perf-profile.calltrace.cycl=
es-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_=
write.ksys_write
>       0.80            +0.0        0.84        perf-profile.calltrace.cycl=
es-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
>       0.92            +0.0        0.97        perf-profile.calltrace.cycl=
es-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.87 =C2=B1  2%      +0.2        1.02 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.write
>       1.66 =C2=B1  2%      +0.2        1.85 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_6=
4
>       1.22 =C2=B1  2%      +0.3        1.50 =C2=B1  2%  perf-profile.call=
trace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_rea=
d
>      21.79            +0.4       22.14        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.read
>       1.39 =C2=B1  2%      +0.5        1.86        perf-profile.calltrace=
.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_wr=
ite
>       1.92            +0.5        2.40        perf-profile.calltrace.cycl=
es-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
>      14.97            +0.5       15.47        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      22.36            +0.6       22.90        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.write
>       7.84            +0.6        8.43        perf-profile.calltrace.cycl=
es-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
>       0.00            +0.6        0.59 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.rep_movs_alternative._copy_to_iter.copy_page_to_iter.pipe_read.v=
fs_read
>       0.00            +0.6        0.60 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.rep_movs_alternative._copy_from_iter.copy_page_from_iter.pipe_wr=
ite.vfs_write
>       1.69            +0.7        2.41        perf-profile.calltrace.cycl=
es-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.40            +0.8        2.16        perf-profile.calltrace.cycl=
es-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
>      10.52            +0.8       11.29        perf-profile.calltrace.cycl=
es-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.56            +0.8        1.34        perf-profile.calltrace.cycl=
es-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
>       0.52            +0.8        1.34        perf-profile.calltrace.cycl=
es-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ksys_wr=
ite
>      15.50            +0.8       16.31        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.65            +0.9        1.56        perf-profile.calltrace.cycl=
es-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
>      12.82            +0.9       13.74        perf-profile.calltrace.cycl=
es-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>      12.00            +0.9       12.92        perf-profile.calltrace.cycl=
es-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.00            +1.0        1.02        perf-profile.calltrace.cycl=
es-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_=
write
>      11.10            +1.1       12.18        perf-profile.calltrace.cycl=
es-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>       8.12            +1.3        9.39        perf-profile.calltrace.cycl=
es-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>       3.13            -0.6        2.56        perf-profile.children.cycle=
s-pp.mutex_lock
>       1.40            -0.5        0.90 =C2=B1  2%  perf-profile.children.=
cycles-pp.__cond_resched
>      23.52            -0.5       23.07        perf-profile.children.cycle=
s-pp.syscall_return_via_sysret
>       1.35 =C2=B1  3%      -0.3        1.01        perf-profile.children.=
cycles-pp.syscall_exit_to_user_mode
>       0.88 =C2=B1  3%      -0.3        0.54 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.rcu_all_qs
>       0.66 =C2=B1  6%      -0.2        0.41 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode_prepare
>       8.92            -0.2        8.68        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>      17.87            -0.2       17.63        perf-profile.children.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>       0.00            +0.1        0.11 =C2=B1  8%  perf-profile.children.=
cycles-pp.set_normalized_timespec64
>       0.15 =C2=B1  2%      +0.1        0.28 =C2=B1 12%  perf-profile.chil=
dren.cycles-pp.timestamp_truncate
>       1.68 =C2=B1  2%      +0.2        1.87 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.copy_page_to_iter
>       1.80            +0.2        2.00        perf-profile.children.cycle=
s-pp.fdget_pos
>       1.32            +0.3        1.59 =C2=B1  2%  perf-profile.children.=
cycles-pp._copy_to_iter
>       0.00            +0.3        0.28        perf-profile.children.cycle=
s-pp.ktime_get_coarse_with_offset
>       0.00            +0.3        0.32        perf-profile.children.cycle=
s-pp.ktime_get_coarse_ts64
>       0.00            +0.3        0.35 =C2=B1  2%  perf-profile.children.=
cycles-pp.ns_to_timespec64
>       1.95            +0.5        2.42        perf-profile.children.cycle=
s-pp.copy_page_from_iter
>       1.49 =C2=B1  2%      +0.5        1.98        perf-profile.children.=
cycles-pp._copy_from_iter
>       0.65            +0.6        1.22 =C2=B1  2%  perf-profile.children.=
cycles-pp.rep_movs_alternative
>       7.98            +0.6        8.56        perf-profile.children.cycle=
s-pp.pipe_read
>       1.72            +0.7        2.43        perf-profile.children.cycle=
s-pp.touch_atime
>       0.00            +0.7        0.74        perf-profile.children.cycle=
s-pp.coarse_ctime
>       1.44            +0.8        2.20        perf-profile.children.cycle=
s-pp.atime_needs_update
>      10.55            +0.8       11.32        perf-profile.children.cycle=
s-pp.vfs_read
>       0.56            +0.8        1.37        perf-profile.children.cycle=
s-pp.inode_needs_update_time
>      44.44            +0.9       45.34        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       0.67            +0.9        1.58        perf-profile.children.cycle=
s-pp.file_update_time
>      12.86            +0.9       13.77        perf-profile.children.cycle=
s-pp.ksys_write
>      12.02            +0.9       12.94        perf-profile.children.cycle=
s-pp.ksys_read
>      11.16            +1.1       12.24        perf-profile.children.cycle=
s-pp.vfs_write
>       8.18            +1.3        9.43        perf-profile.children.cycle=
s-pp.pipe_write
>      30.60            +1.3       31.91        perf-profile.children.cycle=
s-pp.do_syscall_64
>       0.57            +1.9        2.51        perf-profile.children.cycle=
s-pp.current_time
>      23.47            -0.5       23.01        perf-profile.self.cycles-pp=
.syscall_return_via_sysret
>      14.02            -0.4       13.60        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       0.84 =C2=B1  3%      -0.3        0.50 =C2=B1  3%  perf-profile.self=
.cycles-pp.rcu_all_qs
>       0.82 =C2=B1  4%      -0.3        0.50 =C2=B1  2%  perf-profile.self=
.cycles-pp.ksys_write
>      17.70            -0.2       17.46        perf-profile.self.cycles-pp=
.entry_SYSRETQ_unsafe_stack
>       0.61 =C2=B1  6%      -0.2        0.38 =C2=B1  4%  perf-profile.self=
.cycles-pp.syscall_exit_to_user_mode_prepare
>       7.83            -0.2        7.61        perf-profile.self.cycles-pp=
.entry_SYSCALL_64
>       2.15            -0.2        1.94        perf-profile.self.cycles-pp=
.vfs_write
>       1.88 =C2=B1  2%      -0.2        1.70        perf-profile.self.cycl=
es-pp.pipe_read
>       0.52 =C2=B1  3%      -0.2        0.37 =C2=B1  3%  perf-profile.self=
.cycles-pp.__cond_resched
>       0.69            -0.1        0.58 =C2=B1  2%  perf-profile.self.cycl=
es-pp.syscall_exit_to_user_mode
>       0.35 =C2=B1  3%      -0.1        0.27        perf-profile.self.cycl=
es-pp.copy_page_to_iter
>       0.80            -0.1        0.72        perf-profile.self.cycles-pp=
.atime_needs_update
>       0.34 =C2=B1  2%      -0.1        0.28        perf-profile.self.cycl=
es-pp.inode_needs_update_time
>       0.26 =C2=B1  2%      -0.0        0.21 =C2=B1  3%  perf-profile.self=
.cycles-pp.touch_atime
>       0.46            -0.0        0.45        perf-profile.self.cycles-pp=
.copy_page_from_iter
>       0.10 =C2=B1  4%      +0.1        0.20        perf-profile.self.cycl=
es-pp.file_update_time
>       0.54 =C2=B1  2%      +0.1        0.64 =C2=B1  3%  perf-profile.self=
.cycles-pp.ksys_read
>       0.00            +0.1        0.11 =C2=B1  8%  perf-profile.self.cycl=
es-pp.set_normalized_timespec64
>       0.14 =C2=B1  3%      +0.1        0.26 =C2=B1 14%  perf-profile.self=
.cycles-pp.timestamp_truncate
>       1.28 =C2=B1  2%      +0.2        1.45        perf-profile.self.cycl=
es-pp._copy_from_iter
>       1.48            +0.2        1.67 =C2=B1  2%  perf-profile.self.cycl=
es-pp.vfs_read
>       1.80            +0.2        1.99        perf-profile.self.cycles-pp=
.fdget_pos
>       0.00            +0.3        0.26        perf-profile.self.cycles-pp=
.ktime_get_coarse_with_offset
>       0.00            +0.3        0.26        perf-profile.self.cycles-pp=
.ns_to_timespec64
>       0.00            +0.3        0.30        perf-profile.self.cycles-pp=
.ktime_get_coarse_ts64
>       0.00            +0.3        0.33        perf-profile.self.cycles-pp=
.coarse_ctime
>       2.29 =C2=B1  2%      +0.4        2.72        perf-profile.self.cycl=
es-pp.pipe_write
>       0.48            +0.6        1.04 =C2=B1  3%  perf-profile.self.cycl=
es-pp.rep_movs_alternative
>       0.33            +0.6        0.95 =C2=B1  5%  perf-profile.self.cycl=
es-pp.current_time
>=20
>=20
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

