Return-Path: <linux-fsdevel+bounces-28943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDE971A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79086B2389F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB01B86DA;
	Mon,  9 Sep 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pravk/Cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E21B86C7;
	Mon,  9 Sep 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886646; cv=none; b=d2BzVc+1f+dMchy70n4Pt5ZdiWuFvPyurkIrNAJ/WmJ7BlHwDMb+lJ1SKWlMF3JOEwxJTaV7beYhoHimgluM+A3x6Y41ONeFHcCjjc5EPHy9XcnRTv+UyEld0HzTKMD2/xv+0AcQHG86KYeIhfe51LYrqN+ITZ1S48C1C3rdKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886646; c=relaxed/simple;
	bh=gMDLQsyGr+aVnTlYtwC5Ee0IsYtzSPk+Rgyj1y9L18s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhpxtWU+6ZOqY2+KKFOkQrP+ezMVDt/FoauhCSsLHz9czPeS7N7cg/UqsN3ua8NIsLdS49yWTy0emvZFksucYzhfkMrxWs2KkSowg4ZrO5VVfKPZg+YTxUeOcYOmrnVYbsuVWwlXwV/oHZmpjdnKBsxwwuYnE88K9R65x8KWWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pravk/Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A5C4CEC5;
	Mon,  9 Sep 2024 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886643;
	bh=gMDLQsyGr+aVnTlYtwC5Ee0IsYtzSPk+Rgyj1y9L18s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pravk/ClXhDgDogjGSMfxro9ygP1cUyKbepMErRbFI7Su+nRCYfyH8F21Pqq9YMPC
	 zzhXdPU213sKtAONZ00TBZg+QCnVxbgnpBwtsLkbRnxITgb+wwfAXsTr3Hl/2hgiGC
	 Pw8y4CCsHqUgo3MTXGwmAlQoa66k2oGAcusl0ETnjkzLTsoTSWmXGhueO/j24IWzFo
	 3juEpHL/0x+ZObLWZ2o1za4DbDax5zjpijsu50/C2N9XB5XGsetB9DOMAurt1MG5U0
	 SUDSptAmOvzK/zJWzGV3ezI2E961ZL48o/KXoIjvIyRYDzRDXyPY/0XIvV/8NyRIhI
	 nJMvSkiF8qZHA==
Message-ID: <ada46c66750586fdb7373e2ef508e0f5545d1491.camel@kernel.org>
Subject: Re: [brauner-vfs:vfs.mgtime] [fs]  a037d5e7f8:
 will-it-scale.per_thread_ops -5.5% regression
From: Jeff Layton <jlayton@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Christian Brauner
 <christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>,  linux-fsdevel@vger.kernel.org,
 ying.huang@intel.com, feng.tang@intel.com,  fengwei.yin@intel.com
Date: Mon, 09 Sep 2024 08:57:21 -0400
In-Reply-To: <202409091303.31b2b713-oliver.sang@intel.com>
References: <202409091303.31b2b713-oliver.sang@intel.com>
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

On Mon, 2024-09-09 at 16:24 +0800, kernel test robot wrote:
>=20
> Hello,
>=20
> kernel test robot noticed a -5.5% regression of will-it-scale.per_thread_=
ops on:
>=20
>=20
> commit: a037d5e7f81bae8ff69eb670b2ec3f25ad4d2cc2 ("fs: add infrastructure=
 for multigrain timestamps")
> https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.mgtime
>=20
> testcase: will-it-scale
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
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
-----------------------------------------------+
> > testcase: change | will-it-scale: will-it-scale.per_thread_ops -2.4% re=
gression                                       |
> > test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU =
@ 3.10GHz (Ice Lake) with 256G memory          |
> > test parameters  | cpufreq_governor=3Dperformance                      =
                                                 |
> >                  | mode=3Dthread                                       =
                                                 |
> >                  | nr_task=3D100%                                      =
                                                 |
> >                  | test=3Dwriteseek1                                   =
                                                 |
> +------------------+-----------------------------------------------------=
-----------------------------------------------+
> > testcase: change | will-it-scale: will-it-scale.per_thread_ops -5.5% re=
gression                                       |
> > test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380=
H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
> > test parameters  | cpufreq_governor=3Dperformance                      =
                                                 |
> >                  | mode=3Dthread                                       =
                                                 |
> >                  | nr_task=3D100%                                      =
                                                 |
> >                  | test=3Dpipe1                                        =
                                                 |
> +------------------+-----------------------------------------------------=
-----------------------------------------------+
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.san=
g@intel.com
>=20
>=20


It's not too surprising that some of these microbenchmarks might
regress, given that we're adding some atomic ops in the write codepath.

That said, if this the commit it landed on, then this is before any
filesystems have enabled multigrain timestamps. Most of the new stuff
we're adding here is dead code at this point. The main difference is
that we're fetching the ctime_floor value when calling current_time
(and doing the ktime_t comparison).


static ktime_t coarse_ctime(ktime_t floor)
{
        ktime_t coarse =3D ktime_get_coarse();

        /* If coarse time is already newer, return that */
        if (!ktime_after(floor, coarse))
                return ktime_get_coarse_real();
        return ktime_mono_to_real(floor);
}

I forget who it was that suggested changing it, but originally this
patch just did this when the coarse time was after the floor:

    return ktime_mono_to_real(coarse);

I wonder if that might shave off a few cycles?

The other possibility is the is_mgtime check. That has to do some
pointer chasing to get at the fs_flags field. If that's too costly, we
could look at adding a flag to the inode that mirrors that value.

I'll see if I can reproduce this.

> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240909/202409091303.31b2b713-ol=
iver.sang@intel.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-2024020=
6.cgz/lkp-icl-2sp7/pipe1/will-it-scale
>=20
> commit:=20
>   v6.11-rc1
>   a037d5e7f8 ("fs: add infrastructure for multigrain timestamps")
>=20
>        v6.11-rc1 a037d5e7f81bae8ff69eb670b2e=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      98752            +1.3%     100032        proc-vmstat.nr_active_anon
>     103972            +1.2%     105220        proc-vmstat.nr_shmem
>      98752            +1.3%     100032        proc-vmstat.nr_zone_active_=
anon
>   84330110            -5.5%   79683588        will-it-scale.64.threads
>    1317657            -5.5%    1245055        will-it-scale.per_thread_op=
s
>   84330110            -5.5%   79683588        will-it-scale.workload
>  4.678e+10            +1.2%  4.733e+10        perf-stat.i.branch-instruct=
ions
>       0.03 =C2=B1  7%      -0.0        0.02 =C2=B1  6%  perf-stat.i.branc=
h-miss-rate%
>   12781080 =C2=B1  7%     -19.2%   10321748 =C2=B1  6%  perf-stat.i.branc=
h-misses
>       1.01            -2.3%       0.99        perf-stat.i.cpi
>  1.946e+11            +2.4%  1.993e+11        perf-stat.i.instructions
>       0.99            +2.4%       1.01        perf-stat.i.ipc
>       0.03 =C2=B1  7%      -0.0        0.02 =C2=B1  6%  perf-stat.overall=
.branch-miss-rate%
>       1.01            -2.4%       0.99        perf-stat.overall.cpi
>       0.99            +2.4%       1.01        perf-stat.overall.ipc
>     695016            +8.4%     753440        perf-stat.overall.path-leng=
th
>  4.661e+10            +1.2%  4.717e+10        perf-stat.ps.branch-instruc=
tions
>   12713767 =C2=B1  7%     -19.3%   10263468 =C2=B1  6%  perf-stat.ps.bran=
ch-misses
>  1.939e+11            +2.4%  1.986e+11        perf-stat.ps.instructions
>  5.861e+13            +2.4%  6.004e+13        perf-stat.total.instruction=
s
>       7.03            -0.4        6.60        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.write
>       6.89            -0.4        6.48        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.read
>       6.72            -0.4        6.35        perf-profile.calltrace.cycl=
es-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
>       5.69            -0.3        5.37        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.read
>       5.46            -0.3        5.17        perf-profile.calltrace.cycl=
es-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
>       5.68            -0.3        5.40        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.write
>       5.30            -0.3        5.03        perf-profile.calltrace.cycl=
es-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
>      49.56            -0.2       49.34        perf-profile.calltrace.cycl=
es-pp.read
>       4.39            -0.2        4.17        perf-profile.calltrace.cycl=
es-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
>       0.56            -0.1        0.43 =C2=B1 50%  perf-profile.calltrace=
.cycles-pp.aa_file_perm.apparmor_file_permission.security_file_permission.r=
w_verify_area.vfs_write
>       2.66            -0.1        2.52        perf-profile.calltrace.cycl=
es-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1.71            -0.1        1.61        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock_irqsave.__wake_up_sync_key.pipe_write.vfs_write.ksys_w=
rite
>       1.81            -0.1        1.72        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.77            -0.1        1.69        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1.04            -0.1        0.97        perf-profile.calltrace.cycl=
es-pp.fput.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.86            -0.1        0.80        perf-profile.calltrace.cycl=
es-pp.testcase
>       1.11            -0.1        1.05        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.12            -0.1        1.06        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.88            -0.0        0.84        perf-profile.calltrace.cycl=
es-pp.syscall_return_via_sysret.read
>       1.04            -0.0        1.00        perf-profile.calltrace.cycl=
es-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.72            -0.0        0.68        perf-profile.calltrace.cycl=
es-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.65            -0.0        0.61        perf-profile.calltrace.cycl=
es-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.55            -0.0        0.52 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.aa_file_perm.apparmor_file_permission.security_file_permission.r=
w_verify_area.vfs_read
>       0.58            -0.0        0.55 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>      53.26            +0.1       53.34        perf-profile.calltrace.cycl=
es-pp.write
>       0.00            +0.6        0.56 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.ktime_get_coarse_ts64.coarse_ctime.current_time.atime_needs_upda=
te.touch_atime
>       0.00            +0.6        0.64        perf-profile.calltrace.cycl=
es-pp.timestamp_truncate.current_time.atime_needs_update.touch_atime.pipe_r=
ead
>       0.00            +0.6        0.64        perf-profile.calltrace.cycl=
es-pp.timestamp_truncate.current_time.inode_needs_update_time.file_update_t=
ime.pipe_write
>      32.72            +0.8       33.51        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.read
>      31.75            +0.8       32.58        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      36.32            +1.0       37.27        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.write
>      28.50            +1.0       29.49        perf-profile.calltrace.cycl=
es-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      35.33            +1.0       36.34        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.00            +1.1        1.08 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_ti=
me.pipe_write
>      32.09            +1.1       33.20        perf-profile.calltrace.cycl=
es-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.00            +1.2        1.23        perf-profile.calltrace.cycl=
es-pp.coarse_ctime.current_time.atime_needs_update.touch_atime.pipe_read
>      23.02            +1.3       24.30        perf-profile.calltrace.cycl=
es-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      26.62            +1.4       27.97        perf-profile.calltrace.cycl=
es-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>      19.03            +1.6       20.60        perf-profile.calltrace.cycl=
es-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>      15.11            +1.6       16.71        perf-profile.calltrace.cycl=
es-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
>       1.48            +2.1        3.56        perf-profile.calltrace.cycl=
es-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
>       3.51            +2.2        5.72        perf-profile.calltrace.cycl=
es-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
>       3.05            +2.2        5.28        perf-profile.calltrace.cycl=
es-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
>       1.81 =C2=B1  2%      +2.4        4.20        perf-profile.calltrace=
.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_write.ks=
ys_write
>       2.23 =C2=B1  2%      +2.5        4.71        perf-profile.calltrace=
.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.00            +3.3        3.26        perf-profile.calltrace.cycl=
es-pp.current_time.inode_needs_update_time.file_update_time.pipe_write.vfs_=
write
>      14.06            -0.8       13.22        perf-profile.children.cycle=
s-pp.clear_bhb_loop
>       7.01            -0.4        6.62        perf-profile.children.cycle=
s-pp.copy_page_from_iter
>       6.63            -0.4        6.28        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>       5.61            -0.3        5.32        perf-profile.children.cycle=
s-pp._copy_from_iter
>       5.46            -0.3        5.18        perf-profile.children.cycle=
s-pp.copy_page_to_iter
>       5.00            -0.3        4.73        perf-profile.children.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>      50.00            -0.2       49.78        perf-profile.children.cycle=
s-pp.read
>       4.46            -0.2        4.24        perf-profile.children.cycle=
s-pp._copy_to_iter
>       3.88            -0.2        3.69        perf-profile.children.cycle=
s-pp.mutex_lock
>       2.87            -0.1        2.73        perf-profile.children.cycle=
s-pp.__wake_up_sync_key
>       2.38            -0.1        2.24        perf-profile.children.cycle=
s-pp.mutex_unlock
>       2.23            -0.1        2.10        perf-profile.children.cycle=
s-pp.fput
>       1.81            -0.1        1.71        perf-profile.children.cycle=
s-pp._raw_spin_lock_irqsave
>       1.53            -0.1        1.44        perf-profile.children.cycle=
s-pp.x64_sys_call
>       1.10            -0.1        1.01        perf-profile.children.cycle=
s-pp.testcase
>       1.26            -0.1        1.19 =C2=B1  2%  perf-profile.children.=
cycles-pp.aa_file_perm
>       1.48            -0.1        1.41        perf-profile.children.cycle=
s-pp.__cond_resched
>       2.14            -0.1        2.09        perf-profile.children.cycle=
s-pp.syscall_exit_to_user_mode
>       0.35            -0.0        0.32 =C2=B1  2%  perf-profile.children.=
cycles-pp.entry_SYSCALL_64_safe_stack
>       0.57            -0.0        0.54        perf-profile.children.cycle=
s-pp.__wake_up_common
>       0.51            -0.0        0.48        perf-profile.children.cycle=
s-pp.kill_fasync
>       0.26            -0.0        0.23 =C2=B1  2%  perf-profile.children.=
cycles-pp.__x64_sys_read
>       0.49            -0.0        0.47        perf-profile.children.cycle=
s-pp._raw_spin_unlock_irqrestore
>       0.25            -0.0        0.23        perf-profile.children.cycle=
s-pp.__x64_sys_write
>       0.30            -0.0        0.28        perf-profile.children.cycle=
s-pp.make_vfsuid
>       0.23            -0.0        0.22 =C2=B1  2%  perf-profile.children.=
cycles-pp.write@plt
>       0.00            +0.7        0.65        perf-profile.children.cycle=
s-pp.set_normalized_timespec64
>       0.71            +0.7        1.43        perf-profile.children.cycle=
s-pp.timestamp_truncate
>       0.00            +0.9        0.93        perf-profile.children.cycle=
s-pp.ns_to_timespec64
>      28.79            +1.0       29.76        perf-profile.children.cycle=
s-pp.ksys_read
>       0.00            +1.0        1.04        perf-profile.children.cycle=
s-pp.ktime_get_coarse_with_offset
>      32.43            +1.1       33.54        perf-profile.children.cycle=
s-pp.ksys_write
>       0.00            +1.2        1.15 =C2=B1  3%  perf-profile.children.=
cycles-pp.ktime_get_coarse_ts64
>      23.24            +1.3       24.52        perf-profile.children.cycle=
s-pp.vfs_read
>      26.88            +1.3       28.22        perf-profile.children.cycle=
s-pp.vfs_write
>      19.69            +1.5       21.23        perf-profile.children.cycle=
s-pp.pipe_write
>      15.78            +1.6       17.35        perf-profile.children.cycle=
s-pp.pipe_read
>      69.41            +1.7       71.14        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      67.61            +1.8       69.42        perf-profile.children.cycle=
s-pp.do_syscall_64
>       3.65            +2.2        5.86        perf-profile.children.cycle=
s-pp.touch_atime
>       3.34            +2.2        5.56        perf-profile.children.cycle=
s-pp.atime_needs_update
>       2.08 =C2=B1  2%      +2.3        4.35        perf-profile.children.=
cycles-pp.inode_needs_update_time
>       2.45 =C2=B1  2%      +2.4        4.85        perf-profile.children.=
cycles-pp.file_update_time
>       0.00            +2.7        2.72        perf-profile.children.cycle=
s-pp.coarse_ctime
>       1.63            +5.9        7.55        perf-profile.children.cycle=
s-pp.current_time
>      13.92            -0.8       13.07        perf-profile.self.cycles-pp=
.clear_bhb_loop
>       1.04 =C2=B1  3%      -0.3        0.73        perf-profile.self.cycl=
es-pp.inode_needs_update_time
>       5.38            -0.3        5.09        perf-profile.self.cycles-pp=
._copy_from_iter
>       4.83            -0.3        4.56        perf-profile.self.cycles-pp=
.entry_SYSRETQ_unsafe_stack
>       4.55            -0.2        4.33        perf-profile.self.cycles-pp=
.vfs_read
>       4.37            -0.2        4.15        perf-profile.self.cycles-pp=
._copy_to_iter
>       3.34            -0.2        3.14        perf-profile.self.cycles-pp=
.write
>       3.21            -0.2        3.02        perf-profile.self.cycles-pp=
.pipe_read
>       3.34            -0.2        3.15        perf-profile.self.cycles-pp=
.read
>       2.06            -0.1        1.93        perf-profile.self.cycles-pp=
.fput
>       4.43            -0.1        4.30        perf-profile.self.cycles-pp=
.vfs_write
>       2.21            -0.1        2.09        perf-profile.self.cycles-pp=
.mutex_unlock
>       2.54            -0.1        2.42        perf-profile.self.cycles-pp=
.do_syscall_64
>       2.37            -0.1        2.27        perf-profile.self.cycles-pp=
.mutex_lock
>       1.88            -0.1        1.78        perf-profile.self.cycles-pp=
.entry_SYSCALL_64
>       1.73            -0.1        1.64        perf-profile.self.cycles-pp=
._raw_spin_lock_irqsave
>       1.46            -0.1        1.37        perf-profile.self.cycles-pp=
.copy_page_from_iter
>       1.79            -0.1        1.71        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       1.36            -0.1        1.28        perf-profile.self.cycles-pp=
.x64_sys_call
>       1.33            -0.1        1.26        perf-profile.self.cycles-pp=
.security_file_permission
>       0.87            -0.1        0.80        perf-profile.self.cycles-pp=
.testcase
>       1.05            -0.1        0.99        perf-profile.self.cycles-pp=
.rw_verify_area
>       0.99            -0.1        0.93        perf-profile.self.cycles-pp=
.copy_page_to_iter
>       1.05            -0.1        0.99        perf-profile.self.cycles-pp=
.aa_file_perm
>       1.27            -0.1        1.21        perf-profile.self.cycles-pp=
.atime_needs_update
>       0.83            -0.1        0.78        perf-profile.self.cycles-pp=
.__cond_resched
>       1.38            -0.0        1.34        perf-profile.self.cycles-pp=
.syscall_exit_to_user_mode
>       0.34 =C2=B1  2%      -0.0        0.31 =C2=B1  2%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.50            -0.0        0.48        perf-profile.self.cycles-pp=
.__wake_up_sync_key
>       0.18            -0.0        0.16 =C2=B1  2%  perf-profile.self.cycl=
es-pp.__x64_sys_read
>       0.17            -0.0        0.16        perf-profile.self.cycles-pp=
.__x64_sys_write
>       0.43            +0.1        0.49        perf-profile.self.cycles-pp=
.file_update_time
>       0.00            +0.5        0.51        perf-profile.self.cycles-pp=
.set_normalized_timespec64
>       0.58            +0.6        1.15        perf-profile.self.cycles-pp=
.timestamp_truncate
>       0.00            +0.8        0.78        perf-profile.self.cycles-pp=
.ns_to_timespec64
>       0.00            +0.9        0.88 =C2=B1  4%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_ts64
>       0.00            +0.9        0.89 =C2=B1  2%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_with_offset
>       1.07            +0.9        1.98 =C2=B1  2%  perf-profile.self.cycl=
es-pp.current_time
>       0.00            +1.2        1.17        perf-profile.self.cycles-pp=
.coarse_ctime
>=20
>=20
> *************************************************************************=
**************************
> lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-2024020=
6.cgz/lkp-icl-2sp7/writeseek1/will-it-scale
>=20
> commit:=20
>   v6.11-rc1
>   a037d5e7f8 ("fs: add infrastructure for multigrain timestamps")
>=20
>        v6.11-rc1 a037d5e7f81bae8ff69eb670b2e=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      79.00 =C2=B1  9%     +38.8%     109.67 =C2=B1 20%  perf-c2c.HITM.rem=
ote
>   75816166            -2.4%   73999365        will-it-scale.64.threads
>    1184627            -2.4%    1156239        will-it-scale.per_thread_op=
s
>   75816166            -2.4%   73999365        will-it-scale.workload
>       1.29 =C2=B1 15%     +32.0%       1.70 =C2=B1 15%  perf-sched.sch_de=
lay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
>       5.46 =C2=B1221%     -99.7%       0.02 =C2=B1 15%  perf-sched.sch_de=
lay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       2.57 =C2=B1 15%     +32.0%       3.40 =C2=B1 15%  perf-sched.wait_a=
nd_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
>     846.14 =C2=B1 37%     -64.5%     300.69 =C2=B1117%  perf-sched.wait_a=
nd_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       1.29 =C2=B1 15%     +32.0%       1.70 =C2=B1 15%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
>     839.24 =C2=B1 37%     -64.4%     298.49 =C2=B1116%  perf-sched.wait_t=
ime.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>    8283953           +18.7%    9832101 =C2=B1  6%  perf-stat.i.branch-mis=
ses
>       1.13            -1.7%       1.11        perf-stat.i.cpi
>  1.746e+11            +1.7%  1.775e+11        perf-stat.i.instructions
>       0.89            +1.7%       0.90        perf-stat.i.ipc
>       0.02            +0.0        0.02 =C2=B1  6%  perf-stat.overall.bran=
ch-miss-rate%
>       1.13            -1.6%       1.11        perf-stat.overall.cpi
>       0.89            +1.6%       0.90        perf-stat.overall.ipc
>     696240            +4.1%     725044        perf-stat.overall.path-leng=
th
>    8247837           +18.6%    9784317 =C2=B1  6%  perf-stat.ps.branch-mi=
sses
>   1.74e+11            +1.7%  1.769e+11        perf-stat.ps.instructions
>  5.279e+13            +1.6%  5.365e+13        perf-stat.total.instruction=
s
>      26.93            -0.8       26.10        perf-profile.calltrace.cycl=
es-pp.llseek
>      31.20            -0.6       30.58        perf-profile.calltrace.cycl=
es-pp.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write.do_s=
yscall_64
>      12.61            -0.5       12.12 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
>      11.70 =C2=B1  2%      -0.5       11.23 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
>       8.91 =C2=B1  2%      -0.4        8.50 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.lls=
eek
>      13.72            -0.3       13.38        perf-profile.calltrace.cycl=
es-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_ite=
r.vfs_write.ksys_write
>       6.36            -0.2        6.16        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.llseek
>       6.60            -0.2        6.42        perf-profile.calltrace.cycl=
es-pp.shmem_write_begin.generic_perform_write.shmem_file_write_iter.vfs_wri=
te.ksys_write
>       5.69            -0.2        5.52        perf-profile.calltrace.cycl=
es-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_fil=
e_write_iter.vfs_write
>       5.85            -0.1        5.72        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.write
>       5.05            -0.1        4.93        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.write
>       4.86            -0.1        4.75        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.llseek
>       3.23            -0.1        3.14        perf-profile.calltrace.cycl=
es-pp.shmem_write_end.generic_perform_write.shmem_file_write_iter.vfs_write=
.ksys_write
>       2.23            -0.1        2.17        perf-profile.calltrace.cycl=
es-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_write_begin.generic_perfo=
rm_write.shmem_file_write_iter
>       1.55            -0.0        1.51        perf-profile.calltrace.cycl=
es-pp.down_write.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64
>       1.52            -0.0        1.49        perf-profile.calltrace.cycl=
es-pp.mutex_lock.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
>       0.98            -0.0        0.95        perf-profile.calltrace.cycl=
es-pp.fput.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
>       1.56            -0.0        1.52        perf-profile.calltrace.cycl=
es-pp.mutex_lock.__fdget_pos.ksys_lseek.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
>       0.95            -0.0        0.92        perf-profile.calltrace.cycl=
es-pp.folio_unlock.shmem_write_end.generic_perform_write.shmem_file_write_i=
ter.vfs_write
>       1.06            -0.0        1.03        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
llseek
>       0.84            -0.0        0.82        perf-profile.calltrace.cycl=
es-pp.folio_mark_accessed.shmem_get_folio_gfp.shmem_write_begin.generic_per=
form_write.shmem_file_write_iter
>       0.64            -0.0        0.62        perf-profile.calltrace.cycl=
es-pp.folio_mark_dirty.shmem_write_end.generic_perform_write.shmem_file_wri=
te_iter.vfs_write
>       0.76            -0.0        0.74        perf-profile.calltrace.cycl=
es-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.llseek
>       0.00            +0.6        0.57        perf-profile.calltrace.cycl=
es-pp.timestamp_truncate.current_time.inode_needs_update_time.file_update_t=
ime.shmem_file_write_iter
>      75.78            +0.8       76.57        perf-profile.calltrace.cycl=
es-pp.write
>      61.25            +1.0       62.22        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.write
>      60.37            +1.0       61.35        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>      57.56            +1.0       58.61        perf-profile.calltrace.cycl=
es-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.00            +1.1        1.11 =C2=B1  3%  perf-profile.calltrace=
.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_ti=
me.shmem_file_write_iter
>      49.83            +1.2       51.07        perf-profile.calltrace.cycl=
es-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>      39.42            +1.4       40.86        perf-profile.calltrace.cycl=
es-pp.shmem_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>       1.95            +2.1        4.04        perf-profile.calltrace.cycl=
es-pp.inode_needs_update_time.file_update_time.shmem_file_write_iter.vfs_wr=
ite.ksys_write
>       2.33            +2.2        4.54        perf-profile.calltrace.cycl=
es-pp.file_update_time.shmem_file_write_iter.vfs_write.ksys_write.do_syscal=
l_64
>       0.00            +3.1        3.14        perf-profile.calltrace.cycl=
es-pp.current_time.inode_needs_update_time.file_update_time.shmem_file_writ=
e_iter.vfs_write
>      27.11            -0.9       26.24        perf-profile.children.cycle=
s-pp.llseek
>      31.79            -0.6       31.15        perf-profile.children.cycle=
s-pp.generic_perform_write
>       9.30 =C2=B1  2%      -0.4        8.87 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.ksys_lseek
>      13.81            -0.3       13.47        perf-profile.children.cycle=
s-pp.copy_page_from_iter_atomic
>      12.33            -0.3       11.99        perf-profile.children.cycle=
s-pp.clear_bhb_loop
>       6.76            -0.2        6.56        perf-profile.children.cycle=
s-pp.shmem_write_begin
>       5.95            -0.2        5.77        perf-profile.children.cycle=
s-pp.shmem_get_folio_gfp
>       5.77            -0.1        5.64        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>       3.43            -0.1        3.34        perf-profile.children.cycle=
s-pp.shmem_write_end
>       3.51            -0.1        3.42        perf-profile.children.cycle=
s-pp.__cond_resched
>       3.34            -0.1        3.26        perf-profile.children.cycle=
s-pp.mutex_lock
>       2.37            -0.1        2.30        perf-profile.children.cycle=
s-pp.filemap_get_entry
>       2.01            -0.1        1.96        perf-profile.children.cycle=
s-pp.fput
>       1.57            -0.1        1.52        perf-profile.children.cycle=
s-pp.rcu_all_qs
>       1.68            -0.0        1.63        perf-profile.children.cycle=
s-pp.down_write
>       2.15            -0.0        2.10        perf-profile.children.cycle=
s-pp.mutex_unlock
>       0.11 =C2=B1  4%      -0.0        0.07 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.ktime_get_update_offsets_now
>       1.76            -0.0        1.72        perf-profile.children.cycle=
s-pp.syscall_exit_to_user_mode
>       1.02            -0.0        0.98        perf-profile.children.cycle=
s-pp.folio_unlock
>       0.89            -0.0        0.87        perf-profile.children.cycle=
s-pp.folio_mark_accessed
>       0.55            -0.0        0.52        perf-profile.children.cycle=
s-pp.shmem_file_llseek
>       0.77            -0.0        0.75        perf-profile.children.cycle=
s-pp.folio_mark_dirty
>       0.26            -0.0        0.25        perf-profile.children.cycle=
s-pp.__f_unlock_pos
>       0.22            +0.0        0.24        perf-profile.children.cycle=
s-pp.inode_to_bdi
>       0.00            +0.3        0.30        perf-profile.children.cycle=
s-pp.set_normalized_timespec64
>       0.00            +0.4        0.42 =C2=B1  3%  perf-profile.children.=
cycles-pp.ns_to_timespec64
>      74.20            +0.5       74.66        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>       0.00            +0.5        0.47        perf-profile.children.cycle=
s-pp.ktime_get_coarse_with_offset
>      72.54            +0.5       73.04        perf-profile.children.cycle=
s-pp.do_syscall_64
>       0.00            +0.6        0.56 =C2=B1  6%  perf-profile.children.=
cycles-pp.ktime_get_coarse_ts64
>      76.24            +0.8       77.00        perf-profile.children.cycle=
s-pp.write
>      57.97            +1.0       59.02        perf-profile.children.cycle=
s-pp.ksys_write
>      50.19            +1.2       51.42        perf-profile.children.cycle=
s-pp.vfs_write
>       0.00            +1.3        1.29 =C2=B1  2%  perf-profile.children.=
cycles-pp.coarse_ctime
>      39.96            +1.4       41.40        perf-profile.children.cycle=
s-pp.shmem_file_write_iter
>       2.18            +2.0        4.17        perf-profile.children.cycle=
s-pp.inode_needs_update_time
>       2.52            +2.1        4.67        perf-profile.children.cycle=
s-pp.file_update_time
>       0.00            +3.5        3.46        perf-profile.children.cycle=
s-pp.current_time
>       1.13            -0.4        0.72        perf-profile.self.cycles-pp=
.inode_needs_update_time
>      13.62            -0.3       13.28        perf-profile.self.cycles-pp=
.copy_page_from_iter_atomic
>      12.19            -0.3       11.86        perf-profile.self.cycles-pp=
.clear_bhb_loop
>       2.31            -0.1        2.24        perf-profile.self.cycles-pp=
.llseek
>       4.25            -0.1        4.19        perf-profile.self.cycles-pp=
.entry_SYSRETQ_unsafe_stack
>       2.18            -0.1        2.12        perf-profile.self.cycles-pp=
.shmem_get_folio_gfp
>       2.18            -0.1        2.12        perf-profile.self.cycles-pp=
.do_syscall_64
>       1.72            -0.1        1.67        perf-profile.self.cycles-pp=
.filemap_get_entry
>       1.88            -0.0        1.83        perf-profile.self.cycles-pp=
.fput
>       2.14            -0.0        2.09        perf-profile.self.cycles-pp=
.mutex_lock
>       2.01            -0.0        1.96        perf-profile.self.cycles-pp=
.mutex_unlock
>       1.66            -0.0        1.61        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       1.18            -0.0        1.14        perf-profile.self.cycles-pp=
.rcu_all_qs
>       0.54 =C2=B1  2%      -0.0        0.50        perf-profile.self.cycl=
es-pp.timestamp_truncate
>       1.94            -0.0        1.90        perf-profile.self.cycles-pp=
.__cond_resched
>       1.09            -0.0        1.05        perf-profile.self.cycles-pp=
.down_write
>       1.56            -0.0        1.52        perf-profile.self.cycles-pp=
.shmem_write_end
>       0.10 =C2=B1  4%      -0.0        0.07 =C2=B1 11%  perf-profile.self=
.cycles-pp.ktime_get_update_offsets_now
>       1.62            -0.0        1.59        perf-profile.self.cycles-pp=
.entry_SYSCALL_64
>       2.68            -0.0        2.65        perf-profile.self.cycles-pp=
.__fsnotify_parent
>       1.13            -0.0        1.10        perf-profile.self.cycles-pp=
.syscall_exit_to_user_mode
>       0.95            -0.0        0.92        perf-profile.self.cycles-pp=
.folio_unlock
>       0.83            -0.0        0.81        perf-profile.self.cycles-pp=
.folio_mark_accessed
>       0.42            -0.0        0.41        perf-profile.self.cycles-pp=
.shmem_file_llseek
>       0.49            -0.0        0.47        perf-profile.self.cycles-pp=
.balance_dirty_pages_ratelimited_flags
>       0.34            -0.0        0.33        perf-profile.self.cycles-pp=
.folio_mapping
>       0.15 =C2=B1  3%      +0.0        0.17 =C2=B1  2%  perf-profile.self=
.cycles-pp.inode_to_bdi
>       0.39            +0.1        0.48        perf-profile.self.cycles-pp=
.file_update_time
>       0.00            +0.2        0.24 =C2=B1  3%  perf-profile.self.cycl=
es-pp.set_normalized_timespec64
>       0.00            +0.4        0.35        perf-profile.self.cycles-pp=
.ns_to_timespec64
>       0.00            +0.4        0.41 =C2=B1  2%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_with_offset
>       0.00            +0.4        0.44 =C2=B1  8%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_ts64
>       0.00            +0.6        0.55        perf-profile.self.cycles-pp=
.coarse_ctime
>       0.00            +0.9        0.89        perf-profile.self.cycles-pp=
.current_time
>=20
>=20
>=20
> *************************************************************************=
**************************
> lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @=
 2.90GHz (Cooper Lake) with 192G memory
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
>   v6.11-rc1
>   a037d5e7f8 ("fs: add infrastructure for multigrain timestamps")
>=20
>        v6.11-rc1 a037d5e7f81bae8ff69eb670b2e=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>     101460 =C2=B1 14%     -40.5%      60365 =C2=B1 54%  numa-numastat.nod=
e2.other_node
>     101460 =C2=B1 14%     -40.5%      60365 =C2=B1 54%  numa-vmstat.node2=
.numa_other
>     214956            +1.3%     217796        proc-vmstat.nr_shmem
>  2.864e+08            -5.5%  2.706e+08        will-it-scale.224.threads
>    1278568            -5.5%    1207975        will-it-scale.per_thread_op=
s
>  2.864e+08            -5.5%  2.706e+08        will-it-scale.workload
>       0.29 =C2=B1220%    +486.6%       1.70 =C2=B1 71%  perf-sched.sch_de=
lay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_e=
poll_wait
>       0.14 =C2=B1104%    +238.3%       0.49 =C2=B1 26%  perf-sched.sch_de=
lay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>       4.33 =C2=B1196%    +426.6%      22.79 =C2=B1 55%  perf-sched.sch_de=
lay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>      15.03 =C2=B1101%    +153.2%      38.05 =C2=B1 19%  perf-sched.total_=
sch_delay.max.ms
>       0.07 =C2=B1141%    +201.5%       0.20        perf-sched.wait_and_de=
lay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kt=
hread
>       0.70 =C2=B1100%    +137.6%       1.66 =C2=B1 20%  perf-sched.wait_a=
nd_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_stat=
e.kernel_clone
>      35.83 =C2=B1143%    +476.3%     206.50 =C2=B1 56%  perf-sched.wait_a=
nd_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_threa=
d.kthread
>       1.40 =C2=B1100%    +116.9%       3.03 =C2=B1  6%  perf-sched.wait_t=
ime.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       2.43 =C2=B1143%    +472.3%      13.90 =C2=B1 56%  perf-sched.wait_t=
ime.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.do_psel=
ect.constprop
>       0.64 =C2=B1100%    +137.0%       1.51 =C2=B1 20%  perf-sched.wait_t=
ime.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.ker=
nel_clone
>       0.14 =C2=B1104%    +229.2%       0.47 =C2=B1 25%  perf-sched.wait_t=
ime.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
>       2.33 =C2=B1101%    +114.3%       4.99        perf-sched.wait_time.m=
ax.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
>       4.45 =C2=B1143%    +600.8%      31.18 =C2=B1 64%  perf-sched.wait_t=
ime.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.do_psel=
ect.constprop
>  1.612e+11            +1.6%  1.638e+11        perf-stat.i.branch-instruct=
ions
>       0.42 =C2=B1  2%      -0.1        0.37        perf-stat.i.branch-mis=
s-rate%
>  6.629e+08            -9.0%  6.034e+08        perf-stat.i.branch-misses
>      13.77 =C2=B1  3%      +1.3       15.04 =C2=B1  6%  perf-stat.i.cache=
-miss-rate%
>       1.12            -2.6%       1.09        perf-stat.i.cpi
>  6.635e+11            +2.9%  6.827e+11        perf-stat.i.instructions
>       0.89            +2.7%       0.91        perf-stat.i.ipc
>       0.41            -0.0        0.37        perf-stat.overall.branch-mi=
ss-rate%
>       1.12            -2.6%       1.09        perf-stat.overall.cpi
>       0.89            +2.6%       0.91        perf-stat.overall.ipc
>     702093            +8.3%     760166        perf-stat.overall.path-leng=
th
>  1.604e+11            +1.7%  1.631e+11        perf-stat.ps.branch-instruc=
tions
>  6.591e+08            -8.9%  6.005e+08        perf-stat.ps.branch-misses
>    6.6e+11            +2.9%  6.795e+11        perf-stat.ps.instructions
>  2.011e+14            +2.3%  2.057e+14        perf-stat.total.instruction=
s
>       5.47            -0.4        5.04        perf-profile.calltrace.cycl=
es-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
>       6.78            -0.4        6.37        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.write
>       6.84            -0.3        6.51        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.read
>       2.72 =C2=B1  2%      -0.3        2.41 =C2=B1  8%  perf-profile.call=
trace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify=
_area.vfs_read.ksys_read
>       5.38            -0.3        5.08        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.read
>       5.36            -0.3        5.08        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.write
>       3.98            -0.3        3.70        perf-profile.calltrace.cycl=
es-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
>       4.16            -0.2        3.96        perf-profile.calltrace.cycl=
es-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
>      52.78            -0.2       52.59        perf-profile.calltrace.cycl=
es-pp.write
>       2.09            -0.1        1.95        perf-profile.calltrace.cycl=
es-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
>       1.04            -0.1        0.90        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       3.17            -0.1        3.06        perf-profile.calltrace.cycl=
es-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
>       1.56            -0.1        1.46        perf-profile.calltrace.cycl=
es-pp._raw_spin_lock_irqsave.__wake_up_sync_key.pipe_write.vfs_write.ksys_w=
rite
>       0.99            -0.1        0.90        perf-profile.calltrace.cycl=
es-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       1.67            -0.1        1.59        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
>       0.64            -0.1        0.56        perf-profile.calltrace.cycl=
es-pp.testcase
>       0.96            -0.1        0.89        perf-profile.calltrace.cycl=
es-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       1.24            -0.1        1.17        perf-profile.calltrace.cycl=
es-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.read
>       1.24            -0.1        1.17        perf-profile.calltrace.cycl=
es-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.write
>       0.98            -0.1        0.92        perf-profile.calltrace.cycl=
es-pp.fput.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       1.15            -0.1        1.10        perf-profile.calltrace.cycl=
es-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.94            -0.1        0.88        perf-profile.calltrace.cycl=
es-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
>      50.06            +0.1       50.13        perf-profile.calltrace.cycl=
es-pp.read
>       1.64            +0.1        1.75        perf-profile.calltrace.cycl=
es-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.59 =C2=B1  6%      +0.3        0.86 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.anon_pipe_buf_release.pipe_read.vfs_read.ksys_read.do_sysca=
ll_64
>       0.25 =C2=B1100%      +0.4        0.68 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
>       0.00            +0.5        0.54 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.timestamp_truncate.current_time.inode_needs_update_time.file_upd=
ate_time.pipe_write
>       0.00            +0.6        0.58 =C2=B1  3%  perf-profile.calltrace=
.cycles-pp.ktime_get_coarse_ts64.coarse_ctime.current_time.atime_needs_upda=
te.touch_atime
>      35.68            +0.8       36.45        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.write
>      34.78            +0.8       35.61        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       0.00            +1.0        1.03 =C2=B1 14%  perf-profile.calltrace=
.cycles-pp.coarse_ctime.current_time.inode_needs_update_time.file_update_ti=
me.pipe_write
>      32.94            +1.0       33.97        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.read
>      32.05            +1.1       33.13        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      30.48            +1.1       31.57        perf-profile.calltrace.cycl=
es-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>      25.24            +1.2       26.49        perf-profile.calltrace.cycl=
es-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.wri=
te
>      27.80            +1.4       29.19        perf-profile.calltrace.cycl=
es-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       0.00            +1.4        1.42 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.coarse_ctime.current_time.atime_needs_update.touch_atime.pipe_re=
ad
>      22.79            +1.5       24.30        perf-profile.calltrace.cycl=
es-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>      17.46            +1.6       19.04        perf-profile.calltrace.cycl=
es-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>      14.85            +2.2       17.02        perf-profile.calltrace.cycl=
es-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame
>       4.02            +2.3        6.29        perf-profile.calltrace.cycl=
es-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.72            +2.3        4.02        perf-profile.calltrace.cycl=
es-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
>       3.63            +2.3        5.94        perf-profile.calltrace.cycl=
es-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
>       1.78 =C2=B1  8%      +2.3        4.12 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.inode_needs_update_time.file_update_time.pipe_write.vfs_wri=
te.ksys_write
>       2.06 =C2=B1  8%      +2.3        4.41 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall=
_64
>       0.00            +3.3        3.34 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.current_time.inode_needs_update_time.file_update_time.pipe_write=
.vfs_write
>      13.71            -0.7       12.97        perf-profile.children.cycle=
s-pp.clear_bhb_loop
>       5.60            -0.4        5.15        perf-profile.children.cycle=
s-pp.copy_page_from_iter
>       6.87            -0.4        6.48        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>       4.28            -0.3        3.98        perf-profile.children.cycle=
s-pp._copy_from_iter
>       4.06            -0.2        3.83        perf-profile.children.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>       4.23            -0.2        4.03        perf-profile.children.cycle=
s-pp.copy_page_to_iter
>       2.06            -0.2        1.86        perf-profile.children.cycle=
s-pp.mutex_unlock
>      52.98            -0.2       52.80        perf-profile.children.cycle=
s-pp.write
>       2.14            -0.2        1.96        perf-profile.children.cycle=
s-pp.x64_sys_call
>       2.18            -0.2        2.03        perf-profile.children.cycle=
s-pp.__wake_up_sync_key
>       2.60            -0.1        2.45        perf-profile.children.cycle=
s-pp.syscall_exit_to_user_mode
>       3.43            -0.1        3.31        perf-profile.children.cycle=
s-pp._copy_to_iter
>       2.14            -0.1        2.02        perf-profile.children.cycle=
s-pp.fput
>       1.58            -0.1        1.48        perf-profile.children.cycle=
s-pp._raw_spin_lock_irqsave
>       0.74 =C2=B1  2%      -0.1        0.65        perf-profile.children.=
cycles-pp.testcase
>       0.77            -0.0        0.74        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_safe_stack
>       0.36            -0.0        0.34        perf-profile.children.cycle=
s-pp.__x64_sys_read
>       0.39            -0.0        0.37        perf-profile.children.cycle=
s-pp.__x64_sys_write
>       0.14 =C2=B1  3%      -0.0        0.12 =C2=B1  6%  perf-profile.chil=
dren.cycles-pp.make_vfsuid
>       0.26            -0.0        0.24 =C2=B1  2%  perf-profile.children.=
cycles-pp.__wake_up_common
>       0.30            -0.0        0.28        perf-profile.children.cycle=
s-pp._raw_spin_unlock_irqrestore
>       0.42 =C2=B1  3%      +0.1        0.48 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp.rcu_all_qs
>      50.24            +0.1       50.31        perf-profile.children.cycle=
s-pp.read
>       1.36 =C2=B1  3%      +0.1        1.44 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.rep_movs_alternative
>       1.27            +0.1        1.41        perf-profile.children.cycle=
s-pp.__cond_resched
>       0.60 =C2=B1  6%      +0.3        0.86 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.anon_pipe_buf_release
>       0.00            +0.5        0.54 =C2=B1  8%  perf-profile.children.=
cycles-pp.set_normalized_timespec64
>       0.46 =C2=B1 10%      +0.7        1.11 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.timestamp_truncate
>       0.00            +0.9        0.94 =C2=B1  2%  perf-profile.children.=
cycles-pp.ktime_get_coarse_with_offset
>       0.00            +1.0        0.98 =C2=B1  7%  perf-profile.children.=
cycles-pp.ktime_get_coarse_ts64
>       0.00            +1.0        1.04        perf-profile.children.cycle=
s-pp.ns_to_timespec64
>      30.73            +1.1       31.81        perf-profile.children.cycle=
s-pp.ksys_write
>      25.42            +1.2       26.66        perf-profile.children.cycle=
s-pp.vfs_write
>      27.96            +1.4       29.32        perf-profile.children.cycle=
s-pp.ksys_read
>      22.87            +1.5       24.37        perf-profile.children.cycle=
s-pp.vfs_read
>      17.63            +1.6       19.19        perf-profile.children.cycle=
s-pp.pipe_write
>      68.90            +1.8       70.69        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      67.06            +1.9       68.95        perf-profile.children.cycle=
s-pp.do_syscall_64
>      15.15            +2.1       17.30        perf-profile.children.cycle=
s-pp.pipe_read
>       4.10            +2.3        6.37        perf-profile.children.cycle=
s-pp.touch_atime
>       3.73            +2.3        6.02        perf-profile.children.cycle=
s-pp.atime_needs_update
>       1.90 =C2=B1  8%      +2.3        4.20 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.inode_needs_update_time
>       2.13 =C2=B1  7%      +2.3        4.48 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.file_update_time
>       0.00            +2.5        2.52 =C2=B1  5%  perf-profile.children.=
cycles-pp.coarse_ctime
>       1.76            +6.0        7.77 =C2=B1  2%  perf-profile.children.=
cycles-pp.current_time
>      13.63            -0.7       12.89        perf-profile.self.cycles-pp=
.clear_bhb_loop
>       1.07 =C2=B1  5%      -0.4        0.67        perf-profile.self.cycl=
es-pp.inode_needs_update_time
>       3.81            -0.3        3.46        perf-profile.self.cycles-pp=
._copy_from_iter
>       4.10 =C2=B1  2%      -0.3        3.80 =C2=B1  2%  perf-profile.self=
.cycles-pp.vfs_read
>       3.58            -0.2        3.34        perf-profile.self.cycles-pp=
.pipe_read
>       3.35            -0.2        3.11        perf-profile.self.cycles-pp=
.read
>       3.92            -0.2        3.70        perf-profile.self.cycles-pp=
.entry_SYSRETQ_unsafe_stack
>       2.90            -0.2        2.70        perf-profile.self.cycles-pp=
.do_syscall_64
>       1.97            -0.2        1.78        perf-profile.self.cycles-pp=
.mutex_unlock
>       3.00            -0.2        2.81        perf-profile.self.cycles-pp=
.entry_SYSCALL_64
>       2.90            -0.2        2.74        perf-profile.self.cycles-pp=
._copy_to_iter
>       1.71            -0.2        1.54        perf-profile.self.cycles-pp=
.atime_needs_update
>       2.01            -0.2        1.85        perf-profile.self.cycles-pp=
.x64_sys_call
>       3.39            -0.1        3.25        perf-profile.self.cycles-pp=
.write
>       1.32 =C2=B1  2%      -0.1        1.18        perf-profile.self.cycl=
es-pp.copy_page_from_iter
>       1.87            -0.1        1.76        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       2.15            -0.1        2.05        perf-profile.self.cycles-pp=
.mutex_lock
>       1.66            -0.1        1.56        perf-profile.self.cycles-pp=
.syscall_exit_to_user_mode
>       1.89            -0.1        1.79        perf-profile.self.cycles-pp=
.fput
>       0.61            -0.1        0.51        perf-profile.self.cycles-pp=
.testcase
>       1.52            -0.1        1.43        perf-profile.self.cycles-pp=
._raw_spin_lock_irqsave
>       0.81 =C2=B1  4%      -0.1        0.72 =C2=B1  2%  perf-profile.self=
.cycles-pp.copy_page_to_iter
>       1.16            -0.1        1.11        perf-profile.self.cycles-pp=
.ksys_write
>       1.06            -0.0        1.02        perf-profile.self.cycles-pp=
.ksys_read
>       0.36            -0.0        0.32        perf-profile.self.cycles-pp=
.__wake_up_sync_key
>       0.37            -0.0        0.34 =C2=B1  2%  perf-profile.self.cycl=
es-pp.touch_atime
>       0.76            -0.0        0.73        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_safe_stack
>       0.26            -0.0        0.24        perf-profile.self.cycles-pp=
.__wake_up_common
>       0.27            -0.0        0.26        perf-profile.self.cycles-pp=
.__x64_sys_read
>       0.27            -0.0        0.26        perf-profile.self.cycles-pp=
._raw_spin_unlock_irqrestore
>       0.12 =C2=B1  3%      -0.0        0.11 =C2=B1  3%  perf-profile.self=
.cycles-pp.make_vfsuid
>       0.29            -0.0        0.28        perf-profile.self.cycles-pp=
.__x64_sys_write
>       0.26            +0.0        0.30        perf-profile.self.cycles-pp=
.file_update_time
>       0.30 =C2=B1  4%      +0.1        0.37 =C2=B1  9%  perf-profile.self=
.cycles-pp.rcu_all_qs
>       0.85            +0.1        0.92        perf-profile.self.cycles-pp=
.__cond_resched
>       0.89 =C2=B1  5%      +0.1        0.99 =C2=B1  4%  perf-profile.self=
.cycles-pp.rep_movs_alternative
>       0.56 =C2=B1  6%      +0.3        0.82 =C2=B1  2%  perf-profile.self=
.cycles-pp.anon_pipe_buf_release
>       0.00            +0.5        0.52 =C2=B1  7%  perf-profile.self.cycl=
es-pp.set_normalized_timespec64
>       0.43 =C2=B1 10%      +0.6        1.03 =C2=B1  3%  perf-profile.self=
.cycles-pp.timestamp_truncate
>       0.00            +0.9        0.86        perf-profile.self.cycles-pp=
.ns_to_timespec64
>       0.00            +0.9        0.90 =C2=B1  2%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_with_offset
>       0.00            +0.9        0.94 =C2=B1  8%  perf-profile.self.cycl=
es-pp.ktime_get_coarse_ts64
>       0.00            +1.0        1.02 =C2=B1  4%  perf-profile.self.cycl=
es-pp.coarse_ctime
>       1.06 =C2=B1  4%      +1.3        2.38 =C2=B1  3%  perf-profile.self=
.cycles-pp.current_time
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

