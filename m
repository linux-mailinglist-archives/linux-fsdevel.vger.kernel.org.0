Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3323910E45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAUyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 16:54:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50624 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAUyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 16:54:09 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so722287itk.0;
        Wed, 01 May 2019 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIcJKYBcMp0LBZVdGWmzzu8eQ6eVC6AwEkLQJhbgPJA=;
        b=uQOR/ugMpYcHFXtprrn5lLtqOgrkNpwpZgQl13kys6czcZPk8ShghAJNb/tq+GerLz
         aFa8rVINWNqfqcBUW+oLMEN4v1TVZTrmsMXUYF5S3RnjZN6t2KR54P/GSIpn522xOD76
         aIfVMfBp5Ls4Gw4RjG5Lw2a2o5KEdKzKrFh8nS82TqMRrc3wEz8mYIjqjkKSQRHsF3/d
         KC0R0vKhgYa5Bk7Ex+gpoSw7zkXqK5pEty7RvS6D/RdmloGmb8oZjgsJppdUITXCrqWI
         WwQVEsDyF9rjMWcywF+ccA+KC6tWrDE7d2KFaCHwZ0Y1qx64ZNYwCuobSFyofd5la7tB
         elGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIcJKYBcMp0LBZVdGWmzzu8eQ6eVC6AwEkLQJhbgPJA=;
        b=ck2eLxj+/S2KCGdY617akxtCQfiJTMG2G2VR8MOy2nbcy5de0GZyG8RKk7Ut1C2LAW
         hfjuHHZkQt8ee1n4W2LY98WDElu/zeWUw3fdhaET8ctSBD1M9yg0Xu5dkn+51m0rW9oP
         ye6HzvHho5NX1e9ZO4CmL3SGlHHda3eYnCUINivF8XBvRK70CgsUdOlPVsZFx9L8M0bl
         pfYZ0a6OtAvPmKDKSoxYO2IRaxlBHud739GZt9aOHpfeUz0gi/oca9PXj3uBz9kme+ca
         pVr99cOrFZUYYoIRcCvD9LtrpIUsVvqui9kIeHIlF0c6gqf2cjoAgTk1+sjowjCIe3ZM
         rkYQ==
X-Gm-Message-State: APjAAAV7yck8YLAdI2Yvhc1mk+H1f99eHo/lf3jGUHb4IUEwwULKJjZ9
        C9HNyJPJTPuLkuOY/NThkE+NlPFS7cvqRs7a4SaM6BU/
X-Google-Smtp-Source: APXvYqwDSBwuoIz5Cx9CEVGIcqE/OP3knt8Grs33/FqLWFRA3yEiK7fltJ3XAl5Bin3Nlf+6Jumm0lwyN4qmA4T6+qw=
X-Received: by 2002:a24:7347:: with SMTP id y68mr9823741itb.58.1556744048323;
 Wed, 01 May 2019 13:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190424193903.swlfmfuo6cqnpkwa@dcvr> <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr> <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr> <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
 <20190501021405.hfvd7ps623liu25i@dcvr> <20190501073906.ekqr7xbw3qkfgv56@dcvr>
 <CABeXuvq7gCV2qPOo+Q8jvNyRaTvhkRLRbnL_oJ-AuK7Sp=P3QQ@mail.gmail.com> <20190501204826.umekxc7oynslakes@dcvr>
In-Reply-To: <20190501204826.umekxc7oynslakes@dcvr>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 1 May 2019 13:53:57 -0700
Message-ID: <CABeXuvqbCDhp+67SpGLAO7dYiWzWufewQBn+MTxY5NYsaQVrPg@mail.gmail.com>
Subject: Re: Strange issues with epoll since 5.0
To:     Eric Wong <e@80x24.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 1, 2019 at 1:48 PM Eric Wong <e@80x24.org> wrote:
>
> Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > So here is my analysis:
>
> <snip everything I agree with>
>
> > So the 854a6ed56839a40f6 seems to be better than the original code in
> > that it detects the signal.
>
> OTOH, does matter to anybody that a signal is detected slightly
> sooner than it would've been, otherwise?

The original code drops the signal altogether. This is because it
overwrites the current's sigmask with the provided
one(set_current_blocked()). If a signal bit was set, it is lost
forever. It does not detect it sooner. The check for pending signal is
sooner and not just before the syscall returns.
This is what the patch in discussion does: check for signals just
before returning.

>
> > But, the problem is that it doesn't
> > communicate it to the userspace.
>
> Yup, that's a big problem :)
>
> > So a patch like below solves the problem. This is incomplete. I'll
> > verify and send you a proper fix you can test soon. This is just for
> > the sake of discussion:
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 4a0e98d87fcc..63a387329c3d 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -2317,7 +2317,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
> > epoll_event __user *, events,
> >                 int, maxevents, int, timeout, const sigset_t __user *, sigmask,
> >                 size_t, sigsetsize)
> >  {
> > -       int error;
> > +       int error, signal_detected;
> >         sigset_t ksigmask, sigsaved;
> >
> >         /*
> > @@ -2330,7 +2330,10 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
> > epoll_event __user *, events,
> >
> >         error = do_epoll_wait(epfd, events, maxevents, timeout);
> >
> > -       restore_user_sigmask(sigmask, &sigsaved);
> > +       signal_detected = restore_user_sigmask(sigmask, &sigsaved);
> > +
> > +       if (signal_detected && !error)
> > +               return -EITNR;
> >
> >         return error;
>
> Looks like a reasonable API.
>
> > @@ -2862,7 +2862,7 @@ void restore_user_sigmask(const void __user
> > *usigmask, sigset_t *sigsaved)
> >         if (signal_pending(current)) {
> >                 current->saved_sigmask = *sigsaved;
> >                 set_restore_sigmask();
> > -               return;
> > +               return 0;
>
> Shouldn't that "return 1" if a signal is pending?

Yep, I meant this to be 1.

-Deepa
