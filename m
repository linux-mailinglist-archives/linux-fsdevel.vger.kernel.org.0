Return-Path: <linux-fsdevel+bounces-45913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9EA7EC32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 21:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25E87A2A68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AABD265CD6;
	Mon,  7 Apr 2025 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrQSd1y4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803B2571D2;
	Mon,  7 Apr 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051732; cv=none; b=UDhpiGPeatX/16kKlWPDmm1XD3gOS9BQdTSDruVDMggceHZG/+eB6PhS/ma79b4Fmqe0yAwTsnaF36cu21MNCiUSkx63RDsNFUFtLkFRDdt/zZJl8TQMaRDX17+485LkW2O0DdP+xRs5LObXLvuOVdsM1qs4NBbxFZPgjaKTneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051732; c=relaxed/simple;
	bh=jtIwDlss0DPTJBXwiMczuUfLJ5vhGoUdZnfSp7ZHYws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcyfb/V75cGhi+mUN4VpQrGJ/n1mkRTrXK7d/e6xYggMC68tMTwFz1aksopqQrFg2sYCA5e5VfK2sn+AhgdIC+kr9htPD7uMN0Aq+MCcOwME7VCY7GRYqINAlPcyGBhnytXo56hwJziU2JouzwZFaxWmlEeYxb88DMTYdiom2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrQSd1y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273C9C4CEDD;
	Mon,  7 Apr 2025 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051732;
	bh=jtIwDlss0DPTJBXwiMczuUfLJ5vhGoUdZnfSp7ZHYws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrQSd1y4pCP1ak0sAjGQ58K99qeM0zLwKdKFlV5GQh8YiSnZFo6kAACNIDZ/yGbku
	 gwlA/dK0CGRoJxFD5B98yc7cDxXCPFogdmHQHnA8QI5LnE9Ib36FFOI+Wt5MzuyYPF
	 QgdwGcGRaFpFguop24NCs9vd0Mw4cODsUwV7wMUnfee9oBNDhK4lL3ZkYNtIct4X9u
	 Rz/W1/vtpEkMzBzu+auPPk/vhm4kmZ+bm073x4RRtNsUiD0rlCOyd9N3vyj8GWRkOq
	 roiB7miZXqURjFH8NpDyXmTT27gBstXZR5jb12J9rtqOT6TM13pMX8owkOxcXwWDWp
	 B4WLwC+Th5jig==
Date: Mon, 7 Apr 2025 11:48:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: trace: Add missing flags to
 [IOMAP_|IOMAP_F_]FLAGS_STRINGS
Message-ID: <20250407184851.GF6266@frogsfrogsfrogs>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
 <bf67e3e6af1cdc3c6cba83e204f440db1cbfda24.1743691371.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf67e3e6af1cdc3c6cba83e204f440db1cbfda24.1743691371.git.ritesh.list@gmail.com>

On Thu, Apr 03, 2025 at 11:52:28PM +0530, Ritesh Harjani (IBM) wrote:
> This adds missing iomap flags to IOMAP_FLAGS_STRINGS &
> IOMAP_F_FLAGS_STRINGS for tracing. While we are at it, let's also print
> values of iomap->type & iomap->flags.
> 
> e.g. trace for ATOMIC_BIO flag set
> xfs_io-1203    [000] .....   183.001559: iomap_iter_dstmap: dev 8:32 ino 0xc bdev 8:32 addr 0x84200000 offset 0x0 length 0x10000 type MAPPED (0x2) flags DIRTY|ATOMIC_BIO (0x102)
> 
> e.g. trace with DONTCACHE flag set
> xfs_io-1110    [007] .....   238.780532: iomap_iter: dev 8:16 ino 0x83 pos 0x1000 length 0x1000 status 0 flags WRITE|DONTCACHE (0x401) ops xfs_buffered_write_iomap_ops caller iomap_file_buffered_write+0xab/0x0
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Seems reasonable to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/trace.h | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 9eab2c8ac3c5..455cc6f90be0 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -99,7 +99,11 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
>  	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> -	{ IOMAP_ATOMIC,		"ATOMIC" }
> +	{ IOMAP_OVERWRITE_ONLY,	"OVERWRITE_ONLY" }, \
> +	{ IOMAP_UNSHARE,	"UNSHARE" }, \
> +	{ IOMAP_DAX,		"DAX" }, \
> +	{ IOMAP_ATOMIC,		"ATOMIC" }, \
> +	{ IOMAP_DONTCACHE,	"DONTCACHE" }
> 
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> @@ -107,7 +111,14 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_F_SHARED,	"SHARED" }, \
>  	{ IOMAP_F_MERGED,	"MERGED" }, \
>  	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
> -	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
> +	{ IOMAP_F_XATTR,	"XATTR" }, \
> +	{ IOMAP_F_BOUNDARY,	"BOUNDARY" }, \
> +	{ IOMAP_F_ANON_WRITE,	"ANON_WRITE" }, \
> +	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
> +	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
> +	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> +	{ IOMAP_F_STALE,	"STALE" }
> +
> 
>  #define IOMAP_DIO_STRINGS \
>  	{IOMAP_DIO_FORCE_WAIT,	"DIO_FORCE_WAIT" }, \
> @@ -138,7 +149,7 @@ DECLARE_EVENT_CLASS(iomap_class,
>  		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
>  	),
>  	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr 0x%llx offset 0x%llx "
> -		  "length 0x%llx type %s flags %s",
> +		  "length 0x%llx type %s (0x%x) flags %s (0x%x)",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
>  		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
> @@ -146,7 +157,9 @@ DECLARE_EVENT_CLASS(iomap_class,
>  		  __entry->offset,
>  		  __entry->length,
>  		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
> -		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
> +		  __entry->type,
> +		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
> +		  __entry->flags)
>  )
> 
>  #define DEFINE_IOMAP_EVENT(name)		\
> @@ -185,7 +198,7 @@ TRACE_EVENT(iomap_writepage_map,
>  		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
>  	),
>  	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
> -		  "addr 0x%llx offset 0x%llx length 0x%llx type %s flags %s",
> +		  "addr 0x%llx offset 0x%llx length 0x%llx type %s (0x%x) flags %s (0x%x)",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
>  		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
> @@ -195,7 +208,9 @@ TRACE_EVENT(iomap_writepage_map,
>  		  __entry->offset,
>  		  __entry->length,
>  		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
> -		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
> +		  __entry->type,
> +		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
> +		  __entry->flags)
>  );
> 
>  TRACE_EVENT(iomap_iter,
> --
> 2.48.1
> 
> 

