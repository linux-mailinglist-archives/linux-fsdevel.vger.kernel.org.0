Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4032A514
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443047AbhCBLrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577111AbhCBFnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:43:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5313C061797
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 21:41:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bm21so14048992ejb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 21:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qh4mKoIkd3kQcCA7D3vdmXdlqTwhkSQo5TnRd9KvzpU=;
        b=0STt5Ycl180R7lj4Cga2Ph5n69e44b24ZikKiVmIWGCDqXIWGsAZuPE4P0K69CzqQ3
         hp4qehMa5X4OPGH2Cr6+OD16I0cwG0Yobr5C7FFrJ2oVXh0fsFCgZSEE5gXjmtH/7ivf
         gbe24LuMSjYytNGphnsVeKLeBfGmFHEgw9wvB45LrAM79wWh/31Paw4y+M6f0c1HHvBb
         D/4wp9TatYE6PUNIEVVcMd2AL2+Gye2NSMkLupfGJBqy9jKBBehKmfdXd4aobOFuoN5Q
         0J6ACOdAzbGROEwk70MjcGHkQHXaOLPtpkVWjw7rqwCLHJGQnHz2c5zSF4vOvBi7+BB6
         YGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qh4mKoIkd3kQcCA7D3vdmXdlqTwhkSQo5TnRd9KvzpU=;
        b=lcB96CP27ncDTZ+OowIZU+EyboSI6emYxqfaI/qORn8Gg7P79B8DcS82T9ibFpx0Ce
         2FkEZbUmV0q58O6EGVHgTTy9VzXZGp3HJ0OYBVX/9Dr8V7QCUTcgg0BXoleG0TgW3ARE
         zL8ss8u/xOfHOuiASFPVtuvLS2BdzCWVLJDS8lX7Mis7U18+x8tNxd00AqSHpfewag1G
         PIMn3pFzxTCO9rOUDkjvREIgYGaBIFLjuOFOEnWAShGRS3CbggpvIgqleOqB21ZM9q+R
         ANA3oXAu4r+hwjXv1zQM4DlPQPqwkHUorTSAj3z/dn0PLOAhIcIOeOfcihlrTNvIAXs7
         JuMA==
X-Gm-Message-State: AOAM531Ecq56fz8I8SnzX9t/3BQkQxPvngy0TbvCKWt6QxpA18hYYgCr
        ZlQW4BoI5LjjQEK+aDL19k7icaAIr1U/CuyJPRZCfw==
X-Google-Smtp-Source: ABdhPJxSTLNvImcrUmvKf16p/MTyfu851ZZ+6qH6ZGGBP8HSYNNJYVzLikGtLufav/PCWMtKvjVEi1My0ZZJ0iw+rtA=
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr19400531ejc.472.1614663671165;
 Mon, 01 Mar 2021 21:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20210226190454.GD7272@magnolia> <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area> <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area> <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area> <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area> <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210302032805.GM7272@magnolia>
In-Reply-To: <20210302032805.GM7272@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Mar 2021 21:41:02 -0800
Message-ID: <CAPcyv4jXH0F+aii6ZtYQ3=Rx-mOWM7NFHC9wVxacW-b1o_s20g@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
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

On Mon, Mar 1, 2021 at 7:28 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Mar 01, 2021 at 12:55:53PM -0800, Dan Williams wrote:
> > On Sun, Feb 28, 2021 at 2:39 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Sat, Feb 27, 2021 at 03:40:24PM -0800, Dan Williams wrote:
> > > > On Sat, Feb 27, 2021 at 2:36 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > On Fri, Feb 26, 2021 at 02:41:34PM -0800, Dan Williams wrote:
> > > > > > On Fri, Feb 26, 2021 at 1:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > On Fri, Feb 26, 2021 at 12:59:53PM -0800, Dan Williams wrote:
> > > > > it points to, check if it points to the PMEM that is being removed,
> > > > > grab the page it points to, map that to the relevant struct page,
> > > > > run collect_procs() on that page, then kill the user processes that
> > > > > map that page.
> > > > >
> > > > > So why can't we walk the ptescheck the physical pages that they
> > > > > map to and if they map to a pmem page we go poison that
> > > > > page and that kills any user process that maps it.
> > > > >
> > > > > i.e. I can't see how unexpected pmem device unplug is any different
> > > > > to an MCE delivering a hwpoison event to a DAX mapped page.
> > > >
> > > > I guess the tradeoff is walking a long list of inodes vs walking a
> > > > large array of pages.
> > >
> > > Not really. You're assuming all a filesystem has to do is invalidate
> > > everything if a device goes away, and that's not true. Finding if an
> > > inode has a mapping that spans a specific device in a multi-device
> > > filesystem can be a lot more complex than that. Just walking inodes
> > > is easy - determining whihc inodes need invalidation is the hard
> > > part.
> >
> > That inode-to-device level of specificity is not needed for the same
> > reason that drop_caches does not need to be specific. If the wrong
> > page is unmapped a re-fault will bring it back, and re-fault will fail
> > for the pages that are successfully removed.
> >
> > > That's where ->corrupt_range() comes in - the filesystem is already
> > > set up to do reverse mapping from physical range to inode(s)
> > > offsets...
> >
> > Sure, but what is the need to get to that level of specificity with
> > the filesystem for something that should rarely happen in the course
> > of normal operation outside of a mistake?
>
> I can't tell if we're conflating the "a bunch of your pmem went bad"
> case with the "all your dimms fell out of the machine" case.

From the pmem driver perspective it has the media scanning to find
some small handful of cachelines that have gone bad, and it has the
driver ->remove() callback to tell it a bunch of pmem is now offline.
The NVDIMM device "range has gone bad" mechanism has no way to
communicate multiple terabytes have gone bad at once.

In fact I think the distinction is important that ->remove() is not
treated as ->corrupted_range() because I expect the level of freakout
is much worse for a "your storage is offline" notification vs "your
storage is corrupted" notification.

> If, say, a single cacheline's worth of pmem goes bad on a node with 2TB
> of pmem, I certainly want that level of specificity.  Just notify the
> users of the dead piece, don't flush the whole machine down the drain.

Right, something like corrupted_range() is there to say, "keep going
upper layers, but note that this handful of sectors now has
indeterminant data and will return -EIO on access until repaired". The
repair for device-offline is device-online.

>
> > > > There's likely always more pages than inodes, but perhaps it's more
> > > > efficient to walk the 'struct page' array than sb->s_inodes?
> > >
> > > I really don't see you seem to be telling us that invalidation is an
> > > either/or choice. There's more ways to convert physical block
> > > address -> inode file offset and mapping index than brute force
> > > inode cache walks....
> >
> > Yes, but I was trying to map it to an existing mechanism and the
> > internals of drop_pagecache_sb() are, in coarse terms, close to what
> > needs to happen here.
>
> Yes.  XFS (with rmap enabled) can do all the iteration and walking in
> that function except for the invalidate_mapping_* call itself.  The goal
> of this series is first to wire up a callback within both the block and
> pmem subsystems so that they can take notifications and reverse-map them
> through the storage stack until they reach an fs superblock.

I'm chuckling because this "reverse map all the way up the block
layer" is the opposite of what Dave said at the first reaction to my
proposal, "can't the mm map pfns to fs inode  address_spaces?".

I think dax unmap is distinct from corrupted_range() precisely because
they are events happening in two different domains, block device
sectors vs dax device pfns.

Let's step back. I think a chain of ->corrupted_range() callbacks up
the block stack terminating in the filesystem with dax implications
tacked on is the wrong abstraction. Why not use the existing generic
object for communicating bad sector ranges, 'struct badblocks'?

Today whenever the pmem driver receives new corrupted range
notification from the lower level nvdimm
infrastructure(nd_pmem_notify) it updates the 'badblocks' instance
associated with the pmem gendisk and then notifies userspace that
there are new badblocks. This seems a perfect place to signal an upper
level stacked block device that may also be watching disk->bb. Then
each gendisk in a stacked topology is responsible for watching the
badblock notifications of the next level and storing a remapped
instance of those blocks until ultimately the filesystem mounted on
the top-level block device is responsible for registering for those
top-level disk->bb events.

The device gone notification does not map cleanly onto 'struct badblocks'.

If an upper level agent really cared about knowing about ->remove()
events before they happened it could maybe do something like:

dev = disk_to_dev(bdev->bd_disk)->parent;
bus_register_notifier(dev->bus. &disk_host_device_notifier_block)

...where it's trying to watch for events that will trigger the driver
->remove() callback on the device hosting a disk.

I still don't think that solves the need for a separate mechanism for
global dax_device pte invalidation.

I think that global dax_device invalidation needs new kernel
infrastructure to allow internal users, like dm-writecache and future
filesystems using dax for metadata, to take a fault when pmem is
offlined. They can't use the direct-map because the direct-map can't
fault, and they can't indefinitely pin metadata pages because that
blocks ->remove() from being guaranteed of forward progress.

Then an invalidation event is indeed a walk of address_space like
objects where some are fs-inodes and some are kernel-mode dax-users,
and that remains independent from remove events and badblocks
notifications because they are independent objects and events.

In contrast I think calling something like soft_offline_page() a pfn
at a time over terabytes will take forever especially when that event
need not fire if the dax_device is not mounted.

> Once the information has reached XFS, it can use its own reverse
> mappings to figure out which pages of which inodes are now targetted.

It has its own sector based reverse mappings, it does not have pfn reverse map.

> The future of DAX hw error handling can be that you throw the spitwad at
> us, and it's our problem to distill that into mm invalidation calls.
> XFS' reverse mapping data is indexed by storage location and isn't
> sharded by address_space, so (except for the DIMMs falling out), we
> don't need to walk the entire inode list or scan the entire mapping.

->remove() is effectively all the DIMMs falling out for all XFS knows.

> Between XFS and DAX and mm, the mm already has the invalidation calls,
> xfs already has the distiller, and so all we need is that first bit.
> The current mm code doesn't fully solve the problem, nor does it need
> to, since it handles DRAM errors acceptably* already.
>
> * Actually, the hwpoison code should _also_ be calling ->corrupted_range
> when DRAM goes bad so that we can detect metadata failures and either
> reload the buffer or (if it was dirty) shut down.
[..]
> > Going forward, for buses like CXL, there will be a managed physical
> > remove operation via PCIE native hotplug. The flow there is that the
> > PCIE hotplug driver will notify the OS of a pending removal, trigger
> > ->remove() on the pmem driver, and then notify the technician (slot
> > status LED) that the card is safe to pull.
>
> Well, that's a relief.  Can we cancel longterm RDMA leases now too?
> <duck>

Yes, all problems can be solved with more blinky lights.
