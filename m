Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF3132DFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgAGSHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 13:07:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35847 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgAGSHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:07:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so873447otz.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9qVcv2ok0qOOmijKDSuHWlK71aI9OJbo1lCq2yFN1g=;
        b=jQH6IumLFu5DdnndMFOX12fwWMj0i8NatfwnP/5oCE1lYwuVmTMX/cnW78ZGwmvQ6C
         Qf0P7QezhZLY6yUTEncsy4CD2+tMq5afmzQir2tuRcj4aYCq6eLC7oaDEl8aEYUIBHsN
         jRw3z+WcIM8BoxFiz2LVFq3zFqYDP6dfz2dVBV0bsl1Jn3z6HVBWAAWrsIMw9Alg7iso
         4qLs9mUkKKQReWortMYNeHaq6H1iki5wIw2Nh1eGzfZxxf0kVY57IcQnV3FcXeFoIGIf
         wyvQRZSkpk7lUva1wSK7WcXpc+5o1xaEGEtRTQSTS8psr/zB3XKTvtR4ukz9uZweRo1S
         A2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9qVcv2ok0qOOmijKDSuHWlK71aI9OJbo1lCq2yFN1g=;
        b=pQYU2QdUNHRH7cyyNMl/xjWOA6wnFMh3hsabWmJpNebOU0wxfyyHCEUb+mxnFZBi/m
         M8ph/C8RE3ZITXwJiGaRaOhFYJnG26yhNWMnEFw/em6Np2z5qHD4RDxrWSBOhFN5TXz+
         UUl9Y0RU2SAMSzA/Uh1WL0R0NdCEDGiDl7L0vYwR/txX5bjRfvXePlfLQaR1pMRsJFck
         iNdgZjZZNwvCD0FEIJVKbAu/pE5gssxf0SwTyRrDYnOJeDlnswcciKsRJ+JNRq7OOQZA
         Doo/Z3leK9kmYHINr5OUaOfZJjOz2F2YFYOwZCuP3AlwjsgTd2sx/3YPAHEsQO8QqzQY
         iFuA==
X-Gm-Message-State: APjAAAVcpMJEKFselCDkq6Hs5ou16vq0H7AO5wEwPNEiUMZc9DWDdo/J
        z7wnSsZa3OxNHGsIiZkNvyhRyP6hPvN0vOfhOLGPMg==
X-Google-Smtp-Source: APXvYqzLIFHJ9zSugFUS6iwPDoK4NgvqbGeVRNhWCXR5x6X+EAsfnzcznFHENk0/XTBefdPXsNFJL268VI72rv55www=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr1079009otq.126.1578420449528;
 Tue, 07 Jan 2020 10:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20190827163828.GA6859@redhat.com> <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
In-Reply-To: <20200107180101.GC15920@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jan 2020 10:07:18 -0800
Message-ID: <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 10:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > > implementation to expect the block-device to be available.
> > > > > > >
> > > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > > indicated by the block-device partition. That would open up more
> > > > > > > cleanup opportunities.
> > > > > >
> > > > > > Hi Dan,
> > > > > >
> > > > > > After a long time I got time to look at it again. Want to work on this
> > > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > > >
> > > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > > we want to create one dax_device per partition, then it looks like this
> > > > > > will be structured more along the lines how block layer handles disk and
> > > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > > including partition 0). That probably means state belong to whole device
> > > > > > will be in common structure say dax_device_common, and per partition state
> > > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > > dax_device_common.
> > > > > >
> > > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > > partitions be exported to user space.
> > > > >
> > > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > > devices and then remove them after a cycle or two?
> > > >
> > > > That does seem a better plan than trying to force partition support
> > > > where it is not needed.
> > >
> > > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > > create dm-linear devices for each partition, will DAX still work through
> > > that?
> >
> > The device-mapper support will continue, but it will be limited to
> > whole device sub-components. I.e. you could use kpartx to carve up
> > /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
>
> So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
> is a block device, I thought tools will expect it to be partitioned.
> Sometimes I create those partitions and use /dev/pmem0. So what's
> the replacement for this. People often have tools/scripts which might
> want to partition the device and these will start failing.

Partitioning will still work, but dax operation will be declined and
fall back to page-cache.

> IOW, I do not understand that why being able to partition /dev/pmem0
> (which is a block device from user space point of view), is pointless.

How about s/pointless/redundant/. Persistent memory can already be
"partitioned" via namespace boundaries. Block device partitioning is
then redundant and needlessly complicates, as you have found, the
kernel implementation.

The problem will be people that were on dax+ext4 on partitions. Those
people will see a hard failure at mount whereas XFS will fallback to
page cache with a warning in the log. I think ext4 must convert to the
xfs dax handling model before partition support is dropped.
