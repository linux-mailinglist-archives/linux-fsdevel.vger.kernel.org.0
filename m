Return-Path: <linux-fsdevel+bounces-12840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C5867D86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647D11F2985E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAC130E3C;
	Mon, 26 Feb 2024 16:56:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85F12C522;
	Mon, 26 Feb 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966608; cv=none; b=lYCm534TJv2H7hBJdQZn0IPbaXmnTPf+LrnXAXkEHYl3HZhzp9rjo4Eoi699mnA2K+F+ALemlq9Cbc/v+fpkrXpQnwADu27Sp3WR7iHMoqpXpda1z61jo67E9N6/7fP1/Ro8UroRtETGNQFZh05yyj5HIaxG62tY4xgpsUfUkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966608; c=relaxed/simple;
	bh=RzHsl48OLYh1aqi3F31HwLiqNz8fY9P49rMhS62lRMM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lc0qmehqmwrqDkYvzfI+hEJ5ZcNM5+FZZG1PJssg2wunCoj18J3rhWmvstE15YNnOEgQA2oTtwsIR0unuWa+9HncfDD66LQNpIN/2+G7pLqBQpk04iyfM177NLf31/TVMrdIepDsGX8bj2n6o2mUXyW9S5Mr8Y62X+KTGH9CR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk6935sM2z6J9nb;
	Tue, 27 Feb 2024 00:52:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 07DE3140B73;
	Tue, 27 Feb 2024 00:56:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 16:56:41 +0000
Date: Mon, 26 Feb 2024 16:56:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 07/20] famfs: Add include/linux/famfs_ioctl.h
Message-ID: <20240226165639.000025c6@Huawei.com>
In-Reply-To: <z3fx5uiv6uu4sawvxrhfvx42qetchmq4ozxhq2huwg2rrcyk5c@odbiisdhop2m>
References: <cover.1708709155.git.john@groves.net>
	<b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
	<20240226123940.0000692c@Huawei.com>
	<z3fx5uiv6uu4sawvxrhfvx42qetchmq4ozxhq2huwg2rrcyk5c@odbiisdhop2m>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 10:44:43 -0600
John Groves <John@groves.net> wrote:

> On 24/02/26 12:39PM, Jonathan Cameron wrote:
> > On Fri, 23 Feb 2024 11:41:51 -0600
> > John Groves <John@Groves.net> wrote:
> >   
> > > Add uapi include file for famfs. The famfs user space uses ioctl on
> > > individual files to pass in mapping information and file size. This
> > > would be hard to do via sysfs or other means, since it's
> > > file-specific.
> > > 
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  include/uapi/linux/famfs_ioctl.h | 56 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644 include/uapi/linux/famfs_ioctl.h
> > > 
> > > diff --git a/include/uapi/linux/famfs_ioctl.h b/include/uapi/linux/famfs_ioctl.h
> > > new file mode 100644
> > > index 000000000000..6b3e6452d02f
> > > --- /dev/null
> > > +++ b/include/uapi/linux/famfs_ioctl.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +/*
> > > + * famfs - dax file system for shared fabric-attached memory
> > > + *
> > > + * Copyright 2023-2024 Micron Technology, Inc.
> > > + *
> > > + * This file system, originally based on ramfs the dax support from xfs,
> > > + * is intended to allow multiple host systems to mount a common file system
> > > + * view of dax files that map to shared memory.
> > > + */
> > > +#ifndef FAMFS_IOCTL_H
> > > +#define FAMFS_IOCTL_H
> > > +
> > > +#include <linux/ioctl.h>
> > > +#include <linux/uuid.h>
> > > +
> > > +#define FAMFS_MAX_EXTENTS 2  
> > Why 2?  
> 
> You catch everything! 
> 
> This limit is in place to avoid supporting somethign we're not testing. It
> will probably be raised later.
> 
> Currently user space doesn't support deleting files, which makes it easy
> to ignore whether any clients have a stale view of metadata. If there is
> no delete, there's actually no reason to have more than 1 extent.
Then have 1. + a Comment on why it is 1.
> 
> > > +
> > > +enum extent_type {
> > > +	SIMPLE_DAX_EXTENT = 13,  
> > 
> > Comment on this would be good to have  
> 
> Done. Basically we anticipate there being other types of extents in the
> future.

I was more curious about the 13!

> 
> >   
> > > +	INVALID_EXTENT_TYPE,
> > > +};
> > > +
> > > +struct famfs_extent {
> > > +	__u64              offset;
> > > +	__u64              len;
> > > +};
> > > +
> > > +enum famfs_file_type {
> > > +	FAMFS_REG,
> > > +	FAMFS_SUPERBLOCK,
> > > +	FAMFS_LOG,
> > > +};
> > > +
> > > +/**
> > > + * struct famfs_ioc_map
> > > + *
> > > + * This is the metadata that indicates where the memory is for a famfs file
> > > + */
> > > +struct famfs_ioc_map {
> > > +	enum extent_type          extent_type;
> > > +	enum famfs_file_type      file_type;  
> > 
> > These are going to be potentially varying in size depending on arch, compiler
> > settings etc.  Been a while, but I though best practice for uapi was always
> > fixed size elements even though we lose the typing.  
> 
> I might not be following you fully here. User space is running the same
> arch as kernel, so an enum can't be a different size, right? It could be
> a different size on different arches, but this is just between user/kernel.

I can't remember why, but this has bitten me in the past.
Ah, should have known Daniel would have written something on it ;)
https://www.kernel.org/doc/html/next/process/botching-up-ioctls.html

It's the fun of need for compat ioctls with 32bit userspace on 64bit kernels.

The alignment one is key as well. That bit me more than once due to
32bit x86 aligning 64 bit integers at 32 bits.

We could just not support these cases but it's easy to get right so why
bother with complexity of ruling them out.

> 
> I initially thought of XDR for on-media-format, which file systems need
> to do with on-media structs (superblocks, logs, inodes, etc. etc.). But
> this struct is not used in that way.
> 
> In fact, famfs' on-media/in-memory metadata (superblock, log, log entries)
> is only ever read read and written by user space - so it's the user space
> code that needs XDR on-media-format handling.
> 
> So to clarify - do you think those enums should be u32 or the like?

Yes. As it's userspace, uint32_t maybe or __u32. I 'think'
both are acceptable in uapi headers these days.

> 
> Thanks!
> John
> 


