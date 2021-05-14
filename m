Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D2380783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhENKlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 06:41:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:50432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhENKlR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 06:41:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B69FAF11;
        Fri, 14 May 2021 10:40:05 +0000 (UTC)
Subject: Re: [PATCH v10 01/33] mm: Introduce struct folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-2-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ad8cd2e7-4111-f523-bc9c-5702b9071a5f@suse.cz>
Date:   Fri, 14 May 2021 12:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> +/**
> + * folio_page - Return a page from a folio.
> + * @folio: The folio.
> + * @n: The page number to return.
> + *
> + * @n is relative to the start of the folio.  It should be between
> + * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
> + */
> +#define folio_page(folio, n)	nth_page(&(folio)->page, n)

BTW, would it make sense to have also a folio_page(folio) wrapper? Or is
"&folio->page" used in later patches sufficiently elegant and stable enough for
the future?

>  static __always_inline int PageTail(struct page *page)
>  {
>  	return READ_ONCE(page->compound_head) & 1;
> 

