Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30431376B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgAJTKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:10:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:36537 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgAJTKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:10:10 -0500
Received: by mail-io1-f71.google.com with SMTP id 144so2155421iou.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2020 11:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GwElu9VPC3v9CabfBpOGNXC+NQY/jymdyYqtxzzX1tg=;
        b=pQtKf3qXguMfjKlYhyW3aEDlgHxYmAqNgGR/UXCpfiwaeWgsIdO8NOLdyPO/QSC+N7
         zELr6qmlZBOAeC4pSz/VXNqbuGXbz0FZMzoKU+rAM0N4FAStElf7ogLMeScuOmss7/X8
         homG5BjJlYu/oJVPhz4h7sI+4htGtAGv9qlktLlUIdyHUBL3rXCUyZ2zsCmtGkhuag7+
         AGnuxWO7l8ELHTJQGEFeKxMV3jbgmL/6vS9yD3jJy6HdL8nsujWLZeecV6CM1KxFM5RH
         yZ8sjw31wCALa1E6UbxPiwidUemhgU5ggAFUcARCQQ+s0KEnNxI1ZzKosSCBG+8WV0Od
         TeBQ==
X-Gm-Message-State: APjAAAUKpeDEPBbSVuY+8r+5cw5+gRwFndw99muh+O2VX+ROwYcE7ims
        qhU2pA1HPjKg8UHqgZ8OGPuKdLi0As2Z0dqhM+LeQtx6Buvq
X-Google-Smtp-Source: APXvYqyu0RfcKwx6oxYQxavpVWEH/dO0qlxIWkIWookTc+goBv2/sx86ZREvcg3mcTgz094IO6BzKnmUOGJglhFBCj61oxxGFB4I
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2501:: with SMTP id i1mr3829030ioe.231.1578683409693;
 Fri, 10 Jan 2020 11:10:09 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:10:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9034c059bcddf3c@google.com>
Subject: general protection fault in simple_recursive_removal
From:   syzbot <syzbot+1edeee8da2474fe17a53@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6c09d7db Add linux-next specific files for 20200110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157b65c6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=246a085809cfc9f7
dashboard link: https://syzkaller.appspot.com/bug?extid=1edeee8da2474fe17a53
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1edeee8da2474fe17a53@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address  
0xdffffc0000000028: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
CPU: 1 PID: 29862 Comm: syz-executor.4 Not tainted  
5.5.0-rc5-next-20200110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x1254/0x4a00 kernel/locking/lockdep.c:3827
Code: 00 0f 85 96 24 00 00 48 81 c4 f0 00 00 00 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 0b 28 00 00 49 81 3e 20 f9 df 8a 0f 84 5f ee ff
RSP: 0018:ffffc90007ac78d0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc90007ac79e8 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff1549320 R11: ffff8880375be640 R12: 0000000000000140
R13: 0000000000000000 R14: 0000000000000140 R15: 0000000000000000
FS:  00007f6dc39ee700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e625000 CR3: 00000000a8998000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
  down_write+0x93/0x150 kernel/locking/rwsem.c:1534
  inode_lock include/linux/fs.h:791 [inline]
  simple_recursive_removal+0x185/0x720 fs/libfs.c:273
  debugfs_remove fs/debugfs/inode.c:713 [inline]
  debugfs_remove+0x5e/0x80 fs/debugfs/inode.c:707
  blk_trace_free+0x38/0x140 kernel/trace/blktrace.c:311
  do_blk_trace_setup+0x735/0xb50 kernel/trace/blktrace.c:556
  __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:570
  blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:709
  blkdev_ioctl+0xc3/0x670 block/ioctl.c:710
  block_ioctl+0xee/0x130 fs/block_dev.c:1983
  vfs_ioctl fs/ioctl.c:47 [inline]
  ksys_ioctl+0x123/0x180 fs/ioctl.c:760
  __do_sys_ioctl fs/ioctl.c:769 [inline]
  __se_sys_ioctl fs/ioctl.c:767 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:767
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6dc39edc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 000000000000000b
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6dc39ee6d4
R13: 00000000004c2acf R14: 00000000004d8f28 R15: 00000000ffffffff
Modules linked in:
---[ end trace 69c29488e75b4707 ]---
RIP: 0010:__lock_acquire+0x1254/0x4a00 kernel/locking/lockdep.c:3827
Code: 00 0f 85 96 24 00 00 48 81 c4 f0 00 00 00 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 0b 28 00 00 49 81 3e 20 f9 df 8a 0f 84 5f ee ff
RSP: 0018:ffffc90007ac78d0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc90007ac79e8 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff1549320 R11: ffff8880375be640 R12: 0000000000000140
R13: 0000000000000000 R14: 0000000000000140 R15: 0000000000000000
FS:  00007f6dc39ee700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e625000 CR3: 00000000a8998000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
