Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4C63BDBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 11:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiK2KNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 05:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiK2KNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:13:25 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702FE5E3FE
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 02:11:55 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso8102305iox.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 02:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iikjYtuzyzNaBl0Fr5aqej9XCVNGzLadGpq6TZMWYlA=;
        b=2gdmnRolibq9/LnvFq3FQEPQPvzyBGO5ltDMvmENofOhaJVfKeB0qf3E75QPaYHKof
         rHwguQgMrOQGonlT3jsN1wVpADAmu2IGJAs81Oe1yZ0YQFn3YN6YWzufsyXNMOX50DTY
         5a3X9FPxxAl7xoIplZ2POSBsvKAjJs/oKyqvo5L6Fxty+Vzrer2XLHQ+l+4k7oQzviBM
         onJd4q0NdYhO0e15mIbRx/WWHx9iTp1m/Qav1n6j4ES1IjW9MfTIiR+Ueku+bICyrzkQ
         SQif7F+9JMg9dXge/kj9LXITAHW54FzF6P6lD8rD1nGvLLFJfY181YsEf0M8Ivlytf03
         37ig==
X-Gm-Message-State: ANoB5pmsKPl4cXwYeZG9mFWfia0LEbqMageJtapc8R1P3kBVvOW98hiZ
        p9eweYX/lo4ZtBRKjZlgQrLfoTDNBxOhk5mh3Qw26jBt+CaU
X-Google-Smtp-Source: AA0mqf5twLoO/cP7GFkVWO66txAHHbqxKZev2FPt8SHeJLpZVIiATU6gKONpHYvEaC0BC5JxKpyIy2nRLwgjTS0YOUnHng+SIq0n
MIME-Version: 1.0
X-Received: by 2002:a02:600d:0:b0:375:fc9a:4d78 with SMTP id
 i13-20020a02600d000000b00375fc9a4d78mr19905740jac.194.1669716705316; Tue, 29
 Nov 2022 02:11:45 -0800 (PST)
Date:   Tue, 29 Nov 2022 02:11:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001897ea05ee9937c0@google.com>
Subject: [syzbot] INFO: trying to register non-static key in hfsplus_release_folio
From:   syzbot <syzbot+91db21a2bf0e12eb92fd@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=124d67c3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=91db21a2bf0e12eb92fd
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170746ad880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149dfd75880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6bdbba5eb556/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91db21a2bf0e12eb92fd@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 3072 Comm: syz-executor123 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:981
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1294
 __lock_acquire+0xa8/0x3084 kernel/locking/lockdep.c:4934
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 hfsplus_release_folio+0x12c/0x214 fs/hfsplus/inode.c:110
 filemap_release_folio+0xc0/0x238 mm/filemap.c:3948
 block_invalidate_folio+0x1f4/0x3c4 fs/buffer.c:1526
 folio_invalidate mm/truncate.c:159 [inline]
 truncate_cleanup_folio+0xd4/0x334 mm/truncate.c:179
 truncate_inode_pages_range+0x148/0xb8c mm/truncate.c:369
 truncate_inode_pages mm/truncate.c:452 [inline]
 truncate_inode_pages_final+0x8c/0x9c mm/truncate.c:487
 hfsplus_evict_inode+0x20/0x68 fs/hfsplus/super.c:168
 evict+0xec/0x334 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x2c4/0x324 fs/inode.c:1773
 hfsplus_put_super+0xb4/0xec fs/hfsplus/super.c:302
 generic_shutdown_super+0x94/0x198 fs/super.c:492
 kill_block_super+0x30/0x78 fs/super.c:1428
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
hfsplus: request for non-existent node 0 in B*Tree


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
