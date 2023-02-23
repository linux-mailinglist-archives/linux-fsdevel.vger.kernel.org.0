Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278F6A0C29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBWOsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 09:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjBWOsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:48:38 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680864C0B
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 06:48:35 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id 207-20020a6b14d8000000b0074ca9a558feso62694iou.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 06:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VXBDkUpUYKifbOiFKuT6bsEFjnLzhn4RnFbHeeuTOs=;
        b=kr3q3YfmYPbe1Enx7cSca0najZnwAp638qUbmFAZ9Ve71PC0jaSW7Rb74ZiQ699oix
         Mhhs8K8moLJrzLf4MeQa7l8cAtB8PIvw6OlTM6/Sjki4K53R3SPteIi8iQ3bGy7oF40m
         WH3rlc+W5QC+9gzhh85ADb3t3mMPlwwEPbo149yBx3DwKMlGpA9BiiSoIBQiQ+DjSB0O
         MExenJIsA+u01hpVULIMor0aJpoPX2BB0avvuK4rHJ5JmQq7V9mwvTAUAkD1VltLOJNp
         QfGktY6L17fVSD2LYj5bnf5dW+9jI7JHp0w+MIUno1XjtgDRF6j+neYV9idXr0XhwNe/
         g/Ew==
X-Gm-Message-State: AO0yUKWi+XZe0ssTwCtsspGDllFHPzZEHrCxlXwbsJ80fAb6zaSWuzat
        xM6/8s/+cwI78Tr6r5WPoVtNQ9Ml7nOrWq0wM32r5ZDVW+BI
X-Google-Smtp-Source: AK7set+0uea5xqOWWNQ3JkQtQkoSQ0pCVfGq6LK44OkoNWNTHSKOaqgZVMl6Y1BZ+rkockjZnF9zhEgvdT0GTa9OZKmvvmkUIvym
MIME-Version: 1.0
X-Received: by 2002:a5d:9959:0:b0:74c:a9ab:d357 with SMTP id
 v25-20020a5d9959000000b0074ca9abd357mr28401ios.47.1677163714729; Thu, 23 Feb
 2023 06:48:34 -0800 (PST)
Date:   Thu, 23 Feb 2023 06:48:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000725cab05f55f1bb0@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_exclop_balance (2)
From:   syzbot <syzbot+5e466383663438b99b44@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0983f6bf2bfc Merge tag 'devicetree-fixes-for-6.2-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170247f3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e18702f016355851
dashboard link: https://syzkaller.appspot.com/bug?extid=5e466383663438b99b44
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9666ee82c289/disk-0983f6bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2eec7d3e271c/vmlinux-0983f6bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e59c8acdb6e0/bzImage-0983f6bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e466383663438b99b44@syzkaller.appspotmail.com

BTRFS info (device loop1): balance: start 
BTRFS info (device loop1): balance: ended with status: 0
assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:463
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23865 Comm: syz-executor.1 Not tainted 6.2.0-rc7-syzkaller-00018-g0983f6bf2bfc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 6c 6b 3c f7 e9 50 fb ff ff e8 e2 7e 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 c0 14 2c 8b e8 38 62 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 53 32 e7 f6 48
RSP: 0018:ffffc90016f4fe48 EFLAGS: 00010246
RAX: 0000000000000066 RBX: ffff88802a61e0d0 RCX: a8adbef69c355400
RDX: ffffc90006479000 RSI: 0000000000004e31 RDI: 0000000000004e32
RBP: 0000000000000002 R08: ffffffff816ef9ec R09: fffff52002de9f81
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff110054c3c1a
R13: ffff88802a61c000 R14: ffff88802a61c680 R15: dffffc0000000000
FS:  00007f311d1fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff1fc34e18 CR3: 00000000293e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_exclop_balance+0x166/0x1e0 fs/btrfs/ioctl.c:463
 btrfs_ioctl_balance+0x482/0x7c0 fs/btrfs/ioctl.c:3556
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f311c48c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f311d1fd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f311c5abf80 RCX: 00007f311c48c0f9
RDX: 0000000020000880 RSI: 00000000c4009420 RDI: 000000000000000b
RBP: 00007f311c4e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffed1e4938f R14: 00007f311d1fd300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 6c 6b 3c f7 e9 50 fb ff ff e8 e2 7e 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 c0 14 2c 8b e8 38 62 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 53 32 e7 f6 48
RSP: 0018:ffffc90016f4fe48 EFLAGS: 00010246
RAX: 0000000000000066 RBX: ffff88802a61e0d0 RCX: a8adbef69c355400
RDX: ffffc90006479000 RSI: 0000000000004e31 RDI: 0000000000004e32
RBP: 0000000000000002 R08: ffffffff816ef9ec R09: fffff52002de9f81
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff110054c3c1a
R13: ffff88802a61c000 R14: ffff88802a61c680 R15: dffffc0000000000
FS:  00007f311d1fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff1fc34e18 CR3: 00000000293e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
