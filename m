Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38531734B3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 07:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFSFPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 01:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFSFPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:15:02 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49341E4D
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 22:15:01 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77d99de0e9bso246524539f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 22:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687151700; x=1689743700;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axxZo+KE2DKisJ8Ab+8iO5Cith6Yikyh/rebA+GW7eM=;
        b=IrBjS0xPprK+XBzIjBYrEOkt3mwTB/3CbPQ3z5cMGgefSAXDGBfFxOwduebS98tnqT
         J4cz4RRFEYQjIvQHDd1gSU8caW/9YvnbafkFkscX+hWZscsvwx98rEMMkbApd9yBVram
         EnmXjtF6duyIpSGb8CLPie3GbSbJWotyrJhhHER0vFbJxjEEjspFf4SuGRrjD0rInIC5
         rKEQTPHIGzo+xCHysz/CXA3N4ep8wDfVoNj3Yb5oxQYTwyf2lrZRQvGIzYg0rUZTndw6
         Yf9bvGSAlpelxSQZ+XKDegvqqomUcYpzqYvNTTkjuOFZcrPrjkAknVR6mgZV9HtkXo0O
         qhgA==
X-Gm-Message-State: AC+VfDxb3O2ty+Kii2PIi58V1UQgXNA+ih2CkO8pVF7fALQ+iloD243U
        svivXQT3aQIEnWxsj39WHebfu6+bgmtBg3jgSpObSgXH8KCxsoR+hQ==
X-Google-Smtp-Source: ACHHUZ6G+EGVp7dYtRtrqfOKBHaGisvyLNtcwBMAMNJDrEHt9FDNwUmPtOzrdRO26xEG4nQMKaMhi+ykXtyyy4rNULWDvvK5cWEc
MIME-Version: 1.0
X-Received: by 2002:a6b:7b46:0:b0:777:b438:2926 with SMTP id
 m6-20020a6b7b46000000b00777b4382926mr2593077iop.3.1687151700600; Sun, 18 Jun
 2023 22:15:00 -0700 (PDT)
Date:   Sun, 18 Jun 2023 22:15:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbeb4f05fe749dba@google.com>
Subject: [syzbot] [reiserfs?] KASAN: use-after-free Read in leaf_move_items
From:   syzbot <syzbot+b7d8a575b4546d334d73@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150f9b7f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=b7d8a575b4546d334d73
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7d8a575b4546d334d73@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in leaf_copy_items fs/reiserfs/lbalance.c:617 [inline]
BUG: KASAN: use-after-free in leaf_move_items+0x1fbb/0x2960 fs/reiserfs/lbalance.c:726
Read of size 2 at addr ffff8880429f6ffe by task syz-executor.3/11849

CPU: 0 PID: 11849 Comm: syz-executor.3 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 leaf_copy_items fs/reiserfs/lbalance.c:617 [inline]
 leaf_move_items+0x1fbb/0x2960 fs/reiserfs/lbalance.c:726
 balance_leaf_new_nodes_paste_whole fs/reiserfs/do_balan.c:1162 [inline]
 balance_leaf_new_nodes_paste fs/reiserfs/do_balan.c:1215 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1246 [inline]
 balance_leaf+0x6519/0x12510 fs/reiserfs/do_balan.c:1450
 do_balance+0x30d/0x8f0 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x732/0x870 fs/reiserfs/stree.c:2157
 reiserfs_get_block+0x2250/0x5130 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
 reiserfs_write_begin+0x24d/0x520 fs/reiserfs/inode.c:2773
 generic_cont_expand_simple+0x18b/0x2a0 fs/buffer.c:2425
 reiserfs_setattr+0x57d/0x1140 fs/reiserfs/inode.c:3303
 notify_change+0xc8b/0xf40 fs/attr.c:483
 do_truncate+0x220/0x300 fs/open.c:66
 do_sys_ftruncate+0x2e4/0x380 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6e7688c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e7763e168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f6e769abf80 RCX: 00007f6e7688c389
RDX: 0000000000000000 RSI: 0000000002007fff RDI: 0000000000000008
RBP: 00007f6e768d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff25fd51bf R14: 00007f6e7763e300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00010a7d80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x429f6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea00010a7808 ffffea00010a7d48 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 11767, tgid 11766 (syz-executor.5), ts 1715307232613, free_ts 1718076484344
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 __folio_alloc+0x13/0x30 mm/page_alloc.c:4800
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2240
 shmem_alloc_folio mm/shmem.c:1579 [inline]
 shmem_alloc_and_acct_folio+0x5e7/0xe10 mm/shmem.c:1603
 shmem_get_folio_gfp+0x120f/0x3470 mm/shmem.c:1948
 shmem_get_folio mm/shmem.c:2079 [inline]
 shmem_write_begin+0x172/0x4e0 mm/shmem.c:2573
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3929
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:4057
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4089
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x790/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page_list+0x596/0x830 mm/page_alloc.c:2705
 release_pages+0x2193/0x2470 mm/swap.c:1042
 __pagevec_release+0x84/0x100 mm/swap.c:1062
 pagevec_release include/linux/pagevec.h:63 [inline]
 folio_batch_release include/linux/pagevec.h:132 [inline]
 shmem_undo_range+0x6af/0x1ba0 mm/shmem.c:954
 shmem_truncate_range mm/shmem.c:1049 [inline]
 shmem_evict_inode+0x258/0x9f0 mm/shmem.c:1164
 evict+0x2a4/0x620 fs/inode.c:665
 __dentry_kill+0x436/0x650 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1f3/0x420 fs/dcache.c:913
 __fput+0x5e4/0x890 fs/file_table.c:329
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86

Memory state around the buggy address:
 ffff8880429f6e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880429f6f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880429f6f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                                ^
 ffff8880429f7000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880429f7080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
