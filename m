Return-Path: <linux-fsdevel+bounces-26859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE1595C2C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 03:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939061F2482A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338418046;
	Fri, 23 Aug 2024 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1e/wpXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9DB125AC;
	Fri, 23 Aug 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376431; cv=none; b=OhN9fLCqUiZoaCR3l4FHhzWcDFm+lHiTk2aoIcOrHMN0R9NljzlbviAs/VwQK3nCvgeGP1LanayGckttG5FjEPyEaMiDo11z9Mqt9v1YpGvLxnKD9mO1euYLEWedEgrsTdu1NWc8B9qAuxlsA3sdfWZnGBqzQc79iIsAI2i5oXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376431; c=relaxed/simple;
	bh=Nf2wPTVgwfnfO4wozJbawzPg7tqsI7NIDsI0AfWVapU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJcjUuv9ODHZ20It6FIpPlvoKAYatLzDoVmKwEZWZMggddPgH74gFdTH17xTgU8ggKv+jr3GyVCXVjaeH3LocJRw/nD9ZEjKVtfD3/L1A9u4MfFtLoZiJQfGNnZzUhPU67wCxZ/Qcjeqn+ZYmd+7s4QvlywyJt7p1xMhaj1OANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1e/wpXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07E3C32782;
	Fri, 23 Aug 2024 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724376430;
	bh=Nf2wPTVgwfnfO4wozJbawzPg7tqsI7NIDsI0AfWVapU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1e/wpXirDNkn3eK7AMUEuOd/yiilMZj5Qiy43h17fD3qXrfAK8rg8H4vKD4x0+L3
	 tIWNy0aa61rQGYVBxjurWcSTXTmMy7zJQq8I+uGKg22bC5BWhQymnKOfQTt7HZzyRK
	 muY7J3ACs4u5HKVN7W7FaTL579agaEALb3PyUDKEPHEBHS6OtsBcxISwyXF8PSeGiq
	 tDuJ+rsOdag9qCF8Q/uBcyxronyeuZqoZKHqn4WYp7WHSil2NJqt32Q/A9m4ezsjmh
	 2CHeLBvMph8Dw0uRsUvyd0zSz7swMqU+VR7zyJUmUVX5lQaMi6bWeIuPcm4VseS0g1
	 Foby2pF4Rqzrg==
Date: Thu, 22 Aug 2024 18:27:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240823012710.GY6082@frogsfrogsfrogs>
References: <20240819225626.2000752-2-gpiccoli@igalia.com>
 <20240820162359.GI6043@frogsfrogsfrogs>
 <170545d7-3fa5-f52a-1250-dfe0a0fff93c@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170545d7-3fa5-f52a-1250-dfe0a0fff93c@igalia.com>

On Tue, Aug 20, 2024 at 03:42:53PM -0300, Guilherme G. Piccoli wrote:
> On 20/08/2024 13:23, Darrick J. Wong wrote:
> > [...]
> >> +	bdev_allow_write_mounted=
> >> +			Format: <bool>
> >> +			Control the ability of directly writing to mounted block
> >> +			devices' page cache, i.e., allow / disallow writes that
> >> +			bypasses the FS. This was implemented as a means to
> >> +			prevent fuzzers to crash the kernel by breaking the
> >> +			filesystem without its awareness, through direct block
> >> +			device writes. Default is Y and can be changed through
> >> +			the Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> > 
> > Can we mention that this also solves the problem of naïve storage
> > management tools (aka the ones that don't use O_EXCL) writing over a
> > mounted filesystem and trashing it?
> > 
> > --D
> 
> 
> Sure! At least from my side, fine with that.
> How about the following string ?
> 
> + Control the ability of directly writing to mounted block
> + devices' page cache, i.e., allow / disallow writes that
> + bypasses the FS. This was implemented as a means to
> + prevent fuzzers to crash the kernel by breaking the

                "...from crashing the kernel by overwriting
the metadata underneath a mounted filesystem without its awareness."

> + filesystem without its awareness, through direct block
> + device writes. Also prevents issues from direct writes

You can do it with buffered writes to the block device pagecache too.

"This also prevents destructive formatting of mounted filesystems by
naïve storage tooling that don't use O_EXCL."

--D

> + of silly storage tooling (that doesn't use O_EXCL). The
> + default is Y and can be changed through the Kconfig
> + option CONFIG_BLK_DEV_WRITE_MOUNTED.
> 
> 
> But feel free to improve / change it. I'll wait more feedback and
> resubmit with a refined text.
> Cheers,
> 
> 
> Guilherme

