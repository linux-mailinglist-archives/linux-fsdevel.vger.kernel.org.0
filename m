Return-Path: <linux-fsdevel+bounces-11679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AF855FAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC11C22325
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3C12B169;
	Thu, 15 Feb 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="qfjHyfZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79768526F;
	Thu, 15 Feb 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993281; cv=none; b=hdDM7J9LZwvFstVe4SUeRkiTEjIwlf24GaES3mPB7Uw9ZHUT45B4K/OkTCYqZvnYmPv80TBKjjzVK3ayXSyQfjGw038uVg7pJW79XaU3pwEi5yryoeK8PKfKB++aRbjILibRGsc95xBQaE3+lBUuK9R/bxRdA48f2w731fKyYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993281; c=relaxed/simple;
	bh=AqHTAn3N+1KnEOunH/6w/iyxJH/Kil5mim1zRaqivV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk5P06GadfuIF6AftidYtVL2oZL++GNVarJA9Wvo44JSXNG0SY8qOB5MYZ9cqPfuHFGHzNIWmGagzG9Y5AqJgybfCQwjgleO71EWanrHd+RykBm3ZypzSdCugj4WYevK+sV/fgFOOugVYAPO35FKRIM4JL+KK6N7wPYa5UYhwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=qfjHyfZj; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TbBJQ202Dz9sjQ;
	Thu, 15 Feb 2024 11:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707993270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LtJMv3OpCPMbfXLsBLVXagbPP7DLavp46+ckP2yjejI=;
	b=qfjHyfZj/UNcjxY50u5f+PTADR/t9f8/pkZtsIsajtcNAnN04HYby3eKmCSOxui0D+eZXm
	+6XCy3MCNKhPz8scfdNrdTpTyQ3nJo6ULbczuLaaY0VVJCbDzXIdoayNZGXFQ7RH9WHe/z
	f78mKbiBnlsADlt/2ifu865/to0LO/uSW/xKTb47JP96uT2ZUowlbuuN0QF18OFTn+qKnb
	5uT1qE17szzBwp6rHr/cPL+bajrGkqIyX0E9WZZMgVumEmEnetiQFSim6WAZuDko07pcSM
	avoJjlWteDUmtXh8KWWLxp6LtF1MtbId4kCatWRmFFrMMkMrUZbMUzRhatfcQA==
Date: Thu, 15 Feb 2024 11:34:24 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	akpm@linux-foundation.org, kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <l4ios6fmq4dpdncqjp3ukgnbahwuyu5pa5ntocj72qpxmnxlnv@awcgkr4fesoo>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
 <20240213163431.GS6184@frogsfrogsfrogs>
 <xy45wh2y55oinrvkhea36yxtnqmsoikp7eawaa2b5ejivfv4ku@ob72fvbkj4uh>
 <20240213212914.GW616564@frogsfrogsfrogs>
 <Zc0NtZrnHIXrZy53@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0NtZrnHIXrZy53@casper.infradead.org>

> > > Maybe I should have been explicit. We are planning to add support
> > > for min order in the first round, and we want to add support for max order
> > > once the min order support is upstreamed. It was done mainly to reduce
> > > the scope and testing of this series.
> > > 
> > > I definitely agree there are usecases for setting the max order. It is
> > > also the feedback we got from LPC.
> > > 
> > > So one idea would be not to expose max option until we add the support
> > > for max order? So filesystems can only set the min_order with the
> > > initial support?
> > 
> > Yeah, there's really no point in having an argument that's deliberately
> > ignored.
> 
> I favour introducing the right APIs even if they're not fully implemented.
> We have no filesystems today that need this, so it doesn't need to
> be implemented, but if we have to go back and add it, it's more churn
> for every filesystem.  I'm open to better ideas about the API; I think
> for a lot of filesystems they only want to set the minimum, so maybe
> introducing that API now would be a good thing.

I will introduce a new API that only exposes the min order for now. I
agree with you that I don't see a lot of filesystems other than XFS
using this in the near future.

We deduce min order based on the filesystem blocksize but we don't have any
mechanisms in place from userspace to set the max order for a filesystem.
So that also needs to be thought through and discussed with the
community.

I hope to start working on max_order immediately after upstreaming the
min_order feature.

--
Pankaj

