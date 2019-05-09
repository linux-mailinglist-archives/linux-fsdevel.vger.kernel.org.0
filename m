Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCD1184E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 07:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEIFkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 01:40:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52064 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIFkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 01:40:07 -0400
Received: by mail-io1-f71.google.com with SMTP id b9so869574ios.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2019 22:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7jBk512NSDPCpFX0FgBlXkuYuPGMz+RX6RvmqXdphlY=;
        b=OzDrcWQhKDG12zjbNn3fWAbpNqf62H+K93bF0jYP61Ggbl80SOh29SPdTNmfApz0Gs
         BNpluDm8LeLRpXlRE2UBtuKJJGMxLJ62LNEjjZOwAh68Zso4LYQMOYI33I+oPTfPyOwj
         Wc7mVuUVhqmC3M7XJp2iLcY2uJ7mvLKDp2Kbl8O+IDoCJrVh+DRCqq5VnKkeeXwDRfgj
         YoevtrQGNgGvnJpiVmPuTdKqamUMRBxJZqBCjrrUOy1lr6Q5ZVuMBgCv0ioRvbhTi/gb
         HdunTQhpdWiBfoi0BKgV3fU5HbdU1A5mjEvI4uj3CkmVIcoNAmqI8/s7ZdoCjDWhbO9m
         xuHg==
X-Gm-Message-State: APjAAAVCcUZZK+rlbqZ3x53wWtlLbsWpWO/Gxbct/CHCQiAmVb+QbLCE
        sQZ7Tm35vEaVKgVt7nl9P2/Dpd7JilXm6e8fIYqCm2W7Lis0
X-Google-Smtp-Source: APXvYqz342BJCt/AN9FiCyXjeazEfnOaDCC4XGXG8GtnWMadFyg9ATqeIwbauN31w5VOrXnuZxFG7MTng6MYeAH2x4ZocGDCF02Z
MIME-Version: 1.0
X-Received: by 2002:a6b:8fd1:: with SMTP id r200mr1206054iod.142.1557380406666;
 Wed, 08 May 2019 22:40:06 -0700 (PDT)
Date:   Wed, 08 May 2019 22:40:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb704c05886de151@google.com>
Subject: general protection fault in do_move_mount
From:   syzbot <syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    80f23212 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ab8dd0a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40a58b399941db7e
dashboard link: https://syzkaller.appspot.com/bug?extid=494c7ddf66acac0ad747
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+494c7ddf66acac0ad747@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8663 Comm: syz-executor.3 Not tainted 5.1.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_move_mount.isra.0+0x5eb/0xe00 fs/namespace.c:2602
Code: ff 45 89 e6 e9 a0 fb ff ff e8 d1 df b5 ff 48 8b 85 50 ff ff ff 48 8d  
78 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 6d 07 00 00 48 8b 85 50 ff ff ff 31 ff 4c 8b 78
RSP: 0018:ffff888067d97ca8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888067d97e18 RCX: ffffc9000c432000
RDX: 0000000000000009 RSI: ffffffff81baa93f RDI: 0000000000000048
RBP: ffff888067d97d88 R08: ffff88808a6020c0 R09: ffffed1015d26be0
R10: ffffed1015d26bdf R11: ffff8880ae935efb R12: ffff88809e88f700
R13: ffff88808a079620 R14: ffff888067d97e40 R15: ffff8880a99cf8f0
FS:  00007fb568cc3700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9870ffff4bb8 CR3: 000000008e438000 CR4: 00000000001426e0
Call Trace:
  do_move_mount_old fs/namespace.c:2662 [inline]
  do_mount+0xee7/0x1c00 fs/namespace.c:3108
  ksys_mount+0xdb/0x150 fs/namespace.c:3319
  __do_sys_mount fs/namespace.c:3333 [inline]
  __se_sys_mount fs/namespace.c:3330 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3330
  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458da9
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb568cc2c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458da9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000020000000
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000002002 R11: 0000000000000246 R12: 00007fb568cc36d4
R13: 00000000004c4dfd R14: 00000000004d8ac8 R15: 00000000ffffffff
Modules linked in:
---[ end trace f3c85670e73e74c9 ]---
RIP: 0010:do_move_mount.isra.0+0x5eb/0xe00 fs/namespace.c:2602
Code: ff 45 89 e6 e9 a0 fb ff ff e8 d1 df b5 ff 48 8b 85 50 ff ff ff 48 8d  
78 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 6d 07 00 00 48 8b 85 50 ff ff ff 31 ff 4c 8b 78
RSP: 0018:ffff888067d97ca8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888067d97e18 RCX: ffffc9000c432000
RDX: 0000000000000009 RSI: ffffffff81baa93f RDI: 0000000000000048
RBP: ffff888067d97d88 R08: ffff88808a6020c0 R09: ffffed1015d26be0
R10: ffffed1015d26bdf R11: ffff8880ae935efb R12: ffff88809e88f700
R13: ffff88808a079620 R14: ffff888067d97e40 R15: ffff8880a99cf8f0
FS:  00007fb568cc3700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000070d158 CR3: 000000008e438000 CR4: 00000000001426f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
