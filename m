Return-Path: <linux-fsdevel+bounces-22599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBC919EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 07:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5137AB24EB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2B200CB;
	Thu, 27 Jun 2024 05:35:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4B1C696;
	Thu, 27 Jun 2024 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466506; cv=none; b=VD7pTz8OLC+ft2IACOumoVd0uagEHKTKsq/6IpBQkej1fDI/Z6oDaJEHUT8Dlh35v33U7jUzCyFxPvU35cex1ZC4aU/PaywbXn1LGUpJXcMejrxej8jz5bJ+cD/wD4mVdtWttrkREKeVmpYTsfIWHp4O3MA4SVgFjTohShOWcsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466506; c=relaxed/simple;
	bh=ANTmq0PDyj7pcosuTPkRJbwuIFc1EiOFoKBs5TAWMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX9709frgFUSlmwxGddezruFuKHH0TziyCqEgj/k9U+gEO1XZlAjPyjiTNgC2wpwl/wIk97SxP/5T4wk3kgYfVhBg7xcyuJuZds4ZL+fJBLAqLqgXqEidXYhXQymwXQFuhyFC5ZLN4rNyQtFwGbwaeOWHDLyPMRPzb0Y2hJ9ZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D92568C4E; Thu, 27 Jun 2024 07:35:01 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:35:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 05/13] mm: Allow compound zone device pages
Message-ID: <20240627053500.GE14837@lst.de>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com> <e5caa5ac3592dfd360ca44604a5b7c8b499976e8.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5caa5ac3592dfd360ca44604a5b7c8b499976e8.1719386613.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 10:54:20AM +1000, Alistair Popple wrote:
>  static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
>  {
> -	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
> +	return container_of(page_dev_pagemap(page), struct nouveau_dmem_chunk, pagemap);

Overly long line hee (and quite a few more).


