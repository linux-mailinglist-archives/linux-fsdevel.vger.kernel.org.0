Return-Path: <linux-fsdevel+bounces-10521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1A84BEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD11C23602
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8317BCD;
	Tue,  6 Feb 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xPb8YK/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FE17BA0;
	Tue,  6 Feb 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251381; cv=none; b=ilCUY9X4mNqYXFF4OAy9JqZGIWZndofB0NbEgCRRytgTfZN1D+LG30AIG/cIq+1h/Ixboifq01M5vMATj768pEMreG9aeg44y0mI+7doumVOIQHLrpasRjcuEcD1V8nbZUpBKYursokD8Sh1youPN6gmOcATbvaUOf2bG2Jdn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251381; c=relaxed/simple;
	bh=Cv3/fApky2dxdbAPQhPaduQHBrTiKI4IDLOmiw5VP2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwpfSmdnAAv+W4+oEydHHKCA/ORii0SZa+Q3cB7Q5LhCDIpKWVfHlvD4XEb2SyPSOeuDv1jeIRWca0K77m9JI3r9Vk4fOKoTh+tZ+mePXW3r7J4aVA2vTYOfdQNhOv7zLm1UWzs0aMjo0YLgyYP2SYyKAAkgd96MV36grRQvOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xPb8YK/p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=g6B5BxwmsGyW+u9yeLS9SldYEcDJxD1IImH874f49+s=; b=xPb8YK/pn7c8wIJFp5mvckBcTk
	ab3gmZx00G4IBmY8oFTdEHsPyeJh6dGmqzr1UuWad3J9zV7k8rw0eh9Ce/NubzvCy9exKgqabkQXh
	DwWeIxueUouFZ1LrIJZ6NsG+n+nEMlTG//X7wrhz1xfnLsGtJpquoOCLee8vpuuHkohROBC5PpBRB
	Zy8/uG5K1h6oQ9MgcRpxEyZocKW9k+XYZJxx+Ry+6otIp34FF9tIIGdVAAP3G+MYxH7Xzd93RTOhc
	pkZAL4jXBvq5n0c7kM+MuV3bd27MF5yv1ROFsn5VTZBjqj/NPkpxOrZt45yrI3mps5GQtcd3hlprR
	IJEnbYCw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXS4W-00000008oSt-3BVq;
	Tue, 06 Feb 2024 20:29:36 +0000
Message-ID: <865af278-e7c1-4e62-83ce-56f7ce6f7aba@infradead.org>
Date: Tue, 6 Feb 2024 12:29:36 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] fs: FS_IOC_GETUUID
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.or
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240206201858.952303-4-kent.overstreet@linux.dev>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240206201858.952303-4-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 12:18, Kent Overstreet wrote:
> Add a new generic ioctls for querying the filesystem UUID.
> 
> These are lifted versions of the ext4 ioctls, with one change: we're not
> using a flexible array member, because UUIDs will never be more than 16
> bytes.
> 
> This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> reads from super_block->s_uuid. We're not lifting SETFSUUID from ext4 -
> that can be done on offline filesystems by the people who need it,
> trying to do it online is just asking for too much trouble.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: linux-fsdevel@vger.kernel.or
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/ioctl.c              | 16 ++++++++++++++++
>  include/uapi/linux/fs.h | 17 +++++++++++++++++
>  2 files changed, 33 insertions(+)
> 


> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 48ad69f7722e..16a6ecadfd8d 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,19 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/*
> + * We include a length field because some filesystems (vfat) have an identifier
> + * that we do want to expose as a UUID, but doesn't have the standard length.
> + *
> + * We use a fixed size buffer beacuse this interface will, by fiat, never

                                 because

> + * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
> + * users to have to deal with that.
> + */
> +struct fsuuid2 {
> +	__u8	len;
> +	__u8	uuid[16];
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -190,6 +203,9 @@ struct fsxattr {
>   * (see uapi/linux/blkzoned.h)
>   */
>  
> +/* Returns the external filesystem UUID, the same one blkid returns */
> +#define FS_IOC_GETFSUUID		_IOR(0x12, 142, struct fsuuid2)
> +
>  #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
>  #define FIBMAP	   _IO(0x00,1)	/* bmap access */
>  #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
> @@ -198,6 +214,7 @@ struct fsxattr {
>  #define FITRIM		_IOWR('X', 121, struct fstrim_range)	/* Trim */
>  #define FICLONE		_IOW(0x94, 9, int)
>  #define FICLONERANGE	_IOW(0x94, 13, struct file_clone_range)
> +
>  #define FIDEDUPERANGE	_IOWR(0x94, 54, struct file_dedupe_range)

Why the additional blank line? (nit)

>  
>  #define FSLABEL_MAX 256	/* Max chars for the interface; each fs may differ */

-- 
#Randy

