Return-Path: <linux-fsdevel+bounces-27811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37D964400
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7A91C249C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7919414E;
	Thu, 29 Aug 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqwrnsR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAB193096;
	Thu, 29 Aug 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933460; cv=none; b=BM9ZBw3LkHOoGdQ6gWTlfJn/Nvn0PLNiPnE4WJx+yZpwyaQ1PRqqgs2zoLZCzjs1XrW6LPO2Hl4FQoReB/nbSzqFXJ5g9l6vj2/JuyTvD8/3Ssa42SUu2VX3ZDkWXzVu7eWiKVJRB4C9zDTn6PgRFFLpW4VBvCq5FhcnWaszZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933460; c=relaxed/simple;
	bh=mw/x5gkzjiaE2Bw8RBvLT+WfmzG8tj/WG4ujtc6GP8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewcUl1idh0BDHENkXXtGF4u9c8JPdZJU+5b8J8x8Sf5VHyVXgo3nqMWNT0wBmGD94tUhY4j99YFMS9LKdRdy2h8JgPs+6mZI/rsgEuInCn4Wa9AGLUU+b8JOpqkvNXxyOm5iDbTZeg4VF1sA11rpqeOCBKLKjKmNZJ5RMl8dnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqwrnsR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E558C4CEC1;
	Thu, 29 Aug 2024 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933459;
	bh=mw/x5gkzjiaE2Bw8RBvLT+WfmzG8tj/WG4ujtc6GP8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqwrnsR537t1sPvKTzSMSc5IFE3VKwmqv+BZi4Rq40hQiM9TandikvQDZ32qbiBf0
	 qzdyKKv7AJ1pyaxYfKGyGZuwJnPHpGu5QvmfPWWEX9ISUjKSuC8x8klr+4NgxPYFSB
	 jjvSz+riUCay9XArVdXvCmrtjA/OLbYsxNalzdQY7rGmYQqaMhuy7Tpbgg56wjfKuK
	 RZqle4CSCBO4260jG2waEjyAq6cXxaWfJJNUs51N3A7p9Zs7IsTt/1vOHRmsnr+rxQ
	 C6yInIDaQ2an4ophiY20nb86dvKwh3zUjqTnWmZlQcz68p7U4ydaFLjHYK0eWZ9Ypu
	 FdF/q4DaZYt7A==
Date: Thu, 29 Aug 2024 14:10:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-doc@vger.kernel.org, corbet@lwn.net, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, 
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V5] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240829-galaktisch-zugegangen-77735bd59fae@brauner>
References: <20240828145045.309835-1-gpiccoli@igalia.com>
 <20240828162753.GO6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828162753.GO6043@frogsfrogsfrogs>

On Wed, Aug 28, 2024 at 09:27:53AM GMT, Darrick J. Wong wrote:
> On Wed, Aug 28, 2024 at 11:48:58AM -0300, Guilherme G. Piccoli wrote:
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
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Looks good to me now,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Fun unrelated question: do we want to turn on bdev_allow_write_mounted
> if lockdown is enabled?  In that kind of environment, we don't want to
> allow random people to scribble, given how many weird ext4 bugs we've
> had to fix due to syzbot.

I would say yes, we absolutely do.

