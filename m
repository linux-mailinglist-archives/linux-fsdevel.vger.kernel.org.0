Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE18B6A2DF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 04:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBZDyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Feb 2023 22:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBZDyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:54:14 -0500
Received: from mail-io1-xd47.google.com (mail-io1-xd47.google.com [IPv6:2607:f8b0:4864:20::d47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE9110258
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 19:53:44 -0800 (PST)
Received: by mail-io1-xd47.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so1720900iog.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 19:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMWDSG4ofUC76oZC/HF6WgUrzHwbcEsF1WIvKhrXRfQ=;
        b=D5yTlaLmvWQn4u7Hi8l1+6Hob31U6ynYmsl80B8dbjz+0yjcQffUz6e9wmBaqczubU
         tXcTuP0RzdK0hO6Z3HBYYpD6BO2KtUhDRm/uMa2l1zrTAsewkCUE27IGLyXX70LYIuXq
         Q5ay8A/1DmKxEom+4jUCRklwsfALefxFy+AaWFwmPgxpv0HK+PW2o6C9nfL5jstmpA/4
         KUaZghJyl/0MRIYaML2lm0RfGneqPpGl0lVi7VYTqcPrR2ADbF5p5ggnoDwpmbeRftIp
         HCAeRdCaWo5Mtw6/sci7/Bg9g9KDJKLoWppcfwBcLr92hAUF7eqjkcGAC8i1R3hcOJfJ
         rw9Q==
X-Gm-Message-State: AO0yUKWzylJnDoBOe/X0IHMI2kH/Efz6HlgwjmLbSMoeA/kccbPF7NpP
        8EL7+SsSPxo2Q5U/r7E+WXeirZM2HLAAwqYfYYptNKLoit2V
X-Google-Smtp-Source: AK7set/NFTcU+mrjLl1rEV4e6JebJ6p5ilLGRMi1+RAe7mYzqJjrb2YkDAIVblPOiN7GEEQB/tuNLOpBRlT0LT+e2GjvNaV5iwEC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f90:b0:313:fad9:a014 with SMTP id
 v16-20020a056e020f9000b00313fad9a014mr6641816ilo.5.1677383503103; Sat, 25 Feb
 2023 19:51:43 -0800 (PST)
Date:   Sat, 25 Feb 2023 19:51:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dace2005f592479a@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_update_delayed_inode
From:   syzbot <syzbot+742938912a8c5436cfed@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9e58df973d22 Merge tag 'irq-core-2023-02-20' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11aa59f7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ac7065d93fcf412
dashboard link: https://syzkaller.appspot.com/bug?extid=742938912a8c5436cfed
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4f13d97f464/disk-9e58df97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f533b623da7/vmlinux-9e58df97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0288113d3224/bzImage-9e58df97.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+742938912a8c5436cfed@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 6353 at fs/btrfs/delayed-inode.c:1065 __btrfs_update_delayed_inode+0x8f0/0xab0 fs/btrfs/delayed-inode.c:1065
Modules linked in:
CPU: 1 PID: 6353 Comm: btrfs-transacti Not tainted 6.2.0-syzkaller-02172-g9e58df973d22 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:__btrfs_update_delayed_inode+0x8f0/0xab0 fs/btrfs/delayed-inode.c:1065
Code: 8c aa f8 ff ff be 08 00 00 00 4c 89 e7 e8 b8 2c 3d fe e9 98 f8 ff ff e8 2e e7 e7 fd 48 c7 c7 40 3a 2b 8b 89 de e8 f0 0f af fd <0f> 0b e9 3a ff ff ff 89 d1 80 e1 07 80 c1 03 38 c1 0f 8c 6a f9 ff
RSP: 0018:ffffc90016297700 EFLAGS: 00010246
RAX: 47bd4e3c7cf3e600 RBX: 00000000ffffffe4 RCX: ffff888024020000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90016297850 R08: ffffffff81532f72 R09: fffff52002c52e59
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffff88802b938001 R14: ffff888012b86cc8 R15: 1ffff11002570d99
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f829a785058 CR3: 0000000042388000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1099 [inline]
 __btrfs_commit_inode_delayed_items+0x234a/0x2400 fs/btrfs/delayed-inode.c:1119
 __btrfs_run_delayed_items+0x1db/0x430 fs/btrfs/delayed-inode.c:1153
 btrfs_commit_transaction+0xa34/0x3440 fs/btrfs/transaction.c:2264
 transaction_kthread+0x326/0x4c0 fs/btrfs/disk-io.c:1818
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
