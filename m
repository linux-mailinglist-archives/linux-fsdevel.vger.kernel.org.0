Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE8245A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 03:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEUBcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 21:32:50 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44556 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfEUBcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 21:32:50 -0400
Received: by mail-lj1-f169.google.com with SMTP id e13so14220853ljl.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2019 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4fczlIAu46Dfdk97JDXeih55bEKhVpj+7BBQoa4D2So=;
        b=jyBYHefXrnbXbU7iTypnEZZM9UPo0KJOue1Epino2d3PlrAr3QEqk7Zf2D+KML3q7e
         9n26dOBgbNXwkvDFsbU87ZCm0k9QFDJszXkwSQ+jZNRtS9UDOr/OePe5opcLHM/AlmNx
         JIFY8kzbQ4AdcINFW/+EhHz2SS/HhzIz4DJFlYBDe5GA9SxipXOufI8HoaIzH4wZjtXK
         +Hr0Z/0RODgV1hG06KFeMEHwrKXG8iPEVf0EHX64PlDx30yFEHeFwpbzo28wmUxu0YNC
         MI7QWEiXMewaivfN/zqlg6TgBYKVHd3nlTeER1n5w1nUNPS/w9sbH0RDO8EvBfph4X2/
         V2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4fczlIAu46Dfdk97JDXeih55bEKhVpj+7BBQoa4D2So=;
        b=lRYSxMXGpqAqEeqLaOQfl9yUICYrOLjZpurOqzvOyRQ92bIN9ZF5ZJrhB0ry/KeMVD
         b4iBP94MZUnt7gNnqsiktQJonC80q8NiDw1QZCaLf0UvQ3Z9pUGkaU4mM74YhjIsNUCu
         CxywS7V3DJRfK9gQpZVvxz/aW5Ru33k4DN5VkCF/1Wt5djRg5LbvqiDPu74pKWklIZo3
         +pbjZyUF5f9Uloz0u/lxeabT6v6FcD2NF73gqmQCNAXg3EdZplAzrjhmBHOI6+gTdEnv
         rLApJoK/WiH4v+lBP40zOooFB5GA0w9H1w9hK7jzsn0rbIMftUwPdd0ps9EQ614Gv2Fi
         tUDA==
X-Gm-Message-State: APjAAAUxP8KdQvWSkrUsHJitc6yBe1H8of1CqAo1YOqCdOYZoRshByLT
        a4AM35C3hWEgvonDlKIiMyKjuhGv9vtzCCErYBtdAQ==
X-Google-Smtp-Source: APXvYqzvC2IJvFVsPA9gAfTjKrdAXGxMndAbM7lBDt2wHBYo997nMmDhlbpZuhwqNL5Jr5JkccMEWeWb3MKEvbmcupY=
X-Received: by 2002:a2e:2b58:: with SMTP id q85mr40132637lje.179.1558402367197;
 Mon, 20 May 2019 18:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com> <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
In-Reply-To: <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
From:   Yurii Zubrytskyi <zyy@google.com>
Date:   Mon, 20 May 2019 18:32:36 -0700
Message-ID: <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Eugene Zemtsov <ezemtsov@google.com>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 9, 2019 at 1:15 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> I think you have made the right choice for you and for the product you are
> working on to use an isolated module to provide this functionality.
>
> But I assume the purpose of your posting was to request upstream inclusion,
> community code review, etc. This is not likely to happen when the
> implementation and design choices are derived from Employer needs vs.
> the community needs. Sure, you can get high level design review, which is
> what *this* is, but I recon not much more.
>
> This discussion has several references to community projects that can benefit
> from this functionality, but not in its current form.
>
> This development model has worked well in the past for Android and the Android
> user base leverage could help to get you a ticket to staging, but eventually,
> those modules (e.g. ashmem) often do get replaced with more community oriented
> APIs.
>

Hi fsdevel
I'm Yurii, and I work with Eugene on the same team and the same project.

I want to explain how we ended up with a custom filesystem instead of
trying to improve FUSE for everyone, and
why we think (maybe incorrectly) that it may be still pretty useful
for the community.
As the project goal was to allow instant (-ish) deployment of apps
from the dev environment to Android phone, we were hoping to
stick with plain FUSE filesystem, and that's what we've done at first.
But it turned out that even with the best tuning it was still
really slow and battery-hungry (phones spent energy faster than they
were charging over the cord).
At this point we've already collected the profiles for the filesystem
usage, and also figured out what features are essential
to make it usable for streaming:
1. Random reads are the most common -> 4kb-sized read is the size we
have to support, and may not go to usermode on each of those
2. Android tends to list the app directory and stat files in it often
-> these operations need to be cached in kernel as well
3. Because of *random* reads streaming files sequentially isn't
optimal -> need to be able to collect read logs from first deployment
    and stream in that order next time on incremental builds
4. Devices have small flash cards, need to deploy uncompressed game
images for speed and mmap access ->
    support storing 4kb blocks compressed
4.1. Host computer is much better at compression -> support streaming
compressed blocks into the filesystem storage directly, without
       recompression on the phone
5. Android has to verify app signature for installation -> need to
support per-block signing and lazy verification
5.1. For big games even per-block signature data can be huge, so need
to stream even the signatures
6. Development cycle is usually edit-build-try-edit-... -> need to
support delta-patches from existing files
7. File names for installed apps are standard and different from what
they were on the host ->
    must be able to store user-supplied 'key' next to each file to identify it
8. Files never change -> no need to have complex code for mutable data
in the filesystem

In the end, we saw only two ways how to make all of this work: either
take sdcardfs as a base and extend it, or change FUSE to
support cache in kernel; and as you can imagine, sdcardfs route got
thrown out of the window immediately after looking at the code.
But after learning some FUSE internals and its code what we found out
is that to make it do all the listed things we'd basically have
to implement a totally new filesystem inside of it. The only real use
of FUSE that remained was to send FUSE_INIT, and occasional
read requests. Everything else required, first of all, making a cache
object inside FUSE intercept every message before it goes to the
user mode, and also adding new specialized commands initiated by the
usermode (e.g. prefetching data that hasn't been requested
yet, or streaming hashes in). Some things even didn't make sense for a
generic usecase (e.g. having a limited circular buffer of read
blocks in kernel that user can ask for and flush).

In the end, after several tries we just came to a conclusion that the
very set of original requirements is so specific that, funny enough,
anyone who wants to create a lazy-loading experience would hit most of
them, while anyone who's doing something else, would miss
most of them. That's the main reason to go with a separate specialized
driver module, and the reason to share it with the community -
we have a feeling that people will benefit from a high-quality
implementation of lazy loading in kernel, and we will benefit from the
community support and guiding.

Again, we all are human and can be wrong at any step when making
conclusions. E.g. we didn't know about the fscache subsystem,
and were only planning to create a cache object inside FUSE instead.
But for now I still feel that our original research stands, and
that in the long run specialized filesystem serves its users much
better than several scattered changes in other places that all
pretty much look like the same filesystem split into three parts and
adopted to the interfaces those places force onto it. Even more,
those changes and interfaces look quite strange on their own, when not
used together.

Please tell me what you think about this whole thing. We do care about
the feature in general, not about making it
look as we've coded it right now. If you feel that making fscache
interface that covers the whole FUSE usermode
messages + allows for those requirements is useful beyond streaming,
we'll investigate that route further.

Thank you, and sorry for a long email

--
Thanks, Yurii
