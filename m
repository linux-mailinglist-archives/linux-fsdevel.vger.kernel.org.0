Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845EC67B103
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjAYLUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYLTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:19:16 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A21F5E6;
        Wed, 25 Jan 2023 03:17:53 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id bs10so548711vkb.3;
        Wed, 25 Jan 2023 03:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hBL8tLn+UJ9qhT9i2c3LMYqKQzKFOZZnv1ZXlWwYa2I=;
        b=Pz0YxiP0KxrSrlBmmNII5YbKs/asWOOd88k+CD22ftMojSFAtNsfmEV7iR+6kFc9qt
         TOBCaEbodyulZZ2ZL79+BNT3aRPV6Wwtkgkgu3IeZZ76cWMoCrEVoN20ETupyQ730jqu
         GPXmlyoNDN4pO22Y0mHXhZV5VZ6QS7/gVgRVNFihqzV+Aj5L9k28KpOFEX2T9BRJmMo2
         lj7K836r0cZRmdRl9x0N9vMFGMdOEAj2SY9lZ/eh74+CdTvFZamqJnJkoYsNBlmWkoGV
         hpcqIi7psn6ufPCfZzXe3BrXykKXAhP27en5QYJ9OBaZxeb9s3sIB+wkKzgWMDyho3NB
         36LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBL8tLn+UJ9qhT9i2c3LMYqKQzKFOZZnv1ZXlWwYa2I=;
        b=zjHShH4L/HjOmvay68JhMWaEhcoMiPPb46lG6YI0ZWK6/w+6waRsB8LDm8QmqBI8cq
         GtOKbQsFMW1NVuIRAsCcP59Kt0N8UNLzsrzJRCy6WCHVSAEMLxlGPh5Dc/hVPvC3w8FU
         ovak101ufvAioZvwONTKh7SDZLvE4Z+YulKMv8nJGLxosV/h7gf3JjtBg67tJVH0GUF+
         1yrEDvX/khhRjY2xt6O6BXBm/OqPbn9BZHcrLjIzN79ueFMe11gbLmoFHNQ7rxTMJqEI
         cxPxGd7jphzwzzG258FtFUBabQmLsV4KGXgucWwC4O2oJXhZ7AG+tOM8eqdzHAdYtPpw
         6TSA==
X-Gm-Message-State: AFqh2kplP6nfvb+9kjkrluGtxLJv9tc98j8jmOckr9zi65kRpVIXrdtF
        7M1FiCK/n27WCQC6uqhyIeyaYZFY1HaqFEdU6Fc=
X-Google-Smtp-Source: AMrXdXu1+QItfay9+6PlMBufPzgGSKamLwGfkVnrnoc7TMXLis9kiFI1kEOHE3SW4CK9PVS4HldY6r2UgVmxkh3YV/4=
X-Received: by 2002:a1f:91d4:0:b0:3db:104:6d13 with SMTP id
 t203-20020a1f91d4000000b003db01046d13mr4164434vkd.25.1674645472271; Wed, 25
 Jan 2023 03:17:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area> <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com>
In-Reply-To: <87wn5ac2z6.fsf@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 13:17:40 +0200
Message-ID: <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
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

On Wed, Jan 25, 2023 at 12:39 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Wed, Jan 25, 2023 at 6:18 AM Dave Chinner <david@fromorbit.com> wrote:
> >>
> >> On Tue, Jan 24, 2023 at 09:06:13PM +0200, Amir Goldstein wrote:
> >> > On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com> wrote:
> >> > > On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
> >> > > > On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
> >> > > > wrote:
> >> > > > > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> >> > > > > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
> >> > > > > > <alexl@redhat.com>
> >> > > > > > wrote:
> >> > > I'm not sure why the dentry cache case would be more important?
> >> > > Starting a new container will very often not have cached the image.
> >> > >
> >> > > To me the interesting case is for a new image, but with some existing
> >> > > page cache for the backing files directory. That seems to model staring
> >> > > a new image in an active container host, but its somewhat hard to test
> >> > > that case.
> >> > >
> >> >
> >> > ok, you can argue that faster cold cache ls -lR is important
> >> > for starting new images.
> >> > I think you will be asked to show a real life container use case where
> >> > that benchmark really matters.
> >>
> >> I've already described the real world production system bottlenecks
> >> that composefs is designed to overcome in a previous thread.
> >>
> >> Please go back an read this:
> >>
> >> https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.disaster.area/
> >>
> >
> > I've read it and now re-read it.
> > Most of the post talks about the excess time of creating the namespace,
> > which is addressed by erofs+overlayfs.
> >
> > I guess you mean this requirement:
> > "When you have container instances that might only be needed for a
> > few seconds, taking half a minute to set up the container instance
> > and then another half a minute to tear it down just isn't viable -
> > we need instantiation and teardown times in the order of a second or
> > two."
> >
> > Forgive for not being part of the containers world, so I have to ask -
> > Which real life use case requires instantiation and teardown times in
> > the order of a second?
> >
> > What is the order of number of files in the manifest of those ephemeral
> > images?
> >
> > The benchmark was done on a 2.6GB centos9 image.
> >
> > My very minimal understanding of containers world, is that
> > A large centos9 image would be used quite often on a client so it
> > would be deployed as created inodes in disk filesystem
> > and the ephemeral images are likely to be small changes
> > on top of those large base images.
> >
> > Furthermore, the ephmeral images would likely be composed
> > of cenos9 + several layers, so the situation of single composefs
> > image as large as centos9 is highly unlikely.
> >
> > Am I understanding the workflow correctly?
> >
> > If I am, then I would rather see benchmarks with images
> > that correspond with the real life use case that drives composefs,
> > such as small manifests and/or composefs in combination with
> > overlayfs as it would be used more often.
> >
> >> Cold cache performance dominates the runtime of short lived
> >> containers as well as high density container hosts being run to
> >> their container level memory limits. `ls -lR` is just a
> >> microbenchmark that demonstrates how much better composefs cold
> >> cache behaviour is than the alternatives being proposed....
> >>
> >> This might also help explain why my initial review comments focussed
> >> on getting rid of optional format features, straight lining the
> >> processing, changing the format or search algorithms so more
> >> sequential cacheline accesses occurred resulting in less memory
> >> stalls, etc. i.e. reductions in cold cache lookup overhead will
> >> directly translate into faster container workload spin up.
> >>
> >
> > I agree that this technology is novel and understand why it results
> > in faster cold cache lookup.
> > I do not know erofs enough to say if similar techniques could be
> > applied to optimize erofs lookup at mkfs.erofs time, but I can guess
> > that this optimization was never attempted.
>
> As Dave mentioned, containers in a cluster usually run with low memory
> limits to increase density of how many containers can run on a single

Good selling point.

> host.  I've done some tests to get some numbers on the memory usage.
>
> Please let me know if you've any comment on the method I've used to read
> the memory usage, if you've any better suggestion please let me know.
>
> I am using a Fedora container image, but I think the image used is not
> relevant, as the memory used should increase linearly to the image size
> for both setups.
>
> I am using systemd-run --scope to get a new cgroup, the system uses
> cgroupv2.
>
> For this first test I am using a RO mount both for composefs and
> erofs+overlayfs.
>
> # echo 3 > /proc/sys/vm/drop_caches
> # \time systemd-run --scope sh -c 'ls -lR /mnt/composefs > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> Running scope as unit: run-r482ec1c3024a4a8b9d2a369bf5dc6df3.scope
> 16367616
> 0.03user 0.54system 0:00.71elapsed 80%CPU (0avgtext+0avgdata 7552maxresident)k
> 10592inputs+0outputs (28major+1273minor)pagefaults 0swaps
>
> # echo 3 > /proc/sys/vm/drop_caches
> # \time systemd-run --scope sh -c 'ls -lR /mnt/erofs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> Running scope as unit: run-r5f0f599053c349669e5c1ecacaa037b6.scope
> 48390144
> 0.04user 1.03system 0:01.81elapsed 59%CPU (0avgtext+0avgdata 7552maxresident)k
> 30776inputs+0outputs (28major+1269minor)pagefaults 0swaps
>
> the erofs+overlay setup takes 2.5 times to complete and it uses 3 times
> the memory used by composefs.
>
> The second test involves a RW mount for composefs.
>
> For the erofs+overlay setup I've just added an upperdir and workdir to
> the overlay mount, while for composefs I create a completely new overlay
> mount that uses the composefs mount as the lower layer.
>
> # echo 3 > /proc/sys/vm/drop_caches
> # \time systemd-run --scope sh -c 'ls -lR /mnt/composefs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> Running scope as unit: run-r23519c8048704e5b84a1355f131d9d93.scope
> 31014912
> 0.05user 1.15system 0:01.38elapsed 87%CPU (0avgtext+0avgdata 7552maxresident)k
> 10944inputs+0outputs (28major+1282minor)pagefaults 0swaps
>
> # echo 3 > /proc/sys/vm/drop_caches
> # \time systemd-run --scope sh -c 'ls -lR /mnt/erofs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> Running scope as unit: run-rdbccf045f3124e379cec00273638db08.scope
> 48308224
> 0.07user 2.04system 0:03.22elapsed 65%CPU (0avgtext+0avgdata 7424maxresident)k
> 30720inputs+0outputs (28major+1273minor)pagefaults 0swaps
>
> so the erofs+overlay setup still takes more time (almost 2.5 times) and
> uses more memory (slightly more than 1.5 times)
>

That's an important comparison. Thanks for running it.

Based on Alexander's explanation about the differences between overlayfs
lookup vs. composefs lookup of a regular "metacopy" file, I just need to
point out that the same optimization (lazy lookup of the lower data
file on open)
can be done in overlayfs as well.
(*) currently, overlayfs needs to lookup the lower file also for st_blocks.

I am not saying that it should be done or that Miklos will agree to make
this change in overlayfs, but that seems to be the major difference.
getxattr may have some extra cost depending on in-inode xattr format
of erofs, but specifically, the metacopy getxattr can be avoided if this
is a special overlayfs RO mount that is marked as EVERYTHING IS
METACOPY.

I don't expect you guys to now try to hack overlayfs and explore
this path to completion.
My expectation is that this information will be clearly visible to anyone
reviewing future submission, e.g.:

- This is the comparison we ran...
- This is the reason that composefs gives better results...
- It MAY be possible to optimize erofs/overlayfs to get to similar results,
  but we did not try to do that

It is especially important IMO to get the ACK of both Gao and Miklos
on your analysis, because remember than when this thread started,
you did not know about the metacopy option and your main argument
was saving the time it takes to create the overlayfs layer files in the
filesystem, because you were missing some technical background on overlayfs.

I hope that after you are done being annoyed by all the chores we put
you guys up to, you will realize that they help you build your case for
the final submission...

Thanks,
Amir.
