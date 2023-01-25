Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2867B298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjAYMbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 07:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjAYMbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B762C66E
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 04:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674649813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDzrdZqYwaFwCv3U6o2RGXSbhHismEPJdOxDiMixVh4=;
        b=h2nHkLoog6Joz2OmYddu9uC2uQaLAFlfYrMMyV7UUVr/zNQC6tyTsK7jZnNI5n18LIbE8D
        oXNVj3flQNmKhkivaLI7TdthJRSZMsIPNHFQkIbJ2/5mikAoblyjoFiXSGcVUmDML+UhDX
        U/3gdKod88H0xNbFT70CaMgcOYVuoSs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-2qHFb-AmM7WAw47p3l9IWw-1; Wed, 25 Jan 2023 07:30:10 -0500
X-MC-Unique: 2qHFb-AmM7WAw47p3l9IWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6DFE3C38FE8;
        Wed, 25 Jan 2023 12:30:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 300141121333;
        Wed, 25 Jan 2023 12:30:09 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
References: <cover.1674227308.git.alexl@redhat.com>
        <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
        <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
        <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
        <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
        <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
        <20230125041835.GD937597@dread.disaster.area>
        <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
        <87wn5ac2z6.fsf@redhat.com>
        <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
Date:   Wed, 25 Jan 2023 13:30:07 +0100
In-Reply-To: <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 25 Jan 2023 13:17:40 +0200")
Message-ID: <87o7qmbxv4.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Jan 25, 2023 at 12:39 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
>>
>> > On Wed, Jan 25, 2023 at 6:18 AM Dave Chinner <david@fromorbit.com> wrote:
>> >>
>> >> On Tue, Jan 24, 2023 at 09:06:13PM +0200, Amir Goldstein wrote:
>> >> > On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com> wrote:
>> >> > > On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
>> >> > > > On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
>> >> > > > wrote:
>> >> > > > > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
>> >> > > > > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
>> >> > > > > > <alexl@redhat.com>
>> >> > > > > > wrote:
>> >> > > I'm not sure why the dentry cache case would be more important?
>> >> > > Starting a new container will very often not have cached the image.
>> >> > >
>> >> > > To me the interesting case is for a new image, but with some existing
>> >> > > page cache for the backing files directory. That seems to model staring
>> >> > > a new image in an active container host, but its somewhat hard to test
>> >> > > that case.
>> >> > >
>> >> >
>> >> > ok, you can argue that faster cold cache ls -lR is important
>> >> > for starting new images.
>> >> > I think you will be asked to show a real life container use case where
>> >> > that benchmark really matters.
>> >>
>> >> I've already described the real world production system bottlenecks
>> >> that composefs is designed to overcome in a previous thread.
>> >>
>> >> Please go back an read this:
>> >>
>> >> https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.disaster.area/
>> >>
>> >
>> > I've read it and now re-read it.
>> > Most of the post talks about the excess time of creating the namespace,
>> > which is addressed by erofs+overlayfs.
>> >
>> > I guess you mean this requirement:
>> > "When you have container instances that might only be needed for a
>> > few seconds, taking half a minute to set up the container instance
>> > and then another half a minute to tear it down just isn't viable -
>> > we need instantiation and teardown times in the order of a second or
>> > two."
>> >
>> > Forgive for not being part of the containers world, so I have to ask -
>> > Which real life use case requires instantiation and teardown times in
>> > the order of a second?
>> >
>> > What is the order of number of files in the manifest of those ephemeral
>> > images?
>> >
>> > The benchmark was done on a 2.6GB centos9 image.
>> >
>> > My very minimal understanding of containers world, is that
>> > A large centos9 image would be used quite often on a client so it
>> > would be deployed as created inodes in disk filesystem
>> > and the ephemeral images are likely to be small changes
>> > on top of those large base images.
>> >
>> > Furthermore, the ephmeral images would likely be composed
>> > of cenos9 + several layers, so the situation of single composefs
>> > image as large as centos9 is highly unlikely.
>> >
>> > Am I understanding the workflow correctly?
>> >
>> > If I am, then I would rather see benchmarks with images
>> > that correspond with the real life use case that drives composefs,
>> > such as small manifests and/or composefs in combination with
>> > overlayfs as it would be used more often.
>> >
>> >> Cold cache performance dominates the runtime of short lived
>> >> containers as well as high density container hosts being run to
>> >> their container level memory limits. `ls -lR` is just a
>> >> microbenchmark that demonstrates how much better composefs cold
>> >> cache behaviour is than the alternatives being proposed....
>> >>
>> >> This might also help explain why my initial review comments focussed
>> >> on getting rid of optional format features, straight lining the
>> >> processing, changing the format or search algorithms so more
>> >> sequential cacheline accesses occurred resulting in less memory
>> >> stalls, etc. i.e. reductions in cold cache lookup overhead will
>> >> directly translate into faster container workload spin up.
>> >>
>> >
>> > I agree that this technology is novel and understand why it results
>> > in faster cold cache lookup.
>> > I do not know erofs enough to say if similar techniques could be
>> > applied to optimize erofs lookup at mkfs.erofs time, but I can guess
>> > that this optimization was never attempted.
>>
>> As Dave mentioned, containers in a cluster usually run with low memory
>> limits to increase density of how many containers can run on a single
>
> Good selling point.
>
>> host.  I've done some tests to get some numbers on the memory usage.
>>
>> Please let me know if you've any comment on the method I've used to read
>> the memory usage, if you've any better suggestion please let me know.
>>
>> I am using a Fedora container image, but I think the image used is not
>> relevant, as the memory used should increase linearly to the image size
>> for both setups.
>>
>> I am using systemd-run --scope to get a new cgroup, the system uses
>> cgroupv2.
>>
>> For this first test I am using a RO mount both for composefs and
>> erofs+overlayfs.
>>
>> # echo 3 > /proc/sys/vm/drop_caches
>> # \time systemd-run --scope sh -c 'ls -lR /mnt/composefs > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>> Running scope as unit: run-r482ec1c3024a4a8b9d2a369bf5dc6df3.scope
>> 16367616
>> 0.03user 0.54system 0:00.71elapsed 80%CPU (0avgtext+0avgdata 7552maxresident)k
>> 10592inputs+0outputs (28major+1273minor)pagefaults 0swaps
>>
>> # echo 3 > /proc/sys/vm/drop_caches
>> # \time systemd-run --scope sh -c 'ls -lR /mnt/erofs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>> Running scope as unit: run-r5f0f599053c349669e5c1ecacaa037b6.scope
>> 48390144
>> 0.04user 1.03system 0:01.81elapsed 59%CPU (0avgtext+0avgdata 7552maxresident)k
>> 30776inputs+0outputs (28major+1269minor)pagefaults 0swaps
>>
>> the erofs+overlay setup takes 2.5 times to complete and it uses 3 times
>> the memory used by composefs.
>>
>> The second test involves a RW mount for composefs.
>>
>> For the erofs+overlay setup I've just added an upperdir and workdir to
>> the overlay mount, while for composefs I create a completely new overlay
>> mount that uses the composefs mount as the lower layer.
>>
>> # echo 3 > /proc/sys/vm/drop_caches
>> # \time systemd-run --scope sh -c 'ls -lR /mnt/composefs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>> Running scope as unit: run-r23519c8048704e5b84a1355f131d9d93.scope
>> 31014912
>> 0.05user 1.15system 0:01.38elapsed 87%CPU (0avgtext+0avgdata 7552maxresident)k
>> 10944inputs+0outputs (28major+1282minor)pagefaults 0swaps
>>
>> # echo 3 > /proc/sys/vm/drop_caches
>> # \time systemd-run --scope sh -c 'ls -lR /mnt/erofs-overlay > /dev/null; cat $(cat /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>> Running scope as unit: run-rdbccf045f3124e379cec00273638db08.scope
>> 48308224
>> 0.07user 2.04system 0:03.22elapsed 65%CPU (0avgtext+0avgdata 7424maxresident)k
>> 30720inputs+0outputs (28major+1273minor)pagefaults 0swaps
>>
>> so the erofs+overlay setup still takes more time (almost 2.5 times) and
>> uses more memory (slightly more than 1.5 times)
>>
>
> That's an important comparison. Thanks for running it.
>
> Based on Alexander's explanation about the differences between overlayfs
> lookup vs. composefs lookup of a regular "metacopy" file, I just need to
> point out that the same optimization (lazy lookup of the lower data
> file on open)
> can be done in overlayfs as well.
> (*) currently, overlayfs needs to lookup the lower file also for st_blocks.
>
> I am not saying that it should be done or that Miklos will agree to make
> this change in overlayfs, but that seems to be the major difference.
> getxattr may have some extra cost depending on in-inode xattr format
> of erofs, but specifically, the metacopy getxattr can be avoided if this
> is a special overlayfs RO mount that is marked as EVERYTHING IS
> METACOPY.
>
> I don't expect you guys to now try to hack overlayfs and explore
> this path to completion.
> My expectation is that this information will be clearly visible to anyone
> reviewing future submission, e.g.:
>
> - This is the comparison we ran...
> - This is the reason that composefs gives better results...
> - It MAY be possible to optimize erofs/overlayfs to get to similar results,
>   but we did not try to do that
>
> It is especially important IMO to get the ACK of both Gao and Miklos
> on your analysis, because remember than when this thread started,
> you did not know about the metacopy option and your main argument
> was saving the time it takes to create the overlayfs layer files in the
> filesystem, because you were missing some technical background on overlayfs.

we knew about metacopy, which we already use in our tools to create
mapped image copies when idmapped mounts are not available, and also
knew about the other new features in overlayfs.  For example, the
"volatile" feature which was mentioned in your
Overlayfs-containers-lpc-2020 talk, was only submitted upstream after
begging Miklos and Vivek for months.  I had a PoC that I used and tested
locally and asked for their help to get it integrated at the file
system layer, using seccomp for the same purpose would have been more
complex and prone to errors when dealing with external bind mounts
containing persistent data.

The only missing bit, at least from my side, was to consider an image
that contains only overlay metadata as something we could distribute.

I previously mentioned my wish of using it from a user namespace, the
goal seems more challenging with EROFS or any other block devices.  I
don't know about the difficulty of getting overlay metacopy working in a
user namespace, even though it would be helpful for other use cases as
well.

Thanks,
Giuseppe

>
> I hope that after you are done being annoyed by all the chores we put
> you guys up to, you will realize that they help you build your case for
> the final submission...
>
> Thanks,
> Amir.

