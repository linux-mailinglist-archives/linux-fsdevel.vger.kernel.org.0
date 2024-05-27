Return-Path: <linux-fsdevel+bounces-20283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F08D100E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 00:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D02831D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDAB167D98;
	Mon, 27 May 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="d7GYKjCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC316727F;
	Mon, 27 May 2024 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847778; cv=none; b=ShalfeoS3dj6rGrA31WSzkrXio8B6EjC1j2rKh1hqbzK0eDsowe+R8RAF1x8WzWRytkraZ7+iyTuOVJC178zo0j00IypS6lWpfQ2QS1j9mfa5GJBkg1rsadO7KhSbQJTyS9SIjdSDQ1FsFutKtq3d0BOwzVDjwzJKZeOrnRlTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847778; c=relaxed/simple;
	bh=bWoyIz8f8wLuHH16zUiaZPhrCvft6pF8t2F8c7UdBXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjFlilbKq6BFV8RsDAf05KsFXr3fOsZSKzMymm2ipje/mrvIiC1TJqUrgCt3AzyWdRaA8RQLltrAyZiD0Dcwdx9bw0GjsTaVMHX/1wObvfA5xlvsTEuJdspzoxd9AT/s+Qp0vePwzCWKLr5+Ub9fdxCVuC3dlDmdizDKo6v3S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=d7GYKjCm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vp8vH030Gz9sSx;
	Tue, 28 May 2024 00:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716847771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xofQJrMqQk/+jqsSg/d7hjeU9inOMDriTC1PeyMQG1c=;
	b=d7GYKjCmdcKC3w87rQ2OBjU46lVmFu+qDHmCRuwcxFNx99FLKTE0TzY7RF8KBaU5NyPfUt
	hefNRq7vvZAlp/ecd2E8FnP7knvZpTtdv2f9fMYvGvgROdDTQ6tQUte5EamAs4TNNA3d1g
	pfm1uCH4+aMyOxS3MF0OravLFnL4FxjB48Ne9D0KhKZqnUCZ7N+uZYWaEB9WrwIDvqy7YY
	g+T86ovA5qY25WmbRF1r/SbWMjXrV2LAJOk5MEj32ge5pqCnrr5if4tcVTBwFR5zXUawVq
	kHUUR0HgihJiWD0KDSAOpac2L3etWpOwKQUreW9XzuZ9fKGUrjwIHOLO6QvA2Q==
Date: Mon, 27 May 2024 22:09:26 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <20240527220926.3zh2rv43w7763d2y@quentin>
References: <20240527210125.1905586-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527210125.1905586-1-willy@infradead.org>
X-Rspamd-Queue-Id: 4Vp8vH030Gz9sSx

On Mon, May 27, 2024 at 10:01:23PM +0100, Matthew Wilcox (Oracle) wrote:
> We need filesystems to be able to communicate acceptable folio sizes
> to the pagecache for a variety of uses (e.g. large block sizes).
> Support a range of folio sizes between order-0 and order-31.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> For this version, I fixed the TODO that the maximum folio size was not
> being honoured.  I made some other changes too like adding const, moving
> the location of the constants, checking CONFIG_TRANSPARENT_HUGEPAGE, and
> dropping some of the functions which aren't needed until later patches.
> (They can be added in the commits that need them).  Also rebased against
> current Linus tree, so MAX_PAGECACHE_ORDER no longer needs to be moved).

Thanks for this! So I am currently running my xfstests on the new series
I am planning to send in a day or two based on next-20240523.

I assume this patch is intended to be folded in to the next LBS series?

> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1ed9274a0deb..c6aaceed0de6 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,13 +204,18 @@ enum mapping_flags {
>  	AS_EXITING	= 4, 	/* final truncate in progress */
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,
> -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>  				   folio contents */
> -	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
> +	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
> +	AS_FOLIO_ORDER_MIN = 16,
> +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
>  };
>  
> +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000

As you changed the mapping flag offset, these masks also needs to be
changed accordingly.

I moved(pun intended) the AS_UNMOVABLE and kept the
AS_FOLIO_ORDER_(MIN|MAX) value the same.

	AS_FOLIO_ORDER_MIN = 8,
	AS_FOLIO_ORDER_MAX = 13, /* Bit 8-17 are used for FOLIO_ORDER */
	AS_UNMOVABLE = 18,	 /* The mapping cannot be moved, ever */
	AS_INACCESSIBLE,	/* Do not attempt direct R/W access to the mapping */

> +#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
> +
>  
--
Pankaj

