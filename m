Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4392E70B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE2VGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:06:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41119 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE2VGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:06:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id q16so3928922ljj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVxJYqsJ8PqKBiH/MhD8D/4IHXnrKsk8lQyn4afID68=;
        b=gv7KCbInGTZC0sEORr2ucOob8TkqKKsU/4tEdEZifklFeh7eMflQ+/11iAvkc+bdDj
         M8M3MLFWPwmD4cVU8lvCLq2DpGz5fYehqdVV3ypKAWuR9MfYYH3yQgEjJJbpPPJybHAy
         x9ht8s7srUM6XcbJv2sxypRSsH8svnFsycJhU9fP6rX1dYjQn4cttO9vQTb7yTljuQXX
         ueJFIY1HMGEimtViosQRsBlrR+PRzEaZFdriygutZ5bxEBaVObFE7cwxziB48lwi0E6C
         kOPylMJqEoC7/rGyGLsZWg3eeKQCT7W2f26dH7gBaB9v67C2kQpdMPDEH6pLIMz0RZ+V
         5SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVxJYqsJ8PqKBiH/MhD8D/4IHXnrKsk8lQyn4afID68=;
        b=diBWyHxNEZw5W60zclpk//Mb9bOWXMcWS2u9AtIWwqMVaMu3pB+b/Pvfqq2qIDLqZO
         lJ2zg5o+aToDVdBnl/f+QTKHzb23E1J2nTrhrCPXc9BvOJncbzNAmjnPw8+Z+b9/hwlT
         3e5BAgOUpqOrHMNG3Q2DdILZDfy00w6ghAtyrd+m+ymjNPNnGUMxHy90LejSpCAmSfvO
         BX+uo8/AOtYT/3teG1+YigbCbhogKsXyVhg2Qpk7RwT56X/5RaJVgLy3I7BeqAfUpoQi
         7PwF+FY6c+SMmkGvPalNxDZlSwqKGYh0PmkVi3Yp4E+AuIA2lPHEqIkWuVwdZsJx3Yw3
         vhmQ==
X-Gm-Message-State: APjAAAXqgnjRtJDTiGMGUw96up/cRVrjO9czVOgdn4VDn2kVa0QR8EXM
        wJdKJOYAK7Cj3SUjUC7SobqGDmCdTi6GIHg3xKduKg==
X-Google-Smtp-Source: APXvYqyvkLD6L2gDwm0rRyC+6M00Pi8m/cQJeHiE0X5Y5LHFZxR32WXogstX0JNMKF0zIgQesVDL/E82YjEm1AcY8Ag=
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr30381996ljg.139.1559164004652;
 Wed, 29 May 2019 14:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
 <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
 <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
 <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com> <CAJfpegs=4jMo20Wp8NEjREQpqYjqJ22vc680w1E-w6o-dU1brg@mail.gmail.com>
In-Reply-To: <CAJfpegs=4jMo20Wp8NEjREQpqYjqJ22vc680w1E-w6o-dU1brg@mail.gmail.com>
From:   Yurii Zubrytskyi <zyy@google.com>
Date:   Wed, 29 May 2019 14:06:33 -0700
Message-ID: <CAJeUaNBn0gA6eApgOu=n2uoy+6PbOR_xjTdVvc+StvOKGA-i=Q@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 9:25 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> What would benefit many fuse applications is to let the kernel
> transfer data to/from a given location (i.e. offset within a file).
> So instead of transferring data directly in the READ/WRITE messages,
> there would be a MAP message that would return information about where
> the data resides (list of extents+extra parameters for
> compression/encryption).  The returned information could be generic
> enough for your needs, I think.  The fuse kernel module would cache
> this mapping, and could keep the mapping around for possibly much
> longer than the data itself, since it would require orders of
> magnitude less memory. This would not only be saving memory copies,
> but also the number of round trips to userspace.

Yes, and this was _exactly_ our first plan, and it mitigates the read
performance
issue. The reasons why we didn't move forward with it are that we figured out
all other requirements, and fixing each of those needs another change in
FUSE, up to the level when FUSE interface becomes 50% dedicated to
our specific goal:
1. MAP message would have to support data compression (with different
algorithms), hash verification (same thing) with hash streaming (because
even the Merkle tree for a 5GB file is huge, and can't be preloaded
at once)
  1.1. Mapping memory usage can get out of hands pretty quickly: it has to
be at least (offset + size + compression type + hash location + hash size +
hash kind) per each block. I'm not even thinking about multiple storage files
here. For that 5GB file (that's a debug APK for some Android game we're
targeting) we have 1.3M blocks, so ~16 bytes *1.3M = 20M of index only,
without actual overhead for the lookup table.
If the kernel code owns and manages its own on-disk data store and the
format, this index can be loaded and discarded on demand there.

2. We need the same kind of a MAP message but for the directory structure
and for stat(2) calls - Android does way too many of these, and has no
intention to fix it. These caches need to be dynamically sized as well
(as I said, standard kernel caches don't hold anything long enough on
Android because of the usual thing when all memory is used by running
apps)

3. Several smaller features would have to be added, again with their own
interface and specific code in FUSE
3.1 E.g. collecting logs of all block reads - we're planning to have a ring
buffer of configurable size there, and a way to request its content from the
 user space; this doesn't look that useful for other FUSE users, and may
actually be a serious security hole there. We'd not need it at all if FUSE
was calling into user space on each read, so here it's almost like we're
fighting ourselves and making two opposing changes in FUSE

4. All these features are much easier to implement for a readonly
filesystem (cache invalidation is a big thing). But if we limit them in FUSE
to readonly mode we'd make half of its interface dedicated to even
smaller use case.

> There's also work currently ongoing in optimizing the overhead of
> userspace roundtrip.  The most promising thing appears to be matching
> up the CPU for the userspace server with that of the task doing the
> request.  This can apparently result in  60-500% speed improvement.

That sounds almost too good to be true, and will be really cool.
Do you have any patches or git remote available in any compilable state to
try the optimization out? Android has quite complicated hardware config
and I want to see how this works, especially with our model where
several processes may send requests into the same filesystem FD.

> Understood.  Did you re-enable readahead for the case when the file
> has been fully downloaded?

Yes, and it doesn't really help - readahead wants a bunch of blocks
together, but those are scattered around the backing image because they
arrived separately and at different times. So usermode process still has to
issue multiple read commands to respond to a single FUSE read(ahead)
request, which is still slow. Even worse thing happens if CPU was in
reduced frequency idling mode at that time (which is normal for mobile) -
it takes couple hundred ms to ramp it up, and during that time latency
is huge (milliseconds / block)

Overall, I see that it is possible to change FUSE in a way that meets our
needs, but I'm not sure if that kind of change keeps FUSE interface
friendly for all existing and new uses. The set of requirements is so big
and the mobile platform constraints are so harsh that _as efficient as
possible_ and _generic_ do, unfortunately, contradict each other.

Please tell me if you see it differently, and if you have some better ideas
on how to change FUSE in a simpler way
--
Thanks, Yurii
