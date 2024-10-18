Return-Path: <linux-fsdevel+bounces-32307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A69A3578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF11C214E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD4187322;
	Fri, 18 Oct 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Q4A/O3Az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED185B76;
	Fri, 18 Oct 2024 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233204; cv=none; b=kbPNZ/e4ZnJ2UACQQXsu4ZujAFMjHsYEP/Jj+9aBJTba57MSrmSVhv5Z7ubCmB5hDL8LFVR2oDNpzOBIlcm71wU1p0L+gvURXD0h1Kk5qx+LX+/T49gEC/RGVNYdONjMUW0KJy29TB/pvoak6onlcqx9CKEwYUt5Q7jdjWiuZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233204; c=relaxed/simple;
	bh=DgBzEVeacJX8kOcVpx0QeOEBrBu9vyS8ZZ7KCkXwTUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3459N06csTC1TprDo+YiUZ3JT93pyk7a0PAv8+Zxmiz075OrhZ+TyYz8cmbHUxu3pqDwT4oucu0ryzSzGiDEcIqiLrG4sYcc74bEy4fUrz5lwqlEtzXsxd51SndVVWvt4+35JKoPEV897aKPHbbEBKvx85p8Ydkarrt3Z3mHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Q4A/O3Az; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XVFJS4PSRz9sWs;
	Fri, 18 Oct 2024 08:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729233192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9lUm76oun0J4cL0DUo+JXjgnZbpCrPo5PkXuS2bajE=;
	b=Q4A/O3AzgjJ4wq5kykEihJrGR2mq05IbVCjsvf5K+eE7lAVCwgZoZY9mFnUtVT/zYyfpze
	RPG/sdH0tbcSk4NntZTkuXtPcMW3TyJP3GzR2KOIjf176R5HjAB5BipJh6JbMB+Z/mrs02
	gAVpQcEfputQRiZGtSGB+gnmwVL/VmOf+kFHmQA7odWul3rLIra+JK4JS8R7Wwy4eeTp7v
	hq0Hjzvjwm4Lk/1ZvO1CJ1KhuVEcLbzl0gWNDe41V0LlMFNytCgKasb+xGziQemv13RvBh
	nB5g02waFyWevy4iRbwS2K498kYXajyeEe8RfCs0/hiEnkHoAn9xUjeN+YyEZQ==
Date: Fri, 18 Oct 2024 12:03:06 +0530
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] ecryptfs: Convert
 ecryptfs_copy_up_encrypted_with_header() to take a folio
Message-ID: <twf2bgvoif46nqmsazkxeig4w27nfsjmzdqcoakqiyh3yj5vp7@en6om7ow7nvv>
References: <20241017151709.2713048-1-willy@infradead.org>
 <20241017151709.2713048-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-4-willy@infradead.org>
X-Rspamd-Queue-Id: 4XVFJS4PSRz9sWs

On Thu, Oct 17, 2024 at 04:16:58PM +0100, Matthew Wilcox (Oracle) wrote:
> Both callers have a folio, so pass it in and use it throughout.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/ecryptfs/mmap.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> index 346ed5f7ff8d..f7525a906ef7 100644
> --- a/fs/ecryptfs/mmap.c
> +++ b/fs/ecryptfs/mmap.c
> @@ -104,7 +104,7 @@ static void strip_xattr_flag(char *page_virt,
>   * seeing, with the header information inserted.
>   */
>  static int
> -ecryptfs_copy_up_encrypted_with_header(struct page *page,
> +ecryptfs_copy_up_encrypted_with_header(struct folio *folio,
>  				       struct ecryptfs_crypt_stat *crypt_stat)
>  {
>  	loff_t extent_num_in_page = 0;
> @@ -113,9 +113,9 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
>  	int rc = 0;
>  
>  	while (extent_num_in_page < num_extents_per_page) {
> -		loff_t view_extent_num = ((((loff_t)page->index)
> +		loff_t view_extent_num = ((loff_t)folio->index
>  					   * num_extents_per_page)
> -					  + extent_num_in_page);
> +					  + extent_num_in_page;
>  		size_t num_header_extents_at_front =
>  			(crypt_stat->metadata_size / crypt_stat->extent_size);
>  
> @@ -123,21 +123,21 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
>  			/* This is a header extent */
>  			char *page_virt;
>  
> -			page_virt = kmap_local_page(page);
> +			page_virt = kmap_local_folio(folio, 0);
>  			memset(page_virt, 0, PAGE_SIZE);
>  			/* TODO: Support more than one header extent */
>  			if (view_extent_num == 0) {
>  				size_t written;
>  
>  				rc = ecryptfs_read_xattr_region(
> -					page_virt, page->mapping->host);
> +					page_virt, folio->mapping->host);
>  				strip_xattr_flag(page_virt + 16, crypt_stat);
>  				ecryptfs_write_header_metadata(page_virt + 20,
>  							       crypt_stat,
>  							       &written);
>  			}
>  			kunmap_local(page_virt);
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
>  			if (rc) {
>  				printk(KERN_ERR "%s: Error reading xattr "
>  				       "region; rc = [%d]\n", __func__, rc);
> @@ -150,9 +150,9 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
>  				 - crypt_stat->metadata_size);
>  
>  			rc = ecryptfs_read_lower_page_segment(
> -				page, (lower_offset >> PAGE_SHIFT),
> +				&folio->page, (lower_offset >> PAGE_SHIFT),
>  				(lower_offset & ~PAGE_MASK),
> -				crypt_stat->extent_size, page->mapping->host);
> +				crypt_stat->extent_size, folio->mapping->host);
>  			if (rc) {
>  				printk(KERN_ERR "%s: Error attempting to read "
>  				       "extent at offset [%lld] in the lower "
> @@ -189,7 +189,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
>  						      inode);
>  	} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
>  		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
> -			rc = ecryptfs_copy_up_encrypted_with_header(&folio->page,
> +			rc = ecryptfs_copy_up_encrypted_with_header(folio,
>  								    crypt_stat);
>  			if (rc) {
>  				printk(KERN_ERR "%s: Error attempting to copy "
> @@ -293,7 +293,7 @@ static int ecryptfs_write_begin(struct file *file,
>  		} else if (crypt_stat->flags & ECRYPTFS_VIEW_AS_ENCRYPTED) {
>  			if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR) {
>  				rc = ecryptfs_copy_up_encrypted_with_header(
> -					&folio->page, crypt_stat);
> +					folio, crypt_stat);
>  				if (rc) {
>  					printk(KERN_ERR "%s: Error attempting "
>  					       "to copy the encrypted content "
> -- 
> 2.43.0
> 

