Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D778C0D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjH2IyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjH2Ixy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:53:54 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E58B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 01:53:50 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-2717f4ba116so3116963a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 01:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693299230; x=1693904030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhSeRXJePYYhEsJ9/kfejl+Uu0PrN4lHkUjvDw/XFFU=;
        b=XIPbjldc1a/Yf2P+YR4BP1NxTg3wzNi5scTscGlerw5RYnSE6NW232IOjdhUsLS1Ex
         5Op7JLvQKKUd4zaTUWDkr5+X1WyflT1CexxD04CitGi5BH4kslzbJLgQscOzLW+163FB
         NdeV/yQn8XSQ3ZFTruNBIdvX8h+7RTzUgvoTnMQYL03zkP56JJOgPlOYpWjB3vBerqES
         m97cRHRHHggJdORkN4yD3E4XIkDKMfLvcPjwsZVBTHcC708asb8lT9xcrWYSeQ2GDw1C
         XBBDeK7vfufiO4wM0Dm4JhtbDA8VBqNnHg3ULVLXTUTfHW2y6Z7rbGsekSz5T6cRThxu
         Y/wA==
X-Gm-Message-State: AOJu0YyXOpNaJifRlzLEbqYdlhaX25OL3YAFIP3ZmoOjLdtY4iIHUOjB
        odhLELGZqYRGsXq2nNwezb1OfBk/bdf1OFHeJc6hMz/CWlhI
X-Google-Smtp-Source: AGHT+IEpIpdn0MhRVZhuhUcK7IfpwHLFFgAQTv6xAYnprL1z1FG1Ig5Dr0EVqxk4xvVpwJr6U3Zpw6AFBeEURRUhi/eWMkzWJJyl
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c7c9:b0:26d:2079:1376 with SMTP id
 gf9-20020a17090ac7c900b0026d20791376mr6484622pjb.1.1693299229828; Tue, 29 Aug
 2023 01:53:49 -0700 (PDT)
Date:   Tue, 29 Aug 2023 01:53:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017ad3f06040bf394@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in sys_close (5)
From:   syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158c0cdba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45047a5b8c295201
dashboard link: https://syzkaller.appspot.com/bug?extid=e46fbd5289363464bc13
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14780797a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c1fc9fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b19428c542a/disk-727dbda1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45ed4d6b4633/vmlinux-727dbda1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c3abf020089/bzImage-727dbda1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2663 jiffies s: 873 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
 fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
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
RIP: 0010:__x64_sys_close+0x0/0xf0 fs/open.c:1557
Code: 1a 48 83 ec 80 5b 5d 41 5c c3 e8 eb bb f1 ff e9 73 ff ff ff e8 e1 bb f1 ff eb 8b e8 2a 06 4a 08 66 2e 0f 1f 84 00 00 00 00 00 <f3> 0f 1e fa 55 53 48 89 fb e8 c2 81 9d ff 48 8d 7b 70 48 b8 00 00
RSP: 0018:ffffc9000459ff38 EFLAGS: 00000206
RAX: 0000000000000003 RBX: ffffc9000459ff58 RCX: 1ffffffff1d56e59
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffffc9000459ff58
RBP: ffffc9000459ff48 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8eaba457 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6b4427b290
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d f1 8d 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffd4ca6aa18 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f6b4427b290
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000005
RBP: 00000000000f4240 R08: 0000000055d55610 R09: 0000000055d55610
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000220c3
R13: 00007ffd4ca6aa24 R14: 00007ffd4ca6aa40 R15: 00007ffd4ca6aa30
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.831 msecs


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
