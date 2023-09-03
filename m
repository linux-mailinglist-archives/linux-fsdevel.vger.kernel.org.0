Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D482790B8B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 13:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjICLKL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 3 Sep 2023 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjICLKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:10:10 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ECF127
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Sep 2023 04:10:03 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-56f75e70190so202359a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Sep 2023 04:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693739403; x=1694344203;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sDxAwG7AKU11SFXTgQAGFxjQ9mNoubsMELuy5Cglrs=;
        b=kUPKqOstzs/13aN2JRo6dQ1r+VSwBgdtrwduqanTSND7XCMpqv0xbc/NrlMXibXYCr
         rA4ZRYp3rPWMLbFkvmQfI/cXcIWgQb4bsfj3T1dDqxA8k9tc3zB3yPDH1K755HrUYCs+
         SooXdEWIYxrkyAXCx08YgN80mUus+mCX6/rdT0Z0SE8dk7HFHAZIBW6BBovPwhaiUHlR
         5XGLwZGSMpTr64SXtpvqZRll9c9su3SYs61F++cle7sGsmzMjY4d+DonALBD0c334SGN
         gnOFzRdkilJ6bWUQYfNNMlpmNCHorQwo1Xn663Na/Iq9Kc7CBU5f712E+q7Ne8XKxUIE
         247g==
X-Gm-Message-State: AOJu0YwrJWUfSYuNdZVdOlwQnAcD3t6jluCtDBn5flmC7u4TYzFuTlGH
        LVrfzpoVCYSjX3Yp3HPwEYGVhtEG71Ro4BP7UTts++svVhRc
X-Google-Smtp-Source: AGHT+IEoJsE0+DaxDT4OFsrE8kwJmRaELkNZ62c6JOjVhtlwZKoE6Hrgmdpq1kIGD5PQ0nrvNBR8rFwUMJolFBb+rgfasK3tFc3B
MIME-Version: 1.0
X-Received: by 2002:a63:ee0f:0:b0:56c:2f67:7294 with SMTP id
 e15-20020a63ee0f000000b0056c2f677294mr1429599pgi.5.1693739403154; Sun, 03 Sep
 2023 04:10:03 -0700 (PDT)
Date:   Sun, 03 Sep 2023 04:10:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000779c130604726f34@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in sys_openat (3)
From:   syzbot <syzbot+23d96fb466ad56cbb5e5@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d68b4b6f307d Merge tag 'mm-nonmm-stable-2023-08-28-22-48' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ab7013a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c45ae22e154d76fa
dashboard link: https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1554f3ffa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131d119fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaa3c711dd68/disk-d68b4b6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ed6d023ff63/vmlinux-d68b4b6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cc05f8831f38/bzImage-d68b4b6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23d96fb466ad56cbb5e5@syzkaller.appspotmail.com

Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (144 ticks this GP) idle=4084/1/0x4000000000000000 softirq=9930/9930 fqs=1
rcu: 	(t=10500 jiffies g=11621 q=166 ncpus=2)
rcu: rcu_preempt kthread starved for 10498 jiffies! g11621 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task     stack:28672 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1613
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1812
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
1*1024kB 
NMI backtrace for cpu 1
CPU: 1 PID: 5068 Comm: udevd Not tainted 6.5.0-syzkaller-04592-gd68b4b6f307d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x31/0x70 kernel/kcov.c:207
Code: 4d 2c 7c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 00 ba 03 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 04 16 00 00 <85> c0 74 2b 8b 82 e0 15 00 00 83 f8 02 75 20 48 8b 8a e8 15 00 00
RSP: 0018:ffffc900001dfe98 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 00000000000001a8 RCX: 0000000000000100
RDX: ffff88802596d940 RSI: ffffffff8a2ba03a RDI: 0000000000000005
RBP: ffffc900001dff58 R08: 0000000000000005 R09: 0000000000000063
R10: 00000000000001a8 R11: 0000000000122488 R12: 00000000000001a8
R13: 000000000000000a R14: ffffc900801e02a7 R15: 0000000000000000
FS:  00007f4f568abc80(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f5694d650 CR3: 0000000075498000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 put_dec_trunc8+0x2a/0x370 lib/vsprintf.c:230
 number+0x9a8/0xb80 lib/vsprintf.c:510
 vsnprintf+0x905/0x1870 lib/vsprintf.c:2884
 sprintf+0xcd/0x100 lib/vsprintf.c:3022
 print_time kernel/printk/printk.c:1327 [inline]
 info_print_prefix+0x258/0x350 kernel/printk/printk.c:1353
 record_print_text+0x143/0x410 kernel/printk/printk.c:1402
 printk_get_next_message+0x2ca/0x7c0 kernel/printk/printk.c:2809
 console_emit_next_record kernel/printk/printk.c:2844 [inline]
 console_flush_all+0x39e/0xf50 kernel/printk/printk.c:2933
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1c5/0x640 kernel/printk/printk.c:2307
 vprintk+0x89/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 show_free_areas+0x16d4/0x21b0 mm/show_mem.c:384
 __show_mem+0x34/0x150 mm/show_mem.c:409
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xea/0x140 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
 kbd_event+0xcc8/0x17c0 drivers/tty/vt/keyboard.c:1543
 input_to_handler+0x382/0x4c0 drivers/input/input.c:132
 input_pass_values.part.0+0x536/0x7a0 drivers/input/input.c:161
 input_pass_values drivers/input/input.c:148 [inline]
 input_event_dispose+0x5ee/0x770 drivers/input/input.c:378
 input_handle_event+0x11c/0xd80 drivers/input/input.c:406
 input_repeat_key+0x251/0x340 drivers/input/input.c:2263
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
RIP: 0010:virt_to_folio include/linux/mm.h:1255 [inline]
RIP: 0010:virt_to_slab mm/kasan/../slab.h:213 [inline]
RIP: 0010:qlink_to_cache mm/kasan/quarantine.c:129 [inline]
RIP: 0010:qlist_free_all+0x9e/0x170 mm/kasan/quarantine.c:182
Code: 89 de 48 85 ed 49 89 ef 75 ae 4c 89 f7 e8 5a 2a 5e ff 48 c1 e8 0c 48 89 c3 48 b8 00 00 00 00 00 ea ff ff 48 c1 e3 06 48 01 c3 <48> 8b 43 08 a8 01 0f 85 b7 00 00 00 0f 1f 44 00 00 48 89 df e8 09
RSP: 0018:ffffc90003b7fc78 EFLAGS: 00010286
RAX: ffffea0000000000 RBX: ffffea0000a8fcc0 RCX: 0000000000000000
RDX: ffff88802596d940 RSI: ffffffff813b7256 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90003b7fcb8 R14: ffff88802a3f3640 R15: 0000000000000000
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3502
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x100/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4f569819a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcb65fa190 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f569819a4
RDX: 00000000000a0241 RSI: 00007ffcb65fae38 RDI: 00000000ffffff9c
RBP: 00007ffcb65fae38 R08: 00007ffcb65fae90 R09: 00007ffcb65fa638
R10: 0000000000000124 R11: 0000000000000246 R12: 00000000000a0241
R13: 0000556f1fe48a60 R14: 0000556f1fe48300 R15: 0000000000000001
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.821 msecs
CPU: 0 PID: 4489 Comm: udevd Not tainted 6.5.0-syzkaller-04592-gd68b4b6f307d #0
(U) 1*2048kB 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
(M) 3*4096kB 
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
(M) = 15360kB
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 a6 68 2b f7 48 89 df e8 7e e7 2b f7 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 25 4e 1d f7 65 8b 05 36 c9 c6 75 85 c0 74 12 5b
Node 0 DMA32: 
RSP: 0018:ffffc90000007c90 EFLAGS: 00000246
2*4kB 

RAX: 0000000000000002 RBX: ffff88807323f218 RCX: 1ffffffff230254e
(ME) 3*8kB 
RDX: 0000000000000000 RSI: ffffffff8a6ca820 RDI: ffffffff8ac8dcc0
(UME) 2*16kB 
RBP: 0000000000000246 R08: 0000000000000001 R09: fffffbfff22f79ea
(UE) 1*32kB 
R10: ffffffff917bcf57 R11: 0000000000015898 R12: ffff88807323f110
(E) 0*64kB 
R13: 1ffff92000000f96 R14: ffffffff86acef40 R15: 0000000000000001
1*128kB 
FS:  00007f4f568abc80(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
(E) 1*256kB 
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
(E) 1*512kB 
CR2: 0000556f1fe96f58 CR3: 0000000029d1e000 CR4: 00000000003506f0
(U) 1*1024kB 
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
(M) 1*2048kB 
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
(E) 491*4096kB 
Call Trace:
 <IRQ>
(M) = 2015200kB
Node 0 Normal: 
0*4kB 
1*8kB 
(M) 0*16kB 
0*32kB 
0*64kB 0*128kB 
0*256kB 
0*512kB 
0*1024kB 
0*2048kB 
0*4096kB 
= 8kB
Node 1 
Normal: 173*4kB 
(UE) 42*8kB 
(UE) 31*16kB 
(UE) 63*32kB 
(UE) 21*64kB 
(UME) 7*128kB 
(UE) 
2*256kB 
(UM) 2*512kB 
(UM) 1*1024kB 
(U) 1*2048kB 
(U) 955*4096kB 
(ME) 
= 3922068kB
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
 __do_softirq+0x218/0x965 kernel/softirq.c:553
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
lowmem_reserve[]: 0
 </IRQ>
 2613 2614
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
 2614 2614
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x52/0x130 arch/x86/kernel/unwind_orc.c:102

Node 0 
Code: ff 89 de 49 8d 6c 86 fc e8 6b 39 4d 00 85 db 0f 84 d9 00 00 00 e8 ee 3d 4d 00 4c 39 f5 0f 82 cf 00 00 00 4c 89 f3 4c 89 34 24 <49> be 00 00 00 00 00 fc ff df eb 17 e8 cd 3d 4d 00 49 8d 5f 04 4c
DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
RSP: 0018:ffffc90002fef618 EFLAGS: 00000202
lowmem_reserve[]: 0

RAX: 0000000000000000 RBX: ffffffff8ec37628 RCX: 0000000000000000
 0 1
RDX: ffff88807d4fbb80 RSI: ffffffff813a4fc2 RDI: 0000000000000005
 1 1
RBP: ffffffff8ec37668 R08: 0000000000000005 R09: 0000000000000000

Node 0 
R10: 0000000000000011 R11: dffffc0000000000 R12: ffffffff81c2ea71
Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
R13: ffffffff8f3f161c R14: ffffffff8ec37628 R15: ffffc90002fef71d
lowmem_reserve[]: 0
 0 0
 0 0

Node 1 
Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x329/0x2390 arch/x86/kernel/unwind_orc.c:494
lowmem_reserve[]: 0
 0 0
 0 0
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25

Node 0 
DMA: 0*4kB 
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
0*8kB 
0*16kB 
 save_stack+0x160/0x1f0 mm/page_owner.c:128
0*32kB 
0*64kB 
0*128kB 
0*256kB 
0*512kB 
1*1024kB 
(U) 1*2048kB 
(M) 3*4096kB 
(M) = 15360kB
Node 0 DMA32: 
2*4kB 
 __reset_page_owner+0x5a/0x190 mm/page_owner.c:149
(ME) 3*8kB 
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
(UME) 2*16kB 
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
(UE) 1*32kB 
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
(E) 0*64kB 
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
1*128kB 
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
(E) 1*256kB 
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
(E) 1*512kB 
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x19b/0x350 mm/slub.c:3517
(U) 1*1024kB 
(M) 1*2048kB 
(E) 491*4096kB 
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1031
(M) = 2015200kB
 kmalloc_node include/linux/slab.h:619 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:607
Node 0 Normal: 
 kvmalloc include/linux/slab.h:737 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x80b/0x1280 fs/seq_file.c:210
0*4kB 
1*8kB 
 kernfs_fop_read_iter+0x4c8/0x680 fs/kernfs/file.c:279
(M) 0*16kB 
 call_read_iter include/linux/fs.h:1979 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4e0/0x930 fs/read_write.c:470
0*32kB 
0*64kB 
0*128kB 
0*256kB 
0*512kB 
0*1024kB 0*2048kB 
 ksys_read+0x12f/0x250 fs/read_write.c:613
0*4096kB 
= 8kB
Node 1 
Normal: 
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
173*4kB 
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
(UE) 42*8kB 
RIP: 0033:0x7f4f56981b6a
(UE) 31*16kB 
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
(UE) 63*32kB 
RSP: 002b:00007ffcb65f77b8 EFLAGS: 00000246
(UE) 21*64kB 
 ORIG_RAX: 0000000000000000
(UME) 7*128kB 
RAX: ffffffffffffffda RBX: 0000556f1fe48880 RCX: 00007f4f56981b6a
(UE) 2*256kB 
RDX: 0000000000001000 RSI: 0000556f1fe97ff0 RDI: 000000000000000c
(UM) 2*512kB 
RBP: 0000556f1fe48880 R08: 000000000000000c R09: 0000000000000000
(UM) 1*1024kB 
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
(U) 1*2048kB 
R13: 0000000000003fff R14: 00007ffcb65f7c98 R15: 000000000000000a
(U) 955*4096kB 
 </TASK>
(ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7264kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13840kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB writepending:0kB present:4194304kB managed:4117312kB mlocked:0kB bounce:0kB free_pcp:14656kB local_pcp:7392kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Node 0 DMA32: 2*4kB (ME) 3*8kB (UME) 2*16kB (UE) 1*32kB (E) 0*64kB 1*128kB (E) 1*256kB (E) 1*512kB (U) 1*1024kB (M) 1*2048kB (E) 491*4096kB (M) = 2015200kB
Node 0 Normal: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
Node 1 Normal: 173*4kB (UE) 42*8kB (UE) 31*16kB (UE) 63*32kB (UE) 21*64kB (UME) 7*128kB (UE) 2*256kB (UM) 2*512kB (UM) 1*1024kB (U) 1*2048kB (U) 955*4096kB (ME) = 3922068kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14960 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
393503 pages reserved
0 pages cma reserved
Mem-Info:
active_anon:3111 inactive_anon:518 isolated_anon:0
 active_file:0 inactive_file:13682 isolated_file:0
 unevictable:768 dirty:0 writeback:0
 slab_reclaimable:19262 slab_unreclaimable:77897
 mapped:2120 shmem:1278 pagetables:434
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1488159 free_pcp:10463 free_cma:0
Node 0 active_anon:12444kB inactive_anon:2072kB active_file:0kB inactive_file:54656kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:8480kB dirty:0kB writeback:0kB shmem:3576kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:8816kB pagetables:1736kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:1536kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:16kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:15360kB boost:0kB min:200kB low:248kB high:296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 2613 2614 2614 2614
Node 0 DMA32 free:2015200kB boost:0kB min:35412kB low:44264kB high:53116kB reserved_highatomic:0KB active_anon:12400kB inactive_anon:2068kB active_file:0kB inactive_file:53588kB unevictable:1536kB writepending:0kB present:3129332kB managed:2680392kB mlocked:0kB bounce:0kB free_pcp:27192kB local_pcp:13352kB free_cma:0kB
lowmem_reserve[]: 0 0 1 1 1
Node 0 Normal free:8kB boost:0kB min:12kB low:12kB high:12kB reserved_highatomic:0KB active_anon:44kB inactive_anon:4kB active_file:0kB inactive_file:1068kB unevictable:0kB writepending:0kB present:1048576kB managed:1128kB mlocked:0kB bounce:0kB free_pcp:4kB local_pcp:4kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 Normal free:3922068kB boost:0kB min:54480kB low:68100kB high:81720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:72kB unevictable:1536

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
