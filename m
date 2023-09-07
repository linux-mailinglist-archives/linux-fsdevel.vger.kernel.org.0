Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8E796FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 06:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbjIGEm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 00:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbjIGEm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:42:59 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B019AF
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 21:42:55 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1bf703dd1c0so8120885ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 21:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694061775; x=1694666575;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO4jiycN6dbg6wkvNucUtETxjzNo8ws6A658O5yfUKs=;
        b=ZT7+Vy7sgWZrmoJRt0foxftGppfdjirS7xh6mxbEmYUHfBA4ea59/wpTyu2+iA38tZ
         wyuk70UThV6FLWQbZL2iYqS4YTjC9xt2hrrEmySatTxe4hwMCi6Z5k2/pFWGL+73bQ4N
         AaUcaK/YOIyFy6kzfiKBM1wvBcskqDtOuR1SAqDkUo8s/8fcgOZq46QX8WG2yOP4M+9X
         frk851/OwD6AtoNZIv270vzNkBiXJD4BezW5JhrlxQws3xjYJYAkAu3QpSPngRddooXK
         ndl9+PkB4coXnw/ozxYMGNEsZpGdTg53BDA4LOiHV792CHZfUraKOs6/v69y3zmiloOC
         mi/A==
X-Gm-Message-State: AOJu0YzCLrbDjabS+sVgTHDxX7Kx/kcoKkWCUlqSFzBRB4vBW2PNjzEx
        3FTfd2zbHkaz9rFHAYauQ/VRmQN3/JXpuJ2JHx+sIhywu9rV
X-Google-Smtp-Source: AGHT+IGnUXfN5EzBjU00HtB0u2T/SapYwSUSYKMagEKr7olR9IlF0kcFbFNVMNrIeV8PScdj82MjHyRocM8u29RyAw1QEDvp/U7g
MIME-Version: 1.0
X-Received: by 2002:a17:902:e850:b0:1bd:dcdf:6179 with SMTP id
 t16-20020a170902e85000b001bddcdf6179mr6076952plg.2.1694061775253; Wed, 06 Sep
 2023 21:42:55 -0700 (PDT)
Date:   Wed, 06 Sep 2023 21:42:55 -0700
In-Reply-To: <000000000000a13b2c06049391bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005777c90604bd7ef0@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_run_delayed_items
From:   syzbot <syzbot+90ad99829e4f013084b7@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    744a759492b5 Merge tag 'input-for-v6.6-rc0' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c49cdc680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed626705db308b2d
dashboard link: https://syzkaller.appspot.com/bug?extid=90ad99829e4f013084b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150173d0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4cd3ef7a61fb/disk-744a7594.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb7ed3ce6d6/vmlinux-744a7594.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c0866ee45c/bzImage-744a7594.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2efc34fa9036/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90ad99829e4f013084b7@syzkaller.appspotmail.com

BTRFS info (device loop3): force zlib compression, level 3
BTRFS info (device loop3): allowing degraded mounts
BTRFS info (device loop3): using free space tree
BTRFS info (device loop3): auto enabling async discard
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 1 PID: 5219 at fs/btrfs/delayed-inode.c:1158 __btrfs_run_delayed_items+0x3d3/0x430 fs/btrfs/delayed-inode.c:1158
Modules linked in:
CPU: 1 PID: 5219 Comm: syz-executor.3 Not tainted 6.5.0-syzkaller-12053-g744a759492b5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__btrfs_run_delayed_items+0x3d3/0x430 fs/btrfs/delayed-inode.c:1158
Code: fe c1 38 c1 0f 8c b5 fc ff ff 48 89 ef e8 c5 31 42 fe e9 a8 fc ff ff e8 3b 48 e8 fd 48 c7 c7 60 3c 4c 8b 89 de e8 dd c2 ae fd <0f> 0b e9 69 ff ff ff f3 0f 1e fa e8 1d 48 e8 fd 48 8b 44 24 10 42
RSP: 0018:ffffc90004d1f8f0 EFLAGS: 00010246
RAX: c983e039b4061000 RBX: 00000000ffffffef RCX: ffff888021dd8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888077a2f8b0 R08: ffffffff81541672 R09: 1ffff920009a3e88
R10: dffffc0000000000 R11: fffff520009a3e89 R12: dffffc0000000000
R13: ffff888077a2f888 R14: 0000000000000000 R15: ffff888077a2f8b0
FS:  00007fbab9d0b6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff8cad4b028 CR3: 0000000078e4d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0xf44/0x2ff0 fs/btrfs/transaction.c:2393
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbab907cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbab9d0b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbab919bf80 RCX: 00007fbab907cae9
RDX: 0000000020002180 RSI: 0000000050009401 RDI: 0000000000000009
RBP: 00007fbab90c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbab919bf80 R15: 00007ffd6831ff58
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
