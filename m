Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31E31EA27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBRM7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbhBRMSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:18:39 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B5C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 04:17:58 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y202so1766603iof.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgfhC6aV3Oq3Pr6WvVEh918Z9wQfy2EyWoqv3XObnu8=;
        b=NG3E24j0TBk78ATqmZiIzPGhEv7EgZ2/r2KLqH+jJpVYJktj/HnpiZ5H0Wr2cZ28Iu
         qMZ+iO+3QwudpjHmxSQg6GTZD5bQ9UO1iliTfQi+bPJlL9VRmRNZzsKzCPLvNT29kpsy
         4h5qqL7UGFbFWI2JSm6x88LLzbyLQFZtJqOBSnDgpDgRga1BjLqUEslm4i1kjiAsnIjO
         /hD3X3X5tO0MrQHlTY5s4ljneif1G3G0sUQv89TuXYpOr4Ec8vKEAG4UEeML7PzgOD20
         MA6iz6/ynoQxzkWSyWiTfxSeAGaakThszwYyhvz69bxUWFNWx1o5Eig1y02Mza/SwMbB
         G9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgfhC6aV3Oq3Pr6WvVEh918Z9wQfy2EyWoqv3XObnu8=;
        b=qX4zjf55cDZj4t3fLl6dEMf+csZ/Jl9cLYbFHMOwVPkLGbZGJpYVqCKxlzw5yJUXyM
         Z3mpTCJXWgUQgXtzPqoN0MQXS2RrX0OhOhIwXTWTPmmrL7rQK80KcbpSGCiSdCXHKVtC
         gygWTCQyp9SXPVIEdhxVm4f9R4rehdN14pkg6on2dNrxLMoUQiL3wPS946x+zE2e5Gi+
         jL7pHvaiXh9klOnGnfHtISTidMvhf8LguaEzoUK9jC5SGtnQK92Fupv1XvgBV8M+w1BN
         Vgt7dCgHI5goXZV7JApDAAHSsUWkX7J+j7T7RtzcaMPWD290ulyuPKfzbtkDPdgJ3ZP4
         1vUA==
X-Gm-Message-State: AOAM531CvIf0JEjkvD0zNkf5g0HAz4uyJ8DLWWwGJF2Kr8ynVDP7vQNn
        NtP1F4QTpoS1IaDGyZ9ZvUpfS5cnADa5aXuzKZDYXdVk
X-Google-Smtp-Source: ABdhPJzTXr9JT4P7HQiO1wDj/+BEY/e9FMvgotPJIYXWtj3KSGsdj68pxagyQfEIf0i1JlVpeQk1rneeSqmoBTbZ/fs=
X-Received: by 2002:a5d:9c8b:: with SMTP id p11mr3300469iop.72.1613650678261;
 Thu, 18 Feb 2021 04:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-7-amir73il@gmail.com>
 <20210216153943.GD21108@quack2.suse.cz> <CAOQ4uxhpJ=pNsKTpRwGYUancosdLRNaf596he4Ykmd8u=fPFBw@mail.gmail.com>
 <CAOQ4uxg0LfHaJz5t6a=4=OF26_+4ZfPAhB7vcj7xD0wBD7dAmA@mail.gmail.com> <20210218111136.GA16953@quack2.suse.cz>
In-Reply-To: <20210218111136.GA16953@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 14:17:47 +0200
Message-ID: <CAOQ4uxjTR1psVdcfzAFzE353e+iiMm29WRYPHFSOA1j4VkQvXQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] fanotify: mix event info into merge key hash
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 1:11 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 18-02-21 12:46:48, Amir Goldstein wrote:
> > On Wed, Feb 17, 2021 at 12:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > @@ -154,7 +162,10 @@ static inline void fanotify_init_event(struct fanotify_event *event,
> > > > >
> > > > >  struct fanotify_fid_event {
> > > > >       struct fanotify_event fae;
> > > > > -     __kernel_fsid_t fsid;
> > > > > +     union {
> > > > > +             __kernel_fsid_t fsid;
> > > > > +             void *fskey;    /* 64 or 32 bits of fsid used for salt */
> > > > > +     };
> > > > >       struct fanotify_fh object_fh;
> > > > >       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> > > > >       unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
> > > > > @@ -168,7 +179,10 @@ FANOTIFY_FE(struct fanotify_event *event)
> > > > >
> > > > >  struct fanotify_name_event {
> > > > >       struct fanotify_event fae;
> > > > > -     __kernel_fsid_t fsid;
> > > > > +     union {
> > > > > +             __kernel_fsid_t fsid;
> > > > > +             void *fskey;    /* 64 or 32 bits of fsid used for salt */
> > > > > +     };
> > > > >       struct fanotify_info info;
> > > > >  };
> > > >
> > > > What games are you playing here with the unions? I presume you can remove
> > > > these 'fskey' unions and just use (void *)(event->fsid) at appropriate
> > > > places? IMO much more comprehensible...
> > >
> >
> > FYI, this is what the open coded conversion looks like:
> >
> > (void *)*(long *)event->fsid.val
>
> Not great but at least fairly localized. I'd just note that this doesn't quite
> work on 32-bit archs (sizeof(long) != sizeof(__kernel_fsid_t) there). Maybe
> we could just use
>
> hash_32(event->fsid.val[0]) ^ hash_32(event->fsid.val[1])
>
> for mixing into the 'key' value and thus avoid all these games?
>

Makes sense.

Thanks,
Amir.
