Return-Path: <linux-fsdevel+bounces-46781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75179A94BC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 05:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C81170468
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45484257438;
	Mon, 21 Apr 2025 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EG7Ld6U4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF223BA36;
	Mon, 21 Apr 2025 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745207535; cv=none; b=mn1Vpk7Uc6w3jyLSyzY00WNNG4KRBPVgF4lF/SNnzFGtTwSsKXMJndBOAsOE31KDPASaN2jYXAFccRwKictW5iswL/uLmNXNa7MvlFnJ5nN5mQDdP1GQfJRmPrhvmAvdOySxqlSkwDYpO0fDdckQrMHQ0EPH9psmbf2FmvF11eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745207535; c=relaxed/simple;
	bh=SKy360k2jX7Gti4B3tJCD993GCWcNTHmk1yoWFKrfh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgO4LJdZ+cIdD2oYP0xHAoiJJyXOqpupfqxrxOUtG2dK5DmuO3H+3xYsz0Gvo4hnFb7GIgdshEe7y9LpxJvPv+ChA59YTV8DtMgEDxNOLADPsmjXY4eLA3dx1xRm6l32YrKBqOyhxm07oqoTUG+VsamdRb935D383vHM3+ei4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EG7Ld6U4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HPPSSA49F2GQFYt4Y3+jo5LCCyAfhAv7rGkUEFsAg2c=; b=EG7Ld6U4DAUbtxsn3tkr+eGn0v
	kxXkR+MHBvDsceOcYb96/Ypg4Xa6x74Itezu5DqfP/dwzSraKK5DlytGlTIJyNilAyIkZbmiwBcFo
	Hb21edNODFSLNmnDF0vQ13X5CSFfozaHGwSt6bTVs+BO/94px/OGwnzQNPeQ105jPJF2aD+ytX0NS
	YwGXBLQycV44ptuCT9l0BdbRIP34dg02Dmt3QY4Tq1goySGanPRlspvFoYrisyUghzDrML4xDoJyp
	mLs5CjgmNUuATiEC/D0CxhLLu2skBjFVKAFutNuEMzBA8nk+qUyWcofA4eYX/6fffIPDelsC79Hop
	BhMvra/w==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u6iCK-0000000Azui-2RFo;
	Mon, 21 Apr 2025 03:51:59 +0000
Message-ID: <f0b218f4-7379-4fa5-93e4-a1c9dd4c411c@infradead.org>
Date: Sun, 20 Apr 2025 20:51:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/19] famfs_fuse: Add famfs metadata documentation
To: John Groves <John@Groves.net>, Dan Williams <dan.j.williams@intel.com>,
 Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Luis Henriques <luis@igalia.com>,
 Jeff Layton <jlayton@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>,
 Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-18-john@groves.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250421013346.32530-18-john@groves.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/20/25 6:33 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> This describes the fmap metadata - both simple and interleaved
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/famfs_kfmap.h | 90 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> index 325adb8b99c5..7c8d57b52e64 100644
> --- a/fs/fuse/famfs_kfmap.h
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -7,10 +7,90 @@
>  #ifndef FAMFS_KFMAP_H
>  #define FAMFS_KFMAP_H
>  
> +
> +/* KABI version 43 (aka v2) fmap structures
> + *
> + * The location of the memory backing for a famfs file is described by
> + * the response to the GET_FMAP fuse message (devined in

                                                 divined

> + * include/uapi/linux/fuse.h
> + *
> + * There are currently two extent formats: Simple and Interleaved.
> + *
> + * Simple extents are just (devindex, offset, length) tuples, where devindex
> + * references a devdax device that must retrievable via the GET_DAXDEV

                                      must be

> + * message/response.
> + *
> + * The extent list size must be >= file_size.
> + *
> + * Interleaved extents merit some additional explanation. Interleaved
> + * extents stripe data across a collection of strips. Each strip is a
> + * contiguous allocation from a single devdax device - and is described by
> + * a simple_extent structure.
> + *
> + * Interleaved_extent example:
> + *   ie_nstrips = 4
> + *   ie_chunk_size = 2MiB
> + *   ie_nbytes = 24MiB
> + *
> + * ┌────────────┐────────────┐────────────┐────────────┐
> + * │Chunk = 0   │Chunk = 1   │Chunk = 2   │Chunk = 3   │
> + * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
> + * │Stripe = 0  │Stripe = 0  │Stripe = 0  │Stripe = 0  │
> + * │            │            │            │            │
> + * └────────────┘────────────┘────────────┘────────────┘
> + * │Chunk = 4   │Chunk = 5   │Chunk = 6   │Chunk = 7   │
> + * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
> + * │Stripe = 1  │Stripe = 1  │Stripe = 1  │Stripe = 1  │
> + * │            │            │            │            │
> + * └────────────┘────────────┘────────────┘────────────┘
> + * │Chunk = 8   │Chunk = 9   │Chunk = 10  │Chunk = 11  │
> + * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
> + * │Stripe = 2  │Stripe = 2  │Stripe = 2  │Stripe = 2  │
> + * │            │            │            │            │
> + * └────────────┘────────────┘────────────┘────────────┘
> + *
> + * * Data is laid out across chunks in chunk # order
> + * * Columns are strips
> + * * Strips are contiguous devdax extents, normally each coming from a
> + *   different
> + *   memory device

Combine 2 lines above.

> + * * Rows are stripes
> + * * The number of chunks is (int)((file_size + chunk_size - 1) / chunk_size)
> + *   (and obviously the last chunk could be partial)
> + * * The stripe_size = (nstrips * chunk_size)
> + * * chunk_num(offset) = offset / chunk_size    //integer division
> + * * strip_num(offset) = chunk_num(offset) % nchunks
> + * * stripe_num(offset) = offset / stripe_size  //integer division
> + * * ...You get the idea - see the code for more details...
> + *
> + * Some concrete examples from the layout above:
> + * * Offset 0 in the file is offset 0 in chunk 0, which is offset 0 in
> + *   strip 0
> + * * Offset 4MiB in the file is offset 0 in chunk 2, which is offset 0 in
> + *   strip 2
> + * * Offset 15MiB in the file is offset 1MiB in chunk 7, which is offset
> + *   3MiB in strip 3
> + *
> + * Notes about this metadata format:
> + *
> + * * For various reasons, chunk_size must be a multiple of the applicable
> + *   PAGE_SIZE
> + * * Since chunk_size and nstrips are constant within an interleaved_extent,
> + *   resolving a file offset to a strip offset within a single
> + *   interleaved_ext is order 1.
> + * * If nstrips==1, a list of interleaved_ext structures degenerates to a
> + *   regular extent list (albeit with some wasted struct space).
> + */
> +
> +
>  /*
> - * These structures are the in-memory metadata format for famfs files. Metadata
> - * retrieved via the GET_FMAP response is converted to this format for use in
> - * resolving file mapping faults.
> + * The structures below are the in-memory metadata format for famfs files.
> + * Metadata retrieved via the GET_FMAP response is converted to this format
> + * for use in  * resolving file mapping faults.

                  ^drop

> + *
> + * The GET_FMAP response contains the same information, but in a more
> + * message-and-versioning-friendly format. Those structs can be found in the
> + * famfs section of include/uapi/linux/fuse.h (aka fuse_kernel.h in libfuse)
>   */
>  
>  enum famfs_file_type {
> @@ -19,7 +99,7 @@ enum famfs_file_type {
>  	FAMFS_LOG,
>  };
>  
> -/* We anticipate the possiblity of supporting additional types of extents */
> +/* We anticipate the possibility of supporting additional types of extents */
>  enum famfs_extent_type {
>  	SIMPLE_DAX_EXTENT,
>  	INTERLEAVED_EXTENT,
> @@ -63,7 +143,7 @@ struct famfs_file_meta {
>  /*
>   * dax_devlist
>   *
> - * This is the in-memory daxdev metadata that is populated by
> + * This is the in-memory daxdev metadata that is populated by parsing
>   * the responses to GET_FMAP messages
>   */
>  struct famfs_daxdev {

-- 
~Randy


