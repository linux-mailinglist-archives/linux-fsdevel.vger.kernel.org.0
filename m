Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD26159639
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgBKRdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:33:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29182 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729031AbgBKRdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581442420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4X0xfWONZNxuOkpbq3f8Jv0lG2stok0ct4V7XvEvhEQ=;
        b=Xw063yE2SCnIEXtG7JmV9n1NJPe6Ju/E3MSdKhWI/MDryAV59UBizO5m+oZ/aVPcFoOMfD
        LgiPmben91IcjieIMQi2Ms0lYMgAXDgmKaMp/fROz7NXNS3JyEgrqX5VWwdJAYojlU+sy8
        3X9EACDHaj2dMTulEoRR7WXjzWHhmBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-h0GrCcpQOAi3KCxts--_oA-1; Tue, 11 Feb 2020 12:33:38 -0500
X-MC-Unique: h0GrCcpQOAi3KCxts--_oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 391D9100550E;
        Tue, 11 Feb 2020 17:33:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-123-66.rdu2.redhat.com [10.10.123.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C807D26FB2;
        Tue, 11 Feb 2020 17:33:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4579E220A24; Tue, 11 Feb 2020 12:33:31 -0500 (EST)
Date:   Tue, 11 Feb 2020 12:33:31 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200211173331.GC8590@redhat.com>
References: <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
 <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:09:46AM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Hi, Dan,
> >
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> > > I'm going to take a look at how hard it would be to develop a kpartx
> > > fallback in udev. If that can live across the driver transition then
> > > maybe this can be a non-event for end users that already have that
> > > udev update deployed.
> >
> > I just wanted to remind you that label-less dimms still exist, and are
> > still being shipped.  For those devices, the only way to subdivide the
> > storage is via partitioning.
> 
> True, but if kpartx + udev can make this transparent then I don't
> think users lose any functionality. They just gain a device-mapper
> dependency.

Hi Dan,

Are you planning to look into making this work?

We can easily disable partition scanning by specifying gendisk
GENHD_FL_NO_PART_SCAN flag. But what about partition additiona path,
ioctl(BLKPG_ADD_PARTITION). That does not seem to do any checks whether
block device supports in kernel partitions or not. 

So kernel partitions (hence /dev/pmemXpY) objects are created anyway and
this will conflict with all the new planned udev rules.

If you block ioctl(BLKPG_ADD_PARTITION), then user space tools like
parted and fdisk started breaking when trying to create a partition
on /dev/pmeme0. IIUC, we have to allow partition table creation on
/dev/pmem0 so that later kpartx can parse it and create dm-linear
partitions.

Thanks
Vivek

