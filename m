Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFABA1245DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 12:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRLgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 06:36:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40271 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRLgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:36:09 -0500
Received: by mail-io1-f70.google.com with SMTP id q19so1151763ion.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 03:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rUYOAmprzzwSZ1SExj6u5VDSkud8JlPzr8WL2vUkB5Y=;
        b=akJWMMX7bWIa0YyAT0k5AyVaOpMEZaNr+TnnLdpC1YoxSvEdlF8rxX9YA4u/ix+aYO
         bZkmE/thDyy/nm4p22VRRKG0MJ4GgPPa3ldu6zPc4ARDA32aWNXhby3txvYulUwdqeYi
         P05yUU5TYKmHmzszp4sYHi2ZNXepIAYd1n+GyBAAWu5tIUr2FpUU1ALHYRn8PfVt4oVe
         EE68+bKBiMtAfRMDSKfBT0C7L4FDVvEDOHGV3wfXmiajarq3mT4HH/DL4NEFytgke3uG
         Fhat17xExndtMPlZ3oF2PYVcFl4lzDI9CNW6mv1b2ZWpEdjZT9govWOzga5Xpfmdebve
         agPw==
X-Gm-Message-State: APjAAAV9miW8PreVxMQlfg3ciJub49A9u00Sp5eXPuCMH86yeEXBAebc
        VZgMhYMyT/0GTMM6NErqQMY9DnRd1DXqvNGO/OjQqeMax8v7
X-Google-Smtp-Source: APXvYqwqzQBj3s7DOPdgew9KKcoV50sx+/SGzNvS6nUcHbfJ3/IaK3KZrHuSTScFnyeXU+21JFHJpXFa6yppVAbmSEhEs9XGLQrJ
MIME-Version: 1.0
X-Received: by 2002:a92:3c41:: with SMTP id j62mr1328186ila.149.1576668968899;
 Wed, 18 Dec 2019 03:36:08 -0800 (PST)
Date:   Wed, 18 Dec 2019 03:36:08 -0800
In-Reply-To: <0000000000002df264056a35b16b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1dc120599f8d953@google.com>
Subject: Re: kernel BUG at fs/buffer.c:LINE!
From:   syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    2187f215 Merge tag 'for-5.5-rc2-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154f72fee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1171ba8ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107440aee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:3094!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10075 Comm: syz-executor292 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:submit_bh_wbc+0x71c/0x900 fs/buffer.c:3094
Code: 14 e5 ff f0 80 63 01 f7 e9 ab fa ff ff e8 bc a5 a7 ff 41 81 cd 00 10  
00 00 e9 4d fe ff ff e8 ab a5 a7 ff 0f 0b e8 a4 a5 a7 ff <0f> 0b e8 9d a5  
a7 ff 0f 0b e8 96 a5 a7 ff 0f 0b e8 8f a5 a7 ff 0f
RSP: 0018:ffffc90001f37bf8 EFLAGS: 00010293
RAX: ffff888097cd6540 RBX: ffff88808c089888 RCX: ffffffff81cd7f8d
RDX: 0000000000000000 RSI: ffffffff81cd85fc RDI: 0000000000000001
RBP: ffffc90001f37c40 R08: ffff888097cd6540 R09: ffffed1011811312
R10: ffffed1011811311 R11: ffff88808c08988f R12: 0000000000000000
R13: 0000000000000800 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000001f36940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41849f0ef0 CR3: 0000000095d70000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  submit_bh fs/buffer.c:3141 [inline]
  __sync_dirty_buffer+0x12b/0x350 fs/buffer.c:3227
  sync_dirty_buffer+0x1b/0x20 fs/buffer.c:3240
  fat_set_state+0x242/0x330 fs/fat/inode.c:708
  fat_put_super+0x46/0xd0 fs/fat/inode.c:734
  generic_shutdown_super+0x14c/0x370 fs/super.c:462
  kill_block_super+0xa0/0x100 fs/super.c:1442
  deactivate_locked_super+0x95/0x100 fs/super.c:335
  deactivate_super fs/super.c:366 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:362
  cleanup_mnt+0x351/0x4c0 fs/namespace.c:1102
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1109
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448c07
Code: 00 00 00 b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 5d a2 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3d a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc40282788 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000000000002675b RCX: 0000000000448c07
RDX: 0000000000400dc7 RSI: 0000000000000002 RDI: 00007ffc40282830
RBP: 0000000000002abe R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000005 R11: 0000000000000206 R12: 00007ffc40283890
R13: 0000000001f37940 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace c010b278a98f0232 ]---
RIP: 0010:submit_bh_wbc+0x71c/0x900 fs/buffer.c:3094
Code: 14 e5 ff f0 80 63 01 f7 e9 ab fa ff ff e8 bc a5 a7 ff 41 81 cd 00 10  
00 00 e9 4d fe ff ff e8 ab a5 a7 ff 0f 0b e8 a4 a5 a7 ff <0f> 0b e8 9d a5  
a7 ff 0f 0b e8 96 a5 a7 ff 0f 0b e8 8f a5 a7 ff 0f
RSP: 0018:ffffc90001f37bf8 EFLAGS: 00010293
RAX: ffff888097cd6540 RBX: ffff88808c089888 RCX: ffffffff81cd7f8d
RDX: 0000000000000000 RSI: ffffffff81cd85fc RDI: 0000000000000001
RBP: ffffc90001f37c40 R08: ffff888097cd6540 R09: ffffed1011811312
R10: ffffed1011811311 R11: ffff88808c08988f R12: 0000000000000000
R13: 0000000000000800 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000001f36940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000152d458 CR3: 0000000095d70000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

