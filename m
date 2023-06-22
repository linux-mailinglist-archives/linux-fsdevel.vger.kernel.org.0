Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48D73A2C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjFVOOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjFVOOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:14:01 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A51BDA
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 07:13:49 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7778eb7966eso663463139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 07:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443228; x=1690035228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejmIg4Qx6xd91FDWYJpla2pPTx9JtjXCeXyQAb4fjkY=;
        b=gLWUjyzWcQoBQmttaGSc2T14P5RKcB94pcmnns4nqe5WkUOunce4xq2uLM/GxokMBL
         ZD1ZvEhSTD+9EmMXghA3gNNuZtH4zs4DVqavV1PsaEtDjgeirZU7h7303kq4fxXwWb5G
         A+tEIjbEhfvhX0K57ZZriihBf3szq1YmSlJgwhEOLHY+SxSiZC9lJRcyR5Pak+Tlos/R
         3+MUqVN5y8WpyjwGyttkzoFocYkVylZK8+stSxFbg8WecykKnrrCwCJ5mysSqEr8g+2c
         IlQiD/zSEJutrGvJ+kyac81ZLou/YsCNGfLBg7zb2ztY6qB4sRBkHLnGg4/Q4JSDxVNH
         9D6w==
X-Gm-Message-State: AC+VfDzDSDIs0idcg5S2lmP8GMjjvZgYrD1WabTEgFkhSQO+bfcXq00L
        htP7f0g8COcrXJGM4bjVs8uYDvvonJ/Qbd0ULy21tE/dGPRx
X-Google-Smtp-Source: ACHHUZ51ZMIGUQVsUB3fuUc9g7Uh8e+GoTdifBINW07w+HkvOAo7enampj28OOohwaV7EBZtfcBZtMOdPreP51HF6PW6RnhxMVQQ
MIME-Version: 1.0
X-Received: by 2002:a02:8506:0:b0:423:1100:682c with SMTP id
 g6-20020a028506000000b004231100682cmr5919572jai.0.1687443228729; Thu, 22 Jun
 2023 07:13:48 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:13:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a29fe05feb87e4e@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_run_delayed_refs (2)
From:   syzbot <syzbot+810ea5febd3b79bdd384@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dad9774deaf1 Merge tag 'timers-urgent-2023-06-21' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16198bb7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=810ea5febd3b79bdd384
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11acf600a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474fa3f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fce56e230cb4/disk-dad9774d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e12b4efd53ae/vmlinux-dad9774d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38be193d7202/bzImage-dad9774d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2b9fc185d47b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+810ea5febd3b79bdd384@syzkaller.appspotmail.com

BTRFS error (device loop0): failed to run delayed ref for logical 5251072 num_bytes 4096 type 176 action 1 ref_mod 1: -28
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 4996 at fs/btrfs/extent-tree.c:2127 btrfs_run_delayed_refs+0x444/0x480 fs/btrfs/extent-tree.c:2127
Modules linked in:
CPU: 0 PID: 4996 Comm: syz-executor740 Not tainted 6.4.0-rc7-syzkaller-00072-gdad9774deaf1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:btrfs_run_delayed_refs+0x444/0x480 fs/btrfs/extent-tree.c:2127
Code: fe c1 38 c1 0f 8c 54 fc ff ff 48 89 ef e8 44 fe 60 fe e9 47 fc ff ff e8 9a 26 09 fe 48 c7 c7 00 95 29 8b 89 ee e8 4c a5 d0 fd <0f> 0b eb 9e f3 0f 1e fa e8 7f 26 09 fe 48 8b 44 24 18 42 80 3c 28
RSP: 0018:ffffc90003a6f070 EFLAGS: 00010246
RAX: b1a953d201add500 RBX: ffff88807d0f8001 RCX: ffff888027350000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffffe4 R08: ffffffff81530142 R09: fffff5200074ddc1
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888076ab7e70
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880146a1000
FS:  00007fa312072700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005645cf4d5000 CR3: 0000000077a2a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x427/0x3370 fs/btrfs/transaction.c:2158
 btrfs_sync_file+0xcb3/0x10e0 fs/btrfs/file.c:2001
 generic_write_sync include/linux/fs.h:2469 [inline]
 btrfs_do_write_iter+0xccd/0x1270 fs/btrfs/file.c:1684
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
RIP: 0033:0x7fa3120ce3e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa312072208 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fa312151788 RCX: 00007fa3120ce3e9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fa312151780 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000880000c R11: 0000000000000246 R12: 00007fa31215178c
R13: 00007fffc2cae10f R14: 00007fa312072300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
