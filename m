Return-Path: <linux-fsdevel+bounces-72669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33365CFEF97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA76331EA36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240E333426;
	Wed,  7 Jan 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwpu6oXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE539E6CD;
	Wed,  7 Jan 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803437; cv=none; b=ehIMzLcqPtX9QC8GJbbR6miISV9JXA+apO1vy7yRh6/jCxb5oihTcKauo+a9Sxjb0KJsxQxPsrDOy0J1sHDThlTR/RUJ7vcgQX0D+2dnYZ+c0eNRSvQNZ1/h+L2RR5LkrzXNCBdadlDJh3jpnzMfXKyPgx7NFRlNWAk0b2GH7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803437; c=relaxed/simple;
	bh=PzyWecouhwLII/NV3juqn3aJyT4OgFJo85oxsOKSt6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkMXzNbpkXQWNB+A6QIK32eTBE65+GCsOGgBMX73MqRU7MWTJ00nFhblTdgTFe92+m1dtShtYgJF23VGuXV2Q93n9ULVQ2JZ8TFgWTS9ccej4LTV8vCVLREoS9J5eIonY5Kft5bwiK8HPdsHLHrRkvAsmJAEo9so6vNVL4OVJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwpu6oXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAADC4CEF1;
	Wed,  7 Jan 2026 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767803436;
	bh=PzyWecouhwLII/NV3juqn3aJyT4OgFJo85oxsOKSt6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwpu6oXJs2UqqxxduAjq3DZZesh4CaHMovGIXVuKKkHPRKJg0TlbFjNz3kmQ6L0RM
	 Ff0L6m6Vrprn2oyfoFHYI8EQre0GIKo1B06TbOb4I8HdqSwg5ja/ppjAeB6siVz9rG
	 HF0HlsMgqe84a/4HtVzFvbPSyE1QQ1U81PhBUekLxSeuzyLzCJBieNaXHlRjUA6XKg
	 NMrxUoo4dHejBEmB0VLoiTwwf0VwzwtqGQiOJ3mHY3ALb7UzxPLCs1ZtsbfPjeqIgX
	 cMTPyPlVbQvJMUhYs9c8VkdAwpP95edSbwoVduJFBSE1LpZZH6qpTWgBVoUPe6A0sn
	 fgiod5yK2xBDQ==
Date: Wed, 7 Jan 2026 08:30:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media error reporting ioctl
Message-ID: <20260107163035.GA15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637485.774337.16716764027357885673.stgit@frogsfrogsfrogs>
 <20260107093611.GC24264@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107093611.GC24264@lst.de>

On Wed, Jan 07, 2026 at 10:36:11AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 05, 2026 at 11:13:29PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new privileged ioctl so that xfs_scrub can report the media errors
> > that it finds to the kernel for further processing.  Ideally this would
> > be done by the kernel, but the kernel doesn't (yet) support initiating
> > verification reads.
> 
> FYI, I'd much prefer adding the kernel support than relying in userspace
> doing it, which will be hard to move away from.

Hrm.  I wonder, does the block layer use iomap for directio?  Now that
the fserror reporting has been hooked up to iomap, I wonder if it's
possible for xfs_healer to listen for file IO errors on a block device?

Oh.  block/fops.c doesn't actually call iomap_dio_* so I guess that's
not yet possible.  Would it be easier to convert blockdevs to use iomap,
or should I bite the bullet and convert the legacy direct_IO code?

Or I guess one of us should go figure out a reasonable verify command
that would call fserror_* on media errors.

--D

