Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0437D72ABE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjFJNw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFJNw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:52:57 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359CF30E3
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 06:52:56 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77760439873so328489839f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 06:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686405175; x=1688997175;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1b7InKmJ85x3JSORPjT0+2HX2ERAgCofcz+UFTFAFZ8=;
        b=SpdlXW82L5bhKOuo0NUdz591QVz5ckj2Nt3XzPm2GzTK8+e+PNRuY3p6U3vAyT7sk+
         tQxIQNDYrT+FIwDQS74m7U2XlFiDXcLTT4WIdVaM2ZCapVAvayQXngIChIP0+FfHCO3m
         m/T9picAn6+Dkjkzijc3hmbaG73BJoTe1uR1I3m4bX7Yz1q+qrKesPSnkftH0e4cE5g0
         0LjL7k5nlDgXuYRZQ944wvCvCviFl0DA4osgZ+yrCleTGEWegv4WS7EDWAjLPxdsCHJF
         Y7eVg32g1ut9hAl3tvYAmwgqcy79FSBP4A+m5kxgyWu2hxNHTGmoPfnYcQUxD5p2RNkD
         /YCw==
X-Gm-Message-State: AC+VfDxe+EJKnR4+M3r2QRTTtRNFSoPLt3Wris+RTGcvxMxYM8APtW62
        Uj6EzZaOFC9uJW8ZFmwtzdJSdOVpJ7AxSloPsL7EKJ51ReVK
X-Google-Smtp-Source: ACHHUZ5irBvYRMAMwTewiuyArJivnUAv6hx3GO4ej1lziyx+9dG7+1HQBG/QghQ2LAyd3nKr7sUdckJVxLzAMT8YvMd3Aqj8eq8i
MIME-Version: 1.0
X-Received: by 2002:a02:9542:0:b0:41d:9cf2:f41d with SMTP id
 y60-20020a029542000000b0041d9cf2f41dmr1678161jah.0.1686405175595; Sat, 10 Jun
 2023 06:52:55 -0700 (PDT)
Date:   Sat, 10 Jun 2023 06:52:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070575805fdc6cdb2@google.com>
Subject: [syzbot] [ext4?] BUG: sleeping function called from invalid context
 in ext4_update_super
From:   syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b5d0dd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=4acc7d910e617b360859
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92008b448c84/disk-f8dba31b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/25e27132216c/vmlinux-f8dba31b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72466b6c1237/bzImage-f8dba31b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com

EXT4-fs error (device loop4): ext4_get_group_info:331: comm syz-executor.4: invalid group 4294819419
BUG: sleeping function called from invalid context at include/linux/buffer_head.h:404
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 21305, name: syz-executor.4
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
5 locks held by syz-executor.4/21305:
 #0: ffff8880292c8460 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x5fb/0xff0 fs/read_write.c:1253
 #1: ffff8880391da200 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880391da200 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_buffered_write_iter+0xaf/0x3a0 fs/ext4/file.c:283
 #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_convert_inline_data_to_extent fs/ext4/inline.c:584 [inline]
 #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_write_inline_data+0x51d/0x1360 fs/ext4/inline.c:740
 #3: ffff8880391da088 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x980/0x1cf0 fs/ext4/inode.c:616
 #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at: spin_trylock include/linux/spinlock.h:360 [inline]
 #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_lock_group fs/ext4/ext4.h:3407 [inline]
 #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_mb_try_best_found+0x1ca/0x5a0 fs/ext4/mballoc.c:2166
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 21305 Comm: syz-executor.4 Not tainted 6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __might_resched+0x5cf/0x780 kernel/sched/core.c:10153
 lock_buffer include/linux/buffer_head.h:404 [inline]
 ext4_update_super+0x93/0x1230 fs/ext4/super.c:6039
 ext4_commit_super+0xd0/0x4c0 fs/ext4/super.c:6117
 ext4_handle_error+0x5ee/0x8b0 fs/ext4/super.c:676
 __ext4_error+0x277/0x3b0 fs/ext4/super.c:776
 ext4_get_group_info+0x382/0x3e0 fs/ext4/balloc.c:331
 ext4_mb_new_inode_pa+0x89c/0x1300 fs/ext4/mballoc.c:4915
 ext4_mb_try_best_found+0x3a1/0x5a0 fs/ext4/mballoc.c:2171
 ext4_mb_regular_allocator+0x3511/0x3c20 fs/ext4/mballoc.c:2784
 ext4_mb_new_blocks+0xe5f/0x44a0 fs/ext4/mballoc.c:5843
 ext4_alloc_branch fs/ext4/indirect.c:340 [inline]
 ext4_ind_map_blocks+0x10d7/0x29e0 fs/ext4/indirect.c:635
 ext4_map_blocks+0x9e7/0x1cf0 fs/ext4/inode.c:625
 _ext4_get_block+0x238/0x6a0 fs/ext4/inode.c:779
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
 ext4_try_to_write_inline_data+0x7ed/0x1360 fs/ext4/inline.c:740
 ext4_write_begin+0x290/0x10b0 fs/ext4/inode.c:1147
 ext4_da_write_begin+0x300/0xa40 fs/ext4/inode.c:2893
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3923
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:289
 ext4_file_write_iter+0x1d6/0x1930
 do_iter_write+0x7b1/0xcb0 fs/read_write.c:860
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:795
 do_splice_from fs/splice.c:873 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1039
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:994
 do_splice_direct+0x283/0x3d0 fs/splice.c:1082
 do_sendfile+0x620/0xff0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0ff0c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ff1944168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0ff0dabf80 RCX: 00007f0ff0c8c169
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f0ff0ce7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe35f5084f R14: 00007f0ff1944300 R15: 0000000000022000
 </TASK>
BUG: scheduling while atomic: syz-executor.4/21305/0x00000002
5 locks held by syz-executor.4/21305:
 #0: ffff8880292c8460 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x5fb/0xff0 fs/read_write.c:1253
 #1: ffff8880391da200 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880391da200 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_buffered_write_iter+0xaf/0x3a0 fs/ext4/file.c:283
 #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_convert_inline_data_to_extent fs/ext4/inline.c:584 [inline]
 #2: ffff8880391d9ec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_write_inline_data+0x51d/0x1360 fs/ext4/inline.c:740
 #3: ffff8880391da088 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x980/0x1cf0 fs/ext4/inode.c:616
 #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at: spin_trylock include/linux/spinlock.h:360 [inline]
 #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_lock_group fs/ext4/ext4.h:3407 [inline]
 #4: ffff88803944f018 (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_mb_try_best_found+0x1ca/0x5a0 fs/ext4/mballoc.c:2166
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


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
