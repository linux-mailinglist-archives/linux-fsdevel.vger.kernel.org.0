Return-Path: <linux-fsdevel+bounces-18191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B888B644B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 23:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB283287F06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7317B51D;
	Mon, 29 Apr 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="U1ak6Uvm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145517B506;
	Mon, 29 Apr 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424571; cv=none; b=NnDo6yxuadxQC7u/HmUPnWtg5VbDjcF8FyByiGGsB3U8pJnJi/o2MfeA/LCJnKaT1xOTaZNjvofGo8RCteBpJA6gRr2235EJ1MpkCrEWaMvZsbWsSKdbrKib761YbG7dyMNBDJ058eUKXqn//gpFvuEYXfqK9lE7PRXk62ycNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424571; c=relaxed/simple;
	bh=go6kYlHFsYB74kl/8I+T1MsHa88jU15QVf/yTl3oup4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmI7bV3EHOjs/C5R0k9n2z6pX1zuuw/rrhhclET5bbJ+5hwSw8bKVq6261ReKL4Rsi/SeR7xGy0v5hb8y0GVlHVSfAPFoSq8hQRN9ecZT/ZxpSOooKpxvTX4+IgKwp4zCtc15Pf3TH1lzB3ETte1zXG1eT0e6KetGmlyaqA9LjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=U1ak6Uvm; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VSwl41tMbz9sVm;
	Mon, 29 Apr 2024 23:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714424560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVauk+VnSvpEomOaaZ84W2esQ3BuTML2YO68AJLinVg=;
	b=U1ak6UvmPza8W1SDteiXJrHNjmnBm0B1b3nBLu1KGy+d6fQetJxAoa+/bJ7RUmEiNPAyfS
	HoS3MZ22Jj5ktWujk3WY+hZziIF/GDt5iX/zLiNw3d/46mrNxn4VVxgiK/C8v8Ne7FdMAS
	m0ZJ5gHUYPAeyt0Dn1h2KKbaAmH6rXPcTvOXIIlA69z0AeZJcUa2Wdhx1llkSz8jNEUHn9
	/SS2kCHB5qGZJx13HA2FM1D6799dYqv+jHlULMJT74UPU7Hym41Jd92hlxEPAnneQ/AJrg
	wnhAgLhx+pwkyd7xaAJj1fZl6uCzjR+dhqFNcWPCJC+kwM2CHkrwurLrsmTLlQ==
Date: Mon, 29 Apr 2024 21:02:36 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: willy@infradead.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240429210236.jfmhk4uboiqidr35@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-8-kernel@pankajraghav.com>
 <ZitIK5OnR7ZNY0IG@infradead.org>
 <20240426114301.rtrqsv653a6vkbh6@quentin>
 <ZiyJITld-KdZeOrC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiyJITld-KdZeOrC@infradead.org>

On Fri, Apr 26, 2024 at 10:12:01PM -0700, Christoph Hellwig wrote:
> On Fri, Apr 26, 2024 at 11:43:01AM +0000, Pankaj Raghav (Samsung) wrote:
> > Because allocating it during runtime will defeat the purpose.
> 
> Well, what runtime?  Either way it seems like we have the infrastructure
> now based on the comment from willy.

As willy pointed out in that reply, it is allocated on demand, so it
might still fail and we might have to revert back to looping.
And if we end up using the huge zero page, we should also make sure to
decrement to reference in iomap_dio_bio_end_io(), which is not needed
when we use ZERO_PAGE.

FWIW, I did a prototype with mm_huge_zero_page() in one of the older series.
[1] (I forgot to decrement reference in end_io()) but I did not get final
response if that is the direction we want to go.

Let me know your thoughts.

[1]https://lore.kernel.org/linux-xfs/3pqmgrlewo6ctcwakdvbvjqixac5en6irlipe5aiz6vkylfyni@2luhrs36ke5r/#r
> 
> > In anycase, I would like to pursue huge_zero_page folio separately
> > from this series. Also iomap_dio_zero() only pads a fs block with
> > zeroes, which should never be > 64k for XFS.
> 
> Only if you are limited to 64k block size.
> 

