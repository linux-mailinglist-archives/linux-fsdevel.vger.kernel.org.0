Return-Path: <linux-fsdevel+bounces-53218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67141AEC46C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 05:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9993B7597
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F23202F8F;
	Sat, 28 Jun 2025 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OEGU7Qfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB02B9BF;
	Sat, 28 Jun 2025 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751080207; cv=none; b=suXx4kJnPT6eLdB9pWHK4idsz9A+U/jOS9xhtJMRXWCVYkA7Y5MGZ7RCqLslknJoTBHh8/PukxV/msDNjB5pirixgsgPgXeN8m71PwvHoJ45p/u7IIadd/qD8Us/jKNzRFVnCBspXSUzT+BwddvZXhpmemvGerOq2jQIjiARPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751080207; c=relaxed/simple;
	bh=b8+mJwRFpF5IfFwWI/Tw+nTCKCMhnZyvQe3VieW9Gao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT0j5W24GDqPCmsUsk2JFoXker6/ZF4JjZIdLLmc5czsaTypBMyTuP5hM74ue0czrgnOsEdBKde8iPDmDJoYYS33P6Ex9z1wtLRkSCkgnnTl9DXH80edgYdsrOurRSBBJTH1fDb0wkvQQuNyRYc42xv5ZZtTSIS19Wt8o1f448A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OEGU7Qfw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=229+pb3c1kGk60BjjntDQ84g1jSuhYq7vWg2i21vlZg=; b=OEGU7Qfwp6pr7Q/MLT/iINjvn9
	r9wDB8tQGs2iDEFZdYx/++rPO99UXRjmACqfAUX1J5+K4Htn09lmteRsf2ES8N/PdvKpcGf8S8St3
	gv7vKQEbKMLVFtr7BHMBzvUwjwoTG2uFZmKcNl/ra/ZDYVc17Gz6Vu0aGG5tTsjf6aN3n2i0gx22K
	z1pkwpk3AV93GXamQBrmugHmCaaXYiWHbLkuKu1xMFkJs+bK1JOhLy0gsFXte+TX/2aJPfdqXOmsA
	lR2e74fZFQSdm9lUQ64oJihy8SpLG6yp1jjv4+zrtcC8koqf5CW2GOUzVb+TrjiNdGCR9SUJGJqG0
	FKwHwZ/Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVLx0-0000000FaFQ-2Jy1;
	Sat, 28 Jun 2025 03:09:58 +0000
Message-ID: <4edd9243-38f5-4522-b168-c7c71916d297@infradead.org>
Date: Fri, 27 Jun 2025 20:09:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] iomap: hide ioends from the generic writeback code
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-block@vger.kernel.org, gfs2@lists.linux.dev
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-5-hch@lst.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250627070328.975394-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/25 12:02 AM, Christoph Hellwig wrote:
> Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> one to facilitate non-block, non-ioend writeback for use.  Rename
> the submit_ioend method to writeback_submit and make it mandatory so
> that the generic writeback code stops seeing ioends and bios.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          | 16 +---
>  block/fops.c                                  |  1 +
>  fs/gfs2/bmap.c                                |  1 +
>  fs/iomap/buffered-io.c                        | 91 ++++++++++---------
>  fs/xfs/xfs_aops.c                             | 60 ++++++------
>  fs/zonefs/file.c                              |  1 +
>  include/linux/iomap.h                         | 19 ++--
>  7 files changed, 93 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 3c7989ee84ff..7073c1a3ede3 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -285,7 +285,7 @@ The ``ops`` structure must be specified and is as follows:
>   struct iomap_writeback_ops {
>      int (*writeback_range)(struct iomap_writeback_ctx *wpc,
>      		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> -    int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> +    int (*writeback_submit)(struct iomap_writeback_ctx *wpc, int error);
>   };
>  
>  The fields are as follows:
> @@ -307,13 +307,7 @@ The fields are as follows:
>      purpose.
>      This function must be supplied by the filesystem.
>  
> -  - ``submit_ioend``: Allows the file systems to hook into writeback bio
> -    submission.
> -    This might include pre-write space accounting updates, or installing
> -    a custom ``->bi_end_io`` function for internal purposes, such as
> -    deferring the ioend completion to a workqueue to run metadata update
> -    transactions from process context before submitting the bio.
> -    This function is optional.
> +  - ``writeback_submit``: Submit the previous built writeback context.

                                        previously

>  
>  Pagecache Writeback Completion
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a54b14817cd0..a72ab487c8ab 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c



> @@ -1956,6 +1947,18 @@ iomap_writepages(struct iomap_writeback_ctx *wpc)
>  
>  	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
>  		error = iomap_writepage_map(wpc, folio);
> -	return iomap_submit_ioend(wpc, error);
> +
> +	/*
> +	 * If @error is non-zero, it means that we have a situation where some
> +	 * part of the submission process has failed after we've marked pages
> +	 * for writeback.
> +	 *
> +	 * We cannot cancel the writeback directly in that case, so always call
> +	 * ->writeback_submit to run the I/O completion handler to clear the
> +	 * writeback bit and let the file system proess the errors.

	                                         process

> +	 */
> +	if (wpc->wb_ctx)
> +		return wpc->ops->writeback_submit(wpc, error);
> +	return error;
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);


-- 
~Randy


