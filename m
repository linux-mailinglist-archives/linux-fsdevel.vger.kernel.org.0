Return-Path: <linux-fsdevel+bounces-19173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6808C0FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ECF282B65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E380E14B95C;
	Thu,  9 May 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="xtVL76wK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD513B7BD;
	Thu,  9 May 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259331; cv=none; b=E8uZKVf3WJx4ERZbj4wNGIidcw2TYhckuroeDS4Haa5+vSbVrdYo/BmoQd7L9cP5YkNfLnJR7NwBtnqI46Iyt0qkEU2dZUa+e//xEzRTJYPDHrUTWA/dd538lLRXvFgTyjXWJCmW0LIjA9B9TiueX7nY0+DmWHlRSkpSPuJxKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259331; c=relaxed/simple;
	bh=05QMPNFVypoo7MQhuiVJn5TpAp/gm9r77dINcx5tRVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpHZEyYhB8mq6pUM+KaaQ1+gzLHEsSEeN+6mM3iQnxIcwzmk4D/pMp6E8ZAR5OKHZ70+3uyUy5gcanAe0UYn4OKpN+Ue/6qHQla9CCOtp7jEM7q4QZG7cARAzi/bKh/9fFvK4AVTyFOuhCaWC+v5QVJAE66+GvXTYS1HQy5O9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=xtVL76wK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VZsS858jXz9sSD;
	Thu,  9 May 2024 14:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715259320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dfpr4O1ruwod+MTm7pGPfWogKD4Gt2EPTVtvHr0sOQs=;
	b=xtVL76wKt6rG8+F7KEd/puC+S7PZTXghfnlMFu3YrT77cDpYnNDzGw5jHLGr0NA2FLYjvZ
	84XZgst8xi9n7HvHw96PSpsgatVenbaBdLmPcLUSN9qddu4m9JXEXcE0YDl3owJT7GQD40
	ENZpttER1BHCfU4k5tDNTPBh2ZufQ8LUguhRhaA0ThPw95B9ZxExViRYb1YLCNXtTDOEve
	ne3wpNt9JGcTB3A1o8feQV9gj6ba0nTpIdHEO8AqGl/b/yOAztckdz/71iP+M2QmwSL47z
	j1QB9OujlUyv9iGK6lwnK9AYIXWGHcMi6s2Bn9zbqXBOgP47/SBjrIPnkvHnFw==
Date: Thu, 9 May 2024 12:55:14 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@lst.de, willy@infradead.org, mcgrof@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240509125514.2i3a7yo657frjqwq@quentin>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
 <20240509123107.hhi3lzjcn5svejvk@quentin>
 <ZjzFv7cKJcwDRbjQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzFv7cKJcwDRbjQ@infradead.org>
X-Rspamd-Queue-Id: 4VZsS858jXz9sSD

On Thu, May 09, 2024 at 05:46:55AM -0700, Christoph Hellwig wrote:
> On Thu, May 09, 2024 at 12:31:07PM +0000, Pankaj Raghav (Samsung) wrote:
> > > Well, that's why I suggest doing it at mount time.  Asking for it deep
> > > down in the write code is certainly going to be a bit problematic.
> > 
> > Makes sense. But failing to mount because we can't get a huge zero folio
> > seems wrong as we still can't guarantee it even at mount time.
> > 
> > With the current infrastructure I don't see anyway of geting a huge zero
> > folio that is guaranteed so that we don't need any fallback.
> 
> You export get_huge_zero_page, put_huge_zero_page (they might need a
> rename and kerneldoc for the final version) and huge_zero_folio or a
> wrapper to get it, and then call get_huge_zero_page from mount,

static bool get_huge_zero_page(void)
{
	struct folio *zero_folio;
retry:
	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
		return true;

	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO) & ~__GFP_MOVABLE,
			HPAGE_PMD_ORDER);
	if (!zero_folio) {

We might still fail here during mount. My question is: do we also fail
the mount if folio_alloc fails?

		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
		return false;
	}

...
> from unmount and just use huge_zero_folio which is guaranteed to
> exist once get_huge_zero_page succeeded.
> 

-- 
Pankaj Raghav

