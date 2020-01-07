Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A452132EF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgAGTDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 14:03:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:03:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007Ixl88041642;
        Tue, 7 Jan 2020 19:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=pP16p7CV5biucxONI1CRWwnudpCh2Qi23iKl1PGz9LU=;
 b=N6FkUc8uj9VXenfU0c2VcsoliMtTS1p0znfOAfeQ9EsHfSXpNx3QARReX3CQaDxCxWWN
 qcHCOY20RNX5dkMFqktZpRcj4zqvwn3NVoykkV4ixXFUikVxd970Gy+bHdVBFhrJ5hDu
 jrzcHMUaFqmNcx+ps0MORoKuohfsmAKYopXF+TOQHdtnnoPJdf80lVUtqf8qitZVPuKV
 LCOkAcrosCgRFLrFydJh7EX5CAtInoOUiBikY6HuUr9+M7a/ERlvVhpJQ7x3xKsVGmq2
 qZE+K7uf4+mazdelDWgUzXiWiMGdncChudF15pHR1N7IO4Oc8WS/1a2G6NsXHoNZlCNZ kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xaj4tynfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 19:03:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007IsJxd089569;
        Tue, 7 Jan 2020 19:03:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xcpcqvtmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 19:03:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 007J30x7016123;
        Tue, 7 Jan 2020 19:03:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 11:03:00 -0800
Date:   Tue, 7 Jan 2020 11:02:58 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200107190258.GB472665@magnolia>
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
 <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia>
 <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
 <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:49:55AM -0800, Dan Williams wrote:
> On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 10:07:18AM -0800, Dan Williams wrote:
> > > On Tue, Jan 7, 2020 at 10:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> > > > > On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > > > > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > > > > > implementation to expect the block-device to be available.
> > > > > > > > > >
> > > > > > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > > > > > indicated by the block-device partition. That would open up more
> > > > > > > > > > cleanup opportunities.
> > > > > > > > >
> > > > > > > > > Hi Dan,
> > > > > > > > >
> > > > > > > > > After a long time I got time to look at it again. Want to work on this
> > > > > > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > > > > > >
> > > > > > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > > > > > we want to create one dax_device per partition, then it looks like this
> > > > > > > > > will be structured more along the lines how block layer handles disk and
> > > > > > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > > > > > including partition 0). That probably means state belong to whole device
> > > > > > > > > will be in common structure say dax_device_common, and per partition state
> > > > > > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > > > > > dax_device_common.
> > > > > > > > >
> > > > > > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > > > > > partitions be exported to user space.
> > > > > > > >
> > > > > > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > > > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > > > > > devices and then remove them after a cycle or two?
> > > > > > >
> > > > > > > That does seem a better plan than trying to force partition support
> > > > > > > where it is not needed.
> > > > > >
> > > > > > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > > > > > create dm-linear devices for each partition, will DAX still work through
> > > > > > that?
> > > > >
> > > > > The device-mapper support will continue, but it will be limited to
> > > > > whole device sub-components. I.e. you could use kpartx to carve up
> > > > > /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
> > > >
> > > > So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
> > > > is a block device, I thought tools will expect it to be partitioned.
> > > > Sometimes I create those partitions and use /dev/pmem0. So what's
> > > > the replacement for this. People often have tools/scripts which might
> > > > want to partition the device and these will start failing.
> > >
> > > Partitioning will still work, but dax operation will be declined and
> > > fall back to page-cache.
> >
> > Ok, so if I mount /dev/pmem0p1 with dax enabled, that might fail or
> > filesystem will fall back to using page cache. (But dax will not be
> > enabled).
> >
> > >
> > > > IOW, I do not understand that why being able to partition /dev/pmem0
> > > > (which is a block device from user space point of view), is pointless.
> > >
> > > How about s/pointless/redundant/. Persistent memory can already be
> > > "partitioned" via namespace boundaries.
> >
> > But that's an entirely different way of partitioning. To me being able
> > to use block devices (with dax capability) in same way as any other
> > block device makes sense.
> >
> > > Block device partitioning is
> > > then redundant and needlessly complicates, as you have found, the
> > > kernel implementation.
> >
> > It does complicate kernel implementation. Is it too hard to solve the
> > problem in kernel.
> >
> > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > dax code refers back to block device to figure out partition offset in
> > dax device. If we create a dax object corresponding to "struct block_device"
> > and store sector offset in that, then we could pass that object to dax
> > code and not worry about referring back to bdev. I have written some
> > proof of concept code and called that object "dax_handle". I can post
> > that code if there is interest.
> 
> I don't think it's worth it in the end especially considering
> filesystems are looking to operate on /dev/dax devices directly and
> remove block entanglements entirely.
> 
> > IMHO, it feels useful to be able to partition and use a dax capable
> > block device in same way as non-dax block device. It will be really
> > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > will work.
> 
> That can already happen today. If you do not properly align the
> partition then dax operations will be disabled.

Er... is this conversation getting confused?  I was talking about
kpartx's /dev/mapper/pmem0p1 being a straight replacement for the kernel
creating /dev/pmem0p1.  I thnk Vivek was complaining about the
inconsistent behavior between the two, even if the partition is aligned
properly.

I'm not sure how alignment leaked in here?

> This proposal just
> extends that existing failure domain to make all partitions fail to
> support dax.

Oh, wait.  You're proposing that "partitions of pmem devices don't
support DAX", not "the kernel will not create partitions for pmem
devices".

Yeah, that would be inconsistent and weird.  I'd say deprecate the
kernel automounting partitions, but I guess it already does that, and
removing it would break /something/.  I guess you could put
"/dev/pmemXpY" on the deprecation schedule.

--D
