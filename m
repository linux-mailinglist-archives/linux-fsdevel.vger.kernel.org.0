Return-Path: <linux-fsdevel+bounces-75240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DqCDyMzc2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:36:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965277299E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD68301778E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393DF306B31;
	Fri, 23 Jan 2026 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOPwLveg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED72E265A;
	Fri, 23 Jan 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157129; cv=none; b=IVSWfXEwXcKDccKom66yNdndPokuPp4XleS+lyIhRgWVSBw32LsOhymlJPh6YMKsF/LlzeHO0Da41Gtky+E910CJtNlH0hx6oGXt/q1eL79n/DqOdibR10Gul2Mo/V0AI2EYd9FPrH1YYKvVVafirW7kdgZ7fWtcT+boEO5cXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157129; c=relaxed/simple;
	bh=twK/F8qQbhX2/5NMWNxE616q9xKkGx76aZVXL7WTzTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHMoL73X+6/VXdhxpyRu0wB6STC0tHZHsLz6nOZRwwlvPrEjKKg0pnAODB6XUSgGhe19F6ZlDgYnNhs0086MbknIbBr955yRtIevVcXmxfX4yUgCfCGC5VS7bH3ANS4E6/JL/6OhIVun1EVw0Gdxg9Rt8S2RZZyME3g5vWEH0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOPwLveg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7688DC4CEF1;
	Fri, 23 Jan 2026 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157129;
	bh=twK/F8qQbhX2/5NMWNxE616q9xKkGx76aZVXL7WTzTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qOPwLvegr0JFWBIblBpY7yep6nshdSNLVM+ae1XFz5zUKb5C9YSEM8fPt80FsWP2G
	 QXor9itTjqrjLMxljbE3Z2QtrRmcvxytBUanArK5htz+6TxD22vmsvVZyB7m91tvUU
	 q6SRrLSaohR61rPPzwr9S8GA7zZWuiskXGFp0PuvpW/N87QTuF1IQtZlYJooW1YkL3
	 XOHVzDJe2JcIapqAGSmZcdbsyJGmxgJSyLhImvaZwYIYVoh7CNPK5jDwUXIAY8DybC
	 RcbPITvDB70gohO4AgF+/hRABhAkUPqiec3QXzveN/AuW6wBDHB+4ltbz2eSD7B8xk
	 UM34t2+BXscXw==
Message-ID: <824538a6-ce9d-41e7-9485-10ff9e4d5334@kernel.org>
Date: Fri, 23 Jan 2026 19:32:04 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] block: refactor get_contig_folio_len
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75240-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 965277299E
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Move all of the logic to find the contigous length inside a folio into
> get_contig_folio_len instead of keeping some of it in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c | 62 +++++++++++++++++++++++------------------------------
>  1 file changed, 27 insertions(+), 35 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 2359c0723b88..18dfdaba0c73 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1172,33 +1172,35 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
>  	bio_set_flag(bio, BIO_CLONED);
>  }
>  
> -static unsigned int get_contig_folio_len(unsigned int *num_pages,
> -					 struct page **pages, unsigned int i,
> -					 struct folio *folio, size_t left,
> +static unsigned int get_contig_folio_len(struct page **pages,
> +					 unsigned int *num_pages, size_t left,
>  					 size_t offset)
>  {
> -	size_t bytes = left;
> -	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, bytes);
> -	unsigned int j;
> +	struct folio *folio = page_folio(pages[0]);
> +	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
> +	unsigned int max_pages, i;
> +	size_t folio_offset, len;
> +
> +	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;

folio_page_idx(folio, pages[0]) is always going to be 0 here, no ?

> +	len = min(folio_size(folio) - folio_offset, left);
>  
>  	/*
> -	 * We might COW a single page in the middle of
> -	 * a large folio, so we have to check that all
> -	 * pages belong to the same folio.
> +	 * We might COW a single page in the middle of a large folio, so we have
> +	 * to check that all pages belong to the same folio.
>  	 */
> -	bytes -= contig_sz;
> -	for (j = i + 1; j < i + *num_pages; j++) {
> -		size_t next = min_t(size_t, PAGE_SIZE, bytes);
> +	left -= contig_sz;
> +	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +	for (i = 1; i < max_pages; i++) {
> +		size_t next = min_t(size_t, PAGE_SIZE, left);
>  
> -		if (page_folio(pages[j]) != folio ||
> -		    pages[j] != pages[j - 1] + 1) {
> +		if (page_folio(pages[i]) != folio ||
> +		    pages[i] != pages[i - 1] + 1)
>  			break;
> -		}
>  		contig_sz += next;
> -		bytes -= next;
> +		left -= next;
>  	}
> -	*num_pages = j - i;
>  
> +	*num_pages = i;
>  	return contig_sz;
>  }
>  
> @@ -1222,8 +1224,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
>  	ssize_t size;
> -	unsigned int num_pages, i = 0;
> -	size_t offset, folio_offset, left, len;
> +	unsigned int i = 0;
> +	size_t offset, left, len;
>  	int ret = 0;
>  
>  	/*
> @@ -1244,23 +1246,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		return size ? size : -EFAULT;
>  
>  	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> -	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
> -		struct page *page = pages[i];
> -		struct folio *folio = page_folio(page);
> +	for (left = size; left > 0; left -= len) {
>  		unsigned int old_vcnt = bio->bi_vcnt;
> +		unsigned int nr_to_add;
>  
> -		folio_offset = ((size_t)folio_page_idx(folio, page) <<
> -			       PAGE_SHIFT) + offset;
> -
> -		len = min(folio_size(folio) - folio_offset, left);
> -
> -		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> -
> -		if (num_pages > 1)
> -			len = get_contig_folio_len(&num_pages, pages, i,
> -						   folio, left, offset);
> -
> -		if (!bio_add_folio(bio, folio, len, folio_offset)) {
> +		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
> +		if (!bio_add_page(bio, pages[i], len, offset)) {
>  			WARN_ON_ONCE(1);
>  			ret = -EINVAL;
>  			goto out;
> @@ -1275,8 +1266,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  			 * single pin per page.
>  			 */
>  			if (offset && bio->bi_vcnt == old_vcnt)
> -				unpin_user_folio(folio, 1);
> +				unpin_user_folio(page_folio(pages[i]), 1);
>  		}
> +		i += nr_to_add;
>  		offset = 0;
>  	}
>  


-- 
Damien Le Moal
Western Digital Research

