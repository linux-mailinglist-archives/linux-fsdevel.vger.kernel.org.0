Return-Path: <linux-fsdevel+bounces-57072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE458B1E89D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B9A0210B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6627A10C;
	Fri,  8 Aug 2025 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="AWHt8fvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAA2110;
	Fri,  8 Aug 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657283; cv=none; b=Hq7s5KA72gurqs9r0DOSfdzEVGXgUOOT65S26hd5y7OivGN7GonbCo7ydmqkSxpPppZajiEO2waYQqotkyRKUfAxHOQAV22s+/pnYAh7vapmVjld0PZsYFoaxetVbOhjQxlFgNycp3cCW36KPTUq1CczUDSt0YkznrwksP4SC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657283; c=relaxed/simple;
	bh=ZGFdbRGwejrzDcHR/X3MgPRKwNwztzI4nbgHvvSToFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsQxTXNwApxcJ9OUvwnc25drtL0nUz1fWaoCHPtKwkhI01lMYOJ7zIwIzOMSBKCH8jDTuxcyx5NtU2yaHjWTKtUH6Nkl0JjZ113+PAsL9941ULDODtguBAA4SS7mTRK/jsa1QWWq373H6D0kPWegmccmjOCnD9Y+efKNoDXcVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=AWHt8fvS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bz3j93hX9z9tHh;
	Fri,  8 Aug 2025 14:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754657277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pkMYJ2o4F1aHWTWOscA3VXFDMI9SeAOXtPgcMzAcYs8=;
	b=AWHt8fvS0AlKB3qZ9GpjYc0BYsf9nEejwvWvkSXOYHgvNHxfmBHZbANDdmbDY4R+x4oxx4
	wn/8KiYDOD9RPkpwsTOTfxHHbnVR8fdu49EvKFLWpC84XXP4//tzmgPx3oDCAds2B/Tqyc
	VA/urPVj9d1rqLEY55/S2NaQiq9x0e8chaRU1WvQw1TFJONvhiJEl4m6sxwX4nqAo2xNPk
	Zwjz1G41FuBkw83SV4E+v9n8lpWaZJrUkpiv3BvdT0QYReq6+ssdiJtHrH0GuQKBiy3a6e
	DrNaQOP8fHx/w1BVRSpG6arLYRvIzXl9kS6GKhH+athZYNb4KdZCBu5NcTiNXw==
Date: Fri, 8 Aug 2025 14:47:42 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/5] mm: add persistent huge zero folio
Message-ID: <jd6qvb6erqjmsn6b7imwcsktthbvn6tefwdgfsseakra62t7yh@w5ju2gvvp2mj>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
 <20250808121141.624469-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808121141.624469-4-kernel@pankajraghav.com>

> +		if (!get_huge_zero_folio())
> +			pr_warn("Allocating static huge zero folio failed\n");

Oops, forgot to do s/static/persistent/ here.

I can fold this in the next version after receiving the comments.

