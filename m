Return-Path: <linux-fsdevel+bounces-26381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E935958C26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC8F2853F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E31AE878;
	Tue, 20 Aug 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9XUTqKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405E190671;
	Tue, 20 Aug 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171040; cv=none; b=SKpsOrC4WVbkI9SoJlsm1e8S6l6Z/RrEnA3K2TTSpCJiuEuyKZw6mVsUUiPLrFQFkTAHMi+rI/Mu+dLcFarmSHsrKwS55+zzos/rYf6koz0hQD34xIe45zBQ6aL/iyDZoWtz9suYVXkVtr4741exXqSbuaNOz4YP5QfvQ+QjJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171040; c=relaxed/simple;
	bh=nYOUa7CO3WCFF78SuWC9irp0kY+U+/n/V6358gWQpxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZEMPMoYW8PCScYqvFRBBmrs22cX0+ld0aMf1wPVfmqCIoy94XCBDHVrkWJVW5qvCDPAs5W+/TfKQ53Qu54X5fgQQOor+JReCkT34Ameo+6wEpDlWf46tp66Ts0CI5DeYUhKQPmO4I/NrXSwGv3SpEu7W+yxYqAm4kFWvLhV+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9XUTqKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F52C4AF0F;
	Tue, 20 Aug 2024 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724171040;
	bh=nYOUa7CO3WCFF78SuWC9irp0kY+U+/n/V6358gWQpxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9XUTqKkTl0LWa3v9R0uLMuZ2nXn0ymESVQMNIqZ2k36LWTFdKpAoWfRhrJsYTW6P
	 UaPbsZckrq1IDY4krs5hRu6TDObkMOaoXy5gVny+iX6+/WlEX8DA+KsVHDeh65yC8L
	 7t5E/4DWfLxMpAf7dekK7UYKekKNPu5vBaw3jU8MNS4yAeatxjQOHUvsEKiSrPozNX
	 iZlXumKBH3YRBy0ClIH1vXm/lohHOAW+W755zHxRWmmXZ+UB7QnutThsow8trHrfgy
	 B7AUbFRgmbSGLG4OLz0NqoBq7aRpJYwdX+2oAl3sDtRU3w5k2u1qFNaTmCXlxYIOW+
	 KPHrMNelZW9og==
Date: Tue, 20 Aug 2024 09:23:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240820162359.GI6043@frogsfrogsfrogs>
References: <20240819225626.2000752-2-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819225626.2000752-2-gpiccoli@igalia.com>

On Mon, Aug 19, 2024 at 07:56:27PM -0300, Guilherme G. Piccoli wrote:
> Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> devices") added a Kconfig option along with a kernel command-line tuning to
> control writes to mounted block devices, as a means to deal with fuzzers like
> Syzkaller, that provokes kernel crashes by directly writing on block devices
> bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> 
> The patch just missed adding such kernel command-line option to the kernel
> documentation, so let's fix that.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..709d1ee342db 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -517,6 +517,16 @@
>  			Format: <io>,<irq>,<mode>
>  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
>  
> +	bdev_allow_write_mounted=
> +			Format: <bool>
> +			Control the ability of directly writing to mounted block
> +			devices' page cache, i.e., allow / disallow writes that
> +			bypasses the FS. This was implemented as a means to
> +			prevent fuzzers to crash the kernel by breaking the
> +			filesystem without its awareness, through direct block
> +			device writes. Default is Y and can be changed through
> +			the Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.

Can we mention that this also solves the problem of naïve storage
management tools (aka the ones that don't use O_EXCL) writing over a
mounted filesystem and trashing it?

--D

> +
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.
>  
> -- 
> 2.45.2
> 
> 

