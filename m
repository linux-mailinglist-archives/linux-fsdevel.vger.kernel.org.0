Return-Path: <linux-fsdevel+bounces-19086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDC8BFC4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2804E1F2419D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E4824BB;
	Wed,  8 May 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JzBIM3Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8D80C16;
	Wed,  8 May 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168405; cv=none; b=ugYCbN8zwlyA3EATnnCWxdWGIMTM4P9y0hmB/WzYAYPqTPhmz0IUGOvUc3tj7N17ocSnvB1HI0Cr5L0Zu9wW/CSgpIIYd/BnqQIB7+WtzMkJW84AK8N4A7Pq+Ms4a5HMcViRa+jtORP3D0pzn72mGmSg8EnPZmZ5By3FSY8doOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168405; c=relaxed/simple;
	bh=n1Yp/PNkGCAOaGgNzSnsKa0mSwmdF+6LRktN0bUkFe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnNS/nlsTsVJAUU0Hd5LdXD2ymtIBhdcr9kOTUSIicuJX/WcbA+8BLQ01iG5w3q9WBzGqzQG8yYqTbyd6ODpHQQbT/CGVlrM118ldUGKzB/nPu7jBU0hKeGOE67YKd2XRkzfJV0NSc/MH2LWHqdardOfBSl7p51Hw3kRhRMLSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JzBIM3Hh; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VZCqZ0LYQz9sQJ;
	Wed,  8 May 2024 13:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715168394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8b5b6l3GLCsDlk5O+ejhQUOklplNdWM3AwYuWOI24c=;
	b=JzBIM3HhX422tEgKrZjkDJsc26SpEUMYwBHDAqX7Kfq+NZTVCy4SI7U9rrUMzHOttYsWq3
	eFRQNzWLuKFRE3k8cq/gkjEO9wbr2EnCBNf2L5luPvZFJgot1pDngkSbmD+S13TVCgtkWm
	bdkTv9WMLn4147PK7nL+qNltl1D9hDx6C2duc8QvhUccVbWSFtvbMJ2FqD58XwFR3RsO2J
	8OI1utieoGx5XklFcqCEqaWXmX90f8YJyGS6WWZI35srhu+QdOnC/yC0Q96bOwELTm3bhk
	qrz/6IASRjGL5WlC4jQPlPTFux6muRM6XBJWPteLnm2AauVdvxc3BiVChd2qyQ==
Date: Wed, 8 May 2024 11:39:49 +0000
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
Message-ID: <20240508113949.pwyeavrc2rrwsxw2@quentin>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpSx7SBvzQI4oRV@infradead.org>

On Tue, May 07, 2024 at 09:11:51AM -0700, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> > +	if (len > PAGE_SIZE) {
> > +		folio = mm_get_huge_zero_folio(current->mm);
> 
> I don't think the mm_struct based interfaces work well here, as I/O
> completions don't come in through the same mm.  You'll want to use
> lower level interfaces like get_huge_zero_page and use them at
> mount time.

At the moment, we can get a reference to the huge zero folio only through
the mm interface. 

Even if change the lower level interface to return THP, it can still fail
at the mount time and we will need the fallback right?

> 
> > +		if (!folio)
> > +			folio = zero_page_folio;
> 
> And then don't bother with a fallback.
> 

-- 
Pankaj Raghav

