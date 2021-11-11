Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F944DCCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 21:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhKKVAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 16:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKVAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:00:11 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4FC061766
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 12:57:22 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id q74so18160456ybq.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 12:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=U+F4MBTOIQOlXiy42tIUZy7RvYU9O5UeOoNuHpFnk6s=;
        b=vImjnwfmqFOJ/39sPTi7MdOvsZ9ciK1HBwAcKQReHcVHv71FaNBngoezWkDML4RddN
         sFW17vJuKW6Gf1U+xhyo1uXF/bdjh54uBLt6jPLhU2OElt9EdCe9h1zC+FH9dyLC2d5h
         YfXSB/iiHxRCX7PxLb2kf6TW9gNI4HbmKkKK4jwSSRRZtKjFZ00IC6rgtJpQG37cd6Wu
         XC1hQohwMsQE2gl7exN226pFtTrjwNrKcFaHAEq/7eX1HQskNzgBBEsirM+EXw6EPO97
         0Mf6qyd7FGRQGM98VmCu/TKFRZ5huwmgn0J8hMzyDwgyC6z77gMTjSthKkfm7FW+apv6
         vj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=U+F4MBTOIQOlXiy42tIUZy7RvYU9O5UeOoNuHpFnk6s=;
        b=oAUZ7O+n/tp6s7syzEySjhiwnbVOxrGbKRcESJCYwBheLV79wfgwDjN4nLm94anAKM
         VNOSXpiDwmuNzC4K56vO/gpCAsJggOeiYmK6dQ4CetHH3YtQzEekUtc1IWJI6KqhEr4D
         3crGkaIEXzo3eFqAML9g9yENcJMdMl7rgOYI6q2k6QSeYe0If+TcLwhZOUH2MhO3zHs6
         Hcw5zJUPgfsqp+MJl3S4fT+INuXDrRCPTImtC0+BD6NPc4gNgBqmvmSZ7sd2vfLGtDAX
         mTJxceQ+KXQzu6JxOnlr/d8IoLqlt0iLXqs53FCKfLn2Z8+jX9XsLqXFOzw2hqlD/8zk
         HdWw==
X-Gm-Message-State: AOAM531Gjc1/iao70GYwEBbaElGzXOLqt955mwxF/fwYbw6mi9t6ezKz
        aPhdBrM1rtFPWzQQahRiviSumzIMAL0fQZWOSEJPRsx0CtLNFSPun68=
X-Google-Smtp-Source: ABdhPJxfJnQgg5gU/cWSUs3Z3nkB8UItjoVPWI6UZySX0pmsNWAx9JYIcXKRI4iZzcdc7Sl2+A49X0Rd/D043KwAAko=
X-Received: by 2002:a25:d9c9:: with SMTP id q192mr10772355ybg.470.1636664240357;
 Thu, 11 Nov 2021 12:57:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
In-Reply-To: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 11 Nov 2021 15:57:04 -0500
Message-ID: <CAJCQCtQ=JsO6bH=vJE2aZDS_7FDq+y-yHFVm4NTaf7QLArWGAw@mail.gmail.com>
Subject: Re: 5.15+, blocked tasks, folio_wait_bit_common
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 3:24 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Soon after logging in and launching some apps, I get a hang. Although
> there's lots of btrfs stuff in the call traces, I think we're stuck in
> writeback so everything else just piles up and it all hangs
> indefinitely.
>
> Happening since at least
> 5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happening with
> 5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64
>
> Full dmesg including sysrq+w when the journal becomes unresponsive and
> then a bunch of block tasks  > 120s roll in on their own.
>
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1841283


[   55.591277] sysrq: Show Blocked State
[  156.375088] sysrq: Show Blocked State
[  156.375267] task:systemd-journal state:D stack:11848 pid:  593
ppid:     1 flags:0x00000000
[  156.375318] Call Trace:
[  156.375326]  <TASK>
[  156.375443]  __schedule+0x3f8/0x1500
[  156.375481]  ? lock_is_held_type+0xea/0x140
[  156.375573]  schedule+0x4e/0xc0
[  156.375603]  io_schedule+0x47/0x70
[  156.375628]  folio_wait_bit_common+0x14a/0x400
[  156.375675]  ? folio_unlock+0x50/0x50
[  156.375705]  folio_wait_writeback+0x18/0x120
[  156.375722]  btrfs_page_mkwrite+0x217/0x7c0
[  156.375771]  do_page_mkwrite+0x4c/0x140
[  156.375792]  do_wp_page+0x27b/0x330
[  156.375813]  __handle_mm_fault+0xbb2/0x14a0
[  156.375883]  handle_mm_fault+0x11e/0x3a0
[  156.375910]  do_user_addr_fault+0x1ea/0x6b0
[  156.375946]  exc_page_fault+0x79/0x2e0
[  156.375958]  ? asm_exc_page_fault+0x8/0x30
[  156.375976]  asm_exc_page_fault+0x1e/0x30
[  156.375989] RIP: 0033:0x7f05453d8fc5
[  156.376002] RSP: 002b:00007ffc1fd7bed0 EFLAGS: 00010202
[  156.376016] RAX: 00007f05440f8ef0 RBX: 000000000000006b RCX: 00007ffc1fd7bef0
[  156.376024] RDX: 0000558cb2eb8338 RSI: 0000558cb2eb1b50 RDI: 0000558cb2ea6260
[  156.376032] RBP: 0000000000000001 R08: 0000000000879ef0 R09: 000000000000006b
[  156.376039] R10: 00007ffc1fd86080 R11: 00007ffc1fd86090 R12: 0000558cb2eb8300
[  156.376046] R13: 00007ffc1fd7bfe0 R14: 0000000000879ef0 R15: 0000000008510980
[  156.376112]  </TASK>
[  156.376474] task:gvfsd-metadata  state:D stack:12984 pid: 1832
ppid:  1550 flags:0x00004000
[  156.376499] Call Trace:
[  156.376505]  <TASK>
[  156.376527]  __schedule+0x3f8/0x1500
[  156.376545]  ? lock_is_held_type+0xea/0x140
[  156.376562]  ? find_held_lock+0x32/0x90
[  156.376603]  schedule+0x4e/0xc0
[  156.376622]  io_schedule+0x47/0x70
[  156.376638]  folio_wait_bit_common+0x14a/0x400
[  156.376680]  ? folio_unlock+0x50/0x50
[  156.376710]  folio_wait_writeback+0x18/0x120
[  156.376726]  extent_write_cache_pages+0x24f/0x4b0
[  156.376819]  extent_writepages+0x81/0x100
[  156.376848]  do_writepages+0xbf/0x1b0
[  156.376867]  ? lock_release+0x151/0x460
[  156.376898]  ? _raw_spin_unlock+0x29/0x40
[  156.376923]  filemap_fdatawrite_wbc+0x62/0x90
[  156.376940]  filemap_fdatawrite_range+0x46/0x50
[  156.376982]  start_ordered_ops.constprop.0+0x38/0x80
[  156.377015]  btrfs_sync_file+0xa0/0x5a0
[  156.377027]  ? lock_release+0x151/0x460
[  156.377079]  __x64_sys_fsync+0x33/0x60
[  156.377102]  do_syscall_64+0x38/0x90
[  156.377120]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  156.377133] RIP: 0033:0x7fe5b61602bb
[  156.377143] RSP: 002b:00007fff9ee62da0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  156.377157] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5b61602bb
[  156.377166] RDX: 0000000000000000 RSI: 00005636d1fa4420 RDI: 000000000000000a
[  156.377173] RBP: 00007fe59c0023a0 R08: 0000000000000000 R09: 0000000000000070
[  156.377180] R10: 0000000000000180 R11: 0000000000000293 R12: 00005636d1f72c00
[  156.377188] R13: 000000000000000a R14: 00005636d1fb9ab4 R15: 00007fff9ee62e08
[  156.377251]  </TASK>
[  156.377519] task:Permission      state:D stack:13760 pid: 2665
ppid:  1692 flags:0x00004000
[  156.377543] Call Trace:
[  156.377548]  <TASK>
[  156.377570]  __schedule+0x3f8/0x1500
[  156.377587]  ? lock_is_held_type+0xea/0x140
[  156.377604]  ? find_held_lock+0x32/0x90
[  156.377643]  schedule+0x4e/0xc0
[  156.377662]  io_schedule+0x47/0x70
[  156.377678]  folio_wait_bit_common+0x14a/0x400
[  156.377719]  ? folio_unlock+0x50/0x50
[  156.377749]  folio_wait_writeback+0x18/0x120
[  156.377765]  extent_write_cache_pages+0x24f/0x4b0
[  156.377857]  extent_writepages+0x81/0x100
[  156.377886]  do_writepages+0xbf/0x1b0
[  156.377904]  ? lock_release+0x151/0x460
[  156.377935]  ? _raw_spin_unlock+0x29/0x40
[  156.377960]  filemap_fdatawrite_wbc+0x62/0x90
[  156.377976]  filemap_fdatawrite_range+0x46/0x50
[  156.378017]  start_ordered_ops.constprop.0+0x38/0x80
[  156.378049]  btrfs_sync_file+0xa0/0x5a0
[  156.378061]  ? lock_release+0x151/0x460
[  156.378113]  __x64_sys_fsync+0x33/0x60
[  156.378134]  do_syscall_64+0x38/0x90
[  156.378152]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  156.378164] RIP: 0033:0x7fed0e3be2bb
[  156.378174] RSP: 002b:00007fecee0bd310 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  156.378186] RAX: ffffffffffffffda RBX: 00007fecf2749ae0 RCX: 00007fed0e3be2bb
[  156.378194] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000046
[  156.378201] RBP: 0000000000000223 R08: 0000000000000000 R09: 00007fed07f37c40
[  156.378208] R10: 00007fff72f9a080 R11: 0000000000000293 R12: 0000000000000002
[  156.378215] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  156.378278]  </TASK>
[  156.378406] task:StreamTrans #11 state:D stack:12776 pid: 2762
ppid:  1692 flags:0x00004000
[  156.378428] Call Trace:
[  156.378434]  <TASK>
[  156.378455]  __schedule+0x3f8/0x1500
[  156.378473]  ? lock_is_held_type+0xea/0x140
[  156.378490]  ? find_held_lock+0x32/0x90
[  156.378528]  schedule+0x4e/0xc0
[  156.378547]  io_schedule+0x47/0x70
[  156.378563]  folio_wait_bit_common+0x14a/0x400
[  156.378604]  ? folio_unlock+0x50/0x50
[  156.378634]  folio_wait_writeback+0x18/0x120
[  156.378649]  extent_write_cache_pages+0x24f/0x4b0
[  156.378707]  ? lock_is_held_type+0xea/0x140
[  156.378724]  ? find_held_lock+0x32/0x90
[  156.378735]  ? sched_clock_cpu+0xb/0xc0
[  156.378764]  extent_writepages+0x81/0x100
[  156.378793]  do_writepages+0xbf/0x1b0
[  156.378811]  ? lock_release+0x151/0x460
[  156.378843]  ? _raw_spin_unlock+0x29/0x40
[  156.378867]  filemap_fdatawrite_wbc+0x62/0x90
[  156.378884]  filemap_fdatawrite_range+0x46/0x50
[  156.378925]  start_ordered_ops.constprop.0+0x38/0x80
[  156.378957]  btrfs_sync_file+0xa0/0x5a0
[  156.378969]  ? lock_release+0x151/0x460
[  156.379021]  __x64_sys_fsync+0x33/0x60
[  156.379042]  do_syscall_64+0x38/0x90
[  156.379060]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  156.379072] RIP: 0033:0x7fed0e3be2bb
[  156.379081] RSP: 002b:00007fecd88bc7f0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  156.379093] RAX: ffffffffffffffda RBX: 00007fecc9b3e740 RCX: 00007fed0e3be2bb
[  156.379101] RDX: 0000000000000000 RSI: 00007fecc95d7000 RDI: 00000000000000b8
[  156.379107] RBP: 00007fecc9425370 R08: 0000000000000000 R09: 00007fecc95d73c0
[  156.379114] R10: 0000000000000010 R11: 0000000000000293 R12: 00000000000000d7
[  156.379121] R13: 00007fed090905f8 R14: 00007fed090905c8 R15: 00007fecc94f87a8
[  156.379184]  </TASK>
[  156.379208] task:mozStorage #1   state:D stack:12736 pid: 2823
ppid:  1692 flags:0x00000000
[  156.379227] Call Trace:
[  156.379233]  <TASK>
[  156.379254]  __schedule+0x3f8/0x1500
[  156.379271]  ? lock_is_held_type+0xea/0x140
[  156.379319]  schedule+0x4e/0xc0
[  156.379337]  io_schedule+0x47/0x70
[  156.379465]  folio_wait_bit_common+0x14a/0x400
[  156.379534]  ? folio_unlock+0x50/0x50
[  156.379590]  folio_wait_writeback+0x18/0x120
[  156.379615]  __filemap_fdatawait_range+0x77/0x120
[  156.379689]  ? mark_held_locks+0x50/0x80
[  156.379727]  filemap_fdatawait_range+0xe/0x50
[  156.379740]  btrfs_sync_file+0x488/0x5a0
[  156.379799]  __x64_sys_fsync+0x33/0x60
[  156.379819]  do_syscall_64+0x38/0x90
[  156.379838]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  156.379850] RIP: 0033:0x7fed0e3be2bb
[  156.379861] RSP: 002b:00007fecde2ba120 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  156.379874] RAX: ffffffffffffffda RBX: 00007feccdd94998 RCX: 00007fed0e3be2bb
[  156.379881] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000000007b
[  156.379888] RBP: 0000000000000223 R08: 0000000000000000 R09: 00007fed07f37c40
[  156.379895] R10: 00007fff72f9a080 R11: 0000000000000293 R12: 0000000000000002
[  156.379902] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fecc9ca9038
[  156.379966]  </TASK>
[  156.380117] task:grub2-set-bootf state:D stack:12952 pid: 3060
ppid:  1550 flags:0x00004000
[  156.380137] Call Trace:
[  156.380143]  <TASK>
[  156.380165]  __schedule+0x3f8/0x1500
[  156.380181]  ? lock_is_held_type+0xea/0x140
[  156.380230]  schedule+0x4e/0xc0
[  156.380248]  io_schedule+0x47/0x70
[  156.380264]  folio_wait_bit_common+0x14a/0x400
[  156.380306]  ? folio_unlock+0x50/0x50
[  156.380335]  folio_wait_writeback+0x18/0x120
[  156.380423]  __filemap_fdatawait_range+0x77/0x120
[  156.380459]  ? __clear_extent_bit+0x284/0x590
[  156.380503]  filemap_fdatawait_range+0xe/0x50
[  156.380515]  __btrfs_wait_marked_extents.isra.0+0xc0/0xf0
[  156.380547]  btrfs_wait_tree_log_extents+0x31/0x80
[  156.380565]  btrfs_sync_log+0x68d/0xc20
[  156.380619]  ? do_wait_intr_irq+0xb0/0xb0
[  156.380811]  btrfs_sync_file+0x40c/0x5a0
[  156.380869]  __x64_sys_fsync+0x33/0x60
[  156.380890]  do_syscall_64+0x38/0x90
[  156.380908]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  156.380920] RIP: 0033:0x7f0afd126297
[  156.380930] RSP: 002b:00007fffea143948 EFLAGS: 00000246 ORIG_RAX:
000000000000004a
[  156.380942] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0afd126297
[  156.380949] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000003
[  156.380956] RBP: 00007fffea145df0 R08: ffffffffffffffe0 R09: 0000000000000077
[  156.380964] R10: 0000000000000063 R11: 0000000000000246 R12: 00007fffea145f28
[  156.380970] R13: 000055af2a1c5328 R14: 00007f0afd26cc00 R15: 000055af2a1c7d00
[  156.381034]  </TASK>
[  251.120993] sysrq: Show Blocked State
[  251.121155] task:kworker/u16:5   state:D stack:13088 pid:  436
ppid:     2 flags:0x00004000
[  251.121185] Workqueue: writeback wb_workfn (flush-btrfs-1)
[  251.121213] Call Trace:
[  251.121220]  <TASK>
[  251.121248]  __schedule+0x3f8/0x1500
[  251.121271]  ? lock_is_held_type+0xea/0x140
[  251.121321]  schedule+0x4e/0xc0
[  251.121340]  io_schedule+0x47/0x70
[  251.121356]  folio_wait_bit_common+0x14a/0x400
[  251.121387]  ? lock_is_held_type+0xea/0x140
[  251.121406]  ? folio_unlock+0x50/0x50
[  251.121436]  extent_write_cache_pages+0x37c/0x4b0
[  251.121566]  ? __lock_acquire+0x3b3/0x1e00
[  251.121596]  extent_writepages+0x81/0x100
[  251.121626]  do_writepages+0xbf/0x1b0
[  251.121641]  ? lock_is_held_type+0xea/0x140
[  251.121665]  ? lock_is_held_type+0xea/0x140
[  251.121698]  __writeback_single_inode+0x60/0x660
[  251.121728]  writeback_sb_inodes+0x1e3/0x530
[  251.121802]  __writeback_inodes_wb+0x4c/0xe0
[  251.121831]  wb_writeback+0x2d2/0x4a0
[  251.121873]  wb_workfn+0x381/0x6d0
[  251.121895]  ? lock_acquire+0xe3/0x2f0
[  251.121945]  process_one_work+0x2b2/0x610
[  251.121995]  worker_thread+0x55/0x3c0
[  251.122018]  ? process_one_work+0x610/0x610
[  251.122034]  kthread+0x17a/0x1a0
[  251.122048]  ? set_kthread_struct+0x40/0x40
[  251.122071]  ret_from_fork+0x1f/0x30
[  251.122142]  </TASK>
[  251.122184] task:btrfs-transacti state:D stack:12680 pid:  486
ppid:     2 flags:0x00004000
[  251.122206] Call Trace:
[  251.122212]  <TASK>
[  251.122234]  __schedule+0x3f8/0x1500
[  251.122248]  ? mark_held_locks+0x50/0x80
[  251.122280]  ? blk_flush_plug+0xf2/0x120
[  251.122309]  schedule+0x4e/0xc0
[  251.122327]  io_schedule+0x47/0x70
[  251.122343]  blk_mq_get_tag+0x10c/0x260
[  251.122353]  ? efi_partition+0x820/0x820
[  251.122375]  ? do_wait_intr_irq+0xb0/0xb0
[  251.122411]  __blk_mq_alloc_requests+0x16b/0x390
[  251.122449]  blk_mq_submit_bio+0x217/0x840
[  251.122616]  submit_bio_noacct+0x2ae/0x2c0
[  251.122667]  btrfs_map_bio+0x198/0x4d0
[  251.122704]  ? btree_csum_one_bio+0x236/0x2a0
[  251.122767]  btrfs_submit_metadata_bio+0x8a/0x130
[  251.122804]  submit_one_bio+0x6c/0x80
[  251.122818]  submit_extent_page+0x1a0/0x5d0
[  251.122854]  ? lock_release+0x151/0x460
[  251.122887]  ? __folio_start_writeback+0x7f/0x360
[  251.122931]  write_one_eb+0xfe/0x210
[  251.122945]  ? set_btree_ioerr+0x70/0x70
[  251.122993]  btree_write_cache_pages+0x61e/0x8f0
[  251.123113]  do_writepages+0xbf/0x1b0
[  251.123132]  ? lock_release+0x151/0x460
[  251.123164]  ? _raw_spin_unlock+0x29/0x40
[  251.123189]  filemap_fdatawrite_wbc+0x62/0x90
[  251.123206]  filemap_fdatawrite_range+0x46/0x50
[  251.123248]  btrfs_write_marked_extents+0x58/0x140
[  251.123282]  btrfs_write_and_wait_transaction+0x36/0xa0
[  251.123318]  btrfs_commit_transaction+0x711/0xad0
[  251.123369]  transaction_kthread+0x133/0x1a0
[  251.123391]  ? btrfs_cleanup_transaction.isra.0+0x640/0x640
[  251.123408]  kthread+0x17a/0x1a0
[  251.123421]  ? set_kthread_struct+0x40/0x40
[  251.123444]  ret_from_fork+0x1f/0x30
[  251.123587]  </TASK>
[  251.123605] task:systemd-journal state:D stack:11848 pid:  593
ppid:     1 flags:0x00000000
[  251.123627] Call Trace:
[  251.123633]  <TASK>
[  251.123655]  __schedule+0x3f8/0x1500
[  251.123673]  ? lock_is_held_type+0xea/0x140
[  251.123722]  schedule+0x4e/0xc0
[  251.123740]  io_schedule+0x47/0x70
[  251.123756]  folio_wait_bit_common+0x14a/0x400
[  251.123799]  ? folio_unlock+0x50/0x50
[  251.123829]  folio_wait_writeback+0x18/0x120
[  251.123846]  btrfs_page_mkwrite+0x217/0x7c0
[  251.123894]  do_page_mkwrite+0x4c/0x140
[  251.123916]  do_wp_page+0x27b/0x330
[  251.123937]  __handle_mm_fault+0xbb2/0x14a0
[  251.124006]  handle_mm_fault+0x11e/0x3a0
[  251.124033]  do_user_addr_fault+0x1ea/0x6b0
[  251.124069]  exc_page_fault+0x79/0x2e0
[  251.124081]  ? asm_exc_page_fault+0x8/0x30
[  251.124098]  asm_exc_page_fault+0x1e/0x30
[  251.124111] RIP: 0033:0x7f05453d8fc5
[  251.124124] RSP: 002b:00007ffc1fd7bed0 EFLAGS: 00010202
[  251.124138] RAX: 00007f05440f8ef0 RBX: 000000000000006b RCX: 00007ffc1fd7bef0
[  251.124146] RDX: 0000558cb2eb8338 RSI: 0000558cb2eb1b50 RDI: 0000558cb2ea6260
[  251.124153] RBP: 0000000000000001 R08: 0000000000879ef0 R09: 000000000000006b
[  251.124161] R10: 00007ffc1fd86080 R11: 00007ffc1fd86090 R12: 0000558cb2eb8300
[  251.124168] R13: 00007ffc1fd7bfe0 R14: 0000000000879ef0 R15: 0000000008510980
[  251.124232]  </TASK>
[  251.124278] task:btrfs-transacti state:D stack:13272 pid:  764
ppid:     2 flags:0x00004000
[  251.124298] Call Trace:
[  251.124303]  <TASK>
[  251.124325]  __schedule+0x3f8/0x1500
[  251.124350]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  251.124364]  ? lockdep_hardirqs_on+0x7e/0x100
[  251.124379]  ? _raw_spin_unlock_irqrestore+0x3e/0x60
[  251.124407]  schedule+0x4e/0xc0
[  251.124426]  btrfs_commit_transaction+0x8f3/0xad0
[  251.124447]  ? start_transaction+0xc7/0x6a0
[  251.124463]  ? do_wait_intr_irq+0xb0/0xb0
[  251.124560]  transaction_kthread+0x133/0x1a0
[  251.124585]  ? btrfs_cleanup_transaction.isra.0+0x640/0x640
[  251.124601]  kthread+0x17a/0x1a0
[  251.124615]  ? set_kthread_struct+0x40/0x40
[  251.124638]  ret_from_fork+0x1f/0x30
[  251.124708]  </TASK>
[  251.124833] task:kworker/u16:13  state:D stack:12584 pid: 1006
ppid:     2 flags:0x00004000
[  251.124855] Workqueue: btrfs-delalloc btrfs_work_helper
[  251.124874] Call Trace:
[  251.124879]  <TASK>
[  251.124901]  __schedule+0x3f8/0x1500
[  251.124915]  ? mark_held_locks+0x50/0x80
[  251.124936]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  251.124963]  ? rq_qos_wait+0xaf/0x120
[  251.124979]  ? wbt_rqw_done+0xf0/0xf0
[  251.124996]  schedule+0x4e/0xc0
[  251.125015]  io_schedule+0x47/0x70
[  251.125031]  rq_qos_wait+0xb4/0x120
[  251.125049]  ? efi_partition+0x820/0x820
[  251.125072]  ? wbt_cleanup_cb+0x20/0x20
[  251.125101]  wbt_wait+0x77/0xc0
[  251.125127]  __rq_qos_throttle+0x20/0x30
[  251.125146]  blk_mq_submit_bio+0x1ec/0x840
[  251.125195]  submit_bio_noacct+0x2ae/0x2c0
[  251.125220]  btrfs_map_bio+0x198/0x4d0
[  251.125267]  btrfs_submit_compressed_write+0x2ee/0x400
[  251.125340]  submit_compressed_extents+0x26f/0x400
[  251.125408]  async_cow_submit+0x37/0x90
[  251.125424]  btrfs_work_helper+0x13e/0x430
[  251.125463]  process_one_work+0x2b2/0x610
[  251.125553]  worker_thread+0x55/0x3c0
[  251.125577]  ? process_one_work+0x610/0x610
[  251.125593]  kthread+0x17a/0x1a0
[  251.125606]  ? set_kthread_struct+0x40/0x40
[  251.125630]  ret_from_fork+0x1f/0x30
[  251.125698]  </TASK>
[  251.125843] task:gvfsd-metadata  state:D stack:12984 pid: 1832
ppid:  1550 flags:0x00004000
[  251.125863] Call Trace:
[  251.125868]  <TASK>
[  251.125890]  __schedule+0x3f8/0x1500
[  251.125906]  ? lock_is_held_type+0xea/0x140
[  251.125923]  ? find_held_lock+0x32/0x90
[  251.125962]  schedule+0x4e/0xc0
[  251.125981]  io_schedule+0x47/0x70
[  251.125996]  folio_wait_bit_common+0x14a/0x400
[  251.126039]  ? folio_unlock+0x50/0x50
[  251.126069]  folio_wait_writeback+0x18/0x120
[  251.126085]  extent_write_cache_pages+0x24f/0x4b0
[  251.126178]  extent_writepages+0x81/0x100
[  251.126207]  do_writepages+0xbf/0x1b0
[  251.126226]  ? lock_release+0x151/0x460
[  251.126257]  ? _raw_spin_unlock+0x29/0x40
[  251.126281]  filemap_fdatawrite_wbc+0x62/0x90
[  251.126299]  filemap_fdatawrite_range+0x46/0x50
[  251.126340]  start_ordered_ops.constprop.0+0x38/0x80
[  251.126373]  btrfs_sync_file+0xa0/0x5a0
[  251.126385]  ? lock_release+0x151/0x460
[  251.126438]  __x64_sys_fsync+0x33/0x60
[  251.126459]  do_syscall_64+0x38/0x90
[  251.126478]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.126584] RIP: 0033:0x7fe5b61602bb
[  251.126604] RSP: 002b:00007fff9ee62da0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  251.126628] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5b61602bb
[  251.126641] RDX: 0000000000000000 RSI: 00005636d1fa4420 RDI: 000000000000000a
[  251.126653] RBP: 00007fe59c0023a0 R08: 0000000000000000 R09: 0000000000000070
[  251.126666] R10: 0000000000000180 R11: 0000000000000293 R12: 00005636d1f72c00
[  251.126679] R13: 000000000000000a R14: 00005636d1fb9ab4 R15: 00007fff9ee62e08
[  251.126799]  </TASK>
[  251.127023] task:GeckoMain       state:D stack:11088 pid: 2629
ppid:  1692 flags:0x00000000
[  251.127045] Call Trace:
[  251.127051]  <TASK>
[  251.127073]  __schedule+0x3f8/0x1500
[  251.127089]  ? mark_held_locks+0x50/0x80
[  251.127110]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  251.127129]  ? __sbitmap_get_word+0x30/0x80
[  251.127160]  schedule+0x4e/0xc0
[  251.127179]  io_schedule+0x47/0x70
[  251.127195]  blk_mq_get_tag+0x10c/0x260
[  251.127215]  ? do_wait_intr_irq+0xb0/0xb0
[  251.127250]  __blk_mq_alloc_requests+0x16b/0x390
[  251.127289]  blk_mq_submit_bio+0x217/0x840
[  251.127337]  submit_bio_noacct+0x2ae/0x2c0
[  251.127365]  btrfs_map_bio+0x198/0x4d0
[  251.127412]  btrfs_submit_compressed_read+0x468/0x510
[  251.127447]  ? rcu_read_lock_sched_held+0x3f/0x70
[  251.127461]  ? kmem_cache_alloc+0x32b/0x490
[  251.127559]  btrfs_submit_data_bio+0x203/0x210
[  251.127600]  submit_one_bio+0x4f/0x80
[  251.127608]  submit_extent_page+0xae/0x5d0
[  251.127637]  ? find_held_lock+0x32/0x90
[  251.127649]  ? sched_clock_cpu+0xb/0xc0
[  251.127670]  ? lock_release+0x151/0x460
[  251.127714]  btrfs_do_readpage+0x273/0x8d0
[  251.127727]  ? btrfs_repair_one_sector+0x3f0/0x3f0
[  251.127794]  ? extent_readahead+0x93/0x580
[  251.127806]  extent_readahead+0x4a4/0x580
[  251.127904]  read_pages+0x61/0x310
[  251.127943]  page_cache_ra_unbounded+0x1ac/0x290
[  251.127992]  filemap_fault+0x2f9/0xb80
[  251.128014]  ? filemap_map_pages+0x20a/0x790
[  251.128053]  __do_fault+0x37/0x190
[  251.128071]  __handle_mm_fault+0xd4d/0x14a0
[  251.128141]  handle_mm_fault+0x11e/0x3a0
[  251.128168]  do_user_addr_fault+0x1ea/0x6b0
[  251.128203]  exc_page_fault+0x79/0x2e0
[  251.128216]  ? asm_exc_page_fault+0x8/0x30
[  251.128233]  asm_exc_page_fault+0x1e/0x30
[  251.128244] RIP: 0033:0x7fed047b4b0a
[  251.128254] RSP: 002b:00007fff72f49ad0 EFLAGS: 00010202
[  251.128267] RAX: 00007fecce6f6008 RBX: 00007fecce6f6008 RCX: 00007fecce6f6008
[  251.128274] RDX: 00007fecf1969564 RSI: 00000000000047e9 RDI: 00000000000047e9
[  251.128281] RBP: 00007fecce6f6008 R08: 00000000000047e0 R09: 0000000000001a60
[  251.128288] R10: 0000000000000000 R11: 00007fecce6f6008 R12: 00007fecce6f6008
[  251.128295] R13: 00007fecf1969564 R14: 00007fff72f49e80 R15: 00000000000047e9
[  251.128358]  </TASK>
[  251.128372] task:Permission      state:D stack:13760 pid: 2665
ppid:  1692 flags:0x00004000
[  251.128392] Call Trace:
[  251.128398]  <TASK>
[  251.128419]  __schedule+0x3f8/0x1500
[  251.128436]  ? lock_is_held_type+0xea/0x140
[  251.128454]  ? find_held_lock+0x32/0x90
[  251.128549]  schedule+0x4e/0xc0
[  251.128570]  io_schedule+0x47/0x70
[  251.128586]  folio_wait_bit_common+0x14a/0x400
[  251.128629]  ? folio_unlock+0x50/0x50
[  251.128659]  folio_wait_writeback+0x18/0x120
[  251.128674]  extent_write_cache_pages+0x24f/0x4b0
[  251.128766]  extent_writepages+0x81/0x100
[  251.128795]  do_writepages+0xbf/0x1b0
[  251.128813]  ? lock_release+0x151/0x460
[  251.128845]  ? _raw_spin_unlock+0x29/0x40
[  251.128869]  filemap_fdatawrite_wbc+0x62/0x90
[  251.128886]  filemap_fdatawrite_range+0x46/0x50
[  251.128927]  start_ordered_ops.constprop.0+0x38/0x80
[  251.128959]  btrfs_sync_file+0xa0/0x5a0
[  251.128972]  ? lock_release+0x151/0x460
[  251.129024]  __x64_sys_fsync+0x33/0x60
[  251.129045]  do_syscall_64+0x38/0x90
[  251.129063]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.129075] RIP: 0033:0x7fed0e3be2bb
[  251.129085] RSP: 002b:00007fecee0bd310 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  251.129098] RAX: ffffffffffffffda RBX: 00007fecf2749ae0 RCX: 00007fed0e3be2bb
[  251.129105] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000046
[  251.129112] RBP: 0000000000000223 R08: 0000000000000000 R09: 00007fed07f37c40
[  251.129119] R10: 00007fff72f9a080 R11: 0000000000000293 R12: 0000000000000002
[  251.129126] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  251.129190]  </TASK>
[  251.129206] task:Cache2 I/O      state:D stack:12600 pid: 2678
ppid:  1692 flags:0x00000000
[  251.129225] Call Trace:
[  251.129230]  <TASK>
[  251.129252]  __schedule+0x3f8/0x1500
[  251.129266]  ? mark_held_locks+0x50/0x80
[  251.129287]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  251.129306]  ? __sbitmap_get_word+0x30/0x80
[  251.129336]  schedule+0x4e/0xc0
[  251.129354]  io_schedule+0x47/0x70
[  251.129370]  blk_mq_get_tag+0x10c/0x260
[  251.129390]  ? do_wait_intr_irq+0xb0/0xb0
[  251.129425]  __blk_mq_alloc_requests+0x16b/0x390
[  251.129463]  blk_mq_submit_bio+0x217/0x840
[  251.129549]  submit_bio_noacct+0x2ae/0x2c0
[  251.129577]  btrfs_map_bio+0x198/0x4d0
[  251.129598]  ? rcu_read_lock_sched_held+0x3f/0x70
[  251.129633]  btrfs_submit_metadata_bio+0x8a/0x130
[  251.129654]  submit_one_bio+0x6c/0x80
[  251.129662]  read_extent_buffer_pages+0x53d/0x640
[  251.129713]  btree_read_extent_buffer_pages+0x97/0x110
[  251.129750]  read_tree_block+0x39/0x60
[  251.129771]  read_block_for_search+0x17a/0x210
[  251.129818]  btrfs_search_slot+0x206/0x9e0
[  251.129876]  btrfs_lookup_dir_item+0x6c/0xc0
[  251.129909]  btrfs_lookup_dentry+0xa8/0x510
[  251.129929]  ? lockdep_init_map_type+0x51/0x250
[  251.129970]  btrfs_lookup+0xe/0x30
[  251.129981]  __lookup_slow+0x10c/0x1e0
[  251.130016]  ? lock_is_held_type+0xea/0x140
[  251.130052]  ? lock_is_held_type+0xea/0x140
[  251.130082]  walk_component+0x11b/0x190
[  251.130116]  path_lookupat+0x6e/0x1c0
[  251.130141]  filename_lookup+0xbc/0x1a0
[  251.130194]  ? __check_object_size+0x152/0x190
[  251.130216]  ? strncpy_from_user+0x53/0x180
[  251.130255]  user_path_at_empty+0x3a/0x50
[  251.130276]  do_faccessat+0x6e/0x260
[  251.130292]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.130321]  do_syscall_64+0x38/0x90
[  251.130339]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.130351] RIP: 0033:0x7fed0e3b799b
[  251.130360] RSP: 002b:00007fecf292aae8 EFLAGS: 00000246 ORIG_RAX:
0000000000000015
[  251.130372] RAX: ffffffffffffffda RBX: 00007fecc80fe920 RCX: 00007fed0e3b799b
[  251.130399] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fecc7457d08
[  251.130405] RBP: 00007fecf292ab4d R08: 0000000000000770 R09: 0000000000000000
[  251.130412] R10: 0000000000000077 R11: 0000000000000246 R12: 00007fecc38bb4c4
[  251.130419] R13: 00007fecc38bb4f0 R14: 00007fecedb692c0 R15: 00007fecc80fe920
[  251.130568]  </TASK>
[  251.130637] task:StreamTrans #11 state:D stack:12776 pid: 2762
ppid:  1692 flags:0x00004000
[  251.130671] Call Trace:
[  251.130682]  <TASK>
[  251.130723]  __schedule+0x3f8/0x1500
[  251.130749]  ? lock_is_held_type+0xea/0x140
[  251.130779]  ? find_held_lock+0x32/0x90
[  251.130827]  schedule+0x4e/0xc0
[  251.130846]  io_schedule+0x47/0x70
[  251.130862]  folio_wait_bit_common+0x14a/0x400
[  251.130904]  ? folio_unlock+0x50/0x50
[  251.130934]  folio_wait_writeback+0x18/0x120
[  251.130950]  extent_write_cache_pages+0x24f/0x4b0
[  251.131009]  ? lock_is_held_type+0xea/0x140
[  251.131025]  ? find_held_lock+0x32/0x90
[  251.131037]  ? sched_clock_cpu+0xb/0xc0
[  251.131065]  extent_writepages+0x81/0x100
[  251.131094]  do_writepages+0xbf/0x1b0
[  251.131112]  ? lock_release+0x151/0x460
[  251.131144]  ? _raw_spin_unlock+0x29/0x40
[  251.131168]  filemap_fdatawrite_wbc+0x62/0x90
[  251.131186]  filemap_fdatawrite_range+0x46/0x50
[  251.131227]  start_ordered_ops.constprop.0+0x38/0x80
[  251.131260]  btrfs_sync_file+0xa0/0x5a0
[  251.131272]  ? lock_release+0x151/0x460
[  251.131324]  __x64_sys_fsync+0x33/0x60
[  251.131345]  do_syscall_64+0x38/0x90
[  251.131363]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.131375] RIP: 0033:0x7fed0e3be2bb
[  251.131385] RSP: 002b:00007fecd88bc7f0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  251.131397] RAX: ffffffffffffffda RBX: 00007fecc9b3e740 RCX: 00007fed0e3be2bb
[  251.131405] RDX: 0000000000000000 RSI: 00007fecc95d7000 RDI: 00000000000000b8
[  251.131412] RBP: 00007fecc9425370 R08: 0000000000000000 R09: 00007fecc95d73c0
[  251.131418] R10: 0000000000000010 R11: 0000000000000293 R12: 00000000000000d7
[  251.131425] R13: 00007fed090905f8 R14: 00007fed090905c8 R15: 00007fecc94f87a8
[  251.131545]  </TASK>
[  251.131571] task:mozStorage #1   state:D stack:12736 pid: 2823
ppid:  1692 flags:0x00000000
[  251.131591] Call Trace:
[  251.131597]  <TASK>
[  251.131619]  __schedule+0x3f8/0x1500
[  251.131636]  ? lock_is_held_type+0xea/0x140
[  251.131706]  schedule+0x4e/0xc0
[  251.131724]  io_schedule+0x47/0x70
[  251.131740]  folio_wait_bit_common+0x14a/0x400
[  251.131782]  ? folio_unlock+0x50/0x50
[  251.131812]  folio_wait_writeback+0x18/0x120
[  251.131827]  __filemap_fdatawait_range+0x77/0x120
[  251.131869]  ? mark_held_locks+0x50/0x80
[  251.131903]  filemap_fdatawait_range+0xe/0x50
[  251.131916]  btrfs_sync_file+0x488/0x5a0
[  251.131974]  __x64_sys_fsync+0x33/0x60
[  251.131994]  do_syscall_64+0x38/0x90
[  251.132012]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.132024] RIP: 0033:0x7fed0e3be2bb
[  251.132033] RSP: 002b:00007fecde2ba120 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  251.132045] RAX: ffffffffffffffda RBX: 00007feccdd94998 RCX: 00007fed0e3be2bb
[  251.132052] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000000007b
[  251.132059] RBP: 0000000000000223 R08: 0000000000000000 R09: 00007fed07f37c40
[  251.132066] R10: 00007fff72f9a080 R11: 0000000000000293 R12: 0000000000000002
[  251.132073] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fecc9ca9038
[  251.132136]  </TASK>
[  251.132304] task:grub2-set-bootf state:D stack:12952 pid: 3060
ppid:  1550 flags:0x00004000
[  251.132323] Call Trace:
[  251.132328]  <TASK>
[  251.132350]  __schedule+0x3f8/0x1500
[  251.132366]  ? lock_is_held_type+0xea/0x140
[  251.132415]  schedule+0x4e/0xc0
[  251.132433]  io_schedule+0x47/0x70
[  251.132450]  folio_wait_bit_common+0x14a/0x400
[  251.132550]  ? folio_unlock+0x50/0x50
[  251.132582]  folio_wait_writeback+0x18/0x120
[  251.132598]  __filemap_fdatawait_range+0x77/0x120
[  251.132628]  ? __clear_extent_bit+0x284/0x590
[  251.132672]  filemap_fdatawait_range+0xe/0x50
[  251.132685]  __btrfs_wait_marked_extents.isra.0+0xc0/0xf0
[  251.132716]  btrfs_wait_tree_log_extents+0x31/0x80
[  251.132734]  btrfs_sync_log+0x68d/0xc20
[  251.132786]  ? do_wait_intr_irq+0xb0/0xb0
[  251.132977]  btrfs_sync_file+0x40c/0x5a0
[  251.133035]  __x64_sys_fsync+0x33/0x60
[  251.133055]  do_syscall_64+0x38/0x90
[  251.133074]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.133086] RIP: 0033:0x7f0afd126297
[  251.133095] RSP: 002b:00007fffea143948 EFLAGS: 00000246 ORIG_RAX:
000000000000004a
[  251.133107] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0afd126297
[  251.133114] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000003
[  251.133121] RBP: 00007fffea145df0 R08: ffffffffffffffe0 R09: 0000000000000077
[  251.133128] R10: 0000000000000063 R11: 0000000000000246 R12: 00007fffea145f28
[  251.133135] R13: 000055af2a1c5328 R14: 00007f0afd26cc00 R15: 000055af2a1c7d00
[  251.133199]  </TASK>
[  251.133207] task:flatpak         state:D stack:12800 pid: 3070
ppid:  1692 flags:0x00000000
[  251.133226] Call Trace:
[  251.133231]  <TASK>
[  251.133252]  __schedule+0x3f8/0x1500
[  251.133266]  ? mark_held_locks+0x50/0x80
[  251.133287]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  251.133306]  ? __sbitmap_get_word+0x30/0x80
[  251.133335]  schedule+0x4e/0xc0
[  251.133354]  io_schedule+0x47/0x70
[  251.133369]  blk_mq_get_tag+0x10c/0x260
[  251.133390]  ? do_wait_intr_irq+0xb0/0xb0
[  251.133424]  __blk_mq_alloc_requests+0x16b/0x390
[  251.133462]  blk_mq_submit_bio+0x217/0x840
[  251.133545]  submit_bio_noacct+0x2ae/0x2c0
[  251.133570]  btrfs_map_bio+0x198/0x4d0
[  251.133591]  ? rcu_read_lock_sched_held+0x3f/0x70
[  251.133626]  btrfs_submit_metadata_bio+0x8a/0x130
[  251.133648]  submit_one_bio+0x6c/0x80
[  251.133657]  read_extent_buffer_pages+0x53d/0x640
[  251.133707]  btree_read_extent_buffer_pages+0x97/0x110
[  251.133745]  read_tree_block+0x39/0x60
[  251.133766]  read_block_for_search+0x17a/0x210
[  251.133813]  btrfs_search_slot+0x206/0x9e0
[  251.133871]  btrfs_lookup_inode+0x2a/0x90
[  251.133896]  btrfs_read_locked_inode+0x533/0x610
[  251.133947]  btrfs_iget_path+0x6d/0xc0
[  251.133967]  btrfs_lookup_dentry+0x3e8/0x510
[  251.134016]  btrfs_lookup+0xe/0x30
[  251.134027]  __lookup_slow+0x10c/0x1e0
[  251.134061]  ? add_wait_queue+0x1d/0xa0
[  251.134101]  ? lock_is_held_type+0xea/0x140
[  251.134132]  walk_component+0x11b/0x190
[  251.134166]  link_path_walk.part.0.constprop.0+0x225/0x360
[  251.134203]  path_lookupat+0x3e/0x1c0
[  251.134228]  filename_lookup+0xbc/0x1a0
[  251.134283]  ? __check_object_size+0x152/0x190
[  251.134304]  ? strncpy_from_user+0x53/0x180
[  251.134328]  ? __handle_mm_fault+0x110c/0x14a0
[  251.134352]  user_path_at_empty+0x3a/0x50
[  251.134374]  vfs_statx+0x64/0x100
[  251.134388]  ? find_held_lock+0x32/0x90
[  251.134416]  do_statx+0x2d/0x50
[  251.134444]  ? lock_is_held_type+0xea/0x140
[  251.134467]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.134556]  ? lockdep_hardirqs_on+0x7e/0x100
[  251.134584]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.134604]  __x64_sys_statx+0x1b/0x20
[  251.134623]  do_syscall_64+0x38/0x90
[  251.134650]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.134667] RIP: 0033:0x7f25e97be08e
[  251.134686] RSP: 002b:00007ffe80715b28 EFLAGS: 00000202 ORIG_RAX:
000000000000014c
[  251.134709] RAX: ffffffffffffffda RBX: 0000559852804a00 RCX: 00007f25e97be08e
[  251.134723] RDX: 0000000000000900 RSI: 0000559852800f60 RDI: 00000000ffffff9c
[  251.134737] RBP: 0000000000000000 R08: 00007ffe80715ca0 R09: 0000000000000000
[  251.134749] R10: 0000000000000fff R11: 0000000000000202 R12: 00005598527fe640
[  251.134762] R13: 0000559852800f60 R14: 00005598527cd360 R15: 0000559852805670
[  251.134873]  </TASK>
[  251.134883] task:flatpak         state:D stack:13408 pid: 3074
ppid:  1692 flags:0x00000000
[  251.134909] Call Trace:
[  251.134914]  <TASK>
[  251.134936]  __schedule+0x3f8/0x1500
[  251.134965]  ? sched_clock_cpu+0xb/0xc0
[  251.134989]  ? lock_release+0x151/0x460
[  251.135020]  schedule+0x4e/0xc0
[  251.135041]  d_alloc_parallel+0x69c/0x960
[  251.135075]  ? wake_up_q+0x90/0x90
[  251.135108]  __lookup_slow+0xe6/0x1e0
[  251.135142]  ? lock_is_held_type+0xea/0x140
[  251.135196]  ? lock_is_held_type+0xea/0x140
[  251.135244]  walk_component+0x11b/0x190
[  251.135291]  link_path_walk.part.0.constprop.0+0x225/0x360
[  251.135351]  path_lookupat+0x3e/0x1c0
[  251.135392]  filename_lookup+0xbc/0x1a0
[  251.135477]  ? __check_object_size+0x152/0x190
[  251.135576]  ? strncpy_from_user+0x53/0x180
[  251.135621]  ? __handle_mm_fault+0x110c/0x14a0
[  251.135668]  user_path_at_empty+0x3a/0x50
[  251.135706]  vfs_statx+0x64/0x100
[  251.135732]  ? find_held_lock+0x32/0x90
[  251.135773]  do_statx+0x2d/0x50
[  251.135802]  ? lock_is_held_type+0xea/0x140
[  251.135827]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.135840]  ? lockdep_hardirqs_on+0x7e/0x100
[  251.135855]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.135867]  __x64_sys_statx+0x1b/0x20
[  251.135878]  do_syscall_64+0x38/0x90
[  251.135904]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.135921] RIP: 0033:0x7f077b54c08e
[  251.135932] RSP: 002b:00007ffd13e4ba38 EFLAGS: 00000202 ORIG_RAX:
000000000000014c
[  251.135947] RAX: ffffffffffffffda RBX: 000055732e8ef060 RCX: 00007f077b54c08e
[  251.135955] RDX: 0000000000000900 RSI: 000055732e8d6c00 RDI: 00000000ffffff9c
[  251.135963] RBP: 0000000000000000 R08: 00007ffd13e4bbb0 R09: 0000000000000000
[  251.135971] R10: 0000000000000fff R11: 0000000000000202 R12: 000055732e8e83d0
[  251.135977] R13: 000055732e8d6c00 R14: 000055732e8b7360 R15: 000055732e8eedf0
[  251.136042]  </TASK>
[  251.136052] task:flatpak         state:D stack:13808 pid: 3077
ppid:  1692 flags:0x00000000
[  251.136084] Call Trace:
[  251.136090]  <TASK>
[  251.136112]  __schedule+0x3f8/0x1500
[  251.136144]  ? sched_clock_cpu+0xb/0xc0
[  251.136166]  ? lock_release+0x151/0x460
[  251.136196]  schedule+0x4e/0xc0
[  251.136214]  d_alloc_parallel+0x69c/0x960
[  251.136249]  ? wake_up_q+0x90/0x90
[  251.136281]  __lookup_slow+0xe6/0x1e0
[  251.136314]  ? lock_is_held_type+0xea/0x140
[  251.136350]  ? lock_is_held_type+0xea/0x140
[  251.136380]  walk_component+0x11b/0x190
[  251.136449]  link_path_walk.part.0.constprop.0+0x225/0x360
[  251.136559]  path_lookupat+0x3e/0x1c0
[  251.136602]  filename_lookup+0xbc/0x1a0
[  251.136684]  ? __check_object_size+0x152/0x190
[  251.136742]  ? strncpy_from_user+0x53/0x180
[  251.136784]  ? __handle_mm_fault+0xd37/0x14a0
[  251.136828]  user_path_at_empty+0x3a/0x50
[  251.136858]  vfs_statx+0x64/0x100
[  251.136879]  ? find_held_lock+0x32/0x90
[  251.136923]  do_statx+0x2d/0x50
[  251.136967]  ? lock_is_held_type+0xea/0x140
[  251.137006]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.137025]  ? lockdep_hardirqs_on+0x7e/0x100
[  251.137046]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.137066]  __x64_sys_statx+0x1b/0x20
[  251.137084]  do_syscall_64+0x38/0x90
[  251.137110]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.137128] RIP: 0033:0x7f71b223508e
[  251.137146] RSP: 002b:00007fff658acec8 EFLAGS: 00000206 ORIG_RAX:
000000000000014c
[  251.137169] RAX: ffffffffffffffda RBX: 000055cdbfc3d540 RCX: 00007f71b223508e
[  251.137182] RDX: 0000000000000900 RSI: 000055cdbfc2cb60 RDI: 00000000ffffff9c
[  251.137195] RBP: 0000000000000000 R08: 00007fff658ad040 R09: 0000000000000000
[  251.137208] R10: 0000000000000fff R11: 0000000000000206 R12: 000055cdbfc37dc0
[  251.137220] R13: 000055cdbfc2cb60 R14: 000055cdbfc06360 R15: 000055cdbfc37a80
[  251.137335]  </TASK>
[  251.137350] task:flatpak         state:D stack:13808 pid: 3081
ppid:  1692 flags:0x00000000
[  251.137391] Call Trace:
[  251.137401]  <TASK>
[  251.137439]  __schedule+0x3f8/0x1500
[  251.137552]  ? sched_clock_cpu+0xb/0xc0
[  251.137589]  ? lock_release+0x151/0x460
[  251.137624]  schedule+0x4e/0xc0
[  251.137644]  d_alloc_parallel+0x69c/0x960
[  251.137680]  ? wake_up_q+0x90/0x90
[  251.137712]  __lookup_slow+0xe6/0x1e0
[  251.137762]  ? lock_is_held_type+0xea/0x140
[  251.137824]  ? lock_is_held_type+0xea/0x140
[  251.137881]  walk_component+0x11b/0x190
[  251.137919]  link_path_walk.part.0.constprop.0+0x225/0x360
[  251.137980]  path_lookupat+0x3e/0x1c0
[  251.138019]  filename_lookup+0xbc/0x1a0
[  251.138106]  ? __check_object_size+0x152/0x190
[  251.138143]  ? strncpy_from_user+0x53/0x180
[  251.138185]  ? __handle_mm_fault+0xd37/0x14a0
[  251.138229]  user_path_at_empty+0x3a/0x50
[  251.138260]  vfs_statx+0x64/0x100
[  251.138285]  ? find_held_lock+0x32/0x90
[  251.138335]  do_statx+0x2d/0x50
[  251.138384]  ? lock_is_held_type+0xea/0x140
[  251.138421]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.138441]  ? lockdep_hardirqs_on+0x7e/0x100
[  251.138464]  ? syscall_enter_from_user_mode+0x21/0x70
[  251.138557]  __x64_sys_statx+0x1b/0x20
[  251.138581]  do_syscall_64+0x38/0x90
[  251.138616]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  251.138642] RIP: 0033:0x7f1895b2908e
[  251.138664] RSP: 002b:00007ffee5e71b18 EFLAGS: 00000206 ORIG_RAX:
000000000000014c
[  251.138690] RAX: ffffffffffffffda RBX: 00005582d85d1860 RCX: 00007f1895b2908e
[  251.138705] RDX: 0000000000000900 RSI: 00005582d85a6c20 RDI: 00000000ffffff9c
[  251.138718] RBP: 0000000000000000 R08: 00007ffee5e71c90 R09: 0000000000000000
[  251.138731] R10: 0000000000000fff R11: 0000000000000206 R12: 00005582d85dcda0
[  251.138744] R13: 00005582d85a6c20 R14: 00005582d85a0360 R15: 00005582d85dcbd0
[  251.138826]  </TASK>
[  370.926101] INFO: task kworker/u16:5:436 blocked for more than 122 seconds.
[  370.926129]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.926141] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.926151] task:kworker/u16:5   state:D stack:13088 pid:  436
ppid:     2 flags:0x00004000
[  370.926186] Workqueue: writeback wb_workfn (flush-btrfs-1)
[  370.926212] Call Trace:
[  370.926219]  <TASK>
[  370.926245]  __schedule+0x3f8/0x1500
[  370.926267]  ? lock_is_held_type+0xea/0x140
[  370.926313]  schedule+0x4e/0xc0
[  370.926331]  io_schedule+0x47/0x70
[  370.926347]  folio_wait_bit_common+0x14a/0x400
[  370.926375]  ? lock_is_held_type+0xea/0x140
[  370.926394]  ? folio_unlock+0x50/0x50
[  370.926421]  extent_write_cache_pages+0x37c/0x4b0
[  370.926493]  ? __lock_acquire+0x3b3/0x1e00
[  370.926520]  extent_writepages+0x81/0x100
[  370.926547]  do_writepages+0xbf/0x1b0
[  370.926560]  ? lock_is_held_type+0xea/0x140
[  370.926583]  ? lock_is_held_type+0xea/0x140
[  370.926613]  __writeback_single_inode+0x60/0x660
[  370.926641]  writeback_sb_inodes+0x1e3/0x530
[  370.926709]  __writeback_inodes_wb+0x4c/0xe0
[  370.926736]  wb_writeback+0x2d2/0x4a0
[  370.926775]  wb_workfn+0x381/0x6d0
[  370.926795]  ? lock_acquire+0xe3/0x2f0
[  370.926841]  process_one_work+0x2b2/0x610
[  370.926985]  worker_thread+0x55/0x3c0
[  370.927023]  ? process_one_work+0x610/0x610
[  370.927050]  kthread+0x17a/0x1a0
[  370.927071]  ? set_kthread_struct+0x40/0x40
[  370.927110]  ret_from_fork+0x1f/0x30
[  370.927198]  </TASK>
[  370.927212] INFO: task btrfs-transacti:486 blocked for more than 122 seconds.
[  370.927220]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.927228] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.927233] task:btrfs-transacti state:D stack:12680 pid:  486
ppid:     2 flags:0x00004000
[  370.927254] Call Trace:
[  370.927259]  <TASK>
[  370.927279]  __schedule+0x3f8/0x1500
[  370.927293]  ? mark_held_locks+0x50/0x80
[  370.927323]  ? blk_flush_plug+0xf2/0x120
[  370.927350]  schedule+0x4e/0xc0
[  370.927367]  io_schedule+0x47/0x70
[  370.927383]  blk_mq_get_tag+0x10c/0x260
[  370.927393]  ? efi_partition+0x820/0x820
[  370.927413]  ? do_wait_intr_irq+0xb0/0xb0
[  370.927446]  __blk_mq_alloc_requests+0x16b/0x390
[  370.927481]  blk_mq_submit_bio+0x217/0x840
[  370.927527]  submit_bio_noacct+0x2ae/0x2c0
[  370.927549]  btrfs_map_bio+0x198/0x4d0
[  370.927570]  ? btree_csum_one_bio+0x236/0x2a0
[  370.927602]  btrfs_submit_metadata_bio+0x8a/0x130
[  370.927622]  submit_one_bio+0x6c/0x80
[  370.927630]  submit_extent_page+0x1a0/0x5d0
[  370.927654]  ? lock_release+0x151/0x460
[  370.927684]  ? __folio_start_writeback+0x7f/0x360
[  370.927724]  write_one_eb+0xfe/0x210
[  370.927736]  ? set_btree_ioerr+0x70/0x70
[  370.927781]  btree_write_cache_pages+0x61e/0x8f0
[  370.927953]  do_writepages+0xbf/0x1b0
[  370.927974]  ? lock_release+0x151/0x460
[  370.928004]  ? _raw_spin_unlock+0x29/0x40
[  370.928027]  filemap_fdatawrite_wbc+0x62/0x90
[  370.928043]  filemap_fdatawrite_range+0x46/0x50
[  370.928082]  btrfs_write_marked_extents+0x58/0x140
[  370.928113]  btrfs_write_and_wait_transaction+0x36/0xa0
[  370.928147]  btrfs_commit_transaction+0x711/0xad0
[  370.928195]  transaction_kthread+0x133/0x1a0
[  370.928215]  ? btrfs_cleanup_transaction.isra.0+0x640/0x640
[  370.928231]  kthread+0x17a/0x1a0
[  370.928244]  ? set_kthread_struct+0x40/0x40
[  370.928265]  ret_from_fork+0x1f/0x30
[  370.928328]  </TASK>
[  370.928336] INFO: task systemd-journal:593 blocked for more than 122 seconds.
[  370.928344]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.928350] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.928356] task:systemd-journal state:D stack:11848 pid:  593
ppid:     1 flags:0x00000000
[  370.928375] Call Trace:
[  370.928380]  <TASK>
[  370.928400]  __schedule+0x3f8/0x1500
[  370.928416]  ? lock_is_held_type+0xea/0x140
[  370.928461]  schedule+0x4e/0xc0
[  370.928478]  io_schedule+0x47/0x70
[  370.928494]  folio_wait_bit_common+0x14a/0x400
[  370.928532]  ? folio_unlock+0x50/0x50
[  370.928560]  folio_wait_writeback+0x18/0x120
[  370.928575]  btrfs_page_mkwrite+0x217/0x7c0
[  370.928618]  do_page_mkwrite+0x4c/0x140
[  370.928639]  do_wp_page+0x27b/0x330
[  370.928658]  __handle_mm_fault+0xbb2/0x14a0
[  370.928722]  handle_mm_fault+0x11e/0x3a0
[  370.928747]  do_user_addr_fault+0x1ea/0x6b0
[  370.928780]  exc_page_fault+0x79/0x2e0
[  370.928791]  ? asm_exc_page_fault+0x8/0x30
[  370.928807]  asm_exc_page_fault+0x1e/0x30
[  370.928819] RIP: 0033:0x7f05453d8fc5
[  370.928832] RSP: 002b:00007ffc1fd7bed0 EFLAGS: 00010202
[  370.928845] RAX: 00007f05440f8ef0 RBX: 000000000000006b RCX: 00007ffc1fd7bef0
[  370.928852] RDX: 0000558cb2eb8338 RSI: 0000558cb2eb1b50 RDI: 0000558cb2ea6260
[  370.928859] RBP: 0000000000000001 R08: 0000000000879ef0 R09: 000000000000006b
[  370.928867] R10: 00007ffc1fd86080 R11: 00007ffc1fd86090 R12: 0000558cb2eb8300
[  370.928928] R13: 00007ffc1fd7bfe0 R14: 0000000000879ef0 R15: 0000000008510980
[  370.928989]  </TASK>
[  370.929007] INFO: task btrfs-transacti:764 blocked for more than 122 seconds.
[  370.929014]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.929020] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.929025] task:btrfs-transacti state:D stack:13272 pid:  764
ppid:     2 flags:0x00004000
[  370.929044] Call Trace:
[  370.929049]  <TASK>
[  370.929068]  __schedule+0x3f8/0x1500
[  370.929092]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  370.929106]  ? lockdep_hardirqs_on+0x7e/0x100
[  370.929119]  ? _raw_spin_unlock_irqrestore+0x3e/0x60
[  370.929146]  schedule+0x4e/0xc0
[  370.929163]  btrfs_commit_transaction+0x8f3/0xad0
[  370.929183]  ? start_transaction+0xc7/0x6a0
[  370.929199]  ? do_wait_intr_irq+0xb0/0xb0
[  370.929231]  transaction_kthread+0x133/0x1a0
[  370.929251]  ? btrfs_cleanup_transaction.isra.0+0x640/0x640
[  370.929267]  kthread+0x17a/0x1a0
[  370.929279]  ? set_kthread_struct+0x40/0x40
[  370.929301]  ret_from_fork+0x1f/0x30
[  370.929363]  </TASK>
[  370.929393] INFO: task kworker/u16:13:1006 blocked for more than 122 seconds.
[  370.929400]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.929406] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.929412] task:kworker/u16:13  state:D stack:12584 pid: 1006
ppid:     2 flags:0x00004000
[  370.929431] Workqueue: btrfs-delalloc btrfs_work_helper
[  370.929449] Call Trace:
[  370.929453]  <TASK>
[  370.929473]  __schedule+0x3f8/0x1500
[  370.929486]  ? mark_held_locks+0x50/0x80
[  370.929506]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  370.929531]  ? rq_qos_wait+0xaf/0x120
[  370.929546]  ? wbt_rqw_done+0xf0/0xf0
[  370.929562]  schedule+0x4e/0xc0
[  370.929580]  io_schedule+0x47/0x70
[  370.929595]  rq_qos_wait+0xb4/0x120
[  370.929612]  ? efi_partition+0x820/0x820
[  370.929634]  ? wbt_cleanup_cb+0x20/0x20
[  370.929661]  wbt_wait+0x77/0xc0
[  370.929685]  __rq_qos_throttle+0x20/0x30
[  370.929703]  blk_mq_submit_bio+0x1ec/0x840
[  370.929748]  submit_bio_noacct+0x2ae/0x2c0
[  370.929771]  btrfs_map_bio+0x198/0x4d0
[  370.929814]  btrfs_submit_compressed_write+0x2ee/0x400
[  370.929934]  submit_compressed_extents+0x26f/0x400
[  370.929998]  async_cow_submit+0x37/0x90
[  370.930014]  btrfs_work_helper+0x13e/0x430
[  370.930051]  process_one_work+0x2b2/0x610
[  370.930097]  worker_thread+0x55/0x3c0
[  370.930118]  ? process_one_work+0x610/0x610
[  370.930133]  kthread+0x17a/0x1a0
[  370.930146]  ? set_kthread_struct+0x40/0x40
[  370.930167]  ret_from_fork+0x1f/0x30
[  370.930230]  </TASK>
[  370.930262] INFO: task gvfsd-metadata:1832 blocked for more than 122 seconds.
[  370.930269]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.930275] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.930280] task:gvfsd-metadata  state:D stack:12984 pid: 1832
ppid:  1550 flags:0x00004000
[  370.930299] Call Trace:
[  370.930304]  <TASK>
[  370.930324]  __schedule+0x3f8/0x1500
[  370.930339]  ? lock_is_held_type+0xea/0x140
[  370.930355]  ? find_held_lock+0x32/0x90
[  370.930391]  schedule+0x4e/0xc0
[  370.930408]  io_schedule+0x47/0x70
[  370.930423]  folio_wait_bit_common+0x14a/0x400
[  370.930462]  ? folio_unlock+0x50/0x50
[  370.930490]  folio_wait_writeback+0x18/0x120
[  370.930505]  extent_write_cache_pages+0x24f/0x4b0
[  370.930590]  extent_writepages+0x81/0x100
[  370.930616]  do_writepages+0xbf/0x1b0
[  370.930633]  ? lock_release+0x151/0x460
[  370.930663]  ? _raw_spin_unlock+0x29/0x40
[  370.930685]  filemap_fdatawrite_wbc+0x62/0x90
[  370.930701]  filemap_fdatawrite_range+0x46/0x50
[  370.930739]  start_ordered_ops.constprop.0+0x38/0x80
[  370.930768]  btrfs_sync_file+0xa0/0x5a0
[  370.930780]  ? lock_release+0x151/0x460
[  370.930829]  __x64_sys_fsync+0x33/0x60
[  370.930849]  do_syscall_64+0x38/0x90
[  370.930866]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  370.930976] RIP: 0033:0x7fe5b61602bb
[  370.930995] RSP: 002b:00007fff9ee62da0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  370.931018] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5b61602bb
[  370.931031] RDX: 0000000000000000 RSI: 00005636d1fa4420 RDI: 000000000000000a
[  370.931044] RBP: 00007fe59c0023a0 R08: 0000000000000000 R09: 0000000000000070
[  370.931056] R10: 0000000000000180 R11: 0000000000000293 R12: 00005636d1f72c00
[  370.931068] R13: 000000000000000a R14: 00005636d1fb9ab4 R15: 00007fff9ee62e08
[  370.931179]  </TASK>
[  370.931223] INFO: task GeckoMain:2629 blocked for more than 122 seconds.
[  370.931232]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.931239] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.931244] task:GeckoMain       state:D stack:11088 pid: 2629
ppid:  1692 flags:0x00000000
[  370.931264] Call Trace:
[  370.931269]  <TASK>
[  370.931290]  __schedule+0x3f8/0x1500
[  370.931305]  ? mark_held_locks+0x50/0x80
[  370.931326]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  370.931344]  ? __sbitmap_get_word+0x30/0x80
[  370.931373]  schedule+0x4e/0xc0
[  370.931391]  io_schedule+0x47/0x70
[  370.931406]  blk_mq_get_tag+0x10c/0x260
[  370.931426]  ? do_wait_intr_irq+0xb0/0xb0
[  370.931458]  __blk_mq_alloc_requests+0x16b/0x390
[  370.931493]  blk_mq_submit_bio+0x217/0x840
[  370.931538]  submit_bio_noacct+0x2ae/0x2c0
[  370.931563]  btrfs_map_bio+0x198/0x4d0
[  370.931607]  btrfs_submit_compressed_read+0x468/0x510
[  370.931639]  ? rcu_read_lock_sched_held+0x3f/0x70
[  370.931653]  ? kmem_cache_alloc+0x32b/0x490
[  370.931691]  btrfs_submit_data_bio+0x203/0x210
[  370.931727]  submit_one_bio+0x4f/0x80
[  370.931734]  submit_extent_page+0xae/0x5d0
[  370.931761]  ? find_held_lock+0x32/0x90
[  370.931772]  ? sched_clock_cpu+0xb/0xc0
[  370.931792]  ? lock_release+0x151/0x460
[  370.931833]  btrfs_do_readpage+0x273/0x8d0
[  370.931844]  ? btrfs_repair_one_sector+0x3f0/0x3f0
[  370.931966]  ? extent_readahead+0x93/0x580
[  370.931980]  extent_readahead+0x4a4/0x580
[  370.932071]  read_pages+0x61/0x310
[  370.932107]  page_cache_ra_unbounded+0x1ac/0x290
[  370.932152]  filemap_fault+0x2f9/0xb80
[  370.932173]  ? filemap_map_pages+0x20a/0x790
[  370.932209]  __do_fault+0x37/0x190
[  370.932226]  __handle_mm_fault+0xd4d/0x14a0
[  370.932289]  handle_mm_fault+0x11e/0x3a0
[  370.932314]  do_user_addr_fault+0x1ea/0x6b0
[  370.932347]  exc_page_fault+0x79/0x2e0
[  370.932358]  ? asm_exc_page_fault+0x8/0x30
[  370.932374]  asm_exc_page_fault+0x1e/0x30
[  370.932385] RIP: 0033:0x7fed047b4b0a
[  370.932395] RSP: 002b:00007fff72f49ad0 EFLAGS: 00010202
[  370.932407] RAX: 00007fecce6f6008 RBX: 00007fecce6f6008 RCX: 00007fecce6f6008
[  370.932413] RDX: 00007fecf1969564 RSI: 00000000000047e9 RDI: 00000000000047e9
[  370.932420] RBP: 00007fecce6f6008 R08: 00000000000047e0 R09: 0000000000001a60
[  370.932426] R10: 0000000000000000 R11: 00007fecce6f6008 R12: 00007fecce6f6008
[  370.932433] R13: 00007fecf1969564 R14: 00007fff72f49e80 R15: 00000000000047e9
[  370.932491]  </TASK>
[  370.932500] INFO: task Permission:2665 blocked for more than 122 seconds.
[  370.932508]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.932514] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.932519] task:Permission      state:D stack:13760 pid: 2665
ppid:  1692 flags:0x00004000
[  370.932538] Call Trace:
[  370.932543]  <TASK>
[  370.932563]  __schedule+0x3f8/0x1500
[  370.932579]  ? lock_is_held_type+0xea/0x140
[  370.932596]  ? find_held_lock+0x32/0x90
[  370.932631]  schedule+0x4e/0xc0
[  370.932649]  io_schedule+0x47/0x70
[  370.932664]  folio_wait_bit_common+0x14a/0x400
[  370.932703]  ? folio_unlock+0x50/0x50
[  370.932731]  folio_wait_writeback+0x18/0x120
[  370.932746]  extent_write_cache_pages+0x24f/0x4b0
[  370.932831]  extent_writepages+0x81/0x100
[  370.932858]  do_writepages+0xbf/0x1b0
[  370.932928]  ? lock_release+0x151/0x460
[  370.932960]  ? _raw_spin_unlock+0x29/0x40
[  370.932983]  filemap_fdatawrite_wbc+0x62/0x90
[  370.932999]  filemap_fdatawrite_range+0x46/0x50
[  370.933037]  start_ordered_ops.constprop.0+0x38/0x80
[  370.933068]  btrfs_sync_file+0xa0/0x5a0
[  370.933079]  ? lock_release+0x151/0x460
[  370.933128]  __x64_sys_fsync+0x33/0x60
[  370.933147]  do_syscall_64+0x38/0x90
[  370.933165]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  370.933177] RIP: 0033:0x7fed0e3be2bb
[  370.933186] RSP: 002b:00007fecee0bd310 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  370.933198] RAX: ffffffffffffffda RBX: 00007fecf2749ae0 RCX: 00007fed0e3be2bb
[  370.933205] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000046
[  370.933211] RBP: 0000000000000223 R08: 0000000000000000 R09: 00007fed07f37c40
[  370.933218] R10: 00007fff72f9a080 R11: 0000000000000293 R12: 0000000000000002
[  370.933225] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  370.933283]  </TASK>
[  370.933291] INFO: task Cache2 I/O:2678 blocked for more than 122 seconds.
[  370.933298]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.933305] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.933310] task:Cache2 I/O      state:D stack:12600 pid: 2678
ppid:  1692 flags:0x00000000
[  370.933328] Call Trace:
[  370.933333]  <TASK>
[  370.933352]  __schedule+0x3f8/0x1500
[  370.933366]  ? mark_held_locks+0x50/0x80
[  370.933385]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[  370.933403]  ? __sbitmap_get_word+0x30/0x80
[  370.933431]  schedule+0x4e/0xc0
[  370.933448]  io_schedule+0x47/0x70
[  370.933464]  blk_mq_get_tag+0x10c/0x260
[  370.933483]  ? do_wait_intr_irq+0xb0/0xb0
[  370.933515]  __blk_mq_alloc_requests+0x16b/0x390
[  370.933550]  blk_mq_submit_bio+0x217/0x840
[  370.933595]  submit_bio_noacct+0x2ae/0x2c0
[  370.933620]  btrfs_map_bio+0x198/0x4d0
[  370.933639]  ? rcu_read_lock_sched_held+0x3f/0x70
[  370.933671]  btrfs_submit_metadata_bio+0x8a/0x130
[  370.933691]  submit_one_bio+0x6c/0x80
[  370.933699]  read_extent_buffer_pages+0x53d/0x640
[  370.933746]  btree_read_extent_buffer_pages+0x97/0x110
[  370.933781]  read_tree_block+0x39/0x60
[  370.933801]  read_block_for_search+0x17a/0x210
[  370.933845]  btrfs_search_slot+0x206/0x9e0
[  370.933950]  btrfs_lookup_dir_item+0x6c/0xc0
[  370.933983]  btrfs_lookup_dentry+0xa8/0x510
[  370.934002]  ? lockdep_init_map_type+0x51/0x250
[  370.934040]  btrfs_lookup+0xe/0x30
[  370.934051]  __lookup_slow+0x10c/0x1e0
[  370.934084]  ? lock_is_held_type+0xea/0x140
[  370.934117]  ? lock_is_held_type+0xea/0x140
[  370.934145]  walk_component+0x11b/0x190
[  370.934176]  path_lookupat+0x6e/0x1c0
[  370.934200]  filename_lookup+0xbc/0x1a0
[  370.934249]  ? __check_object_size+0x152/0x190
[  370.934269]  ? strncpy_from_user+0x53/0x180
[  370.934305]  user_path_at_empty+0x3a/0x50
[  370.934325]  do_faccessat+0x6e/0x260
[  370.934340]  ? syscall_enter_from_user_mode+0x21/0x70
[  370.934367]  do_syscall_64+0x38/0x90
[  370.934384]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  370.934396] RIP: 0033:0x7fed0e3b799b
[  370.934405] RSP: 002b:00007fecf292aae8 EFLAGS: 00000246 ORIG_RAX:
0000000000000015
[  370.934416] RAX: ffffffffffffffda RBX: 00007fecc80fe920 RCX: 00007fed0e3b799b
[  370.934423] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fecc7457d08
[  370.934429] RBP: 00007fecf292ab4d R08: 0000000000000770 R09: 0000000000000000
[  370.934435] R10: 0000000000000077 R11: 0000000000000246 R12: 00007fecc38bb4c4
[  370.934442] R13: 00007fecc38bb4f0 R14: 00007fecedb692c0 R15: 00007fecc80fe920
[  370.934500]  </TASK>
[  370.934522] INFO: task StreamTrans #11:2762 blocked for more than
122 seconds.
[  370.934529]       Tainted: G        W        --------- ---
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64 #1
[  370.934535] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.934540] task:StreamTrans #11 state:D stack:12776 pid: 2762
ppid:  1692 flags:0x00004000
[  370.934559] Call Trace:
[  370.934564]  <TASK>
[  370.934584]  __schedule+0x3f8/0x1500
[  370.934599]  ? lock_is_held_type+0xea/0x140
[  370.934615]  ? find_held_lock+0x32/0x90
[  370.934651]  schedule+0x4e/0xc0
[  370.934669]  io_schedule+0x47/0x70
[  370.934684]  folio_wait_bit_common+0x14a/0x400
[  370.934723]  ? folio_unlock+0x50/0x50
[  370.934751]  folio_wait_writeback+0x18/0x120
[  370.934766]  extent_write_cache_pages+0x24f/0x4b0
[  370.934820]  ? lock_is_held_type+0xea/0x140
[  370.934836]  ? find_held_lock+0x32/0x90
[  370.934846]  ? sched_clock_cpu+0xb/0xc0
[  370.934947]  extent_writepages+0x81/0x100
[  370.934996]  do_writepages+0xbf/0x1b0
[  370.935024]  ? lock_release+0x151/0x460
[  370.935078]  ? _raw_spin_unlock+0x29/0x40
[  370.935117]  filemap_fdatawrite_wbc+0x62/0x90
[  370.935146]  filemap_fdatawrite_range+0x46/0x50
[  370.935209]  start_ordered_ops.constprop.0+0x38/0x80
[  370.935240]  btrfs_sync_file+0xa0/0x5a0
[  370.935251]  ? lock_release+0x151/0x460
[  370.935300]  __x64_sys_fsync+0x33/0x60
[  370.935320]  do_syscall_64+0x38/0x90
[  370.935337]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  370.935349] RIP: 0033:0x7fed0e3be2bb
[  370.935358] RSP: 002b:00007fecd88bc7f0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  370.935369] RAX: ffffffffffffffda RBX: 00007fecc9b3e740 RCX: 00007fed0e3be2bb
[  370.935376] RDX: 0000000000000000 RSI: 00007fecc95d7000 RDI: 00000000000000b8
[  370.935383] RBP: 00007fecc9425370 R08: 0000000000000000 R09: 00007fecc95d73c0
[  370.935389] R10: 0000000000000010 R11: 0000000000000293 R12: 00000000000000d7
[  370.935396] R13: 00007fed090905f8 R14: 00007fed090905c8 R15: 00007fecc94f87a8
[  370.935455]  </TASK>
[  370.935505]
               Showing all locks held in the system:
[  370.935524] 1 lock held by khungtaskd/56:
[  370.935531]  #0: ffffffffb31914e0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x15/0x16b
[  370.935586] 3 locks held by kworker/u16:5/436:
[  370.935593]  #0: ffff8cfb41e0c948
((wq_completion)writeback){+.+.}-{0:0}, at:
process_one_work+0x21f/0x610
[  370.935630]  #1: ffffad874185fe70
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_one_work+0x21f/0x610
[  370.935664]  #2: ffff8cfb470190e8
(&type->s_umount_key#34){++++}-{3:3}, at: trylock_super+0x16/0x50
[  370.935706] 2 locks held by btrfs-transacti/486:
[  370.935712]  #0: ffff8cfbbe9b0840
(&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at:
transaction_kthread+0x56/0x1a0
[  370.935746]  #1: ffff8cfbbe9b07a0
(&fs_info->tree_log_mutex){+.+.}-{3:3}, at:
btrfs_commit_transaction+0x431/0xad0
[  370.935781] 3 locks held by systemd-journal/593:
[  370.935787]  #0: ffff8cfb47108838 (&mm->mmap_lock#2){++++}-{3:3},
at: do_user_addr_fault+0x149/0x6b0
[  370.935824]  #1: ffff8cfb470195a8 (sb_pagefaults){.+.+}-{0:0}, at:
do_page_mkwrite+0x4c/0x140
[  370.935855]  #2: ffff8cfbab573698 (&ei->i_mmap_lock){++++}-{3:3},
at: btrfs_page_mkwrite+0x2b3/0x7c0
[  370.935952] 1 lock held by btrfs-transacti/764:
[  370.935959]  #0: ffff8cfb47650840
(&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at:
transaction_kthread+0x56/0x1a0
[  370.936007] 2 locks held by kworker/u16:12/1004:
[  370.936013]  #0: ffff8cfb40ee2948
((wq_completion)blkcg_punt_bio){+.+.}-{0:0}, at:
process_one_work+0x21f/0x610
[  370.936047]  #1: ffffad874245fe70
((work_completion)(&blkg->async_bio_work)){+.+.}-{0:0}, at:
process_one_work+0x21f/0x610
[  370.936081] 2 locks held by kworker/u16:13/1006:
[  370.936087]  #0: ffff8cfbbeaf4548
((wq_completion)btrfs-delalloc){+.+.}-{0:0}, at:
process_one_work+0x21f/0x610
[  370.936120]  #1: ffffad874226fe70
((work_completion)(&work->normal_work)){+.+.}-{0:0}, at:
process_one_work+0x21f/0x610
[  370.936191] 1 lock held by GeckoMain/2629:
[  370.936197]  #0: ffff8cfb72ee57b0
(mapping.invalidate_lock#2){.+.+}-{3:3}, at:
page_cache_ra_unbounded+0x76/0x290
[  370.936238] 2 locks held by Cache2 I/O/2678:
[  370.936244]  #0: ffff8cfb4e0873c8
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
[  370.936280]  #1: ffff8cfb4b70dbc0 (btrfs-tree-01){++++}-{3:3}, at:
__btrfs_tree_read_lock+0x24/0x130
[  370.936326] 2 locks held by mozStorage #1/2823:
[  370.936332]  #0: ffff8cfb6e039068
(&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at:
btrfs_inode_lock+0x38/0x70
[  370.936372]  #1: ffff8cfb6e038ed8 (&ei->i_mmap_lock){++++}-{3:3},
at: btrfs_inode_lock+0x49/0x70
[  370.936410] 2 locks held by IndexedDB #13/3100:
[  370.936416]  #0: ffff8cfb470196b8 (sb_internal){.+.+}-{0:0}, at:
btrfs_sync_file+0x327/0x5a0
[  370.936447]  #1: ffff8cfb88f363c8 (&root->log_mutex){+.+.}-{3:3},
at: btrfs_sync_log+0x5e/0xc20
[  370.936499] 2 locks held by grub2-set-bootf/3060:
[  370.936505]  #0: ffff8cfb49b796b8 (sb_internal){.+.+}-{0:0}, at:
btrfs_sync_file+0x327/0x5a0
[  370.936536]  #1: ffff8cfb80aae3c8 (&root->log_mutex){+.+.}-{3:3},
at: btrfs_sync_log+0x31c/0xc20
[  370.936568] 2 locks held by flatpak/3070:
[  370.936574]  #0: ffff8cfb8e848678
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
[  370.936609]  #1: ffff8cfba87a2bc8 (btrfs-tree-01){++++}-{3:3}, at:
__btrfs_tree_read_lock+0x24/0x130
[  370.936639] 1 lock held by flatpak/3074:
[  370.936645]  #0: ffff8cfb8e848678
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
[  370.936680] 1 lock held by flatpak/3077:
[  370.936686]  #0: ffff8cfb8e848678
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
[  370.936721] 1 lock held by flatpak/3081:
[  370.936727]  #0: ffff8cfb8e848678
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190

[  370.936770] =============================================




-- 
Chris Murphy
