Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8B1122FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 07:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLDGjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 01:39:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:43007 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLDGjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:39:08 -0500
Received: by mail-io1-f71.google.com with SMTP id p1so4382893ioo.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2019 22:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6MrFjmAUs8q+JuxhUcHMoFYDZHCeKWA92wbX92h6xAY=;
        b=AEbnG6Li3dQp3QUS5jIfWfpp/7PW1uTQFuYRgbjiShWxaJVBuatcoziq4EH5vfVWes
         VPTcV1nSByHf/DNg8sKe53KWnLZR4kQq7PNd37rPzQbLGWPPHe+AJ1xqt3/LNBuh3aT6
         4pWvaN2AkdqzM9JUhB+jnH7kYFoAXEXnKWK/DL31CUoVRCnJtCrQ6Dd2b+jzfdGVmuHq
         D4nR2PRcN+eZE+qUsR47eRDFl+2L9r7KDvXmJop7qvkwaem0KBYFIDFl6clekhP+hhLv
         K5UcUsLEbuWBxSYiENhwv9XvEXHyAJTBr84OiKgt2AQbijLdNrjLquI2zRcZxWuP0MBe
         kgsQ==
X-Gm-Message-State: APjAAAVDxphpUr1N73P6xYpbzF6x0YTK91C7iAedGgfOl7+cOvbBPGZ8
        np4XVECLHaI1xSww+K5CQXIdnPsieUdxMxanG6BbYz573BsJ
X-Google-Smtp-Source: APXvYqxU7F/G4HQpCmgCl6VMhHLxzWV8DaaedviICUwi+ZTtF2Sg3TxrPUxI7MDqH/iC+rVEaoDCsqX6X5w4ukzbgRQUz5P/qLMi
MIME-Version: 1.0
X-Received: by 2002:a92:45d2:: with SMTP id z79mr2120571ilj.76.1575441547914;
 Tue, 03 Dec 2019 22:39:07 -0800 (PST)
Date:   Tue, 03 Dec 2019 22:39:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3f9030598db1101@google.com>
Subject: WARNING in mark_buffer_dirty (2)
From:   syzbot <syzbot+60da3d6a696457b98553@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    81b6b964 Merge branch 'master' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d35a96e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333b76551307b2a0
dashboard link: https://syzkaller.appspot.com/bug?extid=60da3d6a696457b98553
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+60da3d6a696457b98553@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8537 at fs/buffer.c:1088 mark_buffer_dirty+0x524/0x6c0  
fs/buffer.c:1088
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8537 Comm: syz-executor.1 Not tainted 5.4.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
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
RIP: 0010:mark_buffer_dirty+0x524/0x6c0 fs/buffer.c:1088
Code: 02 00 0f 85 9e 01 00 00 48 8b 3b be 04 00 00 00 e8 51 e7 fc ff e8 4c  
d2 a8 ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 3c d2 a8 ff <0f> 0b e9 2c fb  
ff ff e8 30 d2 a8 ff 0f 0b e9 53 fb ff ff e8 24 d2
RSP: 0000:ffff8880656d72f8 EFLAGS: 00010293
RAX: ffff88806dd68140 RBX: ffff888077cd9738 RCX: ffffffff81cc070e
RDX: 0000000000000000 RSI: ffffffff81cc0be4 RDI: 0000000000000001
RBP: ffff8880656d7320 R08: ffff88806dd68140 R09: ffffed100ef9b2e8
R10: ffffed100ef9b2e7 R11: ffff888077cd973f R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888070b421f8
  __ext4_handle_dirty_metadata+0x3f7/0x600 fs/ext4/ext4_jbd2.c:298
  ext4_free_blocks+0xeab/0x24d0 fs/ext4/mballoc.c:4940
  ext4_remove_blocks fs/ext4/extents.c:2678 [inline]
  ext4_ext_rm_leaf fs/ext4/extents.c:2831 [inline]
  ext4_ext_remove_space+0x2491/0x5650 fs/ext4/extents.c:3076
  ext4_ext_truncate+0x1b5/0x200 fs/ext4/extents.c:4599
  ext4_truncate+0xc6e/0x13c0 fs/ext4/inode.c:4511
  ext4_evict_inode+0x9d4/0x14e0 fs/ext4/inode.c:289
  evict+0x306/0x680 fs/inode.c:574
  iput_final fs/inode.c:1563 [inline]
  iput+0x55d/0x900 fs/inode.c:1589
  dentry_unlink_inode+0x2d9/0x400 fs/dcache.c:374
  __dentry_kill+0x38b/0x600 fs/dcache.c:579
  dentry_kill fs/dcache.c:698 [inline]
  dput+0x62f/0xe10 fs/dcache.c:859
  path_put+0x31/0x70 fs/namei.c:482
  free_fs_struct+0x25/0x70 fs/fs_struct.c:91
  exit_fs+0xf0/0x130 fs/fs_struct.c:108
  do_exit+0x8bd/0x2ef0 kernel/exit.c:793
  do_group_exit+0x135/0x360 kernel/exit.c:895
  get_signal+0x47c/0x24f0 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:160
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a759
Code: Bad RIP value.
RSP: 002b:00007faf7cbeacf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000071bf08 RCX: 000000000045a759
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000071bf08
RBP: 000000000071bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000071bf0c
R13: 00007ffc79ee6e9f R14: 00007faf7cbcb000 R15: 0000000000000003
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
