Return-Path: <linux-fsdevel+bounces-23881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209CB934403
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D004F28237B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C7187355;
	Wed, 17 Jul 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMVe9+Bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA44688;
	Wed, 17 Jul 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252175; cv=none; b=tiJhDBdBr0MSx2kkqBZ/p4uUV6EkR71YjKRZXeQYLkKN412U5tKKds35N7xKazIk7/2hZUpuSBL214h8/Oul/oRiTpGfCLtC7tdLBft2fvpdwwXEQpzzmpveJZ1jkIIbzeaA6EHZ3wjRUqgI9DqwEQRVdTqIUIFfPhomX4Pf57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252175; c=relaxed/simple;
	bh=zsa3P/4RYuVLUdXQBOHKXdYjAy89M8qQ2lncoG4hqVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F99IPXbU9fF6mDL2hjCSp/dKNpBz7t1eqzNhssa2P65DOY1t3bXx/s7wAjCWh/yjfpPicwsgD6aoba0Sao+sTKoxUsB1iIJnBlAflPio4cSki6yRG9T1OJv3/72yTSkAN/v3vnx8JmnOJHvyffAUBQemLIxX5+5+jQCyaDg4nyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMVe9+Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C319EC2BD10;
	Wed, 17 Jul 2024 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721252174;
	bh=zsa3P/4RYuVLUdXQBOHKXdYjAy89M8qQ2lncoG4hqVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMVe9+Bw56Ue+cnv2EATX38Yq0Td2udnMY9BRVVuvpUtDkAYebcIgT4T9fr6vMr7+
	 xg+6nuxXSSlnPKxfeTfmOFLy8Fi/4e+ij8u0uCGEU61EF5/3g9bCAb6ZaNcb73TAvU
	 bQ96zLG6pb7JXopUTxSHcbl66BL2H3s6z4ZgkQL+kf5nJWaVuK1oNDrj0yWenwBidD
	 SDn94OvH+ltLUhJu3p40MQB112T/IPhgCV+oqpGpjkaRLatTP+SJPgjnKfDj/A/4K6
	 yG2VW1b6lTGQgXRtOIl5m5Bux0xuTZH7KglWB/BS1f4Txp1dbkBlGwr+Vm1qKAUWTi
	 pQL/vrdLF4WsA==
Date: Wed, 17 Jul 2024 14:36:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	dchinner@redhat.com, martin.petersen@oracle.com,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v4 1/3] statx.2: Document STATX_WRITE_ATOMIC
Message-ID: <20240717213614.GH1998502@frogsfrogsfrogs>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
 <20240717093619.3148729-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717093619.3148729-2-john.g.garry@oracle.com>

On Wed, Jul 17, 2024 at 09:36:17AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the text to the statx man page.
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man/man2/statx.2 | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index 3d47319c6..a7cdc0097 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -70,6 +70,11 @@ struct statx {
>      __u32 stx_dio_offset_align;
>  \&
>      __u64 stx_subvol;      /* Subvolume identifier */
> +\&
> +    /* Direct I/O atomic write limits */
> +    __u32 stx_atomic_write_unit_min;
> +    __u32 stx_atomic_write_unit_max;
> +    __u32 stx_atomic_write_segments_max;
>  };
>  .EE
>  .in
> @@ -259,6 +264,9 @@ STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>  STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>  STATX_SUBVOL	Want stx_subvol
>  	(since Linux 6.10; support varies by filesystem)
> +STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit_max,
> +	and stx_atomic_write_segments_max.
> +	(since Linux 6.11; support varies by filesystem)

Congratulations ^^^^^^^^^ on getting this merged!

>  .TE
>  .in
>  .P
> @@ -463,6 +471,22 @@ Subvolumes are fancy directories,
>  i.e. they form a tree structure that may be walked recursively.
>  Support varies by filesystem;
>  it is supported by bcachefs and btrfs since Linux 6.10.
> +.TP
> +.I stx_atomic_write_unit_min
> +.TQ
> +.I stx_atomic_write_unit_max
> +The minimum and maximum sizes (in bytes) supported for direct I/O
> +.RB ( O_DIRECT )
> +on the file to be written with torn-write protection.

I'm tempted to be nitpicky and say "...supported for direct I/O writes
to the the file to have torn-write protection" but... eh.  It's hot out
and I'm not that fussed if you want to ignore that.

Either way,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> +These values are each guaranteed to be a power-of-2.
> +.TP
> +.I stx_atomic_write_segments_max
> +The maximum number of elements in an array of vectors for a write with
> +torn-write protection enabled.
> +See
> +.BR RWF_ATOMIC
> +flag for
> +.BR pwritev2 (2).
>  .P
>  For further information on the above fields, see
>  .BR inode (7).
> @@ -516,6 +540,9 @@ It cannot be written to, and all reads from it will be verified
>  against a cryptographic hash that covers the
>  entire file (e.g., via a Merkle tree).
>  .TP
> +.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.11)"
> +The file supports torn-write protection.
> +.TP
>  .BR STATX_ATTR_DAX " (since Linux 5.8)"
>  The file is in the DAX (cpu direct access) state.
>  DAX state attempts to
> -- 
> 2.31.1
> 

