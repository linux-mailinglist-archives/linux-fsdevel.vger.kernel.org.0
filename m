Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15EA5072C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354510AbiDSQTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354511AbiDSQTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:19:06 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E2393FF
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:16:21 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h28-20020a056e021d9c00b002cc403e851aso2113977ila.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kIqlqbqI51kwTHRKj8IajF/Rvbxyiy/lRTS6WnhpTUY=;
        b=SqbOWbWOyD5Ni0a7uX3DtALcHzQCCVJSnofUfOiZ8KMwNh99oQtV4ZQQaTTWJQ+yyR
         XTgDARzTCZurgq7h4hFKrD3kIpjwvwgr/h2nX2SNRSiluG2ERl+MMbxciSjP8T39rMDL
         uAbiWmcxoB4Pf+kY95kKSZTt0YxOIQvLoAj1v7QMgOR4GAkkmuKA4ZQEbCWyEeTdcRXO
         gG9KiLLTy6BS1Jmksdg7M+xpoOwkIjvmWqCUsVVJ365PfCjW7j3Cc2wBhEE7gNa9aU68
         MV5h5V74m24iujjLz9Z1qyEVzJcUcvuBo+KrvMxRIqK7hD2pRS79rpVrYQ5QHsbpUgPl
         IzUg==
X-Gm-Message-State: AOAM532lXytCM1GMxTQ9nAqTTzt+wpYszfrBvIieeeI3gvjE/UWw9ioo
        uDXqYdKA40xB59TnfqJFVUoAbT8uX3g39U2AN+AezVwsT0R9
X-Google-Smtp-Source: ABdhPJwEBE5Lj26y8ZDffyQ4B6Wm9CsVVAvAh4JnHLqDLoE6JQnMpbzREJqoWINF0cn/WVac/SCehmLIH6JrUlKuTZz3v028MvmA
MIME-Version: 1.0
X-Received: by 2002:a02:7058:0:b0:326:70d9:5917 with SMTP id
 f85-20020a027058000000b0032670d95917mr7644947jac.254.1650384980466; Tue, 19
 Apr 2022 09:16:20 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080e10e05dd043247@google.com>
Subject: [syzbot] INFO: rcu detected stall in sys_lsetxattr
From:   syzbot <syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com>
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

HEAD commit:    40354149f4d7 Add linux-next specific files for 20220414
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ae0bd0f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a44d62051576f6f5
dashboard link: https://syzkaller.appspot.com/bug?extid=306090cfa3294f0bbfb3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164417ccf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104d63d0f00000

The issue was bisected to:

commit e257039f0fc7da36ac3a522ef9a5cb4ae7852e67
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Mar 1 04:04:20 2022 +0000

    mount_setattr(): clean the control flow and calling conventions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14622210f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16622210f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12622210f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
Fixes: e257039f0fc7 ("mount_setattr(): clean the control flow and calling conventions")

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10499 ticks this GP) idle=23b/1/0x4000000000000000 softirq=5447/5447 fqs=5210 
	(t=10500 jiffies g=4401 q=63 ncpus=2)
NMI backtrace for cpu 1
CPU: 1 PID: 3614 Comm: syz-executor153 Not tainted 5.18.0-rc2-next-20220414-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x262/0x3f0 kernel/rcu/tree_stall.h:369
 print_cpu_stall kernel/rcu/tree_stall.h:665 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:749 [inline]
 rcu_pending kernel/rcu/tree.c:4010 [inline]
 rcu_sched_clock_irq.cold+0x144/0x8fc kernel/rcu/tree.c:2675
 update_process_times+0x16d/0x200 kernel/time/timer.c:1811
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:243
 tick_sched_timer+0xee/0x120 kernel/time/tick-sched.c:1473
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__mnt_want_write+0xdd/0x2e0 fs/namespace.c:348
Code: 00 02 00 00 89 de e8 22 64 9c ff 85 db 74 42 48 b8 00 00 00 00 00 fc ff df 4d 89 ec 49 c1 ec 03 49 01 c4 e8 e5 61 9c ff f3 90 <41> 0f b6 04 24 84 c0 74 08 3c 03 0f 8e 99 01 00 00 8b 5d 10 31 ff
RSP: 0018:ffffc90003acfdf0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff8880209957c0 RSI: ffffffff81dda00b RDI: 0000000000000003
RBP: ffff888140174c20 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81dda030 R11: 1ffffffff1f09899 R12: ffffed102802e986
R13: ffff888140174c30 R14: ffff888140174c50 R15: 0000000000000000
 mnt_want_write+0x13d/0x3e0 fs/namespace.c:394
 path_setxattr+0xb2/0x1c0 fs/xattr.c:627
 __do_sys_lsetxattr fs/xattr.c:652 [inline]
 __se_sys_lsetxattr fs/xattr.c:648 [inline]
 __x64_sys_lsetxattr+0xbd/0x150 fs/xattr.c:648
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7262608cc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f72625992f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007f72626904b0 RCX: 00007f7262608cc9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000600
RBP: 00007f726265e074 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 695f70756f72672c R14: 695f726573752c30 R15: 00007f72626904b8
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 02                	add    %al,(%rdx)
   2:	00 00                	add    %al,(%rax)
   4:	89 de                	mov    %ebx,%esi
   6:	e8 22 64 9c ff       	callq  0xff9c642d
   b:	85 db                	test   %ebx,%ebx
   d:	74 42                	je     0x51
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	4d 89 ec             	mov    %r13,%r12
  1c:	49 c1 ec 03          	shr    $0x3,%r12
  20:	49 01 c4             	add    %rax,%r12
  23:	e8 e5 61 9c ff       	callq  0xff9c620d
  28:	f3 90                	pause
* 2a:	41 0f b6 04 24       	movzbl (%r12),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	74 08                	je     0x3b
  33:	3c 03                	cmp    $0x3,%al
  35:	0f 8e 99 01 00 00    	jle    0x1d4
  3b:	8b 5d 10             	mov    0x10(%rbp),%ebx
  3e:	31 ff                	xor    %edi,%edi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
