Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708E520EEEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgF3HCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 03:02:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54630 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgF3HCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:02:16 -0400
Received: by mail-io1-f72.google.com with SMTP id t23so12535216iog.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 00:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ECzA0dtAJHjhAvJtCFt9qVVpvMOwHbK1fmaElxhvgYw=;
        b=bq3DroEpEHKxgZZAKl38nDC4gLN3m3zHcWBsu5t4/7y1hfL+MXAuL6va6aac3RZFq6
         yFLvbXsSU4GSRWlQgHifr13ep3Snj0ftvlg0UBCePKzsBt+w8eg03SjSBKEcfrKCs8v0
         NAHcQ28JNuCfQ4ZOhImWgEhQpm+4s+jC0zZS66RNfw0ZzEKVGEbqAel2FDtJmb8YFQds
         j7xTUSIybxIEM39Zv2NA8MEVjm2Ym2SEAw/jITSQmXDvyr1uWNgWwhZNGIx3jLW38QIx
         9+bQz0h/iqnH1jDT08mg0BKml9IoLtxvh7bp6S/e7zbT68VM9IK49d/I2H/ol/4R0iQz
         BN/A==
X-Gm-Message-State: AOAM5325C8CQPkXNGh+JtNeVBRzX/82lV9W5psxU9xZGbT2lQX718QxN
        91LcK8wZKRFH8QVEJJQfdriesOT4huRaUh5ZwoTBsgOT9A/X
X-Google-Smtp-Source: ABdhPJzTG/kuqgmwJS3mcXjkL9h0Lc571CELKWsFFh2qHpXJc6I7ogmcz5bq3MdTCfOCjDrkpL0sOCgHPx2oDK0uTnFcDJamR9Ez
MIME-Version: 1.0
X-Received: by 2002:a6b:b457:: with SMTP id d84mr20392610iof.21.1593500535403;
 Tue, 30 Jun 2020 00:02:15 -0700 (PDT)
Date:   Tue, 30 Jun 2020 00:02:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cb9dc05a947c16e@google.com>
Subject: general protection fault in create_empty_buffers (3)
From:   syzbot <syzbot+66017672f8ea3c492d56@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4e99b321 Merge tag 'nfs-for-5.8-2' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14355b4b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=66017672f8ea3c492d56
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+66017672f8ea3c492d56@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3911 Comm: systemd-udevd Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:create_empty_buffers+0x4f/0x820 fs/buffer.c:1565
Code: 89 ef e8 94 9a ff ff 49 bc 00 00 00 00 00 fc ff df 48 89 44 24 08 48 89 c3 eb 03 48 89 c3 e8 78 9c a6 ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 a8 06 00 00 4c 09 2b 48 8d 7b 08 48 89 f8 48
RSP: 0018:ffffc90001577858 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81cc51b9
RDX: ffff8880a0d5c580 RSI: ffffffff81ccb478 RDI: 0000000000000005
RBP: ffffea00027d2dc0 R08: 0000000000000001 R09: ffff8880a0d5ce48
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dead000000000100
FS:  00007fbeb87098c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 00000000a03ad000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 create_page_buffers+0x295/0x3b0 fs/buffer.c:1679
 block_read_full_page+0xcf/0xed0 fs/buffer.c:2269
 do_read_cache_page+0x8d4/0x1390 mm/filemap.c:2765
 read_mapping_page include/linux/pagemap.h:437 [inline]
 read_part_sector+0xf6/0x5af block/partitions/core.c:772
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:140 [inline]
 blk_add_partitions+0x44b/0xe10 block/partitions/core.c:700
 bdev_disk_changed+0x1ea/0x370 fs/block_dev.c:1524
 blkdev_reread_part block/ioctl.c:103 [inline]
 blkdev_common_ioctl+0x13d1/0x1760 block/ioctl.c:549
 blkdev_ioctl+0x1a3/0x6c0 block/ioctl.c:618
 block_ioctl+0xf9/0x140 fs/block_dev.c:1988
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fbeb7582017
Code: Bad RIP value.
RSP: 002b:00007fff18b4d7e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff18b4d960 RCX: 00007fbeb7582017
RDX: 0000000000000000 RSI: 000000000000125f RDI: 000000000000000e
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000020 R11: 0000000000000246 R12: 00007fff18b4d990
R13: 000055f766174010 R14: 000055f767066210 R15: 00007fff18b4d860
Modules linked in:
---[ end trace 3a62581c64dab56e ]---
RIP: 0010:create_empty_buffers+0x4f/0x820 fs/buffer.c:1565
Code: 89 ef e8 94 9a ff ff 49 bc 00 00 00 00 00 fc ff df 48 89 44 24 08 48 89 c3 eb 03 48 89 c3 e8 78 9c a6 ff 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 a8 06 00 00 4c 09 2b 48 8d 7b 08 48 89 f8 48
RSP: 0018:ffffc90001577858 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81cc51b9
RDX: ffff8880a0d5c580 RSI: ffffffff81ccb478 RDI: 0000000000000005
RBP: ffffea00027d2dc0 R08: 0000000000000001 R09: ffff8880a0d5ce48
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dead000000000100
FS:  00007fbeb87098c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f2d000 CR3: 00000000a03ad000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
