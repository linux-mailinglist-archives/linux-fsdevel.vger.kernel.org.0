Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E846F6EC678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjDXGqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDXGqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:46:48 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28569270B
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 23:46:47 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-760718e6878so686855339f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 23:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682318806; x=1684910806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fd6dqJ6vNUfQTtGZs4HkQf1+w0a46JamGTtztlA6UhI=;
        b=NonrLjEIKBobWw2/EStp/S19A077PHQqTghY2KIFUp6bskYiQNZNAVi1kW0jUIvI4L
         jh8XkFbMmLmU5WLzRCMXB6tDTpxLMqODX3cx9M3whhDS+TZsF2ZySQ49SaFJl4gyXX6a
         RFYy1jWB6zYjf2udcqTGAVzyoY2vJHvah26ny7OvthMi3uf7XR7J6gPCypMS5ojxuQcj
         snKJB4VdJmdpdBu2qF1Xe3aDPFs+ZAc5I0HMZP5ASj4Z8oOxXPz5e7pAmNmRIAYuEzML
         m5NNCfBBG2mMhcw2W/QreKxHsKeqtq8S+1fSWLtBhZE7uvg8hMZZJD9/Qj+J08MYRgwo
         5p4Q==
X-Gm-Message-State: AAQBX9cybkjAQExIapL6rmOFGxeXyj2VFtrkx/0Nk2cHlpEBSDrfDD5m
        EBuiXSG39W8PHEjOtuwdPehgg8WZmlBbOYeWPIScwtfSGW6+
X-Google-Smtp-Source: AKy350aA3V2gYwh6fdUSMxWXbjp90iMnNWbFUoVj6F0JzMGcPAxCTzUQk0uyET6ieJ3obaodDQL+mQCPO9Ry9dBONPuxfjS1oy+z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22bc:b0:40f:8b7d:90db with SMTP id
 z28-20020a05663822bc00b0040f8b7d90dbmr4307604jas.3.1682318806457; Sun, 23 Apr
 2023 23:46:46 -0700 (PDT)
Date:   Sun, 23 Apr 2023 23:46:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dba36305fa0f5e27@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_put_block_group
From:   syzbot <syzbot+e38c6fff39c0d7d6f121@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8e41e0a57566 Revert "ACPICA: Events: Support fixed PCIe wa..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a7e1bfc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/69cc9a5732ed/disk-8e41e0a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f32a5c8e9e68/vmlinux-8e41e0a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b56460ca80d/bzImage-8e41e0a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e38c6fff39c0d7d6f121@syzkaller.appspotmail.com

BTRFS info (device loop5): at unmount dio bytes count 8192
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5108 at fs/btrfs/block-group.c:152 btrfs_put_block_group+0x257/0x2b0
Modules linked in:
CPU: 0 PID: 5108 Comm: syz-executor.5 Not tainted 6.3.0-rc7-syzkaller-00181-g8e41e0a57566 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:btrfs_put_block_group+0x257/0x2b0 fs/btrfs/block-group.c:152
Code: fe e8 fd 28 e2 fd 0f 0b e9 4a fe ff ff e8 f1 28 e2 fd 48 89 df be 03 00 00 00 5b 41 5e 41 5f 5d e9 fe eb 87 00 e8 d9 28 e2 fd <0f> 0b e9 1c ff ff ff e8 cd 28 e2 fd 0f 0b 4c 89 f0 48 c1 e8 03 42
RSP: 0018:ffffc90003f9fa90 EFLAGS: 00010293
RAX: ffffffff83a850b7 RBX: 0000000000002000 RCX: ffff888020419d40
RDX: 0000000000000000 RSI: 0000000000002000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83a84fcc R09: ffffed100ea7db41
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802f07c318
R13: dffffc0000000000 R14: ffff88802f07c000 R15: dffffc0000000000
FS:  0000555555b01400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffa6ebc8300 CR3: 000000002d689000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_free_block_groups+0x9b0/0xe80 fs/btrfs/block-group.c:4272
 close_ctree+0x742/0xd30 fs/btrfs/disk-io.c:4649
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_anon_super+0x3b/0x60 fs/super.c:1107
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2133
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f03aec8d5d7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb62f6788 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f03aec8d5d7
RDX: 00007ffeb62f685b RSI: 000000000000000a RDI: 00007ffeb62f6850
RBP: 00007ffeb62f6850 R08: 00000000ffffffff R09: 00007ffeb62f6620
R10: 0000555555b028b3 R11: 0000000000000246 R12: 00007f03aece6cdc
R13: 00007ffeb62f7910 R14: 0000555555b02810 R15: 00007ffeb62f7950
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
