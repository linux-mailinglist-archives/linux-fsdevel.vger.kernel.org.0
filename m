Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F940F82D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhIQMpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhIQMpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:45:14 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC9C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 05:43:52 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id k18-20020a4abd92000000b002915ed21fb8so3142298oop.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KejStfxhiCsHplAQELWZ08uhHE9dJ4tTOaKzETZDxAw=;
        b=WqUswL1XgMLBkCuFHs0Twr6vBshoPEV228DypEfdAq1Tn0U2z54RkoeibtiQEm3W9t
         7ijEf8xQWd86aPebGHFTrMExrt95opzMB6O9+IB+FNGMTQi6s9OEzNuxokOOHzsgTpIo
         SfDvNVDowqP9N+EqsvG3k3lhBHnZFRJFick9Oabpfb2PXkJFxFNSe1RW3wOhYI4rBX6K
         Eu/f1pvnTZyLczUdCc69ntBN5CwRleoR0Y1f5AoYJV4z1DAxZAIEGcXMMzzS5m5vdUkp
         aWAgZzfaP+LFauegcLGtI1MUPTk8SOhmIVAQwUMHwSV84iZj//tPd2/tPGSZo0qI4BAz
         950A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KejStfxhiCsHplAQELWZ08uhHE9dJ4tTOaKzETZDxAw=;
        b=7Xwkj+Le7qFufRVUMGT8XSa6wv+uRhi6IK/elYTOtQ/6JTXaMKEuFe5tqxB5t57rEP
         CO3mGJDVnzCQFrU2tZXH49Im3U+D0nrgAaJb5lzfC3y1FkuvcDBF2gjb45EGS5vlpUxH
         D0YSRKEkeBAt/nUx7Ueb6bEw3GGoyG5bozhAsJSpU60Dc+1Mp4DkR1L15lDsubhPQFZ5
         mhYP3HEU7OY3Lprh3s5CRqGRNQjxGOU6NDGaBCQXXi4vtuv4DMdKd1JyRRX1CJSxnyxz
         qAq4LrhZXuvoQIttSVSpdnLbgiYnTDlNlaVcYL55vXI6XTIO0rdaN9v20YBh5LgLGbsB
         Squg==
X-Gm-Message-State: AOAM530MdNrs+67IORKwo+cKFNpCs4Lak0dXPVzH6McJkxhs1xWYtpxf
        Hxw2QapmLb3AjjhBrvayuoxAWaRhXryNIu+q4Yr5Dx31+Ymmfg==
X-Google-Smtp-Source: ABdhPJxPysrnFU1B7kKgVysaACU8IQKKxfRQ30sgoPeYfegNc7+poI4p2pEhN26w+HyOa2k0YSuKVO+tuAB9G3yPkCI=
X-Received: by 2002:a4a:e792:: with SMTP id x18mr8797671oov.53.1631882631042;
 Fri, 17 Sep 2021 05:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d6b66705cb2fffd4@google.com> <CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com>
 <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
In-Reply-To: <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 14:43:39 +0200
Message-ID: <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: KFENCE: use-after-free in kvm_fastop_exception
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 17 Sept 2021 at 13:04, Marco Elver <elver@google.com> wrote:
> > On Sat, 4 Sept 2021 at 20:58, syzbot
> > <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1189fe49300000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a7a34dc082816f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=d08efd12a2905a344291
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6d/0x105b
> > >
> > > Use-after-free read at 0xffff88823bc0c020 (in kfence-#5):
> > >  kvm_fastop_exception+0xf6d/0x105b
> >
> > There is probably some bug in d_lookup, but there is also something
> > wrong with the unwinder. It prints an unrelated kvm_fastop_exception
> > frame instead of __d_lookup and interestingly a very similar thing
> > happens on arm64 with HWASAN and a similar bug in d_lookup. The
> > corresponding report is:
> > https://syzkaller.appspot.com/bug?extid=488ddf8087564d6de6e2
> >
> > BUG: KASAN: invalid-access in __entry_tramp_text_end+0xddc/0xd000
> > CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted
> > 5.14.0-syzkaller-11152-g78e709522d2c #0
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> >  dump_backtrace+0x0/0x1ac arch/arm64/kernel/stacktrace.c:76
> >  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:215
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
> >  print_address_description+0x7c/0x2b4 mm/kasan/report.c:256
> >  __kasan_report mm/kasan/report.c:442 [inline]
> >  kasan_report+0x134/0x380 mm/kasan/report.c:459
> >  __do_kernel_fault+0x128/0x1bc arch/arm64/mm/fault.c:317
> >  do_bad_area arch/arm64/mm/fault.c:466 [inline]
> >  do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:737
> >  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
> >  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
> >  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
> >  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
> >  __entry_tramp_text_end+0xddc/0xd000
> >  d_lookup+0x44/0x70 fs/dcache.c:2370
> >  lookup_dcache+0x24/0x84 fs/namei.c:1520
> >  __lookup_hash+0x24/0xd0 fs/namei.c:1543
> >  kern_path_locked+0x90/0x10c fs/namei.c:2567
> >  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
> >  handle drivers/base/devtmpfs.c:382 [inline]
> >  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
> >  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
> >  kthread+0x150/0x15c kernel/kthread.c:319
> >  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> >
> > Here kernel unwinder prints __entry_tramp_text_end instead of __d_lookup.
> >
> > I've looked in more detail into the arm64 case:
> > d_lookup contains a static call to __d_lookup as expected:
> >
> > ffff8000102e0780 <d_lookup>:
> > ...
> > ffff8000102e07c0: 97ffffa4 bl ffff8000102e0650 <__d_lookup>
> > ...
> > ffff8000102e07e8: d65f03c0 ret
> >
> > and these symbols don't overlap or something:
> >
> > $ aarch64-linux-gnu-nm -nS vmlinux | egrep -C 1 " (t|T)
> > (__entry_tramp_text|__d_lookup)"
> > ffff8000102e01f0 0000000000000458 T d_alloc_parallel
> > ffff8000102e0650 0000000000000128 T __d_lookup
> > ffff8000102e0780 000000000000006c T d_lookup
> > --
> > ffff8000117a1f88 T __hibernate_exit_text_end
> > ffff8000117a2000 T __entry_tramp_text_start
> > ffff8000117a2000 00000000000007c8 T tramp_vectors
> > --
> > ffff8000117a27f0 0000000000000024 T tramp_exit_compat
> > ffff8000117a3000 T __entry_tramp_text_end
> > ffff8000117b0000 D _etext
> >
> > So it looks like in both cases the top fault frame is just wrong. But
> > I would assume it's extracted by arch-dependent code, so it's
> > suspicious that it affects both x86 and arm64...
> >
> > Any ideas what's happening?
>
> My suspicion for the x86 case is that kvm_fastop_exception is related
> to instruction emulation and the fault occurs in an emulated
> instruction?

Why would the kernel emulate a plain MOV?
2a:   4c 8b 21                mov    (%rcx),%r12

And it would also mean a broken unwind because the emulated
instruction is in __d_lookup, so it should be in the stack trace.

> But I can't explain the arm64 case.
>
> > >  d_lookup+0xd8/0x170 fs/dcache.c:2370
> > >  lookup_dcache+0x1e/0x130 fs/namei.c:1520
> > >  __lookup_hash+0x29/0x180 fs/namei.c:1543
> > >  kern_path_locked+0x17e/0x320 fs/namei.c:2567
> > >  handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
> > >  handle drivers/base/devtmpfs.c:382 [inline]
> > >  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
> > >  devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
> > >  kthread+0x3e5/0x4d0 kernel/kthread.c:319
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > >
> > > kfence-#5 [0xffff88823bc0c000-0xffff88823bc0cfff, size=4096, cache=names_cache] allocated by task 22:
> > >  getname_kernel+0x4e/0x370 fs/namei.c:226
> > >  kern_path_locked+0x71/0x320 fs/namei.c:2558
> > >  handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
> > >  handle drivers/base/devtmpfs.c:382 [inline]
> > >  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
> > >  devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
> > >  kthread+0x3e5/0x4d0 kernel/kthread.c:319
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > >
> > > freed by task 22:
> > >  putname.part.0+0xe1/0x120 fs/namei.c:270
> > >  putname include/linux/err.h:41 [inline]
> > >  filename_parentat fs/namei.c:2547 [inline]
> > >  kern_path_locked+0xc2/0x320 fs/namei.c:2558
> > >  handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
> > >  handle drivers/base/devtmpfs.c:382 [inline]
> > >  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
> > >  devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
> > >  kthread+0x3e5/0x4d0 kernel/kthread.c:319
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > >
> > > CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > RIP: 0010:kvm_fastop_exception+0xf6d/0x105b
> > > Code: d3 ed e9 14 1b 6d f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 6a 28 6d f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 5a 32 6d f8 bd
> > > RSP: 0018:ffffc90000fe7ae8 EFLAGS: 00010282
> > > RAX: 0000000035736376 RBX: ffff88803b141cc0 RCX: ffff88823bc0c020
> > > RDX: ffffed100762839f RSI: 0000000000000004 RDI: 0000000000000007
> > > RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88803b141cf0
> > > R10: ffffed100762839e R11: 0000000000000000 R12: ffff88823bc0c020
> > > R13: ffff88823bc0c020 R14: ffff88803b141cf0 R15: dffffc0000000000
> > > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffff88823bc0c020 CR3: 0000000029892000 CR4: 00000000001506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  d_lookup+0xd8/0x170 fs/dcache.c:2370
> > >  lookup_dcache+0x1e/0x130 fs/namei.c:1520
> > >  __lookup_hash+0x29/0x180 fs/namei.c:1543
> > >  kern_path_locked+0x17e/0x320 fs/namei.c:2567
> > >  handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
> > >  handle drivers/base/devtmpfs.c:382 [inline]
> > >  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
> > >  devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
> > >  kthread+0x3e5/0x4d0 kernel/kthread.c:319
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > > ==================================================================
> > > ----------------
> > > Code disassembly (best guess):
> > >    0:   d3 ed                   shr    %cl,%ebp
> > >    2:   e9 14 1b 6d f8          jmpq   0xf86d1b1b
> > >    7:   49 8d 0e                lea    (%r14),%rcx
> > >    a:   48 83 e1 f8             and    $0xfffffffffffffff8,%rcx
> > >    e:   4c 8b 21                mov    (%rcx),%r12
> > >   11:   41 8d 0e                lea    (%r14),%ecx
> > >   14:   83 e1 07                and    $0x7,%ecx
> > >   17:   c1 e1 03                shl    $0x3,%ecx
> > >   1a:   49 d3 ec                shr    %cl,%r12
> > >   1d:   e9 6a 28 6d f8          jmpq   0xf86d288c
> > >   22:   49 8d 4d 00             lea    0x0(%r13),%rcx
> > >   26:   48 83 e1 f8             and    $0xfffffffffffffff8,%rcx
> > > * 2a:   4c 8b 21                mov    (%rcx),%r12 <-- trapping instruction
> > >   2d:   41 8d 4d 00             lea    0x0(%r13),%ecx
> > >   31:   83 e1 07                and    $0x7,%ecx
> > >   34:   c1 e1 03                shl    $0x3,%ecx
> > >   37:   49 d3 ec                shr    %cl,%r12
> > >   3a:   e9 5a 32 6d f8          jmpq   0xf86d3299
> > >   3f:   bd                      .byte 0xbd
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
