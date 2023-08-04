Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA98770505
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjHDPlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjHDPlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:41:07 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4D2D71
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:41:05 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1bf57b54f88so3292213fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 08:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691163664; x=1691768464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXfmTWLCk2PZ6zLYPtx1+xYpmGXAer9fGUnxxtzOS0o=;
        b=JZ4QiF+uDCQPVm4yFImScprmHRJbl03Q44FugsIXD16GulPJxCdNC67+ipbq20oS3V
         cimZ51p4aEQztB/si37zW2Dd+l1LJOcUGvo5CfbJHa02LQIFWFQQxYbrJYMLE2XIammq
         k7hXu3utwbVfB+RbiUfCuHds0TayG0p2hZjjoan921y8PFYwa3We5Yk+T4wVzTcsRl1w
         udjewVuXuPT/95EkHoQNotNyoK2ahAAYNY4vBhYgzVWL+jYglmGL3buelZg7Z4Mr7p5r
         /3MO5sEZqvyMZc1hFT64sroUEwZYCdGGzJAGTdW9S4MQpnOP+JzOJT49Ae8QL2QkmZGr
         83GQ==
X-Gm-Message-State: AOJu0Yz44kQNP9ZapJgiQbtoNEqDoCpmiLfN28j/Vvy91CpXIgZjnsKi
        ln28nDG5I/e91ViLjdaS8PF4b/TsMKfmXRIyRk8k/HgnTmV0
X-Google-Smtp-Source: AGHT+IEUwsgSul9CpdIBS7IL94M839EAF9eEJdcZ/poRlgToKAtFFG22qKCSWE//DiIUalyoMjz0qfwhvIOQGqo9iDWwomPTuLO1
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e282:b0:1bb:7d2b:9eb with SMTP id
 v2-20020a056870e28200b001bb7d2b09ebmr2148690oad.7.1691163664777; Fri, 04 Aug
 2023 08:41:04 -0700 (PDT)
Date:   Fri, 04 Aug 2023 08:41:04 -0700
In-Reply-To: <0000000000002930a705fc32b231@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f094106021ab951@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in folio_create_empty_buffers
From:   syzbot <syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    bdffb18b5dd8 Add linux-next specific files for 20230804
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1625c47da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf5fc5e1e5446f
dashboard link: https://syzkaller.appspot.com/bug?extid=0ad741797f4565e7e2d2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b893bea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16764a71a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d65b99a07c2/disk-bdffb18b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b9623d8bd2e/vmlinux-bdffb18b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e6c96c97edb/bzImage-bdffb18b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/17c4ca724160/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ad741797f4565e7e2d2@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000003a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000001d0-0x00000000000001d7]
CPU: 0 PID: 5323 Comm: segctord Not tainted 6.5.0-rc4-next-20230804-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
RIP: 0010:do_raw_spin_lock+0x6e/0x2b0 kernel/locking/spinlock_debug.c:114
Code: 81 48 8d 54 05 00 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e3
RSP: 0018:ffffc9000507f6e8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 00000000000001d0 RCX: 0000000000000000
RDX: 000000000000003a RSI: ffffffff8ac889a0 RDI: 00000000000001d4
RBP: 1ffff92000a0fede R08: 0000000000000000 R09: fffffbfff1d598ca
R10: ffffffff8eacc657 R11: 000000000000004e R12: 0000000000000000
R13: ffffea0001ca6bc0 R14: ffff888072088d98 R15: ffffea0001ca6bd8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000480 CR3: 0000000027f80000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_lock include/linux/spinlock.h:351 [inline]
 folio_create_empty_buffers+0xb0/0x470 fs/buffer.c:1657
 nilfs_lookup_dirty_data_buffers+0x5a1/0x720 fs/nilfs2/segment.c:730
 nilfs_segctor_scan_file+0x1b1/0x6f0 fs/nilfs2/segment.c:1080
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1202 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1529 [inline]
 nilfs_segctor_do_construct+0x2f11/0x8bf0 fs/nilfs2/segment.c:2077
 nilfs_segctor_construct+0x924/0xb50 fs/nilfs2/segment.c:2411
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2519 [inline]
 nilfs_segctor_thread+0x38f/0xe90 fs/nilfs2/segment.c:2602
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
RIP: 0010:do_raw_spin_lock+0x6e/0x2b0 kernel/locking/spinlock_debug.c:114
Code: 81 48 8d 54 05 00 c7 02 f1 f1 f1 f1 c7 42 04 04 f3 f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 e3
RSP: 0018:ffffc9000507f6e8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 00000000000001d0 RCX: 0000000000000000
RDX: 000000000000003a RSI: ffffffff8ac889a0 RDI: 00000000000001d4
RBP: 1ffff92000a0fede R08: 0000000000000000 R09: fffffbfff1d598ca
R10: ffffffff8eacc657 R11: 000000000000004e R12: 0000000000000000
R13: ffffea0001ca6bc0 R14: ffff888072088d98 R15: ffffea0001ca6bd8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000480 CR3: 0000000027f80000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	81 48 8d 54 05 00 c7 	orl    $0xc7000554,-0x73(%rax)
   7:	02 f1                	add    %cl,%dh
   9:	f1                   	int1
   a:	f1                   	int1
   b:	f1                   	int1
   c:	c7 42 04 04 f3 f3 f3 	movl   $0xf3f3f304,0x4(%rdx)
  13:	65 48 8b 14 25 28 00 	mov    %gs:0x28,%rdx
  1a:	00 00
  1c:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
  21:	31 d2                	xor    %edx,%edx
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 e3                	test   %esp,%ebx


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
