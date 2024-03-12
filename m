Return-Path: <linux-fsdevel+bounces-14176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497C878CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 03:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1853B1F21BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 02:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF96FBF;
	Tue, 12 Mar 2024 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfUtsh9v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA18524F;
	Tue, 12 Mar 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209951; cv=none; b=Wq23RK69qwoAgwJm0ZhC7Fx6gCSmqHYAkt2X0MTwfMgGnOMrJ+HhDT8XXhlSlrjGnRDXx6woA2NgB4mGRWzHIJzIyCV/eHBaW1kTEw4ZvLtXjB0pFcsa0y3ZQAeaakiJ+bYVl6mIuZ843WFjgx+qLcNoJSULGqRZARtj9gxpapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209951; c=relaxed/simple;
	bh=x6OxTmBOpYLiXpS7yiSGSSB+jvhKldEjiX4FsMjhzgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxymCyYF41nGAf9bAGDdwa2kifwSK+fGSjfAioIRJnoQA/zKkk8f1bP6+iVci/DVcSwS0vpt2YCrEDm0AmgJ5ltJHKqaYXlGwWGV2pr6+PhGBeR+Ke7V88pSVqMrkB1X6QexBpSta8aRt/YYJPHP5l63dJiniE2Ke+ddUM5IO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfUtsh9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E520C43390;
	Tue, 12 Mar 2024 02:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710209950;
	bh=x6OxTmBOpYLiXpS7yiSGSSB+jvhKldEjiX4FsMjhzgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfUtsh9vMMRxvLRW0Tq8pe1a8xSP/HmA0oGRRzXZ82n+DkT8i/ZBNXF8nxSyN0xOn
	 s2axlqjkf8VG57U8TcdkURfnCudPPsOHndH+wGOb5unn7z9gzukHuFNwgBHtCBjlCI
	 c4Ty1Qb9LmNtdkzYh2XUt3xlBGkVS2xDUEaH8eM8uYSRzrTmw7I87yRcGJ3+6+7Fuw
	 ty8dN/ys5MZ0vj1AUeZ2YcCygMHXBgcjQ7Xt4+6DPDW+s9XgR25goedSvQTFCzt2mW
	 rVOsz/lrUazIiIJX49t4GU7Em/2FNIH3YRNYp4wqhng/DcgrHvgxbuD4xBAYMBgjqb
	 GBZSwOCUMPWOA==
Date: Mon, 11 Mar 2024 19:19:08 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
Message-ID: <20240312021908.GC1182@sol.localdomain>
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311203221.2118219-1-kent.overstreet@linux.dev>

On Mon, Mar 11, 2024 at 04:31:36PM -0400, Kent Overstreet wrote:
> Document the new statxt.stx_subvol field.
> 
> This would be clearer if we had a proper API for walking subvolumes that
> we could refer to, but that's still coming.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20240308022914.196982-1-kent.overstreet@linux.dev/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Alejandro Colomar <alx@kernel.org>
> Cc: linux-man@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  man2/statx.2 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index 0dcf7e20bb1f..480e69b46a89 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -68,6 +68,7 @@ struct statx {
>      /* Direct I/O alignment restrictions */
>      __u32 stx_dio_mem_align;
>      __u32 stx_dio_offset_align;
> +    __u64 stx_subvol;      /* Subvolume identifier */
>  };
>  .EE
>  .in
> @@ -255,6 +256,8 @@ STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
>  STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>  	(since Linux 6.1; support varies by filesystem)
> +STATX_SUBVOL	Wants stx_subvol
> +	(since Linux 6.9; support varies by filesystem)

The other ones say "Want", not "Wants".

> +.TP
> +.I stx_subvolume

It's stx_subvol, not stx_subvolume.

> +Subvolume number of the current file.
> +
> +Subvolumes are fancy directories, i.e. they form a tree structure that may be walked recursively.

How about documenting which filesystems support it?

- Eric

