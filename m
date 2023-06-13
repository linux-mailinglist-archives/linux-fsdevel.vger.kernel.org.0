Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA172EBB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 21:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjFMTNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjFMTNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:13:04 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087771BD7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 12:13:03 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-777a93b3277so634384539f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 12:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683582; x=1689275582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCNqdunKDuVY4aQw92zFkhhfWi7DLSQ56UGFt9Om+VA=;
        b=kNL3mbaNQ++vTU2/gH2WwY1FFN+a9vYE2kn8n49ucyd/qqiEMtZN7c/tiR91EmiWvf
         LU52TbWgmZo2pygmJRdBNg1smGWfAhc85aJar4x8kgX6SBjMaNgrQp0E1ewcU5wKVrLt
         dsFMH5iaH/xY/UnYIP69q79g0akHyazG4S+q7pgcDHpyZHZ73LKvI/5ar+5GwiZvyZAX
         Qyy8uejwUS9UZhI9gM9DpljBCMXG/PomdE7EqtqJm+b7n9+ZQ0QL6atL3G11dTR16ePO
         EpH0FesjfXb0BxSkzkLFqwhOvEjJKnE2pmt/RA4P2LPpzZ/xJIWKGiZHH8QF/DqujpGN
         zezA==
X-Gm-Message-State: AC+VfDyPyzg0N0s3pWVDv6OiGG6pIf7NikTnVUIzdKmLwQZroDic/0s8
        Bjo7NVuB9Ypaxjio6HB3egmkPTJA4ymTVDJKxc6Eow4FqySogvmmWA==
X-Google-Smtp-Source: ACHHUZ5Kc3S8nfvS+Ei/DvQAZwxWT0Y3C6QjfRbQBEmGZOPCQnb5kpwPL9uE2LywEbAopkf22ohUqmqTZQGnJ7YYt13vhhjzMf0r
MIME-Version: 1.0
X-Received: by 2002:a6b:fd15:0:b0:777:afc6:8da0 with SMTP id
 c21-20020a6bfd15000000b00777afc68da0mr5335883ioi.1.1686683582324; Tue, 13 Jun
 2023 12:13:02 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:13:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5e79405fe079f9d@google.com>
Subject: [syzbot] [reiserfs?] UBSAN: array-index-out-of-bounds in direntry_create_vi
From:   syzbot <syzbot+e5bb9eb00a5a5ed2a9a2@syzkaller.appspotmail.com>
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

HEAD commit:    1f6ce8392d6f Add linux-next specific files for 20230613
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164a5a9b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=e5bb9eb00a5a5ed2a9a2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d9bf45aeae9/disk-1f6ce839.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0b03ef83e17/vmlinux-1f6ce839.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6c21a24174d/bzImage-1f6ce839.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5bb9eb00a5a5ed2a9a2@syzkaller.appspotmail.com

REISERFS (device loop2): checking transaction log (loop2)
REISERFS (device loop2): Using r5 hash to sort names
reiserfs: enabling write barrier flush mode
REISERFS (device loop2): Created .reiserfs_priv - reserved for xattr storage.
================================================================================
UBSAN: array-index-out-of-bounds in fs/reiserfs/item_ops.c:485:21
index 1 is out of range for type '__u16 [1]'
CPU: 1 PID: 10154 Comm: syz-executor.2 Not tainted 6.4.0-rc6-next-20230613-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
 direntry_create_vi+0x8db/0x9f0 fs/reiserfs/item_ops.c:485
 create_virtual_node+0x748/0x1a70 fs/reiserfs/fix_node.c:115
 ip_check_balance fs/reiserfs/fix_node.c:1412 [inline]
 check_balance fs/reiserfs/fix_node.c:2083 [inline]
 fix_nodes+0x42e9/0x8660 fs/reiserfs/fix_node.c:2635
 reiserfs_paste_into_item+0x51a/0x8d0 fs/reiserfs/stree.c:2128
 reiserfs_get_block+0x165c/0x4100 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x3b1/0x14a0 fs/buffer.c:2128
 reiserfs_write_begin+0x36e/0xa60 fs/reiserfs/inode.c:2773
 generic_cont_expand_simple+0x117/0x1f0 fs/buffer.c:2488
 reiserfs_setattr+0x395/0x1370 fs/reiserfs/inode.c:3304
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 do_sys_ftruncate+0x549/0x780 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd1ea48c199
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd1eb140168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fd1ea5abf80 RCX: 00007fd1ea48c199
RDX: 0000000000000000 RSI: 0000000006000000 RDI: 0000000000000005
RBP: 00007fd1ea4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe9b988ecf R14: 00007fd1eb140300 R15: 0000000000022000
 </TASK>
================================================================================


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
