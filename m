Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94361367D63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhDVJKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 05:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235690AbhDVJKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619082589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G62r2A54GfDdzdiRe+imbCPlMemqzfVVW4aT0ekamXo=;
        b=dl9XNYBHTKxlduvj1dh0tIh2RgXW/73aRIz852ucW/JTUbCdMhR4vDhEPsU54YNHVtFKSr
        evnI5RFW3yXxa4LxeLf0BbOIiwh7eCcYgUPlTI2qqMx9Hl+7Sgg5oWMq4gLXxN403I44dQ
        uTh48ZfeGenvAxq6WyTcmwC+lCNCb7w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-IVnXtJfeNUmi_BsHMYzleQ-1; Thu, 22 Apr 2021 05:09:47 -0400
X-MC-Unique: IVnXtJfeNUmi_BsHMYzleQ-1
Received: by mail-ed1-f69.google.com with SMTP id d2-20020aa7d6820000b0290384ee872881so12294809edr.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 02:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G62r2A54GfDdzdiRe+imbCPlMemqzfVVW4aT0ekamXo=;
        b=B+fUCTEUcqJCqaKI0CLqwMij/rraAC6FEhu2vnOVQBBsoOV1/r90gvH4Y8pyJQp1zs
         h0M+j4n0/dbJEU966ctd5cjBrL9MD7889jiStQXugtr0PBlDkhhF6Y42oIBCXTAOVjfE
         6V3n/hvmXnBpNNvAKWQB2nvMf4ObXfHocVDogzMzmM+4D8BsEUfj1YFXmhU1QLvR/hoV
         OMuZ+svAzdSCEbLgyGkiJNIpotjKPvrRITYWT6me+YGv5yQ62cLGraNLjEdVtVubXV48
         qQO88zHLcwo8FiBgbSYdsnXCzeGWrQA2vzyd4JnUyOIcUMaqqLK1hYsBT6SxMwpooNUU
         1uuQ==
X-Gm-Message-State: AOAM531SsaPBKz3UYaYhgtyrFT6EtymrqiFOKx0OdWRmZhbXf0/eSaZx
        NAswuTjHGhxT++UnzrwjWJcgzj2qJAD6J4Ah0T7+U1sm8vvFqAnjTYoPzVGAfIWbCmLRYiBAamr
        oqCVb3hJLSTczQJjGU+ExNoFLvGf9Kc/l3qZO+jyF/26p8yPZf+tXUCx0syXVqCVfLg37a9p2mw
        ==
X-Received: by 2002:aa7:d596:: with SMTP id r22mr2545474edq.344.1619082586192;
        Thu, 22 Apr 2021 02:09:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQfaODftOKrJc2tMgSOVDOmiV3CLMhTtE4fTSMHHMlyuJTpjWpd3pf6ZYUB8Y8Z1w+e9veCw==
X-Received: by 2002:aa7:d596:: with SMTP id r22mr2545457edq.344.1619082586009;
        Thu, 22 Apr 2021 02:09:46 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id q19sm1398879ejy.50.2021.04.22.02.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:09:45 -0700 (PDT)
Subject: Re: (in)consistency of page/folio function naming
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210422032051.GM3596236@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ee5148a4-1552-5cf0-5e56-9303311fb2ef@redhat.com>
Date:   Thu, 22 Apr 2021 11:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210422032051.GM3596236@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.04.21 05:20, Matthew Wilcox wrote:
> 
> I'm going through my patch queue implementing peterz's request to rename
> FolioUptodate() as folio_uptodate().  It's going pretty well, but it
> throws into relief all the places where we're not consistent naming
> existing functions which operate on pages as page_foo().  The folio
> conversion is a great opportunity to sort that out.  Mostly so far, I've
> just done s/page/folio/ on function names, but there's the opportunity to
> regularise a lot of them, eg:
> 
> 	put_page		folio_put
> 	lock_page		folio_lock
> 	lock_page_or_retry	folio_lock_or_retry
> 	rotate_reclaimable_page	folio_rotate_reclaimable
> 	end_page_writeback	folio_end_writeback
> 	clear_page_dirty_for_io	folio_clear_dirty_for_io
> 
> Some of these make a lot of sense -- eg when ClearPageDirty has turned
> into folio_clear_dirty(), having folio_clear_dirty_for_io() looks regular.
> I'm not entirely convinced about folio_lock(), but folio_lock_or_retry()
> makes more sense than lock_page_or_retry().  Ditto _killable() or
> _async().
> 
> Thoughts?

I tend to like prefixes: they directly set the topic.

The only thing I'm concerned is that we end up with

put_page vs. folio_put

which is suboptimal.

-- 
Thanks,

David / dhildenb

