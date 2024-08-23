Return-Path: <linux-fsdevel+bounces-26945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F995D402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337A61F21902
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586FB18DF85;
	Fri, 23 Aug 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3GU4xfQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364B18C334;
	Fri, 23 Aug 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432760; cv=none; b=UKHm/udawTlNK23id5UB2eIP0YazAOfKSTL6O+uv8gBy8TjTDDdRZ7N58XSFU3uhxWu/nEn0jw9jBCMQMT5IsUTH0pAzP8eKIU/NSDhyunNl01njBUjH8qKBWkhFBsCppRGpqjP5odK/JcX+qE6Dfv952KfpPtmpHqKy+SSNTmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432760; c=relaxed/simple;
	bh=43adu1eRo+HRbxxi1+zURaQNHe8ohSSLo3KCZFqKHVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZQLya7ZwU86scYkZOYt+5ya4dre5REIyvDWxLYsuexTeqZT0xffABDrGjWtMCih1z1mwepZmAoL2BmaKbTumcvTRZD+2/NHwLav2vucjdbow2/9+k5x2hjtslbdXbER+7BnvZPsvTmp9+fedDEILirWWuz8W52IWg3+bQDuqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3GU4xfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECDEC32786;
	Fri, 23 Aug 2024 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432760;
	bh=43adu1eRo+HRbxxi1+zURaQNHe8ohSSLo3KCZFqKHVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3GU4xfQ5AIlqSIbxWMSew9BKJp9neUwscANQhzHf/jtO1TY7akFD2qugyHiacN+Q
	 YSsdI+yRc3TgNJpywiKLysrk5jsrEFVZH/1r4si29+qjrlHLEVbU7HksNGuwdRwNit
	 5IFPZoN18HtF7xFq3mUkDoiU1FVuT55xN9ah77HLuuZO42kY3+aMZVemHlOM9ILkaQ
	 HBrlG0vcvFF2ylx29SAzi8kRjAJ1VJW/Qs8PHpG3kU56d68G0rbMUEgQN7hkf/uNED
	 S4bWlv74C2bnkle+fIZguF+4hHwPxSOiBB9YRwkLefTTkir5NW1BFBDXkNnUjJKGKm
	 u7CSn4iBgMsPg==
Date: Fri, 23 Aug 2024 10:05:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org,
	corbet@lwn.net, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240823170559.GZ6082@frogsfrogsfrogs>
References: <20240823142840.63234-1-gpiccoli@igalia.com>
 <35febff2-e7cc-4b57-9ba5-798271fe0e3b@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35febff2-e7cc-4b57-9ba5-798271fe0e3b@acm.org>

On Fri, Aug 23, 2024 at 09:11:22AM -0700, Bart Van Assche wrote:
> On 8/23/24 7:26 AM, Guilherme G. Piccoli wrote:
> > +	bdev_allow_write_mounted=
> > +			Format: <bool>
> > +			Control the ability of directly writing to mounted block
> > +			devices' page cache, i.e., allow / disallow writes that
> > +			bypasses the FS. This was implemented as a means to
> > +			prevent fuzzers from crashing the kernel by overwriting
> > +			the metadata underneath a mounted FS without its awareness.
> > +			This also prevents destructive formatting of mounted
> > +			filesystems by naive storage tooling that don't use
> > +			O_EXCL. Default is Y and can be changed through the
> > +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> > +
> 
> Does this flag also affect direct I/O? If so, does this mean that the
> reference to the page cache should be left out?

I think it does affect directio, since the validation is done at open
time via bdev_may_open, right?

--D

> Thanks,
> 
> Bart.

