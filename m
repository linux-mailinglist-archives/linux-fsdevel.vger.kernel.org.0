Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D9779539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjHKQwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjHKQwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:52:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B16930DF;
        Fri, 11 Aug 2023 09:52:21 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C07B660724E;
        Fri, 11 Aug 2023 17:52:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691772739;
        bh=cJDpSEZxlvhurhUAGfOasu425SbOowOI0HNqe2vHqeo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=meOVd+WllbvxSa+vTR+OBY1oYnYFhopr636PpY8Sfkq8nFpU9jcg33RG5oft82yVi
         5Io5fTTbN1LqLO7RwRxA4q3adfuMxDf0GAnL7HJAVBLpfqoa1zCKNjY9CSrsrO7A0s
         kT7QjmeldaPrsK03ewt4f3FqUFiSLlCe/PuGwmc30W9JC4envtKRsl/MiFO+OT5Xwv
         ksLyqf5iv/jMYppexgVSA+Lyq57urM84XpeT86/DCJ92iVxy5l0ggG6XbqAifybRc+
         1fj/8LU/VR5VxQzxqlBzBobnCb+wQJl3yyytLCGvb3BEHvi8jyP0TpEnrJrXMhEDBt
         4ij4UiROvONAA==
Message-ID: <a087cea7-1a71-331f-48a4-b53a387e6f4b@collabora.com>
Date:   Fri, 11 Aug 2023 21:52:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v28 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN
 IOCTL
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
 <20230809061603.1969154-6-usama.anjum@collabora.com>
 <CABb0KFGftHi1t3Pt8V3XvsG=+-hvfQMMteW9VXEPrRmfUdZZWA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGftHi1t3Pt8V3XvsG=+-hvfQMMteW9VXEPrRmfUdZZWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/23 12:26 AM, Michał Mirosław wrote:
> On Wed, 9 Aug 2023 at 08:16, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> Add some explanation and method to use write-protection and written-to
>> on memory range.
> [...]
>> --- a/Documentation/admin-guide/mm/pagemap.rst
>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>> @@ -227,3 +227,67 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
>>  always 12 at most architectures). Since Linux 3.11 their meaning changes
>>  after first clear of soft-dirty bits. Since Linux 4.2 they are used for
>>  flags unconditionally.
>> +
>> +Pagemap Scan IOCTL
>> +==================
>> +
>> +The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get or optionally
>> +clear the info about page table entries. The following operations are supported
>> +in this IOCTL:
>> +- Get the information if the pages have Async Write-Protection enabled
>> +  (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), file mapped
>> +  (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped (``PAGE_IS_SWAPPED``)
>> +  or page has pfn zero (``PAGE_IS_PFNZERO``).
> 
> A recent addition -- PAGE_IS_HUGE -- is missing.
> 
> BTW, it could be easier to understand if the page categories were
> separated from the operation description and listed so that each has
> its own line and maybe a longer description where needed.
I've made 90% of changes you have asked in documentation.

> 
>> +- Find pages which have been written to and/or write protect
>> +  (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages atomically.
>> +  The (``PM_SCAN_WP_MATCHING``) is used to WP the matched pages. The
>> +  (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if non-Async-Write-Protected
>> +  pages are found.
> 
> The operation the IOCTL does now is: "scan the process page tables and
> report memory ranges matching provided criteria '.
> Flags extend the operation: "PM_SCAN_WP_MATCHING write protects the
> memory reported" (it does it atomically, but this is just an
> optimization, isn't it? A process could gather the ranges, WP them,
> and then copy.)
> "PM_SCAN_CHECK_WPASYNC" aborts the scan early if a non-WP-able
> matching page is found.
> 
>> +The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
>> + 1. The size of the ``struct pm_scan_arg`` must be specified in the ``size``
>> +    field. This field will be helpful in recognizing the structure if extensions
>> +    are done later.
>> + 2. The flags can be specified in the ``flags`` field. The ``PM_SCAN_WP_MATCHING``
>> +    and ``PM_SCAN_CHECK_WPASYNC`` are the only added flags at this time. The get
>> +    operation is optionally performed depending upon if the output buffer is
>> +    provided or not.
>> + 3. The range is specified through ``start`` and ``end``.
>> + 4. The output buffer of ``struct page_region`` array and size is specified in
>> +    ``vec`` and ``vec_len``.
>> + 5. The optional maximum requested pages are specified in the ``max_pages``.
>> + 6. The masks are specified in ``category_mask``, ``category_anyof_mask``,
>> +    ``category_inverted`` and ``return_mask``.
>> +    1.  To find if ``PAGE_IS_WRITTEN`` flag is set for pages which have
>> +        ``PAGE_IS_FILE`` set and ``PAGE_IS_SWAPPED`` unset, ``category_mask``
>> +        is set to ``PAGE_IS_FILE | PAGE_IS_SWAPPED``, ``category_inverted`` is
>> +        set to ``PAGE_IS_SWAPPED`` and ``return_mask`` is set to ``PAGE_IS_WRITTEN``.
>> +        The output buffer in ``vec`` and length must be specified in ``vec_len``.
>> +    2. To find pages which have either ``PAGE_IS_FILE`` or ``PAGE_IS_SWAPPED``
>> +       set, ``category_anyof_mask`` is set to  ``PAGE_IS_FILE | PAGE_IS_SWAPPED``.
>> +    3. To find written pages and engage write protect, ``PAGE_IS_WRITTEN`` is
>> +       specified in ``category_mask`` and ``return_mask``. In addition to
>> +       specifying the output buffer in ``vec`` and length in ``vec_len``, the
>> +       ``PM_SCAN_WP_MATCHING`` is specified in ``flags`` to perform write protect
>> +       on the range as well.
> 
> Could this be rewritten as examples? E.g.:
> 
> Finding dirty file-backed pages:
> 
> struct pm_scan_arg arg = {
>  .size = sizeof(arg),
>   .flags = 0,
>  ...
>    .category_mask = ...,
>    .return_mask = ...
> };
> ssize_t n = ioctl(..., &arg);
> 
> Find dirty pages and write protect them in the same call:
> 
> arg = { ... };
> do {
>   ... ioctl(...)
> } while(...);
> 
> (The code snippets heavily commented.)
> 
>> +The ``PAGE_IS_WRITTEN`` flag can be considered as the better and correct
> 
> "as a better-performing alternative"
> 
>> +alternative of soft-dirty flag. It doesn't get affected by housekeeping chores
>> +(VMA merging) of the kernel and hence the user can find the true soft-dirty pages
>> +only.
> 
> This is still an optimization, e.g. in THP case there might be too
> many pages reported?
> 
>> + This IOCTL adds the atomic way to find which pages have been written and
>> +write protect those pages again. This kind of operation is needed to efficiently
>> +find out which pages have changed in the memory.
> 
> This repeats the description of PM_SCAN_WP_MATCHING -- I suggest
> removing this part.
> 
>> +To get information about which pages have been written to or optionally write
>> +protect the pages, following must be performed first in order:
> 
> "PAGE_IS_WRITTEN" category is used with uffd write protect-enabled
> ranges to implement memory dirty tracking in userspace:
> 
>> + 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
>> + 2. The ``UFFD_FEATURE_WP_UNPOPULATED`` and ``UFFD_FEATURE_WP_ASYNC`` features
>> +    are set by ``UFFDIO_API`` IOCTL.
>> + 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
>> +    through ``UFFDIO_REGISTER`` IOCTL.
>> + 4. Then any part of the registered memory or the whole memory region must
>> +    be write protected using ``PAGEMAP_SCAN`` IOCTL with flag ``PM_SCAN_OP_WP``
>> +    or the ``UFFDIO_WRITEPROTECT`` IOCTL can be used. Both of these perform the
>> +    same operation. The former is better in terms of performance.
> 
> I guess that the UFFD performance could be fixed? But this part refers
> to the old PM_SCAN_OP_WP, so an updated example is needed.
> 
>> + 5. Now the ``PAGEMAP_SCAN`` IOCTL can be used to either just find pages which
>> +    have been written to and/or optionally write protect the pages as well.
> 
> "find the pages written to since they were last write protected", but
> this sounds contradicting: we look for pages that were WP but written
> anyway. (IOW: marking write-protected is an implementation detail -
> the ioctl is to find pages that changed since they were last marked.)
> Maybe we should call the operation "marking CLEAN" or alike?
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
