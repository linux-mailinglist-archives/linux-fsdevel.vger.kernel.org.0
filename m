Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8646D74D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhLHPtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 10:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLHPtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:49:50 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A2C061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Dec 2021 07:46:18 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id o1so5457641uap.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Dec 2021 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rb1UrIX/h2Jn3TSZ/DW3sU6ppztqP9i4XW0nwaM6dM=;
        b=LOT5q9mbuiUnao7IdLLvqzNvafg1Yy0hrTW5Svhwa/6wzibx6XH/ybw+E3Xh5sfEMV
         hxCh9RUX28K3/z4IoT8BqlLo82Z16Sx5MpLRLcHwQfqF7OiMKvEVOh5OPKIJtTg3TIV8
         eevVpqZDb9In9GzCrjb4fTIiNoGgT7iKb+SP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rb1UrIX/h2Jn3TSZ/DW3sU6ppztqP9i4XW0nwaM6dM=;
        b=lYicwoBj6s/9S7B4vr6you+JwGCX5uMYzYVqbD1xPiJbaWje/iv+5ZKoWUDaDWdtXk
         P/tc6uuro9is90oWec4DGurtsfuw1nb7o7A0KSxy7fwIzIpID1tBEr9aq3Zm7Exqxez7
         yQewKg3079FC4q4z+guItE4xEDysxqMHrPidLgyweMjmzSAWi3fSX4jEnAJn8ebCjKLB
         YRkr6b9LDFZdexuDtIJi7QCxpBQNGdcYF5ANoOkjfKMbH9I5UMvT/xK/KD4S137ql+do
         N1fYyhI5BPjTWme6BJU62mG404rMnMrSCuwPifpfSUd3EASjmppcul4l2ZQxLmlc38Ej
         Nryg==
X-Gm-Message-State: AOAM530NcNSy8ZrAQx4lDHz/UPgHiP2auWXR+ai1gLy28RBgEkHIrMVM
        GtjR/NIrbW/PIz2h+qgIVnWsfdFxN9o4spMrd+iKaA==
X-Google-Smtp-Source: ABdhPJxfIQM9jTLWOUUyPdo+VFL2MW60Apqt4XhPfYjiErhtAaa2PvwSRasmjstFKkXNB5gwH0rI/GuSxzEx6PZz0NI=
X-Received: by 2002:a05:6102:945:: with SMTP id a5mr54090483vsi.87.1638978377415;
 Wed, 08 Dec 2021 07:46:17 -0800 (PST)
MIME-Version: 1.0
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net> <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net> <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
 <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net> <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
 <CAJfpegt2x1ztuzh0niY7fgx1UKxDGsAkJbS0wVPp5awxwyhRpA@mail.gmail.com> <Ya9uxHGo7UJikEte@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya9uxHGo7UJikEte@hirez.programming.kicks-ass.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 Dec 2021 16:46:06 +0100
Message-ID: <CAJfpegupPZMG2dv27ZkpQwTeUw-WcaRZbYXSH-i=+Rt=T+UaDg@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Dec 2021 at 15:25, Peter Zijlstra <peterz@infradead.org> wrote:

> FIFO means the thread used longest ago gets to go first. If your threads
> are an idempotent workers, FIFO might not be the best option. But I'm
> not much familiar with the FUSE code or it's design.

Okay.  Did some experiments, but couldn't see
wake_up_interruptible_sync() actually migrate the woken task, the
behavior was identical to wake_up_interruptible().   I guess this is
the "less" part in "more or less", but it would be good to see more
clearly what is happening.

I'll try to describe the design to give more context:

- FUSE is similar to network filesystem in that there's a server and a
client, except both are on the same host. The client lives in the
kernel and the server lives in userspace.

- Communication between them is done with read and write syscalls.

- Usually the server has multiple threads.  When a server thread is
idle it is blocking in sys_read -> ... -> fuse_dev_do_read ->
wait_event_interruptible_exclusive(fiq->waitq,...).

- When a filesystem request comes in (e.g. mkdir) a request is
constructed, put on the input queue (fiq->pending) and fiq->waitq
woken up.  After this the client task goes to sleep in
request_wait_answer -> wait_event_interruptible(req->waitq, ...).

- The server thread takes the request off the pending list, copies the
data to the userspace buffer and puts the request on the processing
list.

- The userspace part interprets the read buffer, performs the fs
operation, and writes the reply.

- During the write(2) the reply is now copied to the kernel and the
request is looked up on the processing list.  The client is woken up
through req->waitq.  After returning from write(2) the server thread
again calls read(2) to get the next request.

- After being woken up, the client task now returns with the result of
the operation.

- The above example is for synchronous requests.  There are async
requests like readahead or buffered writes.  In that case the client
does not call request_wait_answer() but returns immediately and the
result is processed from the server thread using a callback function
(req->args->end()).

From a scheduling prospective it would be ideal if the server thread's
CPU was matched to the client thread's CPU, since that would make the
data stay local, and for synchronous requests a _sync type wakeup is
perfect, since the client goes to sleep just as the server starts
processing and vice versa.

Always migrating the woken server thread to the client's CPU is not
going to be good, since this would result in too many migrations and
would loose locality for the server's stack.

Another idea is to add per-cpu input queues.  The client then would
queue the request on the pending queue corresponding to its CPU and
wake up the server thread blocked on that queue.

What happens though if this particular queue has no servers?  Or if a
queue is starved because it's served by less threads than another?
Handing these cases seems really complicated.

Is there a simper way?

Thanks,
Miklos
