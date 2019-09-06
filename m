Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6903AAB7DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbfIFMJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 08:09:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37388 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfIFMJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:09:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id i1so6104393edv.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ZpOOYR+HZWQeyP2e1hldkbWyYIuYUrXJjhNyL08Hq8=;
        b=1gxHiQjKdOMyYiGzE5VW4GFk2+DGLsS8p512DlwXy29ptXKbSTxwpPVaBpZ1OwYzrS
         iNS3KHSS9jXjIQ+sUHeZZ9SEREISWmfb1ze0PNii5OcBKGxRubHhsMXap2slQfeghNCE
         E0p3aVriXPsjvaZlDj3krxH2NPEjfTGXCK5RptnMHNg2ycrRsJ+w7cFxLS6Mp2aIX6+6
         5QXL+r/wNaFsrn0yeAzhcJVg1lDEQYaXqGN1g3QrkgQJxox+6gQ+01A5CRWd0wbb7Ie4
         hfjVnoD4qOkIlwdZmQuoIW2hA+WZ/zAhKjctVLDpQvRmf4x2ndokxfa2L9yq5Kir9BMW
         1jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZpOOYR+HZWQeyP2e1hldkbWyYIuYUrXJjhNyL08Hq8=;
        b=aLEZIhAIz9rFPWIVej5dlQJV4LWJYnkhZp5YGsgMLKRdDHzvuLYWlMiOOEmguc4aws
         69k1lhvf5BroHADMGeEz73h5aqwepOxt0cWsZLGrfRuXPJ0XaMdFZPqUQDkJ9DWoZgxn
         YlxFqpluEdtUppQUeKrZI3uhG0XJhiukSWKxmxY6IjWqnVT0Qn9BuFmBciSQoIKGQeI9
         4EYnKZVbI8ytbQ5sXApe6P7KATJv92kIYYMkT7ABMAyM/8v6EJ4kQEEMVyz38/j7Xogy
         QwDBfu0WtH5gtpiJM3oUH6+0A3rTvrksjQTIba4qfL734EH8K9X8m6SHphqV2RolzS56
         WGQw==
X-Gm-Message-State: APjAAAWhhGAJnuHtLuwOYEIk84RR/khve/RdL5Ib9FUHhAYAp5bsYNzt
        k2Qa2lHCBH0ZR0Lsk4LBN62VU2aF/co=
X-Google-Smtp-Source: APXvYqzc3hH3oh715W7IxEi0aqKaryx+UF7bbnCEMkE8mzS+Qle/uOPGXcP6SUwwvaatUlZBYPeZIA==
X-Received: by 2002:a50:d55e:: with SMTP id f30mr9274055edj.35.1567771784925;
        Fri, 06 Sep 2019 05:09:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c21sm912039ede.45.2019.09.06.05.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 05:09:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 251D01049F1; Fri,  6 Sep 2019 15:09:44 +0300 (+03)
Date:   Fri, 6 Sep 2019 15:09:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 2/3] mm: Allow large pages to be added to the page cache
Message-ID: <20190906120944.gm6lncxmkkz6kgjx@box>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905182348.5319-3-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:23:47AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We return -EEXIST if there are any non-shadow entries in the page
> cache in the range covered by the large page.  If there are multiple
> shadow entries in the range, we set *shadowp to one of them (currently
> the one at the highest index).  If that turns out to be the wrong
> answer, we can implement something more complex.  This is mostly
> modelled after the equivalent function in the shmem code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 041c77c4ca56..ae3c0a70a8e9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -850,6 +850,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  	int huge = PageHuge(page);
>  	struct mem_cgroup *memcg;
>  	int error;
> +	unsigned int nr = 1;
>  	void *old;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> @@ -861,31 +862,47 @@ static int __add_to_page_cache_locked(struct page *page,
>  					      gfp_mask, &memcg, false);
>  		if (error)
>  			return error;
> +		xas_set_order(&xas, offset, compound_order(page));
> +		nr = compound_nr(page);
>  	}
>  
> -	get_page(page);
> +	page_ref_add(page, nr);
>  	page->mapping = mapping;
>  	page->index = offset;
>  
>  	do {
> +		unsigned long exceptional = 0;
> +		unsigned int i = 0;
> +
>  		xas_lock_irq(&xas);
> -		old = xas_load(&xas);
> -		if (old && !xa_is_value(old))
> +		xas_for_each_conflict(&xas, old) {
> +			if (!xa_is_value(old))
> +				break;
> +			exceptional++;
> +			if (shadowp)
> +				*shadowp = old;
> +		}
> +		if (old) {
>  			xas_set_err(&xas, -EEXIST);
> -		xas_store(&xas, page);
> +			break;
> +		}
> +		xas_create_range(&xas);
>  		if (xas_error(&xas))
>  			goto unlock;
>  
> -		if (xa_is_value(old)) {
> -			mapping->nrexceptional--;
> -			if (shadowp)
> -				*shadowp = old;
> +next:
> +		xas_store(&xas, page);
> +		if (++i < nr) {
> +			xas_next(&xas);
> +			goto next;
>  		}

Can we have a proper loop here instead of goto?

		do {
			xas_store(&xas, page);
			/* Do not move xas ouside the range */
			if (++i != nr)
				xas_next(&xas);
		} while (i < nr);

> -		mapping->nrpages++;
> +		mapping->nrexceptional -= exceptional;
> +		mapping->nrpages += nr;
>  
>  		/* hugetlb pages do not participate in page cache accounting */
>  		if (!huge)
> -			__inc_node_page_state(page, NR_FILE_PAGES);
> +			__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES,
> +						nr);
>  unlock:
>  		xas_unlock_irq(&xas);
>  	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
> @@ -902,7 +919,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  	/* Leave page->index set: truncation relies upon it */
>  	if (!huge)
>  		mem_cgroup_cancel_charge(page, memcg, false);
> -	put_page(page);
> +	page_ref_sub(page, nr);
>  	return xas_error(&xas);
>  }
>  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
> -- 
> 2.23.0.rc1
> 

-- 
 Kirill A. Shutemov
