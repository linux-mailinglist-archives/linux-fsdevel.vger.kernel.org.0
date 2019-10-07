Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE20CE542
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 16:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfJGObI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 10:31:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54479 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJGObI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:31:08 -0400
Received: by mail-io1-f71.google.com with SMTP id w8so26904223iod.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 07:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7BY87Ia9AapGjwjMXbsBZnoMaLjgwwjSG2VntvLmU4c=;
        b=B3IH4aVuJzn4kEPOV1OWOivUT+3vkBmIop6+67DDwOvaJH5YQDEJEXVoyWGyr8JJFt
         Ud+mp2YBkUcfFjrVSOyMrEZ9GfLoDXgCD0/NgAwe2TCIs1i6onZ7WKv9Ir/+4J4dFf3W
         OqkNuqs2jvLC1ceck6yMmQaFWs/bFOHhP247rkDdqSj+hJPdBS4lD1PY/mljnsU/hJjc
         3puYtarfJk6+rRGllQo5E7EAjX9GZGkYqdUEOohtsFBNW0wbNbJ/DHlCzDmNug7i8MKf
         plReoShzvuzP+K2fbZYHxtAsmxP7+Ku2FRfaircVTM3AVXTZCGDLnWtok+2aJNIir1Lr
         NtyA==
X-Gm-Message-State: APjAAAX8u0/1ws2+clcUhotQjrblgpuy1j5J2XlrW0xgCz/Uyn8SIVdW
        aEBfKHGFGa8jcGT3A21l+ZxKG7M6oLVHF2jHjTpt/tpyA2Qq
X-Google-Smtp-Source: APXvYqwHM30N8tl1H9tiWFEkk5uQF9JjeMTKqdai85oDJLXRimIYKTBAZ9aPa3GdJ+Ja7qB/Sbi3nEzbTc+XziR64uB+U2mBU037
MIME-Version: 1.0
X-Received: by 2002:a92:d14b:: with SMTP id t11mr28007911ilg.126.1570458667508;
 Mon, 07 Oct 2019 07:31:07 -0700 (PDT)
Date:   Mon, 07 Oct 2019 07:31:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002edb7059452e7fb@google.com>
Subject: WARNING in verify_dirent_name
From:   syzbot <syzbot+76e3977ad1b8cc4d113a@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12165d0b600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ec3be9936e004f6
dashboard link: https://syzkaller.appspot.com/bug?extid=76e3977ad1b8cc4d113a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+76e3977ad1b8cc4d113a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 25558 at fs/readdir.c:150 verify_dirent_name+0x67/0x80  
fs/readdir.c:150
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 25558 Comm: syz-executor.2 Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:verify_dirent_name+0x67/0x80 fs/readdir.c:150
Code: 19 b6 ff 44 89 e0 5b 41 5c 5d c3 e8 43 19 b6 ff 0f 0b e8 3c 19 b6 ff  
41 bc fb ff ff ff 5b 44 89 e0 41 5c 5d c3 e8 29 19 b6 ff <0f> 0b 41 bc fb  
ff ff ff eb ca 0f 1f 44 00 00 66 2e 0f 1f 84 00 00
RSP: 0018:ffff88808db87ad0 EFLAGS: 00010212
RAX: 0000000000040000 RBX: 000000000000000c RCX: ffffc900143e7000
RDX: 0000000000004d26 RSI: ffffffff81bcf9b7 RDI: ffff88808db87cd3
RBP: ffff88808db87ae0 R08: ffff88808f5c41c0 R09: 0000000000000004
R10: fffffbfff120d9b8 R11: ffffffff8906cdc3 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000004 R15: ffff88808db87e50
  filldir64+0x40/0x670 fs/readdir.c:356
  dir_emit include/linux/fs.h:3542 [inline]
  __fat_readdir+0xd9e/0x1cb0 fs/fat/dir.c:677
  fat_readdir+0x44/0x60 fs/fat/dir.c:704
  iterate_dir+0x47f/0x5e0 fs/readdir.c:105
  ksys_getdents64+0x1ce/0x320 fs/readdir.c:412
  __do_sys_getdents64 fs/readdir.c:431 [inline]
  __se_sys_getdents64 fs/readdir.c:428 [inline]
  __x64_sys_getdents64+0x73/0xb0 fs/readdir.c:428
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc825c13c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
RDX: 0000000000001000 RSI: 00000000200005c0 RDI: 0000000000000007
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc825c146d4
R13: 00000000004c0533 R14: 00000000004d2c58 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
