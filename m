Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CB344D07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhCVRPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCVRPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:15:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC45C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:15:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 11so11399588pfn.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UojHEz0pk6GNebu+2HDqWhxrBOGOhUOBrfY2ndpxyhs=;
        b=GbkaRQiTIP+rsqDnSrsNsq0ubjJxbTV3elvqtaFuk9jtLD533Hx/SL/hr04uHKdU0K
         HhUbjafxu5+7EbRgy5WekXc4xqk2BuhFDjT2JQi/qyyKCusBYDARQmsjztyjHcuClN+w
         /k80QBWJkHUTdFBz8K8N0+yMAP+88AU8wBcB9suJI3wJHVzoJ9y4NwpXD28oc21XjYS+
         NX7+AAe3hEOsUkiCZe3cURdMNfnOXEeEUxMbicih/IrR82QN2+TQG8lu1ewGqgX+izM5
         4kycprnKUPqDxuFi0mtW6m8Bthu76/7xxlJj2bylU8lfkp0m0/YVj0K8/q6QtxRsuqBO
         e58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UojHEz0pk6GNebu+2HDqWhxrBOGOhUOBrfY2ndpxyhs=;
        b=Cce8m901Zlf9kKj73rBIlfsxwW+0vILD0wJN/Q4rjmOwVTsYyUXNAeZzt6/TZSnLQO
         jN0eDVgU2Wt1TvSJzF8sHuAnXzyySwrC07jmQT74UnOoT7CytQUJOCMNCnNsyiLSUcxi
         GsgBdSbDy3fRmzT6AxPzXb4ZQNL+JmDE6UvC2SRQhb+yQgwA96srirYsD4RV603RzAI8
         WtEhUUCte+JlyEWACsbSKuEUhYo/L/t6STPU7Sv/H5i7vPuoeppX2oWB8iBnZ/1eUZIo
         cLHP/Aue2dwJsnVCV8iUCTyBhHZV7GIvCv0E/XZL5k+MxiG/aQlAUwOeYtc7SlV+yfy6
         vy0w==
X-Gm-Message-State: AOAM532egfCoBkvySoezvckCn9NN1Jj0rgLBWQWZh6b90zyBomlFNJfm
        saWN3YS/4kxb7NY7CDLGdi2o899i797ZKrSb8bC3MA==
X-Google-Smtp-Source: ABdhPJwc2vn4A7n7qbnr9AqRUkT8NmfXqRbD1H48YgBvu1JCqC/2soGiI6q8Dk7W6NLU5eg2V2Dcna2D6zMHivG50vU=
X-Received: by 2002:a05:6a00:ac8:b029:1ed:f8dc:cb3b with SMTP id
 c8-20020a056a000ac8b02901edf8dccb3bmr805272pfl.60.1616433314431; Mon, 22 Mar
 2021 10:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210302034928.3761098-1-varmam@google.com> <87pmzw7gvy.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pmzw7gvy.fsf@nanos.tec.linutronix.de>
From:   Manish Varma <varmam@google.com>
Date:   Mon, 22 Mar 2021 10:15:03 -0700
Message-ID: <CAMyCerL7UkcU1YgZ=dUTZadv-YPHGccO3PR-DCt2nX7nz0afgA@mail.gmail.com>
Subject: Re: [PATCH] fs: Improve eventpoll logging to stop indicting timerfd
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Thomas,

On Thu, Mar 18, 2021 at 6:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Manish,
>
> On Mon, Mar 01 2021 at 19:49, Manish Varma wrote:
>
> > All together, that will give us names like the following:
> >
> > 1) timerfd file descriptor: [timerfd14:system_server]
> > 2) eventpoll top-level per-process wakesource: epoll:system_server
> > 3) eventpoll-on-timerfd per-descriptor wakesource:
> > epollitem:system_server.[timerfd14:system_server]
>
> All together that should be splitted up into a change to eventpoll and
> timerfd.
>

Noted.

> > diff --git a/fs/timerfd.c b/fs/timerfd.c
> > index c5509d2448e3..4249e8c9a38c 100644
> > --- a/fs/timerfd.c
> > +++ b/fs/timerfd.c
> > @@ -46,6 +46,8 @@ struct timerfd_ctx {
> >       bool might_cancel;
> >  };
> >
> > +static atomic_t instance_count = ATOMIC_INIT(0);
>
> instance_count is misleading as it does not do any accounting of
> instances as the name suggests.
>

Not sure if I am missing a broader point here, but the objective of this
patch is to:
A. To help find the process a given timerfd associated with, and
B. one step further, if there are multiple fds created by a single
process then label each instance using monotonically increasing integer
i.e. "instance_count" to help identify each of them separately.

So, instance_count in my mind helps with "B", i.e. to keep track and
identify each instance of timerfd individually.

> >  static LIST_HEAD(cancel_list);
> >  static DEFINE_SPINLOCK(cancel_lock);
> >
> > @@ -391,6 +393,9 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
> >  {
> >       int ufd;
> >       struct timerfd_ctx *ctx;
> > +     char task_comm_buf[sizeof(current->comm)];
> > +     char file_name_buf[32];
> > +     int instance;
> >
> >       /* Check the TFD_* constants for consistency.  */
> >       BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
> > @@ -427,7 +432,11 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
> >
> >       ctx->moffs = ktime_mono_to_real(0);
> >
> > -     ufd = anon_inode_getfd("[timerfd]", &timerfd_fops, ctx,
> > +     instance = atomic_inc_return(&instance_count);
> > +     get_task_comm(task_comm_buf, current);
>
> How is current->comm supposed to be unique? And with a wrapping counter
> like the above you can end up with identical file descriptor names.
>
> What's wrong with simply using the PID which is guaranteed to be unique
> for the life time of a process/task?
>

Thanks, and Yes, on a second thought, PID sounds like a better option.
I will address in v2 patch.

> > +     snprintf(file_name_buf, sizeof(file_name_buf), "[timerfd%d:%s]",
> > +              instance, task_comm_buf);
> > +     ufd = anon_inode_getfd(file_name_buf, &timerfd_fops, ctx,
> >                              O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
> >       if (ufd < 0)
> >               kfree(ctx);
>
> I actually wonder, whether this should be part of anon_inode_get*().
>

I am curious (and open at the same time) if that will be helpful..
In the case of timerfd, I could see it adds up value by stuffing more
context to the file descriptor name as eventpoll is using the same file
descriptor names as wakesource name, and hence the cost of slightly
longer file descriptor name justifies. But I don't have a solid reason
if this additional cost (of longer file descriptor names) will be
helpful in general with other file descriptors.

> Aside of that this is a user space visible change both for eventpoll and
> timerfd.
>
> Have you carefully investigated whether there is existing user space
> which might depend on the existing naming conventions?
>

I am not sure how I can confirm that for all userspace, but open for
suggestions if you can share some ideas.

However, I have verified and can confirm for Android userspace that
there is no dependency on existing naming conventions for timerfd and
eventpoll wakesource names, if that helps.

> The changelog is silent about this...
>

Noted - will add this into the revised patch.

> Thanks,
>
>         tglx

Thanks,
Manish
