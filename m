Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFF0530F58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiEWLe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiEWLe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 07:34:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1449450060
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 04:34:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p22so25016752lfo.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slD5U1ZLnnag5uUVMq6zG3O9jXp6ALF6Xo5AefMCVo0=;
        b=IuRH6f/Obr2igym8Ti8sMm17ajhPbUTDUiE9pRzlr+h4rTfNFOullaOn8biUcCT8zi
         3fNxPioOwEhs99nNTnPwlC/c37Z808CFcYI8VQidEbjL5fRtQWlIzrsrH9kEyiagjZwf
         3x23eUWPptUQ8yjPDkJyxwLluUM9TAaWaJVd4BbX03WKz4/axhvCeoZF45+1mSk86tRT
         GuZ0NcHgTKsyiXsM6QZHuW9RVx5BDo9nHHbGD6RoVkpyhOSG9m8OZhP6wgN+77BLF1Nr
         tGcnhNoB2DqFfpVGNlfRKhjH0icCTWQc3jeEMs9sxtRe5Y2Ju5WR0NNx1KwE/sk8R3pZ
         aTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slD5U1ZLnnag5uUVMq6zG3O9jXp6ALF6Xo5AefMCVo0=;
        b=exu9q11Agft9JxfFK30oBUT9gQ9e8WANUFK7sNNZI602NzzZvOutjrlSeUAcxD5OKx
         M9meIE6XRaTN8MBeYeQoTQN6gIDnWNbHvwrAlLX7MP+dh2SIHhYI3gjvIoI8xKu0c3fz
         9tSN7HfA96kGeOIBCyTvvMCRMfgPfVWnHuiT2fu3LAtcVvT6AGlUWdTYKGsWQJtjnGli
         Nz6xUGyyElrl6/0e62w6YOBosVgiMr4F1COGM+v4wQP8S11Yu+XsXycGtQoHgZ9KqVwc
         YQ+43SowFapTVlaLA8xQbnfy+4pfoXjDK5Q8PSoTcKsvvZUCErEVzXKjnm5oXE2J+zTI
         Eeog==
X-Gm-Message-State: AOAM531xPXU6GCHo6mrmxH7ru+ITom6rCQIZYLpUigug6/aIjUFqfCSI
        q+1C9DrwZoSIRFvGrREU7iOExiL9Z8FRGzrvpMbdeQ==
X-Google-Smtp-Source: ABdhPJyufZJzKrPyGHXvClU64clAc39hLWJmhquE5y3mgrP5ttLdjp0w7qfRQXK3RMJusjaqeQt9hMbByNRsDo5gNLQ=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr15901781lfb.376.1653305675107; Mon, 23
 May 2022 04:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000032992d05d370f75f@google.com> <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org> <20211221090804.1810-1-hdanton@sina.com>
 <20211222022527.1880-1-hdanton@sina.com> <YcKrHc11B/2tcfRS@mit.edu>
 <CACT4Y+YHxkL5aAgd4wXPe-J+RG6_VBcPs=e8QpRM8=3KJe+GCg@mail.gmail.com> <YogL6MCdYVrqGcRf@mit.edu>
In-Reply-To: <YogL6MCdYVrqGcRf@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 May 2022 13:34:23 +0200
Message-ID: <CACT4Y+ZHCawp__HvJAFPXp+z6XdiVEgwrh8dvDR+cDfQywr20w@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 20 May 2022 at 23:45, Theodore Ts'o <tytso@mit.edu> wrote:
> > Hi Ted,
> >
> > Reviving this old thread re syzkaller using SCHED_FIFO.
> >
> > It's a bit hard to restrict what the fuzzer can do if we give it
> > sched_setattr() and friends syscalls. We could remove them from the
> > fuzzer entirely, but it's probably suboptimal as well.
> >
> > I see that setting up SCHED_FIFO is guarded by CAP_SYS_NICE:
> > https://elixir.bootlin.com/linux/v5.18-rc7/source/kernel/sched/core.c#L7264
> >
> > And I see we drop CAP_SYS_NICE from the fuzzer process since 2019
> > (after a similar discussion):
> > https://github.com/google/syzkaller/commit/f3ad68446455a
> >
> > The latest C reproducer contains: ....
>
> For this particular report, there *was* no C reproducer.  There was
> only a syz reproducer:

Yes, but the same logic should have been used. I just showed the
excerpt from the C reproducer b/c maybe there is something wrong with
that CAP_SYS_NICE logic.

> > syzbot found the following issue on:
> >
> > HEAD commit:    5472f14a3742 Merge tag 'for_linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11132113b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e3bdfd29b408d1b6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9c3fb12e9128b6e1d7eb
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14559113b00000
>
> So let me ask a counter question.  I thought syzbot tries to create a
> minimal reproducer?  So if the sched_setattr is a no-op, and is
> returning EPERM, why wasn't the sched_setattr line removed from the
> syz repro?

Two most common reasons would be (1) flaky reproduction, then each
minimization step can falsely decide that something is needed to
reproduce the bug b/c when we remove it, the crash does not reproduce;
(2) previously order/number of syscalls affected what syscalls are
executed concurrently to provoke races, so removing one syscall could
affect how subsequent syscalls are collided (this is not the case
anymore, but was the case when this bug was reported).


> As a side note, since in many cases running a reproducer can be
> painful, would it be possible for the syzkiller dashboard to provide
> the output of running "strace -f" while the reproducer is running?
>
> That would also especially help since even when there is a C
> reproducer, trying to understand what it is doing from reading the
> syzbot-generated C source code is often non-trivial, and strace does a
> much better job decoding what the !@#?@ the reproducer.  Another
> advantage of using strace is that it will also show us the return code
> from the system call, which would very quickly confirm whether the
> sched_setattr() was actually returning EPERM or not --- and it will
> decode the system call arguments in a way that I often wished would be
> included as comments in the syzbot-generated reproducer.
>
> Providing the strace output could significantly reduce the amount of
> upstream developer toil, and might therefore improve upstream
> developer engagement with syzkaller.

+Aleksandr added this feature recently.

Console output will contain strace output for reproducers (when the
run under strace reproduced the same kernel crash as w/o strace).

Here is a recently reported bug:
https://syzkaller.appspot.com/bug?id=53c9bd2ca0e16936e45ff1333a22b838d91da0a2

"log" link for the reproducer crash shows:
https://syzkaller.appspot.com/text?tag=CrashLog&x=14f791aef00000
...

[   26.757008][ T3179] 8021q: adding VLAN 0 to HW filter on device bond0
[   26.766878][ T3179] eql: remember to turn off Van-Jacobson
compression on your slave devices
Starting sshd: OK
Warning: Permanently added '10.128.0.110' (ECDSA) to the list of known hosts.
execve("./syz-executor1865045535", ["./syz-executor1865045535"],
0x7ffdc91edf40 /* 10 vars */) = 0
brk(NULL)                               = 0x555557248000
brk(0x555557248c40)                     = 0x555557248c40
arch_prctl(ARCH_SET_FS, 0x555557248300) = 0
uname({sysname="Linux", nodename="syzkaller", ...}) = 0
readlink("/proc/self/exe", "/root/syz-executor1865045535", 4096) = 28
brk(0x555557269c40)                     = 0x555557269c40
brk(0x55555726a000)                     = 0x55555726a000
mprotect(0x7f37f8ecc000, 16384, PROT_READ) = 0
mmap(0x1ffff000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS,
-1, 0) = 0x1ffff000
mmap(0x20000000, 16777216, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000
mmap(0x21000000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS,
-1, 0) = 0x21000000
socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER) = 3
syzkaller login: [   58.834018][ T3600] ------------[ cut here ]------------
[   58.839772][ T3600] WARNING: CPU: 0 PID: 3600 at
net/netfilter/nfnetlink.c:703 nfnetlink_unbind+0x357/0x3b0
[   58.849856][ T3600] Modules linked in:
...


The same is available in the report emails, e.g.:
https://lore.kernel.org/all/000000000000ff239c05df391402@google.com/
...
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14f791aef00000
...
