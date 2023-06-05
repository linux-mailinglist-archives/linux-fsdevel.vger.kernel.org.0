Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D7721CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 06:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFEEDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 00:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFEEDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:03:12 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7FB8
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 21:03:11 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-777b8c9cc4aso14203639f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 21:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685937790; x=1688529790;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVOsvXcBHRQXuC+HaYBG4xPvu1frqP2n2IrhjntNu7o=;
        b=V9DLfftbUdYp3N1hiVnZuxP+hLaBWrNbtqzAVLoqxEeH8NroSmbcUoZpnyIgYF14Db
         1dO72Ex3BYyzXvMXIPZ4y2v2vBxDxhh6TptIz4m2WyuOREnRGb9jOwchPO7JCBXQzya/
         BvN02vjpzUTsfQDaCMT4W2nIg7NSwSmxMr9XNmhOKqq3j1An11catRNj1N1tACH6I1NR
         gY6XtCJLh9NWG3MOhaD38y+qSkiTbGwHp2PDA7AOeYOXY9y1m8+8IbDZOcVPzRJsWwpF
         9KRjnmBJwlgY9+Xnwj7UkIfuURW8xqOdn5ufpqVXdxiyFOIN1Vzw2KBZRjRXHRdOzby3
         /+sw==
X-Gm-Message-State: AC+VfDzR8dv7U7gEuo5PcnnuKjc/VVzeVEZ2pRVyKumRQYRhsaKTe7ql
        iSn64l2N6GPDds80ujQd05GWk4U9UShKP5FEVrfr7Xim4AaS
X-Google-Smtp-Source: ACHHUZ6WaFnHIdICbA18XwFkw7JwL0glpHuMAjkCCLLM6s53s30InQQmtzga43KpDRW2uAdQgjDnKfouv/7o3Gqa5jaG4Hf2vqg7
MIME-Version: 1.0
X-Received: by 2002:a02:2941:0:b0:41c:feba:4e8a with SMTP id
 p62-20020a022941000000b0041cfeba4e8amr7546619jap.5.1685937790339; Sun, 04 Jun
 2023 21:03:10 -0700 (PDT)
Date:   Sun, 04 Jun 2023 21:03:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b4f6505fd59fb12@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in __ext4_ioctl
From:   syzbot <syzbot+a537ff48a9cb940d314c@syzkaller.appspotmail.com>
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

HEAD commit:    6f64a5ebe1dc Merge tag 'irq_urgent_for_v6.4_rc5' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108c54b3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3da6c5d3e0a6c932
dashboard link: https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c3283ed69ea/disk-6f64a5eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aeeba51b60c/vmlinux-6f64a5eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1962adc07598/bzImage-6f64a5eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a537ff48a9cb940d314c@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key __key.0, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 0 PID: 19058 at kernel/locking/lockdep.c:938 look_up_lock_class+0xac/0x130 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 0 PID: 19058 Comm: syz-executor.1 Not tainted 6.4.0-rc4-syzkaller-00371-g6f64a5ebe1dc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:look_up_lock_class+0xac/0x130 kernel/locking/lockdep.c:938
Code: 39 48 8b 55 00 48 81 fa 20 18 16 90 74 2c 80 3d 99 eb 54 04 00 75 23 48 c7 c7 c0 6c 4c 8a c6 05 89 eb 54 04 01 e8 34 28 3c f7 <0f> 0b eb 0c e8 1b 25 00 fa 85 c0 75 48 45 31 e4 48 83 c4 08 4c 89
RSP: 0018:ffffc9000dfc7810 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff91f0c721 RCX: ffffc9000b9e4000
RDX: 0000000000040000 RSI: ffffffff814c03a7 RDI: 0000000000000001
RBP: ffff888056cc3488 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff915b7720
R13: 0000000000000001 R14: ffff888056cc3488 R15: 0000000000000001
FS:  00007fd430ba3700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c928000 CR3: 000000004fd89000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 register_lock_class+0xbe/0x1120 kernel/locking/lockdep.c:1290
 __lock_acquire+0x10d/0x5f30 kernel/locking/lockdep.c:4965
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
 ext4_double_down_write_data_sem+0x67/0x80 fs/ext4/move_extent.c:58
 swap_inode_boot_loader fs/ext4/ioctl.c:423 [inline]
 __ext4_ioctl+0x2aa1/0x4b00 fs/ext4/ioctl.c:1418
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd42fe8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd430ba3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd42ffabf80 RCX: 00007fd42fe8c169
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00007fd42fee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd8894480f R14: 00007fd430ba3300 R15: 0000000000022000
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
