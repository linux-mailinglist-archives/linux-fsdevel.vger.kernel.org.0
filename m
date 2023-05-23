Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7870D751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjEWIZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjEWIYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:24:19 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8151FD7
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 01:21:54 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3387d718f4eso9156705ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 01:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830113; x=1687422113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfQJF7F8CzCgiPg/FnTyOygU1Zd7mTMmLMNUmA85cTM=;
        b=FcR6AMI6L/+rXv3143GxV9mnMIrDor+jzjM1v5S4VWXWvsSz5nuWJnv4SdNM92IOab
         AZw2qJkP07i7zp+TiRwNBAhMIDSMUOBrCnlOUFBpnF57667XFCLEKc5KUZWdd+fejjXz
         kBiFUltyXHuT2seIB9kNZa+9LAphnXj0wvINLuP3wAh3WgxJeFKtPezIMSwSKML8Il3a
         3zFY+hOH64smcjHKiaAI+JUs/iz5pSUzqP8FA0oyTntmellfeH1jkqmWvgbgxjtxruNv
         HGJgrNsXXAv8N2pTDRAqGVIMsp+5adbb4khHE3ok2Si3NTXfMGGhJ16uVwUM5nsUbZaH
         td4g==
X-Gm-Message-State: AC+VfDwRwIu4vGE57K6DrHqSPmQa3RSiopJPlwcKxpnvyqOzJVaGr4KN
        2OI1VS7kJeJcdnbPbVmWZbmDBrb3DDhXf8y8hWD2vHH6IPHOcB4nyA==
X-Google-Smtp-Source: ACHHUZ4k/UIBy+giPbPZfgPd2/UC8NWsnFtdZ6aJTckEDvRGfUd7BCwc2olkamKsj4h2UtljgsuKUz69dFwQR3KrbK2RR4Zr9R/l
MIME-Version: 1.0
X-Received: by 2002:a92:cf49:0:b0:33a:557c:402a with SMTP id
 c9-20020a92cf49000000b0033a557c402amr695444ilr.6.1684830113525; Tue, 23 May
 2023 01:21:53 -0700 (PDT)
Date:   Tue, 23 May 2023 01:21:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c771505fc581417@google.com>
Subject: [syzbot] [reiserfs?] KASAN: use-after-free Read in leaf_copy_items_entirely
From:   syzbot <syzbot+7e4b621ae0852681c6e3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    44c026a73be8 Linux 6.4-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111d1bf9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=7e4b621ae0852681c6e3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51c970de1750/disk-44c026a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799aacdbebeb/vmlinux-44c026a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0afc45e7f608/bzImage-44c026a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e4b621ae0852681c6e3@syzkaller.appspotmail.com

REISERFS (device loop2): checking transaction log (loop2)
REISERFS (device loop2): Using r5 hash to sort names
REISERFS (device loop2): using 3.5.x disk format
REISERFS (device loop2): Created .reiserfs_priv - reserved for xattr storage.
==================================================================
BUG: KASAN: use-after-free in leaf_copy_items_entirely+0x1c2/0xee0 fs/reiserfs/lbalance.c:358
Read of size 48 at addr ffff88803e8d9fe8 by task syz-executor.2/17244

CPU: 1 PID: 17244 Comm: syz-executor.2 Not tainted 6.4.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 leaf_copy_items_entirely+0x1c2/0xee0 fs/reiserfs/lbalance.c:358
 leaf_copy_items fs/reiserfs/lbalance.c:610 [inline]
 leaf_move_items+0x101c/0x2960 fs/reiserfs/lbalance.c:726
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
RIP: 0033:0x7fb0fa88c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb0f93fe168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fb0fa9abf80 RCX: 00007fb0fa88c169
RDX: 0000000000000000 RSI: 0000000002007fff RDI: 0000000000000004
RBP: 00007fb0fa8e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee3e87cdf R14: 00007fb0f93fe300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0000fa3640 refcount:1 mapcount:0 mapping:ffff888037946198 index:0x1df1 pfn:0x3e8d9
memcg:ffff8880219c8000
aops:shmem_aops ino:3a7 dentry name:"memfd:syzkaller"
flags: 0xfff0000008001e(referenced|uptodate|dirty|lru|swapbacked|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff0000008001e ffffea0000fa3608 ffffea0000c5e408 ffff888037946198
raw: 0000000000001df1 0000000000000000 00000001ffffffff ffff8880219c8000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 17223, tgid 17221 (syz-executor.0), ts 846949096444, free_ts 845261892059
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
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3923
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:4051
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4083
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
 ffff88803e8d9e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803e8d9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803e8d9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                                          ^
 ffff88803e8da000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803e8da080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
