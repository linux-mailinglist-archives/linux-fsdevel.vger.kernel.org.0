Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9523E132EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 19:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgAGSuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 13:50:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgAGSuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:50:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so326863oie.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t48KUg/ZZUxxUfAn6PKZNoX6jboF7EFYxp12esgcQ28=;
        b=ZMpgs2GKyoBtwEMsSb+m34paimovDcZpnH2wIQCItZ+wZEXPLHaFsrW1Ka8cSuQMnE
         L3LOT9AELU5HIQwh5IJkC8uTu8BMrWW1J9xsNCKLVyyaTMgmz0aoyeSKcEbJRxfjkkgV
         5/GsAUxCrExLRE7VKDI+3Rz3Kx3X9A4cs7uTdXiv2ihlLJ6Oc/O1aTuuTcFoqM5nClll
         Sjr9Yl3VgHCYIsueORm7ISm1jdWsGOS3MytGAdYtcbeb/7n1ecazjNclYZvxhqARCCHQ
         PtHsKiZ0iuTvYnOfl/nibcnc+74rtOGBOev5CMVX19jm1kVUidOQa62QdS1UQz5OAtbF
         R1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t48KUg/ZZUxxUfAn6PKZNoX6jboF7EFYxp12esgcQ28=;
        b=ML6wgvoTSzCMfC/wJvTshZixnWk9EX5+GkHJuZh1B7Orn9FTZPQlUku8WaM+VDdMvW
         OEfHxxls6EYZGKdeQ6/dTikrXNtHXxsHaYVTsY8Pf0d9HzROPN9xN76hSTjkZIP67p64
         k7oicI4OPeNPLlsAqVKml84AzDUBLxT8bBpYNps2KqNZ9tWfeq6H8FpiGGghuk4Gr0ZB
         wCTV5TNvDD3fBYe8LEHZEzSszeVfs/aYn6mNul0WIlNpe+nSrOMHlJ9RW1nHwwRHIzIL
         SDDxXFZz/I1bJPX6dKTynghnLBCn/0rHFEY1wW4A+HnMqY1lahCjli77d2r/QISBlBwC
         zoMw==
X-Gm-Message-State: APjAAAVx1baNkmbJCEbbYH5zFTCSjY/of9vX5Yctyfw44j1ZjSJj6WzM
        CjrXOtUT1kRY0RgHRjP95+MpX2ijXaYF6CGFfDGl0g==
X-Google-Smtp-Source: APXvYqySCi7jdU7hO7GxjPpaMeSSljm0zTFLcblWxgWtNbBVyesDfcmhxVvT/h+O/Soz0EZ3GWEae9nu2R5pOinvUiI=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr687284oij.149.1578423006001;
 Tue, 07 Jan 2020 10:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
In-Reply-To: <20200107183307.GD15920@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jan 2020 10:49:55 -0800
Message-ID: <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
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

On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:07:18AM -0800, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 10:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> > > > On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > >
> > > > > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > > > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > > > > implementation to expect the block-device to be available.
> > > > > > > > >
> > > > > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > > > > indicated by the block-device partition. That would open up more
> > > > > > > > > cleanup opportunities.
> > > > > > > >
> > > > > > > > Hi Dan,
> > > > > > > >
> > > > > > > > After a long time I got time to look at it again. Want to work on this
> > > > > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > > > > >
> > > > > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > > > > we want to create one dax_device per partition, then it looks like this
> > > > > > > > will be structured more along the lines how block layer handles disk and
> > > > > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > > > > including partition 0). That probably means state belong to whole device
> > > > > > > > will be in common structure say dax_device_common, and per partition state
> > > > > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > > > > dax_device_common.
> > > > > > > >
> > > > > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > > > > partitions be exported to user space.
> > > > > > >
> > > > > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > > > > devices and then remove them after a cycle or two?
> > > > > >
> > > > > > That does seem a better plan than trying to force partition support
> > > > > > where it is not needed.
> > > > >
> > > > > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > > > > create dm-linear devices for each partition, will DAX still work through
> > > > > that?
> > > >
> > > > The device-mapper support will continue, but it will be limited to
> > > > whole device sub-components. I.e. you could use kpartx to carve up
> > > > /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
> > >
> > > So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
> > > is a block device, I thought tools will expect it to be partitioned.
> > > Sometimes I create those partitions and use /dev/pmem0. So what's
> > > the replacement for this. People often have tools/scripts which might
> > > want to partition the device and these will start failing.
> >
> > Partitioning will still work, but dax operation will be declined and
> > fall back to page-cache.
>
> Ok, so if I mount /dev/pmem0p1 with dax enabled, that might fail or
> filesystem will fall back to using page cache. (But dax will not be
> enabled).
>
> >
> > > IOW, I do not understand that why being able to partition /dev/pmem0
> > > (which is a block device from user space point of view), is pointless.
> >
> > How about s/pointless/redundant/. Persistent memory can already be
> > "partitioned" via namespace boundaries.
>
> But that's an entirely different way of partitioning. To me being able
> to use block devices (with dax capability) in same way as any other
> block device makes sense.
>
> > Block device partitioning is
> > then redundant and needlessly complicates, as you have found, the
> > kernel implementation.
>
> It does complicate kernel implementation. Is it too hard to solve the
> problem in kernel.
>
> W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> dax code refers back to block device to figure out partition offset in
> dax device. If we create a dax object corresponding to "struct block_device"
> and store sector offset in that, then we could pass that object to dax
> code and not worry about referring back to bdev. I have written some
> proof of concept code and called that object "dax_handle". I can post
> that code if there is interest.

I don't think it's worth it in the end especially considering
filesystems are looking to operate on /dev/dax devices directly and
remove block entanglements entirely.

> IMHO, it feels useful to be able to partition and use a dax capable
> block device in same way as non-dax block device. It will be really
> odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> will work.

That can already happen today. If you do not properly align the
partition then dax operations will be disabled. This proposal just
extends that existing failure domain to make all partitions fail to
support dax.
