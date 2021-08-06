Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898513E306E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 22:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhHFUkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 16:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231572AbhHFUkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628282394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJ1NbDgyUix6sI0pu10YegsxYaaQe+q9Ty47N33Bk3U=;
        b=DNGqHT5Oc0u9SWe/wJGKxfFVK2/soHFhX7bOp9B/a0ag90kW2V64JlKvr+iRcAplFUBYzJ
        ZCwSjTLhdH3/ept7Xl9nW/AnQkCf+T7AeSnpA7L15dr92++kSgKHEZl5Y8vZRKvfJSCtdH
        ecQecTNiEF+uVuf7dijo5W6F96LiMvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-9SwcBtbyMGCEmXHajixaXA-1; Fri, 06 Aug 2021 16:39:52 -0400
X-MC-Unique: 9SwcBtbyMGCEmXHajixaXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07282801AC0;
        Fri,  6 Aug 2021 20:39:51 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58E5A5D9D5;
        Fri,  6 Aug 2021 20:39:50 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com>
Cc:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] INFO: task hung in sys_io_destroy
References: <0000000000007db08f05c79fc81f@google.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 06 Aug 2021 16:41:14 -0400
In-Reply-To: <0000000000007db08f05c79fc81f@google.com> (syzbot's message of
        "Wed, 21 Jul 2021 03:39:20 -0700")
Message-ID: <x498s1ee26t.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1d67c8d993ba Merge tag 'soc-fixes-5.14-1' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b40232300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
> dashboard link: https://syzkaller.appspot.com/bug?extid=d40a01556c761b2cb385
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12453812300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11225922300000
>
> Bisection is inconclusive: the issue happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127cac6a300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=117cac6a300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167cac6a300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com
>
> INFO: task syz-executor299:8807 blocked for more than 143 seconds.
>       Not tainted 5.14.0-rc1-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor299 state:D stack:29400 pid: 8807 ppid:  8806 flags:0x00000000
> Call Trace:
>  context_switch kernel/sched/core.c:4683 [inline]
>  __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
>  schedule+0xd3/0x270 kernel/sched/core.c:6019
>  schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
>  do_wait_for_common kernel/sched/completion.c:85 [inline]
>  __wait_for_common kernel/sched/completion.c:106 [inline]
>  wait_for_common kernel/sched/completion.c:117 [inline]
>  wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
>  __do_sys_io_destroy fs/aio.c:1402 [inline]
>  __se_sys_io_destroy fs/aio.c:1380 [inline]
>  __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

The reproducer is creating a thread, issuing a IOCB_CMD_PREAD from a
pipe in that thread, and then calling io_destroy from another thread.
Because there is no writer on the other end of the pipe, the read will
block.  Note that it also is not submitted asynchronously, as that's not
supported.

io_destroy is "hanging" because it's waiting for the read to finish.  If
the read thread is killed, cleanup happens as usual.  I'm not sure I
could classify this as a kernel bug.

-Jeff

