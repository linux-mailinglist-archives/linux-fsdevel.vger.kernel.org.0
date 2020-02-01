Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5414F76E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 10:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBAJsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 04:48:13 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:35812 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgBAJsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 04:48:13 -0500
Received: by mail-il1-f197.google.com with SMTP id h18so7490984ilc.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 01:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/37N4B52RSRWznngrBUlJ1oTgqXfHis0vJhkaKhoMwI=;
        b=Bmg4cSAyLx1VnZ7uBgAtQPSDENh0v3Ve2wtHpYU8hGKjMPWLszuv6GR7P02VT29QsX
         OVEEoQNUWy8jaUcT7LMHVTX1pBCk2nNT/FuVqp5KZAV52WQb9jR482z6ZapB4AhU0fh5
         730pEyaIQZaL52r8oRAwcqRDj12PVgYK/X+0LT1p5OUb2/cGcf8snDsp4nkpC2Mq9RMk
         5bWhgnykmsSshqTXxs7VyUZA902g+joIK73Avsk2EP76G+kd2gheQ0VYd/Rc0Pq9/W0F
         VgOdnrNu2M7B+zyNLQaa4GoLDxZVPwjhsWU7aNRsSCwoLZCEqys7wX/SeJL/sbxNkyGC
         umyQ==
X-Gm-Message-State: APjAAAWw0JDQ517wqzA5qfcI9aAIYzoOUVzXEgRihF9+oSPbhfxCnTkD
        pJxR/oBBdxiPYWOuSFMGVD+lQFX1x/9B/vtHfYUoGHMVy5sO
X-Google-Smtp-Source: APXvYqxClKtCelQZ2nThWeJD5YpecB7kYwb9rrMQSiRKvmqGsMULRvkYmAI2L+J8OYgLgDCtxdrKe1gaPgy2zvyZoeCTey8HHT4O
MIME-Version: 1.0
X-Received: by 2002:a92:4019:: with SMTP id n25mr5105611ila.147.1580550491062;
 Sat, 01 Feb 2020 01:48:11 -0800 (PST)
Date:   Sat, 01 Feb 2020 01:48:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091cacb059d809681@google.com>
Subject: WARNING in do_dentry_open (2)
From:   syzbot <syzbot+32c9f7d8a32ea5127669@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c677124e Merge branch 'sched-core-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157511bee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9892b0ce783fa
dashboard link: https://syzkaller.appspot.com/bug?extid=32c9f7d8a32ea5127669
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1476cf66e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1640085ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+32c9f7d8a32ea5127669@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10428 at fs/open.c:832 do_dentry_open+0xf65/0x1380 fs/open.c:832
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 10428 Comm: syz-executor099 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x3e kernel/panic.c:582
 report_bug+0x289/0x300 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:do_dentry_open+0xf65/0x1380 fs/open.c:832
Code: ea 03 80 3c 02 00 0f 85 9b 03 00 00 49 8b 46 70 48 85 c0 48 89 85 40 ff ff ff 0f 84 d9 f5 ff ff e9 72 f5 ff ff e8 4b b8 b8 ff <0f> 0b 41 bd ea ff ff ff e9 89 fd ff ff 48 8b bd 50 ff ff ff e8 02
RSP: 0018:ffffc90001e179f8 EFLAGS: 00010293
RAX: ffff888087b7c140 RBX: ffff888085e25ac0 RCX: ffffffff81bc8442
RDX: 0000000000000000 RSI: ffffffff81bc86b5 RDI: 0000000000000005
RBP: ffffc90001e17ad8 R08: ffff888087b7c140 R09: ffffed1014e9f962
R10: ffffed1014e9f961 R11: ffff8880a74fcb0b R12: ffff888219bc7040
R13: 0000000000000001 R14: ffffffff885e8680 R15: ffff888085e25ae8
 vfs_open+0xa0/0xd0 fs/open.c:914
 do_last fs/namei.c:3359 [inline]
 path_openat+0x1141/0x2fb0 fs/namei.c:3476
 do_filp_open+0x1a1/0x280 fs/namei.c:3506
 do_sys_open+0x3fe/0x5d0 fs/open.c:1097
 __do_sys_openat fs/open.c:1124 [inline]
 __se_sys_openat fs/open.c:1118 [inline]
 __x64_sys_openat+0x9d/0x100 fs/open.c:1118
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440229
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc7f2488b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440229
RDX: 0000000000000002 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ab0
R13: 0000000000401b40 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
