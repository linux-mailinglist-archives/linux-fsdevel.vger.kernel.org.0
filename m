Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0261F50A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKGONx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 09:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGONv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:13:51 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34C1789C
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 06:13:50 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id g16so6709764vkl.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Nov 2022 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/eo1TOWjveDL/+sJSCUmD9PurD1iwlOLtlcU77UAj74=;
        b=bCC5r1yXk80w867EVtXCj/fDUVD3idaXY8wNmvVsrSHXTaXoRpE/+TgY0obIYizQKu
         AqN1UutNdY0KCihIGx6DzYe42VE03sL5fkOwKVGyrN4nBP5BzTpfEMNwmSCC77T2ln50
         a6OCdL/yt7SbCqjd2xWv8AgDd8wGMJQa9NeNJAIOmkp3nKL71z2aTLO5ogH5jCeSHywH
         0YlGoJEGTLNJaffICUe4fhVYw3p9HdVBrX+l149G+OsA7YrSl99feEdNOJ4K7043z8QB
         Tx+L7AVmEsjX2208eKvljnAEg9iXP8z9RNGT+dho9N7SXCLDF56Mym1/zbcc/MCXL13c
         XL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eo1TOWjveDL/+sJSCUmD9PurD1iwlOLtlcU77UAj74=;
        b=PHC8LaFvpQTIexuw9vP7zHrZdtWgQhNdCepL9gpGKyaBnbRjH7lJFXBpzbj6rFml1P
         TciAfWaW7r82Wscu0rmuQbUZveQSj7v14t5sT90xJUbenqJllMgEz9OFscxtqpsX+Kbg
         6GquGAQyHO3TxybJ2WVPsqQtspr5Y6E+BF66jqzcrOumnKNfXM2ITKRuL+Xx6Gzxelol
         4TyVSby0F/9pM09u+BUSZV1tIFHdj4MgEr8IdjElVf16RGnorKpci3slh7hmlCXNOdgO
         HMgbdzObDWn0sI1ksWpSFJz2J81FLGp/2ZuJ33L26BCYTrFxR6hJistSBMk/XPtHwRTP
         GjnQ==
X-Gm-Message-State: ACrzQf07+jmlVN0WD+uJx1BStoDtIOWef9XreiSmOfGk25OQCwOEjQ9L
        GRR+FUqMrpR3l0FaxhW2AQ8JKSSxjye1xWOY3w9oDDBR1lg=
X-Google-Smtp-Source: AMsMyM4zCyPbjd/6R37aWcNFOD1/wDtgIAuHEocxhUG6AzbqdiuJ7iysX7J4Ehr9XHETB/iixMMogxdljI2Vg9gywK8=
X-Received: by 2002:a05:6122:988:b0:3a9:a908:72dc with SMTP id
 g8-20020a056122098800b003a9a90872dcmr8224340vkd.15.1667830429486; Mon, 07 Nov
 2022 06:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3>
In-Reply-To: <20221107111008.wt4s4hjumxzl5kqj@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 7 Nov 2022 16:13:37 +0200
Message-ID: <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
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

On Mon, Nov 7, 2022 at 1:10 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 04-11-22 10:17:54, Amir Goldstein wrote:
> > On Thu, Nov 3, 2022 at 6:30 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 28-10-22 15:50:04, Amir Goldstein wrote:
> > > > On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > > Questions:
> > > > > > - What do you think about the direction this POC has taken so far?
> > > > > > - Is there anything specific that you would like to see in the POC
> > > > > >   to be convinced that this API will be useful?
> > > > >
> > > > > I think your POC is taking a good direction and your discussion with Dave
> > > > > had made me more confident that this is all workable :). I liked your idea
> > > > > of the wiki (or whatever form of documentation) that summarizes what we've
> > > > > discussed in this thread. That would be actually pretty nice for future
> > > > > reference.
> > > > >
> > > >
> > > > The current state of POC is that "populate of access" of both files
> > > > and directories is working and "race free evict of file content" is also
> > > > implemented (safely AFAIK).
> > > >
> > > > The technique involving exclusive write lease is discussed at [1].
> > > > In a nutshell, populate and evict synchronize on atomic i_writecount
> > > > and this technique can be implemented with upstream UAPIs.
> > >
> > > Not so much i_writecount AFAIU but the generic lease mechanism overall. But
> > > yes, the currently existing APIs should be enough for your purposes.
> > >
> >
> > Right. Do note that the write lease is not reliable enough by itself
> > to provide exclusive access to the content, because:
> > 1. The lease break signal is delivered asynchronously to content evict
> >     program
> > 2. After the lease break timeout expires, reader will get access
> >     to the content even if content eviction is in progress
> >
> > The actual strong exclusive access is provided by the sequence:
> > 1. Open file for write
> > 2. Deny future FAN_OPEN_PERM
> > 3. Take write lease, but just to verify that i_writecount == 1
> >
> > Notice one thing odd is that in do_dentry_open() the sequence is:
> > 1. increment i_writecount
> > 2. security_file_open() => FAN_OPEN_PERM
> > 3. break_lease()
> >
> > However, FAN_OPEN_PERM is blocking and when listener
> > reads the event, you get to:
> > created_fd() => ... do_dentry_open(f_mode=FMODE_NONOTIFY):
> > 4. may increment i_writecount
> > 5. security_file_open() => FAN_OPEN_PERM skipped
> > 6. break_lease() => send lease break signal
> >
> > The result is a bit non intuitive:
> >
> > If a new open is attempted during content evict, the new open will be
> > blocked for the lease timeout, before the listener even gets a chance
> > to respond.
> >
> > But if lease timeout has expired and the event listener denied the open,
> > the lease break signal will still be delivered to the content evict program,
> > despite the fact that the open is not going to proceed.
>
> I see. I'd just note that allowing FID mode for permission events would
> solve both these problems, won't it?
>

Yes, it would.
event_f_flags = O_PATH also does not have this wrinkle.

Originally, I had considered using FIDs in the permission events,
but I realized the event->fd is used as a key to the permission response,
so I would have had to replace event->fd with some response cookie.

Anyway, this oddity is not a problem for me now.

[...]

> > > Let's think about the race:
> > >
> > > > To clarify, the race that I am trying to avoid is:
> > > > 1. group B got a pre modify event and recorded the change before time T
> > > > 2. The actual modification is performed after time T
> > > > 3. group A does not get a pre modify event, so does not record the change
> > > >     in the checkpoint since T
> > >
> > > AFAIU you are worried about:
> > >
> > > Task T                          Change journal          App
> > >
> > > write(file)
> > >   generate pre_modify event
> > >                                 record 'file' as modified
> > >                                                         Request changes
> > >                                                         Records 'file' contents
> > >   modify 'file' data
> > >
> > > ...
> > >                                                         Request changes
> > >                                                         Nothing changed but
> > > App's view of 'file' is obsolete.
> > >
> > > Can't we solve this by creating POST_WRITE async event and then use it like:
> > >
> >
> > I like the idea of using POST_WRITE instead of holding sb_writers.
> >
> > > 1) Set state to CHECKPOINT_PENDING
> > > 2) In state CHECKPOINT_PENDING we record all received modify events into a
> > >    separate 'transition' stream.
> > > 3) Remove ignore marks we need to remove.
> >
> > Our customer use cases may have many millions of dirs.
> > I don't think this solution will be scalable, which is why I use the
> > alternating groups to invalidate all the existing ignore marks at once.
>
> I see. Well, we could also extend FAN_MARK_FLUSH so that you can just
> remove all ignore marks from a group so that you don't have to remove them
> one-by-one and don't have to switch to a new group. In principle group
> teardown does the same. It would allow large scale as well as small scale
> users use very similar scheme with single group for switching periods.
>

Maybe so, I need to try it to see if it can scale.

But note that in the alternating group scheme we do NOT need to wait for
the old group teardown to complete before returning the results of the query:
1. group T+1 subscribes to some events with FAN_MARK_SYNC
2. group T unsubscribes from those events

Step 2 can be done in the background.
The query which returns all the files modified between checkpoints T..T+1
can already return the changes recorded by group T while group T is
shutting down and cleaning up all the evictable marks.

> > But I agree that alternating groups should not be a requirement for HSM
> > and that for watching smaller subtrees, your suggestion makes more sense.
> >
> > > 4) Switch to new period & clear CHECKPOINT_PENDING, all events are now
> > >    recorded to the new period.
> > > 5) Merge all events from 'transition' stream to both old and new period
> > >    event streams.
> > > 6) Events get removed from the 'transition' stream only once we receive
> > >    POST_WRITE event corresponding to the PRE_WRITE event recorded there (or
> > >    on crash recovery). This way some events from 'transition' stream may
> > >    get merged to multiple period event streams if the checkpoints are
> > >    frequent and writes take long.
> > >
> > > This should avoid the above race, should be relatively lightweight, and
> > > does not require major API extensions.
> > >
> >
> > If I am not mistaken, CHECKPOINT_PENDING vs. alternating groups
> > is an implementation detail for the HSM.
> >
> > PRE_WRITE/POST_WRITE and FAN_MARK_SYNC APIs are needed
> > for both the implementations (single group scheme needs to flush all
> > ignore marks with FAN_MARK_SYNC).
>
> So why would be FAN_MARK_SYNC needed for the single group scheme? From the
> kernel POV the scheme I have proposed does not require any new API changes
> besides the POST_WRITE event AFAICT. And possibly FAN_MARK_FLUSH tweak for
> more efficient removal of ignore marks. We don't even need the filesystem
> freezing (modulo the buffered vs direct IO discussion below).
>

Maybe I'm wrong, but my understanding is that after:
3) Remove ignore marks we need to remove.
a PRE_WRITE event may still be in send_to_group()
with one of the "removed" ignore marks and be ignored.

So it is not safe to:
4) Switch to new period & clear CHECKPOINT_PENDING

My understanding is that
synchronize_srcu(&fsnotify_mark_srcu);
is needed as barrier between 3) and 4)

In any case, even if CHECKPOINT_PENDING can work,
with or without FAN_MARK_SYNC, to me personally, understanding
the proof of correctness of alternating groups model is very easy,
while proving correctness for CHECKPOINT_PENDING model is
something that I was not yet able to accomplish.

> > I am going to try to implement the PRE/POST_WRITE events and for
> > POC I may start with a single group because it may be easier or I may
> > implement both schemes, we'll see.
>
> That would be great. Thank you. Perhaps I'm missing something in my mental
> model which would make things impractical :)
>

Me too. I won't know before I try.

FYI, at the moment I am considering not allowing independent
subscription for PRE/POST_XXX events, but only subscribe to
XXX events and a group with class FAN_CLASS_VFS_FILTER
will get both PRE/POST_XXX and won't be able to subscribe
to XXX events that do not have PRE_XXX events.

The rationale is that if a group subscribes to either PRE/POST_XXX
XXX() operation is not going to be on the fast path anyway.

This will make it easier to support more PRE/POST_XXX events
without using up all the remaining 32bits namespace.

Using the high 32bits of mask for PRE events and folding them
in the object interest mask with the low 32bit is another thing
that I was considering in case you would prefer to allow
independent subscription for PRE/POST_XXX events.

Thanks,
Amir.
