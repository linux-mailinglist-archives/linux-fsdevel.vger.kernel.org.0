Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D91B8E29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDZJSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 05:18:15 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34073 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDZJSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:18:15 -0400
Received: by mail-io1-f70.google.com with SMTP id v12so17135776iol.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 02:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6vjTaIhg0HKYZTo/0/3anwAnw5cVaooRrEtl+peewHI=;
        b=OYANXGPSVyYRDMf5qe56NifRjpKL+swWtFfQnyx9FEfm3DocOJYYJvLIKhvOfe8XxC
         cVk1gk/9N2qYxescg4pooXmcr6jUiX+RSxV3+HQXAKBcwSHN3vZg6kxm3cIvNuZcaieH
         BXvEN0r4omXQzD5XTFoOzL8ZjPm8dn2+O3CfRjNBixKU8CiZAPOFPbqQtgufCMIkWhp+
         jC1cUAV44fbyjU3R4QK0W+Thgmdbe22suZx7fsPfMrScVPCp0KFbd4BCi9kt7Oa8gf1b
         fOTd8eOzdu+f1FAppJsQBWPd/RpISx/AiwD6ZrjbCs+56Jp5XIH3MIeAVaFsBp9Ty8dl
         Gp1Q==
X-Gm-Message-State: AGi0PubBWRfRpHM7i79frC/QXeoANKeWz1ATNoamVNFRfY88LKK4IAds
        Eb8H2gH1gXekeeWVwtNmI+cAtw+oWloaSkAiM1kKGzvPjXQz
X-Google-Smtp-Source: APiQypLh7tYlwedJVLAFbWRCg24jej5lpBRVN2xHrPXC82I6g8gyxbzXGvYF6N5s2dtwlnOTfNhtBL2Wm31JbOhojvhVHce9vy5/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dca:: with SMTP id l10mr15654457ilj.215.1587892692712;
 Sun, 26 Apr 2020 02:18:12 -0700 (PDT)
Date:   Sun, 26 Apr 2020 02:18:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e405c105a42e13ec@google.com>
Subject: WARNING in drop_nlink
From:   syzbot <syzbot+df958cf5688a96ad3287@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    189522da Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16747530100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78a7d8adda44b4b
dashboard link: https://syzkaller.appspot.com/bug?extid=df958cf5688a96ad3287
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e45dbfe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b5b36fe00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a81dc8100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11a81dc8100000
console output: https://syzkaller.appspot.com/x/log.txt?x=16a81dc8100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+df958cf5688a96ad3287@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7023 at fs/inode.c:303 drop_nlink+0xb9/0x100 fs/inode.c:303
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7023 Comm: syz-executor433 Not tainted 5.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:drop_nlink+0xb9/0x100 fs/inode.c:303
Code: 49 8b 1e 48 8d bb b8 07 00 00 be 08 00 00 00 e8 fd 65 ef ff f0 48 ff 83 b8 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 e8 f7 b8 b1 ff <0f> 0b eb 8a 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 63 ff ff ff 4c
RSP: 0018:ffffc900015d7da0 EFLAGS: 00010293
RAX: ffffffff81c1a899 RBX: 1ffff11010d63ab1 RCX: ffff8880a7e88200
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81c1a81e R09: ffffed1010d63ab9
R10: ffffed1010d63ab9 R11: 0000000000000000 R12: ffff888086b1d588
R13: 1ffff110114efcf2 R14: ffff888086b1d540 R15: dffffc0000000000
 inode_dec_link_count include/linux/fs.h:2210 [inline]
 minix_unlink+0xc7/0x100 fs/minix/namei.c:164
 vfs_unlink+0x30c/0x5a0 fs/namei.c:3809
 do_unlinkat+0x377/0x7e0 fs/namei.c:3873
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x449ac7
Code: 0f 1f 00 b8 58 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad cd fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8d cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe753dcec8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000449ac7
RDX: 0000000001fb39e3 RSI: 00007ffe753dcee0 RDI: 00007ffe753dcf70
RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000001fb3980
R13: 00007ffe753de060 R14: 0000000000000000 R15: 0000000000000000
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
