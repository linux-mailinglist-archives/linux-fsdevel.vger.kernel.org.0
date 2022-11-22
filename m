Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6C63345A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 05:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiKVEOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 23:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKVEOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 23:14:46 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6825264AD
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 20:14:44 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id x5-20020a6bda05000000b006db3112c1deso6441457iob.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 20:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmBiWl7MojFdFQWzS0NYKr93ECkxmAAwII0lr2qqI5A=;
        b=i7nnibLB7jSd4lLW1KIFBs0dOTeg4mxMGalqlOrTmcASrdPy8MsICgTKjx3lBOtAHQ
         TY7QoOrGxKebs2eWuJiPDlcB130o2A3nXxQEG+UJAANOby6eOltnSTwYH06DI0OlYXBx
         p5XLzE787qBjI1nJ6pp3yqLaNYSIBxNKCQ/8ebiGcr4SvYDnyK2MFy5sbfRKehxk5qup
         DQsqoEzhIAOJb5G5kzscfPY3OgO7itFdlFkju/OlyjpcqEIbcT/S+q0Zwog2LTo7kA1I
         Gs3OSVP3r138tprIUc5pQ3vr7Pfg4xNU2DM9Z4EGnWSpykXoN2I5QDcbAddav2ilTM6s
         9ksw==
X-Gm-Message-State: ANoB5pnNZ8CHgSZyKvcCppMQzDbffNWwwofprA+c+9WniYZIrjHOi72I
        j+Ot1+o9Fj6AbYAeWQxsXXPDuiENrKk1XZlMU2pP3CdNMr3v
X-Google-Smtp-Source: AA0mqf7G6+RxnGcNJq4WkqlmBAQeyasx5E3A8Ke6o80wRpSz4i0T0HPPv8/FLTEJAXoKo5suyuHWV0U2l+DmMU8QRpbJjqL5ZIqk
MIME-Version: 1.0
X-Received: by 2002:a02:6f0b:0:b0:363:6b4c:eb45 with SMTP id
 x11-20020a026f0b000000b003636b4ceb45mr5022415jab.90.1669090484063; Mon, 21
 Nov 2022 20:14:44 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:14:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066965b05ee07692d@google.com>
Subject: [syzbot] WARNING in notify_change (2)
From:   syzbot <syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144359f9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8232c7627e3f923
dashboard link: https://syzkaller.appspot.com/bug?extid=462da39f0667b357c4b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a17fe9880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e6c4c3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77fa14383845/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/26d9898f9467/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5e417bc4c34/bzImage-eb708140.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3638 at fs/attr.c:327 notify_change+0xf16/0x1440 fs/attr.c:327
Modules linked in:
CPU: 0 PID: 3638 Comm: syz-executor162 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:notify_change+0xf16/0x1440 fs/attr.c:327
Code: 70 97 0a 00 e8 7b d7 9c ff 48 8b 7d c8 48 89 de e8 bf ce f2 01 44 89 fe 48 89 df e8 b4 12 f3 01 e9 aa f6 ff ff e8 5a d7 9c ff <0f> 0b e9 d9 f1 ff ff e8 4e d7 9c ff 44 8b 7d b0 4c 89 ea 48 b8 00
RSP: 0018:ffffc90003bef820 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888075b73be8 RCX: 0000000000000000
RDX: ffff88801c2657c0 RSI: ffffffff81e342b6 RDI: 0000000000000007
RBP: ffffc90003bef890 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90003bef8e8
R13: ffff888073fe0000 R14: 0000000000000000 R15: 0000000000004200
FS:  00007f689a75a700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f689a718718 CR3: 00000000176f8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __remove_privs fs/inode.c:2013 [inline]
 __file_remove_privs+0x415/0x600 fs/inode.c:2034
 file_modified_flags+0xa4/0x320 fs/inode.c:2148
 fuse_file_fallocate+0x4d4/0x930 fs/fuse/file.c:3004
 vfs_fallocate+0x48b/0xe00 fs/open.c:323
 ioctl_preallocate+0x18e/0x200 fs/ioctl.c:290
 file_ioctl fs/ioctl.c:330 [inline]
 do_vfs_ioctl+0x12e9/0x1600 fs/ioctl.c:849
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x10c/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f689a7a85b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f689a75a2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f689a8344c0 RCX: 00007f689a7a85b9
RDX: 00000000200001c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007f689a8020d4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007f689a7fe0c8 R14: 00007f689a8000d0 R15: 00007f689a8344c8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
