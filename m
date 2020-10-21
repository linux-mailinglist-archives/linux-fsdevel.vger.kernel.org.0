Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED8294733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 06:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440128AbgJUETc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 00:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411917AbgJUETb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:19:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E04C0613CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 21:19:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z6so1145656qkz.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 21:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fltLg7p8olmPSrPebFnn/kjNBcZ60UXPyDG5Tj6QA30=;
        b=W93uJsRhYuAW0NaI2zLhIzGo9PXTH81OF+Q9aA9L9P/S4em4WNWQNaN1FOh05AveMs
         0R7IqXXCc1uVg2lsqjts09eFuwQnC67d8gmv0bPjHd3nPl85DgQnfcq70SMDjnPZ77mt
         jB3l5VoQ0G1P7hT7nPgjapPhACPZy11RnFW/QYT25jT2BrriTOVUKbH7DtuNJY5sTl+l
         nAj8XfuMzJxRqM1n8zKFyYUU2k6Tg6G8+M64SWy+9PKQWSwNs9IqCkyAei0VPZ4mu+1k
         3Ky2yvZMICDlE6qr5RAJxSt97jJGgHhqvavJMoyMerdGfWHtLkvAwO3X/3VokBMLasg2
         8q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fltLg7p8olmPSrPebFnn/kjNBcZ60UXPyDG5Tj6QA30=;
        b=r2FicFpHM0hO+LziiLf2+JxUnJGvE4H/6n23D7qi9fkOTEQ3qy2bqxt/PtQxZUgWPJ
         W31LAeCm2kANN23TuCWjc7TFX9jfOHHXnhsTUh+TfGI+qmNPUkc/WufzJZaVlT/MRs9G
         SsFALH+hBTLLeXwlq+iWLaONYc5Isx4XcE7lFsBpl/HxiTK9ndcz4NKu6lAULYjt0P4U
         H7XbKmmL1SffjRSRj/phA6min40SNeAU5XQbMlRGTmyR9Bc5nUJlRQHYaWkUSTbP734D
         viZAVMycQD1gQF0B101UGUYUy01q6T2QNZ40ODGJAYrF44SxcZuC+7FreKPY6QEGqTI9
         rFuA==
X-Gm-Message-State: AOAM530BSfuYNEIecC26MDDZ+Dn6P9I0z1KR6nceGf3mPrmu6pRG8q7Q
        d31Va/i7MgicpeToRAw09ieKeGLsuQ==
X-Google-Smtp-Source: ABdhPJxu7uh8w0wzFCloFLtLURpSS/Y1T/f7OHAtmmG38JlQTLpwVlYG2wfdrEX/aQHHWqUMBVQpKA==
X-Received: by 2002:a37:67d8:: with SMTP id b207mr1526065qkc.174.1603253970629;
        Tue, 20 Oct 2020 21:19:30 -0700 (PDT)
Received: from zaphod.evilpiepirate.org ([2601:19b:c500:a1:d1eb:cfce:9b0b:f9e0])
        by smtp.gmail.com with ESMTPSA id n57sm578781qtf.52.2020.10.20.21.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 21:19:29 -0700 (PDT)
Date:   Wed, 21 Oct 2020 00:19:26 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC] find_get_heads_contig
Message-ID: <20201021041926.GA2597465@zaphod.evilpiepirate.org>
References: <20201021012630.GG20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021012630.GG20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:26:30AM +0100, Matthew Wilcox wrote:
> I was going to convert find_get_pages_contig() to only return head pages,
> but I want to change the API to take a pagevec like the other find_*
> functions have or will have.  And it'd be nice if the name of the function
> reminded callers that it only returns head pages.  So comments on this?

Perfect, looks like exactly what we need - at some point I can change my
vectorized pagecache stuff to use this.

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 31ba06409dfa..b7dd2523fe79 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2093,6 +2093,58 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
>  }
>  EXPORT_SYMBOL(find_get_pages_contig);
>  
> +/**
> + * find_get_heads_contig - Return head pages for a contiguous byte range.
> + * @mapping: The address_space to search.
> + * @start: The starting page index.
> + * @end: The final page index (inclusive).
> + * @pvec: Where the resulting pages are placed.
> + *
> + * find_get_heads_contig() will return a batch of head pages from
> + * @mapping.  Pages are returned with an incremented refcount.  Only the
> + * head page of a THP is returned.  In contrast to find_get_entries(),
> + * pages which are partially outside the range are returned.  The head
> + * pages have ascending indices.  The indices may not be consecutive,
> + * but the bytes represented by the pages are contiguous.  If there is
> + * no page at @start, no pages will be returned.
> + *
> + * Return: The number of pages which were found.
> + */
> +unsigned find_get_heads_contig(struct address_space *mapping, pgoff_t start,
> +		pgoff_t end, struct pagevec *pvec)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start);
> +	struct page *page;
> +
> +	rcu_read_lock();
> +	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
> +		if (xas.xa_index > end)
> +			break;
> +		if (xas_retry(&xas, page) || xa_is_sibling(page))
> +			continue;
> +		if (xa_is_value(page))
> +			break;
> +
> +		if (!page_cache_get_speculative(page))
> +			goto retry;
> +
> +		/* Has the page moved or been split? */
> +		if (unlikely(page != xas_reload(&xas)))
> +			goto put_page;
> +
> +		if (!pagevec_add(pvec, page))
> +			break;
> +		continue;
> +put_page:
> +		put_page(page);
> +retry:
> +		xas_reset(&xas);
> +	}
> +	rcu_read_unlock();
> +	return pagevec_count(pvec);
> +}
> +EXPORT_SYMBOL(find_get_heads_contig);
> +
>  /**
>   * find_get_pages_range_tag - Find and return head pages matching @tag.
>   * @mapping:	the address_space to search
