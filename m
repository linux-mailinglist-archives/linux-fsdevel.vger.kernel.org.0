Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865026ACBFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCFSHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 13:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCFSHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:07:20 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234910F1
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 10:06:57 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso4731318ilq.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 10:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3DAy+sdSVNClvpG+8Cs/sO3zSoJDfrh7pwNO1Id96E=;
        b=s2FBVEadlxl8O59ZDJ6ILK9Yez/bd6Bg5CDhh9np9y/tCSLZ8+PQIrFIjZuBMcEpMA
         wPFbPBYDzL1hhjLHldWI5QaDCSZ6pwPBNGMHficwwTIxWUiDYh8XDDA46fd92m7HNCAH
         FGEhuUZmhedDZUloLXFgFfSiBfQJg0pPatkRNfV+cZnqC/qKrOwhQvcWQMSdyueQRo3f
         dS+sLfhkDJHj9jP0tmSAEBFXFzipItf2uBSPVqg1iF6jpGN54b0RAmI8gar7i29rfLyL
         yFr31i9qSX8fZXJtXn8DFBSILGA7WTSyOs8YCLxwMkmh9tQUuJgNvGo24c2yFwVMpckB
         XSZA==
X-Gm-Message-State: AO0yUKX8PjP3ZJuMct1tgPP38B32xhuH+fiZIajuGpQYNxN2azRLdH3t
        VKfNkMiasgkmGH0tXHVfEUwBS8Z67hLRZwkNUvFdGz/YYbVW4EY=
X-Google-Smtp-Source: AK7set+zfNYG60Jyp4hBAP4Ka6VLriaoIZU7jsN0JHSuzoN6XeDMkLKnp8Yq/1C/WlAakdedqzGjToMp3ckefmL8yXZoSLo4N3MS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13e3:b0:313:cc98:7eee with SMTP id
 w3-20020a056e0213e300b00313cc987eeemr5587306ilj.1.1678126007257; Mon, 06 Mar
 2023 10:06:47 -0800 (PST)
Date:   Mon, 06 Mar 2023 10:06:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d128e05f63f28d5@google.com>
Subject: [syzbot] [fs?] WARNING in schedstat_start
From:   syzbot <syzbot+184ec1dbe951014904b3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    fe15c26ee26e Linux 6.3-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17eda014c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=184ec1dbe951014904b3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ef5932c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16981670c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89d41abd07bd/disk-fe15c26e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa75f5030ade/vmlinux-fe15c26e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/590d0f5903ee/Image-fe15c26e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+184ec1dbe951014904b3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5944 at include/linux/cpumask.h:143 schedstat_start+0x1a0/0x20c kernel/sched/stats.c:206
Modules linked in:
CPU: 0 PID: 5944 Comm: syz-executor219 Not tainted 6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cpu_max_bits_warn kernel/sched/stats.c:206 [inline]
pc : cpumask_check include/linux/cpumask.h:150 [inline]
pc : cpumask_next include/linux/cpumask.h:212 [inline]
pc : schedstat_start+0x1a0/0x20c kernel/sched/stats.c:196
lr : seq_read_iter+0x378/0xc44 fs/seq_file.c:225
sp : ffff80001e4e7980
x29: ffff80001e4e7990 x28: ffff0000d49ea1f0 x27: 1fffe0001a93d43e
x26: ffff0000d49ea140 x25: dfff800000000000 x24: 0000000000000007
x23: ffff800015cdd558 x22: 1fffe0001a93d42a x21: dfff800000000000
x20: ffff800015cdd000 x19: ffff0000d49ea150 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000826e470 x15: 0000000000000000
x14: 1ffff00002b9c0b2 x13: dfff800000000000 x12: 0000000000000001
x11: 1ffff00002b9baab x10: 0000000000000002 x9 : ffff800008af6624
x8 : 0000000000000009 x7 : ffff800008af63c8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80000830ba14
x2 : ffff0000d14c1b40 x1 : ffff0000d49ea150 x0 : ffff0000d49ea128
Call trace:
 schedstat_start+0x1a0/0x20c kernel/sched/stats.c:206
 seq_read_iter+0x378/0xc44 fs/seq_file.c:225
 proc_reg_read_iter+0x18c/0x2bc fs/proc/inode.c:305
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x5bc/0x8ac fs/read_write.c:470
 ksys_read+0x15c/0x26c fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:621
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 11872
hardirqs last  enabled at (11871): [<ffff800008064fd4>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (11871): [<ffff800008064fd4>] el0_svc_common+0x9c/0x258 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (11872): [<ffff80001245e098>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (11864): [<ffff800008020ec0>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (11864): [<ffff800008020ec0>] __do_softirq+0xd64/0xfbc kernel/softirq.c:600
softirqs last disabled at (11859): [<ffff80000802b524>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
