Return-Path: <linux-fsdevel+bounces-12640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14F86220E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E5F2867A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3D611B;
	Sat, 24 Feb 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGPoinDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75B4691;
	Sat, 24 Feb 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708738772; cv=none; b=mZ9nvgih6BpHXS80mXZhHRmQwWbYBoFnDl9pEWHLgxet0IYHnS0q+KuabPDeG+sGjLc96rJQyk5WZ7Yf5Mo2AKhKkhOlzvIy+nFRtpe0jqUf0Reg0BocxFT4nA4vQ+oQroTpbAxYOLKqmjY4441CkeV3pRFaNPSMVpOr0rVyO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708738772; c=relaxed/simple;
	bh=grmqTGtQG9fq4CPhxxcq8kJy2UzulKY7x/6Pg9ONvnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YveVGlPlyXpv+1SJjxLtlXHHhWAcpWSBqFvV6EMHRsDSHvA99bnpwDBL2UK4wg45GsHdDwNFJ3617xBP9E8lJaH/oaavZ8ueo+kbCTJQY58CNf8LdFxEXkcnMfIY343BRNb84znhjKwAyyx8FAz5QN27NjBniyKJxNqEV2xkR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGPoinDl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1PQkgMOAg6e8eTu59zqEMoNNkn6K/4X8IH67/pQAy/U=; b=BGPoinDluaiJF6D2vgIjksRoEi
	EGPOmrVD8c1/7zjT288XvYtD2u02gttPLPx5bqlaamxkRtQXVtwcAeGFb+Wb7W0ex0f0bvb/MMojE
	T+EYgKVVDHZnxczc/XoDBX2Y/l2sIwygIOFW3sSccxT4j1azU4+OF1mFOd3vwoDCyBaleT1UgR7rk
	Vl6Xe26wsYxkqEm4i5Ey1ex9eagaLhRaeF+ofuRX9vwgmGF/8M3h47gpG9fZ3cDAztLbJZgzq1TE/
	1FbK4ga7kiurfiPB8XXA+xGjKiPiNS7Jnzou+Xl6yRTtZiAnQvVmFe+IZ4wa2G64oHTm8GlqzdkhL
	CRgI0hVQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdh0d-0000000BoWv-1wgB;
	Sat, 24 Feb 2024 01:39:23 +0000
Message-ID: <8f62b688-6c14-4eab-b039-7d9a112893f8@infradead.org>
Date: Fri, 23 Feb 2024 17:39:22 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/20] famfs: Add include/linux/famfs_ioctl.h
Content-Language: en-US
To: John Groves <John@Groves.net>, John Groves <jgroves@micron.com>,
 Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Cc: john@jagalactic.com, Dave Chinner <david@fromorbit.com>,
 Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
 gregory.price@memverge.com
References: <cover.1708709155.git.john@groves.net>
 <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/23/24 09:41, John Groves wrote:
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

      This is confusing to me. Is it just me? ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
> +
> +enum extent_type {
> +	SIMPLE_DAX_EXTENT = 13,
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

"/**" is used to begin kernel-doc comments, but this comment block is missing
a few entries to make it be kernel-doc compatible. Please either add them
or just use "/*" to begin the comment.

> + * struct famfs_ioc_map
> + *
> + * This is the metadata that indicates where the memory is for a famfs file
> + */
> +struct famfs_ioc_map {
> +	enum extent_type          extent_type;
> +	enum famfs_file_type      file_type;
> +	__u64                     file_size;
> +	__u64                     ext_list_count;
> +	struct famfs_extent       ext_list[FAMFS_MAX_EXTENTS];
> +};
> +
> +#define FAMFSIOC_MAGIC 'u'

This 'u' value should be documented in
Documentation/userspace-api/ioctl/ioctl-number.rst.

and if possible, you might want to use values like 0x5x or 0x8x
that don't conflict with the ioctl numbers that are already used
in the 'u' space.

> +
> +/* famfs file ioctl opcodes */
> +#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 1, struct famfs_ioc_map)
> +#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 2, struct famfs_ioc_map)
> +#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 3, struct famfs_extent)
> +#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  4)
> +
> +#endif /* FAMFS_IOCTL_H */

-- 
#Randy

