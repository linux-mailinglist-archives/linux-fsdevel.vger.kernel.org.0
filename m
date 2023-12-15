Return-Path: <linux-fsdevel+bounces-6191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9960814A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352A5B22A7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0631741;
	Fri, 15 Dec 2023 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fV3YPsKf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cQxuTYfK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5nZCg9o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PzffO8tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662931725;
	Fri, 15 Dec 2023 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B25E821B39;
	Fri, 15 Dec 2023 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702650348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+1Vzn6gSgVRj2PeTCSSeHhZYkHtT8mht0lDEDG5nPo=;
	b=fV3YPsKfDjKk0wDiNz5lHnGWIiJvWJn3v5VRSZuiXcWcbcQsSTebimcXCwNzY6DwLoI4el
	NmkJEaGodEOhM2aK41i5PzERVhj62TqTcF7daDMICfL9lPmZEQs9F54TnsLcrObmCnIUiy
	DpS629c45/MhykftG8M/OZV6hrY1dMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702650348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+1Vzn6gSgVRj2PeTCSSeHhZYkHtT8mht0lDEDG5nPo=;
	b=cQxuTYfKDmFDq0YwbAMo96JMXs7XZYpTd0yp/UY6DnsDk2q75hWZgZw44jyVmMkdzDl1y1
	LuAETYpHzNqfG4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702650347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+1Vzn6gSgVRj2PeTCSSeHhZYkHtT8mht0lDEDG5nPo=;
	b=M5nZCg9oo12FS/a8eOsTeKRws1NkrZnAooEh/8YzOCZ4gEyXU3Nsd766n3YXrZzSTZYlFt
	sx/2zsjMbQcVFtRpzS8eJiYvE/zi1Q5AEQ0A9d/LuUuZfuF8LGWv/Pj46YNYEbo2T1UXXf
	IiIasiVRYe4DE4goUvHCEc4sXbXl90E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702650347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+1Vzn6gSgVRj2PeTCSSeHhZYkHtT8mht0lDEDG5nPo=;
	b=PzffO8tkAWptGRWe97c2p1cCLFw+S+acfO2t/aHorPPxZFPrWHt3ywkJvbSt11/5yEVg7k
	S55j3eGI9/7we0CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A18E113A08;
	Fri, 15 Dec 2023 14:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HC0rJ+thfGWeawAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 14:25:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 286B7A07E0; Fri, 15 Dec 2023 15:25:47 +0100 (CET)
Date: Fri, 15 Dec 2023 15:25:47 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 04/11] writeback: Simplify the loops in
 write_cache_pages()
Message-ID: <20231215142547.46g2lqs2d2u3ljwl@quack3>
References: <20231214132544.376574-1-hch@lst.de>
 <20231214132544.376574-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214132544.376574-5-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,lst.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 14-12-23 14:25:37, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Collapse the two nested loops into one.  This is needed as a step
> towards turning this into an iterator.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It would be good to mention in the changelog that we drop the condition
index <= end and just rely on filemap_get_folios_tag() to return 0 entries
when index > end. This actually has a subtle implication when end == -1
because then the returned index will be -1 as well and thus if there is
page present on index -1, we could be looping indefinitely. But I think
that's mostly a theoretical concern so I'd be fine with just mentioning
this subtlety in the changelog and possibly in a comment in the code.

								Honza

> ---
>  mm/page-writeback.c | 98 ++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 5a3df8665ff4f9..2087d16115710e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2460,6 +2460,7 @@ int write_cache_pages(struct address_space *mapping,
>  		      void *data)
>  {
>  	int error;
> +	int i = 0;
>  
>  	if (wbc->range_cyclic) {
>  		wbc->index = mapping->writeback_index; /* prev offset */
> @@ -2477,67 +2478,66 @@ int write_cache_pages(struct address_space *mapping,
>  	folio_batch_init(&wbc->fbatch);
>  	wbc->err = 0;
>  
> -	while (wbc->index <= wbc->end) {
> -		int i;
> -
> -		writeback_get_batch(mapping, wbc);
> +	for (;;) {
> +		struct folio *folio;
> +		unsigned long nr;
>  
> +		if (i == wbc->fbatch.nr) {
> +			writeback_get_batch(mapping, wbc);
> +			i = 0;
> +		}
>  		if (wbc->fbatch.nr == 0)
>  			break;
>  
> -		for (i = 0; i < wbc->fbatch.nr; i++) {
> -			struct folio *folio = wbc->fbatch.folios[i];
> -			unsigned long nr;
> +		folio = wbc->fbatch.folios[i++];
>  
> -			wbc->done_index = folio->index;
> +		wbc->done_index = folio->index;
>  
> -			folio_lock(folio);
> -			if (!should_writeback_folio(mapping, wbc, folio)) {
> -				folio_unlock(folio);
> -				continue;
> -			}
> +		folio_lock(folio);
> +		if (!should_writeback_folio(mapping, wbc, folio)) {
> +			folio_unlock(folio);
> +			continue;
> +		}
>  
> -			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> -
> -			error = writepage(folio, wbc, data);
> -			nr = folio_nr_pages(folio);
> -			if (unlikely(error)) {
> -				/*
> -				 * Handle errors according to the type of
> -				 * writeback. There's no need to continue for
> -				 * background writeback. Just push done_index
> -				 * past this page so media errors won't choke
> -				 * writeout for the entire file. For integrity
> -				 * writeback, we must process the entire dirty
> -				 * set regardless of errors because the fs may
> -				 * still have state to clear for each page. In
> -				 * that case we continue processing and return
> -				 * the first error.
> -				 */
> -				if (error == AOP_WRITEPAGE_ACTIVATE) {
> -					folio_unlock(folio);
> -					error = 0;
> -				} else if (wbc->sync_mode != WB_SYNC_ALL) {
> -					wbc->err = error;
> -					wbc->done_index = folio->index + nr;
> -					return writeback_finish(mapping,
> -							wbc, true);
> -				}
> -				if (!wbc->err)
> -					wbc->err = error;
> -			}
> +		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  
> +		error = writepage(folio, wbc, data);
> +		nr = folio_nr_pages(folio);
> +		if (unlikely(error)) {
>  			/*
> -			 * We stop writing back only if we are not doing
> -			 * integrity sync. In case of integrity sync we have to
> -			 * keep going until we have written all the pages
> -			 * we tagged for writeback prior to entering this loop.
> +			 * Handle errors according to the type of
> +			 * writeback. There's no need to continue for
> +			 * background writeback. Just push done_index
> +			 * past this page so media errors won't choke
> +			 * writeout for the entire file. For integrity
> +			 * writeback, we must process the entire dirty
> +			 * set regardless of errors because the fs may
> +			 * still have state to clear for each page. In
> +			 * that case we continue processing and return
> +			 * the first error.
>  			 */
> -			wbc->nr_to_write -= nr;
> -			if (wbc->nr_to_write <= 0 &&
> -			    wbc->sync_mode == WB_SYNC_NONE)
> +			if (error == AOP_WRITEPAGE_ACTIVATE) {
> +				folio_unlock(folio);
> +				error = 0;
> +			} else if (wbc->sync_mode != WB_SYNC_ALL) {
> +				wbc->err = error;
> +				wbc->done_index = folio->index + nr;
>  				return writeback_finish(mapping, wbc, true);
> +			}
> +			if (!wbc->err)
> +				wbc->err = error;
>  		}
> +
> +		/*
> +		 * We stop writing back only if we are not doing
> +		 * integrity sync. In case of integrity sync we have to
> +		 * keep going until we have written all the pages
> +		 * we tagged for writeback prior to entering this loop.
> +		 */
> +		wbc->nr_to_write -= nr;
> +		if (wbc->nr_to_write <= 0 &&
> +		    wbc->sync_mode == WB_SYNC_NONE)
> +			return writeback_finish(mapping, wbc, true);
>  	}
>  
>  	return writeback_finish(mapping, wbc, false);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

