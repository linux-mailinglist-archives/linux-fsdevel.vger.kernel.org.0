Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8346E910
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 14:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhLIN1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 08:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhLIN1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:27:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1529AC061746;
        Thu,  9 Dec 2021 05:23:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o13so9621900wrs.12;
        Thu, 09 Dec 2021 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWAp2ggkhQGw0U/SSX5e9v4KP4A6WQ1KHQZ7jWAyzYA=;
        b=qMzVKbz2hpe+Jx+SmcNppNi41tuBVGZZlzHnWuXRUgaamvgT9Ewi1u0oxvOcXhnhIQ
         vel6H1zm7lld/gQZ/lmcr0WEwFjFK33tc52crhxGVN7mXu6FFfAOzg7UakeIppcJwSzp
         DgTObFEfUcaW70Q35zpB52hGDfYkTOVpp/+EADy6xeMWwBjFPF4s+p29GlRIfZd9ZGWY
         yIvARARgoubV5pLHNFJE48pD4jA2ZtpZrRBck8uZ7z523jRLrd0dl7ayHyBzwxyIFXp9
         Fsb8STGeygq+L5YL9QV9WDdzwosU7MMHdC/IR8nTB3MU5LqgCPgCP+oWxYb4DdOQsv6w
         SbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWAp2ggkhQGw0U/SSX5e9v4KP4A6WQ1KHQZ7jWAyzYA=;
        b=Ksoi/tf1S/PrMAeR6dT6Uoc151pEg83usJ9QwA3PeE+sgqdlaMOqaVRPXzmkoYDf48
         H1C5eiG4YgminKzQwQBjoPCqKl7XSXZJdO8K0qp2iPLOi5Ix2P5C/mAdMHg10GN7QmX1
         pBa2Nd2/zxep226JAOGHU8NDv3k9iZf7EtKdSIeMdR5xaS2YfXCGQgMkG9MMql9c4s1q
         ISFFJ7dxR5IKOV6iwmi35N/ASw11pgSt1YReXA830FuBVGFalbUcC7eFsarBss50Yns2
         sfsgOoHbrpT0sMVPzjvLiaxigicgqj57EvG7pNUuLe5HdwP+2RHZ/daqrqDXP8o9lsu5
         1fQg==
X-Gm-Message-State: AOAM530xr7kzaBaMEC2TMnWcbGL9W+MHoZBpU7LXlULGVWeg4XLxG0ya
        tabz7h7nrGkVSxcrBr3/cRU=
X-Google-Smtp-Source: ABdhPJwDaA96JIa79qhS1/j/8JpvUkiuG8tA7mUD0LKctJqfu4Her35jH0h8uoKjPugLsUVE8IPBUQ==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr6260737wrs.458.1639056216551;
        Thu, 09 Dec 2021 05:23:36 -0800 (PST)
Received: from lpc (bzq-79-179-1-77.red.bezeqint.net. [79.179.1.77])
        by smtp.gmail.com with ESMTPSA id p13sm8603891wmi.0.2021.12.09.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 05:23:36 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:23:32 +0200
From:   Shachar Sharon <synarete@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
Message-ID: <YbIDVMouwlHyjZT+@lpc>
References: <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
 <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
 <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
 <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net>
 <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
 <CAJfpegt2x1ztuzh0niY7fgx1UKxDGsAkJbS0wVPp5awxwyhRpA@mail.gmail.com>
 <Ya9uxHGo7UJikEte@hirez.programming.kicks-ass.net>
 <CAJfpegupPZMG2dv27ZkpQwTeUw-WcaRZbYXSH-i=+Rt=T+UaDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJfpegupPZMG2dv27ZkpQwTeUw-WcaRZbYXSH-i=+Rt=T+UaDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:46:06PM +0100, Miklos Szeredi wrote:
>On Tue, 7 Dec 2021 at 15:25, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> FIFO means the thread used longest ago gets to go first. If your threads
>> are an idempotent workers, FIFO might not be the best option. But I'm
>> not much familiar with the FUSE code or it's design.
>
>Okay.  Did some experiments, but couldn't see
>wake_up_interruptible_sync() actually migrate the woken task, the
>behavior was identical to wake_up_interruptible().   I guess this is
>the "less" part in "more or less", but it would be good to see more
>clearly what is happening.
>
>I'll try to describe the design to give more context:
>
>- FUSE is similar to network filesystem in that there's a server and a
>client, except both are on the same host. The client lives in the
>kernel and the server lives in userspace.
>
>- Communication between them is done with read and write syscalls.
>
>- Usually the server has multiple threads.  When a server thread is
>idle it is blocking in sys_read -> ... -> fuse_dev_do_read ->
>wait_event_interruptible_exclusive(fiq->waitq,...).
>
>- When a filesystem request comes in (e.g. mkdir) a request is
>constructed, put on the input queue (fiq->pending) and fiq->waitq
>woken up.  After this the client task goes to sleep in
>request_wait_answer -> wait_event_interruptible(req->waitq, ...).
>
>- The server thread takes the request off the pending list, copies the
>data to the userspace buffer and puts the request on the processing
>list.
>
>- The userspace part interprets the read buffer, performs the fs
>operation, and writes the reply.
>
>- During the write(2) the reply is now copied to the kernel and the
>request is looked up on the processing list.  The client is woken up
>through req->waitq.  After returning from write(2) the server thread
>again calls read(2) to get the next request.
>
>- After being woken up, the client task now returns with the result of
>the operation.
>
>- The above example is for synchronous requests.  There are async
>requests like readahead or buffered writes.  In that case the client
>does not call request_wait_answer() but returns immediately and the
>result is processed from the server thread using a callback function
>(req->args->end()).
>
>From a scheduling prospective it would be ideal if the server thread's
>CPU was matched to the client thread's CPU, since that would make the
>data stay local, and for synchronous requests a _sync type wakeup is
>perfect, since the client goes to sleep just as the server starts
>processing and vice versa.
>
>Always migrating the woken server thread to the client's CPU is not
>going to be good, since this would result in too many migrations and
>would loose locality for the server's stack.
>
>Another idea is to add per-cpu input queues.  The client then would
>queue the request on the pending queue corresponding to its CPU and
>wake up the server thread blocked on that queue.
>
>What happens though if this particular queue has no servers?  Or if a
>queue is starved because it's served by less threads than another?
>Handing these cases seems really complicated.
>
Per-CPU input queue is a great idea. It was a key concept in ZUFS[1]
design. However, describing it as complicated would be an understatement,
to say the least.

>Is there a simper way?
Here is an idea: hint the userspace server on which cpu to execute the
_next_ request via the (unused) fuse_in_header.padding field in current
request. Naturally, this method would be effective only for cases where
queue-size > 1.

>
>Thanks,
>Miklos

[1] https://lwn.net/Articles/795996/

