Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1947E382C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhEQMrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhEQMq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 08:46:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD97C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 05:45:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z24so5637429ioi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxcJez+3AitnN2GaGpI5uZk3xqykYGOWnsIAvQ2bYRw=;
        b=Ec/huqbWIuh1KirRHhnQiEhNQvgodhhjl3D5WLllEl6dLuMnPhGt1+CyYTMzeOm6du
         wsjokwaPiaLY7ExuAGFJ22sIATJgQKqy35iQd/mrtCZNQYhrKu7NFhntAkcjqsysK0un
         eB1ITD21I4nvWpYif4jfh/qZd03rqpbh+57OUex/nUeanjo9KurutYrNbMysgl9Azuhc
         qaf8y8HaIijiqSy/E4cNaa7275x9e2o8ZG8I7yoM7mbWzvHBK44KhUoGqyMrtZJwYuGV
         inWJIzbNc5srkIGEVyEdWOsspu1tjgZt2hAZHHzqV8RJSsdgSt3pOB/xPaGFtHpQoCZh
         UbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxcJez+3AitnN2GaGpI5uZk3xqykYGOWnsIAvQ2bYRw=;
        b=UnjvUxfc0O4k2zaAb3ahYXIxvviY507NB1rb8kNel4hOJc/WuQA/bQk/fgkRSmwgGI
         QtsBVFM/P5pGXuoS07W7miD8KQ9tF69hfEl6mP/EJ2haRTxfwRVxMT9+GpK+vHZeMf6X
         MrrNaqwhYRyFbpHT42ZJVIKzUhBjycaUJu23ZT1gjxqxzyIWz6Hryo3C6miQU01j04LN
         JUWbtJYZeYRWjVc7LR1/3e0xL+gOQjqx2hLzB5BpmIXZjhyyFfuyKcLdZ6akSaWxN/YA
         t0zC+O4lJ41yqtzW66Jr3sVqKdmxGaV58cvB0WqLUKqWHmBNgO/kzMDlhQd+g4mV+KUc
         RDCw==
X-Gm-Message-State: AOAM533ty+nDiy1yA3jx/lXshYcbk1e4I9wLWBwcYde9hWGPkO6VPGPA
        VwFdHig+sh7H2EkCJTlbsE3oBh+KMOCf4vwNgOSdd0rm
X-Google-Smtp-Source: ABdhPJwhG7rL1nPwOjmxOisjy0M4672XfH8YijXX3odFFQlKM69hIvsLPxlSU4p0VuPT2HGsmiD7v5dRipmh0i7aCdA=
X-Received: by 2002:a05:6638:3445:: with SMTP id q5mr7157824jav.120.1621255541027;
 Mon, 17 May 2021 05:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210503165315.GE2994@quack2.suse.cz> <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz> <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz> <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein> <20210513105526.GG2734@quack2.suse.cz>
 <20210514135632.d53v3pwrh56pnc4d@wittgenstein> <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
 <20210517090928.GA31755@quack2.suse.cz>
In-Reply-To: <20210517090928.GA31755@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 May 2021 15:45:29 +0300
Message-ID: <CAOQ4uxgQ-gS5YBEPy2UEcwbO9Y0ie2vVGQn6Wts3Z8x3LZPfog@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 12:09 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 15-05-21 17:28:27, Amir Goldstein wrote:
> > On Fri, May 14, 2021 at 4:56 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > > for changes with idmap-filtered mark, then it won't see notification for
> > > > those changes because A presumably runs in a different namespace than B, am
> > > > I imagining this right? So mark which filters events based on namespace of
> > > > the originating process won't be usable for such usecase AFAICT.
> > >
> > > Idmap filtered marks won't cover that use-case as envisioned now. Though
> > > I'm not sure they really need to as the semantics are related to mount
> > > marks.
> >
> > We really need to refer to those as filesystem marks. They are definitely
> > NOT mount marks. We are trying to design a better API that will not share
> > as many flaws with mount marks...
>
> I agree. I was pondering about this usecase exactly because the problem with
> changes done through mount A and visible through mount B which didn't get
> a notification were source of complaints about fanotify in the past and the
> reason why you came up with filesystem marks.
>
> > > A mount mark would allow you to receive events based on the
> > > originating mount. If two mounts A and B are separate but expose the
> > > same files you wouldn't see events caused by B if you're watching A.
> > > Similarly you would only see events from mounts that have been delegated
> > > to you through the idmapped userns. I find this acceptable especially if
> > > clearly documented.
> > >
> >
> > The way I see it, we should delegate all the decisions over to userspace,
> > but I agree that the current "simple" proposal may not provide a good
> > enough answer to the case of a subtree that is shared with the host.
> >
> > IMO, it should be a container manager decision whether changes done by
> > the host are:
> > a) Not visible to containerized application
> > b) Watched in host via recursive inode watches
> > c) Watched in host by filesystem mark filtered in userspace
> > d) Watched in host by an "noop" idmapped mount in host, through
> >      which all relevant apps in host access the shared folder
> >
> > We can later provide the option of "subtree filtered filesystem mark"
> > which can be choice (e). It will incur performance overhead on the system
> > that is higher than option (d) but lower than option (c).
>
> But won't b) and c) require the container manager to inject events into the
> event stream observed by the containerized fanotify user? Because in both
> these cases the manager needs to consume generated events and decide what
> to do with them.
>

With (b) manager does not need to inject events.
The manager intercepts fanotify_init() and returns an actual fantify group fd
in the requesting process fd table.

Later, when manager intercepts fanotify_mark() with idmapped mark
request, manager can take care of setting up the recursive inode watches,
but the requesting process will get the events, because it has a clone of
the fanotify group fd.

With (c), I guess the intercepted fanotify_init() can return an open pipe
and proxy the stream of events read from the actual fanotify fd filtering
out the events.

I hope we can provide some form of kernel subtree filtering so
userspace will not need to resort to this sort of practice.

Thanks,
Amir.
