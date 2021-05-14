Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD2380E9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhENRJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:09:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhENRJd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:09:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EAA1B166;
        Fri, 14 May 2021 17:08:21 +0000 (UTC)
Subject: Re: [PATCH v10 14/33] mm/filemap: Add folio_offset and
 folio_file_offset
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-15-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5810b6ba-4b27-ed90-3edb-959da2cf534b@suse.cz>
Date:   Fri, 14 May 2021 19:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-15-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> These are just wrappers around their page counterpart.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/pagemap.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 3b82252d12fc..448a2dfb5ff1 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -558,6 +558,16 @@ static inline loff_t page_file_offset(struct page *page)
>  	return ((loff_t)page_index(page)) << PAGE_SHIFT;
>  }
>  
> +static inline loff_t folio_offset(struct folio *folio)
> +{
> +	return page_offset(&folio->page);
> +}
> +
> +static inline loff_t folio_file_offset(struct folio *folio)
> +{
> +	return page_file_offset(&folio->page);
> +}
> +
>  extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
>  				     unsigned long address);
>  
> 

