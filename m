Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB401F52AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFJK4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 06:56:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49173 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgFJK4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:56:13 -0400
Received: by mail-io1-f71.google.com with SMTP id d20so1276931iom.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 03:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LwSI8L+D98YJR3RL9cyL/ndGk3cpdIv1WYci/0oBLUw=;
        b=MIhnUQvN3xKArtiWVAPMjSpTvTaJjg23bmkI62gY1FYbOvu6zORh8uR7DjEooanbc1
         blozM9+TGke6LnMqcOVfXqe218Lc0d0dyWdezk3xgh0jMLG60YQdoKnICXmoc5ZA9Wnb
         SKfNTilM2+e4ncyF13DQ979NmrnL+wUWIdmnwkdS6PK6Q3n1TZ05v26L0AsKW9jzd2hA
         PINifCFVtrCK5IlS3zCQrDfA7zByVKMsu/7FVNyLZ7UgUjZeo76SXJ08A+V2/cjMuknw
         wmQo9hrlD9mSn66wGJN9ivQSy7ZqCGj0wXAjRQ/towRPK1/bDgwHiIs06dLGt6dpFqfb
         O2AA==
X-Gm-Message-State: AOAM533Cxyj/CMkTgkCDCf4P68sDEaeVvKGw+hXtG54qtSeWfSkrlpHa
        KZojBQLi+d4QhY6njhHEYsZqz/Ly42FhMwK9pRoAHFuAQLef
X-Google-Smtp-Source: ABdhPJzzwGUERjgq/5SoOOh/LDcmjlfsZEiRVIrdfFLs/3z0l6dwlvS07MAqvb31OSyfcta1eXTL6DXT9oNnXSkM7Ev2fD0vIplj
MIME-Version: 1.0
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr2660123ios.169.1591786571921;
 Wed, 10 Jun 2020 03:56:11 -0700 (PDT)
Date:   Wed, 10 Jun 2020 03:56:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d7ca605a7b8b1c5@google.com>
Subject: general protection fault in proc_kill_sb
From:   syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, ebiederm@xmission.com,
        gladkov.alexey@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e12212100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=4abac52934a48af5ff19
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com

RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000751 R14: 00000000004ca3ea R15: 00007f8970ff76d4
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 6840 Comm: syz-executor.2 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:proc_kill_sb+0x4d/0x110 fs/proc/root.c:267
Code: c1 ea 03 80 3c 02 00 0f 85 ad 00 00 00 49 8b ac 24 68 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a1 00 00 00 4c 8b 6d 08 4d 85 ed 74 0d e8 cb 51
RSP: 0018:ffffc90007b67d48 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffc9000d6d1000
RDX: 0000000000000001 RSI: ffffffff81e37c9d RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8c347a2f R11: fffffbfff1868f45 R12: ffff888059e1a000
R13: 00000000fffffff4 R14: 0000000000000000 R15: ffff888059e1a068
FS:  00007f8970ff7700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000073c138 CR3: 00000000588dc000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 deactivate_locked_super+0x8c/0xf0 fs/super.c:335
 vfs_get_super+0x258/0x2d0 fs/super.c:1212
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2874 [inline]
 do_mount+0x1306/0x1b40 fs/namespace.c:3199
 __do_sys_mount fs/namespace.c:3409 [inline]
 __se_sys_mount fs/namespace.c:3386 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3386
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca69
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8970ff6c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000004f62c0 RCX: 000000000045ca69
RDX: 00000000200000c0 RSI: 0000000020000200 RDI: 0000000020000340
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000751 R14: 00000000004ca3ea R15: 00007f8970ff76d4
Modules linked in:
---[ end trace 7f26d357bd21d77e ]---
RIP: 0010:proc_kill_sb+0x4d/0x110 fs/proc/root.c:267
Code: c1 ea 03 80 3c 02 00 0f 85 ad 00 00 00 49 8b ac 24 68 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a1 00 00 00 4c 8b 6d 08 4d 85 ed 74 0d e8 cb 51
RSP: 0018:ffffc90007b67d48 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffc9000d6d1000
RDX: 0000000000000001 RSI: ffffffff81e37c9d RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8c347a2f R11: fffffbfff1868f45 R12: ffff888059e1a000
R13: 00000000fffffff4 R14: 0000000000000000 R15: ffff888059e1a068
FS:  00007f8970ff7700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f19326ab000 CR3: 00000000588dc000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
