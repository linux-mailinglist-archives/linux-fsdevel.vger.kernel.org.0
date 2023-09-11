Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8079C10E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjILAFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 20:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjILAFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:05:36 -0400
Received: from mail-pg1-x550.google.com (mail-pg1-x550.google.com [IPv6:2607:f8b0:4864:20::550])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F715C896
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 17:02:00 -0700 (PDT)
Received: by mail-pg1-x550.google.com with SMTP id 41be03b00d2f7-57774c725ebso1495445a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 17:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694476785; x=1695081585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGkwF0gYaz4cY8e4zOPO10SheJVop81xTC7Gspn6wAQ=;
        b=VLBE40XbylvgoOc+AYxqdztxxoYLktoDJr4Xx1bic7RRerOdWv+721Ks3u4fAYQrDY
         CnuiihnXuRbqM9bjpLnMbCHYEwKljjK1P3HBZSoTjxVFSrpPkttN0P088wDTGHGEYlbf
         0HK9zRWwVI4X4ZE0RCrzl/7Llx0TYObh5iK7fGc1fHoq8OKHanthwtp6Eg3+7ZInXOTG
         6E2AwEovHPFTQNx+HHZ2VLSP/xe7lygrJLsJQwoueZBHt+TyLAPuNRG0g2lJlHKk5e0J
         4wVQmboEHFmW+2ExL96n7AHjbtmjQdaKcd2s9Prss89jfBFd8/WBEm0IA3sgEcA0rqKV
         W6AQ==
X-Gm-Message-State: AOJu0Yx6iBWT/Vhw5TSLLrwmPakWFbcpMv6tSifuwsOyEplV7KBmJ9zc
        WX1p+p3ivHFUkIqBpxYExl/hhEGBAyTleKvGIOVa5LTm6L4BKoqSPA==
X-Google-Smtp-Source: AGHT+IGOHBSTES1Jhg24gmV93v8EzHDuOqQQrx+qi2cRYhfOD1Z+VsaGSxDET7SIecNgCzg4HGTRR3Lfcha3DO9zipDO1K8RElwS
MIME-Version: 1.0
X-Received: by 2002:a17:903:22cc:b0:1c3:1ceb:97b6 with SMTP id
 y12-20020a17090322cc00b001c31ceb97b6mr4263397plg.7.1694472364628; Mon, 11 Sep
 2023 15:46:04 -0700 (PDT)
Date:   Mon, 11 Sep 2023 15:46:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000601fc406051d17bc@google.com>
Subject: [syzbot] [hfs?] kernel BUG in hfs_btree_open (2)
From:   syzbot <syzbot+f8aee4b1409f7e8e6e46@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16abc6c7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=f8aee4b1409f7e8e6e46
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d506cf29d25/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca5b56af4b3e/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa88aed611c1/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8aee4b1409f7e8e6e46@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 64
------------[ cut here ]------------
kernel BUG at fs/hfs/btree.c:41!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 11852 Comm: syz-executor.2 Not tainted 6.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:hfs_btree_open+0xf09/0xf20 fs/hfs/btree.c:41
Code: 7e ff e9 7e fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 9b fa ff ff 4c 89 f7 e8 c1 ca 7e ff e9 8e fa ff ff e8 c7 df 24 ff <0f> 0b e8 c0 df 24 ff 0f 0b e8 b9 df 24 ff 0f 0b 0f 1f 80 00 00 00
RSP: 0000:ffffc900034cf738 EFLAGS: 00010283
RAX: ffffffff8268c3c9 RBX: ffff888036585ad0 RCX: 0000000000040000
RDX: ffffc9000b664000 RSI: 000000000000586c RDI: 000000000000586d
RBP: 0000000000000000 R08: ffffffff8268b627 R09: 1ffff11006cb0b75
R10: dffffc0000000000 R11: ffffed1006cb0b76 R12: ffff8880210a2000
R13: ffff888028f54008 R14: ffff888028f54000 R15: dffffc0000000000
FS:  00007f73a031a6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c2a9ba000 CR3: 0000000023db4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfs_mdb_get+0x1443/0x21b0 fs/hfs/mdb.c:199
 hfs_fill_super+0x107d/0x1790 fs/hfs/super.c:406
 mount_bdev+0x237/0x300 fs/super.c:1629
 legacy_get_tree+0xef/0x190 fs/fs_context.c:638
 vfs_get_tree+0x8c/0x280 fs/super.c:1750
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f739f67e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73a0319ee8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f73a0319f80 RCX: 00007f739f67e1ea
RDX: 0000000020000240 RSI: 0000000020000040 RDI: 00007f73a0319f40
RBP: 0000000020000240 R08: 00007f73a0319f80 R09: 0000000000004012
R10: 0000000000004012 R11: 0000000000000202 R12: 0000000020000040
R13: 00007f73a0319f40 R14: 0000000000000285 R15: 0000000020000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_btree_open+0xf09/0xf20 fs/hfs/btree.c:41
Code: 7e ff e9 7e fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 9b fa ff ff 4c 89 f7 e8 c1 ca 7e ff e9 8e fa ff ff e8 c7 df 24 ff <0f> 0b e8 c0 df 24 ff 0f 0b e8 b9 df 24 ff 0f 0b 0f 1f 80 00 00 00
RSP: 0000:ffffc900034cf738 EFLAGS: 00010283
RAX: ffffffff8268c3c9 RBX: ffff888036585ad0 RCX: 0000000000040000
RDX: ffffc9000b664000 RSI: 000000000000586c RDI: 000000000000586d
RBP: 0000000000000000 R08: ffffffff8268b627 R09: 1ffff11006cb0b75
R10: dffffc0000000000 R11: ffffed1006cb0b76 R12: ffff8880210a2000
R13: ffff888028f54008 R14: ffff888028f54000 R15: dffffc0000000000
FS:  00007f73a031a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff38ded7086 CR3: 0000000023db4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
