Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA00199CD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCaR1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 13:27:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53641 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaR1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:27:08 -0400
Received: by mail-io1-f71.google.com with SMTP id f6so19872026ioc.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 10:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NRXlmApaOOZXeq6VgcdfEnqkVkzCThuB9Mtk0kx2C2I=;
        b=DEGDlSygHChjYvxMuB1CJzLgGmSWb2yhQwGxIt0SFJ7miFnzwppN+C5oxP4M3Fi5rK
         LPgR5AyayzJQdASiR4DhhzXwGx8lX0xE9yUJYtiHtbE+7D8ksMD7w0r4euoXGUa9sWVS
         Y6S6kpnK5W2zFUoyEDisPm0hV8OmlI5Nw87+eOkU+y6ipo0LTkXClXTVzhSVkWRsGdUi
         rYSpJKgQgfDWCuYE03iJ+sTAB9udur1vCbwbTRc+I+I6tPg4dvqwM3oaSMnkbLTt8c7D
         81gAtn14MafLj4/O8SB4s0PWl/Eld/KCEu1VvZshXR6cAYCFJizlgGeiqV0W0+/ykQRP
         2khA==
X-Gm-Message-State: ANhLgQ3H6CHvoqUDR8mSE2UvRM39m242y4Wt+wuXgu29X/4lT8tWd1+6
        NxxV6YOnsx7/0VyAL3MjwNO9TbRK7YDoJHmShddTWzHfOCiX
X-Google-Smtp-Source: ADFU+vvJK+3E18Ce1sryNeMKXYVP79W8YG1UJ0bT+g3/2KAL5u7Xe4IKcntKQWwSo7d9TEzAK9B+GJ8I92mgI3ytYqk0acyDEmyS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:811:: with SMTP id u17mr14585545ilm.93.1585675272031;
 Tue, 31 Mar 2020 10:21:12 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:21:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000519c8405a229cbc2@google.com>
Subject: WARNING in inc_nlink
From:   syzbot <syzbot+a9ac3de1b5de5fb10efc@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e595dd94 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b2bc15e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=a9ac3de1b5de5fb10efc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d33183e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1076297be00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147487a3e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=167487a3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=127487a3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9ac3de1b5de5fb10efc@syzkaller.appspotmail.com

MINIX-fs: mounting unchecked file system, running fsck is recommended
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7042 at fs/inode.c:360 inc_nlink+0x144/0x160 fs/inode.c:360
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7042 Comm: syz-executor911 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:inc_nlink+0x144/0x160 fs/inode.c:360
Code: ff 4c 89 e7 e8 ed 99 ee ff e9 42 ff ff ff 4c 89 e7 e8 70 99 ee ff e9 fc fe ff ff 4c 89 e7 e8 63 99 ee ff eb d4 e8 5c d0 b1 ff <0f> 0b e9 6e ff ff ff e8 60 99 ee ff e9 44 ff ff ff e8 56 99 ee ff
RSP: 0018:ffffc90000ef7d88 EFLAGS: 00010293
RAX: ffff88808721c300 RBX: ffff888085dab990 RCX: ffffffff81c05430
RDX: 0000000000000000 RSI: ffffffff81c054c4 RDI: 0000000000000007
RBP: 0000000000000000 R08: ffff88808721c300 R09: ffffed1043789757
R10: ffffed1043789756 R11: ffff88821bc4bab3 R12: ffff888085dab9d8
R13: ffff888089848b80 R14: ffff888089848bd8 R15: 0000000000000000
 inode_inc_link_count include/linux/fs.h:2199 [inline]
 minix_mkdir+0x71/0x1b0 fs/minix/namei.c:117
 vfs_mkdir+0x419/0x670 fs/namei.c:3889
 do_mkdirat+0x21e/0x280 fs/namei.c:3912
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444a69
Code: 0d d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc41646e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007ffc41646e50 RCX: 0000000000444a69
RDX: 00000000000001ff RSI: 0000000020000080 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000400e50 R09: 0000000000400e50
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004026d0
R13: 0000000000402760 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
