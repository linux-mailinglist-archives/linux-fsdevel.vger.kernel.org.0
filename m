Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90585653AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 03:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiLVC5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 21:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVC5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:57:40 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F315F1A827
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 18:57:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so373229ilh.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 18:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkvBE1UbBZoC/yc5i9qfAPMN7tBftxb6qZxmobUW1/k=;
        b=GV0EANXyx5iVACyD8aLArtOmVDfUWVZss7hINZKLsqyicNRLH6iRgnntazkpL7EjTS
         YuDxcp8R7RDS+SJmEeI+6GY2+h2p3AdfcsHrtRnuKni6v9NbM9Vn7y03tTlkGgCvFDzc
         j9yYf2g8Z3KgzpaIL+gKpz/sTPimWgGWBz+qBE/+Vqjyk1hB87BwIrCYhPECMyhrS+Pj
         jKhSKQoEGlCC/qTLWXeSekWZYwvrbzmODLCVapa5tu1c/usWWLFfmoSRflZwnrZ1E+ms
         hQdUWSXtPOnfYiTjar3Gau82PAbMdv7x1uRJKalEn2YqRIeMawR1R4+DNcpbsqkzpSan
         /LMA==
X-Gm-Message-State: AFqh2koM0a2lekI+KoHRvMMEk+9R8/hYVFBVSAEbT6B1svbR9W4JFJo/
        Y2viBkQniv8bIlk4agNeRgIvNVhBHSR2j7mOFtjQlM2f5Ct+
X-Google-Smtp-Source: AMrXdXtoIpWpXVvycFxtoKV7NJZ47m+rb40rPxKrIlRA0WKuJMQpdx7PBpYVJrptjRcbdfeZnnybBr/5moUnxPeYWeIxllIAej3A
MIME-Version: 1.0
X-Received: by 2002:a02:8586:0:b0:38a:979e:f584 with SMTP id
 d6-20020a028586000000b0038a979ef584mr299871jai.261.1671677858334; Wed, 21 Dec
 2022 18:57:38 -0800 (PST)
Date:   Wed, 21 Dec 2022 18:57:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eccdc505f061d47f@google.com>
Subject: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
From:   syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
To:     hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1560b830480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e320b3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c0577880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/93008694e408/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 0 PID: 0 at fs/buffer.c:1145 __brelse fs/buffer.c:1145 [inline]
WARNING: CPU: 0 PID: 0 at fs/buffer.c:1145 brelse include/linux/buffer_head.h:326 [inline]
WARNING: CPU: 0 PID: 0 at fs/buffer.c:1145 __invalidate_bh_lrus fs/buffer.c:1380 [inline]
WARNING: CPU: 0 PID: 0 at fs/buffer.c:1145 invalidate_bh_lru+0xa0/0x134 fs/buffer.c:1393
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __brelse fs/buffer.c:1145 [inline]
pc : brelse include/linux/buffer_head.h:326 [inline]
pc : __invalidate_bh_lrus fs/buffer.c:1380 [inline]
pc : invalidate_bh_lru+0xa0/0x134 fs/buffer.c:1393
lr : __brelse fs/buffer.c:1145 [inline]
lr : brelse include/linux/buffer_head.h:326 [inline]
lr : __invalidate_bh_lrus fs/buffer.c:1380 [inline]
lr : invalidate_bh_lru+0xa0/0x134 fs/buffer.c:1393
sp : ffff800008003e50
x29: ffff800008003e50 x28: ffff80000d2d42f0 x27: ffff80000d2d42e8
x26: ffff800008648d54 x25: ffff0000c054e2a0 x24: 00000000ffffffff
x23: ffff0001fefcc830 x22: 0000000000000000 x21: 0000000000000001
x20: 0000000000000000 x19: ffff80000cbe89d6 x18: 000000000000035e
x17: ffff8001f1cee000 x16: ffff80000dbe6158 x15: ffff80000d39bc80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff80000d39bc80
x11: ff808000081c4d64 x10: 0000000000010002 x9 : ad49151c1e37eb00
x8 : ad49151c1e37eb00 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100010002 x0 : 0000000000000027
Call trace:
 __brelse fs/buffer.c:1145 [inline]
 brelse include/linux/buffer_head.h:326 [inline]
 __invalidate_bh_lrus fs/buffer.c:1380 [inline]
 invalidate_bh_lru+0xa0/0x134 fs/buffer.c:1393
 __flush_smp_call_function_queue+0x26c/0x8d8 kernel/smp.c:630
 generic_smp_call_function_single_interrupt+0x28/0xfc kernel/smp.c:546
 do_handle_IPI arch/arm64/kernel/smp.c:876 [inline]
 ipi_handler+0x108/0x1a8 arch/arm64/kernel/smp.c:922
 handle_percpu_devid_irq+0xb0/0x1cc kernel/irq/chip.c:930
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:648 [inline]
 generic_handle_domain_irq+0x4c/0x6c kernel/irq/irqdesc.c:704
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:695 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:746 [inline]
 gic_handle_irq+0x78/0x1b4 drivers/irqchip/irq-gic-v3.c:790
 call_on_irq_stack+0x2c/0x54 arch/arm64/kernel/entry.S:892
 do_interrupt_handler+0x7c/0xc0 arch/arm64/kernel/entry-common.c:274
 __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:486
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:491
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:580
 arch_local_irq_enable+0xc/0x18 arch/arm64/include/asm/irqflags.h:35
 default_idle_call+0x48/0xb8 kernel/sched/idle.c:109
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x110/0x2d4 kernel/sched/idle.c:303
 cpu_startup_entry+0x24/0x28 kernel/sched/idle.c:400
 kernel_init+0x0/0x290 init/main.c:729
 start_kernel+0x0/0x620 init/main.c:890
 start_kernel+0x450/0x620 init/main.c:1145
 __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:471
irq event stamp: 114628
hardirqs last  enabled at (114627): [<ffff80000c096a3c>] default_idle_call+0x34/0xb8 kernel/sched/idle.c:106
hardirqs last disabled at (114628): [<ffff80000c084174>] __el1_irq arch/arm64/kernel/entry-common.c:468 [inline]
hardirqs last disabled at (114628): [<ffff80000c084174>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:486
softirqs last  enabled at (114616): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (114581): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
