Return-Path: <linux-fsdevel+bounces-6663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515C81B4AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAA01F22E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029A6ABB7;
	Thu, 21 Dec 2023 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="obs2lYdW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5L7BcSKB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="obs2lYdW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5L7BcSKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000B6AB9F;
	Thu, 21 Dec 2023 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5D21FB42;
	Thu, 21 Dec 2023 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703156956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGCpOt7yvJg/Baj+l7YgN3+pIt5pBMerQ6avhaamLRk=;
	b=obs2lYdW0IeMmDnRh6+mcqyBv/dpPm3iKtRwHtHPDd36hOxZ25aiXvp8oPyqWdQVxmxD7x
	81hr71UhhdB8zKPAZCe9/+RlKWYEht6DCQuInTI/VbnwLbnHr46ITW2Q3J9auW/TfQhaiq
	IJGbNhP3BvQyvZ3OJP+o3PSdnO4KC2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703156956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGCpOt7yvJg/Baj+l7YgN3+pIt5pBMerQ6avhaamLRk=;
	b=5L7BcSKBF7aiALiaurswhJ1TzRUjwbgqVCWEhJmBQAaJyoDHG25mK/Af88nyVWAdKB7Fgh
	bNdjy+joWa5X5aDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703156956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGCpOt7yvJg/Baj+l7YgN3+pIt5pBMerQ6avhaamLRk=;
	b=obs2lYdW0IeMmDnRh6+mcqyBv/dpPm3iKtRwHtHPDd36hOxZ25aiXvp8oPyqWdQVxmxD7x
	81hr71UhhdB8zKPAZCe9/+RlKWYEht6DCQuInTI/VbnwLbnHr46ITW2Q3J9auW/TfQhaiq
	IJGbNhP3BvQyvZ3OJP+o3PSdnO4KC2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703156956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGCpOt7yvJg/Baj+l7YgN3+pIt5pBMerQ6avhaamLRk=;
	b=5L7BcSKBF7aiALiaurswhJ1TzRUjwbgqVCWEhJmBQAaJyoDHG25mK/Af88nyVWAdKB7Fgh
	bNdjy+joWa5X5aDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E02313725;
	Thu, 21 Dec 2023 11:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vT7BDtwchGWwVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 11:09:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1706A07E3; Thu, 21 Dec 2023 12:09:15 +0100 (CET)
Date: Thu, 21 Dec 2023 12:09:15 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] writeback: Factor out writeback_finish()
Message-ID: <20231221110915.kl2c45mepzzcqnbj@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-7-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,infradead.org:email,lst.de:email,suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 18-12-23 16:35:42, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Instead of having a 'done' variable that controls the nested loops,
> have a writeback_finish() that can be returned directly.  This involves
> keeping more things in writeback_control, but it's just moving stuff
> allocated on the stack to being allocated slightly earlier on the stack.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> [hch: heavily rebased, reordered and commented struct writeback_control]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h |  6 +++
>  mm/page-writeback.c       | 79 ++++++++++++++++++++-------------------
>  2 files changed, 47 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 833ec38fc3e0c9..390f2dd03cf27e 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -11,6 +11,7 @@
>  #include <linux/flex_proportions.h>
>  #include <linux/backing-dev-defs.h>
>  #include <linux/blk_types.h>
> +#include <linux/pagevec.h>
>  
>  struct bio;
>  
> @@ -40,6 +41,7 @@ enum writeback_sync_modes {
>   * in a manner such that unspecified fields are set to zero.
>   */
>  struct writeback_control {
> +	/* public fields that can be set and/or consumed by the caller: */
>  	long nr_to_write;		/* Write this many pages, and decrement
>  					   this for each page written */
>  	long pages_skipped;		/* Pages which were not written */
> @@ -77,6 +79,10 @@ struct writeback_control {
>  	 */
>  	struct swap_iocb **swap_plug;
>  
> +	/* internal fields used by the ->writepages implementation: */
> +	struct folio_batch fbatch;
> +	int err;
> +
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	struct bdi_writeback *wb;	/* wb this writeback is issued under */
>  	struct inode *inode;		/* inode being written out */
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index c798c0d6d0abb4..564d5faf562ba7 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2360,6 +2360,29 @@ void tag_pages_for_writeback(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(tag_pages_for_writeback);
>  
> +static void writeback_finish(struct address_space *mapping,
> +		struct writeback_control *wbc, pgoff_t done_index)
> +{
> +	folio_batch_release(&wbc->fbatch);
> +
> +	/*
> +	 * For range cyclic writeback we need to remember where we stopped so
> +	 * that we can continue there next time we are called.  If  we hit the
> +	 * last page and there is more work to be done, wrap back to the start
> +	 * of the file.
> +	 *
> +	 * For non-cyclic writeback we always start looking up at the beginning
> +	 * of the file if we are called again, which can only happen due to
> +	 * -ENOMEM from the file system.
> +	 */
> +	if (wbc->range_cyclic) {
> +		if (wbc->err || wbc->nr_to_write <= 0)
> +			mapping->writeback_index = done_index;
> +		else
> +			mapping->writeback_index = 0;
> +	}
> +}
> +
>  /**
>   * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
>   * @mapping: address space structure to write
> @@ -2395,17 +2418,12 @@ int write_cache_pages(struct address_space *mapping,
>  		      struct writeback_control *wbc, writepage_t writepage,
>  		      void *data)
>  {
> -	int ret = 0;
> -	int done = 0;
>  	int error;
> -	struct folio_batch fbatch;
>  	int nr_folios;
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
> -	pgoff_t done_index;
>  	xa_mark_t tag;
>  
> -	folio_batch_init(&fbatch);
>  	if (wbc->range_cyclic) {
>  		index = mapping->writeback_index; /* prev offset */
>  		end = -1;
> @@ -2419,22 +2437,23 @@ int write_cache_pages(struct address_space *mapping,
>  	} else {
>  		tag = PAGECACHE_TAG_DIRTY;
>  	}
> -	done_index = index;
> -	while (!done && (index <= end)) {
> +
> +	folio_batch_init(&wbc->fbatch);
> +	wbc->err = 0;
> +
> +	while (index <= end) {
>  		int i;
>  
>  		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> -				tag, &fbatch);
> +				tag, &wbc->fbatch);
>  
>  		if (nr_folios == 0)
>  			break;
>  
>  		for (i = 0; i < nr_folios; i++) {
> -			struct folio *folio = fbatch.folios[i];
> +			struct folio *folio = wbc->fbatch.folios[i];
>  			unsigned long nr;
>  
> -			done_index = folio->index;
> -
>  			folio_lock(folio);
>  
>  			/*
> @@ -2481,6 +2500,9 @@ int write_cache_pages(struct address_space *mapping,
>  				folio_unlock(folio);
>  				error = 0;
>  			}
> +		
> +			if (error && !wbc->err)
> +				wbc->err = error;
>  
>  			/*
>  			 * For integrity sync  we have to keep going until we
> @@ -2496,38 +2518,19 @@ int write_cache_pages(struct address_space *mapping,
>  			 * off and media errors won't choke writeout for the
>  			 * entire file.
>  			 */
> -			if (error && !ret)
> -				ret = error;
> -			if (wbc->sync_mode == WB_SYNC_NONE) {
> -				if (ret || wbc->nr_to_write <= 0) {
> -					done_index = folio->index + nr;
> -					done = 1;
> -					break;
> -				}
> +			if (wbc->sync_mode == WB_SYNC_NONE &&
> +			    (wbc->err || wbc->nr_to_write <= 0)) {
> +				writeback_finish(mapping, wbc,
> +						folio->index + nr);
> +				return error;
>  			}
>  		}
> -		folio_batch_release(&fbatch);
> +		folio_batch_release(&wbc->fbatch);
>  		cond_resched();
>  	}
>  
> -	/*
> -	 * For range cyclic writeback we need to remember where we stopped so
> -	 * that we can continue there next time we are called.  If  we hit the
> -	 * last page and there is more work to be done, wrap back to the start
> -	 * of the file.
> -	 *
> -	 * For non-cyclic writeback we always start looking up at the beginning
> -	 * of the file if we are called again, which can only happen due to
> -	 * -ENOMEM from the file system.
> -	 */
> -	if (wbc->range_cyclic) {
> -		if (done)
> -			mapping->writeback_index = done_index;
> -		else
> -			mapping->writeback_index = 0;
> -	}
> -
> -	return ret;
> +	writeback_finish(mapping, wbc, 0);
> +	return 0;
>  }
>  EXPORT_SYMBOL(write_cache_pages);
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

