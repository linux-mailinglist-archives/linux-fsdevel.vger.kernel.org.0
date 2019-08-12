Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71389555
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 04:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHLCHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 22:07:07 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:47312 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHLCHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 22:07:07 -0400
Received: by mail-ot1-f71.google.com with SMTP id g76so5886925otg.14
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2019 19:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pA4ajK2mL+OR2q0DCzQWIvgz3qE+KSagbdoGlUva7a4=;
        b=D0eLpGGKAduA+BJibNWMN9vtcfF5X/tsgClbDPnMb3O2BKk/6+eRbOQX7emnOeV5gD
         rf/XxjoyvELFpFF/wj+Og7Vg7iYW+zxjeB1rlOMKYnqiQUVOaHUXj782qSRKyooO25XD
         oG9Bk3aQHG4OTAU9QQq6yoa/vOY1DRvWirYFnphanK29DXIXLyH+2QphrzN4hy73CbGW
         CJXTdW5K0cgvztGo9Iq3F2TvcCKxxVkshvD2oJcjL05/qzLS33D6fcMaauF8idnHhkPb
         BtR54YlT7/fDiKiDjE9nbxbSqkb72S3hz9cw29JH24RFNeuC00zwNJNbrD9tWzroB+R7
         e3Hg==
X-Gm-Message-State: APjAAAV0yobyd9XpPH/EkeRUPiaGUhfthXMyWl1KquGHbBAGYZZNeSow
        fjr+HexTy/ChUx3lhxMIezHXcYw2Gbicc11CaobsjmwAhZvy
X-Google-Smtp-Source: APXvYqx1J6ZW+jxF/lQ3V1d2KJ2ik/J0TW7ZaJ61DK+gwmOM93ZnyWMxf+0k89SajqAmZLaFwW0gFQ58e5AGgbREvxXb7QiplNpo
MIME-Version: 1.0
X-Received: by 2002:a6b:e317:: with SMTP id u23mr20541853ioc.38.1565575626132;
 Sun, 11 Aug 2019 19:07:06 -0700 (PDT)
Date:   Sun, 11 Aug 2019 19:07:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001097b6058fe1fb22@google.com>
Subject: BUG: Dentry still in use [unmount of nfsd nfsd]
From:   syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f4eb1423 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ab1c74600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=2c95195d5d433f6ed6cb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com

RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0af7a86d4
R13: 00000000004c018f R14: 00000000004d2228 R15: 0000000000000004
BUG: Dentry 00000000117d3c54{i=0,n=clients}  still in use (1) [unmount of  
nfsd nfsd]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 18817 at fs/dcache.c:1595 umount_check  
fs/dcache.c:1595 [inline]
WARNING: CPU: 1 PID: 18817 at fs/dcache.c:1595 umount_check.cold+0xf5/0x116  
fs/dcache.c:1576
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 18817 Comm: syz-executor.3 Not tainted 5.3.0-rc3+ #100
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:umount_check fs/dcache.c:1595 [inline]
RIP: 0010:umount_check.cold+0xf5/0x116 fs/dcache.c:1576
Code: 00 00 45 89 e8 4c 89 e1 53 4d 8b 0f 4c 89 f2 4c 89 e6 48 c7 c7 80 97  
96 87 e8 61 a6 9f ff 48 c7 c7 00 98 96 87 e8 55 a6 9f ff <0f> 0b 58 e9 b1  
15 ff ff e8 24 1f f0 ff e9 1d ff ff ff 45 31 f6 e9
RSP: 0018:ffff888060187b88 EFLAGS: 00010282
RAX: 0000000000000024 RBX: ffff8880624f8bb8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c3ba6 RDI: ffffed100c030f63
RBP: ffff888060187bb8 R08: 0000000000000024 R09: fffffbfff11b42c5
R10: fffffbfff11b42c4 R11: ffffffff88da1623 R12: ffff88803f50fa20
R13: 0000000000000001 R14: 0000000000000000 R15: ffffffff88f75220
  d_walk+0x283/0x950 fs/dcache.c:1305
  do_one_tree+0x28/0x40 fs/dcache.c:1602
  shrink_dcache_for_umount+0x72/0x170 fs/dcache.c:1618
  generic_shutdown_super+0x6d/0x370 fs/super.c:443
  kill_anon_super+0x3e/0x60 fs/super.c:1102
  kill_litter_super+0x50/0x60 fs/super.c:1111
  nfsd_umount+0x3f/0x90 fs/nfsd/nfsctl.c:1416
  deactivate_locked_super+0x95/0x100 fs/super.c:331
  vfs_get_super+0x210/0x270 fs/super.c:1185
  nfsd_fs_get_tree+0x7a/0x90 fs/nfsd/nfsctl.c:1390
  vfs_get_tree+0x8e/0x390 fs/super.c:1413
  vfs_fsconfig_locked+0x236/0x3d0 fs/fsopen.c:232
  __do_sys_fsconfig fs/fsopen.c:445 [inline]
  __se_sys_fsconfig fs/fsopen.c:314 [inline]
  __x64_sys_fsconfig+0x8e0/0xa40 fs/fsopen.c:314
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa0af7a7c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007fa0af7a7c90 RCX: 0000000000459829
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0af7a86d4
R13: 00000000004c018f R14: 00000000004d2228 R15: 0000000000000004
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
