Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AB5AD51A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiIEOhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbiIEOgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:36:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59838175A1
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 07:35:33 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h5-20020a056e021d8500b002eb09a4f7e6so7510711ila.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Sep 2022 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1eu12Y/7myvVTlijkPxBB986iRYCXXzL9QUqsoDSoRU=;
        b=C241IKkdysRKs0sKLawL8+bCYKjzwHcDyFbb1FubxIA4VOgXWAdyh3w/ScYfBFM0Nn
         C41HYXlHEZUYw7I36+EbM47oZ57ZWS+5AOzGTmk1uZUvdRqD3TI7G2RcOmgFiYqHrC4i
         W7fcNFckUubW48rF+5x6+JXmSH7g1TV4eiRizwwDn9DxSDO06lQdvYI21hPe+cUIHshL
         H2DPCguAFY1dRHcrWPN1Aj77rUH5N1kV+ePy/YGe7jn7Z/GnCjk6WusW6jLELL+CURSQ
         P7oad31OCeoJwioT4XVzYP2pZUkIS+D0/cESA5/AUMSDKscicb2d5ykDia1pV7gQXUdc
         sTeg==
X-Gm-Message-State: ACgBeo03lBYdquZoYOBlwH3EYe/MMh3HuDIT9DygrmzW8kWokhhqlORB
        jPGa/GHutWBP6f58dpUQWABqfQkt/Edm4VdYKlqx7x0uH+wn
X-Google-Smtp-Source: AA6agR5ttrukC8L+K07DB/liSFE04gWoF92fJyZa6kcUmS5ZynOGvthyp5Mb3LrgWXAy5aTh6Xm/R8Cib7OuKz2L32AwJ6iyO2SA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3043:b0:341:d8a4:73e8 with SMTP id
 u3-20020a056638304300b00341d8a473e8mr26455973jak.239.1662388530884; Mon, 05
 Sep 2022 07:35:30 -0700 (PDT)
Date:   Mon, 05 Sep 2022 07:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcb48a05e7eefddd@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in kvmalloc_node
From:   syzbot <syzbot+24e8438a720679b9b878@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    10174220f55a usb: reduce kernel log spam on driver registr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=131ee98b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=24e8438a720679b9b878
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc623f81ac2e/disk-10174220.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d582f7185db2/vmlinux-10174220.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24e8438a720679b9b878@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff0fff00000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff89ff800004000-0xfff89ff800004007]
CPU: 1 PID: 1149 Comm: mkdir Not tainted 6.0.0-rc1-syzkaller-00047-g10174220f55a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:__kmalloc_node+0x1dd/0x360 mm/slub.c:4468
Code: 48 83 c4 18 44 89 e1 4c 89 ea 5b 4c 89 fe 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 6e 55 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 3d 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0018:ffffc900004e7c20 EFLAGS: 00010246
RAX: ffff0fff00000000 RBX: 0000000000400cc0 RCX: 0000000000000800
RDX: 0000000000000041 RSI: 0000000000400cc0 RDI: 000000000003b880
RBP: ffff88810004c280 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000400cc0
R13: 0000000000001000 R14: 0000000000000000 R15: ffffffff81632b1e
FS:  00007fd7fef3f800(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7ff039410 CR3: 000000010f2f0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc_node include/linux/slab.h:623 [inline]
 kvmalloc_node+0x3e/0x190 mm/util.c:613
 kvmalloc include/linux/slab.h:750 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x7f7/0x1280 fs/seq_file.c:210
 proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:305
 call_read_iter include/linux/fs.h:2181 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x67d/0x930 fs/read_write.c:470
 ksys_read+0x127/0x250 fs/read_write.c:607
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd7ff0cb8fe
Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007fff62d03468 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055cc8ec572a0 RCX: 00007fd7ff0cb8fe
RDX: 0000000000000400 RSI: 000055cc8ec57500 RDI: 0000000000000003
RBP: 00007fd7ff198380 R08: 0000000000000003 R09: 00007fd7ff19ba60
R10: 000000000000005d R11: 0000000000000246 R12: 00007fff62d03530
R13: 0000000000000d68 R14: 00007fd7ff197780 R15: 0000000000000d68
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:__kmalloc_node+0x1dd/0x360 mm/slub.c:4468
Code: 48 83 c4 18 44 89 e1 4c 89 ea 5b 4c 89 fe 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 6e 55 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 3d 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0018:ffffc900004e7c20 EFLAGS: 00010246
RAX: ffff0fff00000000 RBX: 0000000000400cc0 RCX: 0000000000000800
RDX: 0000000000000041 RSI: 0000000000400cc0 RDI: 000000000003b880
RBP: ffff88810004c280 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000400cc0
R13: 0000000000001000 R14: 0000000000000000 R15: ffffffff81632b1e
FS:  00007fd7fef3f800(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7ff039410 CR3: 000000010f2f0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 83 c4 18          	add    $0x18,%rsp
   4:	44 89 e1             	mov    %r12d,%ecx
   7:	4c 89 ea             	mov    %r13,%rdx
   a:	5b                   	pop    %rbx
   b:	4c 89 fe             	mov    %r15,%rsi
   e:	48 89 ef             	mov    %rbp,%rdi
  11:	5d                   	pop    %rbp
  12:	41 5c                	pop    %r12
  14:	41 5d                	pop    %r13
  16:	41 5e                	pop    %r14
  18:	41 5f                	pop    %r15
  1a:	e9 6e 55 00 00       	jmpq   0x558d
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 3d 01 00 00    	jne    0x171
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
