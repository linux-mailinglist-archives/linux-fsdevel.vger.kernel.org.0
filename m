Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7312A346F5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 03:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhCXCTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 22:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhCXCTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:19:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336CC061765
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 19:19:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce10so30320878ejb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 19:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6pYt7i3ZfjZRsHKNRy9TSnJLBhdXZsjApsl7qVrkWA=;
        b=RsVkB/Y0CZH9XZzn82erHDDP8QMmPgtgAa2wOWWwpxmakMZJgHzNO7I/+g4m4adiEA
         /AuXJMSkwTq4YjUQhLPhFDbNlzE2s0z/XuQk4Yg9oVyPlFKtUWFGXz9b0FcDyGFf1ZSx
         gkTTKLNlXDSjsuh3nOejNfxEfpMWeohC44aSax0AJ/HiZfzuvt5xWllMplzX3LmiyS9+
         HFcxDA7Y913vpd56MDpHtmf02XWLCE3WdLeUSj4zP1CKL4A7JEBAF9uR9Tj6+4exlzq/
         /21DNknGe39jAd9gmA5iOuCZzGMbd3mXM7qmNlmeF/yAv6uShf/XV5CbiPngHl/r30am
         JXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6pYt7i3ZfjZRsHKNRy9TSnJLBhdXZsjApsl7qVrkWA=;
        b=ZvHpS2P0U2JHNuIAMz9qf7hNKm6l96aVQ6YSuEF7UbSqy+Wmem/8fgy/b6915Wg+ap
         rUcxFHIz/uT4ezmBUkr2yLE3wQupaCNC8xJutlITCF7mUv2ahWKJ08ZPuETuML//QhUE
         Zb3KNdP/7y/Wy7LHwfuUZmTNPgMGLm8JysZSIEOXwxVh/7Ch3LUhacrvwCTOQOa65dYT
         xCWIGjFTyUTAMsUmYVTqu06uGslfceBiXgds9Xy1sI6ThtywBaHGxHE1jPJf58z2Sf6m
         KdXdS0CTWZZ8x4Nn14jlav8C0jAr7vm6hXTFpoLehuTVPq1Xgjevz8DeqTnjo2xxrpWQ
         Bz2A==
X-Gm-Message-State: AOAM531yyFEaH+MXMXQXmaa7dN1U07eSPwTPHIYSUYSOAoZv07lZx8tz
        MNADfy9vH4HxOu9inQhgHG1Y4N06Nqld0JYVdG0M/wVnmLOjGg==
X-Google-Smtp-Source: ABdhPJxD4PFaqvtvK1VRDwzCV3Hl7JUGp0Ljr770gbmSGeQf+7GIop0/MoqaotWJPaQPZgD8nzvxH/6snKVhCi2Z0VU=
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr1187750eje.472.1616552376639;
 Tue, 23 Mar 2021 19:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com> <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Mar 2021 19:19:28 -0700
Message-ID: <CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 7:18 PM ruansy.fnst@fujitsu.com
<ruansy.fnst@fujitsu.com> wrote:
>
>
>
> > -----Original Message-----
> > From: ruansy.fnst@fujitsu.com <ruansy.fnst@fujitsu.com>
> > Subject: RE: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
> > > > > > >
> > > > > > > After the conversation with Dave I don't see the point of this.
> > > > > > > If there is a memory_failure() on a page, why not just call
> > > > > > > memory_failure()? That already knows how to find the inode and
> > > > > > > the filesystem can be notified from there.
> > > > > >
> > > > > > We want memory_failure() supports reflinked files.  In this
> > > > > > case, we are not able to track multiple files from a page(this
> > > > > > broken
> > > > > > page) because
> > > > > > page->mapping,page->index can only track one file.  Thus, I
> > > > > > page->introduce this
> > > > > > ->memory_failure() implemented in pmem driver, to call
> > > > > > ->->corrupted_range()
> > > > > > upper level to upper level, and finally find out files who are
> > > > > > using(mmapping) this page.
> > > > > >
> > > > >
> > > > > I know the motivation, but this implementation seems backwards.
> > > > > It's already the case that memory_failure() looks up the
> > > > > address_space associated with a mapping. From there I would expect
> > > > > a new 'struct address_space_operations' op to let the fs handle
> > > > > the case when there are multiple address_spaces associated with a given
> > file.
> > > > >
> > > >
> > > > Let me think about it.  In this way, we
> > > >     1. associate file mapping with dax page in dax page fault;
> > >
> > > I think this needs to be a new type of association that proxies the
> > > representation of the reflink across all involved address_spaces.
> > >
> > > >     2. iterate files reflinked to notify `kill processes signal` by the
> > > >           new address_space_operation;
> > > >     3. re-associate to another reflinked file mapping when unmmaping
> > > >         (rmap qeury in filesystem to get the another file).
> > >
> > > Perhaps the proxy object is reference counted per-ref-link. It seems
> > > error prone to keep changing the association of the pfn while the reflink is
> > in-tact.
> > Hi, Dan
> >
> > I think my early rfc patchset was implemented in this way:
> >  - Create a per-page 'dax-rmap tree' to store each reflinked file's (mapping,
> > offset) when causing dax page fault.
> >  - Mount this tree on page->zone_device_data which is not used in fsdax, so
> > that we can iterate reflinked file mappings in memory_failure() easily.
> > In my understanding, the dax-rmap tree is the proxy object you mentioned.  If
> > so, I have to say, this method was rejected. Because this will cause huge
> > overhead in some case that every dax page have one dax-rmap tree.
> >
>
> Hi, Dan
>
> How do you think about this?  I am still confused.  Could you give me some advice?

So I think the primary driver of this functionality is dax-devices and
the architectural model for memory failure where several architectures
and error handlers know how to route pfn failure to the
memory_failure() frontend.

Compare that to block-devices where sector failure has no similar
framework, and despite some initial interest about reusing 'struct
badblocks' for this type of scenario there has been no real uptake to
expand 'struct badblocks' outside of the pmem driver.

I think the work you have done for ->corrupted_range() just needs to
be repurposed away from a block-device operation to dax-device
infrastructure. Christoph's pushback on extending
block_device_operations makes sense to me because there is likely no
other user of this facility than the pmem driver, and the pmem driver
only needs it for the vestigial reason that filesystems mount on
block-devices and not dax-devices.

Recently Dave drove home the point that a filesystem can't do anything
with pfns, it needs LBAs. A dax-device does not have LBA's, but it
does operate on the concept of device-relative offsets. The filesystem
is allowed to assume that dax-device:PFN[device_byte_offset >>
PAGE_SHIFT] aliases the same data as the associated
block-device:LBA[device_byte_offset >> SECTOR_SHIFT]. He also
reiterated that this interface should be range based, which you
already had, but I did not include in my attempt to communicate the
mass failure of an entire surprise-removed device.

So I think the path forward is:

- teach memory_failure() to allow for ranged failures

- let interested drivers register for memory failure events via a
blocking_notifier_head

- teach memory_failure() to optionally let the notifier chain claim
the event vs its current default of walking page->mapping

- teach the pmem driver to register for memory_failure() events and
filter the ones that apply to pfns that the driver owns

- drop the nfit driver's usage of the mce notifier chain since
memory_failure() is a superset of what the mce notifier communicates

- augment the pmem driver's view of badblocks that it gets from
address range scrub with one's it gets from memory_failure() events

- when pmem handles a memory_failure() event or an address range scrub
event fire a new event on a new per-dax-device blocking_notifier_head
indicating the dax-relative offset ranges of the translated PFNs. This
notification can optionally indicate failure, offline (for removal),
and online (for repaired ranges).

- teach dm to receive dax-device notifier events from its leaf devices
and then translate them into dax-device notifications relative to the
dm-device offset. This would seem to be a straightforward conversion
of what you have done with ->corrupted_range()

- teach filesystems to register for dax-device notifiers

With all of that in place an interested filesystem can take ownership
of a memory failure that impacts a range of pfns it is responsible for
via a dax-device, but it also allows a not interested filesystem to
default to standard single-pfn-at-a-time error handling and
assumptions about page->mapping only referring to a single address
space.

This obviously does not solve Dave's desire to get this type of error
reporting on block_devices, but I think there's nothing stopping a
parallel notifier chain from being created for block-devices, but
that's orthogonal to requirements and capabilities provided by
dax-devices.
