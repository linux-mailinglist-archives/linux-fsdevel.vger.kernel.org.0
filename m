Return-Path: <linux-fsdevel+bounces-28289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896A968E79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 21:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BACB1C226FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5441C62A7;
	Mon,  2 Sep 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="puhyG2Pr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37481A2643;
	Mon,  2 Sep 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725305734; cv=none; b=BwP+pL2AdVpaMLEHr5gqgFeZtz9OD4JG9/rGguE7HRQmxr6PPwlpWHSEtbZnGiFlfIxER+8nxrr+++OrHMMsB0JV+Lac9fiGWLslEZFFUymJT05+FoGiqLutZmG0ilZqwLKKKxuJ4F8jjPsR1hOTZHUVvPf87LAp1hjKEcA5fRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725305734; c=relaxed/simple;
	bh=3FsuXx2HBEHPPRCnRhiqty3vRAedUpOwduGoRLCHn3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt4pjPXYPCt84GjjuLwKQvU5j60NYHCWG+1istsG5ytI/4BcxbsjrqHVGA6p7auuDms+C8w3/Amk4RSHkw//p5qdpTZjlgdMch5fwFQHRrl2f+RkIuB6/SEIt8D0HukoCXe9qISGtC2tYahf1uQ8mriposZdLFjXqhQxu/WkXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=puhyG2Pr; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WyJrH5FTWz9syQ;
	Mon,  2 Sep 2024 21:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1725305727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gO3Xd6rwjK4x7+adB4VWglk+6KjE/LV8zfZQ+BMmR84=;
	b=puhyG2PrXMBDQdcrvvJhraVRl5MFi7F61jTEMstUgKQkfnuT09pAFDZ88PjJ6SU0mLZtdj
	WoO9xd4HJD4+XOJcpAAWqbiuP2maaoBmLaeSkQzLR3V/tlgWu2Sb4o76hMJa3naJx5fhUU
	gYmVrdJlEHHTfhf8fhzJhp0W6wOJgNkVFxuiiStZnLepPpOdBXDD5qf+544STMRUv0nLMX
	vmFcn3wQFTO5YAem6dWhE/PAeg5ie99XLuvDXZVKhC6jPjl3sS3NqU3GWhH5zWqxUe1pa2
	adQFwCmrFScUh406kRJxYdxaUui27zoDUJtJR8tP0PLLgt4GE1k5efFaPUVuVA==
Date: Mon, 2 Sep 2024 19:35:20 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, sfr@canb.auug.org.au,
	akpm@linux-foundation.org, linux-next@vger.kernel.org,
	mcgrof@kernel.org, ziy@nvidia.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] mm: don't convert the page to folio before splitting in
 split_huge_page()
Message-ID: <20240902193520.hvtjrnyqmosnkfff@quentin>
References: <20240902124931.506061-2-kernel@pankajraghav.com>
 <ZtXFBTgLz3YFHk9T@casper.infradead.org>
 <20240902-wovor-knurren-01ba56e0460e@brauner>
 <20240902144841.gfk4bakvtz6bxdqx@quentin>
 <20240902-leiblich-aufsehen-841e42a5a09d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902-leiblich-aufsehen-841e42a5a09d@brauner>
X-Rspamd-Queue-Id: 4WyJrH5FTWz9syQ

> > > > This should be folded into the patch that is broken, not be a separate
> > > > fix commit, otherwise it introduces a bisection hazard which are to be
> > > > avoided when possible.
> > > 
> > > Patch folded into "mm: split a folio in minimum folio order chunks"
> > > with the Link to this patch. Please double-check.
> > Thanks a lot!
> > 
> > I still don't see it upstream[1]. Maybe it is yet to be pushed?
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.blocksize&id=fd031210c9ceb399db1dea001c6a5e98f3b4e2e7
> 
> Pushed now.

I can see it now. Thanks Christian. :)

This patch has a merge conflict in linux-next. It should be a trivial
merge but let me know if you want me to send a patch for it.

