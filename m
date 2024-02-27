Return-Path: <linux-fsdevel+bounces-12987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F9869CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811AD1F27B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201E4DA11;
	Tue, 27 Feb 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Vxr/hBQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF147F60;
	Tue, 27 Feb 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052950; cv=none; b=RkxH9BYDybyj6n2KEEVWVNzqLfEnLHUWETiIvtcp2j+pZ7a19vhB2tfC1BEWdvwLnWFeuquxesCawbpH/Muf4n1wciru6eqXoZRxXvz7s3wsqFmjdrH2jLKQpdPIIrxQMjQoYgl0/bRXd93vZD0VLin8cD/q+9uH0SwY3hijRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052950; c=relaxed/simple;
	bh=na65zOZl5XTP/QEShmS7vfHvQhS99riKElDJy2bCLBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIqNIzgM4avI41bjNSQu7870pd4muCpf00XjVoHXsMUQd3SueK0QWwM7DQ3Q6/l+JEQxWBiZ52aYcAps7HeCKZMNo71OMyfwvUkS6Xv8qeu/IWy6xmQKpFZEnl2W0iIfHAxOJsXQIipkPn1UubhpTD8GTE5j+KNLn66k/5ik/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Vxr/hBQE; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TkkBg1LnFz9srf;
	Tue, 27 Feb 2024 17:55:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709052939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXehXAXIEmYYeqDh0Eogjo6VOr6C1m5T64ivWJ24wcQ=;
	b=Vxr/hBQEi90TuscbFQV/HaSCLfVBeGFcYfC9pSGkw1JM1bJ7O6/8lGar26+RcLW4OlbUlb
	DcQMfg9YhaMLL/vzJAb9CL7mQl5zjEStqSA+4G0ClSj248X9b5LTmqY5I8vxXJXuPystWs
	2H0Y+NlvZAP0b9UxUDnUqvV9nflG3WvAf3/T/hmg/v9EHi86TArZNEBmuFT4WYyRkil/NY
	zSZ5NzUamAXJWaJYjglAmwSCPPwhiKKFsucsuqthi4y7vcyWuIIL6hPa2N1MewHvnwAUSs
	mtxNXlWOjT8BPeJM3cdi1rClYkw2Fuc6kklS03TgcDEEtCLnQA6beIK114JV8w==
Date: Tue, 27 Feb 2024 17:55:35 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, david@fromorbit.com, 
	chandan.babu@oracle.com, akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, 
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <4zpsfvy3e4hkc4avvjjr34rgo7ggpd6hpflptmiauvxwm3dpvk@5wulihwpwbyp>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
 <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
 <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>
 <aajarho6xwi4sphqirwvukofvqy3cl6llpe5fetomj5sz7rgzp@xo2iqdwingtf>
 <vsy43j4pwgh4thcqbhmotap7rgzg5dnet42gd5z6x4yt3zwnu4@5w4ousyue36m>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vsy43j4pwgh4thcqbhmotap7rgzg5dnet42gd5z6x4yt3zwnu4@5w4ousyue36m>

> > > 
> > > you guys are both wrong, just use rounddown()
> > 
> > Umm, what do you mean just use rounddown? rounddown to ...?
> > 
> > We need to get index that are in PAGE units but aligned to min_order
> > pages.
> > 
> > The original patch did this:
> > 
> > index = mapping_align_start_index(mapping, iocb->ki_pos >> PAGE_SHIFT);
> > 
> > Which is essentially a rounddown operation (probably this is what you
> > are suggesting?).
> > 
> > So what willy is proposing will do the same. To me, what I proposed is
> > less complicated but to willy it is the other way around.
> 
> Ok, I just found the code for mapping_align_start_index() - it is just a
> round_down().
> 
> Never mind; patch looks fine (aside from perhaps some quibbling over
> whether the round_down()) should be done before calling readahead or
> within readahead; I think that might have been more what willy was
> keying in on)

Yeah, exactly.

I have one question while I have you here. 

When we have this support in the page cache, do you think bcachefs can make
use of this support to enable bs > ps in bcachefs as it already makes use 
of large folios? 
Do you think it is just a simple mapping_set_large_folios ->
mapping_set_folio_min_order(.., block_size order) or it requires more
effort?

