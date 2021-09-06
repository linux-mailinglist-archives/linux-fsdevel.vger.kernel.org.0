Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C85401955
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbhIFJ4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 05:56:39 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53897 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241394AbhIFJ4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:56:30 -0400
Received: by mail-il1-f199.google.com with SMTP id h8-20020a056e021b8800b0022b466f3373so2255335ili.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 02:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jifsjHtYK8P0HJ9Xm8/TAQghb1ZspQh1SIiaZ0cZTiY=;
        b=lJC9AyU1BsCpQWTT5ZNEZD52HPT1vly/aFTIxuBMeAdtEzjqSFowSoHxhjqVCbcoY+
         afoEK5dz4W5GOBRHrMajBp71IF6UuhsaB0Fydsqqgl4A5qCZnddO9gRLXM/tgQ1zDhIK
         6JMWywsTu7811aA64hyBtV2K2U20T6Nxj0zAZQe00po/fWqYiCHM3pPMZ/XeTcNhAUzH
         3YXp91ZhipssTgqOJQfK9pzlXvm988hmvqRHEkdXThnBXN7q8n0hAfWh9LOvDgK/iQ30
         Hmih/10wcgPQT28daepXGVMJLKWXUOcUzMgCfecuO2osv7vP6xL2lFi227ELz1czdahY
         SRYA==
X-Gm-Message-State: AOAM531SQQwXeSmv8ZG0BumSTw2XjFHNWngyltYwK1yJeOg4taUtMOCV
        Qqet9Al6KPdN051a1uTYSienBlin0BM1G7cxEYvZB6wLQw5O
X-Google-Smtp-Source: ABdhPJzdNdpiHHE2RQSTDIRyASJ28OpZTQKcqqy15pMGg3xHtKaTVuipkSaPADZAc4vjRle4jeDf/9d+o+rz8Ssrw/VIRf1U9Gyg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:: with SMTP id s8mr7360584ilv.323.1630922125921;
 Mon, 06 Sep 2021 02:55:25 -0700 (PDT)
Date:   Mon, 06 Sep 2021 02:55:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8d56e05cb50a541@google.com>
Subject: [syzbot] upstream test error: WARNING in __do_kernel_fault
From:   syzbot <syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f1583cb1be35 Merge tag 'linux-kselftest-next-5.15-rc1' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17756315300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe535c85e8d7384
dashboard link: https://syzkaller.appspot.com/bug?extid=e6bda7e03e329ed0b1db
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com

------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000308 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : ffff00007fbbb9c8 x4 : 0000000000015ff5 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640ca ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 000000000000032d x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640cb ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000352 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640cc ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000377 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640cd ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 000000000000039c x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640ce ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000003c1 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640cf ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000003e6 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d0 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 000000000000040b x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d1 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000430 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d2 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000455 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d3 ]---
__do_kernel_fault: 65272 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 000000000000047b x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : ffff00007fbbb9c8 x4 : 0000000000015ff5 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d4 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000004a0 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d5 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000004c5 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d6 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000004ea x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d7 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 000000000000050f x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d8 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000534 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640d9 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 0000000000000559 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640da ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 000000000000057e x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640db ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000005a3 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640dc ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
Modules linked in:
CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
sp : ffff80001267b980
x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: 756166206e6f6974 x13: 00000000000005c8 x12: ffff80001267b680
x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
Call trace:
 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
---[ end trace ae975648337640dd ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
