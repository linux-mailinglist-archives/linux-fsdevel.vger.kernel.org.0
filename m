Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7F5E9071
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 01:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiIXXgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 19:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiIXXgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 19:36:05 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52C399CB
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 16:36:02 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id f11-20020a5d858b000000b006a17b75af65so1909878ioj.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 16:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yTVKjYEt6Qsc4Nk9uruEWmQ7qup20JIbZji1PM3bE+8=;
        b=w4Lqz5r53fbDTIk//vZZdCqzuj92PC4vEqwI1IMZuz8ZMY75rVI4lDlRVYhGTeSN24
         EYjgie82JaCN06ssPlh5hZVmM+ajs4i8h3kaul9wQmqR1C5LnTwE7bQvbs58y+Eq7lf+
         FDjrc8kpDs7kpJxZL1+x92G7u8fl0UNHCwntziVM5rJa9J4B2xkenMtECBkQAY7ysp61
         k4cEX06Lp7efxWQzXV4OqsuKMFA4hf1XzusCwRz7OF+GKZM7dZP09CxFH596JBZKXmDy
         AIlgYqmaidJ7YLpPVvvkpLq/YNiwy3ffZ+RBwv3H8W9LV+0oh3Xy/rlV77HACtrXQuQF
         2R2Q==
X-Gm-Message-State: ACrzQf1zL8Z4zKSUvKeDRk0lEqoMp0HBXQvc92PqQ8Q74S8OXchaB5XC
        NdXxTnho/ifAy2KL2R0lQ9EaX+lfyFQHpX9CLfhCYfZht4Ml
X-Google-Smtp-Source: AMsMyM5G4iJY3OHLuYXGnWxUIu9foPRwWGpgDMstOdWr2d67mKjdTwg6LGHP4TYg1Ir6Ob8Ch9NwNGp8FsGkpqXZGRLKLPSwuXRi
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1687:b0:6a4:d44:74bf with SMTP id
 s7-20020a056602168700b006a40d4474bfmr5232265iow.80.1664062561998; Sat, 24 Sep
 2022 16:36:01 -0700 (PDT)
Date:   Sat, 24 Sep 2022 16:36:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4630c05e974c1eb@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in evict
From:   syzbot <syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163e7eb6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=6b74cf8fcd7378d8be7c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffc8
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD ba8f067 P4D ba8f067 PUD ba91067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10298 Comm: syz-executor.4 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5666 [inline]
RIP: 0010:lock_acquire+0x1aa/0x570 kernel/locking/lockdep.c:5631
Code: 48 81 64 24 08 00 02 00 00 44 89 fe 6a 00 4c 89 f7 6a 00 ff b4 24 f8 00 00 00 ff 74 24 18 41 0f 94 c1 45 0f b6 c9 e8 b5 94 ff <ff> 48 c7 c7 a0 8a cc 89 48 83 c4 20 e8 25 68 19 08 b8 ff ff ff ff
RSP: 0018:ffffc90013b2f9e8 EFLAGS: 00010092
RAX: 0000000000000001 RBX: 1ffff92002765f43 RCX: ffffffff815e4bee
RDX: 1ffff11003c8b8ae RSI: 0000000000000001 RDI: ffffffff8f67d5d8
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff9068e94f
R10: fffffbfff20d1d29 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801dac49d8 R15: 0000000000000000
FS:  00007fc2d48ce700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc8 CR3: 000000002043b000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_sb_list_del fs/inode.c:502 [inline]
 evict+0x179/0x6b0 fs/inode.c:653
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 ntfs_fill_super+0x2d75/0x3750 fs/ntfs3/super.c:1180
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc2d368a73a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc2d48cdf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fc2d368a73a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc2d48cdfe0
RBP: 00007fc2d48ce020 R08: 00007fc2d48ce020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fc2d48cdfe0 R15: 000000002007aa80
 </TASK>
Modules linked in:
CR2: ffffffffffffffc8
---[ end trace 0000000000000000 ]---
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5666 [inline]
RIP: 0010:lock_acquire+0x1aa/0x570 kernel/locking/lockdep.c:5631
Code: 48 81 64 24 08 00 02 00 00 44 89 fe 6a 00 4c 89 f7 6a 00 ff b4 24 f8 00 00 00 ff 74 24 18 41 0f 94 c1 45 0f b6 c9 e8 b5 94 ff <ff> 48 c7 c7 a0 8a cc 89 48 83 c4 20 e8 25 68 19 08 b8 ff ff ff ff
RSP: 0018:ffffc90013b2f9e8 EFLAGS: 00010092
RAX: 0000000000000001 RBX: 1ffff92002765f43 RCX: ffffffff815e4bee
RDX: 1ffff11003c8b8ae RSI: 0000000000000001 RDI: ffffffff8f67d5d8
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff9068e94f
R10: fffffbfff20d1d29 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88801dac49d8 R15: 0000000000000000
FS:  00007fc2d48ce700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc8 CR3: 000000002043b000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
