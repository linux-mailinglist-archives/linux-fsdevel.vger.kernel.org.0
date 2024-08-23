Return-Path: <linux-fsdevel+bounces-26981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779E95D565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C5CB21BF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CC191F7E;
	Fri, 23 Aug 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEZcaNwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5618DF81;
	Fri, 23 Aug 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438546; cv=none; b=nirTEEjbTy/T4waIFFdRcRrLejg7Unq0e75DlR76GF1zidAgYzNXBSE9JK0Oky3shtfq2yLFZSFBDUIfEcKcmAvytL5ricBoi9bSHs2XHs4CJPl4FXGKtltnlw5ta1cCG+AptjqAQYVzk8RDeGKqRrSCLJPuf5yl1mDrgvbqm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438546; c=relaxed/simple;
	bh=vzDS1xGJWi/pkNolZLO+6HNfn4L3U7xg210csJvwYds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuORKF9NdOLkJLCiHL6wZGKmPPqPoTawTj3T+nab7If3vluhzb5s1YbKCELw6SxgvpsoKiSJqQePjA0SGQAJ1ne7I7lsYy9r4ti2wNa2MOBNO9zNYbCqV3WEgC4D8SmjBiVxo2Oq9ogOjkjSTUEdJJQJ6Kl9frwLW7d03ot+iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEZcaNwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF7C32786;
	Fri, 23 Aug 2024 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724438545;
	bh=vzDS1xGJWi/pkNolZLO+6HNfn4L3U7xg210csJvwYds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEZcaNwWhZR8SbZY5Ob+ylg+PP4VV7BgaZKa/Tq75Q0g5T7UafB3wupXf4TEiU2/U
	 Lv1SwicfYKZ630JfKWDQFz8gq52EWH42m7c1fgYUDd6a2t47BNJGb+otIn5B/F8b3v
	 ps+l8eGSkPI4xpEVPKrdTXT4mu9qPRcs4qqwnQKJYq4E8Z0g3jCyx0yU6p4ahlhNES
	 AjO9IaYtCfPkrmqeBjf1jd7aMGFEI3GNvPWYyy1/zvrWifaRhpjT8P91be1jNtLQ8f
	 DhuGKpzu1X/bkPMXHxaLBUwKLUAIYUOiFm8zTmFMffxmw4jrJCnhjGL4GjBfDusW9R
	 H+enBAvwwpKhA==
Date: Fri, 23 Aug 2024 11:42:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org,
	corbet@lwn.net, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V3] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240823184225.GA6082@frogsfrogsfrogs>
References: <20240823180635.86163-1-gpiccoli@igalia.com>
 <6f303c9f-7180-45ef-961e-6f235ed57553@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f303c9f-7180-45ef-961e-6f235ed57553@kernel.dk>

On Fri, Aug 23, 2024 at 12:17:54PM -0600, Jens Axboe wrote:
> On 8/23/24 12:05 PM, Guilherme G. Piccoli wrote:
> > Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> > devices") added a Kconfig option along with a kernel command-line tuning to
> > control writes to mounted block devices, as a means to deal with fuzzers like
> > Syzkaller, that provokes kernel crashes by directly writing on block devices
> > bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> > 
> > The patch just missed adding such kernel command-line option to the kernel
> > documentation, so let's fix that.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > ---
> > 
> > V3: Dropped reference to page cache (thanks Bart!).
> > 
> > V2 link: https://lore.kernel.org/r/20240823142840.63234-1-gpiccoli@igalia.com
> > 
> > 
> >  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 09126bb8cc9f..58b9455baf4a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -517,6 +517,18 @@
> >  			Format: <io>,<irq>,<mode>
> >  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
> >  
> > +	bdev_allow_write_mounted=
> > +			Format: <bool>
> > +			Control the ability of directly writing to mounted block
> 
> Since we're nit picking...
> 
> Control the ability to directly write [...]
> 
> The directly may be a bit confusing ("does it mean O_DIRECT?"), so maybe
> just
> 
> Control the ability to write [...]
> 
> would be better and more clear.

"Control the ability to open a block device for writing."

Since that's what it actually does, right?

--D

> > +			devices, i.e., allow / disallow writes that bypasses the
> 
> Since we're nit picking, s/bypasses/bypass
> 
> > +			FS. This was implemented as a means to prevent fuzzers
> > +			from crashing the kernel by overwriting the metadata
> > +			underneath a mounted FS without its awareness. This
> > +			also prevents destructive formatting of mounted
> > +			filesystems by naive storage tooling that don't use
> > +			O_EXCL. Default is Y and can be changed through the
> > +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> > +
> >  	bert_disable	[ACPI]
> >  			Disable BERT OS support on buggy BIOSes.
> 
> -- 
> Jens Axboe
> 

