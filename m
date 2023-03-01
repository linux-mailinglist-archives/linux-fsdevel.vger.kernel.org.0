Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537FC6A7191
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCAQyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 11:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCAQyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:54:04 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86A24135
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 08:54:02 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id k13-20020a5d9d4d000000b0074caed3a2d2so9215253iok.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 08:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qdufye7nsdiEuktgAaX45QySU43qp/3ZmCmUxJlBXDk=;
        b=5BoQ35qdgRc0UiLrswU/jbDV5Ym/vkcSBDQ8Ig66uh+xBGr4PQcURhWmc6g/tRswyt
         EAgUdUgh1DUl0bCeDOdfLr3MtBQn5J6Hy7xGSnAJKFUp0ZU3PPXKSBRCpxBnnWxUoPlp
         7O2XLPJxtL/R4uPn5L1CeP6tH4CQKTBXRX5flFYLc7Jy3cClm6pI3qvDk/0Td7OqrhaG
         btUpnfoBAvyn+4NGYmer6Xu3o/VL69xxQioQ2LgJd9IzkfESQ3cnA1ZwiDMDbaNyHChi
         BwONm01qlHokr/7L1kq/ZLRdObFU/8NTH118uW29D9jqEDiy94nHOvMuw15pObAKOwfk
         bIhw==
X-Gm-Message-State: AO0yUKWf1zQqgzjcmAOTpAOdffSc5U/wpf0IV5ztGVnwsSb+cNolYCwI
        JZsNfCHf2njanpJp7McE42eOB3W3Q5L0+3Sy0jrbAA9lUown
X-Google-Smtp-Source: AK7set9BOYgzdHscO/xfbG7JE2QGM3BM7VMgI/1xMbp+T2NVCyBY3R7p4mM7d7W/LFUQYW02ELjqh+aNlHMkfRymj0UBG4rI3m3Z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3882:b0:3c4:cf94:54a7 with SMTP id
 b2-20020a056638388200b003c4cf9454a7mr4394149jav.0.1677689642274; Wed, 01 Mar
 2023 08:54:02 -0800 (PST)
Date:   Wed, 01 Mar 2023 08:54:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bd5ae05f5d98f4f@google.com>
Subject: [syzbot] [udf?] WARNING in __brelse (2)
From:   syzbot <syzbot+64d1c4bd2e3fa680321d@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    2ebd1fbb946d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=144829a8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3519974f3f27816d
dashboard link: https://syzkaller.appspot.com/bug?extid=64d1c4bd2e3fa680321d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16985cc7a274/disk-2ebd1fbb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd3452567115/vmlinux-2ebd1fbb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c75510922212/Image-2ebd1fbb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64d1c4bd2e3fa680321d@syzkaller.appspotmail.com

 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 1 PID: 13690 at fs/buffer.c:1145 __brelse+0x84/0xd8 fs/buffer.c:1145
Modules linked in:
CPU: 1 PID: 13690 Comm: syz-executor.1 Not tainted 6.2.0-syzkaller-18300-g2ebd1fbb946d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __brelse+0x84/0xd8 fs/buffer.c:1145
lr : __brelse+0x84/0xd8 fs/buffer.c:1145
sp : ffff8000222f7600
x29: ffff8000222f7600 x28: ffff8000222f7760 x27: ffff000130521080
x26: ffff8000222f77b0 x25: 1ffff0000445ef00 x24: ffff0000dd9088d0
x23: ffff70000445eed8 x22: 1ffff0000445eee4 x21: ffff00013fc33d98
x20: 0000000000000000 x19: ffff00013fc33df8 x18: 1fffe0003689f976
x17: ffff800015b8d000 x16: ffff80001235d16c x15: 0000000000000000
x14: 1ffff00002b720af x13: dfff800000000000 x12: 0000000000040000
x11: 0000000000016792 x10: ffff80001ffaa000 x9 : 93de21cc8eb3a600
x8 : 93de21cc8eb3a600 x7 : ffff800008288c58 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80000aae9f90
x2 : ffff0001b44fcf08 x1 : 0000000100000000 x0 : 0000000000000027
Call trace:
 __brelse+0x84/0xd8 fs/buffer.c:1145
 brelse include/linux/buffer_head.h:326 [inline]
 udf_rename+0xd1c/0x10b0 fs/udf/namei.c:1214
 vfs_rename+0x9e0/0xe80 fs/namei.c:4779
 do_renameat2+0x95c/0x100c fs/namei.c:4930
 __do_sys_renameat2 fs/namei.c:4963 [inline]
 __se_sys_renameat2 fs/namei.c:4960 [inline]
 __arm64_sys_renameat2+0xe0/0xfc fs/namei.c:4960
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 7128
hardirqs last  enabled at (7127): [<ffff800008288cf8>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1370 [inline]
hardirqs last  enabled at (7127): [<ffff800008288cf8>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5055
hardirqs last disabled at (7128): [<ffff800012358d60>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (7094): [<ffff800008020ea8>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (7094): [<ffff800008020ea8>] __do_softirq+0xd4c/0xfa4 kernel/softirq.c:600
softirqs last disabled at (7079): [<ffff80000802b4a4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
