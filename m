Return-Path: <linux-fsdevel+bounces-57007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BF2B1DC67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE4A7AAE5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E1271462;
	Thu,  7 Aug 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZbzgDWhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F653208
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587430; cv=none; b=V9HFztubA/RF8F3BLMQBr0YI5zwTpUWCFzTDGE/R+qNF77Wr6UYww4P25WzZ6crUxeD4ARVGWcskNCcGm9jRaUzbKsOHWW9cnHS4zjEojAkFvtzPNfeqVM+PUjrcnmGt4TEVWurS6a1KRwefvQv90byK5kYpwi+/TREHO8o/b0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587430; c=relaxed/simple;
	bh=BBs0gw325fyawkuzMT4R2HhK7mNyg0elDwRM39oO4YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmd7uwkGUJxdfx4xRPQivj0oxerexGHUpmhhnV9wxAfxEbs3vJlwo5WgF/afs7PagI5MXtzEHOzpQ9YSdJE5q1++H2nA7XRIqFHcop5QVJOZQ0jELJZkXUhavFLYagkVriIFniRq2874/al0YY+C2hVUEBEoKY4Jl9OP/BPtxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZbzgDWhD; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Aug 2025 10:23:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754587415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+PEcY5X38+TutgVZ5B3E+Djvpy61amQcaiukWSfVUw=;
	b=ZbzgDWhDhZpua1Eh3FH4y0TFiu+V6ZI60Ke3j9V/xYLECXyms2lUrRHDP3+4PbvDgbWGO8
	0wxWxcOtmDUUJn/y8uVR2nOEutAvSMcs8sd39chu4PPbLREkQ/0BgfvYPSjYH2sYXMDkLk
	cGbHSChsn9yzopP/a8Ft8CpsrHITjCI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, hch@infradead.org, wqu@suse.com
Subject: Re: [PATCH 3/3] mm: add vmstat for cgroup uncharged pages
Message-ID: <ytwxjnw4ioieognqrxlyuppbsndge4q4huyjdkdfo5rj2s36ny@oumr35d336vf>
References: <cover.1754438418.git.boris@bur.io>
 <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae30d630ba07de8966d09a3e1700f53715980c2.1754438418.git.boris@bur.io>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 05, 2025 at 05:11:49PM -0700, Boris Burkov wrote:
> If cgroups are configured into the kernel, then uncharged pages can only
> come from filemap_add_folio_nocharge. Track such uncharged folios in
> vmstat so that they are accounted for.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  include/linux/mmzone.h |  3 +++
>  mm/filemap.c           | 18 ++++++++++++++++++
>  mm/vmstat.c            |  3 +++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 283913d42d7b..a945dec65371 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -241,6 +241,9 @@ enum node_stat_item {
>  	NR_HUGETLB,
>  #endif
>  	NR_BALLOON_PAGES,
> +#ifdef CONFIG_MEMCG
> +	NR_UNCHARGED_FILE_PAGES,

> +#endif
>  	NR_VM_NODE_STAT_ITEMS
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ccc9cfb4d418..0a258b4a9246 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -146,6 +146,22 @@ static void page_cache_delete(struct address_space *mapping,
>  	mapping->nrpages -= nr;
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
> +{
> +	long nr = folio_nr_pages(folio) * sign;
> +
> +	if (!folio_memcg(folio))
> +		__lruvec_stat_mod_folio(folio, NR_UNCHARGED_FILE_PAGES, nr);

From filemap_add_folio_nocharge(), this function is called without
preemption disabled, so you will get lockdep warning from following
chain:

__lruvec_stat_mod_folio -> __mod_node_page_state ->
preempt_disable_nested -> lockdep_assert_preemption_disabled().


