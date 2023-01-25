Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021BF67ABC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 09:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjAYIcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 03:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjAYIco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:32:44 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68CA5141F;
        Wed, 25 Jan 2023 00:32:39 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d66so19027126vsd.9;
        Wed, 25 Jan 2023 00:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hMKsP+ymQZlCwigldf1lFK1mABYe2GYiPiGIJK3DBs=;
        b=oE/n3Qi6A4g9N2N1LnzoRIe9h2F2kgqYSrk+Jov3IFh7XmkHbq2/F3dh7Hjz4fVXNN
         6f+64vbpBkwWEWV2IcwfJ+12jXnVqMiXTHvFsznTw95bjmt3MPzGBRbNI08O3yvzJCqV
         dAs03D/wEDeu5fo8Trz+cNsJIhkbSgzkfNd9GCRpYUHo6aHDjbIJBrqA23beJ/oL9VVq
         1z0Nd+YvvqQDmJZcYJace0ADAusjT9FybyjwVgFQTGGXQf9BjFqs6g9hGDYPDv81F8wJ
         ug9/5NX2+H0lhilqwievcsXf/OVoVmxaWMNOe3cGMOqaygb6n3xNeZY0ydmfE/TA0e+d
         vrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hMKsP+ymQZlCwigldf1lFK1mABYe2GYiPiGIJK3DBs=;
        b=UaNMNky9GstpQULtaw9cuj/VAEGtICbxCuE24F8xXGy4xvgvIQJxClKnwOPduUWIIb
         JrIaRFmWGuj9uFDsB17mIkrrc5bRJ3CsT9+TJxUzQtCAAWRIbIidlBSX7JTbuLFhlZBf
         49DkLxZIzUKLiylU4EqAvphyjBQ3M99wkFR49WXXZdghS9M1R2f9hkdWuIbzTJR2QRqL
         YPLPmBPtL6YlJGRy4Jx8Wor6B9bwjHp0bsLR5aMsHGwndj2HOD+2duPn5kPtXPWa82oP
         Ooz0DqR+7BSk/ta8UXLxFGPgvp6MGJ7GbuH9Jkb80cbjhve6Ft00+6QrrGOLw1XLIYBK
         VBrw==
X-Gm-Message-State: AFqh2krgCi4WSdJ872zeDkJckRDXekrqCFCd5p7T8mOTo0tUGpXoZnni
        9fCbLApf7eb8GDnX8EimWtawV7ozyIVFoo3I+64=
X-Google-Smtp-Source: AMrXdXsQI53bA8DTq3bUyjAoK6HZesr6skL+PgyXRZ7z/qlC7onDSMOXKg2OsNoYjrd5P9P6nAMjeAGx6nQalEzqB4s=
X-Received: by 2002:a05:6102:5587:b0:3d1:2167:11ad with SMTP id
 dc7-20020a056102558700b003d1216711admr3922488vsb.2.1674635558641; Wed, 25 Jan
 2023 00:32:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com> <20230125041835.GD937597@dread.disaster.area>
In-Reply-To: <20230125041835.GD937597@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 10:32:26 +0200
Message-ID: <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
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

On Wed, Jan 25, 2023 at 6:18 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Jan 24, 2023 at 09:06:13PM +0200, Amir Goldstein wrote:
> > On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com> wrote:
> > > On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
> > > > On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
> > > > wrote:
> > > > > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> > > > > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
> > > > > > <alexl@redhat.com>
> > > > > > wrote:
> > > I'm not sure why the dentry cache case would be more important?
> > > Starting a new container will very often not have cached the image.
> > >
> > > To me the interesting case is for a new image, but with some existing
> > > page cache for the backing files directory. That seems to model staring
> > > a new image in an active container host, but its somewhat hard to test
> > > that case.
> > >
> >
> > ok, you can argue that faster cold cache ls -lR is important
> > for starting new images.
> > I think you will be asked to show a real life container use case where
> > that benchmark really matters.
>
> I've already described the real world production system bottlenecks
> that composefs is designed to overcome in a previous thread.
>
> Please go back an read this:
>
> https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.disaster.area/
>

I've read it and now re-read it.
Most of the post talks about the excess time of creating the namespace,
which is addressed by erofs+overlayfs.

I guess you mean this requirement:
"When you have container instances that might only be needed for a
few seconds, taking half a minute to set up the container instance
and then another half a minute to tear it down just isn't viable -
we need instantiation and teardown times in the order of a second or
two."

Forgive for not being part of the containers world, so I have to ask -
Which real life use case requires instantiation and teardown times in
the order of a second?

What is the order of number of files in the manifest of those ephemeral
images?

The benchmark was done on a 2.6GB centos9 image.

My very minimal understanding of containers world, is that
A large centos9 image would be used quite often on a client so it
would be deployed as created inodes in disk filesystem
and the ephemeral images are likely to be small changes
on top of those large base images.

Furthermore, the ephmeral images would likely be composed
of cenos9 + several layers, so the situation of single composefs
image as large as centos9 is highly unlikely.

Am I understanding the workflow correctly?

If I am, then I would rather see benchmarks with images
that correspond with the real life use case that drives composefs,
such as small manifests and/or composefs in combination with
overlayfs as it would be used more often.

> Cold cache performance dominates the runtime of short lived
> containers as well as high density container hosts being run to
> their container level memory limits. `ls -lR` is just a
> microbenchmark that demonstrates how much better composefs cold
> cache behaviour is than the alternatives being proposed....
>
> This might also help explain why my initial review comments focussed
> on getting rid of optional format features, straight lining the
> processing, changing the format or search algorithms so more
> sequential cacheline accesses occurred resulting in less memory
> stalls, etc. i.e. reductions in cold cache lookup overhead will
> directly translate into faster container workload spin up.
>

I agree that this technology is novel and understand why it results
in faster cold cache lookup.
I do not know erofs enough to say if similar techniques could be
applied to optimize erofs lookup at mkfs.erofs time, but I can guess
that this optimization was never attempted.

> > > > > This isn't all that strange, as overlayfs does a lot more work for
> > > > > each lookup, including multiple name lookups as well as several
> > > > > xattr
> > > > > lookups, whereas composefs just does a single lookup in a pre-
> > > > > computed
> > > >
> > > > Seriously, "multiple name lookups"?
> > > > Overlayfs does exactly one lookup for anything but first level
> > > > subdirs
> > > > and for sparse files it does the exact same lookup in /objects as
> > > > composefs.
> > > > Enough with the hand waving please. Stick to hard facts.
> > >
> > > With the discussed layout, in a stat() call on a regular file,
> > > ovl_lookup() will do lookups on both the sparse file and the backing
> > > file, whereas cfs_dir_lookup() will just map some page cache pages and
> > > do a binary search.
> > >
> > > Of course if you actually open the file, then cfs_open_file() would do
> > > the equivalent lookups in /objects. But that is often not what happens,
> > > for example in "ls -l".
> > >
> > > Additionally, these extra lookups will cause extra memory use, as you
> > > need dentries and inodes for the erofs/squashfs inodes in addition to
> > > the overlay inodes.
> >
> > I see. composefs is really very optimized for ls -lR.
>
> No, composefs is optimised for minimal namespace and inode
> resolution overhead. 'ls -lR' does a lot of these operations, and
> therefore you see the efficiency of the design being directly
> exposed....
>
> > Now only need to figure out if real users start a container and do ls -lR
> > without reading many files is a real life use case.
>
> I've been using 'ls -lR' and 'find . -ctime 1' to benchmark cold
> cache directory iteration and inode lookup performance for roughly
> 20 years. The benchmarks I run *never* read file data, nor is that
> desired - they are pure directory and inode lookup micro-benchmarks
> used to analyse VFS and filesystem directory and inode lookup
> performance.
>
> I have been presenting such measurements and patches improving
> performance of these microbnechmarks to the XFS and fsdevel lists
> over 15 years and I have *never* had to justify that what I'm
> measuring is a "real world workload" to anyone. Ever.
>
> Complaining about real world relevancy of the presented benchmark
> might be considered applying a double standard, wouldn't you agree?
>

I disagree.
Perhaps my comment was misunderstood.

The cold cache benchmark is certainly relevant for composefs
comparison and I expect to see it in future submissions.

The point I am trying to drive is this:
There are two alternatives on the table:
1. Add fs/composefs
2. Improve erofs and overlayfs

Functionally, I think we all agree that both alternatives should work.

Option #1 will take much less effort from composefs authors, so it is
understandable that they would do their best to argue in its favor.

Option #2 is prefered for long term maintenance reasons, which is
why vfs/erofs/overlayfs developers argue in favor of it.

The only factor that remains that could shift the balance inside
this gray area are the actual performance numbers.

And back to my point: the not so simple decision between the
two options, by whoever makes this decision, should be based
on a real life example of performance improvement and not of
a microbenchamk.

In my limited experience, a real life example means composefs
as a layer in overlayfs.

I did not see those numbers and it is clear that they will not be
as impressive as the bare composefs numbers, so proposing
composefs needs to include those numbers as well.

Alexander did claim that he has real life use cases for bare readonly
composefs images, but he did not say what the size of the manifests
in those images are and he did not say whether these use cases
also require startup and teardown in orders of seconds.

It looks like the different POV are now well understood by all parties
and that we are in the process of fine tuning the information that
needs to be presented for making the best decision based on facts.

This discussion, which was on a collision course at the beginning,
looks like it is in a converging course - this makes me happy.

Thanks,
Amir.
