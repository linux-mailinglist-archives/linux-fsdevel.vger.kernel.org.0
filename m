Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D561A435B91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJUHXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 03:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhJUHXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634800881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbiMCdPk4CEnFtd1xtVopkXI3HjYso6lcRUCflFZfhw=;
        b=Qubna12ypEZ50Yt1k/G/7nwXQ6Tpr51bfbqBf+WI1hZpkI6ls/L0oqyCN9qnt7lxU+fsxJ
        30NMvYd1tvRjyaPn0Yl3XeX99qp856nUNYU5dh4eNh7SBRiI3eC/9/CCOVEftoEfk+qn6z
        8Qh2X++VEThEObxppzhISEeabgNPLQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-1j79eOxCPaybtP2PJr_mGA-1; Thu, 21 Oct 2021 03:21:20 -0400
X-MC-Unique: 1j79eOxCPaybtP2PJr_mGA-1
Received: by mail-wm1-f70.google.com with SMTP id n9-20020a1c7209000000b0030da7d466b8so4056172wmc.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 00:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xbiMCdPk4CEnFtd1xtVopkXI3HjYso6lcRUCflFZfhw=;
        b=YpXjZgJfX2TTP8LOK19izwmGPoufsIea5HmAvpqJj0Zi/RTzyfeqBNwKVCq2W5LB82
         lXlnXx/5C6DRANAzFv3Z7rPuhNpAyJPkbR6FeQfJgHWA+XDlMyU3zQDPLiJkPsxgzfPo
         Bt5eZSVU51fQKxeuhFn7YX6OyYuDqlOggTE+Krvg+jhf6F8Z3wPSBmVXe9syAC9/a5Y+
         U7NUwhppDpgfeVE10qeEX2CPWW1NaUosbUK2S420t3lhJ+yFcPPnrYnZlr4o1b244XpR
         SdatRhm+ltpExEL9VqdAwoxQvK9OCtk0dF2pxsU/ZJ9O669sbNorYsjopEqRGZhLMyc5
         koPQ==
X-Gm-Message-State: AOAM530Juebbnzcrt9dgHx9fsnrUCRaucgT5eSfyxzuVq2HVHwAMFCVs
        jbSelUZ5GOh/TdvZHpuJRQXVqT5qa1iA9aTtktUYOayYTUw5URilHtGREboeGrgVt2Sx4SUwaNd
        EVo3CWuB9QMz9aXTnffke/V+EKw==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr1793760wri.8.1634800878869;
        Thu, 21 Oct 2021 00:21:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxxym2D+JRIWHIru6Ae9Fw3KKewTwDtEVGqqzNoEEwHXfYycIoHeYKsjh4hMZVx/AHj6lPGg==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr1793737wri.8.1634800878636;
        Thu, 21 Oct 2021 00:21:18 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id u16sm6265534wmc.21.2021.10.21.00.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 00:21:18 -0700 (PDT)
Message-ID: <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
Date:   Thu, 21 Oct 2021 09:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org> <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org> <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
 <YXEOCIWKEcUOvVtv@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YXEOCIWKEcUOvVtv@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21.10.21 08:51, Christoph Hellwig wrote:
> On Wed, Oct 20, 2021 at 08:04:56PM +0200, David Hildenbrand wrote:
>> real): assume we have to add a field for handling something about anon
>> THP in the struct page (let's assume in the head page for simplicity).
>> Where would we add it? To "struct folio" and expose it to all other
>> folios that don't really need it because it's so special? To "struct
>> page" where it actually doesn't belong after all the discussions? And if
>> we would have to move that field it into a tail page, it would get even
>> more "tricky".
>>
>> Of course, we could let all special types inherit from "struct folio",
>> which inherit from "struct page" ... but I am not convinced that we
>> actually want that. After all, we're C programmers ;)
>>
>> But enough with another side-discussion :)
> 
> FYI, with my block and direct I/O developer hat on I really, really
> want to have the folio for both file and anon pages.  Because to make
> the get_user_pages path a _lot_ more efficient it should store folios.
> And to make that work I need them to work for file and anon pages
> because for get_user_pages and related code they are treated exactly
> the same.

Thanks, I can understand that. And IMHO that would be even possible with
split types; the function prototype will simply have to look a little
more fancy instead of replacing "struct page" by "struct folio". :)

-- 
Thanks,

David / dhildenb

