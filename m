Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFB6EB21A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjDUTHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjDUTHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:07:45 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426718C
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 12:07:43 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-328f6562564so38082155ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 12:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104063; x=1684696063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8fSKQFPH5kS6exwTF04tijLARI26+Y3UxxpPHRzKuo=;
        b=hb7jl6w5/ureh/UPvxJdSLIak0qQe8hnogG3+NCFwvfHgnxR5+CohO/0WomjDukOJY
         dO+pyzwKHqM80gKExgeLSpdUT9LIZPsmhhyFQ06vMSxjdub/GuG2HV7i7Bq0ZVz9l5Wd
         YbxvhLCjA6Dkq4Axxm0Qa2oj2t1HUhvbIJkIt0O8XRWobm5XFjr8E1wW7MwlItulGdGM
         YvjbVbKPtfUqRmJ0BsaipkNqstqDRyWNjH/64AwQTCst5NzYsGhi6YJ6OPSmZHdggnFz
         PYK3i3z15K6kSpWryljZ+4nXkyOdiAIsyoGD2LM0Sk7Yr9oCWbNYgZqxLsVC0KI2OPM6
         BK8Q==
X-Gm-Message-State: AAQBX9d7AYUdYAPQl4ser6dtWpTx+sFRM1AiwRZ9Yrhclz4HFEZZ8wL6
        zwCVwsdVlMS6fzSL0KbG5GK8OXbeonTb/BnwwlIXLL0O7Ggt
X-Google-Smtp-Source: AKy350bZfOZP7c87py9gvehAPKMTfhK10b753NDTTeN9IJTAEEx8JH8/J5FFIhC6fgpbRpzqRAok5h7TwBipEPiiRw8YFZtA9+ri
MIME-Version: 1.0
X-Received: by 2002:a92:db42:0:b0:32b:3816:772a with SMTP id
 w2-20020a92db42000000b0032b3816772amr3393249ilq.6.1682104063154; Fri, 21 Apr
 2023 12:07:43 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:07:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028e2b905f9dd5f51@google.com>
Subject: [syzbot] [ext4?] WARNING: bad unlock balance in unlock_two_nondirectories
From:   syzbot <syzbot+6c73bd34311ee489dbf5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb0856346a60 Merge tag 'mm-hotfixes-stable-2023-04-19-16-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160d85b8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11869c60f54496a7
dashboard link: https://syzkaller.appspot.com/bug?extid=6c73bd34311ee489dbf5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03697c95ad2e/disk-cb085634.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e699bef459f/vmlinux-cb085634.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1be3bc4b60fd/bzImage-cb085634.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c73bd34311ee489dbf5@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0 Not tainted
-------------------------------------
syz-executor.3/10999 is trying to release lock (&type->i_mutex_dir_key) at:
[<ffffffff81ea121d>] inode_unlock include/linux/fs.h:763 [inline]
[<ffffffff81ea121d>] unlock_two_nondirectories+0xbd/0x100 fs/inode.c:1138
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor.3/10999:
 #0: ffff88803ff8a460 (sb_writers#4){.+.+}-{0:0}, at: __ext4_ioctl+0x10c9/0x4b00 fs/ext4/ioctl.c:1415

stack backtrace:
CPU: 1 PID: 10999 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 __lock_release kernel/locking/lockdep.c:5346 [inline]
 lock_release+0x4f1/0x670 kernel/locking/lockdep.c:5689
 up_write+0x2a/0x520 kernel/locking/rwsem.c:1625
 inode_unlock include/linux/fs.h:763 [inline]
 unlock_two_nondirectories+0xbd/0x100 fs/inode.c:1138
 swap_inode_boot_loader fs/ext4/ioctl.c:510 [inline]
 __ext4_ioctl+0x31d3/0x4b00 fs/ext4/ioctl.c:1418
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9dc1a8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9dc2726168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9dc1babf80 RCX: 00007f9dc1a8c169
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00007f9dc1ae7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd35fd2d0f R14: 00007f9dc2726300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88803e77a1a8, owner = 0x0, curr 0xffff8880842f0000, list empty
WARNING: CPU: 1 PID: 10999 at kernel/locking/rwsem.c:1369 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 1 PID: 10999 at kernel/locking/rwsem.c:1369 up_write+0x425/0x520 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 1 PID: 10999 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x425/0x520 kernel/locking/rwsem.c:1626
Code: 3c 02 00 0f 85 da 00 00 00 48 8b 55 00 4d 89 f1 53 4d 89 f8 4c 89 e9 48 c7 c6 a0 52 4c 8a 48 c7 c7 40 51 4c 8a e8 bb 22 e8 ff <0f> 0b 59 e9 dd fc ff ff 48 89 df e8 9b ca 70 00 e9 1a fc ff ff 48
RSP: 0018:ffffc900167afbd8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8a4c5080 RCX: ffffc9000b5fa000
RDX: 0000000000040000 RSI: ffffffff814b6247 RDI: 0000000000000001
RBP: ffff88803e77a1a8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 57525f4755424544 R12: ffff88803e77a1b0
R13: ffff88803e77a1a8 R14: ffff8880842f0000 R15: 0000000000000000
FS:  00007f9dc2726700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c02174f2f8 CR3: 000000002b502000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:763 [inline]
 unlock_two_nondirectories+0xbd/0x100 fs/inode.c:1138
 swap_inode_boot_loader fs/ext4/ioctl.c:510 [inline]
 __ext4_ioctl+0x31d3/0x4b00 fs/ext4/ioctl.c:1418
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9dc1a8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9dc2726168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9dc1babf80 RCX: 00007f9dc1a8c169
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00007f9dc1ae7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd35fd2d0f R14: 00007f9dc2726300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
