Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03630721D6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 07:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjFEFTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 01:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjFEFTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:19:44 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F5B7
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 22:19:43 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-766655c2cc7so288955339f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 22:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685942382; x=1688534382;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBk0s2MF2AI/AMlwY2L7ayq4gYk55uu/iFfSdgZ9gkY=;
        b=bgC2i1eB7c8HS7RndMPod32OPUIaxY4fYhIW32PYSb9PDaPmVEHwsGzzLhSbpjRnHf
         zewmPkCQ3MfamH/p/FGlIpKKP6yU/TRE7M1httXtxaSUV//e5ZtnsxfMsal8nB737Lzu
         zYCKWpiQ3sg/YxYlcsu7NEtKKdxCwklzscQiIOgghlEGa4jspWsKa9wVWNBe2mdV0iN7
         XCZZMr2xcbkP6CxGMfDPX4ohSTEhtYzc5iYrVc7PCCassDbUCeQeGFCzw7bPpuNAI9CS
         AuL7uJIKLcVq9E8VYls9VGYlOypCf0JYzwylzw6ipvwNu+3C3/pS7BUVWq4TDbRTclQs
         P0rg==
X-Gm-Message-State: AC+VfDyHO1lEXNUGQWnD06aic25OWkB/QQyN6Wdfe+q/jsN4XSxGpegp
        670xwE8O1HLh0ZXy+0XwlmWpyGM2bIvlfjqoBanSOWvHrw3F
X-Google-Smtp-Source: ACHHUZ4FD19vOYTxGNEgXx1+rGQfK1WNRUTMJDekFG+qt+qr8iiNO8ns43o7HvjZmV5fuCLf9ZvbdrqAPCiriqTKsckgkKBXpKfq
MIME-Version: 1.0
X-Received: by 2002:a02:7a07:0:b0:41f:6290:10c6 with SMTP id
 a7-20020a027a07000000b0041f629010c6mr427412jac.0.1685942382431; Sun, 04 Jun
 2023 22:19:42 -0700 (PDT)
Date:   Sun, 04 Jun 2023 22:19:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1149605fd5b0c0d@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_ioctl
From:   syzbot <syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    9561de3a55be Linux 6.4-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11671443280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7890258233e8/disk-9561de3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/693d68681275/vmlinux-9561de3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f62a882fdf3/bzImage-9561de3a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key init_once.__key.780, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 1 PID: 25888 at kernel/locking/lockdep.c:941 look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 1 PID: 25888 Comm: syz-executor.5 Not tainted 6.4.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Code: 8b 16 48 c7 c0 60 91 1e 90 48 39 c2 74 46 f6 05 5d 02 92 03 01 75 3d c6 05 54 02 92 03 01 48 c7 c7 a0 ae ea 8a e8 de 8a a3 f6 <0f> 0b eb 26 e8 f5 d0 80 f9 48 c7 c7 e0 ad ea 8a 89 de e8 37 ca fd
RSP: 0018:ffffc9000346f590 EFLAGS: 00010046
RAX: d34f506bfef30000 RBX: ffffffff9009d5e0 RCX: 0000000000040000
RDX: ffffc9000c4e2000 RSI: 000000000000683a RDI: 000000000000683b
RBP: ffffc9000346f698 R08: ffffffff81530142 R09: ffffed1017325163
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 1ffff9200068dec0 R14: ffff8880894f7088 R15: ffffffff91cac681
FS:  00007fefb6c7f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b481895e0 CR3: 0000000019b2c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x104/0x990 kernel/locking/lockdep.c:1290
 __lock_acquire+0xd3/0x2070 kernel/locking/lockdep.c:4965
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
 swap_inode_boot_loader fs/ext4/ioctl.c:423 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1418 [inline]
 ext4_ioctl+0x453c/0x5b60 fs/ext4/ioctl.c:1608
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fefb5e8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fefb6c7f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fefb5fac050 RCX: 00007fefb5e8c169
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 000000000000000a
RBP: 00007fefb5ee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff62162a1f R14: 00007fefb6c7f300 R15: 0000000000022000
 </TASK>


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
