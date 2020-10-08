Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4C628768B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgJHO7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 10:59:25 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:56481 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbgJHO7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:59:19 -0400
Received: by mail-io1-f78.google.com with SMTP id y19so1377514iow.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 07:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PduyJpvNzvzrVpxv+i1EoFks3qADDQEN3YsVMd137NY=;
        b=qGfBCG2lIZWzulZYmJVchY+DfC3FoYpIRavyX4qDUS2ygIOntnd+YOOvF0blCPM0kT
         SEfTCDsj/qdBiBuUnkD96Q4f4dTgKceCnPu7ydek/uZkY+aPK0SDHDXzik+qBy/w+bTs
         vbyRHmkZwISZJPZWWCzDBSfdF51TTWovgZMwguOmOrCDWGBa8oUS2rfSukhEQi5gFyyx
         zKEgPObITNUq5T2kILkUlmQJpxD/ZGZGxrIhY6KUDXTqyphPWFO+HOE3EZSZ7rSW+BA4
         8kQ6WJdXBrJiHlmo/EfBqmweqncKx79u2IqDwoKUms3KS/McDz5JVNAqvXlXD1dribtm
         C4SA==
X-Gm-Message-State: AOAM531ogDVIQcQTZYWcuIzrM0pw1ZSiBjnHSOR3vbL9ZugtiAV0Vd8Y
        iT0de3BP5KcBQlCm/QrGV9WmZAES88RHQ4vJuJQVbftmBpPz
X-Google-Smtp-Source: ABdhPJzz1MActP86o8lrA0eWRgo0hTkMoCE4wNwY13Wz6FXWIL1N1oazw3U/pSr3RRYghkcyszfeZ+lS0Xlham1QX3fBSzN5Cf58
MIME-Version: 1.0
X-Received: by 2002:a92:8587:: with SMTP id f129mr7263256ilh.226.1602169157826;
 Thu, 08 Oct 2020 07:59:17 -0700 (PDT)
Date:   Thu, 08 Oct 2020 07:59:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085be6f05b12a1366@google.com>
Subject: general protection fault in utf8_casefold
From:   syzbot <syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com>
To:     krisman@collabora.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1785ccd0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=05139c4039d0679e19ff
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12316e00500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e80420500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com

F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=1, run fsck to fix.
F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=2, run fsck to fix.
F2FS-fs (loop0): Try to recover 2th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 27d57943
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 6860 Comm: syz-executor835 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:utf8_casefold+0x43/0x1b0 fs/unicode/utf8-core.c:107
Code: 89 fd 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 49 be 00 00 00 00 00 fc ff df e8 d8 c5 19 ff 48 83 c5 08 48 89 e8 48 c1 e8 03 <42> 8a 04 30 84 c0 0f 85 21 01 00 00 8b 7d 00 e8 89 f8 ff ff 49 89
RSP: 0018:ffffc900072e7c48 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888087470e10 RCX: ffff8880a6b26440
RDX: 0000000000000000 RSI: ffff888087470e10 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff834b74e9 R09: fffffbfff16c82b1
R10: fffffbfff16c82b1 R11: 0000000000000000 R12: ffffc900072e7dc8
R13: 1ffff92000e5cfb3 R14: dffffc0000000000 R15: 00000000000000ff
FS:  00007f59a4052700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f360e3b4000 CR3: 00000000973fb000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 f2fs_init_casefolded_name fs/f2fs/dir.c:85 [inline]
 __f2fs_setup_filename fs/f2fs/dir.c:118 [inline]
 f2fs_prepare_lookup+0x3bf/0x640 fs/f2fs/dir.c:163
 f2fs_lookup+0x10d/0x920 fs/f2fs/namei.c:494
 __lookup_hash+0x115/0x240 fs/namei.c:1445
 filename_create+0x14b/0x630 fs/namei.c:3467
 user_path_create fs/namei.c:3524 [inline]
 do_mkdirat+0x56/0x310 fs/namei.c:3664
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x449367
Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 c7 c0 d0 ff ff ff 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8d e0 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f59a4051bb8 EFLAGS: 00000203 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 0000000000449367
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 0000000020001940
RBP: 00007f59a40526d0 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000203 R12: 00000000ffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: 00007f59a4051c50
Modules linked in:
---[ end trace cf7b61b9a89941d1 ]---
RIP: 0010:utf8_casefold+0x43/0x1b0 fs/unicode/utf8-core.c:107
Code: 89 fd 65 48 8b 04 25 28 00 00 00 48 89 44 24 48 49 be 00 00 00 00 00 fc ff df e8 d8 c5 19 ff 48 83 c5 08 48 89 e8 48 c1 e8 03 <42> 8a 04 30 84 c0 0f 85 21 01 00 00 8b 7d 00 e8 89 f8 ff ff 49 89
RSP: 0018:ffffc900072e7c48 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888087470e10 RCX: ffff8880a6b26440
RDX: 0000000000000000 RSI: ffff888087470e10 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff834b74e9 R09: fffffbfff16c82b1
R10: fffffbfff16c82b1 R11: 0000000000000000 R12: ffffc900072e7dc8
R13: 1ffff92000e5cfb3 R14: dffffc0000000000 R15: 00000000000000ff
FS:  00007f59a4052700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f360e3b4000 CR3: 00000000973fb000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
