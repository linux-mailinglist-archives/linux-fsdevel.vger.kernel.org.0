Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEB302900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbhAYRfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 12:35:16 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49575 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731024AbhAYRd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:33:58 -0500
Received: by mail-io1-f69.google.com with SMTP id z24so20317136iot.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 09:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zQyf9/zOsiNO64sA92+aXQTaItIaOyKBfmTjQw/C9TM=;
        b=LjLSsbV1rpsEMojmt4ktuCbg9P7mVOv4sJufYiiA4Qbm5XdHmQd1ORRKDHzGPgWzwb
         4Kz5DL8s9uA7RGRmFSCaHncNPkpG+mCV+rl/8YGWum1jptbtQ2C45G8aWsFtrwYW1S9s
         qvkmJn6hgvCs8Ci8JKYMUYTG0Fp8jb/GfcdWCpuqlE70uJh1TNM+3N7ZLlgsEnkpNDR3
         zMcOLtEF09vYP4GF6SSviEUvoNyu1URHsd8nMBMbJ2cXgcyNSWFFHJdXEvyY8moLf2fY
         bLgqeJJZbxNCliYtxqqfPpbOGMTcqPK/Ju9+3ibTwiAvkmkIs2QWUqyG3a8XX1Y5mhE1
         FVpw==
X-Gm-Message-State: AOAM531caMrWtO0ZmF3AnWhGL76lkdoSjr+VFDz/a+lwXq/SmBZqoQwh
        7VkUuSFnKCNgapLraX0HipI4/14qUsSgD69H2yRMLkpNTzDG
X-Google-Smtp-Source: ABdhPJxNUQs19faOuX4lMJDLw7R/OfXfketgzzks5a6nlrbC1pdaiJNDn1BDJFLPuq7fzWbbZ+M7sWLQUWM3/+HFnCNbvY37epx+
MIME-Version: 1.0
X-Received: by 2002:a02:3441:: with SMTP id z1mr1620683jaz.63.1611595994267;
 Mon, 25 Jan 2021 09:33:14 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:33:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2865c05b9bcee02@google.com>
Subject: UBSAN: shift-out-of-bounds in exfat_fill_super
From:   syzbot <syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        namjae.jeon@samsung.com, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9791581c Merge tag 'for-5.11-rc4-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d94027500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5f3af3f625fb042
dashboard link: https://syzkaller.appspot.com/bug?extid=da4fe66aaadd3c2e2d1c
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ad6f00d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ffb69f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da4fe66aaadd3c2e2d1c@syzkaller.appspotmail.com

loop0: detected capacity change from 16383 to 0
================================================================================
UBSAN: shift-out-of-bounds in fs/exfat/super.c:471:28
shift exponent 4294967294 is too large for 32-bit type 'int'
CPU: 0 PID: 8443 Comm: syz-executor876 Not tainted 5.11.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x183/0x22e lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
 exfat_read_boot_sector fs/exfat/super.c:471 [inline]
 __exfat_fill_super fs/exfat/super.c:556 [inline]
 exfat_fill_super+0x2acb/0x2d00 fs/exfat/super.c:624
 get_tree_bdev+0x406/0x630 fs/super.c:1291
 vfs_get_tree+0x86/0x270 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x1937/0x2c50 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3409
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446f8a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff97c1b978 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff97c1b9d0 RCX: 0000000000446f8a
RDX: 0000000020000000 RSI: 0000000020000340 RDI: 00007fff97c1b990
RBP: 00007fff97c1b990 R08: 00007fff97c1b9d0 R09: 00007fff00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 000000000000000c
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
