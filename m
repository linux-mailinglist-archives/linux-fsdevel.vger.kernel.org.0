Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62F827A8BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgI1HgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 03:36:17 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:41633 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgI1HgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:36:16 -0400
Received: by mail-il1-f206.google.com with SMTP id a16so101710ilh.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 00:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=k3uruzQgSMTbGqxoGnXfxSAPhtqLRQc7ySzNeuwSBkg=;
        b=D8hj/UldlI9dnTcndswJ0gaA+iTwZKPtBV7HLGUchBKcJA5NVE/02WzCjCvIMy8sSX
         srjtpV0goIrx2aQ3rL3txWxtJCuZdZKl/hiDdRYNFrFm0VZFgveX75SZ8WWJ28r0JNu6
         MxC9sy2RTJCTPeaft/Gpka94tc8/zxU7bltre5zrXt+O0jueFTqazkA4UassGZg1TSQ1
         6hgXromzsOgy9VPTCwQTWf9/gVFYynCsnUfIuuuRDdqaaFLqjJxY65y6EBnqBHzSfONQ
         wKSflcCwUxKaEMw8oU1gLv0MeuRAEuV2LaUhNt3HMU4MSjUFXSkkDuP9laxZVQckul7+
         JNrw==
X-Gm-Message-State: AOAM533XiHqlZ9B+VeYz2ArX/9NVwX8IaNtE8R3EjstOI+4w/X3jl1MS
        QSsnNhkbuuxreOUtC4c13jBxVeokU6QLpP5SYHqvz+AhOvhu
X-Google-Smtp-Source: ABdhPJzt1CJmNQM9vQiFPXYsei9im+1gRXxqCm+/OUKU4USTyz8S7se4WeWppbUiBrCq4Foh7PiBYtnJIT1NX2omc04Syji+pxOT
MIME-Version: 1.0
X-Received: by 2002:a92:7989:: with SMTP id u131mr101117ilc.93.1601278575686;
 Mon, 28 Sep 2020 00:36:15 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:36:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0bbc905b05ab8d5@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in __lookup_slow
From:   syzbot <syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c7ec322 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17289773900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=240e2ebab67245c7
dashboard link: https://syzkaller.appspot.com/bug?extid=3db80bbf66b88d68af9d
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com

REISERFS (device loop1): Using r5 hash to sort names
REISERFS (device loop1): using 3.5.x disk format
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD a7454067 P4D a7454067 PUD 93380067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9128 Comm: syz-executor.1 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90008bbf910 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff92001177f25 RCX: ffffc9000aad7000
RDX: 0000000000000000 RSI: ffff888085c9f330 RDI: ffff88804358f7e0
RBP: ffffffff889c4280 R08: 0000000000000001 R09: ffffffff8d461a7f
R10: 0000000000000000 R11: 000000000005f088 R12: ffff888085c9f330
R13: ffff88804358f7e0 R14: ffffc90008bbfaa0 R15: ffffc90008bbf948
FS:  00007f6bb6cc7700(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000a75b9000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __lookup_slow+0x24c/0x480 fs/namei.c:1544
 lookup_one_len+0x163/0x190 fs/namei.c:2562
 reiserfs_lookup_privroot+0x92/0x280 fs/reiserfs/xattr.c:972
 reiserfs_fill_super+0x211b/0x2df3 fs/reiserfs/super.c:2176
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460bca
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 87 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 ba 87 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f6bb6cc6a88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6bb6cc6b20 RCX: 0000000000460bca
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f6bb6cc6ae0
RBP: 00007f6bb6cc6ae0 R08: 00007f6bb6cc6b20 R09: 0000000020000000
R10: 0000000000a04850 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020000040
Modules linked in:
CR2: 0000000000000000
---[ end trace 79d7e2c3db21cbd3 ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90008bbf910 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff92001177f25 RCX: ffffc9000aad7000
RDX: 0000000000000000 RSI: ffff888085c9f330 RDI: ffff88804358f7e0
RBP: ffffffff889c4280 R08: 0000000000000001 R09: ffffffff8d461a7f
R10: 0000000000000000 R11: 000000000005f088 R12: ffff888085c9f330
R13: ffff88804358f7e0 R14: ffffc90008bbfaa0 R15: ffffc90008bbf948
FS:  00007f6bb6cc7700(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558411c291f8 CR3: 00000000a75b9000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
