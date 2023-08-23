Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B4785F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjHWSIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbjHWSIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:08:47 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86506E50
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 11:08:45 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-56c4e3441f0so2927481a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 11:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692814125; x=1693418925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6TFYzbe+aItdEHV02B+YSmc25pOCMrU53WsD56T7Io=;
        b=hqjrn5w2LfmqZwhMg3xlpRY6LUD4aw3J4+g8IB/IKwbX3zGhj+w+7xxtbPxs+29FR1
         +V1nSxTpWEXTDWnKIYMsdQgP70xpy3/68T6quPbwK20QjJ7ZQ3PTYaJrrXyXu3aeVty5
         UhNt//wH41AnEbf1xAQRd2NMzAHUHjMLhhneQZOWRIYKVF2b3U6W2iImPOZWh55Kl1ja
         HpNNwsHCR9sypLTqDGgyjl/e7eXnzZBgt9pYMoLmAGtHfA0sGhZRLs5Kfl01WtTkABHL
         3ItUCuJzcHrc2rrDjXMbO2mv/DQ89fY3JO0cZiWs94tSBPiA7x11xoALLKWaQ4zTjnEP
         rdJw==
X-Gm-Message-State: AOJu0Yz9bZRj1ltZAdkbM6LRVs5+RIJpGuROhtCBGu8QWhfDCBBtCN8O
        z2rUVxtB2z8JaJRmLnc7TYYj0QyCnu7KwvmoxJF3QumkjMRG
X-Google-Smtp-Source: AGHT+IEJhI9fec1i4ZYACCZLBzgyCh11MSzkTLvunUv2a7UbGaZvosC7SAqCCqtfBkWsLXl3UjWdGM86TC62dfv9r88Bwgkx4qwv
MIME-Version: 1.0
X-Received: by 2002:a63:778a:0:b0:56a:164b:c6ec with SMTP id
 s132-20020a63778a000000b0056a164bc6ecmr1985913pgc.7.1692814125013; Wed, 23
 Aug 2023 11:08:45 -0700 (PDT)
Date:   Wed, 23 Aug 2023 11:08:44 -0700
In-Reply-To: <0000000000000126ec05ffd5a528@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097a8e606039b001f@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_enable_quotas
From:   syzbot <syzbot+693985588d7a5e439483@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    89bf6209cad6 Merge tag 'devicetree-fixes-for-6.5-2' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120c47f7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba1fefa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1636640fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57b9a06bad82/disk-89bf6209.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5bb3483e19d/vmlinux-89bf6209.xz
kernel image: https://storage.googleapis.com/syzbot-assets/905ebaa6ecf8/bzImage-89bf6209.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/20b0f7175bae/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/eda4e74724f3/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+693985588d7a5e439483@syzkaller.appspotmail.com

kernel BUG at fs/ext4/super.c:7010!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5086 Comm: syz-executor143 Not tainted 6.5.0-rc7-syzkaller-00018-g89bf6209cad6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:ext4_quota_enable fs/ext4/super.c:7010 [inline]
RIP: 0010:ext4_enable_quotas+0xb7a/0xb90 fs/ext4/super.c:7057
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 3a f7 ff ff 49 89 d6 48 89 df e8 13 07 99 ff 4c 89 f2 e9 27 f7 ff ff e8 36 35 40 ff <0f> 0b e8 2f 35 40 ff 0f 0b e8 e8 4d 71 08 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc90003d7f880 EFLAGS: 00010293
RAX: ffffffff824b82fa RBX: 0000000000000000 RCX: ffff88802cd08000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003d7fa50 R08: ffffffff824b7bf4 R09: 1ffff1100eadb457
R10: dffffc0000000000 R11: ffffed100eadb458 R12: 0000000000000001
R13: 0000000000000001 R14: ffff88801675d464 R15: dffffc0000000000
FS:  00007fc13f7ec6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc13f8b86c0 CR3: 000000001635a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_fill_super fs/ext4/super.c:5562 [inline]
 ext4_fill_super+0x6157/0x6ce0 fs/ext4/super.c:5696
 get_tree_bdev+0x468/0x6c0 fs/super.c:1318
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc13f83111a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc13f7ec088 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc13f83111a
RDX: 00000000200005c0 RSI: 0000000020000000 RDI: 00007fc13f7ec0a0
RBP: 00007fc13f7ec0a0 R08: 00007fc13f7ec0e0 R09: 00000000000004d4
R10: 0000000000200810 R11: 0000000000000206 R12: 00007fc13f7ec0e0
R13: 0000000000200810 R14: 0000000000000003 R15: 0000000000040000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_quota_enable fs/ext4/super.c:7010 [inline]
RIP: 0010:ext4_enable_quotas+0xb7a/0xb90 fs/ext4/super.c:7057
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 3a f7 ff ff 49 89 d6 48 89 df e8 13 07 99 ff 4c 89 f2 e9 27 f7 ff ff e8 36 35 40 ff <0f> 0b e8 2f 35 40 ff 0f 0b e8 e8 4d 71 08 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc90003d7f880 EFLAGS: 00010293
RAX: ffffffff824b82fa RBX: 0000000000000000 RCX: ffff88802cd08000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003d7fa50 R08: ffffffff824b7bf4 R09: 1ffff1100eadb457
R10: dffffc0000000000 R11: ffffed100eadb458 R12: 0000000000000001
R13: 0000000000000001 R14: ffff88801675d464 R15: dffffc0000000000
FS:  00007fc13f7ec6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556776778 CR3: 000000001635a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
