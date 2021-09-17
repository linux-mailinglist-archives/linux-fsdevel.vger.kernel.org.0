Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8B40FB0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbhIQPFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbhIQPFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:05:23 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E934C061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 08:04:01 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n2-20020a9d6f02000000b0054455dae485so7986260otq.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvWD6tRz6SqO3YvI8jw52v5kCnXKnSUnvz5w+Nfi/zQ=;
        b=FkjiXe5GkL5dkj/gMOunrEtFEP4TOPpK7oF3hdhKabNv8nwfb2ICOm0YZraXO0FyvE
         wjEGImhJmAH0xaBwLJF3sySewmq0qy0KqurC6dm+0AnSYfHbapsn3AjwoOBDHVLLTifx
         YftPj2+x8S2xOd7frOrMv7Zmqn7CA96seV9wUju+WEpGrB199mO2HXIG2/I5kcNfcWqg
         6DMpDViwaEFmRCPLX1H04o/ujM/NTN2DEmfT2hcaVgqCP6Izh8WeWlHuGStaUac2/hV7
         68QtQwIfIcFFdVtnIrI9hOSRMoTzQTuhc0x/4cWGghxRDIXbB27H7cQG+aXyCSHMjIs+
         vfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvWD6tRz6SqO3YvI8jw52v5kCnXKnSUnvz5w+Nfi/zQ=;
        b=8L9lm5dqgCCylOM9O+LR8VeOfE4/IEcm5SgN74sj1ho1UL5f2wgNWp9eKbCHo9Q5gZ
         Pd6MozmbPTIEZUqfE2TPMw+s2Aa3mjIqHre9wnLqbbYcyyla9owX2Lsi0N85DjHnHxFj
         Ve2vvOc11lyfIMjRsOQyGC0oHi1lHudhVH7goFL9OnRjdJ3D8lqT9TJkA0xplCPySwCI
         VJmllkjvRHnEQdzEdA8TZZ5cAHGSFmj4e/TshRt98XFeoIyBrlsWIQnzP6jq6e91zPuc
         qzyYF5iM2l752w3UiMvTXzRbQy+JY8u3z1TXDcc57H+wHzRl8cHZ23z5aMbWYhLX7Ssk
         32Ew==
X-Gm-Message-State: AOAM531Y0hOgN7fETNKNJfDMNY4OGuKaboGjk8/IlWNp+yphKq5/kloA
        dfTfZWVrQyJxrg9qMtvEP586LaA43pzYlOi1XfTabsKaey0T7Q==
X-Google-Smtp-Source: ABdhPJz/oqxxUmuZRL3ol7/kbbP9ZgVy4475wZzhnOzb49MEi8I5MPLx9tIFCN8PFUN0a/GOFganYtcnzTY0gN9qakY=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr10198759otk.137.1631891040373;
 Fri, 17 Sep 2021 08:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a3cf8605cb2a1ec0@google.com>
In-Reply-To: <000000000000a3cf8605cb2a1ec0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 17:03:48 +0200
Message-ID: <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in __entry_tramp_text_end
To:     syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 4 Sept 2021 at 13:57, syzbot
<syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f1583cb1be35 Merge tag 'linux-kselftest-next-5.15-rc1' of ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16354043300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe535c85e8d7384
> dashboard link: https://syzkaller.appspot.com/bug?extid=488ddf8087564d6de6e2
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> userspace arch: arm64
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: invalid-access in __entry_tramp_text_end+0xdfc/0x3000
> Read at addr f4ff000002a361a0 by task kdevtmpfs/22
> Pointer tag: [f4], memory tag: [fe]
>
> CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x1ac arch/arm64/kernel/stacktrace.c:76
>  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:215
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:105
>  print_address_description+0x7c/0x2b4 mm/kasan/report.c:256
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report+0x134/0x380 mm/kasan/report.c:459
>  __do_kernel_fault+0x128/0x1bc arch/arm64/mm/fault.c:317
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:737
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000

/\/\/\/\/\/\/\

This is broken unwind on arm64. d_lookup statically calls __d_lookup,
not __entry_tramp_text_end (which is not even a function).
See the following thread for some debugging details:
https://lore.kernel.org/lkml/CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com/

But there is also the use-after-free in d_lookup.

>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
>
> Allocated by task 22:
>  kasan_save_stack+0x28/0x60 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:434 [inline]
>  __kasan_slab_alloc+0xb0/0x110 mm/kasan/common.c:467
>  kasan_slab_alloc include/linux/kasan.h:254 [inline]
>  slab_post_alloc_hook mm/slab.h:519 [inline]
>  slab_alloc_node mm/slub.c:2959 [inline]
>  slab_alloc mm/slub.c:2967 [inline]
>  kmem_cache_alloc+0x1cc/0x340 mm/slub.c:2972
>  getname_kernel+0x30/0x150 fs/namei.c:226
>  kern_path_locked+0x2c/0x10c fs/namei.c:2558
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
>
> Freed by task 22:
>  kasan_save_stack+0x28/0x60 mm/kasan/common.c:38
>  kasan_set_track+0x28/0x3c mm/kasan/common.c:46
>  kasan_set_free_info+0x20/0x30 mm/kasan/tags.c:36
>  ____kasan_slab_free.constprop.0+0x178/0x1e0 mm/kasan/common.c:366
>  __kasan_slab_free+0x10/0x1c mm/kasan/common.c:374
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  slab_free_hook mm/slub.c:1628 [inline]
>  slab_free_freelist_hook+0xc4/0x20c mm/slub.c:1653
>  slab_free mm/slub.c:3213 [inline]
>  kmem_cache_free+0x9c/0x420 mm/slub.c:3229
>  putname.part.0+0x68/0x7c fs/namei.c:270
>  putname include/linux/err.h:41 [inline]
>  filename_parentat fs/namei.c:2547 [inline]
>  kern_path_locked+0x64/0x10c fs/namei.c:2558
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
>
> The buggy address belongs to the object at ffff000002a36180
>  which belongs to the cache names_cache of size 4096
> The buggy address is located 32 bytes inside of
>  4096-byte region [ffff000002a36180, ffff000002a37180)
> The buggy address belongs to the page:
> page:00000000a105b3ae refcount:1 mapcount:0 mapping:0000000000000000 index:0xf3ff000002a34100 pfn:0x42a30
> head:00000000a105b3ae order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x1ffc00000010200(slab|head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
> raw: 01ffc00000010200 0000000000000000 dead000000000122 faff000002837700
> raw: f3ff000002a34100 0000000080070003 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000002a35f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff000002a36000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >ffff000002a36100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                                  ^
>  ffff000002a36200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff000002a36300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> ==================================================================
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
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a3cf8605cb2a1ec0%40google.com.
