Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6D326FA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 00:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhB0XlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 18:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhB0XlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 18:41:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27241C061756
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 15:40:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so21360489ejc.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 15:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ElBUABiAQGzdBb9Q14hhgxo5CKFBJ/fW6SlESrFX9c=;
        b=0d/WY1VbsmftP5txlFPrN06ZSFwAfu/IzMFnySmCKUxeZh76AWOWhvMNPjRDVkAIFL
         dk6y3c78mH1V6FDD52TW3RE2pfToGib3K8Lg2GdOpluHw/SfUtUjvw7KPrFmRL5O+7Q/
         W5MhvvnE8la08VUW1FQ3RwzbTpghL0fiSOENkZcZY1DChYaNNluUAGILW/o/QkX4vzA4
         MAIKveH6uUSub4mm/Qx4FlzXWMM4pcU4XVJkTbmCQYhE4T23cq6XxcdfOdWax87TKduI
         XoecLuzoQQqfB/pm+H7NJg4Dpj83ClY7bydMO5sBLRMXOosSpuwO2yTW8aX+lPZ+4hlp
         LpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ElBUABiAQGzdBb9Q14hhgxo5CKFBJ/fW6SlESrFX9c=;
        b=lCO9VE6z/1+T1di4ge8qdxDnFp2ZaDfKbOA857j2UqnUgij9lBpFmFFbNWYxAB8C2k
         6NpU3gtLRckOdlTFfOJRfMcko8wz2i2hd2MQwTncDhESJmjFgN9xC4P0kJzJwYSvP9Nc
         cT3SzYIBFmbPczUvOdpc7Lejzl6qYXbngJOMMvEeFKIo8AMhwljtTx6sDh9pSWMsLyq8
         9Kv0zxIb+FJdaPMnVjLqxmvr+435DiVjdyM7GL+ivjEOp/98fKuK+Lo5RpMaMZ8a+Oo3
         +jPbJdLk5P3biYqG3I75/AjkyU2rTnYUHLNGInuhgYaWbGCQcx0V7yVG/hvFav/20edI
         tewA==
X-Gm-Message-State: AOAM532bpF5e6OeIAnMt+8Gs5afKgpca8DRtw/AluECV5HKL4WSTrI/E
        3PCYZ5hpGUoNh9EyhATKwu3KpPR6+DGeFBmeHZeX9w==
X-Google-Smtp-Source: ABdhPJxbfr1J+RzSUV7IBi8GoEnzC9yBAlDFbKQxsZp0Gu26nrbT35J97kR4cgoSTL5V4L7WiF5R1/XaKW63d8ST/2A=
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr9631355ejc.418.1614469233758;
 Sat, 27 Feb 2021 15:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia> <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area> <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area> <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area>
In-Reply-To: <20210227223611.GZ4662@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 27 Feb 2021 15:40:24 -0800
Message-ID: <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
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

On Sat, Feb 27, 2021 at 2:36 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 26, 2021 at 02:41:34PM -0800, Dan Williams wrote:
> > On Fri, Feb 26, 2021 at 1:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > > On Fri, Feb 26, 2021 at 12:59:53PM -0800, Dan Williams wrote:
> > > > On Fri, Feb 26, 2021 at 12:51 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > My immediate concern is the issue Jason recently highlighted [1] with
> > > > > > respect to invalidating all dax mappings when / if the device is
> > > > > > ripped out from underneath the fs. I don't think that will collide
> > > > > > with Ruan's implementation, but it does need new communication from
> > > > > > driver to fs about removal events.
> > > > > >
> > > > > > [1]: http://lore.kernel.org/r/CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com
> > > > >
> > > > > Oh, yay.
> > > > >
> > > > > The XFS shutdown code is centred around preventing new IO from being
> > > > > issued - we don't actually do anything about DAX mappings because,
> > > > > well, I don't think anyone on the filesystem side thought they had
> > > > > to do anything special if pmem went away from under it.
> > > > >
> > > > > My understanding -was- that the pmem removal invalidates
> > > > > all the ptes currently mapped into CPU page tables that point at
> > > > > the dax device across the system. THe vmas that manage these
> > > > > mappings are not really something the filesystem really manages,
> > > > > but a function of the mm subsystem. What the filesystem cares about
> > > > > is that it gets page faults triggered when a change of state occurs
> > > > > so that it can remap the page to it's backing store correctly.
> > > > >
> > > > > IOWs, all the mm subsystem needs to when pmem goes away is clear the
> > > > > CPU ptes, because then when then when userspace tries to access the
> > > > > mapped DAX pages we get a new page fault. In processing the fault, the
> > > > > filesystem will try to get direct access to the pmem from the block
> > > > > device. This will get an ENODEV error from the block device because
> > > > > because the backing store (pmem) has been unplugged and is no longer
> > > > > there...
> > > > >
> > > > > AFAICT, as long as pmem removal invalidates all the active ptes that
> > > > > point at the pmem being removed, the filesystem doesn't need to
> > > > > care about device removal at all, DAX or no DAX...
> > > >
> > > > How would the pmem removal do that without walking all the active
> > > > inodes in the fs at the time of shutdown and call
> > > > unmap_mapping_range(inode->i_mapping, 0, 0, 1)?
> > >
> > > Which then immediately ends up back at the vmas that manage the ptes
> > > to unmap them.
> > >
> > > Isn't finding the vma(s) that map a specific memory range exactly
> > > what the rmap code in the mm subsystem is supposed to address?
> >
> > rmap can lookup only vmas from a virt address relative to a given
> > mm_struct. The driver has neither the list of mm_struct objects nor
> > virt addresses to do a lookup. All it knows is that someone might have
> > mapped pages through the fsdax interface.
>
> So there's no physical addr to vma translation in the mm subsystem
> at all?
>
> That doesn't make sense. We do exactly this for hwpoison for DAX
> mappings. While we don't look at ptes, we get a pfn,

True hwpoison does get a known failing pfn and then uses page->mapping
to get the 'struct address_space' to do the unmap. I discounted that
approach from the outset because it would mean walking every pfn in a
multi-terabyte device just in case one is mapped at device shutdown.

> it points to, check if it points to the PMEM that is being removed,
> grab the page it points to, map that to the relevant struct page,
> run collect_procs() on that page, then kill the user processes that
> map that page.
>
> So why can't we walk the ptescheck the physical pages that they
> map to and if they map to a pmem page we go poison that
> page and that kills any user process that maps it.
>
> i.e. I can't see how unexpected pmem device unplug is any different
> to an MCE delivering a hwpoison event to a DAX mapped page.

I guess the tradeoff is walking a long list of inodes vs walking a
large array of pages.

There's likely always more pages than inodes, but perhaps it's more
efficient to walk the 'struct page' array than sb->s_inodes?

>  Both
> indicate a physical address range now contains invalid data and the
> filesystem has to take the same action...
>
> IOWs, we could just call ->corrupted_range(0, EOD) here to tell the
> filesystem the entire device went away. Then the filesystem deal
> with this however it needs to. However, it would be more efficient
> from an invalidation POV to just call it on the pages that have
> currently active ptes because once the block device is dead
> new page faults on DAX mappings will get a SIGBUS naturally.

There is no efficient way to lookup "currently active ptes" relative
to a physical pfn range.

SIGBUS will happen naturally either way. I don't think the hwpoison
signal with the extra BUS_MCEERR_* info is appropriate given that
indicates data loss vs data offline of a device being unplugged.

>
> > To me this looks like a notifier that fires from memunmap_pages()
> > after dev_pagemap_kill() to notify any block_device associated with
> > that dev_pagemap() to say that any dax mappings arranged through this
> > block_device are now invalid. The reason to do this after
> > dev_pagemap_kill() is so that any new mapping attempts that are racing
> > the removal will be blocked.
>
> I don't see why this needs a unique notifier. At the filesystem
> level, we want a single interface that tells us "something bad
> happened to the block device", not a proliferation of similar but
> subtly different "bad thing X happened to block device" interfaces
> that are unique to specific physical device drivers...
>
> > The receiver of that notification needs to go from a block_device to a
> > superblock that has mapped inodes and walk ->sb_inodes triggering the
> > unmap/invalidation.
>
> Not necessarily.
>
> What if the filesystem is managing mirrored data across multiple
> devices and this device is only one leg of the mirror?

I can see DAX mapping for read access to one leg of the mirror. The
unplug would fire zap_pte for all the inodes with DAX mappings for
that fs. Filesystem is still free at that point to wait for the next
user access, take a refault, and re-establish the mapping to another
leg of the mirror.

> Or that the
> pmem was used by the RT device in XFS and the data/log devices are
> still fine?

I was assuming that the callback would only be triggered for a dax
device as the data device. So xfs_open_devices() would register
mp->m_super for dax_rtdev.

> What if the pmem is just being used as a cache tier, and
> no data was actually lost?

That's fine the cache mapping is zapped and re-fault figures out what
to do. If anything these questions are a reason not to use
->corrupted_range() for this because recovery can happen at refault vs
taking permanent action on a data loss event.

>
> IOWs, what needs to happen at this point is very filesystem
> specific. Assuming that "device unplug == filesystem dead" is not
> correct, nor is specifying a generic action that assumes the
> filesystem is dead because a device it is using went away.

Ok, I think I set this discussion in the wrong direction implying any
mapping of this action to a "filesystem dead" event. It's just a "zap
all ptes" event and upper layers recover from there.
