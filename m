Return-Path: <linux-fsdevel+bounces-71454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB3CC19DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E17C3077CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93232470E;
	Tue, 16 Dec 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDAbpBeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1021A256E;
	Tue, 16 Dec 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874416; cv=none; b=kls3iVQDPIVH2Nfi4WL8QV6OqwWYmLGDsDJSNMrFKhsDQpAFT6AtTB4LLqmDSEO7ol1E9UxG1M7W4DsMIo9UFENERGKlgF/O8Fo/oVRgallEK8WUinOvtpx2K5Rd37zJUCalSAJ15a98G/uonfFdoFAd2u2UX7syzmTC0fCVFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874416; c=relaxed/simple;
	bh=piyXxBWaUZ3zgvjOKFpGezu9pZEl2Y7URGkuCxQZPGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apoDPCF6mCmHepxOdgK16u3/XovEoE4rTiNzOeuEgfQCREqXkSTOHfo7QV8adruCgFfwGlMmxVyDWgJPUuX7j8WYjvRf3za/jkaBDzFMGYY58vWdYQBVAYwH8en28gF6ipZinyTImWvOjmGACGnt1JawLUZrGHKymJNAEp0Ziew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDAbpBeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29297C113D0;
	Tue, 16 Dec 2025 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765874416;
	bh=piyXxBWaUZ3zgvjOKFpGezu9pZEl2Y7URGkuCxQZPGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDAbpBeHtpWCCFwMo8kB4vMukedE5YPTjaIvdcIweGiyCvfh/0k7yraVd7Dfr5HzD
	 BWAHGkJVQmIjkhTq6IEGgjRFt001uV7ct/LEJdOFB1yy2C0OogLxDhhfjE4h5WWaLc
	 AQc06qZZ0t1SB+QkaUa8PnCMJC8GiIV3asle2/sck+N9lWuUllTcf9LNkoMKRu1hM6
	 kaacscxGh6Tyc4MbkxzciNQB5fIT1qvGGRy2ZkBa/djH18E0ZZ1SEToxlwjGc9v2rv
	 oJnwWGYVZjjgNMiE5qEfEn49g7PbwqeXeSia/Vy5nA02Jh5lm7cabhbFzcHulERuGv
	 DsoqZ1CyzSItA==
Date: Tue, 16 Dec 2025 00:40:15 -0800
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Add missing kernel-doc for proc_dointvec_conv
Message-ID: <202512160038.2C7DAA20@keescook>
References: <20251215-jag-sysctl-doc-v1-1-2099a2dcd894@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-jag-sysctl-doc-v1-1-2099a2dcd894@kernel.org>

On Mon, Dec 15, 2025 at 04:52:58PM +0100, Joel Granados wrote:
> Add kernel-doc documentation for the proc_dointvec_conv function to
> describe its parameters and return value.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  kernel/sysctl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 2cd767b9680eb696efeae06f436548777b1b6844..b589f50d62854985c4c063232c95bd7590434738 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -862,6 +862,22 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
>  	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos, 1l, 1l);
>  }
>  
> +/**
> + * proc_dointvec_conv - read a vector of ints with a custom converter
> + * @table: the sysctl table
> + * @dir: %TRUE if this is a write to the sysctl file
> + * @buffer: the user buffer
> + * @lenp: the size of the user buffer
> + * @ppos: file position
> + * @conv: Custom converter call back
> + *
> + * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
> + * values from/to the user buffer, treated as an ASCII string. Negative
> + * strings are not allowed.
> + *
> + * Returns 0 on success

I think kern-doc expects "Returns:" rather than "Returns". But
otherwise, yes! :)

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> + */
> +
>  int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
>  		       size_t *lenp, loff_t *ppos,
>  		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251215-jag-sysctl-doc-d3cb5bd14699
> 
> Best regards,
> -- 
> Joel Granados <joel.granados@kernel.org>
> 
> 

-- 
Kees Cook

