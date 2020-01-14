Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F079D13A0FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 07:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANGdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 01:33:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49049 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgANGdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:33:11 -0500
Received: by mail-il1-f200.google.com with SMTP id u14so9789901ilq.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 22:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1B6lSJjlT3qeD8LwfG4NOmFDkwn4iixmNKRIjQoa5eg=;
        b=kOJXJf1M9FUGZSJeLqRXF+JTI/o+PrTtQqm3UQwQLHFjkmogI0UdmS3xgPXmklt+RP
         gg8mjfqGfKApcr5uRfgId/QhT8JxXP9Lay6TtMF+gR58tR/TLgn99B6hhvms7Eg+KEy+
         L4tJGOMIagwOe9Z5wEhPZkoSvNPyVSUuTgLdjfO2cssU2cOzWqfTFuiFQJBjuIy6rCQQ
         Io5Ix6MyshJfDWkZ8UoJVgA7iQhUE57yCkobVL7CWiGQq9zQciufWrHRIfPuPBJ1ImD3
         qhP2wiDs8fIHF8/zlI/p4MRMWnRlyTnjHSExv1n32u7++5aKvsFuarDx7nHuO3sCQ8X3
         zf6A==
X-Gm-Message-State: APjAAAXJjWj5318gLHLl3r+G3aQzCW24qq1hHI0WsxKqatAwsUU71WR4
        xq6UEbXUJxNocsRRN8otfV0rxHwHTlSSY9EfYTWXx2+AgkI3
X-Google-Smtp-Source: APXvYqzPA9c9XLOtvMAC27kM7KWkxv7n/oeTOITAnpsSmaEOmA6zr4CwynmYa1QgPjVWZpE/sB2aBOUrm6+IhgLcUYi/vd6XdtNd
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6a6:: with SMTP id d6mr17724624jad.132.1578983590726;
 Mon, 13 Jan 2020 22:33:10 -0800 (PST)
Date:   Mon, 13 Jan 2020 22:33:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008132d059c13c47b@google.com>
Subject: kernel BUG at fs/namei.c:LINE!
From:   syzbot <syzbot+79eb0f3df962caf839ed@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8a28e614 Add linux-next specific files for 20200113
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d5fa59e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c529c4d6ca1b2f3a
dashboard link: https://syzkaller.appspot.com/bug?extid=79eb0f3df962caf839ed
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+79eb0f3df962caf839ed@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/namei.c:684!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9764 Comm: syz-executor.0 Not tainted  
5.5.0-rc5-next-20200113-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:unlazy_walk+0x306/0x3b0 fs/namei.c:684
Code: ff ff ff e8 6c 3f a1 ff e8 e7 d8 b3 ff 48 c7 c6 74 6c c1 81 48 c7 c7  
00 f7 ba 89 e8 e4 97 99 ff e9 d8 fe ff ff e8 ca d8 b3 ff <0f> 0b e8 c3 d8  
b3 ff 0f 0b e8 bc d8 b3 ff e8 27 86 a0 ff 31 ff 89
RSP: 0018:ffffc900064cfba0 EFLAGS: 00010293
RAX: ffff88808e912040 RBX: ffffc900064cfc60 RCX: ffffffff81c16a16
RDX: 0000000000000000 RSI: ffffffff81c16ca6 RDI: 0000000000000005
RBP: ffffc900064cfbd0 R08: ffff88808e912040 R09: ffff88808e9128d8
R10: fffffbfff1549b88 R11: ffffffff8aa4dc47 R12: 0000000000000009
R13: ffffc900064cfc68 R14: ffff888096b5d9e0 R15: 0000000000000000
FS:  0000000002454940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0004a9000 CR3: 000000007d640000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  path_mountpoint.isra.0+0x1d5/0x340 fs/namei.c:2788
  filename_mountpoint+0x181/0x380 fs/namei.c:2809
  user_path_mountpoint_at+0x3a/0x50 fs/namei.c:2839
  ksys_umount+0x164/0xef0 fs/namespace.c:1683
  __do_sys_umount fs/namespace.c:1709 [inline]
  __se_sys_umount fs/namespace.c:1707 [inline]
  __x64_sys_umount+0x54/0x80 fs/namespace.c:1707
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45d977
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f  
1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4d 8c fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf6064738 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045d977
RDX: 0000000000403720 RSI: 0000000000000002 RDI: 00007ffcf60647e0
RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000000000e
R10: 000000000000000a R11: 0000000000000206 R12: 00007ffcf6065870
R13: 0000000002455940 R14: 0000000000000000 R15: 00007ffcf6065870
Modules linked in:
---[ end trace b7d2f0f09e464864 ]---
RIP: 0010:unlazy_walk+0x306/0x3b0 fs/namei.c:684
Code: ff ff ff e8 6c 3f a1 ff e8 e7 d8 b3 ff 48 c7 c6 74 6c c1 81 48 c7 c7  
00 f7 ba 89 e8 e4 97 99 ff e9 d8 fe ff ff e8 ca d8 b3 ff <0f> 0b e8 c3 d8  
b3 ff 0f 0b e8 bc d8 b3 ff e8 27 86 a0 ff 31 ff 89
RSP: 0018:ffffc900064cfba0 EFLAGS: 00010293
RAX: ffff88808e912040 RBX: ffffc900064cfc60 RCX: ffffffff81c16a16
RDX: 0000000000000000 RSI: ffffffff81c16ca6 RDI: 0000000000000005
RBP: ffffc900064cfbd0 R08: ffff88808e912040 R09: ffff88808e9128d8
R10: fffffbfff1549b88 R11: ffffffff8aa4dc47 R12: 0000000000000009
R13: ffffc900064cfc68 R14: ffff888096b5d9e0 R15: 0000000000000000
FS:  0000000002454940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd56da0a70 CR3: 000000007d640000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
