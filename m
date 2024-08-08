Return-Path: <linux-fsdevel+bounces-25449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D094C48E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28ED72815FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742314A08E;
	Thu,  8 Aug 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pPXOeXcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D613DDD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142422; cv=none; b=ash5lzvOpVIf/zNHz7XCWyzCQFKpAajK9jHMYh7dNzFMNRkj1SiGZehgTuz6/NVa/Jv37Y6pu1C2qYqqYIIXcjfoVwuwtB9agyY9pafyvtn0E+8fC/pZ1L2stcO76VoFoR9TtxNLab4avp/rwgdSqgd8sb4jl+4N+bWflA8tYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142422; c=relaxed/simple;
	bh=W8M01Ubih3LFLPLCDW7sI1VuQelOPUfcP++/jazIsdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luN4n0TtySXTFRe+pqNWqBpz6i4yl6LvnsI2bYGsPnZUxDn3LQIe+MFEKxVM+heCV82iCrq/2DRlYF6ilwSsBFMg9CB7/4m92h+1KiaOOdc1ehxU/887ba/3zP0EpznMiUZ27jOuuSg5oxtiDse7dqGgMLFrre92tYOoOuB+ilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pPXOeXcw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Aug 2024 11:40:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723142418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ydx9PAc0pIk6Ee6kt/IUIXQh6zOBiUcZmL5SQ/OjIOU=;
	b=pPXOeXcwxEhzflKfYUa1Yaj0Bth++HToPHST2WRMoRl7mUZMfX87lBWvPhv68eJBAueObQ
	nu4cjE+ekJDUIkGlrmcZB79rw+q5/EJk46AOzk85+KGvqtiELL8GjHLjA8WtIfWpzbdOPo
	RLAtQiq2FM/YbC4f6HGfpmxdEHeiEQM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, 
	song@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	willy@infradead.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v4 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
Message-ID: <f3iayd76egugsgmk3evwrzn4bcko5ax2nohatgcdyxss2ilwup@pmrkbledcpc3>
References: <20240807234029.456316-1-andrii@kernel.org>
 <20240807234029.456316-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807234029.456316-7-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 04:40:25PM GMT, Andrii Nakryiko wrote:
> Extend freader with a flag specifying whether it's OK to cause page
> fault to fetch file data that is not already physically present in
> memory. With this, it's now easy to wait for data if the caller is
> running in sleepable (faultable) context.
> 
> We utilize read_cache_folio() to bring the desired folio into page
> cache, after which the rest of the logic works just the same at folio level.
> 
> Suggested-by: Omar Sandoval <osandov@fb.com>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 5e6f842f56f0..e1c01b23efd8 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -20,6 +20,7 @@ struct freader {
>  			struct folio *folio;
>  			void *addr;
>  			loff_t folio_off;
> +			bool may_fault;
>  		};
>  		struct {
>  			const char *data;
> @@ -29,12 +30,13 @@ struct freader {
>  };
>  
>  static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
> -				   struct address_space *mapping)
> +				   struct address_space *mapping, bool may_fault)
>  {
>  	memset(r, 0, sizeof(*r));
>  	r->buf = buf;
>  	r->buf_sz = buf_sz;
>  	r->mapping = mapping;
> +	r->may_fault = may_fault;
>  }
>  
>  static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
> @@ -63,6 +65,11 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
>  	freader_put_folio(r);
>  
>  	r->folio = filemap_get_folio(r->mapping, file_off >> PAGE_SHIFT);
> +
> +	/* if sleeping is allowed, wait for the page, if necessary */
> +	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)))
> +		r->folio = read_cache_folio(r->mapping, file_off >> PAGE_SHIFT, NULL, NULL);

Willy's network fs comment is bugging me. If we pass NULL for filler,
the kernel will going to use fs's read_folio() callback. I have checked
read_folio() for fuse and nfs and it seems like for at least these two
filesystems the callback is accessing file->private_data. So, if the elf
file is on these filesystems, we might see null accesses.


