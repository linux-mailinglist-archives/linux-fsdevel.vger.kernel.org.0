Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5989E78C263
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjH2KkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjH2KkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:40:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12119F;
        Tue, 29 Aug 2023 03:40:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31985ebed68so217023f8f.0;
        Tue, 29 Aug 2023 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693305599; x=1693910399;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bYWMvaPh3fE0F1tz3rOAc5dgkvFbufuilK1CGiiGPw=;
        b=rDTOnlF4OvXj4y+XnOdHG4qOApjYq38PhfVmabLwN7rceb9pG73hshLI5VvSMKwe4+
         dPiu5aVsT49OE7Es9+oNaIQRlYV4QTLlf5mkr/Q3NsNayPxebmeN8IaGIvAygxFKzRIX
         itWv6TG7PbkjgOWbuFmTk1qQJIy0Kpy8zW1wLio8EgjsRiwzZg/Xy4XuApWHEKnGrAME
         fScb9AXAs3YOHhEDaFr5A8lxk3Ms+/jaRcx+W54b73QszpOsuAfg4L9y9qSXSRF9MaHi
         XRo1WATQyRJX+DSE3g165Au4Cu9aFWA9P8x1h9XD0G8k0HsKNk1YCl0MIy9GBJnvQO1t
         jJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305599; x=1693910399;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bYWMvaPh3fE0F1tz3rOAc5dgkvFbufuilK1CGiiGPw=;
        b=Z5Qa8R0K3rAaOHp8q0M3HM2LTZsQxr5px834WuUZgHF7tYka+KsV2koVwFSr9J+ba5
         pavhnmcgmw898kDtuv6/J+Pi2OmNB9dln2ePC882xQqm9WZuJgDi+ZU6B2pt4a5cIka9
         OVA0BXbE7qCLPci5xBa3I3V8HY2v/xyX98tqyBuNuf5bpG/2e9gLyYpPepNtICvo/4aZ
         Wq64KsKr2/89/cWr+qNxfvUQuxzsqN6RCXJBT5ggH1pArT5AZ42nOfndI83zQLX346Aa
         Q+76LSfmqgdKAS4IHMd9yllFQ1gTusbmSjzXq3qCV507zmpz0HTtzEzAE6Ew7O4DyEo5
         UTXg==
X-Gm-Message-State: AOJu0Yw1KrlozNY7c/4XgFiewA5oFKhrd8++wWWcIHlHB7LpJUxi74t+
        QGFD/nJL2aT/6oeKJ/BGslo=
X-Google-Smtp-Source: AGHT+IFpk0R3waJIYI34F7jBwPMjFYmeMa6jCXnkl71ORRsXEIP9z4vTK2rm/O2d9U48cfSh2p0Dxg==
X-Received: by 2002:adf:f4ce:0:b0:317:f1d6:997c with SMTP id h14-20020adff4ce000000b00317f1d6997cmr21257134wrp.0.1693305598554;
        Tue, 29 Aug 2023 03:39:58 -0700 (PDT)
Received: from [10.0.0.4] ([78.240.207.57])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4205000000b00317ddccb0d1sm13338083wrq.24.2023.08.29.03.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:39:57 -0700 (PDT)
Message-ID: <cec84566-b10c-4e16-ab62-44ffd2018376@gmail.com>
Date:   Tue, 29 Aug 2023 12:39:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] INFO: rcu detected stall in sys_close (5)
Content-Language: en-US
To:     syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, edumazet@google.com,
        netdev@vger.kernel.org
References: <00000000000017ad3f06040bf394@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <00000000000017ad3f06040bf394@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/29/23 10:53, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=158c0cdba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45047a5b8c295201
> dashboard link: https://syzkaller.appspot.com/bug?extid=e46fbd5289363464bc13
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14780797a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c1fc9fa80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3b19428c542a/disk-727dbda1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/45ed4d6b4633/vmlinux-727dbda1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4c3abf020089/bzImage-727dbda1.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
>
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2663 jiffies s: 873 root: 0x1/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
> Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
> RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
> RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
> RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <NMI>
>   </NMI>
>   <IRQ>
>   pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
>   fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
>   call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
>   expire_timers kernel/time/timer.c:1751 [inline]
>   __run_timers+0x764/0xb10 kernel/time/timer.c:2022
>   run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
>   __do_softirq+0x218/0x965 kernel/softirq.c:553
>   invoke_softirq kernel/softirq.c:427 [inline]
>   __irq_exit_rcu kernel/softirq.c:632 [inline]
>   irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
>   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
>   </IRQ>
>   <TASK>
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> RIP: 0010:__x64_sys_close+0x0/0xf0 fs/open.c:1557
> Code: 1a 48 83 ec 80 5b 5d 41 5c c3 e8 eb bb f1 ff e9 73 ff ff ff e8 e1 bb f1 ff eb 8b e8 2a 06 4a 08 66 2e 0f 1f 84 00 00 00 00 00 <f3> 0f 1e fa 55 53 48 89 fb e8 c2 81 9d ff 48 8d 7b 70 48 b8 00 00
> RSP: 0018:ffffc9000459ff38 EFLAGS: 00000206
> RAX: 0000000000000003 RBX: ffffc9000459ff58 RCX: 1ffffffff1d56e59
> RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffffc9000459ff58
> RBP: ffffc9000459ff48 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffffff8eaba457 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6b4427b290
> Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d f1 8d 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> RSP: 002b:00007ffd4ca6aa18 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f6b4427b290
> RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000005
> RBP: 00000000000f4240 R08: 0000000055d55610 R09: 0000000055d55610
> R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000220c3
> R13: 00007ffd4ca6aa24 R14: 00007ffd4ca6aa40 R15: 00007ffd4ca6aa30
>   </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.831 msecs
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)


#syz set subsystems: net

fq_pie_timer() should not attempt to loop over up to 65536 flows,
this takes up to 5 ms on ASAN builds.

>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
