Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F15F2494
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 20:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJBSWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 14:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJBSWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:22:38 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93D25295
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Oct 2022 11:22:36 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i13-20020a056e02152d00b002f58aea654fso7140719ilu.20
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Oct 2022 11:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ysbt52RDhC32GaywqJTj5pl+RLMux0Ugbzul04vFNqg=;
        b=6edqIV6cVtS81BX8qF+OaqBK1ELhG4oNiWhSOdEpflkQxGHy7QmVA2EmKQmLBwrV4m
         7ggLY9SacQAbOVIL2t391T9LowyCMQOMC/7+o8LgLFBB6Kf1wjpn48eIV/riNqUQykvI
         GmrLUUNnwJEG0IKsGRzqEC5ODxwvIY4FjJ0F8ftiYkEJOA1ThWAoFVeyCDNM3bJpvINF
         Igf2MtenDlDZfPcXzxRx8AUEOi4KXe3DwOAx9EhERmfw+EI7uYCESKoVgrslSGrqNhvw
         +vYZkt6iFGhvxzRTYQnKPZCEMpD/xW8Cm7aYZRhxCnFZ/5fgdtAxa81n0FxZiVVgSlp/
         mAZg==
X-Gm-Message-State: ACrzQf3jgsw2FaCtEu1NLhisZcYljpvofRA72fYUaKE3Oan22DuwFuFj
        0BTdhsx4la4Jz2U7xvhRUrvWmRtBXaHu0szG3xxEoRx4irtW
X-Google-Smtp-Source: AMsMyM6ws1IS7+jg3/ZPjZaHTnxNHqqnK81R2npG3gNhQlE/icO4LfWZnrVtGbOklfkoSnT6cdq9ro427JatwlVikxFLiIQIuAj7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:2f6:558d:880b with SMTP id
 g11-20020a056e021a2b00b002f6558d880bmr8315363ile.105.1664734955692; Sun, 02
 Oct 2022 11:22:35 -0700 (PDT)
Date:   Sun, 02 Oct 2022 11:22:35 -0700
In-Reply-To: <00000000000042a5d005e967cd34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adeda005ea114fea@google.com>
Subject: Re: [syzbot] invalid opcode in writeback_single_inode
From:   syzbot <syzbot+15cb24a539075fc4c472@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b357fd1c2afc Merge tag 'usb-6.0-final' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1563ce14880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=15cb24a539075fc4c472
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155d3a82880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11106dec880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c8cf859a872/disk-b357fd1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1d370ace8a8/vmlinux-b357fd1c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15cb24a539075fc4c472@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8226
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3881 Comm: syz-executor338 Not tainted 6.0.0-rc7-syzkaller-00239-gb357fd1c2afc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:spin_unlock include/linux/spinlock.h:389 [inline]
RIP: 0010:writeback_single_inode+0x137/0x4c0 fs/fs-writeback.c:1728
Code: 8e 66 03 00 00 41 8b 5c 24 20 bf 01 00 00 00 89 de e8 ed 49 98 ff 83 fb 01 74 22 45 31 ff e8 20 4d 98 ff 4c 89 f7 e8 18 a8 9f <07> 44 89 f8 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 01 4d
RSP: 0018:ffffc90003c7fa10 EFLAGS: 00010286
RAX: 0000000080000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888071de4c10 R08: 0000000000000000 R09: ffff888071de4c9b
R10: ffffed100e3bc993 R11: 0000000000000000 R12: ffffc90003c7fa88
R13: ffff888071de4ce8 R14: ffff888071de4c98 R15: 0000000000000000
FS:  0000555556bc6300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020003580 CR3: 0000000074274000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 write_inode_now+0x16a/0x1e0 fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput.part.0+0x45b/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb0e371181a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5d57af98 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb0e371181a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc5d57afb0
RBP: 00007ffc5d57afb0 R08: 00007ffc5d57aff0 R09: 0000555556bc62c0
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00007ffc5d57aff0 R14: 0000000000000015 R15: 0000000020000db8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:spin_unlock include/linux/spinlock.h:389 [inline]
RIP: 0010:writeback_single_inode+0x137/0x4c0 fs/fs-writeback.c:1728
Code: 8e 66 03 00 00 41 8b 5c 24 20 bf 01 00 00 00 89 de e8 ed 49 98 ff 83 fb 01 74 22 45 31 ff e8 20 4d 98 ff 4c 89 f7 e8 18 a8 9f <07> 44 89 f8 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 01 4d
RSP: 0018:ffffc90003c7fa10 EFLAGS: 00010286
RAX: 0000000080000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888071de4c10 R08: 0000000000000000 R09: ffff888071de4c9b
R10: ffffed100e3bc993 R11: 0000000000000000 R12: ffffc90003c7fa88
R13: ffff888071de4ce8 R14: ffff888071de4c98 R15: 0000000000000000
FS:  0000555556bc6300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb0e3740230 CR3: 0000000074274000 CR4: 0000000000350ef0

