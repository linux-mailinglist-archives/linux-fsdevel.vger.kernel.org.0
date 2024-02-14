Return-Path: <linux-fsdevel+bounces-11586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23599854F6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F7B2B634
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D626087C;
	Wed, 14 Feb 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERNJznFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2D5FDD4;
	Wed, 14 Feb 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930242; cv=none; b=kVnYfoklPU3bc6ul10CUAa6Ld5C0BjFOwwrGvIb4a67rU1PxyBBzE+UqPioU6yZ9ditQDSxU+J4z/x08N9I0pSqMvTAIxywa+UWexIfAsoNFB+6NB7lRbZqVxeHqqK2TABLQ20ZnQ8CB+DadJde/AUHs5NSzn/vianmjsVx1kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930242; c=relaxed/simple;
	bh=aNT9Q60E6NVkQENhpyv0nYecctSGARo/x1kAK3Ece+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK3m0myFrYmki8i3wPT/qONC6wUrt5DGljb0T329cGCm6GgQAG0lAJMEV1pFvNr9fOh6WvoKtrtToPAkbRSDnJv1YuynTzGCsdnX1XOC0LOw77NRFjClT4vAPskdjGZoRcOyydhdrTyj22LN8vgTnIsFwlZCSSGfRvepAAQJQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERNJznFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F8AC433C7;
	Wed, 14 Feb 2024 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707930241;
	bh=aNT9Q60E6NVkQENhpyv0nYecctSGARo/x1kAK3Ece+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERNJznFbmzNdbYIgv703RahL/gAfd3tLwgp0nNTdut21G82Be5UqJRLj19OQdEI3P
	 EvEsJb5956q9MFqCQDGQK8FZ8orsES/A2nkHb89+77RngsKPLNHbnfzYN1Jlp1SkuY
	 5BWTTQMk6sOBYyjXismzj/jOpx5yD00waFzOTGII87EsO2SAR2aafw6XBg2kX5eYcX
	 vZbtslse8kt29MNCDIUmcKGAMmGcZKgeVkVnTNeudEgyW4i58IopFZwykLwko2otsX
	 dUBBN3BRLKhByZmzEsTl6Qf25kyqdoCa3CS4gQ1eYRJQ01D6gO1Zt0qg8OuvdTPEjV
	 lpJ7jz69itNKA==
Date: Wed, 14 Feb 2024 09:04:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>
Subject: Re: shmem patches headsup: Re: [ANNOUNCE] xfs-linux: for-next
 updated to 9ee85f235efe
Message-ID: <20240214170401.GA616564@frogsfrogsfrogs>
References: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240214080305.GA10568@lst.de>
 <877cj7a1zw.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cj7a1zw.fsf@debian-BULLSEYE-live-builder-AMD64>

On Wed, Feb 14, 2024 at 01:51:42PM +0530, Chandan Babu R wrote:
> On Wed, Feb 14, 2024 at 09:03:05 AM +0100, Christoph Hellwig wrote:
> > On Wed, Feb 14, 2024 at 12:18:41PM +0530, Chandan Babu R wrote:
> >> The for-next branch of the xfs-linux repository at:
> >> 
> >> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> >> 
> >> has just been updated.
> >
> > <snip>
> >
> >> Christoph Hellwig (17):
> >>       [f23e079e024c] mm: move mapping_set_update out of <linux/swap.h>
> >>       [604ee858a8c8] shmem: move shmem_mapping out of line
> >>       [8481cd645af6] shmem: set a_ops earlier in shmem_symlink
> >>       [9b4ec2cf0154] shmem: move the shmem_mapping assert into shmem_get_folio_gfp
> >>       [36e3263c623a] shmem: export shmem_get_folio
> >>       [74f6fd19195a] shmem: export shmem_kernel_file_setup
> >>       [eb84b86441e3] shmem: document how to "persist" data when using shmem_*file_setup
> >
> > I would have prefer an ACK or even a shared branch in the MM tree
> > for these.  But as it's been impossible to get any feedback from
> > the shmem and mm maintainer maybe this is the right thing to do.
> >
> 
> I am sorry. I completely forgot about the requirement for an ack from the MM
> maintainers. Thanks for bringing it to notice.

These seven patches have been out for review for nineteen days.

Patches 4, 5, and 7 have been out for review for FORTY TWO DAYS.

willy reviewed them after I asked him (thank you willy!), but this kind
of lead time for fairly minor patches is unworkable.

If you two are so overworked that you cannot provide feedback in under
six weeks, then I really need you to ask your manager for more help
hiring staff so that you can delegate tasks and unburden yourselves.
Stalling everyone else is a shitty thing to do.  Long feedback cycles
are destructive to developing things together -- look at what XFS has
become.

Or just let the patches go in and hch and I will deal with the
regression reports.  Maybe we'll even learn a few things in the process.
Spreading knowledge around the community and decentralizing to reduce
bus factor are two key points of free software, right?

In the meantime, this is blocking me from preparing online repair pull
requests for XFS for 6.9 because those patches need the stuff at the end
of the diet-v3 series.

--D

> -- 
> Chandan
> 

