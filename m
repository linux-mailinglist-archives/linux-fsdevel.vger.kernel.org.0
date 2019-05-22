Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD726282
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfEVKyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 06:54:15 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:37885 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfEVKyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 06:54:14 -0400
Received: by mail-yb1-f175.google.com with SMTP id z12so689701ybr.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YXAoK9ND9R0VjTzvvygyAwPpdr0q18CVJWnET8pVec=;
        b=U9s6Yi62ozgZMkfw9kRXMJLM0jVNZ8E7ovsQLYSa0F03IfFDJ3r03iHO3IE9Mul+CN
         tiflzeKGFrTBIiQzua8Fj2mQGWkKEpiXL3KEnXJRkz0DrPar/uP+4U0BHQVuF7qevOcu
         GwEO7vHXUs+kGH7P30jqxU+uG9oOoU77Ra/B5Zuqtm+uHDjrsZMJZy26Exbi/JwhLOKP
         iltD2Yr8Z084vCNsx2yDKSd9i8zyLLbtH26+GO3nCaVuQwUgwY2fyWZKjX3Ocob42Ea0
         ntzEhOVbND1t0wmFXof91ERyRFS40LqXcJsqWr7ez2uA8W/1dXvqoMTaUv/m2+FEshDL
         Iyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YXAoK9ND9R0VjTzvvygyAwPpdr0q18CVJWnET8pVec=;
        b=QXAoyfyxt7rUFlQg6rtWfcllXxzMxYox7RP/AqZ3JZT4qy9LBPHbAYmgWfOKwAs8sw
         40oIhdEWzZdhWFB7wLpM/OigPyELJa9oE9dtw8qQ5lxUYwAWM1gijNBANoMNMn+JYvM2
         uEnciTeA45O9tXQ/+Nn9qNmj1HmG2RxHsaJAnR3plP+aJ/SrraBJzTMjeBtuej4AcDja
         GRHW3V8Z9C5iakJrJNFh0PPzGth26/yTw0fBpOS7mAUiLMJumoPNZqg4pophpKFsGW0e
         wkRxxZnuRlPzIUURuMy8MFP5fp8KoEBRlY1C+RrDlGsQy9SJxqR+BR4mA/3NiG/1GdBU
         0QBg==
X-Gm-Message-State: APjAAAVJTPISRQkjZWsOVbHDVsqun1+bn0cpGlcW21TUqPZcBSUCFA17
        yvycC+M4DUY3VcTqeoUE+TWxqXCYx1ek+KhYCvY=
X-Google-Smtp-Source: APXvYqyueEUTPBb5EmldyBRWSGqXqJTEVhU+eSvZ7ePOcXMuGm4t5pPmQEffr0SBAh9CnD2YwlesYsn89/8UFhFpHos=
X-Received: by 2002:a25:a304:: with SMTP id d4mr22581109ybi.126.1558522453314;
 Wed, 22 May 2019 03:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com> <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
In-Reply-To: <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 May 2019 13:54:01 +0300
Message-ID: <CAOQ4uxi4dzxArY24YO=+kBCK2gGoq3Ptb8WkzCqSogPgU_R3dQ@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Yurii Zubrytskyi <zyy@google.com>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 4:32 AM Yurii Zubrytskyi <zyy@google.com> wrote:
>
> On Thu, May 9, 2019 at 1:15 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I think you have made the right choice for you and for the product you are
> > working on to use an isolated module to provide this functionality.
> >
> > But I assume the purpose of your posting was to request upstream inclusion,
> > community code review, etc. This is not likely to happen when the
> > implementation and design choices are derived from Employer needs vs.
> > the community needs. Sure, you can get high level design review, which is
> > what *this* is, but I recon not much more.
> >
> > This discussion has several references to community projects that can benefit
> > from this functionality, but not in its current form.
> >
> > This development model has worked well in the past for Android and the Android
> > user base leverage could help to get you a ticket to staging, but eventually,
> > those modules (e.g. ashmem) often do get replaced with more community oriented
> > APIs.
> >
>
> Hi fsdevel
> I'm Yurii, and I work with Eugene on the same team and the same project.
>
> I want to explain how we ended up with a custom filesystem instead of
> trying to improve FUSE for everyone, and
> why we think (maybe incorrectly) that it may be still pretty useful
> for the community.
> As the project goal was to allow instant (-ish) deployment of apps
> from the dev environment to Android phone, we were hoping to
> stick with plain FUSE filesystem, and that's what we've done at first.
> But it turned out that even with the best tuning it was still
> really slow and battery-hungry (phones spent energy faster than they
> were charging over the cord).
> At this point we've already collected the profiles for the filesystem
> usage, and also figured out what features are essential
> to make it usable for streaming:
> 1. Random reads are the most common -> 4kb-sized read is the size we
> have to support, and may not go to usermode on each of those
> 2. Android tends to list the app directory and stat files in it often
> -> these operations need to be cached in kernel as well
> 3. Because of *random* reads streaming files sequentially isn't
> optimal -> need to be able to collect read logs from first deployment
>     and stream in that order next time on incremental builds
> 4. Devices have small flash cards, need to deploy uncompressed game
> images for speed and mmap access ->
>     support storing 4kb blocks compressed
> 4.1. Host computer is much better at compression -> support streaming
> compressed blocks into the filesystem storage directly, without
>        recompression on the phone

Aha. It wasn't clear to me that block aligned decompression of a specific
compression format was part of the filesystem.
eromfs (also for Android) also provides new block aligned decompression
subsystem and I have heard the maintainer say that the decompression
engine could be moved into a library like fs/crypt so that other filesystem
could support the same on-the-fly decryption engine.

> 5. Android has to verify app signature for installation -> need to
> support per-block signing and lazy verification
> 5.1. For big games even per-block signature data can be huge, so need
> to stream even the signatures
> 6. Development cycle is usually edit-build-try-edit-... -> need to
> support delta-patches from existing files
> 7. File names for installed apps are standard and different from what
> they were on the host ->
>     must be able to store user-supplied 'key' next to each file to identify it
> 8. Files never change -> no need to have complex code for mutable data
> in the filesystem
>
> In the end, we saw only two ways how to make all of this work: either
> take sdcardfs as a base and extend it, or change FUSE to
> support cache in kernel; and as you can imagine, sdcardfs route got
> thrown out of the window immediately after looking at the code.
> But after learning some FUSE internals and its code what we found out
> is that to make it do all the listed things we'd basically have
> to implement a totally new filesystem inside of it. The only real use
> of FUSE that remained was to send FUSE_INIT, and occasional
> read requests. Everything else required, first of all, making a cache
> object inside FUSE intercept every message before it goes to the
> user mode, and also adding new specialized commands initiated by the
> usermode (e.g. prefetching data that hasn't been requested
> yet, or streaming hashes in). Some things even didn't make sense for a
> generic usecase (e.g. having a limited circular buffer of read
> blocks in kernel that user can ask for and flush).

As Miklos pointed out and I as well in a previous message, it
appears that you missed a few caching capabilities of FUSE -
Those capabilities may or may not make sense to extend using
fscache or by other means - I haven't studied this myself, but the
study you publish does not convince me that this option has been
fully exhausted.

>
> In the end, after several tries we just came to a conclusion that the
> very set of original requirements is so specific that, funny enough,
> anyone who wants to create a lazy-loading experience would hit most of
> them, while anyone who's doing something else, would miss
> most of them. That's the main reason to go with a separate specialized
> driver module, and the reason to share it with the community -
> we have a feeling that people will benefit from a high-quality
> implementation of lazy loading in kernel, and we will benefit from the
> community support and guiding.
>
> Again, we all are human and can be wrong at any step when making
> conclusions. E.g. we didn't know about the fscache subsystem,
> and were only planning to create a cache object inside FUSE instead.
> But for now I still feel that our original research stands, and
> that in the long run specialized filesystem serves its users much

"serves its users" - that's the difference between our perspective.
I am not thinking only on users of incfs as you defined it, but on a wider
variety of users that need the functionality of user space filesystem with
kernel "fast path" optimizations.

> better than several scattered changes in other places that all
> pretty much look like the same filesystem split into three parts and
> adopted to the interfaces those places force onto it. Even more,
> those changes and interfaces look quite strange on their own, when not
> used together.
>
> Please tell me what you think about this whole thing. We do care about
> the feature in general, not about making it
> look as we've coded it right now. If you feel that making fscache
> interface that covers the whole FUSE usermode
> messages + allows for those requirements is useful beyond streaming,
> we'll investigate that route further.
>

Let me answer that with an anecdote.
The very first FUSE filesystem was AVFS (http://avf.sourceforge.net/).
It provides a VFS interface to archives (e.g. zip).
It is quite amusing that this is exactly what incfs in meant to provide
(APK is a zip file, apparently with some new block aligned compression?).

Now forget Android and APK download and imagine a huge tar archive
on a slow tape device, which can be browsed using AVFS/FUSE.
In that case, would AVFS users benefit from local disk caching of
pieces of archive read from the tape? listing read from the tape? (Yes)
Would AVFS users benefit from storing the compressed blocks in
local disk cache and decompressing them on first read? (Sure why not).

The decision of whether or not incfs functionality should be built into
FUSE needs to take into account all the FUSE filesystems out there.
How many of them would benefit from the extended functionality?
My personal guess is that the answer is "a lot".

Thanks,
Amir.
