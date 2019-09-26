Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C4BF4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfIZOW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 10:22:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIZOW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:22:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id a15so2230794edt.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5emM3Rv+s+i5KmFmY5Kma29c8NT7iZ5h14sKZDL3uyk=;
        b=ozDk6nG0t+v2BwzAIAh7k+bP68jePR7qhFDcsDF6KYLwYjaC95ORzVu9scI/c83NCD
         N4aq5ip8f3HXBF/zsXbtuQVM40Zo+mHheL7FdsmlWB/klHcFlDtX9HC1UrFmMya6AAmd
         +GRsl/o2voYqz8MNWVeG09/njhy+rdsTXSZn9crRVbx3PKbMKXTQ1jAUeu9IMmtmCYtk
         XuJRTaZqx2/gGgU06pCqzUDerLwKmUBfG91qQdtA95+P3M/eoB8Uyn1hFyFBl7hffk93
         XkyYtmaEKm1ghvB8GxgP5J1j0k1WhNm16G//Ay6ek0t7IhGIx9YvJjbs4Rngc0AaRhND
         1uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5emM3Rv+s+i5KmFmY5Kma29c8NT7iZ5h14sKZDL3uyk=;
        b=k9wlWuySm/JXgkSfol7pmqjUe0wfaOkAtN7q95ZmuSiVv18Xy3CgfjdOXCyYbNP2ws
         GX8y4sOy5PnLG+LOU/t6oWrZ5AcJ3+zOSaFiwrQ9S/FNbIeWPbCs+Tu8RLs2O0wZj4ZR
         sq3A7Psc5PGB9JQDTOI3wBm+xR6yjHfRhnrMUqlYxroXhorfYrs1JHU5PeZVMpJkV0xC
         1OgJ522CIUEJYzyQo++H0mO5sULSbeiIgrg6gMgubVwa0O8/x9UClRcegBwkpMUnwptf
         9Ic6jK9CQBgvUUR5yzWXM0O4s6rLv7zvoV2kG+TBgfhSkmrSOCyZYwPX0GSPpeU/r3oy
         2UmQ==
X-Gm-Message-State: APjAAAVTsjU/A8d7OMqMFAkobvmePfvvn12BtG01Stu8vD7d3djIY3Ny
        ZmHAtfnkxmr9hSnDlDo9wYwjQg==
X-Google-Smtp-Source: APXvYqwFeAdXlBfuUBjHRnB4w6+rUcgr/RbA3uhvc7JYhXWgI3FHF5R4/b2l58xTa/EM2R80XzCOQQ==
X-Received: by 2002:a50:ea8c:: with SMTP id d12mr3928274edo.87.1569507776432;
        Thu, 26 Sep 2019 07:22:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k14sm262230ejp.89.2019.09.26.07.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:22:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BB30C101CFB; Thu, 26 Sep 2019 17:22:58 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:22:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] mm: Allow large pages to be added to the page cache
Message-ID: <20190926142258.tzjqedcbptr4tvg4@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-10-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:08PM -0700, Matthew Wilcox wrote:
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
>  mm/filemap.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bab97addbb1d..afe8f5d95810 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -855,6 +855,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  	int huge = PageHuge(page);
>  	struct mem_cgroup *memcg;
>  	int error;
> +	unsigned int nr = 1;
>  	void *old;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> @@ -866,31 +867,45 @@ static int __add_to_page_cache_locked(struct page *page,
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
> +		if (old)
>  			xas_set_err(&xas, -EEXIST);

This made me confused.

Do we rely on 'old' to be NULL if the loop has completed without 'break'?
It's not very obvious.

Can we have a comment or call xas_set_err() within the loop next to the
'break'?

> -		xas_store(&xas, page);
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
> -		mapping->nrpages++;
> +		mapping->nrexceptional -= exceptional;
> +		mapping->nrpages += nr;
>  
>  		/* hugetlb pages do not participate in page cache accounting */
>  		if (!huge)
> -			__inc_node_page_state(page, NR_FILE_PAGES);
> +			__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES,
> +						nr);

We also need to bump NR_FILE_THPS here.

>  unlock:
>  		xas_unlock_irq(&xas);
>  	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
> @@ -907,7 +922,7 @@ static int __add_to_page_cache_locked(struct page *page,
>  	/* Leave page->index set: truncation relies upon it */
>  	if (!huge)
>  		mem_cgroup_cancel_charge(page, memcg, false);
> -	put_page(page);
> +	page_ref_sub(page, nr);
>  	return xas_error(&xas);
>  }
>  ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
> -- 
> 2.23.0
> 
> 

-- 
 Kirill A. Shutemov
