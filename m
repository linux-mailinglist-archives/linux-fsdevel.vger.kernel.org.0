Return-Path: <linux-fsdevel+bounces-45902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D1A7E6AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 18:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDF7443C54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94027208964;
	Mon,  7 Apr 2025 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyljSo/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E142F28;
	Mon,  7 Apr 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043130; cv=none; b=qIi1OooIdIv0A9BNfOU49k0Dv5BcPqKAzfKFUnBb2gcfL6K3OvxYilc+etv9EEvfYXw2cerEVwo5tA7VZchtsSG+c1EomsJs3JAiiNYGTVWRrxvLZ+PfcTufcZdOhHJ59PEGXhjHkUleNSkh0c5XLcfT1Q6dzaxJOi5Q6bJ0fZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043130; c=relaxed/simple;
	bh=ZtMSDeHw3pRSjougueEfpRlN203H88cKeVnztHX2nE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec4nxpIe0MA8qNxwIHDcMVjA21B64lntRszJMoR6UUjnX7Nk5QhC4cuwaWZ03DR4sbwmCKm8Kmha3D/r+6aN9Emb2DLahNFbz6JgXQv6F1E9jXOQJeywutUVEh1PFXrBVY9q3HXSAd6Q0se3UIsE0Tf6Xnr9PA+hUoibza5oNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyljSo/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B3C4CEDD;
	Mon,  7 Apr 2025 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744043128;
	bh=ZtMSDeHw3pRSjougueEfpRlN203H88cKeVnztHX2nE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyljSo/znnjAeeESuziMpD1iZWUIld9a8VW2+IvgnLvKsj9nlzaUhn7LeQn9gAWUR
	 I82Xr0HA/catVAXxyDKAYbmZ4JLVyAmPCPleyOgbTsc2cW4bBS29YK25HcJe/qfvXC
	 rUqUUz+ELLOYbPvjtOFuwTFzSXT8V2I+076SbP0VngpnAuPNs6o7FFRI7GIvWTRbJg
	 ibBEBhTRZL+Bl/MHf4ZkSTadBU7yMEsa3eX3zmGnNDkt1r1/EDpdeWDCd66u7onO4x
	 HkepfmzhHurXGMM5Ox+qT1iuGkKr0Fd8JRfysAcAuBsZUMKDpRwGAWOP773LR6WC1s
	 0vLSckHPB9nGw==
Date: Mon, 7 Apr 2025 09:25:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
Message-ID: <20250407162527.GC6266@frogsfrogsfrogs>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>

On Thu, Apr 03, 2025 at 11:52:27PM +0530, Ritesh Harjani (IBM) wrote:
> Let's document the use of these flags in iomap design doc where other
> flags are defined too -
> 
> - IOMAP_F_BOUNDARY was added by XFS to prevent merging of ioends
>   across RTG boundaries.
> - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
>   for filesystems to inform the iomap that it needs HW-offload based
>   mechanism for torn-write protection
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  Documentation/filesystems/iomap/design.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index e29651a42eec..b916e85bc930 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -243,6 +243,11 @@ The fields are as follows:
>       regular file data.
>       This is only useful for FIEMAP.
>  
> +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
> +     for this iomap must never be merged with the mapping before it.
> +     Currently XFS uses this to prevent merging of ioends across RTG
> +     (realtime group) boundaries.

Hrm, ok.  Based on hch's comment about not mentioning specific fs
behavior, I think I'll suggest something more like:

IOMAP_F_BOUNDARY: This I/O and its completion must not be merged with
any other I/O or completion.  Filesystems must use this when submitting
I/O to devices that cannot handle I/O crossing certain LBAs (e.g. ZNS
devices).  This flag applies only to buffered I/O writeback; all other
functions ignore it.

>     * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>       be set by the filesystem for its own purposes.
>  
> @@ -250,6 +255,11 @@ The fields are as follows:
>       block assigned to it yet and the file system will do that in the bio
>       submission handler, splitting the I/O as needed.
>  
> +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
> +     with the ``REQ_ATOMIC`` flag set in the bio. Filesystems need to set
> +     this flag to inform iomap that the write I/O operation requires
> +     torn-write protection based on HW-offload mechanism.

They must also ensure that mapping updates upon the completion of the
I/O must be performed in a single metadata update.

--D

> +
>     These flags can be set by iomap itself during file operations.
>     The filesystem should supply an ``->iomap_end`` function if it needs
>     to observe these flags:
> -- 
> 2.48.1
> 
> 

