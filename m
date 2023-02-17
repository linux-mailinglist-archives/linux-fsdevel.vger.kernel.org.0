Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C569A3A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 02:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBQB4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 20:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQB4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:56:53 -0500
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD554D3A
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 17:56:52 -0800 (PST)
Received: by mail-io1-f80.google.com with SMTP id b10-20020a5ea70a000000b0071a96a509a7so2055598iod.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 17:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISU7/1DjKHh9fexdII7McIn/QS4zcm5Oor+4ZtCR53I=;
        b=D4bKdzU3YS9qztHy1lsv8iM3BEcboi6PYvT75HSMCSExgA1esLqfuJjjvCzydo9dxr
         PPnBCrZ7wIhtRTnf3XcXE3zo/01xH4JlPes0jOBO5Fub+qwYsyd2GzjNCoWkkc7FVB30
         64QTH3rhrl7ZmhA5UWmizsCTYToo2NqrojX0qSEVDgYgNfKeqZctdo61Z3+y695J/5HD
         3Z/IH1hbWB4Vv3Z2ncalGIAwSyHTTRHktr8O/Cwnv7byGYXu+2Wdd8VmYBJMLFfpGXBy
         bycP1v4AsURee1aWYqsIn9Qmqvo9fGcPfHMfsMeMbUNnCPhfM8RJNag7NbcCqtFf04Aa
         6zsA==
X-Gm-Message-State: AO0yUKVnzQMNzfTEDtotnRJxeQOQDnSyDrrhIkeyjaBU+YPN4odDJtSG
        Qy3ae5z72CBS5BFyyAolx0CcokMVyRqxFCgUKhft8Smi5bolxhBjQQ==
X-Google-Smtp-Source: AK7set8axkVHs4GrDeozxnytwgK4QumRQj4cbEg1tcE5vpxCqqzDm02l4wVnbBziW92X8gPIXqzenaQIiTAcZx1hfybN3o5OIxo6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:bf3:b0:313:f6fa:bc50 with SMTP id
 d19-20020a056e020bf300b00313f6fabc50mr2189182ilu.5.1676599011921; Thu, 16 Feb
 2023 17:56:51 -0800 (PST)
Date:   Thu, 16 Feb 2023 17:56:51 -0800
In-Reply-To: <00000000000000040a05e714f000@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008955d005f4dba008@google.com>
Subject: Re: [syzbot] [reiserfs?] WARNING in reiserfs_readdir_inode
From:   syzbot <syzbot+798ffe5fe3e88235db59@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2d3827b3f393 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb7f2b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606ed7eeab569393
dashboard link: https://syzkaller.appspot.com/bug?extid=798ffe5fe3e88235db59
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150829d7480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff04ab480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd94d68ff17d/disk-2d3827b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f304fbef0773/vmlinux-2d3827b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74eb318f51b0/Image-2d3827b3.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/37f569d9f961/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/0cd68cef0305/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+798ffe5fe3e88235db59@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 4421 at kernel/locking/mutex.c:582 __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 4421 Comm: syz-executor270 Not tainted 6.2.0-rc7-syzkaller-17907-g2d3827b3f393 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
sp : ffff80000ff739e0
x29: ffff80000ff73a50 x28: ffff80000eeb4000 x27: 0000000000000000

x26: 0000000000000000 x25: ffff800008748194 x24: 0000000000000002
x23: ffff800008771cc4 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000c7bf7828 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: ffff0000c3a31a00
x11: ff808000081bbb4c x10: 0000000000000000 x9 : f02dd3de9c24e500
x8 : f02dd3de9c24e500 x7 : 4e5241575f534b43 x6 : ffff80000bf650d4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_readdir_inode+0x9c/0x660 fs/reiserfs/dir.c:79
 reiserfs_readdir+0x28/0x38 fs/reiserfs/dir.c:274
 iterate_dir+0x114/0x28c
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __arm64_sys_getdents64+0x80/0x204 fs/readdir.c:354
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x64/0x178 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0xbc/0x180 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x110 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 24433
hardirqs last  enabled at (24433): [<ffff800008039178>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (24433): [<ffff800008039178>] el0_svc_common+0x40/0x180 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (24432): [<ffff80000bf55074>] el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
softirqs last  enabled at (24376): [<ffff80000801c878>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (24374): [<ffff80000801c844>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---

