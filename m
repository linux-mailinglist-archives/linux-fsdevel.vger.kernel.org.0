Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86295072CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354517AbiDSQTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354504AbiDSQTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:19:03 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C6393F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:16:20 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id a17-20020a056602209100b006549a9cd480so4271347ioa.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J0DIxZ6iIThk8WRXD35eTzm8L7BbvB9LGsp5s+3g5nY=;
        b=GwIDXSGnaXgs6RcIlWYazIQ2Pc9bn+DWC/OR+4nPAsfbL+5PEyY01tfi1TI5jczBRA
         pA9JYcDfM2vONtDIXgaUWurfQbx6MDFKz4Pfxltrx+SghqI18gnkkAMJvvXKgHvHdFER
         Qw+SpD/Ywq+pgPrf0eUNSUgMTnVeJLdtkkUx+HWZVmOcSPuKO1OBxPb6l7CUcTkGcptn
         3Aledg+CD63NlN8CVqZgJL2+zaCkwo8cBcXhKBaBCTq/E6OOlK5PvpZkDGr7XWd5zEC5
         Af6LmecydWath/itWmOutGjAfXbnQpd0mSm9NqBM6UaSUpZw1afh77Ds2eSoMt8+Fegq
         bsHw==
X-Gm-Message-State: AOAM530XH+62PU6W/IWbVc7s1YAOmRWuFbWyhJpRE6ogIEXO3hPRVkFu
        PMv1/OArKK/8Kp/q3PRdqTksgHX8B/sHdQBWxa76CWQlbQmt
X-Google-Smtp-Source: ABdhPJwXQxa1p4FRwX7TZ24K68MpSd+fkc7gHXh48bzZSkuW/45WLlVYYy1Af7/99E9liIZdqd8GVdsZrR6CzCmB9cJwD34x8it7
MIME-Version: 1.0
X-Received: by 2002:a6b:f80b:0:b0:649:a265:bcc3 with SMTP id
 o11-20020a6bf80b000000b00649a265bcc3mr6585960ioh.18.1650384980196; Tue, 19
 Apr 2022 09:16:20 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cc21d05dd0432b8@google.com>
Subject: [syzbot] INFO: rcu detected stall in sys_setxattr (2)
From:   syzbot <syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b2d229d4ddb1 Linux 5.18-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144417ccf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cb89c879305f336
dashboard link: https://syzkaller.appspot.com/bug?extid=10a16d1c43580983f6a2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a88e8f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132a840cf00000

The issue was bisected to:

commit e257039f0fc7da36ac3a522ef9a5cb4ae7852e67
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Mar 1 04:04:20 2022 +0000

    mount_setattr(): clean the control flow and calling conventions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b313c0f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15b313c0f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b313c0f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com
Fixes: e257039f0fc7 ("mount_setattr(): clean the control flow and calling conventions")

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10500 ticks this GP) idle=bb3/1/0x4000000000000000 softirq=5340/5340 fqs=5250 
	(t=10502 jiffies g=4461 q=33)
NMI backtrace for cpu 1
CPU: 1 PID: 3616 Comm: syz-executor364 Not tainted 5.18.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 nmi_cpu_backtrace+0x473/0x4a0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x168/0x280 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x236/0x3a0 kernel/rcu/tree_stall.h:343
 print_cpu_stall kernel/rcu/tree_stall.h:639 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:723 [inline]
 rcu_pending kernel/rcu/tree.c:3923 [inline]
 rcu_sched_clock_irq+0xf1b/0x18d0 kernel/rcu/tree.c:2625
 update_process_times+0x197/0x200 kernel/time/timer.c:1788
 tick_sched_handle kernel/time/tick-sched.c:243 [inline]
 tick_sched_timer+0x377/0x540 kernel/time/tick-sched.c:1473
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x3a6/0xfd0 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x280 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:__mnt_want_write+0xd7/0x2a0 fs/namespace.c:348
Code: bd 00 02 00 00 be 00 02 00 00 44 21 fe 31 ff e8 1f f4 98 ff 44 21 fd 75 0a e8 f5 ef 98 ff eb 3a 0f 1f 00 f3 90 42 0f b6 04 2b <84> c0 75 10 41 f7 06 00 02 00 00 74 1e e8 d7 ef 98 ff eb e5 44 89
RSP: 0018:ffffc90003acfda8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff11002261706 RCX: ffff8880197f0000
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000000
RBP: 0000000000000200 R08: ffffffff81eccb11 R09: fffffbfff1bc082e
R10: fffffbfff1bc082e R11: 1ffffffff1bc082d R12: ffff88801130b820
R13: dffffc0000000000 R14: ffff88801130b830 R15: 0000000000000220
 mnt_want_write+0x43/0x80 fs/namespace.c:394
 path_setxattr+0x117/0x2b0 fs/xattr.c:593
 __do_sys_setxattr fs/xattr.c:611 [inline]
 __se_sys_setxattr fs/xattr.c:607 [inline]
 __x64_sys_setxattr+0xb7/0xd0 fs/xattr.c:607
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f418ef7cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f418ef0d2f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f418f0044b0 RCX: 00007f418ef7cce9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000200
RBP: 00007f418efd2084 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 695f70756f72672c R14: 695f726573752c30 R15: 00007f418f0044b8
 </TASK>
----------------
Code disassembly (best guess):
   0:	bd 00 02 00 00       	mov    $0x200,%ebp
   5:	be 00 02 00 00       	mov    $0x200,%esi
   a:	44 21 fe             	and    %r15d,%esi
   d:	31 ff                	xor    %edi,%edi
   f:	e8 1f f4 98 ff       	callq  0xff98f433
  14:	44 21 fd             	and    %r15d,%ebp
  17:	75 0a                	jne    0x23
  19:	e8 f5 ef 98 ff       	callq  0xff98f013
  1e:	eb 3a                	jmp    0x5a
  20:	0f 1f 00             	nopl   (%rax)
  23:	f3 90                	pause
  25:	42 0f b6 04 2b       	movzbl (%rbx,%r13,1),%eax
* 2a:	84 c0                	test   %al,%al <-- trapping instruction
  2c:	75 10                	jne    0x3e
  2e:	41 f7 06 00 02 00 00 	testl  $0x200,(%r14)
  35:	74 1e                	je     0x55
  37:	e8 d7 ef 98 ff       	callq  0xff98f013
  3c:	eb e5                	jmp    0x23
  3e:	44                   	rex.R
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
