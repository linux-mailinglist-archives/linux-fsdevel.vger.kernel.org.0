Return-Path: <linux-fsdevel+bounces-1620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEAF7DC6E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 08:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4A9B20D90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCEE107AC;
	Tue, 31 Oct 2023 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CM2miGhU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fu4mqHKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65B360
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 07:04:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C59DB;
	Tue, 31 Oct 2023 00:04:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3DC1F38A;
	Tue, 31 Oct 2023 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698735845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uYnrLXiUnb54kRt3R0VsUK9uL16N6yJSyjoGJOu1qs=;
	b=CM2miGhUrdbZ4KaKz4ZKz4KfhWel4XKNq1I1MYfqvnMq17bm2lNDP4hyzMeRO4UvZ/hPrP
	JLOoMp3HK8GR/4wtcUB1weu13Pj7B/dJwIVSgpSgB/Hfg50FOceWh0wFcQ0/limdZi7yJ3
	g1XV02LX/HWhWy+j8vudNs+LCpBy4B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698735845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uYnrLXiUnb54kRt3R0VsUK9uL16N6yJSyjoGJOu1qs=;
	b=fu4mqHKKtb5ROaJmYvb7VLOtwGR6dRopNgQERe9Oz4vGWK6uvh/1c6JvcJ8w2buXCPKMHS
	IZTk+KCWYuaiwmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 279A7138EF;
	Tue, 31 Oct 2023 07:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jYwPCOWmQGVTFQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 31 Oct 2023 07:04:05 +0000
Message-ID: <735f3692-2932-4986-abec-c217da182f71@suse.de>
Date: Tue, 31 Oct 2023 08:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/11] shmem: add order arg to shmem_alloc_folio()
Content-Language: en-US
To: Daniel Gomez <da.gomez@samsung.com>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "djwong@kernel.org"
 <djwong@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
 "hughd@google.com" <hughd@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "gost.dev@samsung.com" <gost.dev@samsung.com>,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef@eucas1p1.samsung.com>
 <20231028211518.3424020-10-da.gomez@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231028211518.3424020-10-da.gomez@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/28/23 23:15, Daniel Gomez wrote:
> Add folio order argument to the shmem_alloc_folio() and merge it with
> the shmem_alloc_folio_huge(). Return will make use of the new
> page_rmappable_folio() where order-0 and high order folios are
> both supported.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>   mm/shmem.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d8dc2ceaba18..fc7605da4316 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1614,40 +1614,27 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>   	return result;
>   }
>   
> -static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
> -		struct shmem_inode_info *info, pgoff_t index)
> +static struct folio *shmem_alloc_folio(gfp_t gfp, struct shmem_inode_info *info,
> +				       pgoff_t index, unsigned int order)
>   {
>   	struct mempolicy *mpol;
>   	pgoff_t ilx;
>   	struct page *page;
>   
> -	mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
> -	page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id());
> +	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
> +	page = alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
>   	mpol_cond_put(mpol);
>   
>   	return page_rmappable_folio(page);
>   }
>   
> -static struct folio *shmem_alloc_folio(gfp_t gfp,
> -		struct shmem_inode_info *info, pgoff_t index)
> -{
> -	struct mempolicy *mpol;
> -	pgoff_t ilx;
> -	struct page *page;
> -
> -	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
> -	page = alloc_pages_mpol(gfp, 0, mpol, ilx, numa_node_id());
> -	mpol_cond_put(mpol);
> -
> -	return (struct folio *)page;
> -}
> -
>   static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>   		struct inode *inode, pgoff_t index,
>   		struct mm_struct *fault_mm, size_t len)
>   {
>   	struct address_space *mapping = inode->i_mapping;
>   	struct shmem_inode_info *info = SHMEM_I(inode);
> +	unsigned int order = 0;
>   	struct folio *folio;
>   	long pages;
>   	int error;
> @@ -1668,12 +1655,12 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>   				index + HPAGE_PMD_NR - 1, XA_PRESENT))
>   			return ERR_PTR(-E2BIG);
>   
> -		folio = shmem_alloc_hugefolio(gfp, info, index);
> +		folio = shmem_alloc_folio(gfp, info, index, HPAGE_PMD_ORDER);
>   		if (!folio)
>   			count_vm_event(THP_FILE_FALLBACK);
>   	} else {
> -		pages = 1;
> -		folio = shmem_alloc_folio(gfp, info, index);
> +		pages = 1UL << order;
> +		folio = shmem_alloc_folio(gfp, info, index, order);
>   	}
>   	if (!folio)
>   		return ERR_PTR(-ENOMEM);
> @@ -1774,7 +1761,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>   	 */
>   	gfp &= ~GFP_CONSTRAINT_MASK;
>   	VM_BUG_ON_FOLIO(folio_test_large(old), old);
> -	new = shmem_alloc_folio(gfp, info, index);
> +	new = shmem_alloc_folio(gfp, info, index, 0);

Shouldn't you use folio_order(old) here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


