Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0820401AD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhIFL6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbhIFL6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:58:00 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BCC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 04:56:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id a25so5362905vso.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYVrPklOjlZ/DTkf8/i1JKXm+JEBvWARosNS8hA3YFs=;
        b=KV0lnYFiWnxMYCucoCBbhkEgyniUMWkq/TEYXhZMxnyp+VzgevsuCdHAsBVbBFr4Dg
         zJ/7KSc3FIXxKFuSBpE1mB5h+aQY59cKGj2pvR0GobqjR5nEy384xtqSM2JSiNpgi9ih
         yeoKEvQPCla+Nvo+33sRmrqf2+LqpO+URR0AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYVrPklOjlZ/DTkf8/i1JKXm+JEBvWARosNS8hA3YFs=;
        b=FVGWzSfw6x4LRACmV3fhvpASMXfJZQ4Fq5KUWwgBxVd1MaMXcup1uJGDRs4Hf3Q6Q+
         aYMTP4LjRNaVwlxrW7US4lggz1Z+swsfrCqk1ZkLBvF49Rmdrw8mPBjEWX2aBWikEn/K
         7BCukLEmL2Miautk9eBwLvzH0RZSf9hS2lWhVj2BZEf/X4flsxevp7DzC6NASlEa1biO
         Euu1ZS+Uw7OLyeGnMk9W404E1OwzwFQwUecaHEeN86/MEhfSVQi3IwygIrz+z3cAL80y
         Jn7yXLhbR4oO1kh3jvQAp99Ye24hEwUhaC0zq47SE3MFLuE+fN/w14MCnLK4UNpPBf9A
         LWAg==
X-Gm-Message-State: AOAM531q+hXCGHeNdzCh2fT/lgln2oGUN9IVAWcvPfP6rWhI9Uo7ZYV1
        mvPhEJpbrWxVYelU9iltZ4VCKdY6i7X9zoU3nmu5ig==
X-Google-Smtp-Source: ABdhPJwvk2QKh2JoBN6aeD83bZV+fzXxq9brWOaTwYzX+mqhP2FWsTcpInJYEPFl9cC3XFqfNHelv4C9evyb+waiMTA=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr5704172vso.19.1630929414371;
 Mon, 06 Sep 2021 04:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bc92ac05cb4ead3e@google.com>
In-Reply-To: <000000000000bc92ac05cb4ead3e@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Sep 2021 13:56:43 +0200
Message-ID: <CAJfpeguqH3ukKeC9Rg66pUp_jWArn3rSBxkZozTVPmTnCf+d6g@mail.gmail.com>
Subject: Re: [syzbot] linux-next test error: KASAN: null-ptr-deref Read in fuse_conn_put
To:     syzbot <syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks,

Force pushed fixed commit 660585b56e63 ("fuse: wait for writepages in
syncfs") to fuse.git#for-next.

This is fixed as far as I'm concerned, not sure how to tell that to syzbot.

Thanks,
Miklos

On Mon, 6 Sept 2021 at 09:34, syzbot
<syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    14c6345e6e6c Add linux-next specific files for 20210903
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=164460ed300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c17400330d618d71
> dashboard link: https://syzkaller.appspot.com/bug?extid=b304e8cb713be5f9d4e1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> BUG: KASAN: null-ptr-deref in fuse_conn_put fs/fuse/inode.c:827 [inline]
> BUG: KASAN: null-ptr-deref in fuse_conn_put+0x1d7/0x300 fs/fuse/inode.c:814
> Read of size 4 at addr 0000000000000000 by task syz-fuzzer/6540
>
> CPU: 0 PID: 6540 Comm: syz-fuzzer Not tainted 5.14.0-next-20210903-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __kasan_report mm/kasan/report.c:446 [inline]
>  kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
>  fuse_conn_put fs/fuse/inode.c:827 [inline]
>  fuse_conn_put+0x1d7/0x300 fs/fuse/inode.c:814
>  fuse_dev_free+0x155/0x1f0 fs/fuse/inode.c:1324
>  fuse_dev_release+0x2a8/0x3f0 fs/fuse/dev.c:2205
>  __fput+0x288/0x9f0 fs/file_table.c:280
>  task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>  exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4af19b
> Code: fb ff eb bd e8 a6 b6 fb ff e9 61 ff ff ff cc e8 9b 82 fb ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> RSP: 002b:000000c0000ef430 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 000000c00001c000 RCX: 00000000004af19b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
> RBP: 000000c0000ef470 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000009
> R13: 0000000000000008 R14: 0000000000000200 R15: 000000c0003fe000
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
