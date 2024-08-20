Return-Path: <linux-fsdevel+bounces-26380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291B958C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3B1F2371A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E2A19D8BB;
	Tue, 20 Aug 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtBRqQo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460C208D7;
	Tue, 20 Aug 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170539; cv=none; b=fv/MgplxziuqrUCmzL4PIvCUTrf3U66EA7av8Mk2TwPzIdQYeS8o6l2CexIoW/2spwCPAeF8wCEQXnBpRxdkWcmg1Npa1uasC+jggTQlqmiRfR7tRhaW6PEAj7zvRRjZMjoE7ymfpYTABPyru2cVQt8HEOGZM8fdLZtotKKcOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170539; c=relaxed/simple;
	bh=9X9zE81M2UtM+HT2hiECWQgG2TJ/K92mEOc886Ex72Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbnxYS2LpTRE9cMWPzUedDbwE49de7L7Y5T/BOTX0WWEY2zIDGrVXNqKTtJdptIy3kX6mA9e6Cqd5o33wXw3pXjGChCq0fqfXC06S+njLt1xpkSTAQ6ckGeBSO0ysrbhmbtr9KJSN8KSYlOExDDHfrrSWe1RaC5ytLNzjjqjNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtBRqQo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C1BC4AF16;
	Tue, 20 Aug 2024 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170538;
	bh=9X9zE81M2UtM+HT2hiECWQgG2TJ/K92mEOc886Ex72Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtBRqQo/ZC8HF/Y6sJF35K11EqskwB1AzpvttVKPgjXjqTXy0pQjVKLwWLbYyV3l/
	 GfwPMcvMPkJL6UcLp9p6OQREpXwmV7kVk/GCw4U3nGzdkWcfPj/LokYTcA/V+vAmGy
	 TM57kGQmSePD3Xn0BpgKnq+b77EkCAdNNF/2A2P3poqsSB//223YsAvHJfOzAchI/4
	 Wr2Y6Dq+XldKSWTNkoXca81p9G0k4yvzRtbJUXDoJ6zHOuUUQxgVMSgO2J/WV9xfVu
	 WkhH97LRrOsMLSNyRv4DO/FpfP3+r5+p5IJctiK0QYP6Df8pYsO+xUk6BfsuKM76Ln
	 Rw5sE7q8HRFWA==
Date: Tue, 20 Aug 2024 09:15:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] Documentation: iomap: fix a typo
Message-ID: <20240820161537.GS865349@frogsfrogsfrogs>
References: <20240820161329.1293718-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820161329.1293718-1-kernel@pankajraghav.com>

On Tue, Aug 20, 2024 at 06:13:29PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Change voidw -> void.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Heh, whoopsw.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/iomap/design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index 37594e1c5914..7261b1b2c379 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -165,7 +165,7 @@ structure below:
>       u16                 flags;
>       struct block_device *bdev;
>       struct dax_device   *dax_dev;
> -     voidw               *inline_data;
> +     void                *inline_data;
>       void                *private;
>       const struct iomap_folio_ops *folio_ops;
>       u64                 validity_cookie;
> -- 
> 2.44.1
> 
> 

