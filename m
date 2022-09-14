Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E695B8205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiINH2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINH2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:28:04 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09426BD6F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 00:28:00 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o123so14951875vsc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wxeXHEzzXvBy5TmvIkfTh9d+b1qpGbPvhAp2hAEy35Q=;
        b=mjC40ImUyyn3wYx9S79RoOvwg0HdBFxj67XlUXPSliuSoXpPDxASLBM9hf2KApl0Wb
         GEvcFlEzceTK6IGQOOZZ2L+Y3eO6F8/kT3nRy9z2YQHJ46wXM8M8rXC1bdG8t1o5/Dv2
         OaJRrBpgbSPYrdgBFYGG2QLo83qVvbuYQx8tnWQwxE7yePWuD/ZycmJ3ibtefvvoI9x0
         NwUqsHzPG+Y93oJdkcdYT/Jr11mvPts+HRw+bxHvjiVKrS5KB0sp3+y1C63/X/YaunWS
         N0nvtqqlP88wawAynYX9lm9gouHB7itkmymziy4Tr82NDiOScXN4G0L8yswcCHay2nZF
         P5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wxeXHEzzXvBy5TmvIkfTh9d+b1qpGbPvhAp2hAEy35Q=;
        b=TqxUab6FT1f/vakeVk7iMNYhVu7KtBFRauzDPHhymSl5BkyYu9oUtBDZyGiFaJtA2X
         UeKob7fNm3WfDniwoDAoySbYryuc7qCM3fEgVQDZv8+JuWpdOagwzT+2dgiQyKt5wVll
         9YXrjBy6vayyEtArUzkt7qX+lnlteRpUQDXGd69qNIfoDdj2nB05IsM9whZ8zboq55iy
         akI3muC5X2455oz3ROebKxObVD5Ig+9xtD+8Pqyox8L8NJQjICq+hxpN5GM/S1aQOhIG
         mCjaNgNUIt7AWhLKfqeB8g5pAjTiA1nbaVE4fxs1uX0X8Azw/RFF2Sr4N+TIGImY31Rt
         IgIA==
X-Gm-Message-State: ACgBeo0l/s36B9zUwD1D3wJBgPIXHJcFxSSsGgH7KXGw/fG840IEwZgc
        KqLuWgVEL9+tjVnxjgS3n8qAVwUH+eQDIvUSx4/u9gxcID4=
X-Google-Smtp-Source: AA6agR4Sg+kz+VnL7AIb0oqjM1dPBbRA0M9FGjvtbelMYbgwJgebYRqYAB3qAT7vI64o8E77Vs/yQ3tt20wzahnqsn8=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr12106377vsh.3.1663140479872; Wed, 14 Sep
 2022 00:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Sep 2022 10:27:48 +0300
Message-ID: <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 7:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 3:57 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > On Sun 11-09-22 21:12:06, Amir Goldstein wrote:
> > > I wanted to consult with you about preliminary design thoughts
> > > for implementing a hierarchical storage manager (HSM)
> > > with fanotify.
> > >

I feel that the discussion is losing focus, so let me try to refocus
and list pros and cons for different options for HSM API...

> > > I have been in contact with some developers in the past
> > > who were interested in using fanotify to implement HSM
> > > (to replace old DMAPI implementation).
> >
> > Ah, DMAPI. Shiver. Bad memories of carrying that hacky code in SUSE kernels
> > ;)

For the record, DMAPI is still partly supported on some proprietary
filesystems, but even if a full implementation existed, this old API
which was used for tape devices mostly is not a good fit for modern
day cloud storage use cases.

> >
> > So how serious are these guys about HSM and investing into it?
>
> Let's put it this way.
> They had to find a replacement for DMAPI so that they could stop
> carrying DMAPI patches, so pretty serious.
> They had to do it one way or the other.
>

As mentioned earlier, this is an open source HSM project [1]
with a release coming soon that is using FAN_OPEN_PERM
to migrate data from the slower tier.

As you can imagine, FAN_OPEN_PERM can only get you as far
as DMAPI but not beyond and it leaves the problem of setting the
marks on all punched files on bringup.

>
> But I do know for a fact that there are several companies out there
> implementing HSM to tier local storage to cloud and CTERA is one of
> those companies.
>
> We use FUSE to implement HSM and I have reason to believe that
> other companies do that as well.
>

FUSE is the most flexible API to implement HSM, but it suffers
from performance overhead in the "fast" path due to context switches
and cache line bounces.

FUSE_PASSTHROUGH patches [2] address this overhead for
large files IO. I plan to upstream those patches.

FUSE-BPF [3] and former extFUSE [4] projects aim to address this
overhead for readdir and other operations.

This is an alluring option for companies that already use FUSE for HSM,
because they will not need to change their implementation much,
but my gut feeling is that there are interesting corner cases lurking...

> > kernel is going to be only a small part of what's needed for it to be
> > useful and we've dropped DMAPI from SUSE kernels because the code was
> > painful to carry (and forwardport + it was not of great quality) and the
> > demand for it was not really big...

Note that the demand was not big for the crappy DMAPI ;)
it does not say anything about the demand for HSM solutions,
which exists and is growing IMO.

> > So I'd prefer to avoid the major API
> > extension unless there are serious users out there - perhaps we will even
> > need to develop the kernel API in cooperation with the userspace part to
> > verify the result is actually usable and useful.

Yap. It should be trivial to implement a "mirror" HSM backend.
For example, the libprojfs [5] projects implements a MirrorProvider
backend for the Microsoft ProjFS [6] HSM API.

>
> > > Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> > > should be enough to implement a basic HSM, but it is not
> > > sufficient for implementing more advanced HSM features.
> > >
[...]
> > My main worry here would be that with FAN_FILESYSTEM marks, there will be
> > far to many events (especially for the lookup & access cases) to reasonably
> > process. And since the events will be blocking, the impact on performance
> > will be large.
> >
>
> Right. That problem needs to be addressed.
>
> > I think that a reasonably efficient HSM will have to stay in the kernel
> > (without generating work for userspace) for the "nothing to do" case. And
> > only in case something needs to be migrated, event is generated and
> > userspace gets involved. But it isn't obvious to me how to do this with
> > fanotify (I could imagine it with say overlayfs which is kind of HSM
> > solution already ;)).
> >

It's true, overlayfs is kind of HSM, but:
- Without swap out to slower tier
- Without user control over method of swap in from slower tier

On another thread regarding FUSE-BPF, Miklos also mentioned
the option to add those features to overlayfs [7] to make it useful
as an HSM kernel driver.

So we have at least three options for an HSM kernel driver (FUSE,
fanotify, overlayfs), but none of them is still fully equipped to drive
a modern HSM implementation.

What is clear is that:
1. The fast path must not context switch to userspace
2. The slow path needs an API for calling into user to migrate files/dirs

What is not clear is:
1. The method to persistently mark files/dirs for fast/slow path
2. The API to call into userspace

Overlayfs provides a method to mark files for slow path
('trusted.overlay.metacopy' xattr), meaning file that has metadata
but not the data, but overlayfs does not provide the API to perform
"user controlled migration" of the data.

Instead of inventing a new API for that, I'd rather extend the
known fanotify protocol and allow the new FAN_XXX_PRE events
only on filesystems that have the concept of a file without its content
(a.k.a. metacopy).

We could say that filesystems that support fscache can also support
FAN_XXX_PRE events, and perhaps cachefilesd could make use of
hooks to implement user modules that populate the fscache objects
out of band.

There is the naive approach to interpret a "punched hole" in a file as
"no content" as DMAPI did, to support FAN_XXX_PRE events on
standard local filesystem (fscache does that internally).
That would be an opt-in via fanotify_init() flag and could be useful for
old DMAPI HSM implementations that are converted to use the new API.

Practically, the filesystems that allow FAN_XXX_PRE events
on punched files would need to advertise this support and maintain
an inode flag (i.e. I_NODATA) to avoid a performance penalty
on every file access. If we take that route, though, it might be better
off to let the HSM daemon set this flag explicitly (e.g. chattr +X)
when punching holes in files and removing the flag explicitly
when filling the holes.

And there is the most flexible option of attaching a BFP filter to
a filesystem mark, but I am afraid that this program will be limited
to using information already in the path/dentry/inode struct.
At least HSM could use an existing arbitrary inode flag
(e.g. chattr+i) as "persistent marks".

So many options! I don't know which to choose :)

If this plan sounds reasonable, I can start with a POC of
"user controlled copy up/down" for overlayfs, using fanotify
as the user notification protocol and see where it goes from there.

Thanks for reading my brain dump ;)

Amir.

[1] https://deepspacestorage.com/
[2] https://lore.kernel.org/linux-fsdevel/20210125153057.3623715-1-balsini@android.com/
[3] https://lpc.events/event/16/contributions/1339/attachments/945/1861/LPC2022%20Fuse-bpf.pdf
[4] https://github.com/extfuse/extfuse
[5] https://github.com/github/libprojfs
[6] https://docs.microsoft.com/en-us/windows/win32/api/_projfs/
[7] https://lore.kernel.org/linux-fsdevel/CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com/
