Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F34634222
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiKVRDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 12:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiKVRDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:03:45 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DF786E5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 09:03:44 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3938dc90ab0so131494847b3.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HEXQfqGAqpuF6hSUcb7SlcOMDgXGccH04+ONdayZ3lM=;
        b=LCR3veMGIwC1TnF0krHzGw8wTvlHpna0+qhNWl671YAd5bXCtUqrpAvalDH/04fwAV
         S+JJKdZWFIWnkaqdRXKY2ZjqQdmK8Fs6CyK0l+YMeZK/7YjWtFUFaPSLV6tz2txo/9Id
         Fdc1ChwhnTrtqe2r3iJKE19smY3rVs4DHS1PZRqyFZFWYOMVNONWsY8nixIb5I0KETzS
         /U8UxwtN9BCsinzQ2ud4k19R7589PGorIehx7Zj8I33Kf533ydZthxupnTqZTL4uVueD
         SsPuoF0uL1XcLxBZ2bvyoj4rSIi6SGfaT6HWNrFtU4HHWFoK8UypaFMfz3AX7zdAW94B
         ZTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEXQfqGAqpuF6hSUcb7SlcOMDgXGccH04+ONdayZ3lM=;
        b=iax/Q+TBhCorx/FpsnAkN3eDUQvkLldk2niOAOdz8gNpSLtFDEj5iqH7iEx9zdJzZO
         3X2eZbb/sZ5s5dkcD7veryJEatPlA5CIbmUJVW7UwR9BZzicGn19o2wrQ8VFoJg7542N
         o3UTWOep44Tse7Q9bkTMKq6v4H6bgu61QLqec3uXelaxfX2/sPFmHENBHFLlPw19mpaE
         OgMbta58kp0wAS/Jsp/67jwUdIvQ9rSPCbp42BBaUFPlJ3XZ3ElThci2oplM1k7faAV/
         1RBwItU5szjB8PbtTKr23mnx1+2NIYVS2SOV7PWSMmUL7EzNxDedL/WpGV1TNBarsRDM
         zcSg==
X-Gm-Message-State: ANoB5pmryaUuUgOjnd4Vx6A7UlEve0mXGkh8Fy4i3OMP76rGfTXuOwBZ
        AWIBilnSj57GUU23g5SZGXR2Y7qCPzUCjnA80WwiQQOnRROt9A==
X-Google-Smtp-Source: AA0mqf5SQTSTO7DrO3KtDZLop3CqMSfLwF08CyGf0Y5I6mubBHk/XqwMCg1xJqGSGBoQ0QugCBsmmiLQLYn29NZIixY=
X-Received: by 2002:a81:48d1:0:b0:370:6c89:4b76 with SMTP id
 v200-20020a8148d1000000b003706c894b76mr6681250ywa.130.1669136623151; Tue, 22
 Nov 2022 09:03:43 -0800 (PST)
MIME-Version: 1.0
References: <e102081e103d897cc0b76908acdac1bf0b65050d.1669130955.git.pabeni@redhat.com>
 <CACSApvYq=r3YAyZ_XceoRz1BuU+Q+MypXaG_S1fMoYCyFEpbrw@mail.gmail.com> <819762b6eb549f74d0ebbb6663f042ae9b6cd86d.camel@redhat.com>
In-Reply-To: <819762b6eb549f74d0ebbb6663f042ae9b6cd86d.camel@redhat.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Tue, 22 Nov 2022 12:03:06 -0500
Message-ID: <CACSApvaMCeKLn88uNAWOxrzPWC9Rr2BZLa3--6TQuY6toYZdOg@mail.gmail.com>
Subject: Re: [REPOST PATCH] epoll: use refcount to reduce ep_mutex contention
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jason Baron <jbaron@akamai.com>,
        Roman Penyaev <rpenyaev@suse.de>, netdev@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:59 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hello,
>
> Thank you for the prompt feedback!
>
> On Tue, 2022-11-22 at 11:18 -0500, Soheil Hassas Yeganeh wrote:
> > On Tue, Nov 22, 2022 at 10:43 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > >
> > > We are observing huge contention on the epmutex during an http
> > > connection/rate test:
> > >
> > >  83.17% 0.25%  nginx            [kernel.kallsyms]         [k] entry_SYSCALL_64_after_hwframe
> > > [...]
> > >            |--66.96%--__fput
> > >                       |--60.04%--eventpoll_release_file
> > >                                  |--58.41%--__mutex_lock.isra.6
> > >                                            |--56.56%--osq_lock
> > >
> > > The application is multi-threaded, creates a new epoll entry for
> > > each incoming connection, and does not delete it before the
> > > connection shutdown - that is, before the connection's fd close().
> > >
> > > Many different threads compete frequently for the epmutex lock,
> > > affecting the overall performance.
> > >
> > > To reduce the contention this patch introduces explicit reference counting
> > > for the eventpoll struct. Each registered event acquires a reference,
> > > and references are released at ep_remove() time. ep_free() doesn't touch
> > > anymore the event RB tree, it just unregisters the existing callbacks
> > > and drops a reference to the ep struct. The struct itself is freed when
> > > the reference count reaches 0. The reference count updates are protected
> > > by the mtx mutex so no additional atomic operations are needed.
> > >
> > > Since ep_free() can't compete anymore with eventpoll_release_file()
> > > for epitems removal, we can drop the epmutex usage at disposal time.
> > >
> > > With the patched kernel, in the same connection/rate scenario, the mutex
> > > operations disappear from the perf report, and the measured connections/rate
> > > grows by ~60%.
> >
> > I locally tried this patch and I can reproduce the results.  Thank you
> > for the nice optimization!
> >
> > > Tested-by: Xiumei Mu <xmu@redhat.com>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > This is just a repost reaching out for more recipents,
> > > as suggested by Carlos.
> > >
> > > Previous post at:
> > >
> > > https://lore.kernel.org/linux-fsdevel/20221122102726.4jremle54zpcapia@andromeda/T/#m6f98d4ccbe0a385d10c04fd4018e782b793944e6
> > > ---
> > >  fs/eventpoll.c | 113 ++++++++++++++++++++++++++++---------------------
> > >  1 file changed, 64 insertions(+), 49 deletions(-)
> > >
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 52954d4637b5..6e415287aeb8 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -226,6 +226,12 @@ struct eventpoll {
> > >         /* tracks wakeup nests for lockdep validation */
> > >         u8 nests;
> > >  #endif
> > > +
> > > +       /*
> > > +        * protected by mtx, used to avoid races between ep_free() and
> > > +        * ep_eventpoll_release()
> > > +        */
> > > +       unsigned int refcount;
> >
> > nitpick: Given that napi_id and nest are both macro protected, you
> > might want to pull it right after min_wait_ts.
>
> Just to be on the same page: the above is just for an aesthetic reason,
> right? Is there some functional aspect I don't see?

Yes, a nitpick completely for aesthetics.  It's also slightly easier
to think about the size, alignment and padding of the structure that
way. Please feel free to ignore.

> [...]
>
> > > @@ -2165,10 +2174,16 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
> > >                         error = -EEXIST;
> > >                 break;
> > >         case EPOLL_CTL_DEL:
> > > -               if (epi)
> > > -                       error = ep_remove(ep, epi);
> > > -               else
> > > +               if (epi) {
> > > +                       /*
> > > +                        * The eventpoll itself is still alive: the refcount
> > > +                        * can't go to zero here.
> > > +                        */
> > > +                       WARN_ON_ONCE(ep_remove(ep, epi));
> >
> > There are similar examples of calling ep_remove() without checking the
> > return value in ep_insert().
>
> Yes, the error paths in ep_insert(). I added a comment referring to all
> of them, trying to explain that ep_dispose() is not needed there.
>
> > I believe we should add a similar comment there, and maybe a
> > WARN_ON_ONCE.  I'm not sure, but it might be worth adding a new helper
> > given this repeated pattern?
>
> I like the idea of such helper. I'll use it in the next iteration, if
> there is a reasonable agreement on this patch.
>
> Whould 'ep_remove_safe()' fit as the helper's name?

'ep_remove_safe()' sounds great to me.

Thanks!
Soheil

> Thanks,
>
> Paolo
>
