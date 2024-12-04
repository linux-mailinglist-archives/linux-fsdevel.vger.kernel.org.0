Return-Path: <linux-fsdevel+bounces-36392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF759E32CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 05:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 600DBB2920E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 04:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286117B425;
	Wed,  4 Dec 2024 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2VLKam+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B2502BE;
	Wed,  4 Dec 2024 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288128; cv=none; b=O3TBQ6v0XKMnrfVm/jwmVDjuzE+6sbrBvZPLeLNvhW0iDOsJJa8flX2RDBdPqCTQnFdsllLUEtaQsnAcgESkDMRmSEJ3C2Kh/+VJFh0QOuCRSMsAj4Mg6POMZRJHo4RfzD5x0aviLlifIp2z5hwjHb9o0cH1vpa7rjJUCqSlVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288128; c=relaxed/simple;
	bh=Bn15N2hYAqeqgfe7AzZ5EtXmUTlRwH3xE3+5AaMRA9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKHybLCYS2zEdGT1xwJLeQT36nihHipjBBcw9NvD1oUSDojFTLiuYUD4zedeE3ZTb/lMabFNYxosWzFtttd7TdwAM3cpR05c6VleHNvfaT7JCoYWQ/S5U5+YIpfuuJx040sdYcoC1VGp4g/i94EoeiaVA+pK8oT1WHTcISQf5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2VLKam+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A75C4CED1;
	Wed,  4 Dec 2024 04:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733288126;
	bh=Bn15N2hYAqeqgfe7AzZ5EtXmUTlRwH3xE3+5AaMRA9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2VLKam+vYPRPcYcOegZS8/mk2dK+Bh+7YAR1aciqAT2OG22p8FX7gzuWVZPzThbG
	 gag1S/gN9joIeNkZKkX/mPNQFVVcSdHoxm9DZ0LihwpOm1UoR6IqfHjWEN9gv8wF0r
	 Xm+JOsWOi89Ogl7trhOv/Jc6y9uR2C0R/n2/KhsuvHQ/kVRR+JWJ745TaOmE0mx97n
	 xDYSxWZfzkqDfCPV1Ph2PlSfeQcXTlrFd5qc5OQTNR2lzGhzDsns8ZEKBxAIOko7ur
	 hfDNzXqllQBp+1RSgJNscWLdO9qixn6U7yLa146AwUHXI8XsFZ0EEqdeDMFdklLUVb
	 OADMXo3JbhgsQ==
Date: Tue, 3 Dec 2024 20:55:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Message-ID: <20241204045525.GB7864@frogsfrogsfrogs>
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203145359.2691972-1-john.g.garry@oracle.com>

On Tue, Dec 03, 2024 at 02:53:59PM +0000, John Garry wrote:
> Linux v6.13 will include atomic write support for xfs and ext4, so update
> STATX_WRITE_ATOMIC commentary to mention that.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/man/man2/statx.2 b/man/man2/statx.2
> index c5b5a28ec..2d33998c5 100644
> --- a/man/man2/statx.2
> +++ b/man/man2/statx.2
> @@ -482,6 +482,15 @@ The minimum and maximum sizes (in bytes) supported for direct I/O
>  .RB ( O_DIRECT )
>  on the file to be written with torn-write protection.
>  These values are each guaranteed to be a power-of-2.
> +.IP
> +.B STATX_WRITE_ATOMIC
> +.RI ( stx_atomic_write_unit_min,
> +.RI stx_atomic_write_unit_max,
> +and
> +.IR stx_atomic_write_segments_max )
> +is supported on block devices since Linux 6.11.
> +The support on regular files varies by filesystem;
> +it is supported by xfs and ext4 since Linux 6.13.

woot!

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  .TP
>  .I stx_atomic_write_segments_max
>  The maximum number of elements in an array of vectors
> -- 
> 2.31.1
> 

