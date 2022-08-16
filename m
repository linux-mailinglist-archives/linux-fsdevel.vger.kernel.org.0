Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE3595885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiHPKhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiHPKg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:36:29 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E17DAEE2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:36:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d4-20020a056e02214400b002df95f624a4so6630299ilv.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=nGjlzvwcBZaemnjd+owBIFDV0Vis9TUHVKBGegmuTWc=;
        b=D8fkTGDO6QTUEGKmpMwegPhCkdk5OZxWYM/GTCQwLav96MkRv4l9qmTF9NYp/+Az/S
         GDkZckwA9NKMEmmed1UbEbBOBrMe/+OVVucTKlh3q/P09LQKH8chOkRhRmDrHwfiOOD2
         Hb3uS3abRvIlo7TNBv2hqmysejhhBkJMGMaGMX465a5M2ffBAZ91vruNuh1hLnUtxVmk
         qX2y0q+GfmMjOlHrUzgYn3qALgvQaC9MavMO0TWoGCzTbalKgKsvsKXEUD/KbHpAsDgs
         2QPb9SYFx4sveJSaQAOAavK8SYXw78iq0fU+MhAzSEjXOnggBKPLTPWjEtVQaWCLNIbx
         8tYg==
X-Gm-Message-State: ACgBeo2UcaC33F6lMbzovygjliCNVU976Yq3Xaw0uSS6bO7bhB9G6zgh
        /P7JBVTnSjOJ66Rasedx0wl8SDTUJrRQhvNg28wHDBweNE4X
X-Google-Smtp-Source: AA6agR5m1fKJIjKEfhhgjeRC37lonyEANjQQJTvbHtI4GVgvr9SPEKm/1GXC/HiZIyaJRUfLKtW15fBqRcya1X8QGW9T60Jpr3T3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:2df:3283:b4a8 with SMTP id
 x5-20020a056e021ca500b002df3283b4a8mr9506125ill.131.1660638983909; Tue, 16
 Aug 2022 01:36:23 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:36:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc792405e657a41b@google.com>
Subject: [syzbot] upstream boot error: general protection fault in getname_kernel
From:   syzbot <syzbot+90d970f179aab5888426@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169f00cb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=90d970f179aab5888426
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90d970f179aab5888426@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000004000-0xfff8200000004007]
CPU: 0 PID: 24 Comm: kdevtmpfs Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0xf6/0x3b0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 99 02 00 00 48 85 c0 0f 84 90 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 9f 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900001efcc0 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 0000000000001000 RCX: 0000000000000800
RDX: 00000000000021e0 RSI: 0000000000000cc0 RDI: 00000000000410f0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888140007500
R13: ffffffff81da9ebe R14: 0000000000000cc0 R15: 0000000000000cc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 getname_kernel+0x4e/0x370 fs/namei.c:227
 kern_path_create+0x20/0x50 fs/namei.c:3823
 handle_create+0xa8/0x4b3 drivers/base/devtmpfs.c:218
 handle drivers/base/devtmpfs.c:391 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:406 [inline]
 devtmpfsd+0x1a4/0x2a3 drivers/base/devtmpfs.c:448
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0xf6/0x3b0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 99 02 00 00 48 85 c0 0f 84 90 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 9f 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900001efcc0 EFLAGS: 00010246

RAX: ffff000000000000 RBX: 0000000000001000 RCX: 0000000000000800
RDX: 00000000000021e0 RSI: 0000000000000cc0 RDI: 00000000000410f0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888140007500
R13: ffffffff81da9ebe R14: 0000000000000cc0 R15: 0000000000000cc0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	51                   	push   %rcx
   1:	08 48 8b             	or     %cl,-0x75(%rax)
   4:	01 48 83             	add    %ecx,-0x7d(%rax)
   7:	79 10                	jns    0x19
   9:	00 48 89             	add    %cl,-0x77(%rax)
   c:	04 24                	add    $0x24,%al
   e:	0f 84 99 02 00 00    	je     0x2ad
  14:	48 85 c0             	test   %rax,%rax
  17:	0f 84 90 02 00 00    	je     0x2ad
  1d:	49 8b 3c 24          	mov    (%r12),%rdi
  21:	41 8b 4c 24 28       	mov    0x28(%r12),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 9f 02 00 00    	jne    0x2d3
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
