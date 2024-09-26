Return-Path: <linux-fsdevel+bounces-30139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1BA986E63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CA91F24EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555E192B8A;
	Thu, 26 Sep 2024 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="W99n5ECV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D919004E;
	Thu, 26 Sep 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337529; cv=none; b=gecXNE+N8obsRk3DKxMITwxBpTsFAd7z2EZ/WAsBZwctUGneLN51RdCRUvPoRXv5HixduZfoDy78pt2yyUbXv1awgXgADqnKlE1/TSLauCtEAYRMrsMR/cnRmXUa4lLtFRypS+Bk4q6cu5cCbh8E9C551mb1Og+A7kW6aA6Xvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337529; c=relaxed/simple;
	bh=hOACXsUaXZM3G9sSR9a9lWI69dxAQWzSYa3/0XrmnQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuE5l5jhVuxcrqHknM1+NmLFxCXCUWxOKiMY1K+pEH4MUmkR55CKYpIhmeVaIpYeg3IUV0+fZ6tbNHJVHo6pu/wg2WHhQ5AJIpkxL35GaPDMwaQkxzht2Ly9W9cN1NxE3IN1fHVe7ttR3VN1bjWRky0m/TGawMVjWgGPathkShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=W99n5ECV; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XDmFB4t1Dz9v5K;
	Thu, 26 Sep 2024 09:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1727337518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zP6EkeLNzBCjBcgWBhh6/S1x/x0ehOHzgIwTNXBy7DI=;
	b=W99n5ECVLXncsEOrPWn0S2NvdkcQvJ0kL/wFIMFI7QEJxxqA2h5/JAoLQbRux0rnpcWrkV
	kRUzezmgww318fsoUKdQyxlLAp+Cbl2mnBjrSQcKTTl3DoOohvE+fwoIhRqTU/M+zF8GXl
	3GZzG6qp6Qotf290hKZ9tWqM3lOIe/64baRZjIr2CF+/nKY3tTih/2634m4uKm9PD1d81i
	w884pba/EiKQEG/U7ICFMG/jQ5au9lNoyJGM/kqExD1hMhyb4x1Qyp0wke1zq0kzx7p6vH
	zKYcJoXa2Msbmebsr9JQS8NkUYyo2/aWd5g3u/gZnu4tlUjIUz+RdBkLLMKFWg==
Date: Thu, 26 Sep 2024 09:58:24 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>, 
	Hannes Reinecke <hare@suse.de>, "Darrick J . Wong" <djwong@kernel.org>, 
	Dave Chinner <dchinner@redhat.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Re: [PATCH AUTOSEL 6.11 237/244] iomap: fix iomap_dio_zero() for
 fs bs > system page size
Message-ID: <xoxm6xlxqew2l3cbuahvkepcnckkiwa3ywetcyqep5hsq62mx5@xgmt3issrki6>
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-237-sashal@kernel.org>
 <ZvQJuuGxixcPgTUG@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvQJuuGxixcPgTUG@dread.disaster.area>

On Wed, Sep 25, 2024 at 11:01:46PM +1000, Dave Chinner wrote:
> On Wed, Sep 25, 2024 at 07:27:38AM -0400, Sasha Levin wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > [ Upstream commit 10553a91652d995274da63fc317470f703765081 ]
> > 
> > iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> > < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> > size < page_size. This is true for most filesystems at the moment.
> > 
> > If the block size > page size, this will send the contents of the page
> > next to zero page(as len > PAGE_SIZE) to the underlying block device,
> > causing FS corruption.
> > 
> > iomap is a generic infrastructure and it should not make any assumptions
> > about the fs block size and the page size of the system.
> 
> Please drop this. It is for support of new functionality that was
> just merged and has no relevance to older kernels. It is not a bug
> fix.
> 

I did not have any fixes by tag for this reason. So please drop this commit
from the queue.

> And ....
> 
> > +
> > +	set_memory_ro((unsigned long)page_address(zero_page),
> > +		      1U << IOMAP_ZERO_PAGE_ORDER);
> 
> .... this will cause stable kernel regressions.
> 
> It was removed later in the merge because it is unnecessary and
> causes boot failures on (at least) some Power architectures.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

-- 
Pankaj Raghav

