Return-Path: <linux-fsdevel+bounces-32325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64499A3850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 10:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70246288DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC418D650;
	Fri, 18 Oct 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0hC39kpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED5188719;
	Fri, 18 Oct 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239340; cv=none; b=cO1GhJVGF28jJH8fI4JiB+yMNKQgTrNLcoZOTIG+FzcJf/Nn+q5SAhz25Ln0otRRicAh08Q+3UekZz6uWh1bkPhXLyuyYbnfqjdFc2fYbFXVInvbRjUOFpCWUh6T0I60im2wjD2RXesEL2dJzHPsFI3pVINshwc6T0Jj0YYRPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239340; c=relaxed/simple;
	bh=tF4XC4Vtg31heQ7HwhhO4oeaDoSrowJ/+m6SZnxNljw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGfu0OrND2XoW/xlj/B9s49P03pSL0ZbkWDqRcsM32wA+z2vatRJWmePIpg6aY3w4kcCc3g/qkCu+MePxvsiitHTps6Djk3VGIqfpndmlYfJTi2iBWVNL2myXCp0heHYRGyOCKqsdbn+0jEcPkbN401n+AUxNQtl8aiB66RiEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0hC39kpO; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XVHPV1Ld1z9tC4;
	Fri, 18 Oct 2024 10:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729238862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swUvX0MKrlHyxLPYu4fA9G6XlsWEUzrS6p8kehZqQlM=;
	b=0hC39kpOU0eHqXQDsGTqJs2Qc4425s5a/pLcxS6B/usxkVbkBKImtHYVvj4QNUSfBzxU49
	F/Zwt36nVeYZjgusOiSyxYsg0d3d7CR02T9VH24Yc1PzKwmI3HENyGDZ3ZBOwLida7NZ3r
	5goBtva9C4t0bVBWkyHmPNnPfsHzNhPmmuNrWQ2OX+fQ8vHADFTgPkCcH2YNeGWGTcxHNS
	qUvs/Q//bN3P0J/VK7Ald7z6xay9/3LyHpblIrPp6YIe556gKn8/WlGVJI9oVKs1DQfdrD
	FvLMiZmzd1EI5mAJxCSYbVlpJvGMAfniGB/lkbIXIB7kL8JmRCPfH6DMlxguOw==
Date: Fri, 18 Oct 2024 13:37:30 +0530
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/10] ecryptfs: Convert ecryptfs_write() to use a folio
Message-ID: <5gihme3d5baq4xqjwpiuazihxheraxnlufefqoesxvtofl6ho2@2p7pikrgauvo>
References: <20241017151709.2713048-1-willy@infradead.org>
 <20241017151709.2713048-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-6-willy@infradead.org>

On Thu, Oct 17, 2024 at 04:17:00PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove ecryptfs_get_locked_page() and call read_mapping_folio()
> directly.  Use the folio throught this function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/ecryptfs/ecryptfs_kernel.h |  1 -
>  fs/ecryptfs/mmap.c            | 16 ----------------
>  fs/ecryptfs/read_write.c      | 25 +++++++++++++------------
>  3 files changed, 13 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index 43f1b5ff987d..f04aa24f6bcd 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -662,7 +662,6 @@ int ecryptfs_read_lower_page_segment(struct folio *folio_for_ecryptfs,
>  				     pgoff_t page_index,
>  				     size_t offset_in_page, size_t size,
>  				     struct inode *ecryptfs_inode);
> -struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index);
>  int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
>  				 size_t *length_size);
>  int ecryptfs_write_packet_length(char *dest, size_t size,
> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> index b7ef0bf563bd..ad535bf9d2f9 100644
> --- a/fs/ecryptfs/mmap.c
> +++ b/fs/ecryptfs/mmap.c
> @@ -22,22 +22,6 @@
>  #include <linux/unaligned.h>
>  #include "ecryptfs_kernel.h"
>  
> -/*
> - * ecryptfs_get_locked_page
> - *
> - * Get one page from cache or lower f/s, return error otherwise.
> - *
> - * Returns locked and up-to-date page (if ok), with increased
> - * refcnt.
> - */
> -struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
> -{
> -	struct page *page = read_mapping_page(inode->i_mapping, index, NULL);
> -	if (!IS_ERR(page))
> -		lock_page(page);
> -	return page;
> -}
> -
>  /*
>   * This is where we encrypt the data and pass the encrypted data to
>   * the lower filesystem.  In OpenPGP-compatible mode, we operate on
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 251e9f6c6972..cddfdfced879 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -93,7 +93,6 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
>  int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  		   size_t size)
>  {
> -	struct page *ecryptfs_page;
>  	struct ecryptfs_crypt_stat *crypt_stat;
>  	char *ecryptfs_page_virt;
>  	loff_t ecryptfs_file_size = i_size_read(ecryptfs_inode);
> @@ -111,6 +110,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  	else
>  		pos = offset;
>  	while (pos < (offset + size)) {
> +		struct folio *ecryptfs_folio;
>  		pgoff_t ecryptfs_page_idx = (pos >> PAGE_SHIFT);
>  		size_t start_offset_in_page = (pos & ~PAGE_MASK);
>  		size_t num_bytes = (PAGE_SIZE - start_offset_in_page);
> @@ -130,17 +130,18 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  			if (num_bytes > total_remaining_zeros)
>  				num_bytes = total_remaining_zeros;
>  		}
> -		ecryptfs_page = ecryptfs_get_locked_page(ecryptfs_inode,
> -							 ecryptfs_page_idx);
> -		if (IS_ERR(ecryptfs_page)) {
> -			rc = PTR_ERR(ecryptfs_page);
> +		ecryptfs_folio = read_mapping_folio(ecryptfs_inode->i_mapping,
> +				ecryptfs_page_idx, NULL);
> +		if (IS_ERR(ecryptfs_folio)) {
> +			rc = PTR_ERR(ecryptfs_folio);
>  			printk(KERN_ERR "%s: Error getting page at "
>  			       "index [%ld] from eCryptfs inode "
>  			       "mapping; rc = [%d]\n", __func__,
>  			       ecryptfs_page_idx, rc);
>  			goto out;
>  		}
> -		ecryptfs_page_virt = kmap_local_page(ecryptfs_page);
> +		folio_lock(ecryptfs_folio);
> +		ecryptfs_page_virt = kmap_local_folio(ecryptfs_folio, 0);
>  
>  		/*
>  		 * pos: where we're now writing, offset: where the request was
> @@ -164,17 +165,17 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  			data_offset += num_bytes;
>  		}
>  		kunmap_local(ecryptfs_page_virt);
> -		flush_dcache_page(ecryptfs_page);
> -		SetPageUptodate(ecryptfs_page);
> -		unlock_page(ecryptfs_page);
> +		flush_dcache_folio(ecryptfs_folio);
> +		folio_mark_uptodate(ecryptfs_folio);
> +		folio_unlock(ecryptfs_folio);
>  		if (crypt_stat->flags & ECRYPTFS_ENCRYPTED)
> -			rc = ecryptfs_encrypt_page(ecryptfs_page);
> +			rc = ecryptfs_encrypt_page(&ecryptfs_folio->page);
>  		else
>  			rc = ecryptfs_write_lower_page_segment(ecryptfs_inode,
> -						ecryptfs_page,
> +						&ecryptfs_folio->page,
>  						start_offset_in_page,
>  						data_offset);
> -		put_page(ecryptfs_page);
> +		folio_put(ecryptfs_folio);
>  		if (rc) {
>  			printk(KERN_ERR "%s: Error encrypting "
>  			       "page; rc = [%d]\n", __func__, rc);
> -- 
> 2.43.0
> 

