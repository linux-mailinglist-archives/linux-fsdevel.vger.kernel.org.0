Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED962C46B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiKPQah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbiKPQaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:30:15 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED360E8D
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 08:24:18 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id q127so18461157vsa.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u+hkIYHb2t6XwinCSdtKVxzSoMWPCTesPrVXSK4i9Iw=;
        b=JZ1nfjPgUDfCF7sywGoNj+6bLRiRbcoby9Ml+FgGf/K98FuTVpKU6cxFrKT8hH1OsL
         W7xBar3JBjUJ2wuZy/JDZ33SOqYZg8Mk0xr1AxNtKgqLXzHhZlOJUKZRctFe6XsLlwpf
         7lrP6TviUc79oAGGhwajGNhCctelSAGU2UQjFI261CFOPhnlZ3jibpin/7SYCg0qtpvr
         D89fed431gJ5Uq2GlgTqDd8TZM8vqLKNEmLsjaDQHwVuxH0HdXkvo/iZZ/B4IyFqoXXM
         MjLwpbplzkm7cLFbt+lDBdi0mAiWj6lJB7EG42dvE8DqqzwVD/csy9FBXyrVLFfDczeD
         dqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+hkIYHb2t6XwinCSdtKVxzSoMWPCTesPrVXSK4i9Iw=;
        b=n/hVPDxco5i7mvzCzcTQApgodtNdSudoxhzzKuKFshPgawoI5BSNDeiZr5D9s6Nt3M
         ERmO6iNlVDKhRW9j1QbHR453wsYSVsSigLwgZ9o1QrD8cZ8k0d0/jSI5kWOsh2ZmnvZ0
         wprFJ62u/QSpBNoIfJ47YpVV9diUPC/LGFfdbzsVyNMowJfqpL4PKqQ2/AsZsI0V+xi3
         U4HEgFXXKk0EypJqcBfMRlAULwZZx7Q8E0An5CN44Xf4+6MR/nUtXAuq4/+eAsWCNjG5
         BeUV/lGHaampQD2DKcCHibVk9jmSYspxt4d03v/PItV0IZz9A+p3TIC5iMthMXzPwKI3
         CbPw==
X-Gm-Message-State: ANoB5pkzViVQIr0GuuhDogr6ID0iEOifx2V7rXUybg8f73avXikeIGgL
        NXMlYoP35oSpISS8PVgEdXe9RGjDpIKu+31txB8=
X-Google-Smtp-Source: AA0mqf5eE/kTKW52fqL8r2FHiJTJOaloNlJvFt5dSwFXr72+ghEV98oGVQjR2wdGTt4NH3kk6p87ag5g0q7uLgOZWNU=
X-Received: by 2002:a67:f1cb:0:b0:3ad:7661:a081 with SMTP id
 v11-20020a67f1cb000000b003ad7661a081mr12035281vsm.2.1668615857904; Wed, 16
 Nov 2022 08:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3> <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3>
In-Reply-To: <20221116105609.ctgh7qcdgtgorlls@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Nov 2022 18:24:06 +0200
Message-ID: <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > Can't we introduce some SRCU lock / unlock into
> > > file_start_write() / file_end_write() and then invoke synchronize_srcu()
> > > during checkpoint after removing ignore marks? It will be much cheaper as
> > > we don't have to flush all dirty data to disk and also writes can keep
> > > flowing while we wait for outstanding writes straddling checkpoint to
> > > complete. What do you think?
> >
> > Maybe, but this is not enough.
> > Note that my patches [1] are overlapping fsnotify_mark_srcu with
> > file_start_write(), so we would need to overlay fsnotify_mark_srcu
> > with this new "modify SRCU".
> >
> > [1] https://github.com/amir73il/linux/commits/fanotify_pre_content
>
> Yes, I know that and frankly, that is what I find somewhat ugly :) I'd rather
> have the "modify SRCU" cover the whole region we need - which means
> including the generation of PRE_MODIFY event.
>

Yeh, it would be great if we can pull this off.

> > > The checkpoint would then do:
> > > start gathering changes for both T and T+1
> > > clear ignore marks
> > > synchronize_srcu()
> > > stop gathering changes for T and report them
> > >
> > > And in this case we would not need POST_WRITE as an event.
> > >
> >
> > Why then give up on the POST_WRITE events idea?
> > Don't you think it could work?
>
> So as we are discussing, the POST_WRITE event is not useful when we want to
> handle crash safety. And if we have some other mechanism (like SRCU) which
> is able to guarantee crash safety, then what is the benefit of POST_WRITE?
> I'm not against POST_WRITE, I just don't see much value in it if we have
> another mechanism to deal with events straddling checkpoint.
>

Not sure I follow.

I think that crash safety can be achieved also with PRE/POST_WRITE:
- PRE_WRITE records an intent to write in persistent snapshot T
  and add to in-memory map of in-progress writes of period T
- When "checkpoint T" starts, new PRE_WRITES are recorded in both
  T and T+1 persistent snapshots, but event is added only to
  in-memory map of in-progress writes of period T+1
- "checkpoint T" ends when all in-progress writes of T are completed

The trick with alternating snapshots "handover" is this
(perhaps I never explained it and I need to elaborate on the wiki [1]):

[1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Modified_files_query

The changed files query results need to include recorded changes in both
"finalizing" snapshot T and the new snapshot T+1 that was started in
the beginning of the query.

Snapshot T MUST NOT be discarded until checkpoint/handover
is complete AND the query results that contain changes recorded
in T and T+1 snapshots have been consumed.

When the consumer ACKs that the query results have been safely stored
or acted upon (I called this operation "bless" snapshot T+1) then and
only then can snapshot T be discarded.

After snapshot T is discarded a new query will start snapshot T+2.
A changed files query result includes the id of the last blessed snapshot.

I think this is more or less equivalent to the SRCU that you suggested,
but all the work is done in userspace at application level.

If you see any problem with this scheme or don't understand it
please let me know and I will try to explain better.


> > > The technical problem I see is how to deal with AIO / io_uring because
> > > SRCU needs to be released in the same context as it is acquired - that
> > > would need to be consulted with Paul McKenney if we can make it work. And
> > > another problem I see is that it might not be great to have this
> > > system-wide as e.g. on networking filesystems or pipes writes can block for
> > > really long.
> > >
> > > Final question is how to expose this to userspace because this
> > > functionality would seem useful outside of filesystem notification space so
> > > probably do not need to tie it to that.
> > >
> > > Or we could simplify our life somewhat and acquire SRCU when generating
> > > PRE_WRITE and drop it when generating POST_WRITE. This would keep SRCU
> > > within fsnotify and would mitigate the problems coming from system-wide
> > > SRCU. OTOH it will create problems when PRE_WRITE gets generated and
> > > POST_WRITE would not for some reason. Just branstorming here, I've not
> > > really decided what's better...
> > >

Seems there are several non trivial challenges to surmount with this
"userspace modification SRCU" idea.

For now, I will stay in my comfort zone and try to make the POC
with PRE/POST_WRITE work and write the proof of correctness.

I will have no objection at all if you figure out how to solve those
issues and guide me to a path for implementing sb_write_srcu.
It will make the userspace implementation much simpler, getting rid
of the in-progress writes in-memory tracking.

> >
> > What if checkpoint only acquired (and released) exclusive sb_writers without
> > flushing dirty data.
> > Wouldn't that be equivalent to the synchronize_srcu() you suggested?
>
> In terms of guarantees it would be equivalent. In terms of impact on the
> system it will be considerably worse. Because SRCU allows new SRCU readers
> to start while synchronize_srcu() is running - so in our case new writes
> can freely run while we are waiting for pending writes to complete. So
> impact of the synchronize_srcu() on system activity will be practically
> unnoticeable. If we use sb_writers as you suggest, it will block all write
> activity until all writes finish. Which can be significant amount of time
> if you have e.g. write(1 GB of data) running.
>

Of course, it was a silly idea.

Thanks,
Amir.
