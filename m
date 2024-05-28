Return-Path: <linux-fsdevel+bounces-20344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5278D19DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FF5B26784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104616C84D;
	Tue, 28 May 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vF/+8BNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658616C6A2;
	Tue, 28 May 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896431; cv=none; b=UK70MA5I+2ZoE5571HKFw02ndbz8zZBzntjX+GtLDWqRF8C7D2rrKZzPLh5Dg2EcU5q4jVf8kRsV5XINTB2uHA1SixearTb4CnNyrFskQ1HJgrLk4VAQEUdAZsLNftBXGYT0GesEIWRNwoNr3N/IRsYjPx0tFqA86d4a9ALiTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896431; c=relaxed/simple;
	bh=Gz5Yvx1/zE1YfDeGa6ObCmZWnRd11MIK2lsjftxlw78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwhCxgfDUygWJO5kwcYVpJZ/OVEL+EsNgD8Oypj6Vco6Cuo12JzouboK4NVqy+eilMA5rx7Jll4X4jR/Cr+iBwWcigOMkduZ5Rr+QZWTwfrsI6tOgWIpIGeKQ9zZW4pDepNSILrDlA5fr0Ntsdx/kaeTKcrFbrb8NBoyZpS3eMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vF/+8BNK; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VpVty3xdqz9skm;
	Tue, 28 May 2024 13:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716896426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MH4iZoCa8o+1+vGItLvqB3NjLB67QMH9m+mQnQae1Lk=;
	b=vF/+8BNK+QYumbRVeBn29Mnw12RlofB+1HZ/AR8dijTzet5Y781x9EmMBjeqhwJrobCtU2
	rUB0WGzbDfGSo6mo/hyb5eZTUZUFvnBy7hfsHfe9tTKgqwZqxOxELRWnZF0wqzt+8NlTZZ
	kobE8B2cBleohXzHrsZ0VmKA9oLfkpmY5tNy/08tSiguUeAS6no1N71AfDSJm6/iG4RduD
	ZgeUzvzigairzfy7gHku5NoVgyd61xgyUJgo2C4GqwVc6qM6BTztWCpn9+LU1hXazJl2h8
	hHVAAReqKk4qcOAuQWM+3lCrbpZ9nBIuzyx2wrY2S0NzMsNOJJFCcoXSV7IOVg==
Date: Tue, 28 May 2024 11:40:20 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <20240528114020.eqnahlnna4srneax@quentin>
References: <20240527210125.1905586-1-willy@infradead.org>
 <e732a6ea-ade2-4398-b1ac-9e552fd365f5@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e732a6ea-ade2-4398-b1ac-9e552fd365f5@suse.de>

> > + */
> > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > +		unsigned int min, unsigned int max)
> > +{
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return;
> > +
> Errm. Sure? When transparent hugepages are _enabled_ we don't support this
> feature?
> Confused.
> 
Replied too quickly. I think this is a mistake. Thanks. I will fold this
change.

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

-- 
Pankaj Raghav

