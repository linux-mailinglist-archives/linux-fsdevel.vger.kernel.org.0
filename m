Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96E645A22D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 13:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhKWMIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 07:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234506AbhKWMIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637669105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10C2btypfwcrFtuMmhHmEu5fFbIpPIsZeEBRh/iSG+U=;
        b=csA8xBpolb+OXjWSjjTdT9+sApuTUSyliTLs1eFGlg4BcHYX2t9jPKAGV00nO7qA+KFBkl
        PV+OhdOk2moESX0OUFYPYjUY3wz92y6u0us3NVnl/NSk7AE5Ql8Qs+RVeqWbcpBOodmow4
        A8IhRouikT3rWq0LKRevqXCAUEITb08=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-F7JsnxWFMrW9TBNrhQhnpg-1; Tue, 23 Nov 2021 07:05:04 -0500
X-MC-Unique: F7JsnxWFMrW9TBNrhQhnpg-1
Received: by mail-wm1-f70.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso955392wmc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 04:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=10C2btypfwcrFtuMmhHmEu5fFbIpPIsZeEBRh/iSG+U=;
        b=a/eqFlY7WY1C2sopbRAjtkjRcVR/vkb2SoitW0dNYCOaUZdOpvmjH70Z4ylVu8oTRm
         t/TfcS0BLG6bgH/5RByMMSOKeCCf5prO5rrfl3tlfISJLrG/rT4+besSHjyU4iy0/SID
         1T85dZ3QkzY2msv0X97N9L4YadVA6dSnlYbpWZUS6iwRBDYcAHEcRE4nNomGC5uHxDX9
         2RtXs8pa3fE/ENCEP/A8yYwQEnGfanAGcOHYbX/nIzcy7sGEQXbARgOZH8BUA5zvZLoK
         Y+YaEbQuH39mbg7wOZO7fwKpRqLSV3r/ry+NsWzh8nEb9qjAqeA991fq+fXEqouead6K
         +a3A==
X-Gm-Message-State: AOAM533co55k52EpX2zobJJFMlQMeWHPv84BA4dw22rWa+LlXK9pxb3T
        86GiiGjj+FyyOi2a27pg3lZJAlRG+C2S8mbAdoIyXJ/5dIGz/S+7t0btihjG6IjW6bDmPkdDuwW
        VODaSn0lqeqdP3iRTpced852Muw==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr2389666wmb.90.1637669103364;
        Tue, 23 Nov 2021 04:05:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLoxWe0qE+FnDLpNv40B8GIz11hsE9XFI/Y9fkJD69fhqkCoyVX155VmOBmNmz+cOprFl9Vg==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr2389644wmb.90.1637669103184;
        Tue, 23 Nov 2021 04:05:03 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id o12sm16660715wrc.85.2021.11.23.04.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 04:05:02 -0800 (PST)
Message-ID: <476868f6-8d32-b8d2-855e-4b19e8a54cc2@redhat.com>
Date:   Tue, 23 Nov 2021 13:05:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20211123000102.4052105-1-almasrymina@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211123000102.4052105-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.11.21 01:01, Mina Almasry wrote:
> Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> address is currently mapped by a transparent huge page or not.  Example
> use case is a process requesting THPs from the kernel (via a huge tmpfs
> mount for example), for a performance critical region of memory.  The
> userspace may want to query whether the kernel is actually backing this
> memory by hugepages or not.
> 
> PM_THP_MAPPED bit is set if the virt address is mapped at the PMD
> level and the underlying page is a transparent huge page.
> 
> A few options were considered:
> 1. Add /proc/pid/pageflags that exports the same info as
>    /proc/kpageflags.  This is not appropriate because many kpageflags are
>    inappropriate to expose to userspace processes.
> 2. Simply get this info from the existing /proc/pid/smaps interface.
>    There are a couple of issues with that:
>    1. /proc/pid/smaps output is human readable and unfriendly to
>       programatically parse.
>    2. /proc/pid/smaps is slow because it must read the whole memory range
>       rather than a small range we care about.  The cost of reading
>       /proc/pid/smaps into userspace buffers is about ~800us per call,
>       and this doesn't include parsing the output to get the information
>       you need. The cost of querying 1 virt address in /proc/pid/pagemaps
>       however is around 5-7us.
> 
> Tested manually by adding logging into transhuge-stress, and by
> allocating THP and querying the PM_THP_MAPPED flag at those
> virtual addresses.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Rientjes rientjes@google.com
> Cc: Paul E. McKenney <paulmckrcu@fb.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> Cc: Florian Schmidt <florian.schmidt@nutanix.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> 
> 
> ---
> 
> Changes in v7:
> - Added clarification that smaps is only slow because it looks at the
>   whole address space.
> 
> Changes in v6:
> - Renamed to PM_THP_MAPPED
> - Removed changes to transhuge-stress
> 
> Changes in v5:
> - Added justification for this interface in the commit message!
> 
> Changes in v4:
> - Removed unnecessary moving of flags variable declaration
> 
> Changes in v3:
> - Renamed PM_THP to PM_HUGE_THP_MAPPING
> - Fixed checks to set PM_HUGE_THP_MAPPING
> - Added PM_HUGE_THP_MAPPING docs
> ---
>  Documentation/admin-guide/mm/pagemap.rst | 3 ++-
>  fs/proc/task_mmu.c                       | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index fdc19fbc10839..8a0f0064ff336 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -23,7 +23,8 @@ There are four components to pagemap:
>      * Bit  56    page exclusively mapped (since 4.2)
>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
> -    * Bits 57-60 zero
> +    * Bit  58    page is a huge (PMD size) THP mapping
> +    * Bits 59-60 zero
>      * Bit  61    page is file-page or shared-anon (since 3.5)
>      * Bit  62    page swapped
>      * Bit  63    page present
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ad667dbc96f5c..d784a97aa209a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1302,6 +1302,7 @@ struct pagemapread {
>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>  #define PM_UFFD_WP		BIT_ULL(57)
> +#define PM_THP_MAPPED		BIT_ULL(58)
>  #define PM_FILE			BIT_ULL(61)
>  #define PM_SWAP			BIT_ULL(62)
>  #define PM_PRESENT		BIT_ULL(63)
> @@ -1456,6 +1457,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  
>  		if (page && page_mapcount(page) == 1)
>  			flags |= PM_MMAP_EXCLUSIVE;
> +		if (page && is_transparent_hugepage(page))
> +			flags |= PM_THP_MAPPED;
>  
>  		for (; addr != end; addr += PAGE_SIZE) {
>  			pagemap_entry_t pme = make_pme(frame, flags);
> 

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

