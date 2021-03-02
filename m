Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178A332B4C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354201AbhCCF2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351879AbhCBRuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:50:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563DC061A2E
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 09:49:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s8so26361698edd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 09:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1jNIbHrSTxAMgQLW8j2zNIaeCqH8C/pWqqPUiSjxU0=;
        b=z61wMQoD4obDZYrGr5vzM7cXLqWh158yp1rO2r0bNbmecFgzWwYJLjBdFB+KZOzB/8
         4l34RMuywLH3KvcaP8Y/94oUTRXpstJEB0MTvzKYApokwl6q+Scj/RH95PCwNcHlgfuO
         4uMWFu2Az6g5yrcShaejYitRijoF64SIhA8j7cwSxFbm8qsSHEe6WYw3wB/Fvcy+NtiO
         v89FFOds+2gWhrH698lt1JMZq0hbFy15fBUQLWBrTggXeb5CdojCkJBcEFU5QxJCSDV3
         MwsSCQcRY8x14ZDzII/LSQ77Ge870b5ERbOKp3H0hJjXRS1rkW+tHCghwrP8tP0AvTHI
         N7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1jNIbHrSTxAMgQLW8j2zNIaeCqH8C/pWqqPUiSjxU0=;
        b=Ix7h3gyceCiTp2HRqeZqiAbVMPaB9EIioz5IJ5IcjtfNwOJIZ025eaqX/iR0h+fudF
         4FnSozviq75vDIRWSY7pyerxecUBzcOCRAkQXPB3SvaJbXsSorrVvLQt2LYwm5EJndV7
         l5bqRPPxHkasD5/x1zNJ063FFv4dPDspoH1+vFqg6vqslzCq8+aIZRMZI6zKVl4SCugf
         1bxFFCy7E7Tm7UjvRY9ldEooqi1rC0PXI3/M4H6y8gJBN7VIKDhWki3oSttmMjv8/kK8
         tH8ZFC7axyEeaXq6MWSQ7bLRd968zAUH+DWPY83wnjFSR6YAWaoqc3NioVIgr65Ua34s
         jOwg==
X-Gm-Message-State: AOAM532dPAKWVCPs5ZG89o6jBNb7gU2CnltURD58U1At7ENrSzlpRT1u
        qqNJEwux9BkKxgH4TbJhpXIy2hEQGzcuJoy+W+mprw==
X-Google-Smtp-Source: ABdhPJw52xU2AAVDUM7fXxo6dph71Kc7Vf7xblc+YtWfct1Obn+c8f0OfGJHsyuuxwfVWHPK34k5EGOt8jCZ2PZVdvs=
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr22090543edb.354.1614707379707;
 Tue, 02 Mar 2021 09:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20210226205126.GX4662@dread.disaster.area> <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area> <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area> <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area> <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210302032805.GM7272@magnolia> <CAPcyv4jXH0F+aii6ZtYQ3=Rx-mOWM7NFHC9wVxacW-b1o_s20g@mail.gmail.com>
 <20210302075736.GJ4662@dread.disaster.area>
In-Reply-To: <20210302075736.GJ4662@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Mar 2021 09:49:30 -0800
Message-ID: <CAPcyv4iyTHVW51xocmLO7F6ATgq0rJtQ1nShB=rAmDfzx83EyA@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 1, 2021 at 11:57 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Mar 01, 2021 at 09:41:02PM -0800, Dan Williams wrote:
> > On Mon, Mar 1, 2021 at 7:28 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > I really don't see you seem to be telling us that invalidation is an
> > > > > either/or choice. There's more ways to convert physical block
> > > > > address -> inode file offset and mapping index than brute force
> > > > > inode cache walks....
> > > >
> > > > Yes, but I was trying to map it to an existing mechanism and the
> > > > internals of drop_pagecache_sb() are, in coarse terms, close to what
> > > > needs to happen here.
> > >
> > > Yes.  XFS (with rmap enabled) can do all the iteration and walking in
> > > that function except for the invalidate_mapping_* call itself.  The goal
> > > of this series is first to wire up a callback within both the block and
> > > pmem subsystems so that they can take notifications and reverse-map them
> > > through the storage stack until they reach an fs superblock.
> >
> > I'm chuckling because this "reverse map all the way up the block
> > layer" is the opposite of what Dave said at the first reaction to my
> > proposal, "can't the mm map pfns to fs inode  address_spaces?".
>
> Ah, no, I never said that the filesystem can't do reverse maps. I
> was asking if the mm could directly (brute-force) invalidate PTEs
> pointing at physical pmem ranges without needing walk the inode
> mappings. That would be far more efficient if it could be done....
>
> > Today whenever the pmem driver receives new corrupted range
> > notification from the lower level nvdimm
> > infrastructure(nd_pmem_notify) it updates the 'badblocks' instance
> > associated with the pmem gendisk and then notifies userspace that
> > there are new badblocks. This seems a perfect place to signal an upper
> > level stacked block device that may also be watching disk->bb. Then
> > each gendisk in a stacked topology is responsible for watching the
> > badblock notifications of the next level and storing a remapped
> > instance of those blocks until ultimately the filesystem mounted on
> > the top-level block device is responsible for registering for those
> > top-level disk->bb events.
> >
> > The device gone notification does not map cleanly onto 'struct badblocks'.
>
> Filesystems are not allowed to interact with the gendisk
> infrastructure - that's for supporting the device side of a block
> device. It's a layering violation, and many a filesytem developer
> has been shouted at for trying to do this. At most we can peek
> through it to query functionality support from the request queue,
> but otherwise filesystems do not interact with anything under
> bdev->bd_disk.

So lets add an api that allows the querying of badblocks by bdev and
let the block core handle the bd_disk interaction. I see other block
functionality like blk-integrity reaching through gendisk. The fs need
not interact with the gendisk directly.

>
> As it is, badblocks are used by devices to manage internal state.
> e.g. md for recording stripes that need recovery if the system
> crashes while they are being written out.

I know, I was there when it was invented which is why it was
top-of-mind when pmem had a need to communicate badblocks. Other block
drivers have threatened to use it for badblocks tracking, but none of
those have carried through on that initial interest.

>
> > If an upper level agent really cared about knowing about ->remove()
> > events before they happened it could maybe do something like:
> >
> > dev = disk_to_dev(bdev->bd_disk)->parent;
> > bus_register_notifier(dev->bus. &disk_host_device_notifier_block)
>
> Yeah, that's exactly the sort of thing that filesystems have been
> aggressively discouraged from doing for years.

Yup, it's a layering violation.

> Part of the reason for this is that gendisk based mechanisms are not
> very good for stacked device error reporting. Part of the problem
> here is that every layer of the stacked device has to hook the
> notifier of the block devices underneath it, then translate the
> event to match the upper block device map, then regenerate the
> notification for the next layer up. This isn't an efficient way to
> pass a notification through a series of stacked devices and it is
> messy and cumbersome to maintain.

It's been messy and cumbersome to route new infrastructure through DM
every time a new dax_operation arrives. The corrupted_range() routing
has the same burden. The advantage of badblocks over corrupted_range()
is that it solves the "what If I miss a notification" problem. Each
layer of the stack maintains its sector translation of the next level
errors.
.
> It can be effective for getting notifications to userspace about
> something that happens to a specific block device.

No, it's not block device specific, it's stuck at the disk level. The
user notification aspect was added for pmem at the disk layer because
IIRC it was NAKd to add it to the block_device itself.

>
> But The userspace
> still ends up having to solve the "what does this error resolve to"
> problem. i.e. Userspace still needs to map that notification to a
> filesystem, and for data loss events map it to objects within the
> filesystem, which can be extremely expensive to do from userspace.

Expensive and vulnerable to TOCTOU, this has been the motivation for
filesystem native awareness of these errors from the beginning.

> This is exactly the sort of userspace error reporting mess that
> various projects have asked us to try to fix. Plumbing errors
> internally through the kernel up to the filesystem where the
> filesytem can point directly to the user data that is affected is a
> simple, effective solution to the problem. Especially if we then
> have a generic error notification mechanism for filesystems to emit
> errors to registered userspace watchers...

Agree, that's the dream worth pursuing.

>
> > I still don't think that solves the need for a separate mechanism for
> > global dax_device pte invalidation.
>
> It's just another type of media error because.....
>
> > I think that global dax_device invalidation needs new kernel
> > infrastructure to allow internal users, like dm-writecache and future
> > filesystems using dax for metadata, to take a fault when pmem is
> > offlined.
>
> .... if userspace has directly mapped into the cache, and the cache
> storage goes away, the userspace app has to be killed because we
> have no idea if the device going away has caused data loss or not.
> IOWs, if userspace writes direct to the cache device and it hasn't
> been written back to other storage when it gets yanked, we have just
> caused data corruption to occur.

If userspace has it direct mapped dirty in the cache when the remove
fires, there is no opportunity to flush the cache. Just as there is no
opportunity today with non-DAX and the page cache. The block-queue
will be invalidated and any dirty in page cache is stranded.

> At minimum, we now have to tell the filesystem that the dirty data
> in the cache is now bad, and direct map applications that map those
> dirty ranges need to be killed because their backing store is no
> longer valid nor does the backup copy contain the data they last
> wrote. Nor is it acessible by direct access, which is going to be
> interesting because dynamically changing dax to non-dax access can't
> be done without forcibly kicking the inode out of the cache. That
> requires all references to the inode to go away. And that means the
> event really has to go up to the filesystem.
>
> But I think the biggest piece of the puzzle that you haven't grokked
> here is that the dm cache device isn't a linear map - it's made up of
> random ranges from the underlying devices. Hence the "remove" of a dm
> cache device turns into a huge number of small, sparse corrupt
> ranges, not a single linear device remove event.

I am aware that DM is non-linear. The other non-linearity is sector-to-pfn.

> IOWs, device unplug/remove events are not just simple "pass it on"
> events in a stacked storage setup. There can be non-trivial mappings
> through the layers, and device disappearance may in fact manifest to
> the user as data corruption rather than causing data to be
> inaccessible.

Even MD does not rely on component device notifications for failure
notifications, it waits for write-errors, and yes losing a component
of a raid0 is more than a data offline event.

> Hence "remove" notifications just don't work in the storage stack.
> They need to be translated to block ranges going bad (i.e.  media
> errors), and reported to higher layers as bad ranges, not as device
> removal.

Yes, the generic top-level remove event is pretty much useless for
both the dax pte invalidation and lba range offline notification. I'm
distinguishing that from knock on events that fire in response to
->remove() triggering on the disk driver which seems to be where you
are at as well with the idea to trigger ->corrupted_range(0, EOD) from
->remove().

There's 2 ways to view the "filesystems have wanted proactive
notification of remove events from storage for a long time". There's
either enough pent up demand to convince all parties to come to the
table and get something done, or there's too much momentum with the
status quo to overcome.

I do not think it is fair to ask Ruan to solve a problem with brand
new plumbing that the Linux storage community has not seen fit to
address for a decade. Not when disk->bb is already plumbed without
anyone complaining about it.

> The same goes for DAX devices. The moment they can be placed in
> storage stacks in non-trivial configurations and/or used as cache
> devices that can be directly accessed over tranditional block
> devices, we end up with error conditions that can only be mapped as
> ranges of blocks that have gone bad.

I see plumbing corrupted_range() and using it to communicate removal
in addition to badblocks in addition to bad pfns as a revolutionary
change. A reuse of disk->bb for communicating poison sector discovery
events up the stack and a separate facility to invalidate dax devices
as evolutionary. The evolutionary change does not preclude the
eventual revolutionary change, but it has a better chance of making
forward progress in the near term.
