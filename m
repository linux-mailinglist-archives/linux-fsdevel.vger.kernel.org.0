Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D841D451D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 07:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgEOFVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 01:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbgEOFV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 01:21:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E009C05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 22:21:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id y22so1402802qki.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 22:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=gInxQOdZOaqokdqxXmouDhZhNy2e1yNxXdlP5JHe5/8=;
        b=Pv5wJc2dBTkMyn0XWKnfPG6QWravhpOy13e3l5ajQcVZE02XpA6or1Lv418PNkSF8c
         KGKWzreTfApj5NUq32O8+l+LvAuJSoDi2U02NEHCUymZQODInjdZRgMkFuwjrzOk781r
         sgr2zBsSCPr3TxC8b3CkqgtGpqXLBes3exen6Hv5z7sdrn+1pZb/mnekbjdyqQNrP0lF
         MxnAo6SpPViXTii8XOWZnPTo2xwOicsGCKsOrtUA722uUZjZwjqKrzCJme3Y313WL1Js
         FH8uHOq3yEakFC5EMrWYjXYRx6X6V1s4wYV71IUWa1u3/Vv9ojQXYJTVVTwM07RwlmO6
         dOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=gInxQOdZOaqokdqxXmouDhZhNy2e1yNxXdlP5JHe5/8=;
        b=iQbb79rhiGCgke+D3QxBSZUZ79OLq3Tp0ja0h9d+kAn1v5ij9zFKm14Uk31KtzuL4U
         lfXBvvIYZruQ171sBLZVG2gDP8+a/J8hzkvh5QQhbB62q5gpwIycFOuFP9k0XO2rT6v4
         1/WQ3YjEQwMjEWxUoFJ9C9ThMkKSfq85gtmoilco3Xs4P1CMdnUk3AeVejDxgRyNEpne
         HllCaS9y7BMW1xs1u27spBsVTeK7ELHP4VVLsCpRp9kTUuSTVQQLHZRHUdTMqGDspUQV
         VDScRfg1C63RQClgIkbrLveEfV4Qv+oCl/hRnbBbucLJ8bmBT2bOTaUjyDGyPmBAcYit
         G1cQ==
X-Gm-Message-State: AOAM533KF8Vx1OvewtiYoJ9MCwMBBNai/+nh4hQrBxnu7C2TEWCVlV4O
        r4KKmFHFb2E5Khl3CJdtVFk5pg==
X-Google-Smtp-Source: ABdhPJy1x0nQGnyo0RnmDA/F0BXUsFAm7s+D7XRE251PwLLVwxjjVh6vNRngKL+JTbkxqfl2MtLsqQ==
X-Received: by 2002:a05:620a:a83:: with SMTP id v3mr1760800qkg.456.1589520088371;
        Thu, 14 May 2020 22:21:28 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y21sm841591qkb.95.2020.05.14.22.21.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 22:21:27 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: "BUG: MAX_LOCKDEP_ENTRIES too low" with 6979 "&type->s_umount_key"
Message-Id: <F430E503-F8E9-41B6-B23E-D350FD73359B@lca.pw>
Date:   Fri, 15 May 2020 01:21:26 -0400
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lockdep is screwed here in next-20200514 due to "BUG: =
MAX_LOCKDEP_ENTRIES too low". One of the traces below pointed to this =
linux-next commit,

8c8e824d4ef0 watch_queue: Introduce a non-repeating system-unique =
superblock ID

which was accidentally just showed up in next-20200514 along with,

46896d79c514 watch_queue: Add superblock notifications

I did have here,

CONFIG_SB_NOTIFICATIONS=3Dy
CONFIG_MOUNT_NOTIFICATIONS=3Dy
CONFIG_FSINFO=3Dy

While MAX_LOCKDEP_ENTRIES is 32768, I noticed there is one type of lock =
had a lot along,

# grep  'type->s_umount_key=E2=80=99 /proc/lockdep_chains | wc -l
6979

type->s_umount_key is from alloc_super(),

lockdep_set_class(&s->s_umount, &type->s_umount_key);

Any thought before I bury myself bisecting this?

[15323.316234] LTP: starting isofs (isofs.sh)
[15369.549302] LTP: starting fs_fill
[15369.837565] /dev/zero: Can't open blockdev
[15378.107150] EXT4-fs (loop0): mounting ext3 file system using the ext4 =
subsystem
[15378.180704] EXT4-fs (loop0): mounted filesystem with ordered data =
mode. Opts: (null)
[15378.191630] ext3 filesystem being mounted at =
/tmp/ltp-M6YHxqgN9o/mIisOB/mntpoint supports timestamps until 2038 =
(0x7fffffff)
[15448.581853] EXT4-fs (loop0): mounted filesystem with ordered data =
mode. Opts: (null)
[15448.592515] ext4 filesystem being mounted at =
/tmp/ltp-M6YHxqgN9o/mIisOB/mntpoint supports timestamps until 2038 =
(0x7fffffff)
[15482.370368] XFS (loop0): Mounting V5 Filesystem
[15482.413544] XFS (loop0): Ending clean mount
[15482.427896] xfs filesystem being mounted at =
/tmp/ltp-M6YHxqgN9o/mIisOB/mntpoint supports timestamps until 2038 =
(0x7fffffff)
[15495.280716] XFS (loop0): Unmounting Filesystem
[15613.223513] LTP: starting binfmt_misc01 (binfmt_misc01.sh)
[15615.253089] BUG: MAX_LOCKDEP_ENTRIES too low!
[15615.258178] turning off the locking correctness validator.
[15615.264402] CPU: 4 PID: 80930 Comm: mount Tainted: G           O      =
5.7.0-rc5-next-20200514 #1
[15615.273942] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
[15615.283218] Call Trace:
[15615.286388]  dump_stack+0xa7/0xea
[15615.290429]  alloc_list_entry.cold.37+0x11/0x18
[15615.295689]  __lock_acquire+0x2aad/0x3260
[15615.300428]  ? register_lock_class+0xb90/0xb90
[15615.305603]  ? __kasan_check_read+0x11/0x20
[15615.310514]  ? mark_lock+0x160/0xfe0
[15615.314814]  ? check_chain_key+0x1df/0x2e0
[15615.319637]  ? print_irqtrace_events+0x110/0x110
[15615.324984]  lock_acquire+0x1a2/0x680
[15615.329373]  ? vfs_generate_unique_id+0x23/0x70
[15615.334632]  ? check_flags.part.28+0x220/0x220
[15615.339806]  ? ktime_get+0xf2/0x150
[15615.344016]  ? lockdep_hardirqs_on+0x1b0/0x2c0
[15615.349190]  ? vfs_generate_unique_id+0x14/0x70
[15615.354453]  ? trace_hardirqs_on+0x3a/0x160
[15615.359366]  _raw_spin_lock+0x2f/0x40
[15615.363754]  ? vfs_generate_unique_id+0x23/0x70
[15615.369014]  vfs_generate_unique_id+0x23/0x70
vfs_generate_unique_id at fs/super.c:1890
[15615.374099]  alloc_super+0x531/0x5b0
alloc_super at fs/super.c:286
[15615.378398]  ? alloc_file.cold.7+0x19/0x19
[15615.383220]  sget_fc+0xb9/0x3a0
sget_fc at fs/super.c:539
[15615.387082]  ? compare_single+0x10/0x10
[15615.391645]  ? bm_get_tree+0x20/0x20 [binfmt_misc]
[15615.397167]  vfs_get_super+0x4e/0x1a0
vfs_get_super at fs/super.c:1197
[15615.401554]  get_tree_single+0x13/0x20
[15615.406031]  bm_get_tree+0x15/0x20 [binfmt_misc]
[15615.411380]  vfs_get_tree+0x54/0x150
[15615.415681]  do_mount+0xef4/0x11b0
[15615.419807]  ? copy_mount_string+0x20/0x20
[15615.424630]  ? __kasan_check_write+0x14/0x20
[15615.429630]  ? _copy_from_user+0x95/0xd0
[15615.434282]  ? memdup_user+0x58/0x90
[15615.438579]  __x64_sys_mount+0x100/0x120
[15615.443231]  do_syscall_64+0xcc/0xaf0
[15615.447617]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[15615.452965]  ? syscall_return_slowpath+0x580/0x580
[15615.458487]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[15615.464447]  ? trace_hardirqs_off_caller+0x3a/0x150
[15615.470055]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[15615.475489]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[15615.481271] RIP: 0033:0x7f9721fb79ee
[15615.485572] Code: 48 8b 0d 9d f4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a f4 2b 00 f7 d8 64 89 01 48
[15615.505155] RSP: 002b:00007ffd555d4ac8 EFLAGS: 00000246 ORIG_RAX: =
00000000000000a5
[15615.513474] RAX: ffffffffffffffda RBX: 00005591d34c19c0 RCX: =
00007f9721fb79ee
[15615.521355] RDX: 00005591d34c1ba0 RSI: 00005591d34c38c0 RDI: =
00005591d34c1bc0
[15615.529232] RBP: 00007f9722d63184 R08: 0000000000000000 R09: =
0000000000000003
[15615.537113] R10: 00000000c0ed0000 R11: 0000000000000246 R12: =
0000000000000000
[15615.544991] R13: 00000000c0ed0000 R14: 00005591d34c1bc0 R15: =
00005591d34c1ba0

=3D=3D=3D the second run =3D=3D=3D

[28392.003312] LTP: starting read_all_dev (read_all -d /dev -p -q -r 10)
[28392.125739] BUG: MAX_LOCKDEP_ENTRIES too low!
[28392.131254] turning off the locking correctness validator.
[28392.137568] CPU: 64 PID: 107055 Comm: read_all Tainted: G           O =
L    5.7.0-rc5-next-20200514 #1
[28392.147634] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
[28392.157002] Call Trace:
[28392.160260]  dump_stack+0xa7/0xea
[28392.164390]  alloc_list_entry.cold.37+0x11/0x18
[28392.169745]  __lock_acquire+0x2aad/0x3260
[28392.174820]  ? register_lock_class+0xb90/0xb90
[28392.180208]  ? check_chain_key+0x1df/0x2e0
[28392.185120]  lock_acquire+0x1a2/0x680
[28392.189646]  ? get_random_u32+0x4c/0xe0
[28392.194296]  ? lock_downgrade+0x3e0/0x3e0
[28392.199123]  ? check_flags.part.28+0x220/0x220
[28392.204386]  ? get_random_u32+0x4c/0xe0
[28392.209038]  _raw_spin_lock_irqsave+0x3a/0x50
[28392.214212]  ? get_random_u32+0x4c/0xe0
[28392.218862]  get_random_u32+0x4c/0xe0
get_random_u32 at drivers/char/random.c:2225
[28392.223341]  allocate_slab+0x13e/0x5c0
[28392.227905]  ? memcg_kmem_get_cache+0x378/0x640
[28392.233257]  new_slab+0x46/0x70
[28392.237207]  ___slab_alloc+0x35e/0x810
[28392.241770]  ? rcu_read_lock_sched_held+0xe0/0xe0
[28392.247295]  ? seq_open+0x44/0xd0
[28392.251424]  ? seq_open+0x44/0xd0
[28392.255551]  __slab_alloc+0x43/0x70
[28392.259851]  ? __slab_alloc+0x43/0x70
[28392.264325]  ? seq_open+0x44/0xd0
[28392.268455]  kmem_cache_alloc+0x2e9/0x460
[28392.273281]  seq_open+0x44/0xd0
kmem_cache_zalloc at include/linux/slab.h:661 (discriminator 3)
(inlined by) seq_open at fs/seq_file.c:59 (discriminator 3)
[28392.277233]  kernfs_fop_open+0x2ec/0x720
[28392.281973]  do_dentry_open+0x323/0x870
do_dentry_open at fs/open.c:796
[28392.286625]  ? kernfs_fop_read+0x2c0/0x2c0
[28392.291539]  ? chmod_common+0x280/0x280
[28392.296188]  ? kernfs_iop_permission+0x5d/0x70
[28392.301451]  ? inode_permission+0x65/0x1d0
[28392.306364]  vfs_open+0x58/0x60
[28392.310314]  path_openat+0xbd6/0xf40
[28392.314703]  ? path_lookupat+0x1c0/0x1c0
[28392.319441]  ? register_lock_class+0xb90/0xb90
[28392.324701]  ? match_held_lock+0x20/0x270
[28392.329525]  ? match_held_lock+0x20/0x270
[28392.334351]  ? check_chain_key+0x1df/0x2e0
[28392.339261]  ? find_held_lock+0xca/0xf0
[28392.343910]  do_filp_open+0x11d/0x1a0
[28392.348389]  ? may_open_dev+0x50/0x50
[28392.352865]  ? __kasan_check_read+0x11/0x20
[28392.357866]  ? do_raw_spin_unlock+0xa8/0x140
[28392.362953]  ? _raw_spin_unlock+0x22/0x30
[28392.367780]  do_sys_openat2+0x307/0x420
[28392.372431]  ? file_open_root+0x210/0x210
[28392.377257]  do_sys_open+0x95/0xe0
[28392.381469]  ? filp_open+0x60/0x60
[28392.385683]  ? lockdep_hardirqs_on+0x1b0/0x2c0
[28392.390944]  __x64_sys_openat+0x59/0x70
[28392.395596]  do_syscall_64+0xcc/0xaf0
[28392.400072]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[28392.405510]  ? syscall_return_slowpath+0x580/0x580
[28392.411122]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[28392.417172]  ? trace_hardirqs_off_caller+0x3a/0x150
[28392.422869]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[28392.428394]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[28392.434268] RIP: 0033:0x7f1ad727a2ff
[28392.438658] Code: 52 89 f0 25 00 00 41 00 3d 00 00 41 00 74 44 8b 05 =
56 d1 20 00 85 c0 75 65 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f =
05 <48> 3d 00 f0 ff ff 0f 87 9d 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[28392.458331] RSP: 002b:00007ffd8c461340 EFLAGS: 00000246 ORIG_RAX: =
0000000000000101
[28392.466742] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: =
00007f1ad727a2ff
[28392.474710] RDX: 0000000000000800 RSI: 00007ffd8c461450 RDI: =
00000000ffffff9c=
