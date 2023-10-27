Return-Path: <linux-fsdevel+bounces-1367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404B7D9A1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC453B214B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3C241FC;
	Fri, 27 Oct 2023 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345CB1F171
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 13:36:30 +0000 (UTC)
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0610D4
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:36:27 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3b3edaef525so2815228b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698413786; x=1699018586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2d7LjPPHT/lVJIo2H2QqG7uP94vUPzZNIrAqJouvjs=;
        b=SLzBDXnEwaVNALVyCyUGnLKxsTDOC3N541f9QpNUWN5peZTLL9rV0hQvy9Xx5k9PUV
         X9TciScU2ujO/QqD8bDZ36QVYmtYkKujjlt3ShQPPqO7ZLRtwZCjX7/HrIUZp6bLX/kJ
         5uZa7B8ElnPG5X8Q9f/mqhWzFFM9o4NFrEdDSTcBC0KpJFGvk9ZSp+jKL6c43ydxOSNt
         YbNolUck1gQXXn6jGZ793ei+7Mj7yTsbKmaj1KzZ5GItuiK7wpelJdj/H6neLhels8eD
         NwlnhwsRUdYvmd9jk0OqrjQ5MOYc3CRmqLfxwPg/pd8rhdbzpElPTCNmUxijPAdI1tNj
         yO2A==
X-Gm-Message-State: AOJu0YxdlgTiNx6HU7qYuLK9H4Gm7fGlChdFRvgjpRfzjNfrJrQbOCtX
	gzrXJohaltWi7Ujf3Fz7B9HlfjrYdmxady7eAAgB3wCHmuVh
X-Google-Smtp-Source: AGHT+IGH491s58SWM3l3CcKu6CD1EgfAugYCkKz67enbaOewDHnb3taxKVf1asOkIv0olghM0iuGFO9AcU5AJRXqEM28TnQpoc9Y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2118:b0:3ab:84f0:b4a5 with SMTP id
 r24-20020a056808211800b003ab84f0b4a5mr867739oiw.3.1698413786470; Fri, 27 Oct
 2023 06:36:26 -0700 (PDT)
Date: Fri, 27 Oct 2023 06:36:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c9d500608b2c62b@google.com>
Subject: [syzbot] [x25?] [reiserfs?] general protection fault in lapbeth_data_transmit
From: syzbot <syzbot+6062afbf92a14f75d88b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11028640a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=6062afbf92a14f75d88b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150a0f73280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fcaff280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16519d7a3fc8/disk-1b29d271.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2cd6e97f1df/vmlinux-1b29d271.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7781abe10c9/bzImage-1b29d271.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5b429fa9e0f3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6062afbf92a14f75d88b@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0011ad8e6f: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x000000008d6c7378-0x000000008d6c737f]
CPU: 0 PID: 4991 Comm: syz-executor335 Not tainted 6.4.0-rc6-syzkaller-00269-g1b29d271614a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:dev_hard_header include/linux/netdevice.h:3137 [inline]
RIP: 0010:lapbeth_data_transmit+0x245/0x360 drivers/net/wan/lapbether.c:257
Code: 74 08 3c 01 0f 8e 97 00 00 00 49 8d bc 24 38 02 00 00 66 89 9d b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c6 00 00 00 49 8b 9c 24 38 02 00 00 48 85 db 74
RSP: 0018:ffffc90000007c20 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000012 RCX: 0000000000000003
RDX: 0000000011ad8e6f RSI: ffffffff8807bdbb RDI: 000000008d6c7378
RBP: ffff8880223bddc0 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000094001 R12: 000000008d6c7140
R13: 0000000000000000 R14: ffff888023302a14 R15: 0000000000000000
FS:  00005555563323c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055727dd5a800 CR3: 000000002921e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 lapb_data_transmit+0x93/0xc0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0x187/0x3a0 net/lapb/lapb_out.c:149
 lapb_send_control+0x1cb/0x370 net/lapb/lapb_subr.c:251
 lapb_t1timer_expiry+0x5e0/0x8f0 net/lapb/lapb_timer.c:142
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
 __run_timers kernel/time/timer.c:2022 [inline]
 __run_timers kernel/time/timer.c:1995 [inline]
 run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x4f/0x1b0 arch/x86/lib/memmove_64.S:69
Code: 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 <48> 8d 76 20 4c 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f
RSP: 0018:ffffc90003abefb0 EFLAGS: 00000286
RAX: ffff888073551fb4 RBX: 0000000000000002 RCX: 1ffff1100e6aa201
RDX: fffffffff9171f60 RSI: ffff88807a3dffe4 RDI: ffff88807a3dfff4
RBP: 0000000000000020 R08: 7a3e0c8000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888073551fa4 R15: 0000000000000010
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_hard_header include/linux/netdevice.h:3137 [inline]
RIP: 0010:lapbeth_data_transmit+0x245/0x360 drivers/net/wan/lapbether.c:257
Code: 74 08 3c 01 0f 8e 97 00 00 00 49 8d bc 24 38 02 00 00 66 89 9d b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c6 00 00 00 49 8b 9c 24 38 02 00 00 48 85 db 74
RSP: 0018:ffffc90000007c20 EFLAGS: 00010216

RAX: dffffc0000000000 RBX: 0000000000000012 RCX: 0000000000000003
RDX: 0000000011ad8e6f RSI: ffffffff8807bdbb RDI: 000000008d6c7378
RBP: ffff8880223bddc0 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000094001 R12: 000000008d6c7140
R13: 0000000000000000 R14: ffff888023302a14 R15: 0000000000000000
FS:  00005555563323c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055727dd5a800 CR3: 000000002921e000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	74 08                	je     0xa
   2:	3c 01                	cmp    $0x1,%al
   4:	0f 8e 97 00 00 00    	jle    0xa1
   a:	49 8d bc 24 38 02 00 	lea    0x238(%r12),%rdi
  11:	00
  12:	66 89 9d b8 00 00 00 	mov    %bx,0xb8(%rbp)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 c6 00 00 00    	jne    0xfa
  34:	49 8b 9c 24 38 02 00 	mov    0x238(%r12),%rbx
  3b:	00
  3c:	48 85 db             	test   %rbx,%rbx
  3f:	74                   	.byte 0x74


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

