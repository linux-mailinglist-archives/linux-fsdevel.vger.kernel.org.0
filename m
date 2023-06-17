Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656FD733F08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjFQHOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjFQHON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:14:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DD4213B;
        Sat, 17 Jun 2023 00:14:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666eec46206so556976b3a.3;
        Sat, 17 Jun 2023 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686986051; x=1689578051;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1i7He5Kbp1aVNgVcTn6mnSa9HnbTYwL5h+VE5kZxvRE=;
        b=regMC1h2001emd30POLwhQx9x+BV/EMfI1+S5oUl5OeI9kgbSfm+VQvBooo31tgIt+
         +SR/rpn4YXlHE7CGJQcrEPOUtDpvjvW4mwmx0mCST5qKb0Uy+Dj64oDcKbdP1Sgkc27k
         oOl3SDDrd8IFYfdqRSxAQo6Uyg1hPf6/OpdG7nrxB8dzkmZCwOLETAvWKPUfn77kCSkT
         dhC6TMgl1cnkvUQPpyY3ClXRBhYNzo+pJae017brd+fDiLFHHY60aQG9FHLusnlNg81K
         IjV3sXhqSszdHRPxh9ycVttQAf6vXwiscZIhNsMtPnafmc3WBjHiLlPuqs61sdOD4sNJ
         d4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686986051; x=1689578051;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i7He5Kbp1aVNgVcTn6mnSa9HnbTYwL5h+VE5kZxvRE=;
        b=Js82Ay19dUsIBkIdrq4/+mETQHZBGxV2cbdD369YXUMM0BpCiDAshWt9YWL9Q4Wf67
         xbRqeTZQbES2r6bw/YlS1Jcj2imM02C4O63GGz6CB3nYY8qJMqZRBc9SYCXGo49s+LIT
         ocXv11CXy9FvlSsEgVCg/Wl31RD4ORer5PtX40wHz9zJ2H4nRyYs7GRC6wsE07ibHgrV
         sQaB0n1O0vPipsMt1++WaeHa3pNprNI4zbBak8y/7GxKTioHOwBzb6HYejq1fxpvkc++
         HDPsXgyhgWeJ2v6dSSkTysH5xVDYAA+U5pe0d35f9XVmyc5KcCwyw6GqmchzBjMFU79c
         wPDQ==
X-Gm-Message-State: AC+VfDx2lj9LsFUSlWZZ4BTL6tAxcRqw7qSlhqNrlbx+HptCKSNaBmK5
        JyjZF4/E7YsWy9zTKk8DwTw=
X-Google-Smtp-Source: ACHHUZ5jWdv4Pj3ilPEWX0sNeZN9HNkl7A3D9PORp4+UQzb+V1mG0HoUfOk5LisLKA1UtFOPIAyzqw==
X-Received: by 2002:a17:902:e5d0:b0:1af:babd:7b84 with SMTP id u16-20020a170902e5d000b001afbabd7b84mr4771156plf.41.1686986051391;
        Sat, 17 Jun 2023 00:14:11 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001aad714400asm16814382pls.229.2023.06.17.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 00:14:10 -0700 (PDT)
Date:   Sat, 17 Jun 2023 12:43:59 +0530
Message-Id: <877cs2o91k.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
In-Reply-To: <20230612203910.724378-9-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
> Start at the maximum page cache size and shrink by half every time we
> hit the "we are short on memory" problem.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a5d62c9640cf..818dc350ffc5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -768,6 +768,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
>  	loff_t length = iomap_length(iter);
> +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iter->pos;
>  	ssize_t written = 0;
>  	long status = 0;
> @@ -776,15 +777,13 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  	do {
>  		struct folio *folio;
> -		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		size_t offset;		/* Offset into folio */
> +		unsigned long bytes;	/* Bytes to write to folio */

why not keep typeof "bytes" as size_t same as of "copied".

>  		size_t copied;		/* Bytes copied from user */
>  
> -		offset = offset_in_page(pos);
> -		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
>  again:
> +		offset = pos & (chunk - 1);
> +		bytes = min(chunk - offset, iov_iter_count(i));
>  		status = balance_dirty_pages_ratelimited_flags(mapping,
>  							       bdp_flags);
>  		if (unlikely(status))
> @@ -814,11 +813,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> -		page = folio_file_page(folio, pos >> PAGE_SHIFT);
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
>  		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
>  
> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
>  
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
> @@ -835,6 +837,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			 */
>  			if (copied)
>  				bytes = copied;

I think with your code change which changes the label position of
"again", the above lines doing bytes = copied becomes dead code.
We anyway recalculate bytes after "again" label. 


-ritesh


> +			if (chunk > PAGE_SIZE)
> +				chunk /= 2;
>  			goto again;
>  		}
>  		pos += status;
> -- 
> 2.39.2
