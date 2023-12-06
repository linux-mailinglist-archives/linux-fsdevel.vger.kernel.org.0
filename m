Return-Path: <linux-fsdevel+bounces-5029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9228077BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1571280C62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F53DBB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5IPfpza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFBBD5F;
	Wed,  6 Dec 2023 08:42:36 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d83ff72dbbso492187a34.1;
        Wed, 06 Dec 2023 08:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880956; x=1702485756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asCEEgirDvHkKaejtnEsqP4PHqKMjBDcULojEo964yQ=;
        b=D5IPfpzaZjAJm9W9yEjlb1cuJEHQxFiWpizuz56nehce74imDW2fjVEo8dpm7I0w8S
         wJVC0c9bVysQ6HxOk2n0tDhb/H5TjaSQGiM2fXoPtxBOIkcIDKhoviD7drFLbpYGM29T
         rJZay47UYMCSYlx2Rg0MYG/wJifoxOP0Zpz22iTVHhPUCrdWOOupoJrpJl0cqfHHCPuz
         SMEZPC2lchdA4PW6QVnzh2RD8r46K3uNU/RDeJ5AoahLtl57UvehUN+SQy2T80yCl6jI
         ughyxY9Y0aJ5xfiaa9/SeBhINWFWBI6laOVWz8uyKOiHxxaFdPoHL1xSXxiuHE1IjBkE
         78gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880956; x=1702485756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asCEEgirDvHkKaejtnEsqP4PHqKMjBDcULojEo964yQ=;
        b=CjmPO9Vi54sQd2YUppvGTu6CdUn2p8nEY3y1rW6dimouEelo6S4c+iQ9wOMKhMn1gb
         mVA84cqrMKlxvCpdkLYSSs1r/1HDjsWNp3Z5CgyxMJ6IjoWhzK6Lm2jRDiaumEKBN9Xr
         J2DWMAehdWzhuahnGyyrsWXqazsYNw3/cs4Z+g+e7F5dLlz54XwN/9MKd9eCxGL5QjbI
         GT8Xi0pbxGujyp5AL/5i/MBbV0SmI4GvxDC3wmv/8yGbPZENbstohwvRTN/rJc8NDRT6
         myGhZnFpzGcbMuoHodLDgVERQYWc35rLd4TfvKZKzhMq7WyaCQ+//B/J6lWxgrhohNdb
         nrUQ==
X-Gm-Message-State: AOJu0YxiqX//fE7xXY42T2kp4Dvv7nC+2xEDgmbSbjRUaFwvcbaX3tvz
	xcD3120C2m8+lH4PIlsF2Fa3p84rCliPpmZNrnI=
X-Google-Smtp-Source: AGHT+IGX6T+gliz+z38RWHPf8ZKplKp5G+kgFqlCsdMNUX4N/d6Pr80ARomT0UYyhaHlQk9KMORJ5caKG4R/oF8ABjg=
X-Received: by 2002:a05:6870:b28c:b0:1fb:75a:6779 with SMTP id
 c12-20020a056870b28c00b001fb075a6779mr599621oao.32.1701880955079; Wed, 06 Dec
 2023 08:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6802:30f:b0:50c:13ee:b03d with HTTP; Wed, 6 Dec 2023
 08:42:34 -0800 (PST)
In-Reply-To: <20231206163010.445vjwmfwwvv65su@f>
References: <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020> <20231201040951.GO38156@ZenIV>
 <20231201065602.GP38156@ZenIV> <20231201200446.GA1431056@ZenIV>
 <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020> <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020> <20231206054946.GM1674809@ZenIV>
 <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020> <20231206161509.GN1674809@ZenIV> <20231206163010.445vjwmfwwvv65su@f>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 6 Dec 2023 17:42:34 +0100
Message-ID: <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12/6/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Wed, Dec 06, 2023 at 04:15:09PM +0000, Al Viro wrote:
>> On Wed, Dec 06, 2023 at 10:56:00PM +0800, Oliver Sang wrote:
>> > hi, Al Viro,
>> >
>> > by our tests, seems "854e9f938aafe step 4.5" is the major reason for
>> > regression
>> >
>> > stress-ng:
>>
>> Ugh.  So all that slowdown comes from one thing - not taking the parent'=
s
>> lock in
>> lock_for_kill() (and not dropping the parent's lock in __dentry_kill(),
>> since the
>> caller is not holding it now).  Other changes in there undo some of that
>> slowdown,
>> but not enough to balance it.
>>
>> Note that it's not reordering the removal from list of children vs.
>> ->d_iput(),
>> not postponing the decrement of parent's refcount, etc. - it's literally
>> not bothering
>> with holding parent->d_lock over the beginning of already reordered
>> __dentry_kill().
>> And no, there's no cond_resched() anywhere in the affected areas.
>>
>> What the hell is going on?  Was ->d_lock on parent serving as a throttle
>> and reducing
>> the access rate to something badly contended down the road?  I don't see
>> anything
>> of that sort in the profile changes, though...
>>
>> Any ideas would be very welcome - I'm really at loss here.  Help?
>>
>
> Normally it means off cpu time went up.
>
> You did not mention there are no cond_resched() calls slapped in the
> area, but the off time may very well be coming from locks.
>
> I don't have time right now to poke around what exactly happens, but I
> can already tell you stress-ng *is* running into off cpu time in this
> test (collected with offcputime-bpfcc):
> [snip]
>     finish_task_switch.isra.0
>     __schedule
>     __cond_resched
>     down_read
>     super_lock
>     user_get_super
>     __do_sys_ustat
>     do_syscall_64
>     entry_SYSCALL_64_after_hwframe
>     syscall
>     -                stress-ng-sysin (118572)
>         3964
>
>
>     finish_task_switch.isra.0
>     __schedule
>     __cond_resched
>     down_read
>     kernfs_iop_permission
>     inode_permission
>     link_path_walk.part.0.constprop.0
>     path_lookupat
>     filename_lookup
>     user_path_at_empty
>     user_statfs
>     __do_sys_statfs
>     do_syscall_64
>     entry_SYSCALL_64_after_hwframe
>     statfs64
>     [unknown]
>     -                stress-ng-sysin (118568)
>         4343
> [/snip]
>
> I'm on stock kernel, top of the profile on cpu is bunch of spinlocks.
>
> Not an outlandish claim would be that after you stopped taking one of
> them, spinning went down and more traffic was put on locks which *can*
> put their consumers off cpu (and which *do* do it in this test).
>
> Locks which go off cpu degrade more than mere spinlocks and you end up
> with a slowdown.
>
> All that said I think it would help if these reports started including
> off cpu time (along with bt) at least for spawned threads.
>

That is to say your patchset is probably an improvement, but this
benchmark uses kernfs which is a total crapper, with code like this in
kernfs_iop_permission:

        root =3D kernfs_root(kn);

        down_read(&root->kernfs_iattr_rwsem);
        kernfs_refresh_inode(kn, inode);
        ret =3D generic_permission(&nop_mnt_idmap, inode, mask);
        up_read(&root->kernfs_iattr_rwsem);


Maybe there is an easy way to dodge this, off hand I don't see one.

If there are no other regressions found and there is no easy way out,
I would argue this should be ignored.

>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox=
_group/test/testcase/testtime:
>> >
>> > os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64=
-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s
>> >
>> > commit:
>> >   dc3cf789eb259 step 4: make shrink_kill() keep the parent pinned unti=
l
>> > after __dentry_kill() of victim
>> >   854e9f938aafe step 4.5: call __dentry_kill() without holding a lock =
on
>> > parent
>> >   e2797564725a5 step 5: clean lock_for_kill()
>> >
>> > dc3cf789eb25978f 854e9f938aafe9aa64a1c6bbe7a
>> > e2797564725a5c4e83652167819
>> > ---------------- ---------------------------
>> > ---------------------------
>> >          %stddev     %change         %stddev     %change
>> > %stddev
>> >              \          |                \          |                \
>> >     327846 =C2=B1  2%     -34.4%     215162           -32.8%     22021=
3 =C2=B1  2%
>> >  stress-ng.sysinfo.ops
>> >       5464 =C2=B1  2%     -34.4%       3586           -32.8%       367=
0 =C2=B1  2%
>> >  stress-ng.sysinfo.ops_per_sec
>> >
>> > detail is as below [1]
>> >
>> >
>> >
>> > unixbench:
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/te=
st/testcase:
>> >
>> > gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cg=
z/300s/lkp-icl-2sp9/shell1/unixbench
>> >
>> > commit:
>> >   dc3cf789eb259 step 4: make shrink_kill() keep the parent pinned unti=
l
>> > after __dentry_kill() of victim
>> >   854e9f938aafe step 4.5: call __dentry_kill() without holding a lock =
on
>> > parent
>> >   e2797564725a5 step 5: clean lock_for_kill()
>> >
>> > dc3cf789eb25978f 854e9f938aafe9aa64a1c6bbe7a
>> > e2797564725a5c4e83652167819
>> > ---------------- ---------------------------
>> > ---------------------------
>> >          %stddev     %change         %stddev     %change
>> > %stddev
>> >              \          |                \          |                \
>> >      34670           -11.7%      30622           -11.4%      30701
>> >  unixbench.score
>> >
>> > detail is as below [2]
>> >
>> >
>> >
>> > [1]
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox=
_group/test/testcase/testtime:
>> >
>> > os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64=
-20220510.cgz/lkp-icl-2sp7/sysinfo/stress-ng/60s
>> >
>> > commit:
>> >   dc3cf789eb259 step 4: make shrink_kill() keep the parent pinned unti=
l
>> > after __dentry_kill() of victim
>> >   854e9f938aafe step 4.5: call __dentry_kill() without holding a lock =
on
>> > parent
>> >   e2797564725a5 step 5: clean lock_for_kill()
>> >
>> > dc3cf789eb25978f 854e9f938aafe9aa64a1c6bbe7a
>> > e2797564725a5c4e83652167819
>> > ---------------- ---------------------------
>> > ---------------------------
>> >          %stddev     %change         %stddev     %change
>> > %stddev
>> >              \          |                \          |                \
>> >       9.37            +0.9%       9.46            +0.9%       9.46
>> >  iostat.cpu.system
>> >      31152 =C2=B1  9%     -16.3%      26080 =C2=B1 11%     -16.7%     =
 25939 =C2=B1 11%
>> >  numa-meminfo.node1.Active
>> >       0.11 =C2=B1  4%     -15.0%       0.09 =C2=B1  3%     -15.9%     =
  0.09
>> >  turbostat.IPC
>> >       6816 =C2=B1  4%      -8.6%       6231            -8.6%       623=
0
>> >  proc-vmstat.nr_active_anon
>> >       8830 =C2=B1  4%      -7.1%       8200            -7.2%       819=
7
>> >  proc-vmstat.nr_shmem
>> >       6816 =C2=B1  4%      -8.6%       6231            -8.6%       623=
0
>> >  proc-vmstat.nr_zone_active_anon
>> >     327846 =C2=B1  2%     -34.4%     215162           -32.8%     22021=
3 =C2=B1  2%
>> >  stress-ng.sysinfo.ops
>> >       5464 =C2=B1  2%     -34.4%       3586           -32.8%       367=
0 =C2=B1  2%
>> >  stress-ng.sysinfo.ops_per_sec
>> >       3864 =C2=B1 47%     -62.7%       1443 =C2=B1 43%     -67.0%     =
  1276 =C2=B1 19%
>> >  stress-ng.time.involuntary_context_switches
>> >       3864 =C2=B1 47%     -62.7%       1443 =C2=B1 43%     -67.0%     =
  1276 =C2=B1 19%
>> >  time.involuntary_context_switches
>> >       3.34 =C2=B1  3%     -31.2%       2.30 =C2=B1  2%     -29.1%     =
  2.37 =C2=B1  3%
>> >  time.user_time
>> >     272.90 =C2=B1  6%     +19.3%     325.70 =C2=B1  6%     +28.1%     =
349.70 =C2=B1  4%
>> >  time.voluntary_context_switches
>> >       0.06 =C2=B1 46%     -73.6%       0.02 =C2=B1 49%     -79.9%     =
  0.01 =C2=B1 40%
>> >
>> > perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.re=
t_from_fork_asm
>> >       4.00 =C2=B1 12%     -33.1%       2.68 =C2=B1 59%     -52.6%     =
  1.90 =C2=B1 58%
>> >
>> > perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.re=
t_from_fork_asm
>> >       0.02 =C2=B1 32%     -48.2%       0.01 =C2=B1 21%     -49.4%     =
  0.01 =C2=B1 27%
>> >  perf-sched.total_sch_delay.average.ms
>> >       0.33 =C2=B1 49%    -100.0%       0.00           -98.5%       0.0=
1 =C2=B1299%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.__lookup_slow
>> >       0.30 =C2=B1 23%     -85.6%       0.04 =C2=B1 81%     -73.9%     =
  0.08 =C2=B1 84%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_iop_permis=
sion.inode_permission.link_path_walk
>> >       0.30 =C2=B1 17%     -84.9%       0.04 =C2=B1 56%     -79.2%     =
  0.06 =C2=B1 75%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.pa=
th_lookupat.filename_lookup
>> >       0.29 =C2=B1 21%     -83.5%       0.05 =C2=B1134%     -73.8%     =
  0.08 =C2=B1185%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.__loo=
kup_slow.walk_component
>> >       0.28 =C2=B1 29%     -76.9%       0.06 =C2=B1 54%     -74.7%     =
  0.07 =C2=B1 73%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.user_statfs._=
_do_sys_statfs
>> >       0.34 =C2=B1 55%     -79.4%       0.07 =C2=B1152%     -86.6%     =
  0.05 =C2=B1155%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.__d=
o_sys_newstat
>> >       0.28 =C2=B1 26%     -73.6%       0.07 =C2=B1 44%     -77.9%     =
  0.06 =C2=B1 63%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.path_lookupa=
t.filename_lookup
>> >       0.32 =C2=B1 15%     -81.6%       0.06 =C2=B1 57%     -81.1%     =
  0.06 =C2=B1 64%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_lo=
okupat.filename_lookup
>> >       0.29 =C2=B1 62%     -96.0%       0.01 =C2=B1168%     -87.6%     =
  0.04 =C2=B1187%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constpr=
op.0.kmem_cache_alloc_lru
>> >       0.29 =C2=B1 29%     -84.8%       0.04 =C2=B1 36%     -86.0%     =
  0.04 =C2=B1 34%
>> >
>> > perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.syscall_exit_to_user_mode.do_syscall_64
>> >       0.65 =C2=B1 41%    -100.0%       0.00           -99.2%       0.0=
1 =C2=B1299%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.__lookup_slow
>> >       0.87 =C2=B1 16%     -90.0%       0.09 =C2=B1 81%     -74.5%     =
  0.22 =C2=B1 96%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_iop_permis=
sion.inode_permission.link_path_walk
>> >       0.92 =C2=B1 14%     -69.5%       0.28 =C2=B1 82%     -71.4%     =
  0.26 =C2=B1 78%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.pa=
th_lookupat.filename_lookup
>> >       0.92 =C2=B1 23%     -89.3%       0.10 =C2=B1181%     -88.9%     =
  0.10 =C2=B1153%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__loo=
kup_slow.walk_component
>> >       0.95 =C2=B1 57%     -77.6%       0.21 =C2=B1 78%     -74.9%     =
  0.24 =C2=B1 99%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.user_statfs._=
_do_sys_statfs
>> >       0.73 =C2=B1 28%     -82.9%       0.12 =C2=B1163%     -83.7%     =
  0.12 =C2=B1227%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.__d=
o_sys_newstat
>> >       0.89 =C2=B1 21%     -43.8%       0.50 =C2=B1 57%     -66.3%     =
  0.30 =C2=B1 86%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupa=
t.filename_lookup
>> >       0.86 =C2=B1 19%     -55.0%       0.38 =C2=B1 83%     -57.2%     =
  0.37 =C2=B1 79%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_lo=
okupat.filename_lookup
>> >       0.58 =C2=B1 58%     -97.9%       0.01 =C2=B1163%     -82.9%     =
  0.10 =C2=B1238%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constpr=
op.0.kmem_cache_alloc_lru
>> >       1.49 =C2=B1104%     -68.9%       0.46 =C2=B1 66%     -73.2%     =
  0.40 =C2=B1 50%
>> >
>> > perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.syscall_exit_to_user_mode.do_syscall_64
>> >       1.61 =C2=B1  2%     +13.4%       1.83 =C2=B1  2%     +12.4%     =
  1.81 =C2=B1  3%
>> >  perf-stat.i.MPKI
>> >  1.143e+09 =C2=B1  2%     -16.3%  9.568e+08           -14.5%  9.767e+0=
8
>> >  perf-stat.i.branch-instructions
>> >    8673684 =C2=B1  2%      -8.6%    7931970            -7.5%    802137=
0 =C2=B1  3%
>> >  perf-stat.i.cache-misses
>> >   22426311 =C2=B1  2%     -10.6%   20043839            -8.8%   2044626=
3 =C2=B1  2%
>> >  perf-stat.i.cache-references
>> >       3.72 =C2=B1  2%     +23.9%       4.61           +21.6%       4.5=
3
>> >  perf-stat.i.cpi
>> >       2356 =C2=B1  2%      +8.3%       2552 =C2=B1  2%      +7.2%     =
  2525 =C2=B1  3%
>> >  perf-stat.i.cycles-between-cache-misses
>> >  1.448e+09 =C2=B1  2%     -18.0%  1.187e+09           -16.3%  1.212e+0=
9
>> >  perf-stat.i.dTLB-loads
>> >       0.01 =C2=B1  2%      +0.0        0.01            +0.0        0.0=
1 =C2=B1  5%
>> >  perf-stat.i.dTLB-store-miss-rate%
>> >  7.019e+08 =C2=B1  2%     -22.6%  5.432e+08           -20.9%  5.552e+0=
8
>> >  perf-stat.i.dTLB-stores
>> >  5.692e+09 =C2=B1  2%     -17.9%  4.674e+09           -16.1%  4.777e+0=
9 =C2=B1  2%
>> >  perf-stat.i.instructions
>> >       0.30 =C2=B1  2%     -16.2%       0.25           -14.8%       0.2=
5
>> >  perf-stat.i.ipc
>> >     485.18 =C2=B1  2%     -10.1%     436.38            -8.5%     443.9=
6 =C2=B1  2%
>> >  perf-stat.i.metric.K/sec
>> >      51.42 =C2=B1  2%     -18.4%      41.96           -16.7%      42.8=
4
>> >  perf-stat.i.metric.M/sec
>> >      86.80            +2.1       88.86            +2.3       89.11
>> >  perf-stat.i.node-store-miss-rate%
>> >    3368969 =C2=B1  3%      -4.9%    3205464 =C2=B1  2%      -3.8%    3=
240173 =C2=B1  3%
>> >  perf-stat.i.node-store-misses
>> >     486089 =C2=B1  4%     -19.3%     392430 =C2=B1  5%     -22.1%     =
378508 =C2=B1  6%
>> >  perf-stat.i.node-stores
>> >       1.53 =C2=B1  2%     +11.4%       1.70 =C2=B1  3%     +10.2%     =
  1.68 =C2=B1  3%
>> >  perf-stat.overall.MPKI
>> >       0.89 =C2=B1  3%      +0.1        0.95 =C2=B1  3%      +0.1      =
  0.97 =C2=B1  3%
>> >  perf-stat.overall.branch-miss-rate%
>> >       3.54 =C2=B1  2%     +21.2%       4.29           +18.8%       4.2=
1
>> >  perf-stat.overall.cpi
>> >       2321 =C2=B1  2%      +8.8%       2526 =C2=B1  2%      +7.9%     =
  2504 =C2=B1  3%
>> >  perf-stat.overall.cycles-between-cache-misses
>> >       0.01 =C2=B1  2%      +0.0        0.01            +0.0        0.0=
1 =C2=B1  5%
>> >  perf-stat.overall.dTLB-store-miss-rate%
>> >       0.28 =C2=B1  2%     -17.5%       0.23           -15.8%       0.2=
4
>> >  perf-stat.overall.ipc
>> >      87.41            +1.7       89.12            +2.1       89.55
>> >  perf-stat.overall.node-store-miss-rate%
>> >  1.124e+09 =C2=B1  2%     -16.3%  9.404e+08           -14.6%    9.6e+0=
8
>> >  perf-stat.ps.branch-instructions
>> >    8533816 =C2=B1  2%      -8.6%    7804060            -7.5%    789053=
7 =C2=B1  3%
>> >  perf-stat.ps.cache-misses
>> >   22060802 =C2=B1  2%     -10.6%   19713622            -8.8%   2011005=
4 =C2=B1  2%
>> >  perf-stat.ps.cache-references
>> >  1.424e+09 =C2=B1  2%     -18.0%  1.167e+09           -16.3%  1.191e+0=
9
>> >  perf-stat.ps.dTLB-loads
>> >  6.904e+08 =C2=B1  2%     -22.6%  5.341e+08           -20.9%  5.459e+0=
8 =C2=B1  2%
>> >  perf-stat.ps.dTLB-stores
>> >  5.596e+09 =C2=B1  2%     -17.9%  4.594e+09           -16.1%  4.696e+0=
9 =C2=B1  2%
>> >  perf-stat.ps.instructions
>> >    3315209 =C2=B1  3%      -4.8%    3154566 =C2=B1  2%      -3.8%    3=
188030 =C2=B1  3%
>> >  perf-stat.ps.node-store-misses
>> >     477440 =C2=B1  4%     -19.4%     384927 =C2=B1  5%     -22.2%     =
371554 =C2=B1  6%
>> >  perf-stat.ps.node-stores
>> >  3.496e+11 =C2=B1  3%     -18.0%  2.867e+11           -16.4%  2.924e+1=
1
>> >  perf-stat.total.instructions
>> >      10.78            -9.4        1.40 =C2=B1  4%      -9.3        1.4=
4 =C2=B1 11%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.w=
alk_component.path_lookupat
>> >      18.43            -6.6       11.87            -6.5       11.92 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_c=
omponent.path_lookupat.filename_lookup
>> >      18.62            -6.3       12.33            -6.2       12.38 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.path_loo=
kupat.filename_lookup.user_path_at_empty
>> >       3.70 =C2=B1  2%      -3.0        0.71 =C2=B1  6%      -3.0      =
  0.73 =C2=B1 11%
>> >
>> > perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel._=
_lookup_slow.walk_component
>> >       3.54 =C2=B1  2%      -2.8        0.69 =C2=B1  5%      -2.8      =
  0.70 =C2=B1 12%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_a=
lloc_parallel.__lookup_slow
>> >       9.18            -2.7        6.50            -2.8        6.42
>> >  perf-profile.calltrace.cycles-pp.open64
>> >       3.35            -2.7        0.68 =C2=B1  4%      -2.6        0.7=
1 =C2=B1 11%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.d_alloc_parallel.__loo=
kup_slow.walk_component
>> >       9.09            -2.7        6.43            -2.7        6.36
>> >  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open6=
4
>> >       9.08            -2.6        6.43            -2.7        6.35
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.open64
>> >       9.05            -2.6        6.41            -2.7        6.34
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.open64
>> >       9.04            -2.6        6.40            -2.7        6.33
>> >
>> > perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.open64
>> >       3.22 =C2=B1  2%      -2.6        0.58 =C2=B1  6%      -2.7      =
  0.55 =C2=B1 34%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.__dentry_kill.dput.d_alloc_parallel
>> >       3.21 =C2=B1  2%      -2.6        0.65 =C2=B1  4%      -2.5      =
  0.68 =C2=B1 11%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.d_alloc=
_parallel.__lookup_slow
>> >       3.18 =C2=B1  2%      -2.5        0.65 =C2=B1  5%      -2.5      =
  0.67 =C2=B1 11%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.fast_dput.dput.d_alloc_parallel
>> >       8.54            -2.5        6.05            -2.5        5.99
>> >
>> > perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys=
_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       8.50            -2.5        6.03            -2.5        5.97
>> >
>> > perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_opena=
t2.__x64_sys_openat.do_syscall_64
>> >       7.61            -2.3        5.28            -2.3        5.28
>> >  perf-profile.calltrace.cycles-pp.__xstat64
>> >       7.53            -2.3        5.22            -2.3        5.23
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xsta=
t64
>> >       7.52            -2.3        5.22            -2.3        5.22
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__xstat64
>> >       7.50            -2.3        5.20            -2.3        5.20
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.__xstat64
>> >       7.17            -2.2        4.99            -2.2        4.98
>> >
>> > perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall=
_64.entry_SYSCALL_64_after_hwframe.__xstat64
>> >       6.56            -2.0        4.54 =C2=B1  2%      -1.9        4.6=
3
>> >
>> > perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename=
_lookup.user_path_at_empty.user_statfs
>> >       6.42            -2.0        4.45 =C2=B1  2%      -2.0        4.4=
6
>> >
>> > perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_ne=
wstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       6.39            -2.0        4.42 =C2=B1  2%      -2.0        4.4=
3
>> >
>> > perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_sta=
tx.__do_sys_newstat.do_syscall_64
>> >       6.99            -1.8        5.15 =C2=B1  2%      -1.8        5.2=
2
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead._=
_legitimize_path.try_to_unlazy.link_path_walk
>> >       5.84 =C2=B1  2%      -1.6        4.21 =C2=B1  2%      -1.5      =
  4.30
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_=
path_walk.path_lookupat.filename_lookup
>> >       5.76            -1.6        4.19 =C2=B1  2%      -1.5        4.2=
7
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_pat=
h.try_to_unlazy.link_path_walk.path_lookupat
>> >      31.88            -1.4       30.50            -1.5       30.40
>> >
>> > perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename=
_lookup.user_path_at_empty.user_statfs
>> >       3.91 =C2=B1  3%      -1.1        2.84 =C2=B1  3%      -1.0      =
  2.91
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_loo=
kupat.filename_lookup.user_path_at_empty
>> >       3.14            -1.0        2.17 =C2=B1  2%      -1.0        2.1=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename=
_lookup.vfs_statx.__do_sys_newstat
>> >       3.18            -1.0        2.22            -1.0        2.21 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_op=
en.do_sys_openat2.__x64_sys_openat
>> >       1.72 =C2=B1  2%      -1.0        0.77 =C2=B1  2%      -0.9      =
  0.79 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.compl=
ete_walk.path_lookupat.filename_lookup
>> >       2.28 =C2=B1  6%      -0.8        1.48 =C2=B1  3%      -0.8      =
  1.52 =C2=B1  7%
>> >  perf-profile.calltrace.cycles-pp.syscall
>> >       2.19 =C2=B1  6%      -0.8        1.42 =C2=B1  3%      -0.7      =
  1.46 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscal=
l
>> >       2.18 =C2=B1  6%      -0.8        1.41 =C2=B1  3%      -0.7      =
  1.46 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.syscall
>> >       1.90 =C2=B1  3%      -0.8        1.14 =C2=B1  3%      -0.8      =
  1.11 =C2=B1  2%
>> >  perf-profile.calltrace.cycles-pp.__close
>> >       2.14 =C2=B1  6%      -0.8        1.39 =C2=B1  3%      -0.7      =
  1.43 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_ustat.do_syscall_64.entry_SY=
SCALL_64_after_hwframe.syscall
>> >       1.82 =C2=B1  3%      -0.7        1.08 =C2=B1  2%      -0.8      =
  1.05 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clos=
e
>> >       1.81 =C2=B1  3%      -0.7        1.08 =C2=B1  2%      -0.8      =
  1.04 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__close
>> >       1.79 =C2=B1  3%      -0.7        1.06 =C2=B1  2%      -0.8      =
  1.03 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.__close
>> >       1.53 =C2=B1  3%      -0.7        0.87 =C2=B1  3%      -0.7      =
  0.85 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.=
entry_SYSCALL_64_after_hwframe.__close
>> >       2.44            -0.6        1.81 =C2=B1  2%      -0.7        1.7=
7 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_op=
en.do_sys_openat2.__x64_sys_openat
>> >       2.43            -0.6        1.80 =C2=B1  2%      -0.7        1.7=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_fi=
lp_open.do_sys_openat2
>> >       2.42            -0.6        1.79 =C2=B1  2%      -0.7        1.7=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_op=
enat.do_filp_open
>> >       1.72 =C2=B1  3%      -0.6        1.11 =C2=B1  4%      -0.6      =
  1.14 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys=
_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       1.96 =C2=B1  2%      -0.6        1.37 =C2=B1  2%      -0.6      =
  1.36 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_s=
ys_openat2.__x64_sys_openat
>> >       2.12            -0.6        1.52 =C2=B1  4%      -0.6        1.5=
4 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename=
_lookup.vfs_statx.__do_sys_newstat
>> >       2.11            -0.6        1.52 =C2=B1  4%      -0.6        1.5=
3 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.fil=
ename_lookup.vfs_statx
>> >       1.94 =C2=B1  2%      -0.6        1.38 =C2=B1  3%      -0.5      =
  1.40 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_loo=
kupat.filename_lookup.vfs_statx
>> >       2.19            -0.6        1.63 =C2=B1  2%      -0.6        1.6=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.termina=
te_walk.path_openat
>> >       1.95 =C2=B1  3%      -0.5        1.42 =C2=B1  2%      -0.5      =
  1.44 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_ope=
nat.do_filp_open.do_sys_openat2
>> >       1.95 =C2=B1  3%      -0.5        1.42 =C2=B1  2%      -0.5      =
  1.43 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_=
path_walk.path_openat.do_filp_open
>> >       1.32 =C2=B1  6%      -0.5        0.82 =C2=B1  8%      -0.5      =
  0.81 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_=
lookupat.filename_lookup.user_path_at_empty
>> >       1.92 =C2=B1  2%      -0.5        1.41 =C2=B1  3%      -0.5      =
  1.42 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_pat=
h.try_to_unlazy.link_path_walk.path_openat
>> >       1.12 =C2=B1  6%      -0.5        0.62 =C2=B1  3%      -0.5      =
  0.62 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_compo=
nent.path_lookupat.filename_lookup
>> >       1.39 =C2=B1  3%      -0.4        0.94 =C2=B1  3%      -0.5      =
  0.93 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do=
_filp_open.do_sys_openat2
>> >       1.16 =C2=B1  6%      -0.4        0.76 =C2=B1  3%      -0.4      =
  0.78 =C2=B1  5%
>> >
>> > perf-profile.calltrace.cycles-pp.user_get_super.__do_sys_ustat.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe.syscall
>> >       1.16 =C2=B1  3%      -0.4        0.78 =C2=B1  2%      -0.4      =
  0.81 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_=
lookup.user_path_at_empty.user_statfs
>> >       1.15 =C2=B1  3%      -0.4        0.78 =C2=B1  2%      -0.4      =
  0.80 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_look=
upat.filename_lookup.user_path_at_empty
>> >       0.85 =C2=B1  6%      -0.4        0.49 =C2=B1 33%      -0.4      =
  0.46 =C2=B1 50%
>> >
>> > perf-profile.calltrace.cycles-pp.shmem_statfs.statfs_by_dentry.user_st=
atfs.__do_sys_statfs.do_syscall_64
>> >       0.95 =C2=B1 18%      -0.3        0.62 =C2=B1  4%      -0.3      =
  0.63 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_pat=
h.try_to_unlazy.complete_walk.path_lookupat
>> >       0.76 =C2=B1  5%      -0.3        0.43 =C2=B1 50%      -0.3      =
  0.44 =C2=B1 50%
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_fstatfs.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.fstatfs64
>> >       1.00 =C2=B1  5%      -0.3        0.69 =C2=B1  5%      -0.3      =
  0.70 =C2=B1  7%
>> >  perf-profile.calltrace.cycles-pp.fstatfs64
>> >       0.90 =C2=B1  7%      -0.3        0.62 =C2=B1  5%      -0.3      =
  0.63 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lo=
okupat.filename_lookup.user_path_at_empty
>> >       0.89 =C2=B1  7%      -0.3        0.61 =C2=B1  6%      -0.3      =
  0.62 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_=
walk.path_lookupat.filename_lookup
>> >       0.82 =C2=B1  5%      -0.3        0.55 =C2=B1  3%      -0.3      =
  0.51 =C2=B1 34%
>> >
>> > perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.user=
_statfs.__do_sys_statfs.do_syscall_64
>> >       0.83 =C2=B1  5%      -0.3        0.58 =C2=B1  6%      -0.3      =
  0.58 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatf=
s64
>> >       0.81 =C2=B1  5%      -0.2        0.56 =C2=B1  6%      -0.2      =
  0.57 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.fstatfs64
>> >       0.57 =C2=B1  4%      +0.3        0.82 =C2=B1  6%      +0.2      =
  0.74 =C2=B1  5%
>> >
>> > perf-profile.calltrace.cycles-pp.down_read.walk_component.path_lookupa=
t.filename_lookup.user_path_at_empty
>> >       0.27 =C2=B1100%      +0.5        0.76 =C2=B1  4%      +0.4      =
  0.69 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.tr=
y_to_unlazy.lookup_fast.walk_component
>> >       1.04 =C2=B1  4%      +0.5        1.57 =C2=B1  4%      +0.4      =
  1.44 =C2=B1  5%
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_put_return.fast_dput.dput.ter=
minate_walk.path_lookupat
>> >       5.24            +2.2        7.44 =C2=B1  2%      +2.2        7.4=
4
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
>> >       5.82            +2.3        8.14            +2.3        8.15
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parall=
el.__lookup_slow.walk_component
>> >       6.27            +2.4        8.64            +2.4        8.65
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slo=
w.walk_component.path_lookupat
>> >      16.20            +3.4       19.56            +3.4       19.62
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
>> >      17.74            +3.5       21.21 =C2=B1  2%      +3.5       21.2=
8
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.fast_dput.dput.terminate_walk
>> >      15.97            +3.9       19.86 =C2=B1  2%      +4.0       19.9=
6
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.termina=
te_walk.path_lookupat
>> >      17.18            +4.4       21.55            +4.3       21.51
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lo=
okupat.filename_lookup
>> >      12.22            +4.7       16.92            +4.6       16.85
>> >
>> > perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.path_looku=
pat.filename_lookup.user_path_at_empty
>> >      15.14            +5.0       20.10            +4.9       20.05
>> >
>> > perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename=
_lookup.user_path_at_empty.user_statfs
>> >      15.10            +5.0       20.06            +4.9       20.01
>> >
>> > perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.fil=
ename_lookup.user_path_at_empty
>> >       1.61 =C2=B1  3%      +5.0        6.60            +5.0        6.6=
4
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.__dentry_kill.dput.step_into
>> >      10.23            +5.1       15.30            +5.1       15.30
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_pat=
h.try_to_unlazy.lookup_fast.walk_component
>> >       9.72            +5.2       14.89            +5.2       14.88
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead._=
_legitimize_path.try_to_unlazy.lookup_fast
>> >      10.74            +5.3       16.07            +5.3       16.00
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.looku=
p_fast.walk_component.path_lookupat
>> >      10.75            +5.3       16.09            +5.3       16.02
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_compon=
ent.path_lookupat.filename_lookup
>> >       1.72            +5.4        7.16            +5.4        7.11 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.fast_dput.dput.step_into
>> >       1.75            +5.5        7.22            +5.4        7.17 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.step_in=
to.path_lookupat
>> >       2.12            +5.5        7.59            +5.4        7.54 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.step_into.path_lookupa=
t.filename_lookup
>> >       1.92 =C2=B1  3%      +5.7        7.63            +5.7        7.6=
5
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.ste=
p_into.path_lookupat
>> >       2.10 =C2=B1  3%      +5.9        8.05            +6.0        8.1=
0
>> >
>> > perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.path_loo=
kupat.filename_lookup
>> >      68.68            +7.5       76.18            +7.4       76.10
>> >  perf-profile.calltrace.cycles-pp.__statfs
>> >      68.40            +7.6       75.97            +7.5       75.90
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__stat=
fs
>> >      68.35            +7.6       75.94            +7.5       75.87
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__statfs
>> >      68.22            +7.6       75.85            +7.6       75.78
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.__statfs
>> >      67.97            +7.7       75.68            +7.6       75.61
>> >
>> > perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe.__statfs
>> >       8.18            +7.9       16.06            +7.9       16.05
>> >
>> > perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_look=
up.user_path_at_empty.user_statfs
>> >       7.62            +8.0       15.67            +8.0       15.67
>> >
>> > perf-profile.calltrace.cycles-pp.dput.step_into.path_lookupat.filename=
_lookup.user_path_at_empty
>> >      65.52            +8.5       74.06            +8.4       73.94
>> >
>> > perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_s=
ys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >      63.54            +8.8       72.34            +8.7       72.28
>> >
>> > perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.us=
er_statfs.__do_sys_statfs.do_syscall_64
>> >      63.38            +8.8       72.22            +8.8       72.16
>> >
>> > perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_pa=
th_at_empty.user_statfs.__do_sys_statfs
>> >       7.39            -7.4        0.00            -7.4        0.00
>> >  perf-profile.children.cycles-pp.lock_for_kill
>> >      18.47            -6.6       11.91            -6.5       11.96 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.d_alloc_parallel
>> >      18.65            -6.3       12.36            -6.2       12.41 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.__lookup_slow
>> >      13.05            -4.0        9.09            -3.9        9.14
>> >  perf-profile.children.cycles-pp.link_path_walk
>> >       9.20            -2.7        6.51            -2.8        6.44
>> >  perf-profile.children.cycles-pp.open64
>> >       9.25            -2.6        6.60            -2.7        6.52
>> >  perf-profile.children.cycles-pp.__x64_sys_openat
>> >       9.24            -2.6        6.60            -2.7        6.52
>> >  perf-profile.children.cycles-pp.do_sys_openat2
>> >       8.73            -2.5        6.25            -2.5        6.18
>> >  perf-profile.children.cycles-pp.do_filp_open
>> >       8.70            -2.5        6.23            -2.5        6.16
>> >  perf-profile.children.cycles-pp.path_openat
>> >       7.64            -2.3        5.30            -2.3        5.30
>> >  perf-profile.children.cycles-pp.__xstat64
>> >       7.55            -2.3        5.25            -2.3        5.25
>> >  perf-profile.children.cycles-pp.__do_sys_newstat
>> >       7.22            -2.2        5.04            -2.2        5.03
>> >  perf-profile.children.cycles-pp.vfs_statx
>> >      33.93            -2.0       31.94            -2.1       31.83
>> >  perf-profile.children.cycles-pp.walk_component
>> >       3.02 =C2=B1  3%      -1.0        1.98 =C2=B1  3%      -1.0      =
  2.04 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.statfs_by_dentry
>> >       2.67 =C2=B1  5%      -1.0        1.67 =C2=B1  6%      -1.1      =
  1.61 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.inode_permission
>> >       2.31 =C2=B1  6%      -0.8        1.50 =C2=B1  3%      -0.8      =
  1.54 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.syscall
>> >       1.93 =C2=B1  3%      -0.8        1.16 =C2=B1  3%      -0.8      =
  1.13 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__close
>> >       2.14 =C2=B1  6%      -0.8        1.39 =C2=B1  3%      -0.7      =
  1.44 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__do_sys_ustat
>> >       2.20 =C2=B1  4%      -0.7        1.45 =C2=B1  5%      -0.7      =
  1.50 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.__percpu_counter_sum
>> >       1.79 =C2=B1  3%      -0.7        1.06 =C2=B1  2%      -0.8      =
  1.03 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__x64_sys_close
>> >       2.14 =C2=B1  2%      -0.7        1.48            -0.6        1.5=
2 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.complete_walk
>> >       1.54 =C2=B1  3%      -0.7        0.88 =C2=B1  3%      -0.7      =
  0.86 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__fput
>> >       1.63 =C2=B1  7%      -0.6        1.03 =C2=B1  9%      -0.6      =
  0.98 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.kernfs_iop_permission
>> >       1.97 =C2=B1  2%      -0.6        1.37 =C2=B1  2%      -0.6      =
  1.36 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_open
>> >       1.51 =C2=B1  6%      -0.5        0.97 =C2=B1  4%      -0.5      =
  0.98 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.__d_lookup_rcu
>> >       1.49 =C2=B1  5%      -0.5        0.96 =C2=B1  4%      -0.5      =
  1.00 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.shmem_statfs
>> >       1.42 =C2=B1  3%      -0.5        0.92 =C2=B1  3%      -0.5      =
  0.91 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.lockref_get
>> >       1.40 =C2=B1  3%      -0.5        0.94 =C2=B1  3%      -0.5      =
  0.94 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_dentry_open
>> >       0.86 =C2=B1  3%      -0.4        0.43 =C2=B1  2%      -0.4      =
  0.42 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.dcache_dir_close
>> >       1.20 =C2=B1  4%      -0.4        0.80 =C2=B1  4%      -0.4      =
  0.81 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.getname_flags
>> >       1.16 =C2=B1  6%      -0.4        0.76 =C2=B1  3%      -0.4      =
  0.78 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.user_get_super
>> >       0.47 =C2=B1  5%      -0.4        0.11 =C2=B1 17%      -0.4      =
  0.11 =C2=B1 16%
>> >  perf-profile.children.cycles-pp._raw_spin_trylock
>> >       2.30 =C2=B1  3%      -0.3        1.96 =C2=B1  5%      -0.5      =
  1.84 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.down_read
>> >       1.05 =C2=B1  5%      -0.3        0.73 =C2=B1  5%      -0.3      =
  0.73 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.fstatfs64
>> >       0.97 =C2=B1  4%      -0.3        0.67 =C2=B1  9%      -0.3      =
  0.68 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.ext4_statfs
>> >       1.02 =C2=B1  7%      -0.3        0.73 =C2=B1  6%      -0.3      =
  0.70 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.up_read
>> >       0.97 =C2=B1  3%      -0.3        0.71 =C2=B1  5%      -0.3      =
  0.70 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.try_to_unlazy_next
>> >       0.82 =C2=B1  9%      -0.3        0.56 =C2=B1  6%      -0.3      =
  0.54 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.__traverse_mounts
>> >       0.77 =C2=B1  6%      -0.3        0.51 =C2=B1  5%      -0.2      =
  0.52 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.strncpy_from_user
>> >       0.31 =C2=B1 61%      -0.2        0.06 =C2=B1169%      -0.3      =
  0.03 =C2=B1300%
>> >  perf-profile.children.cycles-pp.smpboot_thread_fn
>> >       0.40 =C2=B1 48%      -0.2        0.16 =C2=B1 62%      -0.2      =
  0.14 =C2=B1 59%
>> >  perf-profile.children.cycles-pp.ret_from_fork
>> >       0.39 =C2=B1 49%      -0.2        0.16 =C2=B1 64%      -0.2      =
  0.14 =C2=B1 61%
>> >  perf-profile.children.cycles-pp.kthread
>> >       0.61 =C2=B1 10%      -0.2        0.38 =C2=B1 10%      -0.2      =
  0.40 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__d_lookup
>> >       0.40 =C2=B1 48%      -0.2        0.17 =C2=B1 61%      -0.2      =
  0.14 =C2=B1 59%
>> >  perf-profile.children.cycles-pp.ret_from_fork_asm
>> >       0.76 =C2=B1  5%      -0.2        0.53 =C2=B1  6%      -0.2      =
  0.53 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.__do_sys_fstatfs
>> >       0.64 =C2=B1  5%      -0.2        0.41 =C2=B1  4%      -0.2      =
  0.44 =C2=B1  5%
>> >  perf-profile.children.cycles-pp._find_next_or_bit
>> >       0.46 =C2=B1  9%      -0.2        0.24 =C2=B1  7%      -0.2      =
  0.24 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.path_init
>> >       0.80 =C2=B1  3%      -0.2        0.58 =C2=B1  5%      -0.2      =
  0.59 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.path_put
>> >       0.54 =C2=B1 13%      -0.2        0.33 =C2=B1 11%      -0.2      =
  0.33 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.kernfs_dop_revalidate
>> >       0.67 =C2=B1  6%      -0.2        0.47 =C2=B1  6%      -0.2      =
  0.47 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.fd_statfs
>> >       0.39 =C2=B1 10%      -0.2        0.19 =C2=B1  9%      -0.2      =
  0.19 =C2=B1 10%
>> >  perf-profile.children.cycles-pp.nd_jump_root
>> >       0.52 =C2=B1  4%      -0.2        0.34 =C2=B1  6%      -0.2      =
  0.34 =C2=B1 10%
>> >  perf-profile.children.cycles-pp.kmem_cache_free
>> >       0.61 =C2=B1  6%      -0.2        0.44 =C2=B1  9%      -0.2      =
  0.44 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.alloc_empty_file
>> >       0.50 =C2=B1  3%      -0.2        0.34 =C2=B1  7%      -0.2      =
  0.34 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.dcache_dir_open
>> >       0.50 =C2=B1  3%      -0.2        0.34 =C2=B1  7%      -0.2      =
  0.34 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.d_alloc_cursor
>> >       0.44 =C2=B1  8%      -0.2        0.29 =C2=B1  7%      -0.1      =
  0.31 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.entry_SYSCALL_64
>> >       0.44 =C2=B1  7%      -0.1        0.31 =C2=B1  9%      -0.1      =
  0.31 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.kmem_cache_alloc
>> >       0.38 =C2=B1  7%      -0.1        0.25 =C2=B1  8%      -0.1      =
  0.26 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__check_object_size
>> >       0.45 =C2=B1  7%      -0.1        0.32 =C2=B1  9%      -0.1      =
  0.33 =C2=B1 10%
>> >  perf-profile.children.cycles-pp.security_file_alloc
>> >       0.47 =C2=B1  6%      -0.1        0.35 =C2=B1  7%      -0.1      =
  0.35 =C2=B1 10%
>> >  perf-profile.children.cycles-pp.init_file
>> >       0.40 =C2=B1  8%      -0.1        0.29 =C2=B1 11%      -0.1      =
  0.30 =C2=B1 10%
>> >  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>> >       0.32 =C2=B1  9%      -0.1        0.20 =C2=B1  6%      -0.1      =
  0.20 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.super_lock
>> >       0.24 =C2=B1 12%      -0.1        0.13 =C2=B1 10%      -0.1      =
  0.13 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.security_file_free
>> >       0.21 =C2=B1 10%      -0.1        0.10 =C2=B1 10%      -0.1      =
  0.11 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.set_root
>> >       0.23 =C2=B1 12%      -0.1        0.12 =C2=B1 10%      -0.1      =
  0.13 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.apparmor_file_free_security
>> >       0.28 =C2=B1  9%      -0.1        0.18 =C2=B1  7%      -0.1      =
  0.19 =C2=B1 13%
>> >  perf-profile.children.cycles-pp.open_last_lookups
>> >       0.30 =C2=B1  3%      -0.1        0.21 =C2=B1  8%      -0.1      =
  0.21 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>> >       0.26 =C2=B1  4%      -0.1        0.17 =C2=B1  7%      -0.1      =
  0.18 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.ioctl
>> >       0.27 =C2=B1  7%      -0.1        0.18 =C2=B1 10%      -0.1      =
  0.18 =C2=B1 11%
>> >  perf-profile.children.cycles-pp._copy_to_user
>> >       0.22 =C2=B1 16%      -0.1        0.14 =C2=B1  9%      -0.1      =
  0.15 =C2=B1 21%
>> >  perf-profile.children.cycles-pp.drop_super
>> >       0.19 =C2=B1 23%      -0.1        0.11 =C2=B1  9%      -0.1      =
  0.10 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.generic_permission
>> >       0.19 =C2=B1  9%      -0.1        0.11 =C2=B1  6%      -0.1      =
  0.12 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.simple_statfs
>> >       0.17 =C2=B1 11%      -0.1        0.11 =C2=B1 11%      -0.1      =
  0.11 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>> >       0.19 =C2=B1  6%      -0.1        0.13 =C2=B1  9%      -0.1      =
  0.12 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.check_heap_object
>> >       0.20 =C2=B1  6%      -0.1        0.14 =C2=B1  8%      -0.1      =
  0.13 =C2=B1 13%
>> >  perf-profile.children.cycles-pp.do_statfs_native
>> >       0.38 =C2=B1  3%      -0.1        0.32 =C2=B1  5%      -0.1      =
  0.31 =C2=B1  8%
>> >  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>> >       0.13 =C2=B1  9%      -0.1        0.07 =C2=B1 17%      -0.1      =
  0.07 =C2=B1 12%
>> >  perf-profile.children.cycles-pp.apparmor_file_open
>> >       0.13 =C2=B1 10%      -0.1        0.07 =C2=B1 18%      -0.1      =
  0.07 =C2=B1 13%
>> >  perf-profile.children.cycles-pp.security_file_open
>> >       0.13 =C2=B1  6%      -0.0        0.08 =C2=B1 12%      -0.1      =
  0.07 =C2=B1 12%
>> >  perf-profile.children.cycles-pp.may_open
>> >       0.16 =C2=B1 11%      -0.0        0.12 =C2=B1 10%      -0.1      =
  0.11 =C2=B1 13%
>> >  perf-profile.children.cycles-pp.generic_fillattr
>> >       0.21 =C2=B1  7%      -0.0        0.16 =C2=B1  6%      -0.1      =
  0.16 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.__cond_resched
>> >       0.11 =C2=B1 14%      -0.0        0.06 =C2=B1 12%      -0.0      =
  0.08 =C2=B1 10%
>> >  perf-profile.children.cycles-pp.__check_heap_object
>> >       0.16 =C2=B1 11%      -0.0        0.12 =C2=B1 10%      -0.1      =
  0.11 =C2=B1 13%
>> >  perf-profile.children.cycles-pp.vfs_getattr_nosec
>> >       0.14 =C2=B1  8%      -0.0        0.10 =C2=B1  9%      -0.0      =
  0.10 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.filp_flush
>> >       0.11 =C2=B1 10%      -0.0        0.07 =C2=B1 13%      -0.0      =
  0.07 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.__x64_sys_ioctl
>> >       0.10 =C2=B1 17%      -0.0        0.07 =C2=B1 15%      -0.0      =
  0.08 =C2=B1 23%
>> >  perf-profile.children.cycles-pp.btrfs_statfs
>> >       0.09 =C2=B1 14%      -0.0        0.05 =C2=B1 34%      -0.0      =
  0.07 =C2=B1 17%
>> >  perf-profile.children.cycles-pp.stress_sysinfo
>> >       0.11 =C2=B1 10%      -0.0        0.08 =C2=B1 11%      -0.0      =
  0.07 =C2=B1 18%
>> >  perf-profile.children.cycles-pp.autofs_d_manage
>> >       0.09 =C2=B1  7%      -0.0        0.06 =C2=B1  6%      -0.0      =
  0.06 =C2=B1 35%
>> >  perf-profile.children.cycles-pp.__virt_addr_valid
>> >       0.00            +0.1        0.07 =C2=B1  7%      +0.1        0.0=
7 =C2=B1 16%
>> >  perf-profile.children.cycles-pp.__wake_up
>> >       0.06 =C2=B1 36%      +0.1        0.13 =C2=B1 14%      +0.1      =
  0.14 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.___d_drop
>> >       0.01 =C2=B1200%      +0.1        0.09 =C2=B1 11%      +0.1      =
  0.09 =C2=B1 11%
>> >  perf-profile.children.cycles-pp.__d_lookup_unhash
>> >       0.05 =C2=B1 36%      +0.1        0.16 =C2=B1 15%      +0.1      =
  0.16 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__d_rehash
>> >       0.16 =C2=B1 10%      +0.2        0.40 =C2=B1  7%      +0.2      =
  0.40 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__d_add
>> >       0.17 =C2=B1  9%      +0.2        0.42 =C2=B1  7%      +0.2      =
  0.42 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.simple_lookup
>> >      40.61            +1.5       42.07            +1.4       42.01
>> >  perf-profile.children.cycles-pp.dput
>> >      21.19            +2.0       23.18            +2.1       23.29
>> >  perf-profile.children.cycles-pp.lockref_get_not_dead
>> >      21.63            +2.3       23.92            +2.4       23.99
>> >  perf-profile.children.cycles-pp.__legitimize_path
>> >       6.29            +2.4        8.67            +2.4        8.68
>> >  perf-profile.children.cycles-pp.d_alloc
>> >      20.75            +2.5       23.28            +2.6       23.35
>> >  perf-profile.children.cycles-pp.try_to_unlazy
>> >       6.15            +2.9        9.02            +2.9        9.08
>> >  perf-profile.children.cycles-pp.__dentry_kill
>> >      19.78            +3.7       23.51            +3.7       23.44
>> >  perf-profile.children.cycles-pp.terminate_walk
>> >      14.30            +4.1       18.36            +4.0       18.30
>> >  perf-profile.children.cycles-pp.lookup_fast
>> >      26.95            +6.0       32.94            +5.9       32.82
>> >  perf-profile.children.cycles-pp.fast_dput
>> >      63.58            +6.4       70.01            +6.6       70.20
>> >  perf-profile.children.cycles-pp._raw_spin_lock
>> >      70.02            +6.8       76.83            +6.8       76.78
>> >  perf-profile.children.cycles-pp.filename_lookup
>> >      69.84            +6.9       76.71            +6.8       76.66
>> >  perf-profile.children.cycles-pp.path_lookupat
>> >      59.37            +7.0       66.41            +7.2       66.57
>> >  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>> >      68.82            +7.4       76.26            +7.4       76.19
>> >  perf-profile.children.cycles-pp.__statfs
>> >       9.19 =C2=B1  2%      +7.5       16.70            +7.5       16.6=
9
>> >  perf-profile.children.cycles-pp.step_into
>> >      68.23            +7.6       75.86            +7.6       75.78
>> >  perf-profile.children.cycles-pp.__do_sys_statfs
>> >      67.98            +7.7       75.69            +7.6       75.62
>> >  perf-profile.children.cycles-pp.user_statfs
>> >      65.54            +8.5       74.08            +8.4       73.96
>> >  perf-profile.children.cycles-pp.user_path_at_empty
>> >       2.53 =C2=B1  2%      -1.0        1.53 =C2=B1  3%      -1.0      =
  1.56 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.lockref_get_not_dead
>> >       4.22            -0.6        3.60 =C2=B1  3%      -0.6        3.6=
2 =C2=B1  2%
>> >  perf-profile.self.cycles-pp._raw_spin_lock
>> >       1.49 =C2=B1  6%      -0.5        0.95 =C2=B1  5%      -0.5      =
  0.96 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.__d_lookup_rcu
>> >       1.40 =C2=B1  5%      -0.5        0.92 =C2=B1  8%      -0.5      =
  0.95 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.__percpu_counter_sum
>> >       0.47 =C2=B1  5%      -0.4        0.10 =C2=B1 12%      -0.4      =
  0.11 =C2=B1 16%
>> >  perf-profile.self.cycles-pp._raw_spin_trylock
>> >       0.89 =C2=B1  9%      -0.3        0.54 =C2=B1  5%      -0.4      =
  0.54 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.inode_permission
>> >       2.25 =C2=B1  4%      -0.3        1.92 =C2=B1  5%      -0.5      =
  1.80 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.down_read
>> >       1.01 =C2=B1  8%      -0.3        0.72 =C2=B1  6%      -0.3      =
  0.69 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.up_read
>> >       0.74 =C2=B1  4%      -0.3        0.49 =C2=B1  5%      -0.3      =
  0.47 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.lockref_get
>> >       0.57 =C2=B1  4%      -0.2        0.39 =C2=B1  7%      -0.2      =
  0.40 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.user_get_super
>> >       0.49 =C2=B1  5%      -0.2        0.32 =C2=B1  6%      -0.2      =
  0.33 =C2=B1  6%
>> >  perf-profile.self.cycles-pp._find_next_or_bit
>> >       0.41 =C2=B1  5%      -0.2        0.24 =C2=B1  5%      -0.2      =
  0.24 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.kmem_cache_free
>> >       0.39 =C2=B1  6%      -0.1        0.25 =C2=B1  7%      -0.1      =
  0.26 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.do_dentry_open
>> >       0.39 =C2=B1  7%      -0.1        0.26 =C2=B1  6%      -0.1      =
  0.26 =C2=B1  9%
>> >  perf-profile.self.cycles-pp.strncpy_from_user
>> >       0.23 =C2=B1 13%      -0.1        0.12 =C2=B1  8%      -0.1      =
  0.13 =C2=B1 12%
>> >  perf-profile.self.cycles-pp.apparmor_file_free_security
>> >       0.40 =C2=B1  9%      -0.1        0.29 =C2=B1 10%      -0.1      =
  0.29 =C2=B1 10%
>> >  perf-profile.self.cycles-pp.apparmor_file_alloc_security
>> >       0.26 =C2=B1 12%      -0.1        0.17 =C2=B1  6%      -0.1      =
  0.18 =C2=B1  9%
>> >  perf-profile.self.cycles-pp.kmem_cache_alloc
>> >       0.26 =C2=B1  8%      -0.1        0.17 =C2=B1  7%      -0.1      =
  0.18 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.link_path_walk
>> >       0.29 =C2=B1  4%      -0.1        0.20 =C2=B1  9%      -0.1      =
  0.20 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>> >       0.26 =C2=B1  7%      -0.1        0.17 =C2=B1  9%      -0.1      =
  0.17 =C2=B1 10%
>> >  perf-profile.self.cycles-pp._copy_to_user
>> >       0.26 =C2=B1  6%      -0.1        0.17 =C2=B1 10%      -0.1      =
  0.16 =C2=B1 11%
>> >  perf-profile.self.cycles-pp.shmem_statfs
>> >       0.16 =C2=B1 25%      -0.1        0.08 =C2=B1 12%      -0.1      =
  0.08 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.generic_permission
>> >       0.19 =C2=B1  9%      -0.1        0.11 =C2=B1  5%      -0.1      =
  0.12 =C2=B1  9%
>> >  perf-profile.self.cycles-pp.simple_statfs
>> >       0.19 =C2=B1  7%      -0.1        0.12 =C2=B1  9%      -0.1      =
  0.12 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.statfs_by_dentry
>> >       0.18 =C2=B1  8%      -0.1        0.11 =C2=B1 11%      -0.1      =
  0.12 =C2=B1 13%
>> >  perf-profile.self.cycles-pp.__statfs
>> >       0.14 =C2=B1 15%      -0.1        0.08 =C2=B1 13%      -0.1      =
  0.08 =C2=B1 13%
>> >  perf-profile.self.cycles-pp.lookup_fast
>> >       0.12 =C2=B1 10%      -0.1        0.07 =C2=B1 17%      -0.1      =
  0.07 =C2=B1 12%
>> >  perf-profile.self.cycles-pp.apparmor_file_open
>> >       0.18 =C2=B1  9%      -0.1        0.12 =C2=B1 12%      -0.1      =
  0.12 =C2=B1  9%
>> >  perf-profile.self.cycles-pp.filename_lookup
>> >       0.18 =C2=B1  6%      -0.0        0.14 =C2=B1 11%      -0.1      =
  0.13 =C2=B1 10%
>> >  perf-profile.self.cycles-pp.step_into
>> >       0.16 =C2=B1 11%      -0.0        0.11 =C2=B1  9%      -0.1      =
  0.11 =C2=B1 12%
>> >  perf-profile.self.cycles-pp.generic_fillattr
>> >       0.34 =C2=B1  3%      -0.0        0.29 =C2=B1  5%      -0.1      =
  0.28 =C2=B1  6%
>> >  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>> >       0.12 =C2=B1  8%      -0.0        0.07 =C2=B1 10%      -0.0      =
  0.08 =C2=B1 13%
>> >  perf-profile.self.cycles-pp.getname_flags
>> >       0.10 =C2=B1 14%      -0.0        0.06 =C2=B1 14%      -0.0      =
  0.07 =C2=B1 13%
>> >  perf-profile.self.cycles-pp.__check_heap_object
>> >       0.12 =C2=B1 10%      -0.0        0.08 =C2=B1 10%      -0.0      =
  0.09 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.entry_SYSCALL_64
>> >       0.11 =C2=B1 13%      -0.0        0.07 =C2=B1 10%      -0.0      =
  0.08 =C2=B1 15%
>> >  perf-profile.self.cycles-pp.__do_sys_statfs
>> >       0.11 =C2=B1  4%      -0.0        0.08 =C2=B1 13%      -0.0      =
  0.07 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.do_syscall_64
>> >       0.12 =C2=B1 10%      -0.0        0.10 =C2=B1  8%      -0.0      =
  0.10 =C2=B1 12%
>> >  perf-profile.self.cycles-pp.__cond_resched
>> >       0.10 =C2=B1 13%      -0.0        0.08 =C2=B1 16%      -0.0      =
  0.07 =C2=B1 10%
>> >  perf-profile.self.cycles-pp.fast_dput
>> >       0.09 =C2=B1  7%      -0.0        0.06 =C2=B1  9%      -0.0      =
  0.06 =C2=B1 34%
>> >  perf-profile.self.cycles-pp.__virt_addr_valid
>> >       0.08 =C2=B1 13%      -0.0        0.05 =C2=B1 34%      -0.0      =
  0.04 =C2=B1 66%
>> >  perf-profile.self.cycles-pp.path_init
>> >       0.09 =C2=B1 11%      -0.0        0.06 =C2=B1 11%      -0.0      =
  0.06 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.set_root
>> >       0.15 =C2=B1 16%      +0.0        0.18 =C2=B1  7%      +0.0      =
  0.20 =C2=B1 14%
>> >  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
>> >       0.06 =C2=B1 36%      +0.1        0.13 =C2=B1 13%      +0.1      =
  0.13 =C2=B1  8%
>> >  perf-profile.self.cycles-pp.___d_drop
>> >       0.01 =C2=B1200%      +0.1        0.09 =C2=B1 11%      +0.1      =
  0.09 =C2=B1 12%
>> >  perf-profile.self.cycles-pp.__d_lookup_unhash
>> >       0.05 =C2=B1 36%      +0.1        0.15 =C2=B1 15%      +0.1      =
  0.16 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.__d_rehash
>> >       0.52 =C2=B1  6%      +0.7        1.25 =C2=B1  7%      +0.7      =
  1.21 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.d_alloc_parallel
>> >      59.00            +6.9       65.92            +7.0       66.05
>> >  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>> >
>> >
>> > [2]
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/te=
st/testcase:
>> >
>> > gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cg=
z/300s/lkp-icl-2sp9/shell1/unixbench
>> >
>> > commit:
>> >   dc3cf789eb259 step 4: make shrink_kill() keep the parent pinned unti=
l
>> > after __dentry_kill() of victim
>> >   854e9f938aafe step 4.5: call __dentry_kill() without holding a lock =
on
>> > parent
>> >   e2797564725a5 step 5: clean lock_for_kill()
>> >
>> > dc3cf789eb25978f 854e9f938aafe9aa64a1c6bbe7a
>> > e2797564725a5c4e83652167819
>> > ---------------- ---------------------------
>> > ---------------------------
>> >          %stddev     %change         %stddev     %change
>> > %stddev
>> >              \          |                \          |                \
>> >  1.248e+08           +17.7%  1.469e+08           +18.1%  1.474e+08
>> >  cpuidle..usage
>> >      10.07            -1.2        8.88            -1.2        8.91
>> >  mpstat.cpu.all.usr%
>> >     450791           +14.1%     514156           +14.3%     515431
>> >  vmstat.system.cs
>> >     264870           +12.3%     297560           +12.6%     298133
>> >  vmstat.system.in
>> >  4.832e+08           -11.5%  4.275e+08           -11.4%  4.283e+08
>> >  numa-numastat.node0.local_node
>> >  4.832e+08           -11.5%  4.275e+08           -11.4%  4.283e+08
>> >  numa-numastat.node0.numa_hit
>> >  4.814e+08           -11.6%  4.255e+08           -11.4%  4.266e+08
>> >  numa-numastat.node1.local_node
>> >  4.815e+08           -11.6%  4.255e+08           -11.4%  4.266e+08
>> >  numa-numastat.node1.numa_hit
>> >  4.832e+08           -11.5%  4.275e+08           -11.4%  4.283e+08
>> >  numa-vmstat.node0.numa_hit
>> >  4.832e+08           -11.5%  4.275e+08           -11.4%  4.283e+08
>> >  numa-vmstat.node0.numa_local
>> >  4.815e+08           -11.6%  4.255e+08           -11.4%  4.266e+08
>> >  numa-vmstat.node1.numa_hit
>> >  4.814e+08           -11.6%  4.255e+08           -11.4%  4.266e+08
>> >  numa-vmstat.node1.numa_local
>> >      82.32 =C2=B1  8%     -12.0%      72.46 =C2=B1  5%     -11.2%     =
 73.07 =C2=B1 12%
>> >  sched_debug.cfs_rq:/.load_avg.avg
>> >     172.62 =C2=B1  9%     -16.7%     143.84 =C2=B1 12%     -13.8%     =
148.85 =C2=B1 20%
>> >  sched_debug.cfs_rq:/.removed.load_avg.stddev
>> >    2118769           +14.0%    2416288           +14.3%    2421673
>> >  sched_debug.cpu.nr_switches.avg
>> >    2175854           +14.0%    2479813           +14.2%    2485271
>> >  sched_debug.cpu.nr_switches.max
>> >    2000322 =C2=B1  2%     +16.2%    2323738           +17.1%    234179=
3
>> >  sched_debug.cpu.nr_switches.min
>> >    9752242            -8.9%    8882512            -8.6%    8910347
>> >  time.involuntary_context_switches
>> >     935946 =C2=B1  5%     -19.5%     753574 =C2=B1  3%     -18.5%     =
762614 =C2=B1  2%
>> >  time.major_page_faults
>> >  1.403e+09           -11.8%  1.237e+09           -11.6%   1.24e+09
>> >  time.minor_page_faults
>> >       3762            -4.6%       3590            -4.7%       3585
>> >  time.percent_of_cpu_this_job_got
>> >      18312            -2.6%      17831            -2.9%      17777
>> >  time.system_time
>> >       5430 =C2=B1  3%     -11.4%       4811           -10.9%       483=
7
>> >  time.user_time
>> >  1.363e+08           +17.1%  1.596e+08           +17.4%    1.6e+08
>> >  time.voluntary_context_switches
>> >  1.245e+08           +17.7%  1.465e+08           +18.1%   1.47e+08
>> >  turbostat.C1
>> >      37.13            +2.4       39.50            +2.4       39.53
>> >  turbostat.C1%
>> >  1.694e+08           +12.2%    1.9e+08           +12.4%  1.904e+08
>> >  turbostat.IRQ
>> >       2.55 =C2=B1 23%      -2.5        0.00 =C2=B1264%      -2.6      =
  0.00 =C2=B1264%
>> >  turbostat.PKG_%
>> >     273478 =C2=B1  3%     +16.3%     318031           +17.5%     32125=
5
>> >  turbostat.POLL
>> >     392.66            -2.0%     384.95            -2.0%     384.80
>> >  turbostat.PkgWatt
>> >      83.78            -1.9%      82.18            -1.9%      82.20
>> >  turbostat.RAMWatt
>> >      34670           -11.7%      30622           -11.4%      30701
>> >  unixbench.score
>> >    9752242            -8.9%    8882512            -8.6%    8910347
>> >  unixbench.time.involuntary_context_switches
>> >     935946 =C2=B1  5%     -19.5%     753574 =C2=B1  3%     -18.5%     =
762614 =C2=B1  2%
>> >  unixbench.time.major_page_faults
>> >  1.403e+09           -11.8%  1.237e+09           -11.6%   1.24e+09
>> >  unixbench.time.minor_page_faults
>> >       3762            -4.6%       3590            -4.7%       3585
>> >  unixbench.time.percent_of_cpu_this_job_got
>> >      18312            -2.6%      17831            -2.9%      17777
>> >  unixbench.time.system_time
>> >       5430 =C2=B1  3%     -11.4%       4811           -10.9%       483=
7
>> >  unixbench.time.user_time
>> >  1.363e+08           +17.1%  1.596e+08           +17.4%    1.6e+08
>> >  unixbench.time.voluntary_context_switches
>> >   92695042           -11.7%   81832215           -11.5%   82058309
>> >  unixbench.workload
>> >     527070            +4.4%     550213            +4.3%     549858
>> >  proc-vmstat.nr_active_anon
>> >    1256160            +1.8%    1278405            +1.8%    1278495
>> >  proc-vmstat.nr_file_pages
>> >     550582            +4.0%     572876            +4.1%     572938
>> >  proc-vmstat.nr_shmem
>> >      46408            -0.5%      46196            -0.9%      45996
>> >  proc-vmstat.nr_slab_unreclaimable
>> >     527070            +4.4%     550213            +4.3%     549858
>> >  proc-vmstat.nr_zone_active_anon
>> >  9.646e+08           -11.6%   8.53e+08           -11.4%  8.549e+08
>> >  proc-vmstat.numa_hit
>> >  9.646e+08           -11.6%   8.53e+08           -11.4%  8.549e+08
>> >  proc-vmstat.numa_local
>> >    1601249            -5.9%    1506672            -5.5%    1512940
>> >  proc-vmstat.pgactivate
>> >  1.019e+09           -11.6%  9.011e+08           -11.4%  9.032e+08
>> >  proc-vmstat.pgalloc_normal
>> >  1.408e+09           -11.8%  1.242e+09           -11.6%  1.245e+09
>> >  proc-vmstat.pgfault
>> >  1.018e+09           -11.6%  9.003e+08           -11.4%  9.024e+08
>> >  proc-vmstat.pgfree
>> >   55555614           -11.7%   49072849           -11.5%   49184460
>> >  proc-vmstat.pgreuse
>> >      48551           -11.9%      42791           -11.4%      43034
>> >  proc-vmstat.thp_fault_alloc
>> >   20497893           -11.6%   18112553           -11.4%   18152407
>> >  proc-vmstat.unevictable_pgs_culled
>> >       2.87            +5.2%       3.01            +5.2%       3.02
>> >  perf-stat.i.MPKI
>> >  1.718e+10           -10.0%  1.546e+10            -9.9%  1.547e+10
>> >  perf-stat.i.branch-instructions
>> >       1.79            +0.0        1.83            +0.0        1.83
>> >  perf-stat.i.branch-miss-rate%
>> >  3.109e+08            -8.0%  2.861e+08            -7.8%  2.866e+08
>> >  perf-stat.i.branch-misses
>> >  2.511e+08            -5.7%  2.368e+08            -5.5%  2.371e+08
>> >  perf-stat.i.cache-misses
>> >  1.161e+09            -5.3%    1.1e+09            -5.0%  1.104e+09
>> >  perf-stat.i.cache-references
>> >     452916           +14.1%     516643           +14.4%     518004
>> >  perf-stat.i.context-switches
>> >       1.77            +7.6%       1.90            +7.3%       1.90
>> >  perf-stat.i.cpi
>> >  1.474e+11            -3.2%  1.426e+11            -3.3%  1.425e+11
>> >  perf-stat.i.cpu-cycles
>> >     120955            +3.6%     125322            +3.9%     125612
>> >  perf-stat.i.cpu-migrations
>> >   16833193 =C2=B1  2%      -9.5%   15240763 =C2=B1  3%  +3.1e+05%  5.1=
65e+10 =C2=B1264%
>> >  perf-stat.i.dTLB-load-misses
>> >  2.127e+10           -10.1%  1.913e+10           -10.0%  1.914e+10
>> >  perf-stat.i.dTLB-loads
>> >       0.12            -0.0        0.12            -0.0        0.12
>> >  perf-stat.i.dTLB-store-miss-rate%
>> >   14062688           -10.9%   12533168           -10.8%   12542779
>> >  perf-stat.i.dTLB-store-misses
>> >   1.15e+10            -9.1%  1.046e+10            -8.8%  1.048e+10
>> >  perf-stat.i.dTLB-stores
>> >   8.52e+10           -10.3%   7.64e+10           -10.2%  7.647e+10
>> >  perf-stat.i.instructions
>> >       0.57            -7.1%       0.53            -7.0%       0.53
>> >  perf-stat.i.ipc
>> >       1482 =C2=B1  5%     -19.4%       1194 =C2=B1  3%     -18.5%     =
  1208 =C2=B1  2%
>> >  perf-stat.i.major-faults
>> >       2.30            -3.2%       2.23            -3.3%       2.23
>> >  perf-stat.i.metric.GHz
>> >       2425            -7.2%       2251            -7.0%       2254
>> >  perf-stat.i.metric.K/sec
>> >     798.58            -9.7%     720.87            -9.6%     721.89
>> >  perf-stat.i.metric.M/sec
>> >    2186637           -11.7%    1930410           -11.5%    1934606
>> >  perf-stat.i.minor-faults
>> >   54365401            -5.6%   51335291            -5.5%   51353913
>> >  perf-stat.i.node-load-misses
>> >    6937761 =C2=B1  2%      -9.7%    6266518            -9.0%    631104=
4
>> >  perf-stat.i.node-loads
>> >      37.45            +1.1       38.52            +1.0       38.47
>> >  perf-stat.i.node-store-miss-rate%
>> >   27467487            -4.3%   26282510            -4.3%   26286981
>> >  perf-stat.i.node-store-misses
>> >   45755244            -9.3%   41489294            -9.1%   41590963
>> >  perf-stat.i.node-stores
>> >    2188120           -11.7%    1931605           -11.5%    1935815
>> >  perf-stat.i.page-faults
>> >       2.95            +5.2%       3.10            +5.2%       3.10
>> >  perf-stat.overall.MPKI
>> >       1.81            +0.0        1.85            +0.0        1.85
>> >  perf-stat.overall.branch-miss-rate%
>> >       1.73            +7.9%       1.87            +7.7%       1.86
>> >  perf-stat.overall.cpi
>> >       0.12            -0.0        0.12            -0.0        0.12
>> >  perf-stat.overall.dTLB-store-miss-rate%
>> >       0.58            -7.3%       0.54            -7.2%       0.54
>> >  perf-stat.overall.ipc
>> >      37.50            +1.3       38.77            +1.2       38.71
>> >  perf-stat.overall.node-store-miss-rate%
>> >     580179            +1.5%     589066            +1.4%     588133
>> >  perf-stat.overall.path-length
>> >  1.716e+10           -10.0%  1.544e+10            -9.9%  1.546e+10
>> >  perf-stat.ps.branch-instructions
>> >  3.106e+08            -8.0%  2.858e+08            -7.8%  2.863e+08
>> >  perf-stat.ps.branch-misses
>> >  2.507e+08            -5.7%  2.365e+08            -5.5%  2.368e+08
>> >  perf-stat.ps.cache-misses
>> >   1.16e+09            -5.3%  1.099e+09            -4.9%  1.103e+09
>> >  perf-stat.ps.cache-references
>> >     452344           +14.1%     515907           +14.4%     517289
>> >  perf-stat.ps.context-switches
>> >  1.472e+11            -3.2%  1.424e+11            -3.3%  1.424e+11
>> >  perf-stat.ps.cpu-cycles
>> >     120816            +3.6%     125163            +3.8%     125459
>> >  perf-stat.ps.cpu-migrations
>> >   16842486 =C2=B1  2%      -9.5%   15246149 =C2=B1  3%    +3e+05%  5.1=
19e+10 =C2=B1264%
>> >  perf-stat.ps.dTLB-load-misses
>> >  2.125e+10           -10.1%  1.911e+10           -10.0%  1.913e+10
>> >  perf-stat.ps.dTLB-loads
>> >   14047507           -10.9%   12518508           -10.8%   12528435
>> >  perf-stat.ps.dTLB-store-misses
>> >  1.149e+10            -9.1%  1.045e+10            -8.8%  1.047e+10
>> >  perf-stat.ps.dTLB-stores
>> >  8.512e+10           -10.3%  7.632e+10           -10.2%   7.64e+10
>> >  perf-stat.ps.instructions
>> >       1482 =C2=B1  5%     -19.4%       1193 =C2=B1  3%     -18.5%     =
  1208 =C2=B1  2%
>> >  perf-stat.ps.major-faults
>> >    2184052           -11.7%    1927941           -11.5%    1932219
>> >  perf-stat.ps.minor-faults
>> >   54273292            -5.6%   51245500            -5.5%   51266857
>> >  perf-stat.ps.node-load-misses
>> >    6947010 =C2=B1  2%      -9.7%    6272166            -9.1%    631754=
2
>> >  perf-stat.ps.node-loads
>> >   27420207            -4.3%   26235835            -4.3%   26241313
>> >  perf-stat.ps.node-store-misses
>> >   45702958            -9.3%   41437373            -9.1%   41541645
>> >  perf-stat.ps.node-stores
>> >    2185534           -11.7%    1929134           -11.5%    1933427
>> >  perf-stat.ps.page-faults
>> >  5.377e+13           -10.4%   4.82e+13           -10.3%  4.826e+13
>> >  perf-stat.total.instructions
>> >       0.01 =C2=B1  8%     -30.0%       0.01 =C2=B1 17%      +5.0%     =
  0.01 =C2=B1 73%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.__lookup_slow
>> >       0.01 =C2=B1 12%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.lookup_open
>> >       0.02 =C2=B1 16%     -37.3%       0.01 =C2=B1 26%     -37.3%     =
  0.01 =C2=B1 19%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kma=
lloc_trace.perf_event_mmap_event.perf_event_mmap
>> >       0.03 =C2=B1 28%     -43.9%       0.02 =C2=B1 33%     -10.7%     =
  0.03 =C2=B1 36%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.copy_pte_range.copy_p4d_ran=
ge.copy_page_range.dup_mmap
>> >       0.01 =C2=B1 19%     -24.8%       0.01 =C2=B1  6%     -29.1%     =
  0.01 =C2=B1  7%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.li=
nk_path_walk.part
>> >       0.03 =C2=B1 69%     -65.3%       0.01 =C2=B1 42%     -32.0%     =
  0.02 =C2=B1 78%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.a=
non_vma_fork.dup_mmap
>> >       0.03 =C2=B1 11%     -37.8%       0.02 =C2=B1 21%     -29.4%     =
  0.02 =C2=B1 22%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.ex=
it_mmap.__mmput
>> >       0.00 =C2=B1 74%    +100.5%       0.01 =C2=B1 41%   +1165.1%     =
  0.04 =C2=B1248%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.down_write.generic_file_wri=
te_iter.vfs_write.ksys_write
>> >       0.02 =C2=B1 17%     -34.4%       0.02 =C2=B1 31%     -27.3%     =
  0.02 =C2=B1 59%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma.=
free_pgtables.exit_mmap
>> >       0.01 =C2=B1  9%     +23.4%       0.01 =C2=B1  6%     +26.6%     =
  0.01 =C2=B1 10%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.dput.d_alloc_parallel.__loo=
kup_slow.walk_component
>> >       0.02 =C2=B1 21%     -36.9%       0.01 =C2=B1 11%     -39.4%     =
  0.01 =C2=B1 11%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_wa=
lk.part
>> >       0.02 =C2=B1  8%     -25.7%       0.01 =C2=B1  7%     -22.4%     =
  0.01 =C2=B1 15%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_op=
enat.do_filp_open
>> >       0.03 =C2=B1 31%     -12.9%       0.03 =C2=B1 82%     -44.0%     =
  0.02 =C2=B1 10%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.d=
o_exit
>> >       0.03 =C2=B1 37%     -72.7%       0.01 =C2=B1 50%     -76.8%     =
  0.01 =C2=B1 64%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_=
nodes.mas_preallocate.__split_vma
>> >       0.03 =C2=B1  8%     -32.8%       0.02 =C2=B1 24%      -2.8%     =
  0.03 =C2=B1 33%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_du=
p.__split_vma.do_vmi_align_munmap
>> >       0.03 =C2=B1 58%     -57.9%       0.01 =C2=B1 24%     -46.6%     =
  0.02 =C2=B1 48%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_f=
inish_mmu.exit_mmap.__mmput
>> >       0.02 =C2=B1 11%     -35.1%       0.01 =C2=B1 11%     -36.3%     =
  0.01 =C2=B1 19%
>> >
>> > perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_=
page_range
>> >       0.02 =C2=B1 31%     -41.9%       0.01 =C2=B1 36%     -51.2%     =
  0.01 =C2=B1 23%
>> >
>> > perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.link_path_walk.part
>> >       0.02 =C2=B1 12%     -29.7%       0.01 =C2=B1  9%     -25.4%     =
  0.01 =C2=B1 17%
>> >
>> > perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.irqentry_exit_to_user_mode.asm_exc_page_fault
>> >       0.02 =C2=B1 39%     -43.4%       0.01 =C2=B1  4%     -44.4%     =
  0.01 =C2=B1  8%
>> >
>> > perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>> >       0.02 =C2=B1 17%     -32.8%       0.01 =C2=B1  9%     -15.3%     =
  0.02 =C2=B1 38%
>> >
>> > perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.syscall_exit_to_user_mode.do_syscall_64
>> >       0.02 =C2=B1 13%     -27.5%       0.01 =C2=B1  9%     -27.5%     =
  0.01 =C2=B1  9%
>> >
>> > perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_=
fault.__do_fault
>> >       0.02 =C2=B1  4%     -29.0%       0.01 =C2=B1  2%     -32.7%     =
  0.01 =C2=B1  3%
>> >  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_6=
4
>> >       0.02 =C2=B1  5%     -34.1%       0.01 =C2=B1  5%     -34.1%     =
  0.01 =C2=B1  6%
>> >
>> > perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_=
slowpath.down_read.open_last_lookups
>> >       0.02 =C2=B1  2%     -12.5%       0.01 =C2=B1  3%     -12.5%     =
  0.01 =C2=B1  3%
>> >
>> > perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_=
slowpath.down_read.walk_component
>> >       0.01 =C2=B1  5%     -27.9%       0.01 =C2=B1  9%     -24.9%     =
  0.01 =C2=B1  3%
>> >
>> > perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.do_unlinkat
>> >       0.01 =C2=B1  2%     -22.8%       0.01 =C2=B1  5%     -23.8%     =
  0.01 =C2=B1  4%
>> >
>> > perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.open_last_lookups
>> >       0.01 =C2=B1  9%     -20.6%       0.01 =C2=B1 12%      -4.4%     =
  0.01 =C2=B1 13%
>> >
>> > perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.vma_prepare
>> >       0.02 =C2=B1  8%     -11.4%       0.02 =C2=B1 15%     -14.6%     =
  0.02 =C2=B1  8%
>> >
>> > perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_fo=
r_completion_state.kernel_clone
>> >       0.02 =C2=B1  7%     -38.9%       0.01 =C2=B1  6%     -35.7%     =
  0.01 =C2=B1  8%
>> >
>> > perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
>> >       0.03 =C2=B1  2%      -8.8%       0.02 =C2=B1  3%      -9.7%     =
  0.02 =C2=B1  3%
>> >
>> > perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.re=
t_from_fork_asm
>> >       0.04 =C2=B1  2%     +47.0%       0.06 =C2=B1 63%      -7.9%     =
  0.04 =C2=B1  3%
>> >
>> > perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_fr=
om_fork_asm
>> >       0.28 =C2=B1 41%     -97.4%       0.01 =C2=B1 16%     -91.6%     =
  0.02 =C2=B1184%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.__lookup_slow
>> >       0.01 =C2=B1 28%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.lookup_open
>> >       0.85 =C2=B1 72%     -91.0%       0.08 =C2=B1128%     -71.9%     =
  0.24 =C2=B1 67%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.step_int=
o.link_path_walk
>> >       0.06 =C2=B1 70%     -22.1%       0.04 =C2=B1226%     -90.4%     =
  0.01 =C2=B1 49%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.step_int=
o.open_last_lookups
>> >       0.40 =C2=B1104%     -80.7%       0.08 =C2=B1 96%     -45.3%     =
  0.22 =C2=B1120%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.a=
non_vma_fork.dup_mmap
>> >       0.00 =C2=B1 76%    +103.0%       0.01 =C2=B1 43%   +2248.5%     =
  0.08 =C2=B1256%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.down_write.generic_file_wri=
te_iter.vfs_write.ksys_write
>> >       0.02 =C2=B1108%     -17.6%       0.02 =C2=B1 99%     -65.3%     =
  0.01 =C2=B1 36%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.down_write.vfs_unlink.do_un=
linkat.__x64_sys_unlinkat
>> >       0.00 =C2=B1117%   +2079.5%       0.03 =C2=B1218%    +297.7%     =
  0.01 =C2=B1103%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link.insert_=
vm_struct.__install_special_mapping
>> >       1.41 =C2=B1 14%     -34.6%       0.92 =C2=B1 15%     -22.4%     =
  1.10 =C2=B1 26%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_wa=
lk.part
>> >       0.11 =C2=B1 89%     +59.8%       0.17 =C2=B1173%     -83.2%     =
  0.02 =C2=B1146%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma=
_prepare.do_anonymous_page.__handle_mm_fault
>> >       1.07 =C2=B1 23%     -53.0%       0.50 =C2=B1 55%      -7.2%     =
  0.99 =C2=B1 62%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empt=
y_file.path_openat.do_filp_open
>> >       0.64 =C2=B1 40%     -83.3%       0.11 =C2=B1101%     -85.1%     =
  0.10 =C2=B1131%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_=
nodes.mas_preallocate.__split_vma
>> >       0.25 =C2=B1 41%    +153.8%       0.63 =C2=B1178%     -51.8%     =
  0.12 =C2=B1 69%
>> >
>> > perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.=
evict.do_unlinkat.__x64_sys_unlinkat
>> >       1.72 =C2=B1 16%     -33.5%       1.15 =C2=B1 16%     +23.6%     =
  2.13 =C2=B1118%
>> >
>> > perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.irqentry_exit_to_user_mode.asm_exc_page_fault
>> >       3.37 =C2=B1 13%  +15157.3%     514.78 =C2=B1171%      +6.5%     =
  3.59 =C2=B1 12%
>> >
>> > perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_fr=
om_fork_asm
>> >       0.02 =C2=B1  2%     -15.1%       0.02 =C2=B1  5%     -14.4%     =
  0.02 =C2=B1  2%
>> >  perf-sched.total_sch_delay.average.ms
>> >       1.56            -9.2%       1.42            -9.1%       1.42
>> >  perf-sched.total_wait_and_delay.average.ms
>> >    1392371           +12.2%    1561782           +12.1%    1560293
>> >  perf-sched.total_wait_and_delay.count.ms
>> >       1.54            -9.2%       1.40            -9.0%       1.40
>> >  perf-sched.total_wait_time.average.ms
>> >      20.11 =C2=B1 16%     -23.3%      15.43 =C2=B1 20%     -26.1%     =
 14.86 =C2=B1 16%
>> >
>> > perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.=
shmem_file_write_iter.vfs_write.ksys_write
>> >       2.95 =C2=B1 36%     +65.2%       4.87 =C2=B1 33%    +109.2%     =
  6.17 =C2=B1 29%
>> >
>> > perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_=
release.exit_mm_release.exit_mm
>> >       2.76 =C2=B1 11%     +15.1%       3.18 =C2=B1 11%     +21.4%     =
  3.35 =C2=B1  6%
>> >
>> > perf-sched.wait_and_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.=
tlb_finish_mmu.exit_mmap.__mmput
>> >       3.55           +15.2%       4.09           +15.5%       4.10
>> >
>> > perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__=
x64_sys_exit_group.do_syscall_64
>> >       6.51           +11.3%       7.25           +11.3%       7.25
>> >
>> > perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.d=
o_syscall_64
>> >       1.93 =C2=B1  2%     +18.9%       2.29           +20.0%       2.3=
1
>> >
>> > perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_sysca=
ll_64
>> >      26.10 =C2=B1  2%     -11.4%      23.12            -9.7%      23.5=
7 =C2=B1  2%
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_pol=
l.constprop.0.do_sys_poll
>> >       0.27           -14.2%       0.23           -14.0%       0.23
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_=
read_slowpath.down_read.open_last_lookups
>> >       0.25           -10.4%       0.22           -10.3%       0.22
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_=
read_slowpath.down_read.walk_component
>> >       0.24           -15.8%       0.20           -15.9%       0.20
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_=
write_slowpath.down_write.do_unlinkat
>> >       0.17           -16.4%       0.14           -16.5%       0.14
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_=
write_slowpath.down_write.open_last_lookups
>> >       0.32 =C2=B1 10%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_=
write_slowpath.down_write.unlink_file_vma
>> >       0.12 =C2=B1  3%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_=
write_slowpath.down_write.vma_prepare
>> >       0.25 =C2=B1  4%     -12.1%       0.22 =C2=B1  5%     -13.0%     =
  0.21
>> >
>> > perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do=
_syscall_64.entry_SYSCALL_64_after_hwframe
>> >      99.29 =C2=B1 10%     -26.0%      73.50 =C2=B1  8%     -23.3%     =
 76.12 =C2=B1 13%
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mma=
p.dup_mm.constprop
>> >     147.43 =C2=B1  7%     -27.4%     107.00 =C2=B1  9%     -25.8%     =
109.38 =C2=B1  9%
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup=
_mm.constprop
>> >     690.86 =C2=B1  3%     -28.6%     493.25 =C2=B1  6%     -32.2%     =
468.62 =C2=B1  3%
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtable=
s.exit_mmap.__mmput
>> >      50.29 =C2=B1  8%     +28.8%      64.75 =C2=B1  8%     +16.3%     =
 58.50 =C2=B1 13%
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.s=
hmem_file_write_iter.vfs_write.ksys_write
>> >      55.57 =C2=B1  9%     -19.7%      44.62 =C2=B1 14%     -19.0%     =
 45.00 =C2=B1  8%
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.prepar=
e_creds.copy_creds.copy_process
>> >       4208 =C2=B1  2%     -20.5%       3345 =C2=B1  3%     -19.4%     =
  3390 =C2=B1  3%
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthre=
ad.ret_from_fork.ret_from_fork_asm
>> >      44149           -11.3%      39141           -11.4%      39108
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec=
.bprm_execve.part
>> >     823.57 =C2=B1  4%     -11.9%     725.62 =C2=B1  4%     -12.1%     =
723.88
>> >
>> > perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.un=
map_page_range
>> >      75322            -9.0%      68542            -9.0%      68557
>> >
>> > perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do=
_syscall_64
>> >      39574           -17.8%      32535           -18.2%      32370
>> >
>> > perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscal=
l_64
>> >     531.86 =C2=B1  2%     +12.4%     597.62           +11.5%     593.0=
0 =C2=B1  2%
>> >
>> > perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll=
.constprop.0.do_sys_poll
>> >     778858 =C2=B1  2%     +29.9%    1011786           +29.9%    101170=
6
>> >
>> > perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_r=
ead_slowpath.down_read.walk_component
>> >      12514 =C2=B1 15%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_w=
rite_slowpath.down_write.unlink_file_vma
>> >      14945 =C2=B1 16%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_w=
rite_slowpath.down_write.vma_prepare
>> >      20.51 =C2=B1 64%     +30.8%      26.82 =C2=B1 38%     +62.2%     =
 33.27 =C2=B1  6%
>> >
>> > perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.unlink_anon=
_vmas.free_pgtables.exit_mmap
>> >      26.08 =C2=B1 25%     +24.1%      32.37 =C2=B1  6%     +14.4%     =
 29.84 =C2=B1 10%
>> >
>> > perf-sched.wait_and_delay.max.ms.__cond_resched.task_work_run.do_exit.=
do_group_exit.__x64_sys_exit_group
>> >      33.65 =C2=B1  2%     +11.4%      37.47 =C2=B1  4%    +366.8%     =
157.09 =C2=B1202%
>> >
>> > perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.u=
nmap_page_range
>> >      12.61 =C2=B1 15%     +27.9%      16.13 =C2=B1  9%     +20.8%     =
 15.23 =C2=B1 18%
>> >
>> > perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_=
read_slowpath.down_read.walk_component
>> >      33.56 =C2=B1  3%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_=
write_slowpath.down_write.unlink_file_vma
>> >       3.90 =C2=B1 13%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_=
write_slowpath.down_write.vma_prepare
>> >      30.80 =C2=B1  6%     +12.5%      34.64 =C2=B1  4%     +13.4%     =
 34.91 =C2=B1  3%
>> >
>> > perf-sched.wait_and_delay.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do=
_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       0.21 =C2=B1  3%      -7.0%       0.20 =C2=B1 13%     -14.9%     =
  0.18 =C2=B1  4%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.__lookup_slow
>> >       0.22 =C2=B1 10%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.lookup_open
>> >       0.20 =C2=B1  4%     -16.4%       0.16 =C2=B1  4%     -17.6%     =
  0.16 =C2=B1  4%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kma=
lloc_trace.perf_event_mmap_event.perf_event_mmap
>> >       0.31 =C2=B1 40%     -28.2%       0.22 =C2=B1 35%     -36.9%     =
  0.19 =C2=B1  9%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.apparmor_file_alloc_securit=
y.security_file_alloc.init_file.alloc_empty_file
>> >       0.21 =C2=B1  4%     -10.4%       0.19 =C2=B1  3%     -11.2%     =
  0.19 =C2=B1  3%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.down_read.open_last_lookups=
.path_openat.do_filp_open
>> >       0.22 =C2=B1  2%     -13.4%       0.19           -14.0%       0.1=
9
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.li=
nk_path_walk.part
>> >       0.25 =C2=B1  9%     -15.3%       0.21 =C2=B1 18%     -22.2%     =
  0.19 =C2=B1  6%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone._=
_split_vma.vma_modify
>> >       0.23 =C2=B1  6%     -15.4%       0.19 =C2=B1  4%     -15.0%     =
  0.19 =C2=B1  6%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__sp=
lit_vma.vma_modify
>> >       0.22 =C2=B1 12%     -18.3%       0.18 =C2=B1  8%     -15.3%     =
  0.19 =C2=B1  4%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.d_alloc_parallel.looku=
p_open.isra
>> >       0.27 =C2=B1  2%     -26.5%       0.20 =C2=B1  6%     -26.3%     =
  0.20 =C2=B1  4%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path=
_openat.do_filp_open
>> >       0.23 =C2=B1  2%     -15.3%       0.20           -15.2%       0.2=
0
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_wa=
lk.part
>> >       0.23 =C2=B1 10%     -15.7%       0.19 =C2=B1  3%     -17.3%     =
  0.19 =C2=B1  2%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lo=
okups.path_openat
>> >       0.21 =C2=B1  2%     -12.1%       0.19           -12.2%       0.1=
9
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_op=
enat.do_filp_open
>> >      20.11 =C2=B1 16%     -23.3%      15.43 =C2=B1 20%     -26.1%     =
 14.86 =C2=B1 16%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem=
_file_write_iter.vfs_write.ksys_write
>> >       0.21 =C2=B1  4%     -12.0%       0.18 =C2=B1  4%      -8.1%     =
  0.19 =C2=B1  5%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empt=
y_file.path_openat.do_filp_open
>> >       0.23 =C2=B1  9%     -26.2%       0.17 =C2=B1  7%     -28.8%     =
  0.16 =C2=B1  8%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_=
nodes.mas_preallocate.__split_vma
>> >       0.19 =C2=B1 14%     -24.7%       0.14 =C2=B1 20%      -3.6%     =
  0.19 =C2=B1 34%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_=
nodes.mas_preallocate.vma_expand
>> >       0.19 =C2=B1  3%     -17.3%       0.16 =C2=B1  7%     -15.9%     =
  0.16 =C2=B1  6%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_al=
loc.mmap_region.do_mmap
>> >       0.23 =C2=B1  2%     -13.7%       0.20 =C2=B1  4%     -10.2%     =
  0.21 =C2=B1  8%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_du=
p.__split_vma.do_vmi_align_munmap
>> >       2.91 =C2=B1 35%     +67.1%       4.86 =C2=B1 33%    +111.9%     =
  6.16 =C2=B1 30%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exit_relea=
se.exit_mm_release.exit_mm
>> >       0.23           -11.3%       0.21 =C2=B1  3%     -13.5%       0.2=
0 =C2=B1  3%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.do_vmi_align_mun=
map.do_vmi_munmap.mmap_region
>> >       2.72 =C2=B1 11%     +16.0%       3.16 =C2=B1 11%     +22.3%     =
  3.33 =C2=B1  6%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_f=
inish_mmu.exit_mmap.__mmput
>> >       0.26 =C2=B1  3%     -22.9%       0.20 =C2=B1  4%     -22.2%     =
  0.20 =C2=B1  6%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.=
evict.do_unlinkat.__x64_sys_unlinkat
>> >       0.21 =C2=B1  2%     -18.5%       0.17           -17.1%       0.1=
7 =C2=B1  3%
>> >
>> > perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.con=
stprop.0
>> >       0.26 =C2=B1 10%     -19.9%       0.21 =C2=B1  3%     -19.9%     =
  0.21 =C2=B1  2%
>> >
>> > perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.link_path_walk.part
>> >       3.51           +15.4%       4.06           +15.7%       4.07
>> >
>> > perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_s=
ys_exit_group.do_syscall_64
>> >       6.48           +11.4%       7.22           +11.4%       7.22
>> >
>> > perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_sys=
call_64
>> >       0.14 =C2=B1  3%     -16.9%       0.12 =C2=B1  2%     -17.4%     =
  0.12 =C2=B1  2%
>> >
>> > perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_=
fault.__do_fault
>> >       1.91 =C2=B1  2%     +19.3%       2.28           +20.4%       2.3=
0
>> >  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_6=
4
>> >      26.10 =C2=B1  2%     -11.4%      23.12            -9.7%      23.5=
7 =C2=B1  2%
>> >
>> > perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.con=
stprop.0.do_sys_poll
>> >       0.24           -12.4%       0.21           -12.2%       0.21
>> >
>> > perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_=
slowpath.down_read.open_last_lookups
>> >       0.23           -10.3%       0.21           -10.2%       0.21
>> >
>> > perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_=
slowpath.down_read.walk_component
>> >       0.23           -15.2%       0.20           -15.4%       0.19
>> >
>> > perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.do_unlinkat
>> >       0.12 =C2=B1 10%     -30.3%       0.08 =C2=B1 18%     -26.5%     =
  0.09 =C2=B1 14%
>> >
>> > perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.mmap_region
>> >       0.15           -15.8%       0.13           -16.1%       0.13
>> >
>> > perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.open_last_lookups
>> >       0.11 =C2=B1  3%     -27.8%       0.08 =C2=B1 11%     -25.0%     =
  0.08 =C2=B1  7%
>> >
>> > perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.vma_prepare
>> >       0.23 =C2=B1  3%      -9.8%       0.20 =C2=B1  5%     -11.0%     =
  0.20 =C2=B1  2%
>> >
>> > perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
>> >       0.78 =C2=B1 17%     -59.4%       0.32 =C2=B1 21%     -61.3%     =
  0.30 =C2=B1 26%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.__lookup_slow
>> >       0.33 =C2=B1 24%    -100.0%       0.00          -100.0%       0.0=
0
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.d_alloc_=
parallel.lookup_open
>> >       1.17 =C2=B1 51%     -61.8%       0.45 =C2=B1 37%     -55.8%     =
  0.52 =C2=B1 27%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_int=
o.link_path_walk
>> >       0.56 =C2=B1 32%     -56.1%       0.24 =C2=B1 47%     -42.3%     =
  0.32 =C2=B1 83%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.down_write.__anon_vma_prepa=
re.do_anonymous_page.__handle_mm_fault
>> >       1.32 =C2=B1 24%     -32.4%       0.89 =C2=B1 46%     -41.7%     =
  0.77 =C2=B1 33%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_m=
map.vm_mmap_pgoff
>> >      24.90 =C2=B1 31%     +12.1%      27.92 =C2=B1 26%     +33.6%     =
 33.26 =C2=B1  6%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas=
.free_pgtables.exit_mmap
>> >       0.98 =C2=B1 14%     -22.6%       0.76 =C2=B1  8%      -4.0%     =
  0.95 =C2=B1 38%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.d_alloc_parallel.__loo=
kup_slow.walk_component
>> >       1.71 =C2=B1 14%     -29.7%       1.20 =C2=B1 11%      -4.5%     =
  1.63 =C2=B1 28%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_wa=
lk.part
>> >       0.51 =C2=B1 14%     -26.4%       0.37 =C2=B1 10%     +11.2%     =
  0.56 =C2=B1 28%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.=
search_binary_handler.exec_binprm
>> >       1.35 =C2=B1 16%     -39.0%       0.82 =C2=B1 28%      -7.1%     =
  1.25 =C2=B1 47%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empt=
y_file.path_openat.do_filp_open
>> >       1.00 =C2=B1 26%     -52.4%       0.48 =C2=B1 29%     -55.3%     =
  0.45 =C2=B1 41%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_=
nodes.mas_preallocate.__split_vma
>> >       0.51 =C2=B1 42%     -49.6%       0.26 =C2=B1 32%      -1.5%     =
  0.50 =C2=B1 56%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_al=
loc.do_brk_flags.__do_sys_brk
>> >      26.07 =C2=B1 25%     +24.1%      32.36 =C2=B1  6%     +14.5%     =
 29.84 =C2=B1 10%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.task_work_run.do_exit.do_gr=
oup_exit.__x64_sys_exit_group
>> >      33.64 =C2=B1  2%     +11.3%      37.45 =C2=B1  4%    +366.9%     =
157.07 =C2=B1202%
>> >
>> > perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_=
page_range
>> >       1.42 =C2=B1 34%      -8.4%       1.31 =C2=B1 53%     -41.2%     =
  0.84 =C2=B1 15%
>> >
>> > perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_compon=
ent.link_path_walk.part
>> >       7.04 =C2=B1  9%     +21.3%       8.53 =C2=B1  8%     +18.3%     =
  8.32 =C2=B1 19%
>> >
>> > perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_=
slowpath.down_read.walk_component
>> >       3.77 =C2=B1 14%     -23.4%       2.89 =C2=B1 33%     -32.2%     =
  2.56 =C2=B1 17%
>> >
>> > perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.mmap_region
>> >       3.88 =C2=B1 14%     -28.2%       2.78 =C2=B1 30%     -34.8%     =
  2.53 =C2=B1 11%
>> >
>> > perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write=
_slowpath.down_write.vma_prepare
>> >      30.79 =C2=B1  6%     +12.2%      34.55 =C2=B1  4%     +13.4%     =
 34.91 =C2=B1  3%
>> >
>> > perf-sched.wait_time.max.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
>> >      15.12 =C2=B1  5%      -6.2        8.93 =C2=B1  4%      -6.4      =
  8.76
>> >
>> > perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff=
.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >      14.87 =C2=B1  5%      -6.2        8.70 =C2=B1  5%      -6.3      =
  8.53
>> >
>> > perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksy=
s_mmap_pgoff.do_syscall_64
>> >      13.58 =C2=B1  6%      -6.0        7.56 =C2=B1  5%      -6.2      =
  7.39 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
>> >      13.60 =C2=B1  6%      -6.0        7.58 =C2=B1  5%      -6.2      =
  7.41 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
>> >       9.82 =C2=B1  6%      -4.8        5.00 =C2=B1 10%      -5.1      =
  4.75 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mma=
p_region.do_mmap.vm_mmap_pgoff
>> >       6.57 =C2=B1  8%      -4.3        2.26 =C2=B1  7%      -4.4      =
  2.16 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_=
down_write_slowpath.down_write.unlink_file_vma
>> >       7.22 =C2=B1  7%      -4.3        2.92 =C2=B1 13%      -4.7      =
  2.56 =C2=B1  8%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_writ=
e_slowpath.down_write.unlink_file_vma.free_pgtables
>> >       8.92 =C2=B1  6%      -4.0        4.88 =C2=B1  6%      -4.2      =
  4.77 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_=
mmap_pgoff.ksys_mmap_pgoff
>> >       5.68 =C2=B1  8%      -3.7        1.94 =C2=B1  8%      -3.8      =
  1.89 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_=
down_write_slowpath.down_write.vma_prepare
>> >       5.24 =C2=B1  8%      -3.0        2.19 =C2=B1  8%      -3.1      =
  2.13 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_writ=
e_slowpath.down_write.vma_prepare.__split_vma
>> >       5.66 =C2=B1  6%      -2.5        3.14 =C2=B1  6%      -2.6      =
  3.07 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vm=
i_munmap.mmap_region.do_mmap
>> >       5.03 =C2=B1  7%      -2.4        2.61 =C2=B1  7%      -2.5      =
  2.54 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_=
munmap.do_vmi_munmap.mmap_region
>> >       4.63 =C2=B1  8%      -2.4        2.25 =C2=B1  8%      -2.4      =
  2.19 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do=
_vmi_align_munmap.do_vmi_munmap
>> >       4.59 =C2=B1  8%      -2.4        2.22 =C2=B1  8%      -2.4      =
  2.16 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.=
vma_prepare.__split_vma.do_vmi_align_munmap
>> >       3.99 =C2=B1  7%      -2.3        1.68 =C2=B1 17%      -2.4      =
  1.57 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_v=
mi_munmap.mmap_region.do_mmap
>> >       3.70 =C2=B1  7%      -2.3        1.43 =C2=B1  7%      -2.3      =
  1.38 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_r=
egion.do_vmi_align_munmap.do_vmi_munmap
>> >       3.77 =C2=B1  7%      -2.3        1.52 =C2=B1 18%      -2.4      =
  1.42 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_ali=
gn_munmap.do_vmi_munmap.mmap_region
>> >       3.64 =C2=B1  7%      -2.2        1.39 =C2=B1  8%      -2.3      =
  1.35 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtab=
les.unmap_region.do_vmi_align_munmap
>> >       3.60 =C2=B1  7%      -2.2        1.37 =C2=B1  8%      -2.3      =
  1.33 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.=
unlink_file_vma.free_pgtables.unmap_region
>> >       9.68            -2.1        7.58            -2.1        7.54
>> >
>> > perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_=
group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       9.68            -2.1        7.58            -2.1        7.54
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.en=
try_SYSCALL_64_after_hwframe
>> >       9.68            -2.1        7.58            -2.1        7.54
>> >
>> > perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do=
_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       8.14            -2.0        6.15            -2.1        6.07
>> >
>> > perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_s=
ys_exit_group.do_syscall_64
>> >       8.13            -2.0        6.14            -2.1        6.07
>> >
>> > perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit=
.__x64_sys_exit_group
>> >       8.11            -2.0        6.12            -2.1        6.05
>> >
>> > perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_=
group_exit
>> >       3.71 =C2=B1  8%      -2.0        1.73 =C2=B1 12%      -2.4      =
  1.34 =C2=B1 19%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.=
unlink_file_vma.free_pgtables.exit_mmap
>> >       3.84 =C2=B1  7%      -1.9        1.89 =C2=B1  5%      -2.2      =
  1.68 =C2=B1 15%
>> >
>> > perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtab=
les.exit_mmap.__mmput
>> >       8.05 =C2=B1  3%      -1.7        6.30            -1.7        6.3=
1 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.w=
alk_component.link_path_walk
>> >       8.73            -1.7        7.02            -1.7        6.99
>> >
>> > perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_=
sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       8.13            -1.6        6.50            -1.7        6.46
>> >
>> > perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_c=
ommon.__x64_sys_execve.do_syscall_64
>> >       8.12            -1.6        6.49            -1.7        6.45
>> >
>> > perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bpr=
m_execve.do_execveat_common.__x64_sys_execve
>> >       8.02            -1.6        6.40            -1.7        6.37
>> >
>> > perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler=
.exec_binprm.bprm_execve.do_execveat_common
>> >       9.11            -1.6        7.50            -1.6        7.46
>> >  perf-profile.calltrace.cycles-pp.execve
>> >       9.10            -1.6        7.49            -1.6        7.46
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.execve
>> >       9.09            -1.6        7.48            -1.6        7.45
>> >
>> > perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>> >       9.10            -1.6        7.49            -1.6        7.46
>> >  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execv=
e
>> >       9.10            -1.6        7.49            -1.6        7.46
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.execve
>> >       3.81 =C2=B1  4%      -1.5        2.31 =C2=B1  2%      -1.5      =
  2.26
>> >
>> > perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do=
_sys_clone.do_syscall_64
>> >       4.39            -1.5        2.89            -1.5        2.86
>> >
>> > perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search=
_binary_handler.exec_binprm.bprm_execve
>> >       3.79 =C2=B1  5%      -1.4        2.36 =C2=B1  3%      -1.5      =
  2.30 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_=
mm.do_exit
>> >       3.50 =C2=B1  5%      -1.4        2.06 =C2=B1  3%      -1.5      =
  2.02
>> >
>> > perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_c=
lone.__do_sys_clone
>> >       4.13 =C2=B1  5%      -1.4        2.75            -1.4        2.7=
1
>> >
>> > perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_bin=
ary.search_binary_handler.exec_binprm
>> >       4.65 =C2=B1  3%      -1.3        3.30 =C2=B1  8%      -1.5      =
  3.12 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_cl=
one.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       3.02 =C2=B1  6%      -1.3        1.68 =C2=B1  4%      -1.4      =
  1.62 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mm=
ap.__mmput.exit_mm
>> >       2.57 =C2=B1  8%      -1.3        1.25 =C2=B1  7%      -1.4      =
  1.20 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.down_write.mmap_region.do_mmap.vm_mma=
p_pgoff.ksys_mmap_pgoff
>> >       2.53 =C2=B1  8%      -1.3        1.22 =C2=B1  7%      -1.4      =
  1.17 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.=
mmap_region.do_mmap.vm_mmap_pgoff
>> >       2.50 =C2=B1  8%      -1.3        1.20 =C2=B1  7%      -1.4      =
  1.15 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_writ=
e_slowpath.down_write.mmap_region.do_mmap
>> >       2.32 =C2=B1  8%      -1.3        1.06 =C2=B1  8%      -1.3      =
  1.02 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_=
down_write_slowpath.down_write.mmap_region
>> >       3.64 =C2=B1  8%      -1.1        2.52            -1.2        2.4=
8
>> >
>> > perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load=
_elf_binary.search_binary_handler
>> >       3.56 =C2=B1  7%      -1.1        2.50            -1.1        2.4=
7
>> >
>> > perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new=
_exec.load_elf_binary
>> >       4.77 =C2=B1  2%      -1.0        3.73            -1.1        3.6=
8
>> >  perf-profile.calltrace.cycles-pp.__libc_fork
>> >       4.23 =C2=B1  3%      -1.0        3.24 =C2=B1  2%      -1.0      =
  3.19
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc=
_fork
>> >       4.23 =C2=B1  3%      -1.0        3.24 =C2=B1  2%      -1.0      =
  3.19
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__libc_fork
>> >       4.23 =C2=B1  3%      -1.0        3.24 =C2=B1  2%      -1.0      =
  3.18
>> >
>> > perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe.__libc_fork
>> >       4.23 =C2=B1  3%      -1.0        3.24 =C2=B1  2%      -1.0      =
  3.18
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SY=
SCALL_64_after_hwframe.__libc_fork
>> >       7.19            -0.9        6.30            -0.9        6.32
>> >  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>> >       6.53            -0.8        5.72            -0.8        5.72
>> >  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>> >       6.49            -0.8        5.68            -0.8        5.69
>> >
>> > perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm=
_exc_page_fault
>> >       5.73            -0.7        5.01            -0.7        5.02
>> >
>> > perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.ex=
c_page_fault.asm_exc_page_fault
>> >       1.47 =C2=B1 11%      -0.7        0.75 =C2=B1  8%      -0.7      =
  0.72 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_proce=
ss.kernel_clone
>> >       1.75 =C2=B1  5%      -0.7        1.03 =C2=B1  2%      -0.8      =
  0.99 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_=
mmap.begin_new_exec
>> >       1.20 =C2=B1 13%      -0.7        0.49 =C2=B1 39%      -0.7      =
  0.46 =C2=B1 37%
>> >
>> > perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_=
down_write_slowpath.down_write.dup_mmap
>> >       1.39 =C2=B1 12%      -0.7        0.68 =C2=B1  9%      -0.7      =
  0.65 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.=
dup_mmap.dup_mm.copy_process
>> >       5.46            -0.7        4.76            -0.7        4.77
>> >
>> > perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_=
user_addr_fault.exc_page_fault.asm_exc_page_fault
>> >       1.37 =C2=B1 12%      -0.7        0.67 =C2=B1  9%      -0.7      =
  0.63 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_writ=
e_slowpath.down_write.dup_mmap.dup_mm
>> >       0.94 =C2=B1  7%      -0.7        0.27 =C2=B1100%      -0.6      =
  0.32 =C2=B1 77%
>> >
>> > perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_=
mmap_pgoff.do_syscall_64
>> >       1.27 =C2=B1  7%      -0.7        0.61 =C2=B1  4%      -0.7      =
  0.58 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mm=
ap.__mmput.exec_mmap
>> >       1.06 =C2=B1  7%      -0.6        0.48 =C2=B1 38%      -0.5      =
  0.53 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mma=
p_pgoff.ksys_mmap_pgoff
>> >       3.56 =C2=B1  2%      -0.5        3.09            -0.4        3.1=
2
>> >
>> > perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_=
fault.do_user_addr_fault.exc_page_fault
>> >       1.26 =C2=B1  4%      -0.5        0.80 =C2=B1  3%      -0.5      =
  0.79
>> >
>> > perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.e=
ntry_SYSCALL_64_after_hwframe
>> >       1.27 =C2=B1  4%      -0.5        0.81 =C2=B1  3%      -0.5      =
  0.80
>> >
>> > perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
>> >       1.21 =C2=B1  5%      -0.5        0.75 =C2=B1  3%      -0.5      =
  0.74
>> >
>> > perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_=
syscall_64.entry_SYSCALL_64_after_hwframe
>> >       3.24 =C2=B1  2%      -0.4        2.81            -0.4        2.8=
3
>> >
>> > perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fa=
ult.handle_mm_fault.do_user_addr_fault
>> >       1.71 =C2=B1  3%      -0.4        1.29 =C2=B1  2%      -0.5      =
  1.26 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe
>> >       1.71 =C2=B1  2%      -0.4        1.29 =C2=B1  2%      -0.4      =
  1.26 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       1.57 =C2=B1  3%      -0.4        1.16 =C2=B1  2%      -0.4      =
  1.13 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64=
_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       1.43 =C2=B1  3%      -0.4        1.02 =C2=B1  2%      -0.4      =
  1.00 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect=
_pkey.__x64_sys_mprotect.do_syscall_64
>> >       3.06 =C2=B1  2%      -0.4        2.66            -0.4        2.6=
8
>> >
>> > perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fa=
ult.__handle_mm_fault.handle_mm_fault
>> >       1.39 =C2=B1  3%      -0.4        1.00 =C2=B1  2%      -0.4      =
  0.97 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup=
.do_mprotect_pkey.__x64_sys_mprotect
>> >       0.97 =C2=B1  5%      -0.4        0.62 =C2=B1  4%      -0.4      =
  0.59 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mp=
rotect_fixup.do_mprotect_pkey
>> >       2.83 =C2=B1  2%      -0.3        2.49            -0.3        2.4=
9
>> >
>> > perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_=
vmas.exit_mmap.__mmput
>> >       2.66 =C2=B1  2%      -0.3        2.34            -0.3        2.3=
4
>> >
>> > perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_pag=
e_range.unmap_vmas.exit_mmap
>> >       2.25 =C2=B1  2%      -0.3        1.98            -0.3        1.9=
8
>> >
>> > perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.=
do_exit
>> >       0.58 =C2=B1  3%      -0.3        0.32 =C2=B1 77%      -0.3      =
  0.25 =C2=B1100%
>> >
>> > perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       2.11 =C2=B1  2%      -0.3        1.86            -0.3        1.8=
5
>> >
>> > perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap=
.__mmput.exit_mm
>> >       1.28            -0.2        1.03            -0.2        1.03
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>> >       1.28            -0.2        1.03            -0.2        1.03
>> >
>> > perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.d=
o_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       1.80 =C2=B1  2%      -0.2        1.56 =C2=B1  2%      -0.2      =
  1.57
>> >
>> > perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages=
.do_read_fault.do_fault.__handle_mm_fault
>> >       1.25 =C2=B1  6%      -0.2        1.02 =C2=B1  5%      -0.2      =
  1.00 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_bin=
ary.search_binary_handler.exec_binprm
>> >       1.25 =C2=B1  6%      -0.2        1.03 =C2=B1  5%      -0.2      =
  1.01 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.searc=
h_binary_handler.exec_binprm.bprm_execve
>> >       1.76 =C2=B1  2%      -0.2        1.55            -0.2        1.5=
6
>> >  perf-profile.calltrace.cycles-pp.__mmap
>> >       1.60 =C2=B1  2%      -0.2        1.40            -0.2        1.4=
0
>> >  perf-profile.calltrace.cycles-pp.setlocale
>> >       0.76 =C2=B1  3%      -0.2        0.55 =C2=B1  2%      -0.2      =
  0.54
>> >
>> > perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe
>> >       0.76 =C2=B1  3%      -0.2        0.55 =C2=B1  2%      -0.2      =
  0.54
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>> >       1.73 =C2=B1  2%      -0.2        1.53            -0.2        1.5=
3
>> >  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mma=
p
>> >       1.73 =C2=B1  2%      -0.2        1.53            -0.2        1.5=
3
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__mmap
>> >       0.58 =C2=B1  3%      -0.2        0.38 =C2=B1 57%      -0.2      =
  0.38 =C2=B1 57%
>> >
>> > perf-profile.calltrace.cycles-pp.set_pte_range.filemap_map_pages.do_re=
ad_fault.do_fault.__handle_mm_fault
>> >       1.70 =C2=B1  2%      -0.2        1.50            -0.2        1.5=
0
>> >
>> > perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.__mmap
>> >       1.68            -0.2        1.48            -0.2        1.48
>> >
>> > perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe.__mmap
>> >       1.33 =C2=B1  2%      -0.2        1.13 =C2=B1  2%      -0.2      =
  1.13
>> >
>> > perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit=
_mm.do_exit
>> >       1.30 =C2=B1  2%      -0.2        1.11 =C2=B1  2%      -0.2      =
  1.11
>> >
>> > perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.=
exit_mmap.__mmput.exit_mm
>> >       1.04 =C2=B1  2%      -0.2        0.88 =C2=B1  2%      -0.2      =
  0.88
>> >
>> > perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.t=
lb_finish_mmu.exit_mmap.__mmput
>> >       0.82 =C2=B1  6%      -0.2        0.67 =C2=B1  5%      -0.2      =
  0.65 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.elf_load.load_elf_inter=
p.load_elf_binary.search_binary_handler
>> >       0.79 =C2=B1  6%      -0.1        0.64 =C2=B1  5%      -0.2      =
  0.63 =C2=B1  6%
>> >
>> > perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.elf_load.load_e=
lf_interp.load_elf_binary
>> >       0.60 =C2=B1  2%      -0.1        0.45 =C2=B1 37%      -0.1      =
  0.52
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SY=
SCALL_64_after_hwframe.wait4
>> >       0.77 =C2=B1  7%      -0.1        0.62 =C2=B1  6%      -0.2      =
  0.60 =C2=B1  7%
>> >
>> > perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.elf=
_load.load_elf_interp
>> >       0.59 =C2=B1  2%      -0.1        0.45 =C2=B1 37%      -0.1      =
  0.51
>> >
>> > perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe.wait4
>> >       0.82 =C2=B1  3%      -0.1        0.69 =C2=B1  3%      -0.1      =
  0.68 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_=
open.do_sys_openat2.__x64_sys_openat
>> >       1.37            -0.1        1.24            -0.1        1.24
>> >  perf-profile.calltrace.cycles-pp._dl_addr
>> >       1.04 =C2=B1  2%      -0.1        0.91            -0.1        0.9=
2
>> >  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
>> >       1.01 =C2=B1  2%      -0.1        0.88            -0.1        0.8=
8
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open=
64_nocancel.setlocale
>> >       0.99 =C2=B1  2%      -0.1        0.87            -0.1        0.8=
8
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>> >       1.00 =C2=B1  2%      -0.1        0.88            -0.1        0.8=
8
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.__open64_nocancel.setlocale
>> >       0.99 =C2=B1  2%      -0.1        0.86            -0.1        0.8=
7
>> >
>> > perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>> >       0.80 =C2=B1  2%      -0.1        0.69 =C2=B1  2%      -0.1      =
  0.69 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.zap_pm=
d_range.unmap_page_range.unmap_vmas
>> >       0.83 =C2=B1  2%      -0.1        0.73            -0.1        0.7=
3
>> >
>> > perf-profile.calltrace.cycles-pp.elf_load.load_elf_binary.search_binar=
y_handler.exec_binprm.bprm_execve
>> >       1.01 =C2=B1  3%      -0.1        0.91            -0.1        0.9=
1
>> >  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
>> >       0.88            -0.1        0.78            -0.1        0.78
>> >
>> > perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mma=
p.begin_new_exec
>> >       0.70 =C2=B1  2%      -0.1        0.60 =C2=B1  2%      -0.1      =
  0.61
>> >  perf-profile.calltrace.cycles-pp.wait4
>> >       1.01 =C2=B1  3%      -0.1        0.91            -0.1        0.9=
2
>> >  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
>> >       0.69 =C2=B1  2%      -0.1        0.59            -0.1        0.6=
0
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.wait4
>> >       0.98 =C2=B1  3%      -0.1        0.88            -0.1        0.8=
8
>> >
>> > perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_a=
sm
>> >       0.69 =C2=B1  2%      -0.1        0.59            -0.1        0.6=
0
>> >  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
>> >       0.78            -0.1        0.69            -0.1        0.70 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap=
.__mmput.exec_mmap
>> >       0.64 =C2=B1  2%      -0.1        0.55 =C2=B1  2%      -0.1      =
  0.56
>> >
>> > perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_=
read_slowpath.down_read.open_last_lookups.path_openat
>> >       0.71 =C2=B1  2%      -0.1        0.62 =C2=B1  2%      -0.1      =
  0.62 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.h=
andle_mm_fault.do_user_addr_fault.exc_page_fault
>> >       0.68            -0.1        0.60 =C2=B1  2%      -0.1        0.6=
1
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.op=
en_last_lookups.path_openat.do_filp_open
>> >       0.74 =C2=B1  2%      -0.1        0.66            -0.1        0.6=
6
>> >
>> > perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle=
_mm_fault.do_user_addr_fault.exc_page_fault
>> >       0.70            -0.1        0.62 =C2=B1  2%      -0.1        0.6=
3
>> >
>> > perf-profile.calltrace.cycles-pp.down_read.open_last_lookups.path_open=
at.do_filp_open.do_sys_openat2
>> >       0.80 =C2=B1  3%      -0.1        0.72            -0.1        0.7=
3 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fo=
rk.ret_from_fork_asm
>> >       0.63            -0.1        0.55 =C2=B1  2%      -0.1        0.5=
6
>> >
>> > perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rw=
sem_down_read_slowpath.down_read.open_last_lookups
>> >       0.79            -0.1        0.72            -0.1        0.72
>> >  perf-profile.calltrace.cycles-pp.__strcoll_l
>> >       0.58 =C2=B1  3%      -0.1        0.52            -0.1        0.4=
5 =C2=B1 37%
>> >  perf-profile.calltrace.cycles-pp._IO_default_xsputn
>> >       0.66 =C2=B1  2%      -0.1        0.60            -0.1        0.6=
0
>> >
>> > perf-profile.calltrace.cycles-pp.copy_strings.do_execveat_common.__x64=
_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       0.61 =C2=B1  3%      +0.0        0.63            +0.0        0.6=
4 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysve=
c_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
>> >       0.73 =C2=B1  2%      +0.0        0.76            +0.0        0.7=
7 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_=
safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>> >       0.96            +0.1        1.02            +0.1        1.02
>> >  perf-profile.calltrace.cycles-pp.open64
>> >       0.94            +0.1        0.99            +0.1        1.00
>> >
>> > perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.open64
>> >       0.95            +0.1        1.00            +0.1        1.01
>> >  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open6=
4
>> >       0.95            +0.1        1.00            +0.1        1.01
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.open64
>> >       0.94            +0.1        1.00            +0.1        1.00
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_=
SYSCALL_64_after_hwframe.open64
>> >       0.71 =C2=B1  2%      +0.1        0.81            +0.1        0.8=
1 =C2=B1  2%
>> >  perf-profile.calltrace.cycles-pp.unlinkat
>> >       0.70 =C2=B1  2%      +0.1        0.80 =C2=B1  2%      +0.1      =
  0.80 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entr=
y_SYSCALL_64_after_hwframe.unlinkat
>> >       0.70 =C2=B1  2%      +0.1        0.80            +0.1        0.8=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_sys=
call_64.entry_SYSCALL_64_after_hwframe.unlinkat
>> >       0.70 =C2=B1  2%      +0.1        0.80            +0.1        0.8=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink=
at
>> >       0.70 =C2=B1  2%      +0.1        0.80            +0.1        0.8=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe.unlinkat
>> >       0.53 =C2=B1  3%      +0.1        0.63 =C2=B1  2%      +0.1      =
  0.64 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_f=
unction_queue.__sysvec_call_function_single.sysvec_call_function_single.asm=
_sysvec_call_function_single
>> >       0.62 =C2=B1  2%      +0.1        0.75 =C2=B1  2%      +0.1      =
  0.75 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sys=
vec_call_function_single.sysvec_call_function_single.asm_sysvec_call_functi=
on_single.acpi_safe_halt
>> >       0.64 =C2=B1  3%      +0.1        0.78 =C2=B1  2%      +0.1      =
  0.78 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_=
call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_id=
le_enter
>> >       0.73 =C2=B1  3%      +0.1        0.87 =C2=B1  2%      +0.2      =
  0.88 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_op=
enat.do_filp_open.do_sys_openat2
>> >       0.70 =C2=B1  3%      +0.1        0.85 =C2=B1  3%      +0.2      =
  0.86 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_l=
ookups.path_openat.do_filp_open
>> >       0.70 =C2=B1  3%      +0.1        0.84 =C2=B1  2%      +0.2      =
  0.86 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.looku=
p_fast.open_last_lookups.path_openat
>> >       0.70 =C2=B1  3%      +0.1        0.84 =C2=B1  2%      +0.2      =
  0.85 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_pat=
h.try_to_unlazy.lookup_fast.open_last_lookups
>> >       0.77 =C2=B1  3%      +0.2        0.92 =C2=B1  2%      +0.2      =
  0.93 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysve=
c_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
>> >       1.38            +0.2        1.57            +0.2        1.58
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_c=
omponent.link_path_walk.path_lookupat
>> >       1.59 =C2=B1  2%      +0.2        1.81            +0.2        1.8=
2
>> >
>> > perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidl=
e_enter_state.cpuidle_enter.cpuidle_idle_call
>> >       1.41 =C2=B1  2%      +0.2        1.63            +0.2        1.6=
4
>> >
>> > perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_pat=
h_walk.path_lookupat.filename_lookup
>> >       0.70 =C2=B1  4%      +0.2        0.95 =C2=B1  3%      +0.2      =
  0.94 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_las=
t_lookups.path_openat.do_filp_open
>> >       0.73 =C2=B1  4%      +0.2        0.98 =C2=B1  3%      +0.2      =
  0.97 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_op=
enat.do_filp_open.do_sys_openat2
>> >       2.33 =C2=B1  3%      +0.4        2.70            +0.4        2.7=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.__dentry_kill.dput.d_alloc_parallel
>> >       2.44 =C2=B1  3%      +0.4        2.82            +0.4        2.8=
3 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel._=
_lookup_slow.walk_component
>> >       2.39 =C2=B1  3%      +0.4        2.78            +0.4        2.7=
8 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_a=
lloc_parallel.__lookup_slow
>> >       1.95            +0.4        2.36            +0.4        2.38
>> >
>> > perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lo=
okupat.filename_lookup.vfs_statx
>> >       2.69 =C2=B1  2%      +0.4        3.12            +0.4        3.1=
4
>> >
>> > perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.c=
puidle_enter.cpuidle_idle_call.do_idle
>> >       2.27 =C2=B1  3%      +0.4        2.70 =C2=B1  2%      +0.4      =
  2.71 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.d_alloc=
_parallel.__lookup_slow
>> >       2.26 =C2=B1  3%      +0.4        2.69 =C2=B1  2%      +0.4      =
  2.70 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.fast_dput.dput.d_alloc_parallel
>> >       2.32 =C2=B1  3%      +0.4        2.75            +0.4        2.7=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.d_alloc_parallel.__loo=
kup_slow.walk_component
>> >       2.79 =C2=B1  2%      +0.4        3.24            +0.5        3.2=
6
>> >
>> > perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpu=
idle_idle_call.do_idle.cpu_startup_entry
>> >       2.80 =C2=B1  2%      +0.4        3.25            +0.5        3.2=
7
>> >
>> > perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_id=
le.cpu_startup_entry.start_secondary
>> >       0.00            +0.5        0.46 =C2=B1 37%      +0.5        0.5=
3 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_compon=
ent.link_path_walk.path_lookupat
>> >       3.03 =C2=B1  2%      +0.5        3.50            +0.5        3.5=
2
>> >
>> > perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup=
_entry.start_secondary.secondary_startup_64_no_verify
>> >       3.62 =C2=B1  2%      +0.5        4.13            +0.5        4.1=
5
>> >
>> > perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secon=
dary.secondary_startup_64_no_verify
>> >       3.63 =C2=B1  2%      +0.5        4.14            +0.5        4.1=
6
>> >
>> > perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_=
no_verify
>> >       3.63 =C2=B1  2%      +0.5        4.14            +0.5        4.1=
6
>> >
>> > perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.sec=
ondary_startup_64_no_verify
>> >       3.68            +0.5        4.20            +0.5        4.23
>> >  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>> >       0.15 =C2=B1158%      +0.5        0.67 =C2=B1  2%      +0.5      =
  0.69 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_=
walk.path_lookupat.filename_lookup
>> >       1.27 =C2=B1  2%      +0.6        1.82            +0.6        1.8=
3
>> >
>> > perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats=
.find_busiest_group.load_balance.newidle_balance
>> >       0.00            +0.6        0.57 =C2=B1  2%      +0.6        0.5=
8 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_lo=
okupat.filename_lookup
>> >       0.00            +0.6        0.57 =C2=B1  2%      +0.6        0.5=
8 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.fil=
ename_lookup.vfs_statx
>> >       0.00            +0.6        0.58 =C2=B1  2%      +0.6        0.5=
9 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename=
_lookup.vfs_statx.__do_sys_newstat
>> >       2.45 =C2=B1  2%      +0.6        3.04            +0.6        3.0=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_=
safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>> >       1.41 =C2=B1  2%      +0.6        2.01            +0.6        2.0=
2
>> >
>> > perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group=
.load_balance.newidle_balance.pick_next_task_fair
>> >       1.43 =C2=B1  2%      +0.6        2.04            +0.6        2.0=
5
>> >
>> > perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newid=
le_balance.pick_next_task_fair.__schedule
>> >       0.00            +0.6        0.62 =C2=B1  4%      +0.6        0.6=
2 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.d_alloc.d_alloc_parallel.lookup_open
>> >       2.19            +0.6        2.82            +0.7        2.84
>> >
>> > perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename=
_lookup.vfs_statx.__do_sys_newstat
>> >       0.00            +0.6        0.63 =C2=B1  3%      +0.6        0.6=
3 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parall=
el.lookup_open.open_last_lookups
>> >       0.00            +0.6        0.64 =C2=B1  3%      +0.6        0.6=
5 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.ste=
p_into.open_last_lookups
>> >       0.00            +0.7        0.66 =C2=B1  3%      +0.7        0.6=
6 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_las=
t_lookups.path_openat
>> >       0.00            +0.7        0.66 =C2=B1  3%      +0.7        0.6=
6 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.=
open_last_lookups.path_openat
>> >       0.71 =C2=B1  2%      +0.7        1.38 =C2=B1  2%      +0.7      =
  1.39 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_open=
at.do_filp_open.do_sys_openat2
>> >       0.00            +0.7        0.67 =C2=B1  2%      +0.7        0.6=
8 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.step_in=
to.open_last_lookups
>> >       0.67 =C2=B1  2%      +0.7        1.34 =C2=B1  2%      +0.7      =
  1.36 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path=
_openat.do_filp_open
>> >       0.00            +0.7        0.68 =C2=B1  2%      +0.7        0.6=
9 =C2=B1  3%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.step_into.open_last_lo=
okups.path_openat
>> >       1.90 =C2=B1  2%      +0.8        2.70            +0.8        2.7=
2
>> >
>> > perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_nex=
t_task_fair.__schedule.schedule
>> >       2.83            +0.9        3.69            +0.9        3.73
>> >
>> > perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>> >       2.71            +0.9        3.58            +0.9        3.62
>> >
>> > perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>> >       2.69            +0.9        3.56            +0.9        3.60
>> >
>> > perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_sta=
tx.__do_sys_newstat.do_syscall_64
>> >       2.71            +0.9        3.58            +0.9        3.62
>> >
>> > perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_ne=
wstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >       2.09 =C2=B1  2%      +0.9        2.96            +0.9        2.9=
8
>> >
>> > perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair._=
_schedule.schedule.schedule_preempt_disabled
>> >       2.12 =C2=B1  2%      +0.9        3.01            +0.9        3.0=
2
>> >
>> > perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedu=
le.schedule_preempt_disabled.rwsem_down_read_slowpath
>> >       3.50 =C2=B1  2%      +1.0        4.52            +1.0        4.5=
5
>> >
>> > perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_=
disabled.rwsem_down_read_slowpath.down_read
>> >       3.72 =C2=B1  2%      +1.0        4.76            +1.1        4.8=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp=
_open.do_sys_openat2.__x64_sys_openat
>> >       2.88 =C2=B1  2%      +1.1        3.99            +1.1        4.0=
0
>> >
>> > perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rw=
sem_down_read_slowpath.down_read.walk_component
>> >       2.88 =C2=B1  2%      +1.1        3.99            +1.1        4.0=
0
>> >
>> > perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_=
read_slowpath.down_read.walk_component.link_path_walk
>> >      10.51 =C2=B1  3%      +1.3       11.78            +1.3       11.8=
3
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_c=
omponent.link_path_walk.path_openat
>> >       3.15 =C2=B1  2%      +1.3        4.43            +1.3        4.4=
5
>> >
>> > perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.wa=
lk_component.link_path_walk.path_openat
>> >       3.22 =C2=B1  2%      +1.3        4.54            +1.3        4.5=
6
>> >
>> > perf-profile.calltrace.cycles-pp.down_read.walk_component.link_path_wa=
lk.path_openat.do_filp_open
>> >      10.58 =C2=B1  3%      +1.4       11.94            +1.4       11.9=
9
>> >
>> > perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_pat=
h_walk.path_openat.do_filp_open
>> >       2.09 =C2=B1  2%      +2.4        4.54            +2.5        4.5=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_=
walk.path_openat.do_filp_open
>> >       1.83 =C2=B1  3%      +2.5        4.31            +2.5        4.3=
3 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_compon=
ent.link_path_walk.path_openat
>> >       1.79 =C2=B1  3%      +2.5        4.32 =C2=B1  5%      +2.7      =
  4.46 =C2=B1  5%
>> >
>> > perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_pat=
h.try_to_unlazy.lookup_fast.walk_component
>> >       2.68 =C2=B1  3%      +2.6        5.24 =C2=B1  4%      +2.7      =
  5.42 =C2=B1  4%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
>> >       2.29 =C2=B1  3%      +2.6        4.89 =C2=B1  2%      +2.6      =
  4.90 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
>> >       2.34 =C2=B1  3%      +2.6        4.95            +2.6        4.9=
7 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead._=
_legitimize_path.try_to_unlazy.lookup_fast
>> >       0.00            +2.7        2.72 =C2=B1  2%      +2.8        2.7=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.step_in=
to.link_path_walk
>> >       0.00            +2.8        2.76            +2.8        2.78 =C2=
=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.ste=
p_into.link_path_walk
>> >       0.00            +2.8        2.82 =C2=B1  2%      +2.9        2.8=
6 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.step_into.link_path_wa=
lk.path_openat
>> >       1.83 =C2=B1  3%      +2.9        4.69 =C2=B1  5%      +3.0      =
  4.84
>> >
>> > perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.looku=
p_fast.walk_component.link_path_walk
>> >       0.00            +2.9        2.86            +2.9        2.89
>> >
>> > perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_pat=
h_walk.path_openat
>> >       3.00 =C2=B1  3%      +3.0        5.97 =C2=B1  2%      +3.0      =
  6.00 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.fast_dput.dput.terminate_walk
>> >       3.02 =C2=B1  3%      +3.0        6.00 =C2=B1  2%      +3.0      =
  6.03 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.fast_dput.dput.termina=
te_walk.path_openat
>> >       3.15 =C2=B1  3%      +3.0        6.18            +3.1        6.2=
2 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_fi=
lp_open.do_sys_openat2
>> >       3.16 =C2=B1  3%      +3.0        6.20 =C2=B1  2%      +3.1      =
  6.23 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_op=
en.do_sys_openat2.__x64_sys_openat
>> >       3.14 =C2=B1  3%      +3.0        6.18 =C2=B1  2%      +3.1      =
  6.21 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.fast_dput.dput.terminate_walk.path_op=
enat.do_filp_open
>> >       2.80 =C2=B1  3%      +3.1        5.89            +3.1        5.9=
5
>> >
>> > perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parall=
el.__lookup_slow.walk_component
>> >       3.05 =C2=B1  2%      +3.2        6.29            +3.3        6.3=
5
>> >
>> > perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slo=
w.walk_component.link_path_walk
>> >       0.00            +3.3        3.27 =C2=B1  2%      +3.3        3.3=
0 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.__dentry_kill.dput.step_into
>> >       0.00            +3.4        3.38 =C2=B1  2%      +3.4        3.4=
3 =C2=B1  2%
>> >
>> > perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw=
_spin_lock.fast_dput.dput.step_into
>> >       1.39            +4.3        5.72 =C2=B1  2%      +4.4        5.8=
0
>> >
>> > perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.=
do_filp_open.do_sys_openat2
>> >       1.36            +4.3        5.70            +4.4        5.77
>> >
>> > perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_op=
enat.do_filp_open
>> >      58.11            +4.5       62.65            +4.5       62.64
>> >  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>> >      58.08            +4.5       62.62            +4.5       62.61
>> >
>> > perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_=
hwframe
>> >      16.02 =C2=B1  2%      +5.2       21.18            +5.2       21.2=
6
>> >
>> > perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_op=
enat.do_filp_open.do_sys_openat2
>> >      17.55 =C2=B1  2%      +9.5       27.02            +9.6       27.1=
8
>> >
>> > perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_op=
en.do_sys_openat2.__x64_sys_openat
>> >      27.04 =C2=B1  2%     +13.2       40.26           +13.4       40.4=
9
>> >
>> > perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys=
_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>> >      25.93 =C2=B1  2%     +13.2       39.15           +13.4       39.3=
8
>> >
>> > perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
>> >      26.97 =C2=B1  2%     +13.2       40.19           +13.5       40.4=
2
>> >
>> > perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_opena=
t2.__x64_sys_openat.do_syscall_64
>> >      25.91 =C2=B1  2%     +13.2       39.13           +13.4       39.3=
6
>> >
>> > perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe
>> >      19.76 =C2=B1  7%      -9.5       10.25 =C2=B1  6%      -9.9      =
  9.91 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.down_write
>> >      18.96 =C2=B1  7%      -9.4        9.56 =C2=B1  6%      -9.8      =
  9.20 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>> >      18.41 =C2=B1  8%      -9.3        9.10 =C2=B1  7%      -9.7      =
  8.75 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>> >      16.58 =C2=B1  8%      -8.9        7.70 =C2=B1  7%      -9.2      =
  7.37 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.osq_lock
>> >      17.98 =C2=B1  4%      -6.9       11.07 =C2=B1  3%      -7.1      =
 10.88
>> >  perf-profile.children.cycles-pp.vm_mmap_pgoff
>> >      17.77 =C2=B1  4%      -6.9       10.88 =C2=B1  3%      -7.1      =
 10.70
>> >  perf-profile.children.cycles-pp.do_mmap
>> >      17.42 =C2=B1  5%      -6.9       10.56 =C2=B1  4%      -7.0      =
 10.38
>> >  perf-profile.children.cycles-pp.mmap_region
>> >      15.30 =C2=B1  5%      -6.2        9.08 =C2=B1  4%      -6.4      =
  8.91
>> >  perf-profile.children.cycles-pp.ksys_mmap_pgoff
>> >      10.93 =C2=B1  5%      -4.6        6.32 =C2=B1  5%      -4.7      =
  6.19 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_vmi_munmap
>> >      10.84 =C2=B1  5%      -4.6        6.23 =C2=B1  5%      -4.7      =
  6.10 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_vmi_align_munmap
>> >       9.78 =C2=B1  6%      -4.2        5.58 =C2=B1  4%      -4.4      =
  5.42 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.free_pgtables
>> >       8.36 =C2=B1  7%      -4.0        4.34 =C2=B1  5%      -4.2      =
  4.20 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.unlink_file_vma
>> >       7.13 =C2=B1  7%      -3.3        3.82 =C2=B1  6%      -3.4      =
  3.71 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.vma_prepare
>> >      12.01            -3.1        8.96            -3.2        8.86
>> >  perf-profile.children.cycles-pp.exit_mmap
>> >      12.05            -3.0        9.00            -3.2        8.90
>> >  perf-profile.children.cycles-pp.__mmput
>> >       7.41 =C2=B1  5%      -3.0        4.43 =C2=B1  4%      -3.1      =
  4.34 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__split_vma
>> >       9.84            -2.1        7.73            -2.2        7.68
>> >  perf-profile.children.cycles-pp.__x64_sys_exit_group
>> >       9.84            -2.1        7.72            -2.2        7.67
>> >  perf-profile.children.cycles-pp.do_exit
>> >       9.84            -2.1        7.73            -2.2        7.68
>> >  perf-profile.children.cycles-pp.do_group_exit
>> >       4.53 =C2=B1  6%      -2.0        2.53 =C2=B1  5%      -2.1      =
  2.48 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.unmap_region
>> >       8.16            -2.0        6.16            -2.1        6.09
>> >  perf-profile.children.cycles-pp.exit_mm
>> >      10.38            -1.9        8.52            -1.9        8.49
>> >  perf-profile.children.cycles-pp.__x64_sys_execve
>> >      10.37            -1.9        8.51            -1.9        8.48
>> >  perf-profile.children.cycles-pp.do_execveat_common
>> >       8.79            -1.7        7.08            -1.7        7.05
>> >  perf-profile.children.cycles-pp.bprm_execve
>> >       8.14            -1.6        6.50            -1.7        6.46
>> >  perf-profile.children.cycles-pp.exec_binprm
>> >       8.12            -1.6        6.48            -1.7        6.45
>> >  perf-profile.children.cycles-pp.search_binary_handler
>> >       8.02            -1.6        6.40            -1.7        6.36
>> >  perf-profile.children.cycles-pp.load_elf_binary
>> >       9.11            -1.6        7.50            -1.6        7.47
>> >  perf-profile.children.cycles-pp.execve
>> >       5.41 =C2=B1  2%      -1.2        4.16            -1.3        4.1=
1
>> >  perf-profile.children.cycles-pp.kernel_clone
>> >      10.19            -1.2        8.97            -1.2        8.97
>> >  perf-profile.children.cycles-pp.asm_exc_page_fault
>> >       4.99 =C2=B1  3%      -1.2        3.79 =C2=B1  2%      -1.3      =
  3.73
>> >  perf-profile.children.cycles-pp.__do_sys_clone
>> >       4.88 =C2=B1  3%      -1.2        3.69 =C2=B1  2%      -1.2      =
  3.64
>> >  perf-profile.children.cycles-pp.copy_process
>> >       4.39            -1.1        3.28            -1.1        3.25
>> >  perf-profile.children.cycles-pp.begin_new_exec
>> >       9.15            -1.1        8.04            -1.1        8.04
>> >  perf-profile.children.cycles-pp.exc_page_fault
>> >       3.81 =C2=B1  4%      -1.1        2.70 =C2=B1  2%      -1.2      =
  2.65
>> >  perf-profile.children.cycles-pp.dup_mm
>> >       9.11            -1.1        8.01            -1.1        8.00
>> >  perf-profile.children.cycles-pp.do_user_addr_fault
>> >       4.20 =C2=B1  2%      -1.1        3.12            -1.1        3.0=
9
>> >  perf-profile.children.cycles-pp.exec_mmap
>> >       3.50 =C2=B1  5%      -1.1        2.43 =C2=B1  3%      -1.1      =
  2.38
>> >  perf-profile.children.cycles-pp.dup_mmap
>> >       4.81 =C2=B1  2%      -1.0        3.76            -1.1        3.7=
1
>> >  perf-profile.children.cycles-pp.__libc_fork
>> >       8.35            -1.0        7.32            -1.0        7.32
>> >  perf-profile.children.cycles-pp.handle_mm_fault
>> >       7.97            -1.0        6.99            -1.0        6.99
>> >  perf-profile.children.cycles-pp.__handle_mm_fault
>> >       5.24 =C2=B1  2%      -0.7        4.58            -0.6        4.5=
9
>> >  perf-profile.children.cycles-pp.do_fault
>> >       4.80 =C2=B1  2%      -0.6        4.20            -0.6        4.2=
1
>> >  perf-profile.children.cycles-pp.do_read_fault
>> >       4.64 =C2=B1  2%      -0.6        4.06            -0.6        4.0=
7
>> >  perf-profile.children.cycles-pp.filemap_map_pages
>> >       1.10 =C2=B1  7%      -0.5        0.57 =C2=B1  6%      -0.5      =
  0.56 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.vma_expand
>> >       1.71 =C2=B1  2%      -0.4        1.29 =C2=B1  2%      -0.5      =
  1.26 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__x64_sys_mprotect
>> >       1.71 =C2=B1  2%      -0.4        1.29 =C2=B1  2%      -0.4      =
  1.26 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_mprotect_pkey
>> >       1.57 =C2=B1  3%      -0.4        1.16 =C2=B1  2%      -0.4      =
  1.13 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.mprotect_fixup
>> >       3.45 =C2=B1  2%      -0.4        3.04            -0.4        3.0=
5
>> >  perf-profile.children.cycles-pp.unmap_vmas
>> >       1.43 =C2=B1  3%      -0.4        1.03 =C2=B1  2%      -0.4      =
  1.00 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.vma_modify
>> >       3.19 =C2=B1  2%      -0.4        2.81            -0.4        2.8=
2
>> >  perf-profile.children.cycles-pp.unmap_page_range
>> >       2.33 =C2=B1  3%      -0.4        1.96 =C2=B1  3%      -0.4      =
  1.95 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.elf_load
>> >       3.09 =C2=B1  2%      -0.4        2.72            -0.4        2.7=
3
>> >  perf-profile.children.cycles-pp.zap_pmd_range
>> >       3.03 =C2=B1  2%      -0.4        2.67            -0.4        2.6=
8
>> >  perf-profile.children.cycles-pp.zap_pte_range
>> >       1.51            -0.4        1.16            -0.4        1.15 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.rwsem_spin_on_owner
>> >       2.72 =C2=B1  2%      -0.3        2.38 =C2=B1  2%      -0.3      =
  2.38
>> >  perf-profile.children.cycles-pp.next_uptodate_folio
>> >       2.06            -0.3        1.77            -0.3        1.76
>> >  perf-profile.children.cycles-pp.tlb_finish_mmu
>> >       1.86            -0.3        1.58 =C2=B1  2%      -0.3        1.5=
8
>> >  perf-profile.children.cycles-pp.tlb_batch_pages_flush
>> >       1.39 =C2=B1  6%      -0.3        1.14 =C2=B1  5%      -0.3      =
  1.12 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.load_elf_interp
>> >       1.55 =C2=B1  2%      -0.2        1.31 =C2=B1  2%      -0.2      =
  1.32
>> >  perf-profile.children.cycles-pp.release_pages
>> >       1.77 =C2=B1  2%      -0.2        1.56            -0.2        1.5=
7
>> >  perf-profile.children.cycles-pp.__mmap
>> >       1.80            -0.2        1.60            -0.2        1.60
>> >  perf-profile.children.cycles-pp.kmem_cache_alloc
>> >       1.61 =C2=B1  2%      -0.2        1.40            -0.2        1.4=
1
>> >  perf-profile.children.cycles-pp.setlocale
>> >       1.63            -0.2        1.44            -0.2        1.43
>> >  perf-profile.children.cycles-pp.vma_interval_tree_insert
>> >       1.44            -0.2        1.27            -0.2        1.26
>> >  perf-profile.children.cycles-pp.alloc_pages_mpol
>> >       1.16 =C2=B1  3%      -0.2        0.99 =C2=B1  2%      -0.2      =
  0.98 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.alloc_empty_file
>> >       1.35 =C2=B1  2%      -0.2        1.18            -0.2        1.1=
9
>> >  perf-profile.children.cycles-pp.__open64_nocancel
>> >       1.37            -0.2        1.21 =C2=B1  2%      -0.2        1.2=
0
>> >  perf-profile.children.cycles-pp.__alloc_pages
>> >       1.15 =C2=B1  2%      -0.2        1.00 =C2=B1  2%      -0.2      =
  1.00
>> >  perf-profile.children.cycles-pp.page_remove_rmap
>> >       0.82 =C2=B1  3%      -0.1        0.68 =C2=B1  3%      -0.1      =
  0.68 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.init_file
>> >       1.02 =C2=B1  2%      -0.1        0.88            -0.2        0.8=
7 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__vm_munmap
>> >       0.71 =C2=B1  3%      -0.1        0.58 =C2=B1  3%      -0.1      =
  0.58 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.security_file_alloc
>> >       1.38            -0.1        1.25            -0.1        1.26
>> >  perf-profile.children.cycles-pp._dl_addr
>> >       0.97 =C2=B1  2%      -0.1        0.84            -0.1        0.8=
4
>> >  perf-profile.children.cycles-pp.set_pte_range
>> >       0.62 =C2=B1  3%      -0.1        0.50 =C2=B1  3%      -0.1      =
  0.49 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>> >       0.70 =C2=B1  3%      -0.1        0.58 =C2=B1  3%      -0.1      =
  0.58 =C2=B1  2%
>> >  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>> >       0.95 =C2=B1  2%      -0.1        0.83 =C2=B1  2%      -0.1      =
  0.82
>> >  perf-profile.children.cycles-pp.get_page_from_freelist
>> >       1.19 =C2=B1  2%      -0.1        1.07            -0.1        1.0=
8
>> >  perf-profile.children.cycles-pp.ret_from_fork
>> >       1.03 =C2=B1  2%      -0.1        0.91            -0.1        0.9=
0
>> >  perf-profile.children.cycles-pp.do_anonymous_page
>> >       1.22 =C2=B1  2%      -0.1        1.10            -0.1        1.1=
0
>> >  perf-profile.children.cycles-pp.ret_from_fork_asm
>> >       0.84            -0.1        0.72 =C2=B1  2%      -0.1        0.7=
1
>> >  perf-profile.children.cycles-pp.vma_complete
>> >       1.46            -0.1        1.35            -0.1        1.35 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.kmem_cache_free
>> >       0.19            -0.1        0.08            -0.1        0.08 =C2=
=B1  5%
>> >  perf-profile.children.cycles-pp._raw_spin_trylock
>> >       0.90            -0.1        0.79 =C2=B1  2%      -0.1        0.8=
0
>> >  perf-profile.children.cycles-pp.perf_event_mmap
>> >       0.87            -0.1        0.76 =C2=B1  2%      -0.1        0.7=
7
>> >  perf-profile.children.cycles-pp.perf_event_mmap_event
>> >       0.86 =C2=B1  2%      -0.1        0.76            -0.1        0.7=
6 =C2=B1  2%
>> >  perf-profile.children.cycles-pp._compound_head
>> >       0.91            -0.1        0.80            -0.1        0.81
>> >  perf-profile.children.cycles-pp.mas_store_prealloc
>> >       1.52 =C2=B1  2%      -0.1        1.42            -0.1        1.4=
4
>> >  perf-profile.children.cycles-pp.__do_softirq
>> >       0.68 =C2=B1  3%      -0.1        0.58            -0.1        0.5=
9
>> >  perf-profile.children.cycles-pp.__do_sys_wait4
>> >       0.93 =C2=B1  2%      -0.1        0.83            -0.1        0.8=
3
>> >  perf-profile.children.cycles-pp.wp_page_copy
>> >       0.42 =C2=B1  4%      -0.1        0.32 =C2=B1  2%      -0.1      =
  0.33 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.security_file_free
>> >       0.71 =C2=B1  3%      -0.1        0.61            -0.1        0.6=
1
>> >  perf-profile.children.cycles-pp.wait4
>> >       0.98 =C2=B1  3%      -0.1        0.88            -0.1        0.8=
8
>> >  perf-profile.children.cycles-pp.kthread
>> >       0.67 =C2=B1  3%      -0.1        0.57            -0.1        0.5=
7
>> >  perf-profile.children.cycles-pp.do_wait
>> >       1.35 =C2=B1  2%      -0.1        1.26            -0.1        1.2=
8
>> >  perf-profile.children.cycles-pp.rcu_core
>> >       0.68 =C2=B1  2%      -0.1        0.58            -0.1        0.5=
9
>> >  perf-profile.children.cycles-pp.kernel_wait4
>> >       0.41 =C2=B1  4%      -0.1        0.32 =C2=B1  2%      -0.1      =
  0.32 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.apparmor_file_free_security
>> >       1.30 =C2=B1  2%      -0.1        1.21            -0.1        1.2=
3
>> >  perf-profile.children.cycles-pp.rcu_do_batch
>> >       1.89            -0.1        1.81            -0.1        1.84
>> >  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>> >       0.80 =C2=B1  3%      -0.1        0.72            -0.1        0.7=
3 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.smpboot_thread_fn
>> >       0.93 =C2=B1  2%      -0.1        0.86            -0.1        0.8=
6
>> >  perf-profile.children.cycles-pp.__slab_free
>> >       0.50 =C2=B1  3%      -0.1        0.42 =C2=B1  2%      -0.1      =
  0.43 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_open
>> >       0.62 =C2=B1  2%      -0.1        0.54            -0.1        0.5=
4
>> >  perf-profile.children.cycles-pp.mas_wr_store_entry
>> >       0.79            -0.1        0.72            -0.1        0.72
>> >  perf-profile.children.cycles-pp.__strcoll_l
>> >       0.55 =C2=B1  2%      -0.1        0.48            -0.1        0.4=
7
>> >  perf-profile.children.cycles-pp.vma_alloc_folio
>> >       0.78            -0.1        0.70 =C2=B1  2%      -0.1        0.7=
0 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
>> >       0.58            -0.1        0.51            -0.1        0.52
>> >  perf-profile.children.cycles-pp.sync_regs
>> >       1.67            -0.1        1.60            -0.1        1.58
>> >  perf-profile.children.cycles-pp.up_write
>> >       0.50 =C2=B1  2%      -0.1        0.43 =C2=B1  2%      -0.1      =
  0.43 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.clear_page_erms
>> >       0.50 =C2=B1  3%      -0.1        0.43            -0.1        0.4=
2 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.release_empty_file
>> >       0.75 =C2=B1  2%      -0.1        0.69            -0.1        0.6=
8
>> >  perf-profile.children.cycles-pp.copy_strings
>> >       0.64 =C2=B1  2%      -0.1        0.57 =C2=B1  2%      -0.1      =
  0.57
>> >  perf-profile.children.cycles-pp.unlink_anon_vmas
>> >       0.62 =C2=B1  3%      -0.1        0.56            -0.1        0.5=
5 =C2=B1  2%
>> >  perf-profile.children.cycles-pp._IO_default_xsputn
>> >       0.65 =C2=B1  2%      -0.1        0.59 =C2=B1  4%      -0.1      =
  0.58 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.mm_init
>> >       0.48            -0.1        0.42            -0.1        0.43
>> >  perf-profile.children.cycles-pp.vm_area_alloc
>> >       0.52 =C2=B1  2%      -0.1        0.46 =C2=B1  2%      -0.1      =
  0.46
>> >  perf-profile.children.cycles-pp.ksys_read
>> >       0.51 =C2=B1  2%      -0.1        0.44 =C2=B1  2%      -0.1      =
  0.44
>> >  perf-profile.children.cycles-pp.vfs_read
>> >       0.45 =C2=B1  3%      -0.1        0.39            -0.1        0.3=
9
>> >  perf-profile.children.cycles-pp.rmqueue
>> >       0.43 =C2=B1  3%      -0.1        0.37 =C2=B1  2%      -0.1      =
  0.37 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.dup_task_struct
>> >       0.47            -0.1        0.41            -0.1        0.41
>> >  perf-profile.children.cycles-pp.read
>> >       0.26 =C2=B1  5%      -0.1        0.20 =C2=B1  5%      -0.1      =
  0.21 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
>> >       0.57 =C2=B1  3%      -0.1        0.51 =C2=B1  2%      -0.1      =
  0.51
>> >  perf-profile.children.cycles-pp.perf_iterate_sb
>> >       0.55            -0.1        0.49 =C2=B1  2%      -0.1        0.4=
9
>> >  perf-profile.children.cycles-pp.vma_interval_tree_remove
>> >       0.56 =C2=B1  2%      -0.1        0.50            -0.1        0.5=
0
>> >  perf-profile.children.cycles-pp.lock_vma_under_rcu
>> >       0.46 =C2=B1  2%      -0.1        0.40 =C2=B1  2%      -0.1      =
  0.41 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.vm_area_dup
>> >       0.57 =C2=B1  2%      -0.1        0.52            -0.0        0.5=
3
>> >  perf-profile.children.cycles-pp.native_irq_return_iret
>> >       0.47 =C2=B1  2%      -0.1        0.42            -0.0        0.4=
3
>> >  perf-profile.children.cycles-pp.__vfork
>> >       0.40 =C2=B1  3%      -0.1        0.34 =C2=B1  2%      -0.1      =
  0.34 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.folio_add_file_rmap_range
>> >       0.61 =C2=B1  2%      -0.1        0.55            -0.1        0.5=
6
>> >  perf-profile.children.cycles-pp.find_idlest_cpu
>> >       0.42 =C2=B1  2%      -0.1        0.37 =C2=B1  2%      -0.1      =
  0.37
>> >  perf-profile.children.cycles-pp.mas_wr_node_store
>> >       0.39 =C2=B1  3%      -0.1        0.34 =C2=B1  3%      -0.0      =
  0.35
>> >  perf-profile.children.cycles-pp.do_task_dead
>> >       0.34 =C2=B1  4%      -0.1        0.29 =C2=B1  2%      -0.1      =
  0.29 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.do_dentry_open
>> >       0.57 =C2=B1  2%      -0.1        0.52            -0.1        0.5=
1
>> >  perf-profile.children.cycles-pp.copy_page_range
>> >       0.46            -0.1        0.41 =C2=B1  3%      -0.1        0.4=
0 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__fput
>> >       0.44 =C2=B1  4%      -0.1        0.39            -0.0        0.3=
9 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.run_ksoftirqd
>> >       0.57 =C2=B1  3%      -0.1        0.52            -0.1        0.5=
2
>> >  perf-profile.children.cycles-pp.getname_flags
>> >       1.11            -0.0        1.06            -0.0        1.08
>> >  perf-profile.children.cycles-pp.irq_exit_rcu
>> >       0.15 =C2=B1 18%      -0.0        0.10 =C2=B1  6%      -0.1      =
  0.10 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.osq_unlock
>> >       0.39 =C2=B1  4%      -0.0        0.34 =C2=B1  2%      -0.1      =
  0.33
>> >  perf-profile.children.cycles-pp.__rmqueue_pcplist
>> >       0.45            -0.0        0.40            -0.0        0.40 =C2=
=B1  3%
>> >  perf-profile.children.cycles-pp.mas_wr_bnode
>> >       0.42 =C2=B1  4%      -0.0        0.37            -0.0        0.3=
7
>> >  perf-profile.children.cycles-pp.do_cow_fault
>> >       0.45            -0.0        0.40 =C2=B1  3%      -0.0        0.4=
1 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.task_work_run
>> >       0.33 =C2=B1  4%      -0.0        0.28 =C2=B1  2%      -0.0      =
  0.28 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.folio_batch_move_lru
>> >       0.53            -0.0        0.48            -0.0        0.48
>> >  perf-profile.children.cycles-pp.find_idlest_group
>> >       0.55 =C2=B1  2%      -0.0        0.50            -0.1        0.4=
9
>> >  perf-profile.children.cycles-pp.copy_p4d_range
>> >       0.64 =C2=B1  2%      -0.0        0.60 =C2=B1  2%      -0.1      =
  0.59
>> >  perf-profile.children.cycles-pp.mod_objcg_state
>> >       0.57 =C2=B1  2%      -0.0        0.53            -0.1        0.5=
2 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__mmdrop
>> >       0.30 =C2=B1  6%      -0.0        0.25 =C2=B1  3%      -0.0      =
  0.26 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.alloc_thread_stack_node
>> >       0.43 =C2=B1  2%      -0.0        0.38            -0.0        0.3=
9
>> >  perf-profile.children.cycles-pp.__x64_sys_vfork
>> >       0.39 =C2=B1  2%      -0.0        0.34 =C2=B1  2%      -0.0      =
  0.34 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.pte_alloc_one
>> >       0.30 =C2=B1  2%      -0.0        0.26 =C2=B1  3%      -0.0      =
  0.26
>> >  perf-profile.children.cycles-pp.pipe_read
>> >       0.49 =C2=B1  2%      -0.0        0.44            -0.0        0.4=
5
>> >  perf-profile.children.cycles-pp.update_sg_wakeup_stats
>> >       0.42 =C2=B1  2%      -0.0        0.38            -0.0        0.3=
8
>> >  perf-profile.children.cycles-pp.mas_walk
>> >       0.42 =C2=B1  2%      -0.0        0.38 =C2=B1  2%      -0.0      =
  0.37
>> >  perf-profile.children.cycles-pp.__x64_sys_munmap
>> >       0.40            -0.0        0.36 =C2=B1  2%      -0.0        0.3=
6 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.percpu_counter_add_batch
>> >       0.30 =C2=B1  4%      -0.0        0.25 =C2=B1  3%      -0.0      =
  0.26 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.lru_add_drain_cpu
>> >       0.44 =C2=B1  2%      -0.0        0.40 =C2=B1  2%      -0.0      =
  0.39 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.strnlen_user
>> >       0.40 =C2=B1  2%      -0.0        0.36 =C2=B1  2%      -0.0      =
  0.36 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.create_elf_tables
>> >       0.38 =C2=B1  2%      -0.0        0.34 =C2=B1  2%      -0.0      =
  0.34
>> >  perf-profile.children.cycles-pp.__mem_cgroup_charge
>> >       0.37            -0.0        0.32            -0.0        0.32 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.__vm_area_free
>> >       0.29 =C2=B1  4%      -0.0        0.24 =C2=B1  2%      -0.0      =
  0.25 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__do_wait
>> >       0.37            -0.0        0.33            -0.1        0.32
>> >  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>> >       0.30 =C2=B1  4%      -0.0        0.26 =C2=B1  2%      -0.0      =
  0.25 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__rb_insert_augmented
>> >       0.38            -0.0        0.34            -0.0        0.34 =C2=
=B1  3%
>> >  perf-profile.children.cycles-pp.mas_split
>> >       0.44 =C2=B1  2%      -0.0        0.40 =C2=B1  3%      -0.0      =
  0.40 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.alloc_bprm
>> >       0.39 =C2=B1  2%      -0.0        0.35 =C2=B1  2%      -0.0      =
  0.34 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.perf_event_mmap_output
>> >       0.38 =C2=B1  2%      -0.0        0.34 =C2=B1  2%      -0.0      =
  0.35 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.setup_arg_pages
>> >       0.41 =C2=B1  2%      -0.0        0.37 =C2=B1  2%      -0.0      =
  0.37
>> >  perf-profile.children.cycles-pp.wake_up_new_task
>> >       0.35            -0.0        0.31            -0.0        0.30 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.free_swap_cache
>> >       0.37 =C2=B1  3%      -0.0        0.34 =C2=B1  5%      -0.0      =
  0.33 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.pcpu_alloc
>> >       0.43            -0.0        0.39            -0.0        0.39 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.get_arg_page
>> >       0.29 =C2=B1  4%      -0.0        0.25 =C2=B1  3%      -0.0      =
  0.26 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.lru_add_drain
>> >       0.31 =C2=B1  5%      -0.0        0.27 =C2=B1  2%      -0.0      =
  0.28 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.ksys_write
>> >       0.33 =C2=B1  3%      -0.0        0.29 =C2=B1  2%      -0.0      =
  0.29 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.free_unref_page_commit
>> >       0.61 =C2=B1  2%      -0.0        0.57            -0.0        0.5=
8
>> >  perf-profile.children.cycles-pp.finish_task_switch
>> >       0.36            -0.0        0.32            -0.0        0.32 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.get_user_pages_remote
>> >       0.37 =C2=B1  2%      -0.0        0.33 =C2=B1  2%      -0.0      =
  0.34 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.mtree_range_walk
>> >       0.35            -0.0        0.32            -0.0        0.31 =C2=
=B1  2%
>> >  perf-profile.children.cycles-pp.__get_user_pages
>> >       0.24 =C2=B1  2%      -0.0        0.20 =C2=B1  3%      -0.0      =
  0.21 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__fxstat64
>> >       0.32 =C2=B1  2%      -0.0        0.28 =C2=B1  3%      -0.0      =
  0.29 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.shift_arg_pages
>> >       0.39 =C2=B1  2%      -0.0        0.36            -0.0        0.3=
6 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.sched_exec
>> >       0.42 =C2=B1  2%      -0.0        0.39 =C2=B1  2%      -0.0      =
  0.39 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__cond_resched
>> >       0.26 =C2=B1  2%      -0.0        0.23 =C2=B1  3%      -0.0      =
  0.24 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__mod_lruvec_page_state
>> >       0.30 =C2=B1  2%      -0.0        0.26 =C2=B1  3%      -0.0      =
  0.26 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__pte_alloc
>> >       0.19 =C2=B1  5%      -0.0        0.16 =C2=B1  4%      -0.0      =
  0.16
>> >  perf-profile.children.cycles-pp.d_path
>> >       0.36 =C2=B1  2%      -0.0        0.32            -0.0        0.3=
3 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__pte_offset_map_lock
>> >       0.27 =C2=B1  3%      -0.0        0.24 =C2=B1  3%      -0.0      =
  0.24 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
>> >       0.30 =C2=B1  3%      -0.0        0.27 =C2=B1  2%      -0.0      =
  0.27 =C2=B1  3%
>> >  perf-profile.children.cycles-pp._IO_padn
>> >       0.34            -0.0        0.31 =C2=B1  2%      -0.0        0.3=
0 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__perf_sw_event
>> >       0.18 =C2=B1  3%      -0.0        0.15 =C2=B1  4%      -0.0      =
  0.16 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__do_sys_newfstat
>> >       0.29            -0.0        0.26 =C2=B1  3%      -0.0        0.2=
6 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.anon_vma_fork
>> >       0.25            -0.0        0.22 =C2=B1  3%      -0.0        0.2=
2 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.__wp_page_copy_user
>> >       0.39 =C2=B1  3%      -0.0        0.36 =C2=B1  3%      -0.0      =
  0.36
>> >  perf-profile.children.cycles-pp.strncpy_from_user
>> >       0.28 =C2=B1  2%      -0.0        0.25            -0.0        0.2=
6 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.write
>> >       0.25 =C2=B1  4%      -0.0        0.22 =C2=B1  2%      -0.0      =
  0.23 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.free_pcppages_bulk
>> >       0.34 =C2=B1  2%      -0.0        0.31            -0.0        0.3=
1
>> >  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
>> >       0.31 =C2=B1  3%      -0.0        0.28 =C2=B1  2%      -0.0      =
  0.28 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.get_unmapped_area
>> >       0.26 =C2=B1  2%      -0.0        0.24 =C2=B1  5%      -0.0      =
  0.24 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.memset_orig
>> >       0.24 =C2=B1  2%      -0.0        0.21 =C2=B1  4%      -0.0      =
  0.21 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
>> >       0.21 =C2=B1  3%      -0.0        0.18 =C2=B1  2%      -0.0      =
  0.18 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.map_vdso
>> >       0.28 =C2=B1  2%      -0.0        0.25 =C2=B1  2%      -0.0      =
  0.25 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__anon_vma_prepare
>> >       0.27            -0.0        0.24 =C2=B1  2%      -0.0        0.2=
4 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.mas_next_slot
>> >       0.21 =C2=B1  4%      -0.0        0.19 =C2=B1  3%      -0.0      =
  0.18
>> >  perf-profile.children.cycles-pp.rmqueue_bulk
>> >       0.31 =C2=B1  2%      -0.0        0.28 =C2=B1  2%      -0.0      =
  0.28 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.copy_pte_range
>> >       0.20 =C2=B1  5%      -0.0        0.17 =C2=B1  4%      -0.0      =
  0.17 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.__rb_erase_color
>> >       0.27            -0.0        0.24 =C2=B1  3%      -0.0        0.2=
4 =C2=B1  2%
>> >  perf-profile.children.cycles-pp._IO_fwrite
>> >       0.21 =C2=B1  2%      -0.0        0.18 =C2=B1  3%      -0.0      =
  0.18 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.free_unref_page_list
>> >       0.57 =C2=B1  2%      -0.0        0.55            -0.0        0.5=
4
>> >  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
>> >       0.25 =C2=B1  2%      -0.0        0.23 =C2=B1  3%      -0.0      =
  0.22 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__close
>> >       0.27 =C2=B1  3%      -0.0        0.24 =C2=B1  2%      -0.0      =
  0.24 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.copy_string_kernel
>> >       0.16 =C2=B1  4%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.13 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
>> >       0.11 =C2=B1  6%      -0.0        0.08 =C2=B1  5%      -0.0      =
  0.09 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.security_file_open
>> >       0.21 =C2=B1  4%      -0.0        0.18 =C2=B1  3%      -0.0      =
  0.18 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.wait_task_zombie
>> >       0.16 =C2=B1  4%      -0.0        0.13 =C2=B1  5%      -0.0      =
  0.13 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.wmemchr
>> >       0.17 =C2=B1  4%      -0.0        0.15 =C2=B1  2%      -0.0      =
  0.16 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.release_task
>> >       0.22 =C2=B1  4%      -0.0        0.20 =C2=B1  3%      -0.0      =
  0.20 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.rep_stos_alternative
>> >       0.18 =C2=B1  3%      -0.0        0.16 =C2=B1  4%      -0.0      =
  0.16 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.memmove
>> >       0.36 =C2=B1  2%      -0.0        0.33            -0.0        0.3=
3
>> >  perf-profile.children.cycles-pp.___perf_sw_event
>> >       0.22 =C2=B1  2%      -0.0        0.19 =C2=B1  2%      -0.0      =
  0.19 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.anon_vma_clone
>> >       0.19 =C2=B1  4%      -0.0        0.17 =C2=B1  3%      -0.0      =
  0.16 =C2=B1  4%
>> >  perf-profile.children.cycles-pp._exit
>> >       0.23 =C2=B1  4%      -0.0        0.21            -0.0        0.2=
1 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.mas_alloc_nodes
>> >       0.22 =C2=B1  2%      -0.0        0.20 =C2=B1  2%      -0.0      =
  0.19 =C2=B1  2%
>> >  perf-profile.children.cycles-pp._copy_to_iter
>> >       0.12 =C2=B1  5%      -0.0        0.10 =C2=B1  5%      -0.0      =
  0.10 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.vfs_fstat
>> >       0.20 =C2=B1  2%      -0.0        0.17 =C2=B1  2%      -0.0      =
  0.18 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__install_special_mapping
>> >       0.26            -0.0        0.23 =C2=B1  2%      -0.0        0.2=
3 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.try_charge_memcg
>> >       0.20 =C2=B1  3%      -0.0        0.17 =C2=B1  3%      -0.0      =
  0.17 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__close_nocancel
>> >       0.19 =C2=B1  4%      -0.0        0.17 =C2=B1  2%      -0.0      =
  0.17 =C2=B1  3%
>> >  perf-profile.children.cycles-pp._IO_file_xsputn
>> >       0.10 =C2=B1  6%      -0.0        0.08 =C2=B1  6%      -0.0      =
  0.08 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.apparmor_file_open
>> >       0.20 =C2=B1  4%      -0.0        0.18 =C2=B1  5%      -0.0      =
  0.18 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.schedule_tail
>> >       0.24            -0.0        0.22 =C2=B1  3%      -0.0        0.2=
2 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__x64_sys_close
>> >       0.18 =C2=B1  2%      -0.0        0.16 =C2=B1  2%      -0.0      =
  0.16 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.mas_store
>> >       0.28 =C2=B1  4%      -0.0        0.26 =C2=B1  3%      -0.0      =
  0.25 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.cgroup_rstat_updated
>> >       0.22 =C2=B1  4%      -0.0        0.20 =C2=B1  4%      -0.0      =
  0.20 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.vm_unmapped_area
>> >       0.21 =C2=B1  2%      -0.0        0.19 =C2=B1  4%      -0.0      =
  0.19 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__pmd_alloc
>> >       0.25 =C2=B1  3%      -0.0        0.23 =C2=B1  2%      -0.0      =
  0.23 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.___slab_alloc
>> >       0.20 =C2=B1  3%      -0.0        0.18 =C2=B1  4%      -0.0      =
  0.18 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.do_open_execat
>> >       0.14 =C2=B1  4%      -0.0        0.12 =C2=B1  2%      -0.0      =
  0.13 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
>> >       0.14 =C2=B1  2%      -0.0        0.12            -0.0        0.1=
2 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__sysconf
>> >       0.20 =C2=B1  3%      -0.0        0.18 =C2=B1  2%      -0.0      =
  0.18 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.malloc
>> >       0.16 =C2=B1  4%      -0.0        0.14 =C2=B1  3%      -0.0      =
  0.14 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.brk
>> >       0.13 =C2=B1  5%      -0.0        0.10 =C2=B1  6%      -0.0      =
  0.11 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__do_fault
>> >       0.13 =C2=B1  4%      -0.0        0.11 =C2=B1  4%      -0.0      =
  0.11 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.__unfreeze_partials
>> >       0.29 =C2=B1  2%      -0.0        0.27 =C2=B1  2%      -0.0      =
  0.26
>> >  perf-profile.children.cycles-pp.flush_tlb_mm_range
>> >       0.14 =C2=B1  5%      -0.0        0.12 =C2=B1  5%      -0.0      =
  0.12
>> >  perf-profile.children.cycles-pp.prepend_path
>> >       0.16 =C2=B1  3%      -0.0        0.14 =C2=B1  3%      -0.0      =
  0.15 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.do_brk_flags
>> >       0.23 =C2=B1  3%      -0.0        0.22 =C2=B1  3%      -0.0      =
  0.21 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.filemap_read
>> >       0.16 =C2=B1  2%      -0.0        0.14 =C2=B1  3%      -0.0      =
  0.15 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.move_page_tables
>> >       0.22 =C2=B1  2%      -0.0        0.20 =C2=B1  3%      -0.0      =
  0.19 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.copy_page_to_iter
>> >       0.07 =C2=B1  4%      -0.0        0.05 =C2=B1  8%      -0.0      =
  0.05 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.apparmor_bprm_creds_for_exec
>> >       0.19 =C2=B1  3%      -0.0        0.17 =C2=B1  3%      -0.0      =
  0.17 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>> >       0.12 =C2=B1  3%      -0.0        0.10 =C2=B1  3%      -0.0      =
  0.10 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.__exit_signal
>> >       0.28 =C2=B1  3%      -0.0        0.26 =C2=B1  3%      -0.0      =
  0.25 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__percpu_counter_sum
>> >       0.14 =C2=B1  3%      -0.0        0.12 =C2=B1  3%      -0.0      =
  0.12 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.open_exec
>> >       0.10 =C2=B1  5%      -0.0        0.08 =C2=B1  5%      -0.0      =
  0.08 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.wait_for_completion_state
>> >       0.18 =C2=B1  2%      -0.0        0.17 =C2=B1  4%      -0.0      =
  0.16 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__pud_alloc
>> >       0.12 =C2=B1  3%      -0.0        0.11 =C2=B1  4%      -0.0      =
  0.10 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.alloc_fd
>> >       0.07 =C2=B1  6%      -0.0        0.06 =C2=B1  9%      -0.0      =
  0.06 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.security_bprm_creds_for_exec
>> >       0.17 =C2=B1  3%      -0.0        0.15 =C2=B1  3%      -0.0      =
  0.15 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.exit_notify
>> >       0.18 =C2=B1  3%      -0.0        0.16 =C2=B1  3%      -0.0      =
  0.16 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.memcg_account_kmem
>> >       0.10 =C2=B1  4%      -0.0        0.08            -0.0        0.0=
9 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.schedule_timeout
>> >       0.14 =C2=B1  3%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.13 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__do_sys_brk
>> >       0.14 =C2=B1  3%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.13 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.generic_file_write_iter
>> >       0.15 =C2=B1  3%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.14 =C2=B1  3%
>> >  perf-profile.children.cycles-pp._copy_from_user
>> >       0.15 =C2=B1  4%      -0.0        0.13 =C2=B1  4%      -0.0      =
  0.13 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.__put_anon_vma
>> >       0.15 =C2=B1  4%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.14 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.insert_vm_struct
>> >       0.09 =C2=B1  8%      -0.0        0.07 =C2=B1  4%      -0.0      =
  0.07 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.filemap_fault
>> >       0.13 =C2=B1  3%      -0.0        0.11 =C2=B1  2%      -0.0      =
  0.11 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.remove_vma
>> >       0.10 =C2=B1  5%      -0.0        0.08            -0.0        0.0=
8 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.__wait_for_common
>> >       0.27 =C2=B1  2%      -0.0        0.26            -0.0        0.2=
6 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__check_object_size
>> >       0.11 =C2=B1  3%      -0.0        0.10 =C2=B1  5%      -0.0      =
  0.10 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.mas_leaf_max_gap
>> >       0.13 =C2=B1  2%      -0.0        0.12 =C2=B1  5%      -0.0      =
  0.12 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.vma_link
>> >       0.08 =C2=B1  8%      -0.0        0.06 =C2=B1  7%      -0.0      =
  0.07 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.apparmor_mmap_file
>> >       0.15 =C2=B1  4%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.13 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.lru_add_fn
>> >       0.15 =C2=B1  3%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.14 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.free_pgd_range
>> >       0.07 =C2=B1  6%      -0.0        0.05 =C2=B1  8%      -0.0      =
  0.06 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.security_inode_getattr
>> >       0.10 =C2=B1  4%      -0.0        0.09 =C2=B1  5%      -0.0      =
  0.09 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.free_percpu
>> >       0.09 =C2=B1  3%      -0.0        0.08 =C2=B1  5%      -0.0      =
  0.08 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.fput
>> >       0.13 =C2=B1  5%      -0.0        0.12 =C2=B1  4%      -0.0      =
  0.11 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>> >       0.12            -0.0        0.11 =C2=B1  4%      -0.0        0.1=
1 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.mas_push_data
>> >       0.12            -0.0        0.11 =C2=B1  4%      -0.0        0.1=
1 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.task_tick_fair
>> >       0.21 =C2=B1  2%      -0.0        0.20 =C2=B1  2%      -0.0      =
  0.19
>> >  perf-profile.children.cycles-pp.flush_tlb_func
>> >       0.11 =C2=B1  4%      -0.0        0.09 =C2=B1  4%      -0.0      =
  0.10 =C2=B1  5%
>> >  perf-profile.children.cycles-pp._setjmp
>> >       0.22 =C2=B1  2%      -0.0        0.20 =C2=B1  3%      -0.0      =
  0.20
>> >  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>> >       0.11 =C2=B1  4%      -0.0        0.10 =C2=B1  5%      -0.0      =
  0.10
>> >  perf-profile.children.cycles-pp.mas_update_gap
>> >       0.10 =C2=B1  3%      -0.0        0.09 =C2=B1  3%      -0.0      =
  0.09
>> >  perf-profile.children.cycles-pp.__tlb_remove_page_size
>> >       0.11            -0.0        0.10 =C2=B1  4%      -0.0        0.1=
0 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.vm_normal_page
>> >       0.18 =C2=B1  3%      -0.0        0.17 =C2=B1  2%      -0.0      =
  0.16
>> >  perf-profile.children.cycles-pp.native_flush_tlb_one_user
>> >       0.08 =C2=B1  4%      -0.0        0.07 =C2=B1  7%      -0.0      =
  0.07
>> >  perf-profile.children.cycles-pp.cfree
>> >       0.09            -0.0        0.08 =C2=B1  4%      -0.0        0.0=
8 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.evict
>> >       0.11 =C2=B1  4%      -0.0        0.10 =C2=B1  7%      -0.0      =
  0.09 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__kernel_read
>> >       0.08 =C2=B1  4%      -0.0        0.07 =C2=B1  8%      -0.0      =
  0.07
>> >  perf-profile.children.cycles-pp.get_zeroed_page
>> >       0.07            -0.0        0.06            -0.0        0.06 =C2=
=B1  5%
>> >  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
>> >       0.10 =C2=B1  5%      -0.0        0.09 =C2=B1  5%      -0.0      =
  0.08 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.__p4d_alloc
>> >       0.14 =C2=B1  3%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.12 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.down_read_trylock
>> >       0.06 =C2=B1  7%      +0.0        0.08 =C2=B1  6%      +0.0      =
  0.07
>> >  perf-profile.children.cycles-pp.select_idle_core
>> >       0.10            +0.0        0.11 =C2=B1  2%      +0.0        0.1=
1 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.wake_affine
>> >       0.07 =C2=B1  5%      +0.0        0.08 =C2=B1  6%      +0.0      =
  0.08 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.irqentry_enter
>> >       0.20 =C2=B1  2%      +0.0        0.22 =C2=B1  4%      +0.0      =
  0.22 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.update_curr
>> >       0.18 =C2=B1  2%      +0.0        0.19 =C2=B1  4%      +0.0      =
  0.19 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>> >       0.08 =C2=B1  5%      +0.0        0.10 =C2=B1  5%      +0.0      =
  0.10 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.wakeup_preempt
>> >       0.14 =C2=B1  3%      +0.0        0.16 =C2=B1  2%      +0.0      =
  0.16 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__update_load_avg_se
>> >       0.27 =C2=B1  2%      +0.0        0.29 =C2=B1  2%      +0.0      =
  0.29
>> >  perf-profile.children.cycles-pp.__call_rcu_common
>> >       0.11 =C2=B1  3%      +0.0        0.13 =C2=B1  3%      +0.0      =
  0.12 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.available_idle_cpu
>> >       0.11 =C2=B1  5%      +0.0        0.12 =C2=B1  5%      +0.0      =
  0.13 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.rwsem_mark_wake
>> >       0.14 =C2=B1  4%      +0.0        0.16 =C2=B1  3%      +0.0      =
  0.16 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
>> >       0.04 =C2=B1 40%      +0.0        0.06 =C2=B1  5%      +0.0      =
  0.06 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.resched_curr
>> >       0.08 =C2=B1  4%      +0.0        0.10 =C2=B1  6%      +0.0      =
  0.10 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__legitimize_mnt
>> >       0.11 =C2=B1  4%      +0.0        0.13 =C2=B1  3%      +0.0      =
  0.13 =C2=B1  5%
>> >  perf-profile.children.cycles-pp.slab_pre_alloc_hook
>> >       0.09 =C2=B1  5%      +0.0        0.11 =C2=B1  3%      +0.0      =
  0.10 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.__smp_call_single_queue
>> >       0.08 =C2=B1  5%      +0.0        0.11 =C2=B1  4%      +0.0      =
  0.10 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.llist_add_batch
>> >       0.17 =C2=B1  4%      +0.0        0.19 =C2=B1  4%      +0.0      =
  0.19 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.update_rq_clock
>> >       0.04 =C2=B1 41%      +0.0        0.07 =C2=B1  6%      +0.0      =
  0.07 =C2=B1  9%
>> >  perf-profile.children.cycles-pp.__filename_parentat
>> >       0.15            +0.0        0.18 =C2=B1  2%      +0.0        0.1=
8 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.find_busiest_queue
>> >       0.48 =C2=B1  2%      +0.0        0.51            +0.0        0.5=
1
>> >  perf-profile.children.cycles-pp.schedule_idle
>> >       0.04 =C2=B1 63%      +0.0        0.07 =C2=B1  6%      +0.0      =
  0.07 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.path_parentat
>> >       0.21 =C2=B1  3%      +0.0        0.24 =C2=B1  3%      +0.0      =
  0.24
>> >  perf-profile.children.cycles-pp.up_read
>> >       0.20 =C2=B1  2%      +0.0        0.24            +0.0        0.2=
4 =C2=B1  4%
>> >  perf-profile.children.cycles-pp._find_next_and_bit
>> >       0.24 =C2=B1  2%      +0.0        0.28 =C2=B1  4%      +0.0      =
  0.27
>> >  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
>> >       0.17 =C2=B1  7%      +0.0        0.20 =C2=B1  4%      +0.0      =
  0.21 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.copy_fs_struct
>> >       0.17 =C2=B1  8%      +0.0        0.21 =C2=B1  4%      +0.0      =
  0.21 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.lockref_get
>> >       0.15 =C2=B1  5%      +0.0        0.19 =C2=B1  2%      +0.0      =
  0.18 =C2=B1  4%
>> >  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>> >       0.64 =C2=B1  2%      +0.0        0.68            +0.0        0.6=
8
>> >  perf-profile.children.cycles-pp.update_load_avg
>> >       0.29 =C2=B1  3%      +0.0        0.33 =C2=B1  2%      +0.0      =
  0.33
>> >  perf-profile.children.cycles-pp.__d_alloc
>> >       0.31 =C2=B1  3%      +0.0        0.35 =C2=B1  2%      +0.0      =
  0.35 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.cpu_util
>> >       0.00            +0.0        0.04 =C2=B1 37%      +0.1        0.0=
5 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.poll_idle
>> >       0.48 =C2=B1  3%      +0.0        0.52 =C2=B1  2%      +0.0      =
  0.52
>> >  perf-profile.children.cycles-pp.enqueue_entity
>> >       0.00            +0.1        0.05            +0.1        0.05
>> >  perf-profile.children.cycles-pp.__d_lookup_unhash
>> >       0.97 =C2=B1  2%      +0.1        1.02            +0.1        1.0=
2
>> >  perf-profile.children.cycles-pp.open64
>> >       0.80            +0.1        0.85            +0.0        0.85
>> >  perf-profile.children.cycles-pp.try_to_wake_up
>> >       0.00            +0.1        0.05 =C2=B1  6%      +0.1        0.0=
5 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.___d_drop
>> >       0.00            +0.1        0.06 =C2=B1 12%      +0.0        0.0=
4 =C2=B1 38%
>> >  perf-profile.children.cycles-pp.__wake_up
>> >       0.24 =C2=B1 13%      +0.1        0.30 =C2=B1  9%      +0.1      =
  0.30 =C2=B1  8%
>> >  perf-profile.children.cycles-pp.exit_fs
>> >       0.62 =C2=B1  2%      +0.1        0.68 =C2=B1  2%      +0.1      =
  0.68
>> >  perf-profile.children.cycles-pp.enqueue_task_fair
>> >       0.70 =C2=B1  2%      +0.1        0.76 =C2=B1  2%      +0.1      =
  0.77
>> >  perf-profile.children.cycles-pp.activate_task
>> >       0.46 =C2=B1  3%      +0.1        0.52 =C2=B1  2%      +0.1      =
  0.52 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.dequeue_entity
>> >       0.00            +0.1        0.06 =C2=B1  7%      +0.1        0.0=
6 =C2=B1  7%
>> >  perf-profile.children.cycles-pp.__d_rehash
>> >       0.74 =C2=B1  2%      +0.1        0.82 =C2=B1  2%      +0.1      =
  0.81
>> >  perf-profile.children.cycles-pp.rwsem_wake
>> >       0.30 =C2=B1  3%      +0.1        0.38 =C2=B1  2%      +0.1      =
  0.37 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.idle_cpu
>> >       0.30 =C2=B1 12%      +0.1        0.37 =C2=B1  8%      +0.1      =
  0.39 =C2=B1  6%
>> >  perf-profile.children.cycles-pp.path_put
>> >       0.65 =C2=B1  2%      +0.1        0.72 =C2=B1  2%      +0.1      =
  0.72 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.wake_up_q
>> >       0.60 =C2=B1  2%      +0.1        0.68            +0.1        0.6=
9
>> >  perf-profile.children.cycles-pp.dequeue_task_fair
>> >       0.60 =C2=B1  2%      +0.1        0.68 =C2=B1  2%      +0.1      =
  0.68
>> >  perf-profile.children.cycles-pp.ttwu_do_activate
>> >       0.28 =C2=B1  3%      +0.1        0.37            +0.1        0.3=
7
>> >  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
>> >       0.71 =C2=B1  2%      +0.1        0.81 =C2=B1  2%      +0.1      =
  0.81 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.unlinkat
>> >       0.70 =C2=B1  2%      +0.1        0.80            +0.1        0.8=
0 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.do_unlinkat
>> >       0.70 =C2=B1  2%      +0.1        0.80 =C2=B1  2%      +0.1      =
  0.80 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__x64_sys_unlinkat
>> >       0.12 =C2=B1  4%      +0.1        0.22 =C2=B1  4%      +0.1      =
  0.22 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.__d_add
>> >       0.25 =C2=B1  9%      +0.1        0.36 =C2=B1 15%      +0.1      =
  0.36 =C2=B1 13%
>> >  perf-profile.children.cycles-pp._raw_spin_lock_irq
>> >       0.13 =C2=B1  3%      +0.1        0.23 =C2=B1  5%      +0.1      =
  0.23 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.simple_lookup
>> >       0.62 =C2=B1  2%      +0.1        0.73 =C2=B1  2%      +0.1      =
  0.73 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.sched_ttwu_pending
>> >       0.40 =C2=B1  3%      +0.1        0.52 =C2=B1  2%      +0.1      =
  0.54 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.lockref_put_return
>> >       0.73 =C2=B1  2%      +0.1        0.87 =C2=B1  2%      +0.1      =
  0.87 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>> >       0.75 =C2=B1  2%      +0.1        0.89 =C2=B1  2%      +0.1      =
  0.89 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__sysvec_call_function_single
>> >       0.88 =C2=B1  2%      +0.2        1.04 =C2=B1  2%      +0.2      =
  1.05
>> >  perf-profile.children.cycles-pp.sysvec_call_function_single
>> >       0.84 =C2=B1  4%      +0.2        1.07 =C2=B1  2%      +0.2      =
  1.06 =C2=B1  3%
>> >  perf-profile.children.cycles-pp.lookup_open
>> >       1.76            +0.4        2.15            +0.4        2.16
>> >  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>> >       2.74 =C2=B1  2%      +0.4        3.17            +0.5        3.1=
9
>> >  perf-profile.children.cycles-pp.acpi_idle_enter
>> >       2.72 =C2=B1  2%      +0.4        3.16            +0.5        3.1=
8
>> >  perf-profile.children.cycles-pp.acpi_safe_halt
>> >       2.42 =C2=B1  2%      +0.4        2.87            +0.5        2.8=
9
>> >  perf-profile.children.cycles-pp.update_sg_lb_stats
>> >       2.85 =C2=B1  2%      +0.5        3.30            +0.5        3.3=
2
>> >  perf-profile.children.cycles-pp.cpuidle_enter
>> >       2.84 =C2=B1  2%      +0.5        3.29            +0.5        3.3=
2
>> >  perf-profile.children.cycles-pp.cpuidle_enter_state
>> >       2.62 =C2=B1  2%      +0.5        3.08            +0.5        3.1=
1
>> >  perf-profile.children.cycles-pp.update_sd_lb_stats
>> >       2.65 =C2=B1  2%      +0.5        3.12            +0.5        3.1=
5
>> >  perf-profile.children.cycles-pp.find_busiest_group
>> >       3.08 =C2=B1  2%      +0.5        3.56            +0.5        3.5=
8
>> >  perf-profile.children.cycles-pp.cpuidle_idle_call
>> >       3.63 =C2=B1  2%      +0.5        4.14            +0.5        4.1=
6
>> >  perf-profile.children.cycles-pp.start_secondary
>> >       3.68            +0.5        4.20            +0.5        4.22
>> >  perf-profile.children.cycles-pp.do_idle
>> >       3.68            +0.5        4.20            +0.5        4.23
>> >  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>> >       3.68            +0.5        4.20            +0.5        4.23
>> >  perf-profile.children.cycles-pp.cpu_startup_entry
>> >       3.52 =C2=B1  2%      +0.6        4.13            +0.6        4.1=
7
>> >  perf-profile.children.cycles-pp.load_balance
>> >       3.83 =C2=B1  2%      +0.7        4.49            +0.7        4.5=
3
>> >  perf-profile.children.cycles-pp.newidle_balance
>> >       3.87 =C2=B1  2%      +0.7        4.56            +0.7        4.5=
9
>> >  perf-profile.children.cycles-pp.pick_next_task_fair
>> >       5.75 =C2=B1  2%      +0.8        6.56            +0.9        6.6=
1
>> >  perf-profile.children.cycles-pp.__schedule
>> >       4.84 =C2=B1  2%      +0.8        5.68            +0.9        5.7=
1
>> >  perf-profile.children.cycles-pp.schedule
>> >       3.06            +0.9        3.92            +0.9        3.96
>> >  perf-profile.children.cycles-pp.filename_lookup
>> >       3.04            +0.9        3.90            +0.9        3.94
>> >  perf-profile.children.cycles-pp.path_lookupat
>> >       3.20 =C2=B1  2%      +0.9        4.07            +0.9        4.1=
1
>> >  perf-profile.children.cycles-pp.__do_sys_newstat
>> >       3.06            +0.9        3.95            +0.9        3.99
>> >  perf-profile.children.cycles-pp.vfs_statx
>> >       3.85 =C2=B1  2%      +1.0        4.83            +1.0        4.8=
5
>> >  perf-profile.children.cycles-pp.schedule_preempt_disabled
>> >       3.93 =C2=B1  2%      +1.0        4.95            +1.1        4.9=
9 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.open_last_lookups
>> >       3.83 =C2=B1  2%      +1.2        5.03            +1.2        5.0=
6
>> >  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>> >       3.95 =C2=B1  2%      +1.2        5.19            +1.3        5.2=
2
>> >  perf-profile.children.cycles-pp.down_read
>> >      79.53            +1.4       80.88            +1.3       80.83
>> >  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>> >      79.47            +1.4       80.83            +1.3       80.78
>> >  perf-profile.children.cycles-pp.do_syscall_64
>> >      12.18 =C2=B1  2%      +1.6       13.75            +1.6       13.8=
1
>> >  perf-profile.children.cycles-pp.__lookup_slow
>> >      12.81 =C2=B1  3%      +1.7       14.51            +1.8       14.5=
7
>> >  perf-profile.children.cycles-pp.d_alloc_parallel
>> >       3.61 =C2=B1  2%      +2.7        6.36            +2.8        6.4=
0
>> >  perf-profile.children.cycles-pp.lookup_fast
>> >       3.18 =C2=B1  3%      +2.9        6.06            +2.9        6.1=
0 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.__legitimize_path
>> >       3.19 =C2=B1  3%      +2.9        6.08            +2.9        6.1=
2 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.try_to_unlazy
>> >       3.30 =C2=B1  3%      +3.0        6.29            +3.0        6.3=
3 =C2=B1  2%
>> >  perf-profile.children.cycles-pp.lockref_get_not_dead
>> >       3.87 =C2=B1  2%      +3.2        7.08            +3.3        7.1=
4
>> >  perf-profile.children.cycles-pp.d_alloc
>> >       3.59 =C2=B1  2%      +3.2        6.84            +3.3        6.8=
8
>> >  perf-profile.children.cycles-pp.terminate_walk
>> >       3.58 =C2=B1  3%      +3.5        7.12            +3.6        7.1=
5
>> >  perf-profile.children.cycles-pp.__dentry_kill
>> >       2.41 =C2=B1  2%      +5.2        7.63            +5.3        7.7=
2
>> >  perf-profile.children.cycles-pp.step_into
>> >      18.36 =C2=B1  2%      +5.6       23.91            +5.7       24.0=
2
>> >  perf-profile.children.cycles-pp.walk_component
>> >      14.80 =C2=B1  3%      +6.7       21.46            +6.8       21.6=
1
>> >  perf-profile.children.cycles-pp.dput
>> >       7.37 =C2=B1  3%      +6.9       14.29            +7.0       14.4=
1
>> >  perf-profile.children.cycles-pp.fast_dput
>> >      20.08 =C2=B1  2%     +10.1       30.14           +10.2       30.3=
2
>> >  perf-profile.children.cycles-pp.link_path_walk
>> >      20.56 =C2=B1  3%     +12.7       33.26           +12.9       33.4=
9
>> >  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>> >      21.57 =C2=B1  2%     +12.8       34.40           +13.1       34.6=
3
>> >  perf-profile.children.cycles-pp._raw_spin_lock
>> >      28.15 =C2=B1  2%     +13.1       41.26           +13.3       41.5=
0
>> >  perf-profile.children.cycles-pp.__x64_sys_openat
>> >      28.13 =C2=B1  2%     +13.1       41.25           +13.4       41.4=
8
>> >  perf-profile.children.cycles-pp.do_sys_openat2
>> >      27.50 =C2=B1  2%     +13.2       40.65           +13.4       40.8=
9
>> >  perf-profile.children.cycles-pp.do_filp_open
>> >      27.42 =C2=B1  2%     +13.2       40.59           +13.4       40.8=
2
>> >  perf-profile.children.cycles-pp.path_openat
>> >      16.38 =C2=B1  8%      -8.8        7.61 =C2=B1  7%      -9.1      =
  7.28 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.osq_lock
>> >       1.46            -0.3        1.12            -0.3        1.11
>> >  perf-profile.self.cycles-pp.rwsem_spin_on_owner
>> >       2.54 =C2=B1  2%      -0.3        2.21 =C2=B1  2%      -0.3      =
  2.21
>> >  perf-profile.self.cycles-pp.next_uptodate_folio
>> >       1.61            -0.2        1.42            -0.2        1.42
>> >  perf-profile.self.cycles-pp.vma_interval_tree_insert
>> >       0.95 =C2=B1  3%      -0.1        0.80 =C2=B1  2%      -0.1      =
  0.81
>> >  perf-profile.self.cycles-pp.release_pages
>> >       1.06 =C2=B1  2%      -0.1        0.92 =C2=B1  2%      -0.1      =
  0.92
>> >  perf-profile.self.cycles-pp.page_remove_rmap
>> >       0.94 =C2=B1  2%      -0.1        0.80            -0.2        0.7=
8
>> >  perf-profile.self.cycles-pp.up_write
>> >       1.23            -0.1        1.11            -0.1        1.12
>> >  perf-profile.self.cycles-pp._dl_addr
>> >       0.60 =C2=B1  3%      -0.1        0.48 =C2=B1  3%      -0.1      =
  0.48 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.apparmor_file_alloc_security
>> >       0.94 =C2=B1  2%      -0.1        0.82 =C2=B1  2%      -0.1      =
  0.83
>> >  perf-profile.self.cycles-pp.filemap_map_pages
>> >       0.19 =C2=B1  2%      -0.1        0.08 =C2=B1  6%      -0.1      =
  0.08 =C2=B1  6%
>> >  perf-profile.self.cycles-pp._raw_spin_trylock
>> >       0.73 =C2=B1  2%      -0.1        0.63 =C2=B1  2%      -0.1      =
  0.64
>> >  perf-profile.self.cycles-pp.down_write
>> >       0.78 =C2=B1  2%      -0.1        0.68 =C2=B1  2%      -0.1      =
  0.68 =C2=B1  2%
>> >  perf-profile.self.cycles-pp._compound_head
>> >       0.40 =C2=B1  4%      -0.1        0.31 =C2=B1  2%      -0.1      =
  0.31 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.apparmor_file_free_security
>> >       0.85 =C2=B1  2%      -0.1        0.76            -0.1        0.7=
6
>> >  perf-profile.self.cycles-pp.zap_pte_range
>> >       0.99            -0.1        0.91            -0.1        0.92
>> >  perf-profile.self.cycles-pp.kmem_cache_free
>> >       0.92 =C2=B1  2%      -0.1        0.84            -0.1        0.8=
5
>> >  perf-profile.self.cycles-pp.__slab_free
>> >       0.49            -0.1        0.42 =C2=B1  2%      -0.1        0.4=
2 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.clear_page_erms
>> >       0.78            -0.1        0.71            -0.1        0.71
>> >  perf-profile.self.cycles-pp.__strcoll_l
>> >       0.58 =C2=B1  3%      -0.1        0.52            -0.1        0.5=
2 =C2=B1  2%
>> >  perf-profile.self.cycles-pp._IO_default_xsputn
>> >       0.58            -0.1        0.51            -0.1        0.52
>> >  perf-profile.self.cycles-pp.sync_regs
>> >       0.59 =C2=B1  2%      -0.1        0.52            -0.1        0.5=
3 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.kmem_cache_alloc
>> >       0.54 =C2=B1  2%      -0.1        0.48            -0.1        0.4=
8 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.vma_interval_tree_remove
>> >       0.37 =C2=B1  3%      -0.1        0.31            -0.1        0.3=
1 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.folio_add_file_rmap_range
>> >       0.57 =C2=B1  2%      -0.1        0.52            -0.0        0.5=
3
>> >  perf-profile.self.cycles-pp.native_irq_return_iret
>> >       0.15 =C2=B1 18%      -0.1        0.10 =C2=B1  7%      -0.1      =
  0.09 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.osq_unlock
>> >       0.47            -0.0        0.42            -0.0        0.42
>> >  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
>> >       0.27 =C2=B1 23%      -0.0        0.23 =C2=B1 17%      -0.1      =
  0.22 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.__handle_mm_fault
>> >       0.47 =C2=B1  3%      -0.0        0.43 =C2=B1  2%      -0.0      =
  0.43 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.lockref_get_not_dead
>> >       0.18 =C2=B1  3%      -0.0        0.14 =C2=B1  5%      -0.0      =
  0.14 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
>> >       0.43 =C2=B1  2%      -0.0        0.39 =C2=B1  2%      -0.0      =
  0.38 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.strnlen_user
>> >       0.28 =C2=B1  3%      -0.0        0.24            -0.0        0.2=
4
>> >  perf-profile.self.cycles-pp.__rb_insert_augmented
>> >       0.52 =C2=B1  2%      -0.0        0.48 =C2=B1  2%      -0.0      =
  0.48 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.mod_objcg_state
>> >       0.36 =C2=B1  2%      -0.0        0.32 =C2=B1  3%      -0.0      =
  0.33 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.mtree_range_walk
>> >       0.32            -0.0        0.28 =C2=B1  2%      -0.0        0.2=
7
>> >  perf-profile.self.cycles-pp.free_swap_cache
>> >       0.36 =C2=B1  2%      -0.0        0.32 =C2=B1  2%      -0.0      =
  0.32 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.percpu_counter_add_batch
>> >       0.43 =C2=B1  2%      -0.0        0.39            -0.0        0.3=
9 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.update_sg_wakeup_stats
>> >       0.29 =C2=B1  3%      -0.0        0.26            -0.0        0.2=
6 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.set_pte_range
>> >       0.24 =C2=B1  2%      -0.0        0.21 =C2=B1  3%      -0.0      =
  0.21 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
>> >       0.28 =C2=B1  3%      -0.0        0.25 =C2=B1  2%      -0.0      =
  0.24 =C2=B1  2%
>> >  perf-profile.self.cycles-pp._IO_padn
>> >       0.25 =C2=B1  2%      -0.0        0.22 =C2=B1  4%      -0.0      =
  0.22 =C2=B1  3%
>> >  perf-profile.self.cycles-pp._IO_fwrite
>> >       0.25 =C2=B1  2%      -0.0        0.23 =C2=B1  4%      -0.0      =
  0.23 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.memset_orig
>> >       0.56 =C2=B1  2%      -0.0        0.54            -0.0        0.5=
3
>> >  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
>> >       0.10 =C2=B1  6%      -0.0        0.08 =C2=B1  4%      -0.0      =
  0.08 =C2=B1  9%
>> >  perf-profile.self.cycles-pp.apparmor_file_open
>> >       0.24            -0.0        0.22 =C2=B1  3%      -0.0        0.2=
2 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.mas_next_slot
>> >       0.18 =C2=B1  5%      -0.0        0.15 =C2=B1  5%      -0.0      =
  0.15 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.__rb_erase_color
>> >       0.30 =C2=B1  2%      -0.0        0.27            -0.0        0.2=
7 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.___perf_sw_event
>> >       0.19 =C2=B1  2%      -0.0        0.17 =C2=B1  3%      -0.0      =
  0.17 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.mas_wr_node_store
>> >       0.26 =C2=B1  4%      -0.0        0.24 =C2=B1  3%      -0.0      =
  0.23 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.cgroup_rstat_updated
>> >       0.20            -0.0        0.18 =C2=B1  3%      -0.0        0.1=
8 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.perf_event_mmap_output
>> >       0.21 =C2=B1  3%      -0.0        0.19 =C2=B1  3%      -0.0      =
  0.18 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.mmap_region
>> >       0.15 =C2=B1  5%      -0.0        0.13 =C2=B1  3%      -0.0      =
  0.13 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
>> >       0.21 =C2=B1  3%      -0.0        0.20 =C2=B1  3%      -0.0      =
  0.20 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.__cond_resched
>> >       0.06 =C2=B1  5%      -0.0        0.04 =C2=B1 37%      -0.0      =
  0.05 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.entry_SYSCALL_64
>> >       0.23 =C2=B1  2%      -0.0        0.21 =C2=B1  3%      -0.0      =
  0.20 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.try_charge_memcg
>> >       0.16 =C2=B1  3%      -0.0        0.14 =C2=B1  4%      -0.0      =
  0.14 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.strncpy_from_user
>> >       0.15 =C2=B1  3%      -0.0        0.13 =C2=B1  2%      -0.0      =
  0.13 =C2=B1  3%
>> >  perf-profile.self.cycles-pp._copy_from_user
>> >       0.11 =C2=B1  4%      -0.0        0.10 =C2=B1  7%      -0.0      =
  0.10 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.__mod_lruvec_page_state
>> >       0.12 =C2=B1  5%      -0.0        0.10 =C2=B1  4%      -0.0      =
  0.11 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.__get_user_8
>> >       0.07 =C2=B1  6%      -0.0        0.06 =C2=B1  5%      -0.0      =
  0.06 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.apparmor_mmap_file
>> >       0.14 =C2=B1  2%      -0.0        0.12 =C2=B1  4%      -0.0      =
  0.12 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.handle_mm_fault
>> >       0.12 =C2=B1  3%      -0.0        0.11            -0.0        0.1=
1 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.mas_walk
>> >       0.08 =C2=B1  6%      -0.0        0.06 =C2=B1  7%      -0.0      =
  0.07 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.__split_vma
>> >       0.09            -0.0        0.08 =C2=B1  6%      -0.0        0.0=
8 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.vm_area_dup
>> >       0.08            -0.0        0.07            -0.0        0.07 =C2=
=B1  5%
>> >  perf-profile.self.cycles-pp.getenv
>> >       0.18 =C2=B1  4%      -0.0        0.17 =C2=B1  2%      -0.0      =
  0.16
>> >  perf-profile.self.cycles-pp.native_flush_tlb_one_user
>> >       0.07 =C2=B1  6%      -0.0        0.06 =C2=B1  7%      -0.0      =
  0.06
>> >  perf-profile.self.cycles-pp.__libc_fork
>> >       0.05 =C2=B1  8%      +0.0        0.06            +0.0        0.0=
6 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.pick_next_task_fair
>> >       0.13 =C2=B1  3%      +0.0        0.14 =C2=B1  3%      +0.0      =
  0.15 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.__update_load_avg_se
>> >       0.09 =C2=B1  5%      +0.0        0.10 =C2=B1  4%      +0.0      =
  0.10
>> >  perf-profile.self.cycles-pp.dequeue_task_fair
>> >       0.16 =C2=B1  3%      +0.0        0.17 =C2=B1  4%      +0.0      =
  0.18 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.update_sd_lb_stats
>> >       0.06 =C2=B1  8%      +0.0        0.07 =C2=B1  4%      +0.0      =
  0.07 =C2=B1  4%
>> >  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
>> >       0.04 =C2=B1 40%      +0.0        0.06 =C2=B1  5%      +0.0      =
  0.06 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.resched_curr
>> >       0.13 =C2=B1  4%      +0.0        0.15 =C2=B1  3%      +0.0      =
  0.15 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.update_rq_clock
>> >       0.14 =C2=B1  3%      +0.0        0.16 =C2=B1  2%      +0.0      =
  0.16 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
>> >       0.10 =C2=B1  4%      +0.0        0.12 =C2=B1  4%      +0.0      =
  0.13 =C2=B1  3%
>> >  perf-profile.self.cycles-pp.load_balance
>> >       0.07 =C2=B1  8%      +0.0        0.09 =C2=B1  4%      +0.0      =
  0.10 =C2=B1  5%
>> >  perf-profile.self.cycles-pp.__legitimize_mnt
>> >       0.13 =C2=B1  3%      +0.0        0.16 =C2=B1  4%      +0.0      =
  0.16 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.find_busiest_queue
>> >       0.08 =C2=B1  5%      +0.0        0.10 =C2=B1  4%      +0.0      =
  0.10 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.llist_add_batch
>> >       0.12 =C2=B1  3%      +0.0        0.15 =C2=B1  3%      +0.0      =
  0.15 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.enqueue_entity
>> >       0.18 =C2=B1  3%      +0.0        0.20 =C2=B1  2%      +0.0      =
  0.20 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.up_read
>> >       0.18 =C2=B1  2%      +0.0        0.21 =C2=B1  2%      +0.0      =
  0.22 =C2=B1  3%
>> >  perf-profile.self.cycles-pp._find_next_and_bit
>> >       0.11 =C2=B1  4%      +0.0        0.15 =C2=B1  3%      +0.0      =
  0.14 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.down_read
>> >       0.27 =C2=B1  3%      +0.0        0.31 =C2=B1  2%      +0.0      =
  0.31
>> >  perf-profile.self.cycles-pp.cpu_util
>> >       0.14 =C2=B1  3%      +0.0        0.19 =C2=B1  3%      +0.0      =
  0.18 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.d_alloc
>> >       0.00            +0.1        0.05 =C2=B1  6%      +0.1        0.0=
5 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.___d_drop
>> >       0.00            +0.1        0.05 =C2=B1  9%      +0.1        0.0=
5 =C2=B1  6%
>> >  perf-profile.self.cycles-pp.__dentry_kill
>> >       0.00            +0.1        0.06 =C2=B1  7%      +0.1        0.0=
6 =C2=B1  7%
>> >  perf-profile.self.cycles-pp.__d_rehash
>> >       0.29 =C2=B1  3%      +0.1        0.36 =C2=B1  2%      +0.1      =
  0.35 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.idle_cpu
>> >       0.39 =C2=B1  3%      +0.1        0.51 =C2=B1  2%      +0.1      =
  0.53 =C2=B1  2%
>> >  perf-profile.self.cycles-pp.lockref_put_return
>> >       1.53            +0.1        1.66            +0.1        1.65
>> >  perf-profile.self.cycles-pp._raw_spin_lock
>> >       0.18 =C2=B1  4%      +0.2        0.38 =C2=B1  2%      +0.2      =
  0.38
>> >  perf-profile.self.cycles-pp.d_alloc_parallel
>> >       1.22 =C2=B1  2%      +0.2        1.47            +0.2        1.4=
7
>> >  perf-profile.self.cycles-pp.acpi_safe_halt
>> >       1.75 =C2=B1  2%      +0.3        2.06            +0.3        2.0=
8
>> >  perf-profile.self.cycles-pp.update_sg_lb_stats
>> >      20.28 =C2=B1  3%     +12.6       32.84           +12.8       33.0=
7
>> >  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>> >
>


--=20
Mateusz Guzik <mjguzik gmail.com>

