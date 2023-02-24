Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA06A187D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 10:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBXJHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 04:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBXJHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:07:39 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011F1499F
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 01:07:37 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id u25-20020a5ec019000000b00733ef3dabe3so8280328iol.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 01:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHUVtxCupvvkNrRQBIJ1+156O8We7JNu+EhpPpItJds=;
        b=gpVZqvho3wJVDfKQWSHlsoITbGMhQ/Iw/We8mC6e05Hw77tTXAQZT9OSxmZO4JNj6Z
         q/btJDiZt50zCMQW4bhk1epMlvBAu8/+gSp2mS0P9QTByhv2FU0kWeM1jmvS+t7Gl6Lx
         ykI1mnGTEMwkPz6yc2uZES/6R47p60L6wBSbOkvxeZDgP+AMbpQXDwloJeoxLBfbZZdZ
         TD1Ks8DSpJ6O4+jd9iE6ZLYa7f5A0nD716dvbixgnE4csUvHqPcCbiAWq1qn8DNn8ehx
         5jX+Qqa1Z9Dh/VEViXiud5EFYOeF+DCHxUZZf7+d3VOa7D+4KM6TkaM8JLKQbCDrJZ6P
         JHAg==
X-Gm-Message-State: AO0yUKUUypmW2t+oaZdzbPTNoC10pEaqWlDNZaM/RHmtjE4q57H9ErzV
        oUhPFNKWi8bi3eMagAOZP7hFfrSL45p5Xo2KYLRCO6jgqHYj
X-Google-Smtp-Source: AK7set8w5MWjPG5BCMzkthD+cQ8RgWOjslO5UqnaPpoaPBDAkjmQArGXHZax730aNo+1wzfU0tcvtkbKDaewHnbxfc14ux1BZSoA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cb0:b0:30f:8b37:a8b6 with SMTP id
 16-20020a056e020cb000b0030f8b37a8b6mr4450629ilg.4.1677229657350; Fri, 24 Feb
 2023 01:07:37 -0800 (PST)
Date:   Fri, 24 Feb 2023 01:07:37 -0800
In-Reply-To: <000000000000c396f805ef112fd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eeebab05f56e7594@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_delete_cat
From:   syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    97e36f4aa06f Revert "sched/core: kmsan: do not instrument ..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1776cd44c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
dashboard link: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602e2acc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c73260c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9931a9627dc6/disk-97e36f4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aafdb2fd6dc/vmlinux-97e36f4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90df5872c7ff/bzImage-97e36f4a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ad4aeec6ed10/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_lookup+0x679/0xf20 fs/hfsplus/dir.c:83
 hfsplus_lookup+0x679/0xf20 fs/hfsplus/dir.c:83
 __lookup_slow+0x528/0x730 fs/namei.c:1685
 lookup_slow+0x6a/0xc0 fs/namei.c:1702
 walk_component+0x462/0x650 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0x27d/0x6f0 fs/namei.c:2474
 filename_lookup+0x250/0x800 fs/namei.c:2503
 user_path_at_empty+0x87/0x3a0 fs/namei.c:2876
 user_path_at include/linux/namei.h:57 [inline]
 path_setxattr+0x82/0x3f0 fs/xattr.c:645
 __do_sys_lsetxattr fs/xattr.c:673 [inline]
 __se_sys_lsetxattr fs/xattr.c:669 [inline]
 __ia32_sys_lsetxattr+0xed/0x170 fs/xattr.c:669
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f6/0xe90 mm/page_alloc.c:5572
 alloc_pages+0xab0/0xd80 mm/mempolicy.c:2287
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x425/0x15f0 mm/slub.c:2051
 ___slab_alloc+0x109c/0x32d0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x5fb/0xa50 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:3119 [inline]
 hfsplus_alloc_inode+0x5a/0xc0 fs/hfsplus/super.c:627
 alloc_inode+0x83/0x440 fs/inode.c:259
 iget_locked+0x2dd/0xe80 fs/inode.c:1286
 hfsplus_iget+0x63/0xb70 fs/hfsplus/super.c:64
 hfsplus_btree_open+0x13e/0x1d20 fs/hfsplus/btree.c:150
 hfsplus_fill_super+0x12bb/0x2a80 fs/hfsplus/super.c:473
 mount_bdev+0x50e/0x840 fs/super.c:1359
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
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

CPU: 1 PID: 5005 Comm: syz-executor236 Not tainted 6.2.0-syzkaller-81152-g97e36f4aa06f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
=====================================================

