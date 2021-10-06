Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD84247CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhJFURI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 16:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbhJFURH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633551314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/U2tYxVxsPynDsuDE3Ges1cZfLv0m8gNxqlOCizQNIE=;
        b=Jp8D0SqsWbOsK7xhbMVzWhf9q+pJIQb36P4akAxOBJF57YooyyCDrX8wKnCURolJnK1a8A
        yH3OxeE/UHH68tn5g81R+qBZkaICiRvNn7Npa8k73RljEeIH2i6RzP7/s8rqos7tf1JCWy
        4bZf5KmJEGG6TEQBoq8YQL4A0DqKRkQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-Lqxh4Z22PfCaE95bPS476Q-1; Wed, 06 Oct 2021 16:15:13 -0400
X-MC-Unique: Lqxh4Z22PfCaE95bPS476Q-1
Received: by mail-qk1-f198.google.com with SMTP id bm12-20020a05620a198c00b00432e14ddb99so3042574qkb.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 13:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/U2tYxVxsPynDsuDE3Ges1cZfLv0m8gNxqlOCizQNIE=;
        b=FBZRjNjxAlzz86wV8zY0myyNv6FKP+opeBLc06GoWCdBO+0PeU1QPStndIe+/xaEOl
         BmMxlpYh6XyIl+2uaIzC3G9Ucnvh30NSPQLMQ1iFzL0yakoljJaCRx5T7gCZLzXf47KR
         /2EYM+NRBu0fKPnEjKWrZ63vFDh4KKNrbJWBW4kb/bXmfhuMQZ6ODJBkI5EgILghKBoE
         SFd2RQhmf/prQZ/th1EpKF+j87jY2t9X9cKlidyULcqL9NwbSauYJ3p7QMvdJMf+UwCo
         kkOW/qwVQ3cCvqR7pVboLtpqLDiqd+RLLc64m7ckdsILkUWlZRgGR05V6bN0Su/f8Mto
         /h8Q==
X-Gm-Message-State: AOAM532fjQqnhtkfrVOd7G5IYBaM12bOWwodAMjbHHwFnWOTOfgTt85I
        iojWMzMlbOfSBI2b+S4bgnXnETg2jspKr4qEzyXmVpVvA/LQVY2dYMHNjEEvxQfGQIiIZ0bhxL3
        s6dgU2y8XBObCVaQI4IdNm8Eo2g==
X-Received: by 2002:a37:48c:: with SMTP id 134mr100796qke.233.1633551313459;
        Wed, 06 Oct 2021 13:15:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyABKk/9Kv5nK/n8wDOgt5wHwzEBYKofFmU30gYxiWgdXVd9pFaNq3S6Bq1e4aIY9E2QEcyUw==
X-Received: by 2002:a37:48c:: with SMTP id 134mr100776qke.233.1633551313175;
        Wed, 06 Oct 2021 13:15:13 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id b19sm1531437qto.46.2021.10.06.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:15:12 -0700 (PDT)
Date:   Wed, 6 Oct 2021 16:15:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YV4Dz3y4NXhtqd6V@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> @@ -1148,8 +1148,12 @@ static int __get_hwpoison_page(struct page *page)
>  		return -EBUSY;
>  
>  	if (get_page_unless_zero(head)) {
> -		if (head == compound_head(page))
> +		if (head == compound_head(page)) {
> +			if (PageTransHuge(head))
> +				SetPageHasHWPoisoned(head);
> +
>  			return 1;
> +		}
>  
>  		pr_info("Memory failure: %#lx cannot catch tail\n",
>  			page_to_pfn(page));

Sorry for the late comments.

I'm wondering whether it's ideal to set this bit here, as get_hwpoison_page()
sounds like a pure helper to get a refcount out of a sane hwpoisoned page.  I'm
afraid there can be side effect that we set this without being noticed, so I'm
also wondering we should keep it in memory_failure().

Quotting comments for get_hwpoison_page():

 * get_hwpoison_page() takes a page refcount of an error page to handle memory
 * error on it, after checking that the error page is in a well-defined state
 * (defined as a page-type we can successfully handle the memor error on it,
 * such as LRU page and hugetlb page).

For example, I see that both unpoison_memory() and soft_offline_page() will
call it too, does it mean that we'll also set the bits e.g. even when we want
to inject an unpoison event too?

Thanks,

-- 
Peter Xu

