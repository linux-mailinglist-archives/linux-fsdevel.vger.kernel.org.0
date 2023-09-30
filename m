Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B77B43B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 23:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjI3VH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 17:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjI3VH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:07:57 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D96DA
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 14:07:54 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1dd5dee0774so2260303fac.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 14:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696108073; x=1696712873;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otBfQrmQDL+mpXNdIPmqhYy3fKzQRiuiQTggjywq8j0=;
        b=PQ9IKLgWgRQ6Foz5iM8BGQWyDpG/J5FsVlIlVqlQUOlfbgUrDon6JppYY1YA7/IPkK
         fV8PgUooF32iLatK7Hg78W9j5jYfyYu9uZ6Ki5aC/ZDZUs3ExCORCx2mM5GJDuCZExtz
         zgrFn3BI8qbWj2s0RkOwXeBYDazukCPRAFs9SBjIT3eWIJO7SbcGktuC503Af3SWqLJp
         et83I/HP4d/m1oPDRcN2/MiuiKLWKQ29gvAIz/x2RNMvkgPcWQXQzRLCjfL5z7h+GeXh
         WOTWDLCaohwUIfcnXzyNZhlQShiRAXHbrTjGYEwQKRaokKFa9WfUplpe58JG74fG1M4b
         u4jw==
X-Gm-Message-State: AOJu0YwZqAvquECOnvEOjsW/WEMroWe8coa5ioMhbLLhSbR+q5CMs0VV
        3C2/ALlSxh2pdSDPufaAZ3jFsx12KZL9vXduz4WvMgCyPMBG
X-Google-Smtp-Source: AGHT+IFOvNgeG3dQrAOoJ+6fGQ3TqQPdqxyP8FCTLhsT4NtzUFaqusiKhGBPbaUvkcUlYX5Zu67Av/X92QgG6sZbfG/pl+G/EuJO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a8d:b0:1dc:e0e3:228b with SMTP id
 dt13-20020a0568705a8d00b001dce0e3228bmr3163046oab.0.1696108073623; Sat, 30
 Sep 2023 14:07:53 -0700 (PDT)
Date:   Sat, 30 Sep 2023 14:07:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003aa943060699ef0c@google.com>
Subject: [syzbot] [btrfs?] KASAN: stack-out-of-bounds Read in btrfs_buffered_write
From:   syzbot <syzbot+e5c1bab304c63c107418@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    df964ce9ef9f Add linux-next specific files for 20230929
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c348e6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=880c828d75e38e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=e5c1bab304c63c107418
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe7244c6057d/disk-df964ce9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48cdc7f3b2c0/vmlinux-df964ce9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce7c93a66da9/bzImage-df964ce9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5c1bab304c63c107418@syzkaller.appspotmail.com

BTRFS info (device loop5): auto enabling async discard
==================================================================
BUG: KASAN: stack-out-of-bounds in iterate_bvec include/linux/iov_iter.h:116 [inline]
BUG: KASAN: stack-out-of-bounds in __copy_from_iter_mc+0x30a/0x3f0 lib/iov_iter.c:262
Read of size 4 at addr ffffc9000a0ff574 by task syz-executor.5/8451

CPU: 0 PID: 8451 Comm: syz-executor.5 Not tainted 6.6.0-rc3-next-20230929-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 iterate_bvec include/linux/iov_iter.h:116 [inline]
 __copy_from_iter_mc+0x30a/0x3f0 lib/iov_iter.c:262
 __copy_from_iter lib/iov_iter.c:271 [inline]
 copy_page_from_iter_atomic+0x471/0x11e0 lib/iov_iter.c:504
 btrfs_copy_from_user+0xe7/0x310 fs/btrfs/file.c:61
 btrfs_buffered_write+0xabe/0x12d0 fs/btrfs/file.c:1337
 btrfs_do_write_iter+0xa56/0x1120 fs/btrfs/file.c:1686
 __kernel_write_iter+0x261/0x7e0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x299/0x790 fs/coredump.c:915
 elf_core_dump+0x2700/0x3900 fs/binfmt_elf.c:2142
 do_coredump+0x2c97/0x3fc0 fs/coredump.c:764
 get_signal+0x2434/0x2790 kernel/signal.c:2890
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:87
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2fa447cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2fa51250c8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffe5 RBX: 00007f2fa459bf80 RCX: 00007f2fa447cae9
RDX: 0000000100000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f2fa44c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2fa459bf80 R15: 00007ffd70b99bd8
 </TASK>

The buggy address belongs to stack of task syz-executor.5/8451
 and is located at offset 108 in frame:
 dump_user_range+0x0/0x790 fs/coredump.c:482

This frame has 3 objects:
 [48, 56) 'pos'
 [80, 96) 'bvec'
 [112, 152) 'iter'

The buggy address belongs to the virtual mapping at
 [ffffc9000a0f8000, ffffc9000a101000) created by:
 kernel_clone+0xfd/0x920 kernel/fork.c:2902

The buggy address belongs to the physical page:
page:ffffea0001fce280 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7f38a
memcg:ffff8880291b7482
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff8880291b7482
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 8450, tgid 8450 (syz-executor.5), ts 363006042687, free_ts 362824161389
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x98f/0x32a0 mm/page_alloc.c:3333
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4589
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2304
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0x8f3/0x1bf0 mm/vmalloc.c:3320
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1118 [inline]
 copy_process+0x13e3/0x74b0 kernel/fork.c:2327
 kernel_clone+0xfd/0x920 kernel/fork.c:2902
 __do_sys_clone3+0x1f1/0x260 kernel/fork.c:3203
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1134 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2383
 free_unref_page_list+0xe6/0xb30 mm/page_alloc.c:2564
 release_pages+0x32a/0x14e0 mm/swap.c:1042
 __folio_batch_release+0x77/0xe0 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:83 [inline]
 mapping_try_invalidate+0x39a/0x480 mm/truncate.c:535
 invalidate_bdev+0xb1/0xd0 block/bdev.c:87
 btrfs_close_bdev+0x11a/0x170 fs/btrfs/volumes.c:1017
 btrfs_close_one_device fs/btrfs/volumes.c:1041 [inline]
 close_fs_devices fs/btrfs/volumes.c:1086 [inline]
 close_fs_devices+0x200/0x980 fs/btrfs/volumes.c:1073
 btrfs_close_devices+0x91/0x610 fs/btrfs/volumes.c:1102
 btrfs_free_fs_info+0x4b/0x410 fs/btrfs/disk-io.c:1237
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:484
 deactivate_super+0xde/0x100 fs/super.c:517
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1256
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x215/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296

Memory state around the buggy address:
 ffffc9000a0ff400: f1 f1 f1 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00
 ffffc9000a0ff480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000a0ff500: 00 f1 f1 f1 f1 f1 f1 00 f2 f2 f2 00 00 f2 f2 00
                                                             ^
 ffffc9000a0ff580: 00 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00
 ffffc9000a0ff600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
