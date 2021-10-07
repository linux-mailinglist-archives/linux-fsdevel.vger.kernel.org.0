Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5827C425A6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbhJGSNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhJGSNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:13:19 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A1C061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 11:11:25 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id f3so1316736uap.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OK69gQ35Nu0gwgUD1ws+YChTnNs1FIQJu3+x4LVEMx4=;
        b=TTKLR81zmo8SsvAjs8PbfaNQTsnPhDHL/0nX7wdhdS3fVMeRIuw2UpJqmJk2HznO/M
         tUuCj8eLhaQrSx/icivowuWxyFu0ByVf1fsucDmwK0aoEm3ww59QWSdBYYU9DEGzmJnr
         lauqopHcOapVbihbtjA3lcG0kjbASX/Kch20w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OK69gQ35Nu0gwgUD1ws+YChTnNs1FIQJu3+x4LVEMx4=;
        b=fnntV4w6RMPpI24BhgmmnrnIdwRhy20KyuqXLhdROxhIkBYZ75pDfryfNZEUZHdJEt
         H2lgwbY0lIrFGRp4+pEm7jFy+KYm+LlBRWzEcLPxr7BQ/RZRFvV6btVg0pUY8gzoVrh8
         q51PRSudUgX6bygy1qBrhAx70l4AWcwtO3FUiqRmw5q7FeyaNoB0BK2bDr1FSp4uN90j
         VC2N7oY3/JJ5Jj+09phkmBUbi2riwGrkqBuS1iVJpQP678IyJV375yGedQ4PRD9xqb5v
         imvK7j/Nisd13BLsax5+v74W8rmSauWK4yUnaDBhDh8WtRtavidMOgpwLAl2coK4HLco
         hf+g==
X-Gm-Message-State: AOAM533R2yC9QjMpOKwuvcHo7bTNv3rLePAnJMPbqu0ry8gAEFScVtRq
        sqKeOsQJ4kNQGMUzLPPKwKbuwBfCMkbp00wqcizrqw==
X-Google-Smtp-Source: ABdhPJxNTZemrAzE3NcvXLkzrHcTHRH+mBFZ6mhRRimzLv9/kgx+9EDxnAxlmMKdZSqAXIsqcPxFQBhrERD/H63+BDs=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr6405462uac.72.1633630284671;
 Thu, 07 Oct 2021 11:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210930143850.1188628-1-vgoyal@redhat.com> <20210930143850.1188628-8-vgoyal@redhat.com>
 <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com>
 <YV3LBNM3jnGBBzwS@redhat.com> <CAJfpegtoNSXFwiiFuU0tczogS6NFqeodLaxcr0Ax5d=dG0-utw@mail.gmail.com>
 <YV8Ca/wP9HDWJITq@redhat.com>
In-Reply-To: <YV8Ca/wP9HDWJITq@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 20:11:13 +0200
Message-ID: <CAJfpegsguYZ3y5G6Rj4hoxEOn2ObnUVajTVhtyvm4ZSeFqGtFw@mail.gmail.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Oct 2021 at 16:22, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Oct 07, 2021 at 03:45:40PM +0200, Miklos Szeredi wrote:
> > On Wed, 6 Oct 2021 at 18:13, Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Oct 06, 2021 at 03:02:36PM +0200, Miklos Szeredi wrote:
> > > > On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> > > > > sent by file server to signifiy that a previous locking request has
> > > > > completed and actual caller should be woken up.
> > > >
> > > > Shouldn't this also be generic instead of lock specific?
> > > >
> > > > I.e. generic header  + original outarg.
> > >
> > > Hi Miklos,
> > >
> > > I am not sure I understand the idea. Can you please elaborate a bit more.
> > >
> > > IIUC, "fuse_out_header + original outarg"  is format for responding
> > > to regular fuse requests. If we use that it will become like responding
> > > to same request twice. First time we responded with ->error=1 so that
> > > caller can wait and second time we respond with actual outarg (if
> > > there is one depending on the type of request).
> > >
> > > IOW, this will become more like implementing blocking of request in
> > > client in a more generic manner.
> > >
> > > But outarg, depends on type of request (In case of locking there is
> > > none). And outarg memory is allocated by driver and filled by server.
> > > In case of notifications, driver is allocating the memory but it
> > > does not know what will come in notification and how much memory
> > > to allocate. So it relies on device telling it how much memory
> > > to allocate in general so that bunch of pre-defined notification
> > > types can fit in (fs->notify_buf_size).
> > >
> > > I modeled this on the same lines as other fuse notifications where
> > > server sends notifications with following format.
> > >
> > > fuse_out_header + <structure based on notification type>
> > >
> > > out_header->unique is 0 for notifications to differentiate notifications
> > > from request reply.
> > >
> > > out_header->error contains the code of actual notification being sent.
> > > ex. FUSE_NOTIFY_INVAL_INODE or FUSE_NOTIFY_LOCK or FUSE_NOTIFY_DELETE.
> > > Right now virtiofs supports only one notification type. But in future
> > > we can introduce more types (to support inotify stuff etc).
> > >
> > > In short, I modeled this on existing notion of fuse notifications
> > > (and not fuse reply). And given notifications are asynchronous,
> > > we don't know what were original outarg. In fact they might
> > > be generated not necessarily in response to a request. And that's
> > > why this notion of defining a type of notification (FUSE_NOTIFY_LOCK)
> > > and then let driver decide how to handle this notification.
> > >
> > > I might have completely misunderstood your suggestion. Please help
> > > me understand.
> >
> > Okay, so we are expecting this mechanism to be only used for blocking
> > locks.
>
> Yes, as of now it is only being used only for blocking locks. So there
> are two parts to it.
>
> A. For a blocking operation, server can reply with error=1, and that's
>    a signal to client to wait for a notification to arrive later. And
>    fuse client will not complete the request and instead will queue it
>    in one of the internal lists.
>
> B. Later server will send a fuse notification event (FUSE_NOTIFY_LOCK)
>    when it has acquired the lock. This notification will have unique
>    number of request for which this notification has been generated.
>    Fuse client will search for the request with expected unique number
>    in the list and complete the request.
>
> I think part A is generic in the sense it could be used for other
> kind of blocking requests as well down the line, where server is
> doing the blocking operation on behalf of client and will send
> notification later. Part B is very specific to blocking locks though.

I don't really get why B is specific to blocking locks. But anyway...
we are only implementing it for blocking locks for now.

>
> > That makes sense, but then locking ops should be setting a
> > flag indicating that this is locking op.  I.e. in fuse_setlk():
> >
> >     args.blocking_lock = true;
> >
> > And this should be verified when the reply with the positive error comes back.
>
> So this args.blocking_lock, goes to server as well? Or this is something
> internal to fuse client so that client can decide whether ->error=1 is
> a valid response or not. IOW, client is trying to do verification
> whether server should have generated ->error=1 or not for this specific
> request.

Right, it's for the client.

Thanks,
Miklos
