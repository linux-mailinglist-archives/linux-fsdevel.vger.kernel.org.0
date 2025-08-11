Return-Path: <linux-fsdevel+bounces-57285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB030B203DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC94173630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF4223DF0;
	Mon, 11 Aug 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GTk5FROV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30772624;
	Mon, 11 Aug 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904949; cv=none; b=fxleQrLP3roFYhE3gkngIe7pI1AZJiVoRn+LttSquGixOCT4aKM9CvUa9sesTMyzQAZjFw771gVqMROgWkjmRztnJxmWf6eQpybQg9sJAnrFItBSusJ0JphSfxAVF68kb8OmgAAQXD4PhVJKdi8ImOeY77KhTeO/D3vxSJQrzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904949; c=relaxed/simple;
	bh=fRO/XvhtmCzSop7U0WLU8SqB29CBl0HDXlMdKUkfoCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6Lq1CscblqeVRDXW4bC5MwfElylqGNREAXCBdUXzgzf/tSQZzZ5ssGXHKiF/HmLvsIJL3YUeHUBzu6/3wvXMRo7xxtHcITcXcflunHeSLFSNb4rNbi+oX3ubMKL3P9laTxNV+uoUI9yLFnwvX7ZriRaRUR51Rru+4jsqwBOdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GTk5FROV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c0qHt1TDXz9t3B;
	Mon, 11 Aug 2025 11:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754904938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYaSNjo652MdDtNEkrK62ubowtD18Yw4cYxTCIxPtHU=;
	b=GTk5FROVMTCTxXEJppTQOFY+PCoXfXU0dO6ikOewslNIUGy1NT48uxATKWrhNK5SmFUp+J
	bdYU+VSSFeJfM3LNhz9fz2oQVmhbI9Yxr/R9k4L8fpCJeGFyB05/RXH4ljZ+uygivdVEb6
	WPyKyBkBSC2eJqSmo2xNBaUSwgfmTsvJYuJxADqsbd7JmYkDERu9VBjASWB4mxg7fL9uLp
	eKwwiCGqWgkU04QXht8/a4j2a7fh+CUrTGVIjQVhSevAfaixjy23fZhq9gUstYORo456H0
	SNAxLMr1DEWsFAD40K3IyPE+QcXwbvAxjon0uHgBmMNsaQs9gx3Cy3fBm4tUcw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <d1560177-b7ec-45f0-beb2-62bd5fe7d3a6@pankajraghav.com>
Date: Mon, 11 Aug 2025 11:35:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] block: use largest_zero_folio in
 __blkdev_issue_zero_pages()
To: Jens Axboe <axboe@kernel.dk>, hch@lst.de
Cc: linux-kernel@vger.kernel.org, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mike Rapoport <rppt@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 willy@infradead.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <20250811084113.647267-6-kernel@pankajraghav.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250811084113.647267-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4c0qHt1TDXz9t3B

On 8/11/25 10:41, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Use largest_zero_folio() in __blkdev_issue_zero_pages().
> On systems with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO enabled, we will end up
> sending larger bvecs instead of multiple small ones.
> 
> Noticed a 4% increase in performance on a commercial NVMe SSD which does
> not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
> gains might be bigger if the device supports bigger MDTS.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-lib.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 

@Jens and @Christoph, is it possible to take a quick look of this patch when you have the time?

I already made the changes that Christoph mentioned before, so I think it should
be good to go.

@Christoph, I will send the follow up patches to iomap direct io code once we get these changes
merged.

> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 4c9f20a689f7..3030a772d3aa 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -196,6 +196,8 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>  		struct bio **biop, unsigned int flags)
>  {
> +	struct folio *zero_folio = largest_zero_folio();
> +
>  	while (nr_sects) {
>  		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
>  		struct bio *bio;
> @@ -208,15 +210,14 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  			break;
>  
>  		do {
> -			unsigned int len, added;
> +			unsigned int len;
>  
> -			len = min_t(sector_t,
> -				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
> -			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
> -			if (added < len)
> +			len = min_t(sector_t, folio_size(zero_folio),
> +				    nr_sects << SECTOR_SHIFT);
> +			if (!bio_add_folio(bio, zero_folio, len, 0))
>  				break;
> -			nr_sects -= added >> SECTOR_SHIFT;
> -			sector += added >> SECTOR_SHIFT;
> +			nr_sects -= len >> SECTOR_SHIFT;
> +			sector += len >> SECTOR_SHIFT;
>  		} while (nr_sects);
>  
>  		*biop = bio_chain_and_submit(*biop, bio);


--
Pankaj

