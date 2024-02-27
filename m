Return-Path: <linux-fsdevel+bounces-12991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458B869D3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F261F2855A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7264EB5D;
	Tue, 27 Feb 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Bp8e/1d+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A94EB21;
	Tue, 27 Feb 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053810; cv=none; b=p+g8QwHXmJW0bqHUpUKTR7pVKjPHnMS/KYqsJG7B8KtujZ/wXGDKfRNQK3OJOcBmNpaR5N6jpc/KEHu6gvatO7Abk8o4+waXENFTrWbPNjt1IcJT42gAxmbpXbzwSPvi+Qi34J1aduwtUeDQKe3EogXe/VM/UvlZg1Zm/2ZDqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053810; c=relaxed/simple;
	bh=gyuDS9EtEKaZucQGaEB4KRJYUmQ89m4Q+KTR4RAwEKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6BTxxmsK3KUGg2PIBjIE55lgm4jDpGLfNtJ7IqS8dXigWUIPdfKwWtKf8m7vXnowD3V+TtmEuK2JVig6f71AO4vHTVkWvysqSAEEG4xevAfqk+wlXR+qLsIqi8fhc0oGr2lTZoPnZz1mhaoz0ONpkiV22r5vY/cqJEWqkFdiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Bp8e/1d+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkkWF4lXLz9stn;
	Tue, 27 Feb 2024 18:10:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709053801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3rbyqVBPDOPP9EM6vMSpLtzZtbMxF8srL9v40G0eMw=;
	b=Bp8e/1d+0s6eBqZSdp+nDUYyWX1I3kndK4tVYRukCkdA303SiPrLBul3QkDt5kyngCAxCH
	CclK+qmQimTSdZ37SJNF9ZyYlxC93pioBZL4JBPcXSnaSjNn4wsAlRppgX5jrhwJxVS9NX
	rk+zeg2BZoiI5WjnQfuFp9jTA9Fdr8Fuk9FkmCwPZzIFW+auxXD6VRyLQMgnSl02jeT8oe
	LaWL0DWKVVRHCLtwmfY2MAoo0lGBlMy6M774uvUCrgTYrqzgVjPMSNZ53L/bAQIBVmkAem
	RnWbBaahhuYcPF6ChRUiqlfzXlCRTxqpmuqKCms8KauMe4oQE/CatYUOSDAc9Q==
Date: Tue, 27 Feb 2024 18:09:57 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, david@fromorbit.com, 
	chandan.babu@oracle.com, akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, 
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <mm47tgwkrk3glymx6hzgp5bshnzqwqt26ja46xckfzzbjuwzic@oupjlfibn4nm>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
 <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
 <hjrsbb34ghop4qbb6owmg3wqkxu4l42yrekshwfleeqattscqp@z2epeibc67lt>
 <aajarho6xwi4sphqirwvukofvqy3cl6llpe5fetomj5sz7rgzp@xo2iqdwingtf>
 <vsy43j4pwgh4thcqbhmotap7rgzg5dnet42gd5z6x4yt3zwnu4@5w4ousyue36m>
 <4zpsfvy3e4hkc4avvjjr34rgo7ggpd6hpflptmiauvxwm3dpvk@5wulihwpwbyp>
 <na2k4nnvkseh2yh27eqkbfyouf7vnerd6i7pt4z7f7xsjsm6pu@ry5tvdcr2ggw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <na2k4nnvkseh2yh27eqkbfyouf7vnerd6i7pt4z7f7xsjsm6pu@ry5tvdcr2ggw>
X-Rspamd-Queue-Id: 4TkkWF4lXLz9stn

> > 
> > I have one question while I have you here. 
> > 
> > When we have this support in the page cache, do you think bcachefs can make
> > use of this support to enable bs > ps in bcachefs as it already makes use 
> > of large folios? 
> 
> Yes, of course.
> 
> > Do you think it is just a simple mapping_set_large_folios ->
> > mapping_set_folio_min_order(.., block_size order) or it requires more
> > effort?
> 
> I think that's all that would be required. There's very little in the
> way of references to PAGE_SIZE in bcachefs.

Sweet. I will take a look at it once we get this upstream.

--
Pankaj

