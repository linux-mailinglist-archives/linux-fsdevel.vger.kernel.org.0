Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB20CE53F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfJGOaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 10:30:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38836 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:30:08 -0400
Received: by mail-io1-f70.google.com with SMTP id e6so27058549iog.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 07:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sPnceGy4KIQEpbbOvELtAtUJXVUVS43coZhCQeMu3P0=;
        b=V2pZxRmjRj4j1LY3MNUMn2i6Dr0p8Unm0yFruc9LE+NwoQGvmkaGNyFX8CEnJ5CK7T
         kTsmaHtvRn4pi+96pR443iC0srvwqiNBBO/dsH79Rt19dq3NuKs/UafCt0qkgz5Es2y3
         IQA1I+6cem9nX+IB7fomMiZndrtZ/n4A2w+bbO6nY2AFhVSH+OcpI4nbFBwuK1M/wMod
         y/kawdpSm95tzKOeepxiuABawNcPRo53lj27DCatXVgReOObtjPAM7mm4cF7WUAe8BAM
         XA7G0PcR+gQ2TIg4mQEyJhni8MBK6WMilSv1Za7nzwDmLOzq8JY2feWI51ExrMdkYr1s
         UQdA==
X-Gm-Message-State: APjAAAW1GmnmRimtba2ubFqyr4nCIpPxA97vkOYnC4xG7aAZaJqXRdD8
        aq+9d+0edRG3x5/+XQzGP2fLf840cfDsQcvrB3RW+wNsezLy
X-Google-Smtp-Source: APXvYqw6bMONiAXK3jAD+QHsaAQGL2DxyMV4QlaIUZAMVOoWVo3N+LG+gJwsA2BOPRhEraq3wKaxRgYZGqLSK6QLGem4nlaDNB6t
MIME-Version: 1.0
X-Received: by 2002:a5e:a818:: with SMTP id c24mr12978584ioa.230.1570458607252;
 Mon, 07 Oct 2019 07:30:07 -0700 (PDT)
Date:   Mon, 07 Oct 2019 07:30:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b7bfb059452e314@google.com>
Subject: WARNING in filldir64
From:   syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    43b815c6 Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10721dfb600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb0b431ccdf08c1c
dashboard link: https://syzkaller.appspot.com/bug?extid=3031f712c7ad5dd4d926
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10405 at fs/readdir.c:150 verify_dirent_name  
fs/readdir.c:150 [inline]
WARNING: CPU: 1 PID: 10405 at fs/readdir.c:150 filldir64+0x524/0x620  
fs/readdir.c:356
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 10405 Comm: syz-executor.2 Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x25c/0x799 kernel/panic.c:220
  __warn+0x20e/0x210 kernel/panic.c:581
  report_bug+0x1b6/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:verify_dirent_name fs/readdir.c:150 [inline]
RIP: 0010:filldir64+0x524/0x620 fs/readdir.c:356
Code: 00 00 c7 03 f2 ff ff ff b8 f2 ff ff ff 48 83 c4 60 5b 41 5c 41 5d 41  
5e 41 5f 5d c3 e8 55 2c b9 ff 0f 0b eb 07 e8 4c 2c b9 ff <0f> 0b 49 83 c6  
24 4c 89 f0 48 c1 e8 03 42 8a 04 20 84 c0 0f 85 b6
RSP: 0018:ffff8880a3dc7b88 EFLAGS: 00010283
RAX: ffffffff81ba0624 RBX: 000000000000000c RCX: 0000000000040000
RDX: ffffc9000a588000 RSI: 00000000000021f1 RDI: 00000000000021f2
RBP: ffff8880a3dc7c10 R08: ffffffff81ba0134 R09: 0000000000000004
R10: fffffbfff1120afb R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880a3dc7d30 R14: ffff8880a3dc7e88 R15: 000000000000000c
  dir_emit include/linux/fs.h:3542 [inline]
  __fat_readdir+0x1320/0x1a50 fs/fat/dir.c:677
  fat_readdir+0x46/0x50 fs/fat/dir.c:704
  iterate_dir+0x2a4/0x520 fs/readdir.c:107
  ksys_getdents64+0x1ea/0x3f0 fs/readdir.c:412
  __do_sys_getdents64 fs/readdir.c:431 [inline]
  __se_sys_getdents64 fs/readdir.c:428 [inline]
  __x64_sys_getdents64+0x7a/0x90 fs/readdir.c:428
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f943ff4bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
RDX: 0000000000001000 RSI: 00000000200005c0 RDI: 0000000000000005
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f943ff4c6d4
R13: 00000000004c0533 R14: 00000000004d2c58 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
