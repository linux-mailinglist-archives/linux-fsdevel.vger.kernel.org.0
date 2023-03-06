Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E126ACBAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCFR5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCFR5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:57:36 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416976C68E
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 09:56:50 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so5624232iog.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 09:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbYPssxYw36RLyWTnT/f7ACds/3BmPm1HtAyqnW8PkQ=;
        b=ebvwX2YK94JGgTmJ07iakq1wdg9Ri2zouiHIWBm1LtrFwYtEw+2x/1zUvLIR5BKOxH
         v3/OHcam57rW+M7DvBLsgei8rc41uDSBBLnJTCsMAURuu5htySk5MX8OULI9vBnNL+ud
         d24QXIcG1mYy/ScZHoHg5JCbQFLxn0mWEG8SBa1Vx95tmClGL+XDE5wAbxh8C2CZajUh
         uC2RxyGxXalpledAeISM/X1q+UXW3VSpn3W3XO1rQHrSFqzKNbv5wZo7jqQ0TJ2Lm1Hm
         M7FYx1rab3orOAKp2w4pOCppOb42C/8BsmKCjCfWfQVRKujLfvmVuaQhVCX+iGvuOvLW
         jtxg==
X-Gm-Message-State: AO0yUKUdHInoL7gr1I+mNN2oLTbhX+Ta00L1RyRkkW8ospfIAD5FWRmk
        vfUyQhg9B0eifoSqh2liaAd5lJ7rKOHzs6NJYzpVAiUSc0Ad
X-Google-Smtp-Source: AK7set/NYf/xVRnSH5dF/+Q21oXrP2/XsfFtlq7ZLE6KVscS5BOGvLcxw7YJDt3L1dje1LwFwKc3ZmzjoN3S2RA6tvlKIXpLmgot
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1091:b0:315:459d:e6dd with SMTP id
 r17-20020a056e02109100b00315459de6ddmr5507955ilj.3.1678125344099; Mon, 06 Mar
 2023 09:55:44 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:55:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006176705f63f01b1@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_find_set_zero_bits
From:   syzbot <syzbot+773fa9d79b29bd8b6831@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
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

HEAD commit:    944070199c5e kmsan: add memsetXX tests
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11241922c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
dashboard link: https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14254554c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f1ed74c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e9f6063c80b/disk-94407019.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/249a6496ae21/vmlinux-94407019.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08b8d6e427f4/bzImage-94407019.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5de3b0f6cccb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+773fa9d79b29bd8b6831@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in hfs_find_set_zero_bits+0x836/0xc90 fs/hfs/bitmap.c:45
 hfs_find_set_zero_bits+0x836/0xc90 fs/hfs/bitmap.c:45
 hfs_vbm_search_free+0x141/0x530 fs/hfs/bitmap.c:151
 hfs_extend_file+0x6fc/0x1bf0 fs/hfs/extent.c:408
 hfs_get_block+0x400/0x1020 fs/hfs/extent.c:353
 __block_write_begin_int+0x6b1/0x2670 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0x143/0x450 fs/buffer.c:2102
 cont_write_begin+0xa64/0xe60 fs/buffer.c:2456
 hfs_write_begin+0x9a/0x130 fs/hfs/inode.c:58
 generic_perform_write+0x3f5/0xbf0 mm/filemap.c:3773
 __generic_file_write_iter+0x393/0x920 mm/filemap.c:3901
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:3933
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x834/0x1580 fs/read_write.c:584
 ksys_write+0x21f/0x4f0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __ia32_sys_write+0x91/0xd0 fs/read_write.c:646
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:766
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x518/0x920 mm/slub.c:3491
 kmalloc_trace+0x51/0x200 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 hfs_mdb_get+0x1c4e/0x29b0 fs/hfs/mdb.c:175
 hfs_fill_super+0x1d78/0x2460 fs/hfs/super.c:406
 mount_bdev+0x50e/0x840 fs/super.c:1359
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:610
 vfs_get_tree+0xa5/0x500 fs/super.c:1489
 do_new_mount+0x69a/0x1580 fs/namespace.c:3145
 path_mount+0x725/0x1ec0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3674
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 1 PID: 5030 Comm: syz-executor199 Not tainted 6.2.0-syzkaller-81157-g944070199c5e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
