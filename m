Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78397628A17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKNUIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 15:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiKNUIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:08:31 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09542AF2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 12:08:29 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id e26so4192755uaa.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/nDHkltTGqA1M/U7EgDCwYcQfakBgnKQ6YU3H3BacY=;
        b=qn4kYbX3oLYGCAAXWUCwdqoYoS9tphOVK50DFhzzxGMmPqsoP8YLsxoJduz2D7Fwfj
         Q8W5UeU0sK6ZJBb5toN0L48t2CyOVpH1bupt51ic5Nv6VOfcdENIwJhPYSu9t6edayxS
         yIsUavy8eCVM7HUZKAwuy2J3H8ngq+EIRiCBSaEWMfn1HJtHcxtCvMZTIea08fj0jg/M
         Y9ePVkr/usYb7mjGujuT9k/S8M446HVKEDCISRuO1VmwXGXYMzcvcXNcxwa+45ed7sa+
         dtJLKF9TiX/ShwZJRE6KI5oy7FhJV765GDmUkiY4f9S4ufC/T082ev8EzAJzUzMr+FnB
         Zw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/nDHkltTGqA1M/U7EgDCwYcQfakBgnKQ6YU3H3BacY=;
        b=Qlni1whKfGD6Ko+adHQIVC13s3LJHnRkRaa+Gr68taqQttZhbZSpZda4X5J/i+Fx8x
         WWJ/Dr6i4ZHqcGXnYxLhRNIz2QSb+rbJAoE2ApRn2BUXqAA1/H0wi3EKAi6HM9fk74dn
         /oqSemCWYt3IkxYc1WTdOIYFeeC+5pxDyHOAX7DrrmzWGdR9ulZyihYGj/ratU6HJKlb
         7xxCvHWh/P4sh9i7eiuQPo56qBydc2rfCmJmTDRhO7vNb44mVDGdjR35Uio5M+4yYvjS
         Kc0lxEa19on4QEf52NBblE9wK7BkDmg1oHTzD4TfOmKC6oUKcvrTskIXTFJUpo5xFAej
         +SfQ==
X-Gm-Message-State: ANoB5pnOApHCirqDIKSW9xDss4+MHfPf0QXnXsdLJk4G4zZZImD/9woB
        Mo4CTQuG+8BSgJrd3FLJzJHRLAA4x8vTV6zOCLEn3LfV1b0=
X-Google-Smtp-Source: AA0mqf42DZOpJHhlVjeCz5p034xKKuvQ1PivECxD76QvvM2dC/S/umz2fWR336Wt1Yj2QURUVdaexWJNm8LVvxKWIqI=
X-Received: by 2002:ab0:71d7:0:b0:3dc:40aa:84cf with SMTP id
 n23-20020ab071d7000000b003dc40aa84cfmr7853000uao.102.1668456508631; Mon, 14
 Nov 2022 12:08:28 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3>
In-Reply-To: <20221114191721.yp3phd5w5cx6nmk2@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Nov 2022 22:08:16 +0200
Message-ID: <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
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

On Mon, Nov 14, 2022 at 9:17 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 07-11-22 16:13:37, Amir Goldstein wrote:
> > On Mon, Nov 7, 2022 at 1:10 PM Jan Kara <jack@suse.cz> wrote:
> > > > > Let's think about the race:
> > > > >
> > > > > > To clarify, the race that I am trying to avoid is:
> > > > > > 1. group B got a pre modify event and recorded the change before time T
> > > > > > 2. The actual modification is performed after time T
> > > > > > 3. group A does not get a pre modify event, so does not record the change
> > > > > >     in the checkpoint since T
> > > > >
> > > > > AFAIU you are worried about:
> > > > >
> > > > > Task T                          Change journal          App
> > > > >
> > > > > write(file)
> > > > >   generate pre_modify event
> > > > >                                 record 'file' as modified
> > > > >                                                         Request changes
> > > > >                                                         Records 'file' contents
> > > > >   modify 'file' data
> > > > >
> > > > > ...
> > > > >                                                         Request changes
> > > > >                                                         Nothing changed but
> > > > > App's view of 'file' is obsolete.
> > > > >
> > > > > Can't we solve this by creating POST_WRITE async event and then use it like:
> > > > >
> > > >
> > > > I like the idea of using POST_WRITE instead of holding sb_writers.
> > > >
> > > > > 1) Set state to CHECKPOINT_PENDING
> > > > > 2) In state CHECKPOINT_PENDING we record all received modify events into a
> > > > >    separate 'transition' stream.
> > > > > 3) Remove ignore marks we need to remove.
> > > >
> > > > Our customer use cases may have many millions of dirs.
> > > > I don't think this solution will be scalable, which is why I use the
> > > > alternating groups to invalidate all the existing ignore marks at once.
> > >
> > > I see. Well, we could also extend FAN_MARK_FLUSH so that you can just
> > > remove all ignore marks from a group so that you don't have to remove them
> > > one-by-one and don't have to switch to a new group. In principle group
> > > teardown does the same. It would allow large scale as well as small scale
> > > users use very similar scheme with single group for switching periods.
> > >
> >
> > Maybe so, I need to try it to see if it can scale.
> >
> > But note that in the alternating group scheme we do NOT need to wait for
> > the old group teardown to complete before returning the results of the query:
> > 1. group T+1 subscribes to some events with FAN_MARK_SYNC
> > 2. group T unsubscribes from those events
> >
> > Step 2 can be done in the background.
> > The query which returns all the files modified between checkpoints T..T+1
> > can already return the changes recorded by group T while group T is
> > shutting down and cleaning up all the evictable marks.
>
> I agree. With my scheme with a single group we first need to remove the
> ignore marks before we can report events for T and start collecting events
> for T+1. Total amount of work is going to be the same but latency of
> reporting is going to be higher. I'd just think that it would not be too bad
> but it needs to be measured. Also from the scheme you've described the
> declaration of a checkpoint didn't seem like a latency sensitive operation?
>

I guess not. I will look into it.

> > > > But I agree that alternating groups should not be a requirement for HSM
> > > > and that for watching smaller subtrees, your suggestion makes more sense.
> > > >
> > > > > 4) Switch to new period & clear CHECKPOINT_PENDING, all events are now
> > > > >    recorded to the new period.
> > > > > 5) Merge all events from 'transition' stream to both old and new period
> > > > >    event streams.
> > > > > 6) Events get removed from the 'transition' stream only once we receive
> > > > >    POST_WRITE event corresponding to the PRE_WRITE event recorded there (or
> > > > >    on crash recovery). This way some events from 'transition' stream may
> > > > >    get merged to multiple period event streams if the checkpoints are
> > > > >    frequent and writes take long.
> > > > >
> > > > > This should avoid the above race, should be relatively lightweight, and
> > > > > does not require major API extensions.
> > > > >
> > > >
> > > > If I am not mistaken, CHECKPOINT_PENDING vs. alternating groups
> > > > is an implementation detail for the HSM.
> > > >
> > > > PRE_WRITE/POST_WRITE and FAN_MARK_SYNC APIs are needed
> > > > for both the implementations (single group scheme needs to flush all
> > > > ignore marks with FAN_MARK_SYNC).
> > >
> > > So why would be FAN_MARK_SYNC needed for the single group scheme? From the
> > > kernel POV the scheme I have proposed does not require any new API changes
> > > besides the POST_WRITE event AFAICT. And possibly FAN_MARK_FLUSH tweak for
> > > more efficient removal of ignore marks. We don't even need the filesystem
> > > freezing (modulo the buffered vs direct IO discussion below).
> > >
> >
> > Maybe I'm wrong, but my understanding is that after:
> > 3) Remove ignore marks we need to remove.
> > a PRE_WRITE event may still be in send_to_group()
> > with one of the "removed" ignore marks and be ignored.
> >
> > So it is not safe to:
> > 4) Switch to new period & clear CHECKPOINT_PENDING
>
> Well, but we'd still get the POST_WRITE event, evaluate this as a write
> straddling checkpoint and include the file into the set of changed files
> for checkpoint T+1 or later. So I don't think synchronize_srcu() is needed
> anywhere?
>

You are probably right. I will double check.

> > My understanding is that
> > synchronize_srcu(&fsnotify_mark_srcu);
> > is needed as barrier between 3) and 4)
> >
> > In any case, even if CHECKPOINT_PENDING can work,
> > with or without FAN_MARK_SYNC, to me personally, understanding
> > the proof of correctness of alternating groups model is very easy,
> > while proving correctness for CHECKPOINT_PENDING model is
> > something that I was not yet able to accomplish.
>
> I agree the scheme with CHECKPOINT_PENDING isn't easy to reason about but I
> don't find your scheme with two groups simpler ;) Let me try to write down
> rationale for my scheme, I think I can even somewhat simplify it:
>
> Write operation consists of:
> generate PRE_WRITE on F
> modify data of F
> generate POST_WRITE on F
>
> Checkpoint consists of:
> clear ignore marks
> report files for which we received PRE_WRITE or POST_WRITE until this
> moment
>
> And the invariant we try to provide is: If file F was modified during
> checkpoint T, then we report F as modified during T or some later
> checkpoint. Where it is matter of quality of implementation that "some
> later checkpoint" isn't too much later than T but it depends on the
> frequency of checkpoints, the length of notification queue, etc. so it is
> difficult to give hard guarantees.
>
> And the argument why the scheme maintains the invariant is that if
> POST_WRITE is generated after "clear ignore marks" finishes, it will get
> delivered and thus F will get reported as modified in some checkpoint once
> the event is processed. If POST_WRITE gets generated before "clear ignore
> marks" finishes and F is among ignored inodes, it means F is already in
> modified set so it will get reported as part of checkpoint T. Also
> application will already see modified data when processing list of modified
> files in checkpoint T.
>
> Simple and we don't even need PRE_WRITE here. But maybe you wanted to
> provide stronger invariant? Like "you are not able to see modified data
> without seeing F as modified?" But what exactly would be a guarantee here?
> I feel I'm missing something here but I cannot quite grasp it at this
> moment...
>

This is the very basic guarantee that the persistent change tracking snapshots
need to provide. If a crash happens after modification is done and before
modification is recorded, we won't detect the modification after reboot.

Maybe "checkpoint" was a bad name to use for this handover between
two subsequent change tracking snapshots.

> > > > I am going to try to implement the PRE/POST_WRITE events and for
> > > > POC I may start with a single group because it may be easier or I may
> > > > implement both schemes, we'll see.
> > >
> > > That would be great. Thank you. Perhaps I'm missing something in my mental
> > > model which would make things impractical :)
> > >
> >
> > Me too. I won't know before I try.
> >
> > FYI, at the moment I am considering not allowing independent
> > subscription for PRE/POST_XXX events, but only subscribe to
> > XXX events and a group with class FAN_CLASS_VFS_FILTER
> > will get both PRE/POST_XXX and won't be able to subscribe
> > to XXX events that do not have PRE_XXX events.
> >
> > The rationale is that if a group subscribes to either PRE/POST_XXX
> > XXX() operation is not going to be on the fast path anyway.
> >
> > This will make it easier to support more PRE/POST_XXX events
> > without using up all the remaining 32bits namespace.
> >
> > Using the high 32bits of mask for PRE events and folding them
> > in the object interest mask with the low 32bit is another thing
> > that I was considering in case you would prefer to allow
> > independent subscription for PRE/POST_XXX events.
>
> So one question: Do you see anything else than POST_WRITE as being useful?
> For directory operations it seems pointless as they hold i_rwsem exclusively
> so I don't see useful distinction between PRE and POST event. For OPEN and
> CLOSE I don't see use either. ACCESS might be the only one where PRE and
> POST would both be useful for something.
>

PRE_ACCESS is used to populate missing data and POST_ACCESS
is irrelevant for that.

PRE_MODIFY is used for something completely different, it is used
for the persistent change tracking and this has to be crash safe, so
exclusive i_rwsem has nothing to do with it.

PRE_MODIFY is called before i_rwsem and before sb_start_write()
so that HSM can record the change intent in the same filesystem
that the change is going to happen (this is a journaled record).

I feel I may have not explained this correctly.
Does this make sense?

Thanks,
Amir.
