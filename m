Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0827A6299AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKONI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 08:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiKONIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:08:44 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2786B0B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 05:08:30 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id g4so6536189vkk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 05:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rSOF8oftx/biH+k+NwMEYd53wHekwBX+kuvaZbBTa5k=;
        b=UPyCCiYYDXTjPNGBz8Uw0bm9+FdEIv4S1QIUGkp3Xio63xHzDdi2PNyKVrBengv3Hx
         EY4Ula8WzBkMwSsceFXJxDqtACdKX6zsvSfm2qhd4nb12+kfSfWY6tCRPPIKrcrz//Hu
         B2EJytU9FHqNA9z+Je95fMjNcW9qeDV3PPLrgGPngfZpBR7MTlyj/aSTva89nCQ/Epcx
         /lRJxlqRuyAlKhQVgUAIXdOIJVm0kTMBqXeTZn8rfgpiI7gFxZvTS3UwT67VrxZXj7Sd
         MYbKB0DcAuAFeEHsw1Yv008+O9iXGxWcD8Ed1T/HUH+HMiBxurlB4R1pFmLSREKkCu99
         bF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSOF8oftx/biH+k+NwMEYd53wHekwBX+kuvaZbBTa5k=;
        b=xaevqSHpWLaQeZDTTKHq6pSLnXLuq4vPgNM1ZF1s6zHJRA+U5fbKUeelaJzTVK1iRL
         hYs4Q7RaJr9xbm40eLhc4B9aLfcH/aHFbwtTSBkk7G81EmsV3kykgUE396pTthKM4alE
         may8/w3eYVm1C7JIu6QHtSbH2QQz7D5QVu2Ulxwsb5e4L3D6Q8I/ZOe9XzX8aqqZw5M4
         G/olBgv0H5gCOgrxTPfGPE8UlS0f5PIfjeckf4E65HKhM3FHLQFLwxano+jTn58T4ii1
         ZZU+qHZM+Qylw+TQl8vGMvhHPgH9zZxV2hCccT0e82XxrT7YRYHymh8ynqXriQUHDSfU
         Nnbw==
X-Gm-Message-State: ANoB5pmQEo5v5mVtjBq18U9BPGWYg/1e+6PG9+ah/Ev51TWWmFGu+OUG
        5yeaLYPKTuSX/2bkdPLJfAH6CW/1VDWIz7WAj1K7o1m6vYQ=
X-Google-Smtp-Source: AA0mqf5adNulyRRGX0Uhz4wCcXVkrZB+HdJMIy6y/uRDuOXmJtHlnTUy30DNLTzQEDKr14Q1/xMoQI381c5iOSeq4Gk=
X-Received: by 2002:a1f:fe4e:0:b0:3ab:a69f:3b7c with SMTP id
 l75-20020a1ffe4e000000b003aba69f3b7cmr8991656vki.36.1668517709578; Tue, 15
 Nov 2022 05:08:29 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
 <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3>
In-Reply-To: <20221115101614.wuk2f4dhnjycndt6@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 15 Nov 2022 15:08:17 +0200
Message-ID: <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
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

On Tue, Nov 15, 2022 at 12:16 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-11-22 22:08:16, Amir Goldstein wrote:
> > On Mon, Nov 14, 2022 at 9:17 PM Jan Kara <jack@suse.cz> wrote:
> > > > My understanding is that
> > > > synchronize_srcu(&fsnotify_mark_srcu);
> > > > is needed as barrier between 3) and 4)
> > > >
> > > > In any case, even if CHECKPOINT_PENDING can work,
> > > > with or without FAN_MARK_SYNC, to me personally, understanding
> > > > the proof of correctness of alternating groups model is very easy,
> > > > while proving correctness for CHECKPOINT_PENDING model is
> > > > something that I was not yet able to accomplish.
> > >
> > > I agree the scheme with CHECKPOINT_PENDING isn't easy to reason about but I
> > > don't find your scheme with two groups simpler ;) Let me try to write down
> > > rationale for my scheme, I think I can even somewhat simplify it:
> > >
> > > Write operation consists of:
> > > generate PRE_WRITE on F
> > > modify data of F
> > > generate POST_WRITE on F
> > >
> > > Checkpoint consists of:
> > > clear ignore marks
> > > report files for which we received PRE_WRITE or POST_WRITE until this
> > > moment
> > >
> > > And the invariant we try to provide is: If file F was modified during
> > > checkpoint T, then we report F as modified during T or some later
> > > checkpoint. Where it is matter of quality of implementation that "some
> > > later checkpoint" isn't too much later than T but it depends on the
> > > frequency of checkpoints, the length of notification queue, etc. so it is
> > > difficult to give hard guarantees.
> > >
> > > And the argument why the scheme maintains the invariant is that if
> > > POST_WRITE is generated after "clear ignore marks" finishes, it will get
> > > delivered and thus F will get reported as modified in some checkpoint once
> > > the event is processed. If POST_WRITE gets generated before "clear ignore
> > > marks" finishes and F is among ignored inodes, it means F is already in
> > > modified set so it will get reported as part of checkpoint T. Also
> > > application will already see modified data when processing list of modified
> > > files in checkpoint T.
> > >
> > > Simple and we don't even need PRE_WRITE here. But maybe you wanted to
> > > provide stronger invariant? Like "you are not able to see modified data
> > > without seeing F as modified?" But what exactly would be a guarantee here?
> > > I feel I'm missing something here but I cannot quite grasp it at this
> > > moment...
> > >
> >
> > This is the very basic guarantee that the persistent change tracking snapshots
> > need to provide. If a crash happens after modification is done and before
> > modification is recorded, we won't detect the modification after reboot.
>
> Right, crash safety was the point I was missing ;) Thanks for reminding me.
> And now I also see why you use filesystem freezing - it is a way to make
> things crash safe as otherwise it is difficult to guard against a race
>
> generate PRE_WRITE for F
>                                 PRE_WRITE ignored because file is already
>                                         modified
>                                 checkpoint happens -> F reported as modified
>                                   contents of F fetched
>
> modify data
> transaction commit
> <crash>
>                                 POST_WRITE never seen so change to F is
>                                   never reported
>
> I just think filesystem freezing is too big hammer for widespread use of
> persistent change tracking.

Note that fsfreeze is also needed to flush dirty data after modify data,
not only to wait for modify data transaction commit.

Otherwise the fetched contents of F will differ from contents of F
after reboot even if we did wait for POST_WRITE.

However, in this case, file contents can be considered corrupted
and rsync, for example, will not detect the change either, because
mtime does match the previously fetched value.

As long as applications write files safely (with rename) fsfreeze is not
needed, but for strict change tracking, fsfreeze is needed, so fsfreeze
is a policy decision of HSM.

> Can't we introduce some SRCU lock / unlock into
> file_start_write() / file_end_write() and then invoke synchronize_srcu()
> during checkpoint after removing ignore marks? It will be much cheaper as
> we don't have to flush all dirty data to disk and also writes can keep
> flowing while we wait for outstanding writes straddling checkpoint to
> complete. What do you think?

Maybe, but this is not enough.
Note that my patches [1] are overlapping fsnotify_mark_srcu with
file_start_write(), so we would need to overlay fsnotify_mark_srcu
with this new "modify SRCU".

[1] https://github.com/amir73il/linux/commits/fanotify_pre_content

>
> The checkpoint would then do:
> start gathering changes for both T and T+1
> clear ignore marks
> synchronize_srcu()
> stop gathering changes for T and report them
>
> And in this case we would not need POST_WRITE as an event.
>

Why then give up on the POST_WRITE events idea?
Don't you think it could work?
Or is it just because you think the generic API would be useful to others?

> The technical problem I see is how to deal with AIO / io_uring because
> SRCU needs to be released in the same context as it is acquired - that
> would need to be consulted with Paul McKenney if we can make it work. And
> another problem I see is that it might not be great to have this
> system-wide as e.g. on networking filesystems or pipes writes can block for
> really long.
>
> Final question is how to expose this to userspace because this
> functionality would seem useful outside of filesystem notification space so
> probably do not need to tie it to that.
>
> Or we could simplify our life somewhat and acquire SRCU when generating
> PRE_WRITE and drop it when generating POST_WRITE. This would keep SRCU
> within fsnotify and would mitigate the problems coming from system-wide
> SRCU. OTOH it will create problems when PRE_WRITE gets generated and
> POST_WRITE would not for some reason. Just branstorming here, I've not
> really decided what's better...
>

What if checkpoint only acquired (and released) exclusive sb_writers without
flushing dirty data.
Wouldn't that be equivalent to the synchronize_srcu() you suggested?

> > Maybe "checkpoint" was a bad name to use for this handover between
> > two subsequent change tracking snapshots.
>
> I'm getting used to the terminology :) But to me it still seems more
> natural to look at the situation as a single stream of events where we fetch
> bulks of changes at certain moments, rather than looking at it as certain
> entities collecting events for different time intervals.
>

I always used "snapshot take" as terminology.
I just now started to use "checkpoint" for this userspace HSM implementation.

I have no objection to single stream, nor to "flush all evictable" command.
I will try to start with this implementation for POC.

Thanks,
Amir.
