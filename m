Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8991636F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 00:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBRXLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 18:11:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6598 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgBRXLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:11:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c6f1d0000>; Tue, 18 Feb 2020 15:11:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 15:11:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 15:11:39 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 23:11:38 +0000
Subject: Re: [PATCH v6 06/19] mm: rename readahead loop variable to 'i'
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-10-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <64b98d0d-d281-fe34-8dbb-a04ac719d74d@nvidia.com>
Date:   Tue, 18 Feb 2020 15:11:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-10-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582067485; bh=Akrlss92FgzkovaQxMkVJdSsymeHgaqEmFb5c836i2c=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=asIzv0ojJMKF80DvWYkbSq9xGWJ7ZLdUAYVyRhXJBGnn4nPGzSL5rIS/ovTNr0scc
         gs7mPgZCbIGuN21UlJlaqg82EidFL/bBRrnN1h9FnqQChjvgbS/geskVhNeO2W1sV/
         biiNK98/SqvU14elddMK8D4ixbdxkqTNwCfXZWhbo6lz6fqouGkCodOHr15m9WoBPg
         I43na5oYhdKOUUcTc0axj14qTc0xmCQmt8qsSWiZWW3MAxOJzAv21qXLCylvpn+L1Q
         UamfH/UvbmkELot1FHszYWOU7zMxTj/3Gq6drvkO89R/67fyfce8YR2j0Jl0ROIySV
         t1Mvpfops1WHQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Change the type of page_idx to unsigned long, and rename it -- it's
> just a loop counter, not a page index.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Looks good,

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/mm/readahead.c b/mm/readahead.c
> index 74791b96013f..bdc5759000d3 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -156,7 +156,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
> -	int page_idx;
> +	unsigned long i;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
>  	struct readahead_control rac = {
> @@ -174,7 +174,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */
> -	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
> +	for (i = 0; i < nr_to_read; i++) {
>  		struct page *page;
>  
>  		if (offset > end_index)
> @@ -198,7 +198,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  			break;
>  		page->index = offset;
>  		list_add(&page->lru, &page_pool);
> -		if (page_idx == nr_to_read - lookahead_size)
> +		if (i == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		rac._nr_pages++;
>  		offset++;
> 
