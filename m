Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92893706643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjEQLMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQLMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 07:12:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9CB10FE;
        Wed, 17 May 2023 04:12:36 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3311482ae2cso1369715ab.2;
        Wed, 17 May 2023 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684321956; x=1686913956;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwf+bDRdYHTeNVP2kiVKQR2U5R9UWH6DhipdK4xKsJg=;
        b=s4fsCIDRtzLYU5YVMrtFkKrhDFmcKdj5WbtEVDCwWliL2rGL3af3pW8UIXTy5257mb
         cwMZKJKryyrmt+qmtTZaal5uQzCk5NdTbsqcKe6WqaBhXFu5KfEpm33hO6TYsUBrtSGa
         AO6OSPCPJICgNF6t9D6goS+Hxf5DMmM9ElaZ3mT9AQdV8jKbyJyDcF5pXBVPJl5mLggM
         vaFV0Suqu3Wv0jMR5QAeBbmPDbbz0Tbyo7nIngnMEpbhiqJR7KsewLYQmoB8wIvz6PfC
         u5vFwuXkU7Jpu2Njc1dQ2YIudwK0Ywj19az9ICCT4ArA/lkbS74N/wzHZGPY2Kkhg0nz
         icxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321956; x=1686913956;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwf+bDRdYHTeNVP2kiVKQR2U5R9UWH6DhipdK4xKsJg=;
        b=Ive7qe6inNLiXeib9fnHMd9u7wNh3h8IglehSYRotJGGbvmEKJlzzR7tN/4Dm61obb
         Gb1Iz9v65KxywGK9lCNWVM2Vvq64rm4CZboaI0ZfqpYjJFiJjBS+dcETSmsV7zMp7DZR
         K87iEfWsw1Cr+ItMKx4SVvJvb7L4B3vnMnb7HGoX8suRRMwXMBGNJWxU4KAF6jRSmi3K
         e/AKP7RryJxNMoFEyHegZ2AIgIScTYm1DKAc60j07hZSiPy6I0oOk6+WDd0T6A2moWZZ
         5FrM1BlLmVNK2GbhxMbAhs/w2T1Vcl7lH6TG2cFYD1VE04/bEHsLleQV7MCwQo7LYP6I
         N1sw==
X-Gm-Message-State: AC+VfDxYiZ5c9OQ+wC1FFTwd4qhl0twjhsYuqLjor4UQ5kMIudkV2Q7M
        oHFX8G9k9A97DrzBkNli4tfVgJS/BcuRentLhVU=
X-Google-Smtp-Source: ACHHUZ6qAYZfZGMoYob28zy877Fin56K3EIhduhOSj/eHv7VwZ4FcTevnlL/RrJ5KPbBiUiVQsjg2TLf1spkvqKhgQk=
X-Received: by 2002:a92:d491:0:b0:32b:44b4:25b2 with SMTP id
 p17-20020a92d491000000b0032b44b425b2mr1438070ilg.30.1684321955565; Wed, 17
 May 2023 04:12:35 -0700 (PDT)
MIME-Version: 1.0
From:   yang lan <lanyang0908@gmail.com>
Date:   Wed, 17 May 2023 19:12:23 +0800
Message-ID: <CAAehj2=HQDk-AMYpVR7i91hbQC4G5ULKd9iYoP05u_9tay8VMw@mail.gmail.com>
Subject: INFO: task hung in blkdev_open bug
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We use our modified Syzkaller to fuzz the Linux kernel and found the
following issue:

Head Commit: f1b32fda06d2cfb8eea9680b0ba7a8b0d5b81eeb
Git Tree: stable

Console output: https://pastebin.com/raw/U6yhCfpy
Kernel config: https://pastebin.com/raw/BiggLxRg
C reproducer: https://pastebin.com/raw/6mg7uF8W
Syz reproducer: https://pastebin.com/raw/bSjNi7Vc


root@syzkaller:~# uname -a
Linux syzkaller 5.10.179 #1 SMP PREEMPT Thu Apr 27 16:22:48 CST 2023
x86_64 GNU/Linux
root@syzkaller:~# gcc poc_blkdev.c -o poc_blkdev
root@syzkaller:~# ./poc_blkdev
[  126.866571][ T1949] block nbd0: Possible stuck request
000000002439ca71: control (read@0,1024B). Runtime 30 seconds
[  126.867464][ T1949] block nbd0: Possible stuck request
000000003e3fb642: control (read@1024,1024B). Runtime 30 seconds
[  156.948517][ T1949] block nbd0: Possible stuck request
000000002439ca71: control (read@0,1024B). Runtime 60 seconds
[  156.949284][ T1949] block nbd0: Possible stuck request
000000003e3fb642: control (read@1024,1024B). Runtime 60 seconds
[  187.029585][ T1949] block nbd0: Possible stuck request
000000002439ca71: control (read@0,1024B). Runtime 90 seconds
[  187.030378][ T1949] block nbd0: Possible stuck request
000000003e3fb642: control (read@1024,1024B). Runtime 90 seconds
[  217.110282][ T1949] block nbd0: Possible stuck request
000000002439ca71: control (read@0,1024B). Runtime 120 seconds
[  217.110314][ T1949] block nbd0: Possible stuck request
000000003e3fb642: control (read@1024,1024B). Runtime 120 seconds
[  247.190786][ T1949] block nbd0: Possible stuck request
000000002439ca71: control (read@0,1024B). Runtime 150 seconds
[  247.191613][ T1949] block nbd0: Possible stuck request
000000003e3fb642: control (read@1024,1024B). Runtime 150 seconds
[  277.271159][ T1949] block nbd0: Possible stuck request
000000002439ca71: control (read@0,1024B). Runtime 180 seconds
[  277.271982][ T1949] block nbd0: Possible stuck request
000000003e3fb642: control (read@1024,1024B). Runtime 180 seconds
[  284.951335][ T1552] INFO: task systemd-udevd:7629 blocked for more
than 143 seconds.
[  284.952044][ T1552]       Not tainted 5.10.179 #1
[  284.952368][ T1552] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  284.952928][ T1552] task:systemd-udevd   state:D stack:26160 pid:
7629 ppid:  4451 flags:0x00004304
[  284.953533][ T1552] Call Trace:
[  284.953766][ T1552]  __schedule+0xae4/0x1e10
[  284.954061][ T1552]  ? __sched_text_start+0x8/0x8
[  284.954400][ T1552]  ? preempt_schedule_thunk+0x16/0x18
[  284.954754][ T1552]  ? preempt_schedule_common+0x37/0xc0
[  284.955112][ T1552]  schedule+0xc3/0x270
[  284.955389][ T1552]  io_schedule+0x17/0x70
[  284.955671][ T1552]  wait_on_page_bit_common+0x542/0xcb0
[  284.956032][ T1552]  ? find_get_pages_range_tag+0xe40/0xe40
[  284.956407][ T1552]  ? bdev_disk_changed+0x3f0/0x3f0
[  284.956746][ T1552]  ? end_buffer_async_write+0x5c0/0x5c0
[  284.957112][ T1552]  ? find_get_pages_contig+0xc20/0xc20
[  284.957473][ T1552]  do_read_cache_page+0x66b/0x1000
[  284.957810][ T1552]  ? enable_ptr_key_workfn+0x30/0x30
[  284.958167][ T1552]  read_part_sector+0xf6/0x610
[  284.958486][ T1552]  ? adfspart_check_ADFS+0x800/0x800
[  284.958834][ T1552]  adfspart_check_ICS+0x9a/0xd00
[  284.959161][ T1552]  ? pointer+0x790/0x790
[  284.959442][ T1552]  ? adfspart_check_ADFS+0x800/0x800
[  284.959792][ T1552]  ? snprintf+0xae/0xe0
[  284.960067][ T1552]  ? vsprintf+0x30/0x30
[  284.960353][ T1552]  ? adfspart_check_ADFS+0x800/0x800
[  284.960700][ T1552]  blk_add_partitions+0x47a/0xe70
[  284.961035][ T1552]  bdev_disk_changed+0x249/0x3f0
[  284.961787][ T1552]  __blkdev_get+0xdb8/0x15b0
[  284.962139][ T1552]  ? rcu_read_lock_sched_held+0xd0/0xd0
[  284.962512][ T1552]  ? __blkdev_put+0x720/0x720
[  284.962826][ T1552]  ? devcgroup_check_permission+0x1ac/0x470
[  284.963209][ T1552]  blkdev_get+0xd1/0x250
[  284.963490][ T1552]  blkdev_open+0x20a/0x290
[  284.963783][ T1552]  do_dentry_open+0x69a/0x1240
[  284.964097][ T1552]  ? bd_acquire+0x2c0/0x2c0
[  284.964400][ T1552]  path_openat+0xd7d/0x2720
[  284.964701][ T1552]  ? path_lookupat.isra.41+0x560/0x560
[  284.965059][ T1552]  ? lock_downgrade+0x6a0/0x6a0
[  284.965379][ T1552]  ? alloc_set_pte+0x448/0x1b00
[  284.965697][ T1552]  ? xas_find+0x325/0x900
[  284.965986][ T1552]  ? find_held_lock+0x33/0x1c0
[  284.966316][ T1552]  do_filp_open+0x1a4/0x270
[  284.966617][ T1552]  ? may_open_dev+0xf0/0xf0
[  284.966921][ T1552]  ? rwlock_bug.part.1+0x90/0x90
[  284.967252][ T1552]  ? do_raw_spin_unlock+0x172/0x260
[  284.967595][ T1552]  ? __alloc_fd+0x2a9/0x620
[  284.967907][ T1552]  do_sys_openat2+0x5db/0x8c0
[  284.968218][ T1552]  ? file_open_root+0x400/0x400
[  284.968541][ T1552]  do_sys_open+0xca/0x140
[  284.968830][ T1552]  ? filp_open+0x70/0x70
[  284.969114][ T1552]  ? __secure_computing+0x100/0x360
[  284.969458][ T1552]  do_syscall_64+0x2d/0x70
[  284.969754][ T1552]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
[  284.970146][ T1552] RIP: 0033:0x7fd2bc544840
[  284.970448][ T1552] RSP: 002b:00007ffe6f0c4778 EFLAGS: 00000246
ORIG_RAX: 0000000000000002
[  284.971550][ T1552] RAX: ffffffffffffffda RBX: 000055f0dc215e90
RCX: 00007fd2bc544840
[  284.972099][ T1552] RDX: 000055f0db45cfe3 RSI: 00000000000a0800
RDI: 000055f0dc229760
[  284.972622][ T1552] RBP: 00007ffe6f0c48f0 R08: 000055f0db45c670
R09: 0000000000000010
[  284.973143][ T1552] R10: 000055f0db45cd0c R11: 0000000000000246
R12: 00007ffe6f0c4840
[  284.973666][ T1552] R13: 000055f0dc22aa70 R14: 0000000000000003
R15: 000000000000000e
[  284.974207][ T1552]
[  284.974207][ T1552] Showing all locks held in the system:
[  284.974729][ T1552] 1 lock held by khungtaskd/1552:
[  284.975057][ T1552]  #0: ffffffff8ae9cea0
(rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x52/0x29f
[  284.975721][ T1552] 2 locks held by kworker/u8:0/1940:
[  284.976066][ T1552]  #0: ffff888018636938
((wq_completion)knbd0-recv){+.+.}-{0:0}, at:
process_one_work+0x8e2/0x15d0
[  284.976782][ T1552]  #1: ffff8880110f7e00
((work_completion)(&args->work)){+.+.}-{0:0}, at:
process_one_work+0x917/0x15d0
[  284.977539][ T1552] 1 lock held by in:imklog/7416:
[  284.977860][ T1552]  #0: ffff888041b50ff0
(&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x110
[  284.978476][ T1552] 1 lock held by systemd-udevd/7629:
[  284.978819][ T1552]  #0: ffff88800f813480
(&bdev->bd_mutex){+.+.}-{3:3}, at: __blkdev_get+0x45e/0x15b0
[  284.979450][ T1552]
[  284.979606][ T1552] =============================================
[  284.979606][ T1552]
[  284.980153][ T1552] NMI backtrace for cpu 0
[  284.980443][ T1552] CPU: 0 PID: 1552 Comm: khungtaskd Not tainted 5.10.179 #1
[  284.980915][ T1552] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.12.0-1 04/01/2014
[  284.981513][ T1552] Call Trace:
[  284.981739][ T1552]  dump_stack+0x106/0x162
[  284.982026][ T1552]  nmi_cpu_backtrace.cold.8+0x44/0xd5
[  284.982382][ T1552]  ? lapic_can_unplug_cpu+0x70/0x70
[  284.982725][ T1552]  nmi_trigger_cpumask_backtrace+0x1aa/0x1e0
[  284.983117][ T1552]  watchdog+0xd5a/0xf80
[  284.983398][ T1552]  ? hungtask_pm_notify+0xa0/0xa0
[  284.983726][ T1552]  kthread+0x3aa/0x490
[  284.983994][ T1552]  ? __kthread_cancel_work+0x190/0x190
[  284.984358][ T1552]  ret_from_fork+0x1f/0x30
[  284.984703][ T1552] Sending NMI from CPU 0 to CPUs 1:
[  284.985306][    C1] NMI backtrace for cpu 1
[  284.985309][    C1] CPU: 1 PID: 7417 Comm: rs:main Q:Reg Not
tainted 5.10.179 #1
[  284.985312][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.12.0-1 04/01/2014
[  284.985314][    C1] RIP: 0010:check_memory_region+0x11c/0x1e0
[  284.985318][    C1] Code: 00 fc ff df 49 01 d9 49 01 c0 eb 03 49 89
c0 4d 39 c8 0f 84 8a 00 00 00 41 80 38 00 49 8d 40 01 74 ea eb b0 41
bc 08 00 00 00 <45> 29 c4 4d 89 c8 4b 8d 1c 0c eb 0c 49 83 c0 01 48 89
d8 49 39 d8
[  284.985320][    C1] RSP: 0018:ffff888046fef988 EFLAGS: 00000202
4.9853
000000 M Ces1sa]ge  fRroAm Xsy: ffslfogfd@esydzk1al0le0r 9ca9at1 A4pr7
2 8 R07B:5X:0: 003600 0..0.
 K9 R CkeXrn:el :[f  ff28f4.f9fff8386b0654]d[ cT1255e2]
ernel[ p a ni2c 8- 4n.o985326][    C1] RDX: 0000000000000001 RSI:
00000000000005c2 RDI: ffff88804e548a3e
[  284.985328][    C1] RBP: ffffed1009ca9200 R08: 0000000000000007
R09: ffffed1009ca9147
[  284.985331][    C1] R10: ffff88804e548fff R11: ffffed1009ca91ff
R12: 0000000000000008
[  284.985333][    C1] R13: 00007f74bc025152 R14: 0000000000000000
R15: 00000000000005c2
[  284.985335][    C1] FS:  00007f74c5e32700(0000)
GS:ffff88807ec00000(0000) knlGS:0000000000000000
[  284.985337][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  284.985339][    C1] CR2: 00007f098c751008 CR3: 0000000049b08000
CR4: 0000000000350ee0
[  284.985341][    C1] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[  284.985343][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[  284.985345][    C1] Call Trace:
[  284.985346][    C1]  copyin+0xde/0x110
[  284.985348][    C1]  iov_iter_copy_from_user_atomic+0x404/0xcf0
[  284.985349][    C1]  ? rcu_is_watching+0x11/0xb0
[  284.985351][    C1]  ? __mark_inode_dirty+0x13b/0xd90
[  284.985352][    C1]  ? current_time+0xb6/0x120
[  284.985354][    C1]  generic_perform_write+0x337/0x4d0
[  284.985356][    C1]  ? file_update_time+0xd0/0x470
[  284.985357][    C1]  ? filemap_check_errors+0x150/0x150
[  284.985359][    C1]  ? inode_update_time+0xb0/0xb0
[  284.985360][    C1]  ? down_write+0xdb/0x150
[  284.985362][    C1]  ext4_buffered_write_iter+0x20d/0x470
[  284.985363][    C1]  ext4_file_write_iter+0x426/0x1400
[  284.985365][    C1]  ? __lock_acquire+0x1839/0x5e90
[  284.985366][    C1]  ? lock_release+0x631/0x660
[  284.985368][    C1]  ? ext4_buffered_write_iter+0x470/0x470
[  284.985370][    C1]  ? lockdep_hardirqs_on_prepare+0x3f0/0x3f0
[  284.985371][    C1]  new_sync_write+0x491/0x660
[  284.985373][    C1]  ? new_sync_read+0x6e0/0x6e0
[  284.985374][    C1]  ? __fdget_pos+0xeb/0x110
[  284.985376][    C1]  ? rcu_read_lock_held+0xb0/0xb0
[  284.985377][    C1]  vfs_write+0x671/0xa90
[  284.985378][    C1]  ksys_write+0x11f/0x240
[  284.985380][    C1]  ? __ia32_sys_read+0xb0/0xb0
[  284.985381][    C1]  ? syscall_enter_from_user_mode+0x26/0x70
[  284.985383][    C1]  do_syscall_64+0x2d/0x70
[  284.985385][    C1]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
[  284.985386][    C1] RIP: 0033:0x7f74c88761cd
[  284.985390][    C1] Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48
3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01
00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4
08 48 3d 01
[  284.985392][    C1] RSP: 002b:00007f74c5e31590 EFLAGS: 00000293
ORIG_RAX: 0000000000000001
[  284.985396][    C1] RAX: ffffffffffffffda RBX: 00007f74bc024b90
RCX: 00007f74c88761cd
[  284.985398][    C1] RDX: 0000000000000d21 RSI: 00007f74bc024b90
RDI: 0000000000000006
[  284.985400][    C1] RBP: 0000000000000000 R08: 0000000000000000
R09: 0000000000000000
[  284.985403][    C1] R10: 0000000000000000 R11: 0000000000000293
R12: 00007f74bc024910
[  284.985405][    C1] R13: 00007f74c5e315b0 R14: 0000558be67cb360
R15: 0000000000000d21
[  284.986064][ T1552] Kernel panic - not syncing: hung_task: blocked tasks
[  285.008567][ T1552] CPU: 0 PID: 1552 Comm: khungtaskd Not tainted 5.10.179 #1
[  285.009039][ T1552] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.12.0-1 04/01/2014
[  285.009625][ T1552] Call Trace:
[  285.009848][ T1552]  dump_stack+0x106/0x162
[  285.010138][ T1552]  panic+0x2d8/0x6fb
[  285.010395][ T1552]  ? print_oops_end_marker.cold.9+0x15/0x15
[  285.010786][ T1552]  ? cpumask_next+0x3c/0x40
[  285.011079][ T1552]  ? printk_safe_flush+0xd7/0x120
[  285.011408][ T1552]  ? watchdog.cold.5+0x5/0x15f
[  285.011719][ T1552]  ? watchdog+0xb36/0xf80
[  285.012003][ T1552]  watchdog.cold.5+0x16/0x15f
[  285.012312][ T1552]  ? hungtask_pm_notify+0xa0/0xa0
[  285.012639][ T1552]  kthread+0x3aa/0x490
[  285.012912][ T1552]  ? __kthread_cancel_work+0x190/0x190
[  285.013269][ T1552]  ret_from_fork+0x1f/0x30
[  285.013915][ T1552] Kernel Offset: disabled
[  285.014241][ T1552] Rebooting in 86400 seconds..

Please let me know if I can provide any more information, and I hope I
didn't mess up this bug report.

Regards,

Yang
