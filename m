Return-Path: <linux-fsdevel+bounces-11433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F0853D0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA66282F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67F627E3;
	Tue, 13 Feb 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hoqQbHuA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444E612F9;
	Tue, 13 Feb 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858845; cv=none; b=L/wo/wHWAJyrZfiQKCUMzXRRSKMy/ESpewuMQgKOIWXpc9Ol2yooQ2xyvwGJchUV+n2X8/wk3+PWpa90sFEX7Wn56p7OSNwTCh2ZjbbMesOzHJ9v2vbr6Yxgf/deHTCKtDFptxzD2st8gPG957iMDR314Vr0YpbovU0ma9dxlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858845; c=relaxed/simple;
	bh=S3J4zlST+wxHxV0QDkNI7aYaDDSHL+rASbwhEYMSL0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFb+XCGVk6DFfuDxa6SNmHHKKrjtnu3ncrnf2XUe8MBvUw87/de7fpFoP8/NAihFMG8Ra1nyeta9t/+Jcaw0mUktRkoNHqyMxy3pSYB9n0LE25y2MPmyp4a/Lo/j9u+WF7GITX3b7JEaEAT5+oP8M94sNnhw0xKUy86jVUs51sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hoqQbHuA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TZDbD1XLsz9sry;
	Tue, 13 Feb 2024 22:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707858840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7WJh0rY7t1tbG5MUYD8H9w1/4ApsTlZUgX2ME/dH1Y=;
	b=hoqQbHuAL4jYct8W27o1LnWQ0j8Bg2L77QM4d+lI4Ry+gTZPVmghVfNwrPrCgeKp0It+ln
	eb04OK1cPcA24Sp7MWGRn43NG5Z+mkpXR8ukVkUpvletGY/cz8lmDyuchOOClG/uxSnXmW
	S33hsmE1DT7ZreOeHefKvnS3TU83ZkGfO1X2KyO1ojvWsB0DztnLQ97sPrke+C2rb+6anj
	4y5B+VTiWLrZbHGgs29GINx4gxZbHO2tIufvamfknes1YTq0PqDictJAAgZJaE6BS7TV9t
	7juGWY9R4bfVEtAiNm/uxz93WuaYh4L0AipK9UNYSS6Q6+flML0WXqD1T41GkQ==
Date: Tue, 13 Feb 2024 22:13:55 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 02/14] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <zjxq2so7fx3di7pa57nymko2cvfe7ugg6qtxasqbb6ziupy5ye@q4f6kddng5ro>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-3-kernel@pankajraghav.com>
 <487c0bec-4229-4add-bec4-1711f0b9bbee@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487c0bec-4229-4add-bec4-1711f0b9bbee@suse.de>

> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 750e779c23db..323a8e169581 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2479,14 +2479,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
> >   {
> >   	struct file *filp = iocb->ki_filp;
> >   	struct address_space *mapping = filp->f_mapping;
> > +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> >   	struct file_ra_state *ra = &filp->f_ra;
> > -	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
> > +	pgoff_t index = round_down(iocb->ki_pos >> PAGE_SHIFT, min_nrpages);
> >   	pgoff_t last_index;
> >   	struct folio *folio;
> >   	int err = 0;
> >   	/* "last_index" is the index of the page beyond the end of the read */
> >   	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> > +	last_index = round_up(last_index, min_nrpages);
> 
> Huh? 'last_index' is unset here; sure you mean 'iocb->ki_pos + count' ?
> 
> And what's the rationale to replace 'DIV_ROUND_UP' with 'round_up' ?

Actually we are not replacing DIV_ROUND_UP, we are just adding another
round_up operation to min_nrpages pages after we get the last_index by
converting the bytes to page count. The main idea is to align the
last_index to min_order, if it is set. AFAIK, there is no one helper
that can do both lines in one shot.

> 
> >   retry:
> >   	if (fatal_signal_pending(current))
> >   		return -EINTR;

