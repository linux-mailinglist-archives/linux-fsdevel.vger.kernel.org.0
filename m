Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915EA6129BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJ3Jvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ3Jvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:51:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE8BE6;
        Sun, 30 Oct 2022 02:51:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so22815857eja.6;
        Sun, 30 Oct 2022 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDghFPkgm0Bon6txMxF2PyM6t8EE5SBUHvWuXSrZpjU=;
        b=C1LIM2QcTvauprLLkS0de+ZTT1GvTa/+aX1zf0sNWHoHFLCz05EDFQ77bQAnHfZ3E6
         MDmxDezGhkq5V4h/279DVqRWjB0AJOeSQQeJ4Xwmz2H+gEBlgAITYBqOrUQbD5zV+f10
         AUfyz+0bLz7h2cLbnlbAVrv/DKBLYajd7Hnc0t+fBSJESbzq/2PrjV4blx+ubZQS7iM6
         v2h3LvprOERS8MPra2ZrDSeUYmwXAGRgZP6cH2QB+Z8SS0pN5remY2J9lD3I5LPtJMhy
         DQwPfAdx93UsF5uVUMHsS1q16F6k3tjsa/bpTu9AXyeXPSYTnjQsFRG3Q8IgAh1u6hTp
         BMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDghFPkgm0Bon6txMxF2PyM6t8EE5SBUHvWuXSrZpjU=;
        b=6gN80uKhXZWWUYIDWlIHC2K8KV1eSajLchoKgaaYQzlWmgGjxijp4Oq+D84u7a/+qp
         nFEOZb3tHuYBHwklW/LGLNVu8ad43lLXaporTSgpmbbct2wCdmJ3+5m42xRVLEQQs52g
         ZbY8ezQxe8RwpZ+Kz2qpkZUiURXovDCGUfJBsj0YRnY10kvaARuoNx/QBRHEtQhtWa+Q
         l/fMaSoraGKsuwJK5lJJL3OCDiftNuUbNj7hWOKh+X9GRNb3AtxBB37pmAthUWkJjWPV
         ZcUtK585Yhs3Z+62Kein7AWk2CSEj/5C243/Bn0TM7CJwTtmucZwoxdIzdrPF2zys708
         sjRg==
X-Gm-Message-State: ACrzQf3HMsXOT+1yGYE2DNGFYaX5+Emv4KdY3ffQDIlCThUqBcupigN7
        /wQoeGgkTUri7CesvCzu0CJaXwXV7qfLU6prI9OTFORdg+IKpg==
X-Google-Smtp-Source: AMsMyM6WAL8jjFKTuqsXWRI0RiBABiYiiUHOJOW+P0W8bpOkQ7M5a7/DEWdUsD2UvOzbNRYNabbxSFyr5Q9MO5jhjmw=
X-Received: by 2002:a17:907:c208:b0:7ad:a0df:d4c7 with SMTP id
 ti8-20020a170907c20800b007ada0dfd4c7mr7362643ejc.312.1667123495257; Sun, 30
 Oct 2022 02:51:35 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:50:59 +0800
Message-ID: <CAO4mrffezZUhCCjeDzbdwTNH7RLxsS6o1YUvGJD7tWrovBnRSQ@mail.gmail.com>
Subject: INFO: task hung in fuse_mount_remove
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1tgzWXmjFknwTTo-Y7gSi48OdM7kyVrxb/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

INFO: task syz-executor.0:6566 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:10408 pid: 6566 ppid:     1 flags:0x00004004
Call Trace:
 __schedule+0x4a1/0x1720
 schedule+0x36/0xe0
 rwsem_down_write_slowpath+0x322/0x7a0
 fuse_mount_remove+0x26/0x90
 fuse_sb_destroy+0x23/0x50
 fuse_kill_sb_anon+0x11/0x20
 deactivate_locked_super+0x42/0x90
 deactivate_super+0x9d/0xb0
 cleanup_mnt+0x153/0x1d0
 task_work_run+0x86/0xe0
 exit_to_user_mode_prepare+0x25e/0x280
 syscall_exit_to_user_mode+0x19/0x60
 do_syscall_64+0x40/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46aba7
RSP: 002b:00007ffdca8286e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046aba7
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffdca8287a0
RBP: 00007ffdca8298a0 R08: 0000000002d3ddd3 R09: 000000000000000c
R10: 00000000fffffffb R11: 0000000000000246 R12: 0000000002d3dd00
R13: 0000000000000002 R14: 0000000000000032 R15: 0000000000000bb8

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8641dee0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x15/0x17a
1 lock held by in:imklog/6175:
 #0: ffff888013fda6f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x92/0xa0
2 locks held by agetty/6224:
 #0: ffff888013f03098 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x20/0x50
 #1: ffffc900008472e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x203/0x930
2 locks held by agetty/6232:
 #0: ffff88810ac7d898 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x20/0x50
 #1: ffffc9000084b2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x203/0x930
2 locks held by syz-executor.0/6566:
 #0: ffff88802dbeb0e0 (&type->s_umount_key#53){+.+.}-{3:3}, at:
deactivate_super+0x95/0xb0
 #1: ffff88803ca09b38 (&fc->killsb){++++}-{3:3}, at: fuse_mount_remove+0x26/0x90
1 lock held by syz-executor.0/1879:
 #0: ffff88803ca09b38 (&fc->killsb){++++}-{3:3}, at:
fuse_dev_do_write+0x532/0x14f0

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
Call Trace:
 dump_stack_lvl+0xcd/0x134
 nmi_cpu_backtrace.cold.8+0xf3/0x118
 nmi_trigger_cpumask_backtrace+0x18f/0x1c0
 watchdog+0x9a0/0xb10
 kthread+0x1a6/0x1e0
 ret_from_fork+0x1f/0x30
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10409 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:perf_trace_lock_acquire+0x156/0x1a0
Code: 00 53 e8 5d 47 1d 00 5e 5f 48 8b 45 d0 65 48 33 04 25 28 00 00
00 75 4a 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 48 8b 03 <48> 85
c0 0f 85 1c ff ff ff eb d4 41 bd 18 00 07 00 41 bc 06 00 00
RSP: 0000:ffffc90002d97c80 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffe8ffffc42d38 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002d97cd8 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000005 R11: 0000000000000000 R12: 000000000000000e
R13: 00000000000f0018 R14: ffffffff86338f00 R15: ffff88810ae79b28
FS:  00007f9a23fd1700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000110c96000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x184/0x330
 __might_fault+0x92/0xc0
 copy_fpstate_to_sigframe+0x5a8/0x680
 get_sigframe.isra.16+0xb1/0x1b0
 arch_do_signal_or_restart+0x53a/0x870
 exit_to_user_mode_prepare+0x138/0x280
 irqentry_exit_to_user_mode+0x5/0x40
 exc_page_fault+0x4a4/0x1130
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x4064fb
Code: c7 f0 fe ff ff e8 65 06 02 00 85 c0 0f 84 95 01 00 00 64 f0 83
2c 25 b8 ff ff ff 01 48 8b 54 24 18 48 8b 44 24 28 4c 8b 42 78 <8b> 00
49 83 f8 ff 89 82 80 00 00 00 0f 84 13 01 00 00 48 8b 44 24
RSP: 002b:00007f9a23fd0c40 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 000000000119bfa0
RDX: 000000000119bfa0 RSI: 0000000000000001 RDI: 00007f9a23fd15f0
RBP: 000000000119bfa8 R08: 0000000000000000 R09: 000000000119bfa8
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007ffdca829770
----------------
Code disassembly (best guess):
   0: 00 53 e8              add    %dl,-0x18(%rbx)
   3: 5d                    pop    %rbp
   4: 47 1d 00 5e 5f 48    rex.RXB sbb $0x485f5e00,%eax
   a: 8b 45 d0              mov    -0x30(%rbp),%eax
   d: 65 48 33 04 25 28 00 xor    %gs:0x28,%rax
  14: 00 00
  16: 75 4a                jne    0x62
  18: 48 8d 65 d8          lea    -0x28(%rbp),%rsp
  1c: 5b                    pop    %rbx
  1d: 41 5c                pop    %r12
  1f: 41 5d                pop    %r13
  21: 41 5e                pop    %r14
  23: 41 5f                pop    %r15
  25: 5d                    pop    %rbp
  26: c3                    retq
  27: 48 8b 03              mov    (%rbx),%rax
* 2a: 48 85 c0              test   %rax,%rax <-- trapping instruction
  2d: 0f 85 1c ff ff ff    jne    0xffffff4f
  33: eb d4                jmp    0x9
  35: 41 bd 18 00 07 00    mov    $0x70018,%r13d
  3b: 41                    rex.B
  3c: bc                    .byte 0xbc
  3d: 06                    (bad)

Best,
Wei
