Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7C77137E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 05:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHFDsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 23:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFDsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 23:48:18 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A31A4
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Aug 2023 20:48:14 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1b07f5f7b96so4442928fac.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Aug 2023 20:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691293694; x=1691898494;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB4gpVz6vQvvB5Ahs4Wq4tMlzZ/RoWcGtm3MYPcmhhY=;
        b=YAY2M17Y1DwYzUI1xIp11N7LGmKkX3Jkp2fzVdmSty6qZEJcV3/qGKwMt2sY9NWpZi
         wbeqRF23aEktmQrC7S5QG6XYIRFc8Gtg1hRBzIZ/MDKEWH1oHsVofFgaXWH5zqoiHc7D
         /nuydJ3D2W3k3HCTfIPMkQaifT4wByVETjn2DQN6dWhllBkqAY6aqU6EoGG4T1kyrfX1
         FrkTrcpuAfZmvzTjyGqjYc0mSm652mXtcVPbzLdIivjp6ZB9kRK/FqeQDBlyRQfmI6v5
         fNKoRq3Wf2ixYfHZMcI+Hm/aXcwPKO/6PTpPerpL1rVwzUFzmCSu5cIgTAvCBxeZACt3
         6V4w==
X-Gm-Message-State: AOJu0YxwSAinPgCDlr6Uy073vsJdCZFLc8Rlbhrlut8dp6ZsQg6kSZPl
        aBliAIhjI2iJ3bf7CyykuriQ7ZgI+T8vsKnsOuBAf49UuR+y
X-Google-Smtp-Source: AGHT+IF84rMYuKEpjvcKfw0hIDa3OM5O68THUCnEz7dr3qveFUpkwl1FiLF+mPZuJZcoJZEmj+tFk8/ej93IsohxM+HA1mWd38uG
MIME-Version: 1.0
X-Received: by 2002:a05:6870:956a:b0:1b0:2eab:e7e2 with SMTP id
 v42-20020a056870956a00b001b02eabe7e2mr5975049oal.0.1691293694010; Sat, 05 Aug
 2023 20:48:14 -0700 (PDT)
Date:   Sat, 05 Aug 2023 20:48:13 -0700
In-Reply-To: <00000000000040e14205ffbf333f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7ae72060238ff24@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (2)
From:   syzbot <syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    86d7896480b0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7a295a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21762bc8221a1ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2f934f08ab03d473ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f0b171a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129e5713a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/136ba9602d1f/disk-86d78964.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcd3ab5ec39d/vmlinux-86d78964.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3041f85d1a44/Image-86d78964.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/02dc44470901/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com

 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Not tainted 6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c4b x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e0296278 x24: ffff0000e02961e0
x23: ffff0000e0296258 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e0296240 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 20656
hardirqs last  enabled at (20655): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (20655): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (20656): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (19642): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (19642): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (19633): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c57 x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e02962d8 x24: ffff0000e02961e0
x23: ffff0000e02962b8 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e02962a0 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 21126
hardirqs last  enabled at (21125): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (21125): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (21126): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (20772): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (20772): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (20659): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c63 x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e0296338 x24: ffff0000e02961e0
x23: ffff0000e0296318 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e0296300 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 21568
hardirqs last  enabled at (21567): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (21567): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (21568): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (21214): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (21214): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (21129): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c6f x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e0296398 x24: ffff0000e02961e0
x23: ffff0000e0296378 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e0296360 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 21948
hardirqs last  enabled at (21947): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (21947): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (21948): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (21584): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (21584): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (21571): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c7b x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e02963f8 x24: ffff0000e02961e0
x23: ffff0000e02963d8 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e02963c0 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 22332
hardirqs last  enabled at (22331): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (22331): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (22332): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (21958): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (21958): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (21951): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c87 x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e0296458 x24: ffff0000e02961e0
x23: ffff0000e0296438 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e0296420 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 22732
hardirqs last  enabled at (22731): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (22731): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (22732): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (22354): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (22354): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (22335): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c93 x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e02964b8 x24: ffff0000e02961e0
x23: ffff0000e0296498 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e0296480 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 000000008a56c67c x13: 0000000071fb52ff x12: 00000000a7effed4
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000001
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x134/0x310 fs/ntfs3/fsntfs.c:2485
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 23126
hardirqs last  enabled at (23125): [<ffff800080b723d4>] lookup_bh_lru fs/buffer.c:1403 [inline]
hardirqs last  enabled at (23125): [<ffff800080b723d4>] __find_get_block+0x1a0/0xd18 fs/buffer.c:1415
hardirqs last disabled at (23126): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (22744): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (22744): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (22735): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5986 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 5986 Comm: syz-executor496 Tainted: G        W          6.5.0-rc4-syzkaller-g86d7896480b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
lr : wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
sp : ffff8000969a71e0
x29: ffff8000969a7210 x28: 1fffe0001c052c9f x27: dfff800000000000
x26: dfff800000000000 x25: ffff0000e0296518 x24: ffff0000e02961e0
x23: ffff0000e02964f8 x22: 00000000000001e7 x21: ffff0000dbdae2d0
x20: ffff0000e02964e0 x19: 00000000000001e7 x18: 1fffe0003683adc6
x17: 0000000000000000 x16: ffff80008a57089c x15: 0000000000000001
x14: 1ffff00011d18abf x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c583d340 x7 : 0000000000000000 x6 : ffff800080063870
x5 : ffff0000d477e9c8 x4 : 0000000000000000 x3 : 0000000000000000
x2 : ffffffffffffffc0 x1 : 00000000000001e7 x0 : 00000000000001e7
Call trace:
 wnd_add_free_ext+0x9b0/0xc00 fs/ntfs3/bitmap.c:351
 wnd_set_free+0x570/0x5cc fs/ntfs3/bitmap.c:749
 mark_as_free_ex+0x1c8/0x310 fs/ntfs3/fsntfs.c:2495
 run_deallocate_ex+0x1e0/0x4ac fs/ntfs3/attrib.c:122
 attr_set_size+0x1128/0x342c fs/ntfs3/attrib.c:750
 ntfs_truncate fs/ntfs3/file.c:393 [inline]
 ntfs3_setattr+0x424/0x8fc fs/ntfs3/file.c:682
 notify_change+0xa84/0xd20 fs/attr.c:483
 do_truncate+0x1c0/0x28c fs/open.c:66
 vfs_truncate+0x2b8/0x360 fs/open.c:112
 do_sys_truncate+0xec/0x1b4 fs/open.c:135
 __do_sys_truncate fs/open.c:147 [inline]
 __se_sys_truncate fs/open.c:145 [inline]
 __arm64_sys_truncate+0x5c/0x70 fs/open.c:145
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 23528
hardirqs last  enabled at (23527): [<ffff80008a65a7c0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (23527): [<ffff80008a65a7c0>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (23528): [<ffff80008a56c1dc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (23142): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (23142): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (23129): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
