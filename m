Return-Path: <linux-fsdevel+bounces-12800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F18867599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA19DB2770D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9380024;
	Mon, 26 Feb 2024 12:39:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAF7F7F8;
	Mon, 26 Feb 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951186; cv=none; b=hq5NbC8CvQawrrDphX1szf9w2wGfOZTduX76Nsf0atTcwgPM3XPALwEUITUvxksgj82EEEa5P9Y2BWYB319EWbHXHvJDPf9Y/tCxfrrvjE4EMXx03HmfluhAfSelW2rTMzJSFt1qWBwi/hUnmHPMXOuuN0/+KbybuWBsEuKZeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951186; c=relaxed/simple;
	bh=NGYp5BWIWj8SFQWbwPzlkAlkYMl5l0bOr2xtSsI6jtQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyRnSvZqtQjSEbTtLmIruq/1m5NGxrU/wnswZyFDI20BAsd4HOHZQ1pHZUoseHlBfYlV6KZUsmaZRg0E2Xw2mKezMePgihO37JW8Y6oh754MlnXgGH+JBWTI9WJ+o3JC4WoERRo9UjD01ZTH7iinNzI7TLghQJlMr23mXC7z1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk0Sq6gLRz6K6jp;
	Mon, 26 Feb 2024 20:35:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 715421400DB;
	Mon, 26 Feb 2024 20:39:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:39:41 +0000
Date: Mon, 26 Feb 2024 12:39:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
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
Message-ID: <20240226123940.0000692c@Huawei.com>
In-Reply-To: <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:51 -0600
John Groves <John@Groves.net> wrote:

> Add uapi include file for famfs. The famfs user space uses ioctl on
> individual files to pass in mapping information and file size. This
> would be hard to do via sysfs or other means, since it's
> file-specific.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  include/uapi/linux/famfs_ioctl.h | 56 ++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/uapi/linux/famfs_ioctl.h
> 
> diff --git a/include/uapi/linux/famfs_ioctl.h b/include/uapi/linux/famfs_ioctl.h
> new file mode 100644
> index 000000000000..6b3e6452d02f
> --- /dev/null
> +++ b/include/uapi/linux/famfs_ioctl.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2024 Micron Technology, Inc.
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file system
> + * view of dax files that map to shared memory.
> + */
> +#ifndef FAMFS_IOCTL_H
> +#define FAMFS_IOCTL_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/uuid.h>
> +
> +#define FAMFS_MAX_EXTENTS 2
Why 2?
> +
> +enum extent_type {
> +	SIMPLE_DAX_EXTENT = 13,

Comment on this would be good to have

> +	INVALID_EXTENT_TYPE,
> +};
> +
> +struct famfs_extent {
> +	__u64              offset;
> +	__u64              len;
> +};
> +
> +enum famfs_file_type {
> +	FAMFS_REG,
> +	FAMFS_SUPERBLOCK,
> +	FAMFS_LOG,
> +};
> +
> +/**
> + * struct famfs_ioc_map
> + *
> + * This is the metadata that indicates where the memory is for a famfs file
> + */
> +struct famfs_ioc_map {
> +	enum extent_type          extent_type;
> +	enum famfs_file_type      file_type;

These are going to be potentially varying in size depending on arch, compiler
settings etc.  Been a while, but I though best practice for uapi was always
fixed size elements even though we lose the typing.


> +	__u64                     file_size;
> +	__u64                     ext_list_count;
> +	struct famfs_extent       ext_list[FAMFS_MAX_EXTENTS];
> +};
> +
> +#define FAMFSIOC_MAGIC 'u'
> +
> +/* famfs file ioctl opcodes */
> +#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 1, struct famfs_ioc_map)
> +#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 2, struct famfs_ioc_map)
> +#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 3, struct famfs_extent)
> +#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  4)
> +
> +#endif /* FAMFS_IOCTL_H */


