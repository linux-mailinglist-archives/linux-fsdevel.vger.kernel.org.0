Return-Path: <linux-fsdevel+bounces-22867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19291DDC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD3E1C219F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656F13DDA7;
	Mon,  1 Jul 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="sWSGXNHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F21376E7;
	Mon,  1 Jul 2024 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832970; cv=none; b=bj7gGWswuVrkS5pQWw/2It7bNisTopbl7DJOOUCIO5S42pOjAUmRTjqDQdgAe64J/xXmMVShGrqEQbzWf0CzZt9GoGNrUJm1P5A1W9Hyx+y1xYpY09QqTGgHlEeKT+qn7ekdMdBtVP1cEBQuD/siKJQMMs9dxsYrfwVLLgvU5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832970; c=relaxed/simple;
	bh=PdZjdKVsTo8BInxtMoeikZhosQ+YMPeygOn+mRKQJlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz+J33PQvGXLXnc99o06yIxd/HCPPEcSIwpPxD1S5+3mD/4V2/FiUzt9ENS+ImmVHajfQpRApvFsKgpxuP6UqtDipPm6X92oQaQ6dZzN0R6QonnKsuJNQAZ8O8e2xNCT6dW4egVrvSWRHkNUfD7QGznjcrg57hiP/x11HpMbrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=sWSGXNHd; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WCNtj20JGz9stQ;
	Mon,  1 Jul 2024 13:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719832957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnAj7fu/gnOEMmtPn1UH5DlbH0qYTyY/NJtePcvvPoQ=;
	b=sWSGXNHdaOe+lh8vuyr7s9Prmk0ZUfC1xrL0pUTCn0fBww1tZtrnHprqu2iNl82i4lze6J
	sd0/9Mc1QDz0c7zqRC8YW1Jo+Zof/qKj+F7ISUotsntAv+U5xkE9nPhp0xlypYYGw//5/l
	ZDpVRwFdb0spyAXGZx3pHsBfCydB45nbE9LhE0J9kleP8jo6TcnDmevkIeLqd6taS6Rkfl
	d9ROd6QpXaqbOwCofoJ8GG6mEVN70BuTSLGsd7qlKm6qXYrSW5CBhXmnmShgkbdq0bKCzG
	K58sRCdijvxw+18RQ3f0vNe/odXTJR1//vBJovUnD+7fqWvbJBf6PYiJ/YpfRg==
Date: Mon, 1 Jul 2024 11:22:30 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240701112230.st6petb4sf7fs4ks@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <ZoIWVthXmtZKesSO@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoIWVthXmtZKesSO@dread.disaster.area>
X-Rspamd-Queue-Id: 4WCNtj20JGz9stQ

On Mon, Jul 01, 2024 at 12:37:10PM +1000, Dave Chinner wrote:
> On Tue, Jun 25, 2024 at 11:44:16AM +0000, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
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
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Looks fine, so:
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
Thanks!
> 
> but....
> 
> > +
> > +	if (!zero_page_64k)
> > +		return -ENOMEM;
> > +
> > +	set_memory_ro((unsigned long)page_address(zero_page_64k),
> > +		      1U << ZERO_PAGE_64K_ORDER);
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^
> isn't that just ZERO_PAGE_64K_SIZE?

Nope, set_memory_ro takes numbers of pages and not size in bytes :)

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

