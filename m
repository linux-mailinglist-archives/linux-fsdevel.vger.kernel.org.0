Return-Path: <linux-fsdevel+bounces-42888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD62A4ACE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F8B1893281
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE11E47DD;
	Sat,  1 Mar 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="A2jA9XJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19EC19007D;
	Sat,  1 Mar 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847202; cv=none; b=Em5xLUa5XcqAUMb2bAdP4297Jf81vAF0ZZZ3AD9Ww3sVR7GGtW+eo0lQYTimDkR3HF9cDyTUAmjhGv3WaHuHD2lL66YkF/fbHFRD+R+loGnyOaucVMpoJ8hUZJBSyXNONRcK72LQUSWba0HKsNB+DtMMhemgnN4z+7Svp5cUVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847202; c=relaxed/simple;
	bh=FVQpJz2NQLO72Ywv6QilmFahoejCINbXoE91tlE00/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYWa/fPup72lcGYZU9oVTcXF8z3Lm0Cx/yqR5Qd3+V7M53/fUZHPUU6oYghydqmCa+aXBXycBgy7R7c0P3A+3FvEEeYRJl/2s3OZj08RfiYF6B9EksQb5+7YDpPLR83hbc+w4xFWB+zN0WQwhF386oWefkkBDfIKcmQEJ/GfhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=A2jA9XJy; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z4rQY4q0Hz9sl3;
	Sat,  1 Mar 2025 17:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740847190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2U/JC9Mkv2iTVLlyM6LmZFkoV9o6Q7G7toYDxFnoFrQ=;
	b=A2jA9XJyjbGcbS47afkSTerq1syUKrXRObXYBL1JQNZrC9B/DDbXSdIryAkOlqWo0Z+CcU
	8xZueFTRziHzn+JQQ0mHIpCtSJXI0td/jKn3u90tZ7HqG+fZgVPlsxZBKAn87ZE/KKtebY
	r7oRypgas1aMscsLfRYmh/WFKhBS9tTaHTy0scPDsIhvCwYxaqpQT+cCnFpjhWG/B8FS7b
	vJPZ7P9b1wG05AucfmNpakKsu+PjzD/S1R0I5kvbxXXxm8rH9PyZvaG61An3Os2yZmS42d
	B/L5dzwYMUAmDdPDG+BJBjib0x8E2vfhJ8uh7yNeNTOY+97c95p1r7oZjDC0gg==
Date: Sat, 1 Mar 2025 11:39:46 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Sven Peter <sven@svenpeter.dev>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-staging@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>

On 25/03/01 12:04AM, Sven Peter wrote:
> Hi,
> 
> 
> On Fri, Feb 28, 2025, at 02:53, Ethan Carter Edwards wrote:
> > Lately, I have been thinking a lot about the lack of APFS support on
> > Linux. I was wondering what I could do about that. APFS support is not 
> > in-tree, but there is a proprietary module sold by Paragon software [0].
> > Obviously, this could not be used in-tree. However, there is also an 
> > open source driver that, from what I can tell, was once planned to be 
> > upstreamed [1] with associated filesystem progs [2]. I think I would 
> > base most of my work off of the existing FOSS tree.
> >
> > The biggest barrier I see currently is the driver's use of bufferheads.
> > I realize that there has been a lot of work to move existing filesystem
> > implementations to iomap/folios, and adding a filesystem that uses
> > bufferheads would be antithetical to the purpose of that effort.
> > Additionally, there is a lot of ifndefs/C preprocessor magic littered
> > throughout the codebase that fixes functionality with various different
> > versions of Linux. 
> >
> > The first step would be to move away from bufferheads and the
> > versioning. I plan to start my work in the next few weeks, and hope to
> > have a working driver to submit to staging by the end of June. From
> > there, I will work to have it meet more kernel standards and hopefully
> > move into fs/ by the end of the year.
> >
> > Before I started, I was wondering if anyone had any thoughts. I am open
> > to feedback. If you think this is a bad idea, let me know. I am very
> > passionate about the Asahi Linux project. I think this would be a good
> > way to indirectly give back and contribute to the project. While I
> > recognize that it is not one of Asahi's project goals (those being
> > mostly hardware support), I am confident many users would find it
> > helpful. I sure would.
> 
> Agreed, I think it would be helpful for many people (especially those
> who still regularly dual boot between macOS and Linux) to have a working
> APFS driver upstream.
> This may also be useful once we fully bring up the Secure Enclave and need
> to read/write to at least a single file on the xART partition which has
> to be APFS because it's shared between all operating systems running on
> a single machine.
> 
> 
> It looks like there's still recent activity on that linux-apfs github
> repository. Have you reached out to the people working on it to see
> what their plans for upstreaming and/or future work are?

I did ask the upstream maintainer and he said he did not see it
happening. He specifically mentioned the use of bufferheads as a barrier
to mainline merging, but I get the sense that he does not have the
time/desire to commit to upstreaming it. [0]

I did have a question/concern over the inclusion of the LZFSE/LZVN [1]
compression library included in the module. It is BSD3 licensed, which,
as far as I know is GPL-compatible, but what is the kernel's policy on
external algorithms being included? It was originally developed by Apple
and as far as I can tell is pretty necessary to read (and write)
compressed files on APFS. Also, the library does produce an objtool
warning.

Ted, looping you in here, your thoughts?

> 
> 
> 
> Best,
> 
> 
> Sven
> 

Thanks,
Ethan

[0]: https://github.com/linux-apfs/linux-apfs-rw/issues/68
[1]: https://github.com/linux-apfs/linux-apfs-rw/tree/master/lzfse

