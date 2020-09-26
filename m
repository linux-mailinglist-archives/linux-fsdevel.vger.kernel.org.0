Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D366279659
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgIZC6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 22:58:18 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:33226 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIZC6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 22:58:18 -0400
Received: by mail-io1-f77.google.com with SMTP id l22so3609657iol.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 19:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JxillUE/CAFTAJxMn16vSJNPYmIZl3QapnqwSeueIkc=;
        b=XvTBDLdlAvqB/lDOAGeH5+Snv3xdDUlMp3kjkDp13z1AqS6ZqFEnXQ478ABIPMRgPe
         FPlXJWzeEQb/4NMaOMfj7da4dNdD9zZChLqUy22jHFvpyez5omzTw8qFUHv5Lq/vVwPH
         hK25lm3RhwKCm9ctADTgKfPfToUvuUk7G4z16wECCscNMIT4bYyQ9q/eERV00XhcGox0
         Q1LYp5kvUgcttGoK5ZE2VxpzqdvSt58iaBkKl6evzoRCNibNfgBLUuxIDNHGlWnxb8aW
         dYlGwuLtl+wYjpqFwWwbKQnGTR+FgempRvgUUNUu+0XaQEd1fGZXbxZ1X2CPzGN5m+7v
         j3wg==
X-Gm-Message-State: AOAM530e/Z6FsNOFd5mI9MDXmDpUuqionWPupCID+otadYBq6o0GeByF
        ZaoiJHX4AUmL82qSNGsUFnXFypla9Ni3q1Uc8HDp7WkIxl9h
X-Google-Smtp-Source: ABdhPJycHIFX6DalLxqqZeKlk+ezYA9xgmGuCW8DHk/X7yD56zZ2Oxs3ayHthY7GPECSbP/hvfq4lytAlF8i9k4zQX3GL0duyJG/
MIME-Version: 1.0
X-Received: by 2002:a92:50c:: with SMTP id q12mr2630599ile.8.1601089096553;
 Fri, 25 Sep 2020 19:58:16 -0700 (PDT)
Date:   Fri, 25 Sep 2020 19:58:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da992305b02e9a51@google.com>
Subject: WARNING in __kernel_read (2)
From:   syzbot <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b10b8ad8 Add linux-next specific files for 20200921
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1437eff1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf0782933432b43
dashboard link: https://syzkaller.appspot.com/bug?extid=51177e4144d764827c45
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f9f08d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d67c81900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51177e4144d764827c45@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7028 at fs/read_write.c:440 __kernel_read+0x80e/0xa10 fs/read_write.c:440
Modules linked in:
CPU: 0 PID: 7028 Comm: syz-executor458 Not tainted 5.9.0-rc5-next-20200921-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__kernel_read+0x80e/0xa10 fs/read_write.c:440
Code: 8a e8 c6 97 12 02 31 ff 89 c3 89 c6 e8 2b ac b3 ff 85 db 0f 85 6e 3b 55 06 49 c7 c5 ea ff ff ff e9 bd fd ff ff e8 b2 af b3 ff <0f> 0b 49 c7 c5 ea ff ff ff e9 aa fd ff ff e8 9f af b3 ff 48 89 ea
RSP: 0018:ffffc90006027b38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffff81c1715b
RDX: ffff888091eba480 RSI: ffffffff81c1787e RDI: 0000000000000005
RBP: 000000000008801c R08: 0000000000000001 R09: ffff888091ebad88
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a16710c0
R13: 0000000000000001 R14: ffffc90006027d08 R15: ffff8880a1671144
FS:  00007efcd60f1700(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000a2dc5000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernel_read+0x52/0x70 fs/read_write.c:471
 kernel_read_file fs/exec.c:989 [inline]
 kernel_read_file+0x2e5/0x620 fs/exec.c:952
 kernel_read_file_from_fd+0x56/0xa0 fs/exec.c:1076
 __do_sys_finit_module+0xe6/0x190 kernel/module.c:4066
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44a639
Code: e8 bc b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 4b cc fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007efcd60f0db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 00000000006dbc68 RCX: 000000000044a639
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006dbc60 R08: 00007efcd60f1700 R09: 0000000000000000
R10: 00007efcd60f1700 R11: 0000000000000246 R12: 00000000006dbc6c
R13: 00007ffd3d8928ef R14: 00007efcd60f19c0 R15: 0000000000000001


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
