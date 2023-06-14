Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E372F378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 06:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbjFNEUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 00:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjFNEU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:20:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2119B1;
        Tue, 13 Jun 2023 21:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=D9e3x9i8rBKYm3toYXDRWUXq9796QOZEiqel4E9RDSQ=; b=ptry9IrRJnz/Kqmd1+0osrL1CQ
        iSA86OAjUouPrH3MIaIdajDF8MeIKN16meKgjfkpQXUtlmG7+YfL6VwgPDRLPo2YUvfn4WZ4hGNI+
        DzkxISScnE7H0Hm70ysbCXZkG6iQcxhJst84nH5UEwSVp4ZS/TyvG8/3/GnsTNa/Nu2+5EXlQruEz
        GAMeK7rfui/COGK3C8/0lpbQYHJB79vqlU7aK02zJhMrzjKLaMKyWXXTnhRilEDJMxPfkuiWHaDVX
        ED9HhmateLa2wPxWCmaSd08C2s/sflld2Y2YwrlC4Ss6MkQRCL/5T8TIGihDngwMXn5db+ottR/U6
        aDuqAwpw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9HzO-009xON-2S;
        Wed, 14 Jun 2023 04:20:10 +0000
Message-ID: <57358041-0e36-deaa-e2ec-06dcfc92ba4d@infradead.org>
Date:   Tue, 13 Jun 2023 21:20:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v18 4/5] mm/pagemap: add documentation of PAGEMAP_SCAN
 IOCTL
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
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
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-5-usama.anjum@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230613102905.2808371-5-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 6/13/23 03:29, Muhammad Usama Anjum wrote:
> Add some explanation and method to use write-protection and written-to
> on memory range.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v16:
> - Update the documentation
> 
> Changes in v11:
> - Add more documentation
> ---
>  Documentation/admin-guide/mm/pagemap.rst | 58 ++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index c8f380271cad..3b977526d4b3 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -227,3 +227,61 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
>  always 12 at most architectures). Since Linux 3.11 their meaning changes
>  after first clear of soft-dirty bits. Since Linux 4.2 they are used for
>  flags unconditionally.
> +
> +Pagemap Scan IOCTL
> +==================
> +
> +The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get or optionally
> +clear the info about page table entries. The following operations are supported
> +in this IOCTL:
> +- Get the information if the pages have been written-to (``PAGE_IS_WRITTEN``),

                                                written to

> +  file mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``) or swapped
> +  (``PAGE_IS_SWAPPED``).
> +- Find pages which have been written-to and/or write protect the pages atomically

                                written to

> +  (atomic ``PM_SCAN_OP_GET + PM_SCAN_OP_WP``)
> +
> +The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
> + 1. The size of the ``struct pm_scan_arg`` must be specified in the ``size``
> +    field. This field will be helpful in recognizing the structure if extensions
> +    are done later.
> + 2. The flags can be specified in the ``flags`` field. The ``PM_SCAN_OP_GET``
> +    and ``PM_SCAN_OP_WP`` are the only added flags at this time.
> + 3. The range is specified through ``start`` and ``len``.
> + 4. The output buffer of ``struct page_region`` array and size is specified in
> +    ``vec`` and ``vec_len``.
> + 5. The optional maximum requested pages are specified in the ``max_pages``.
> + 6. The masks are specified in ``required_mask``, ``anyof_mask``,
> +    ``excluded_ mask`` and ``return_mask``.
> +    1.  To find if ``PAGE_IS_WRITTEN`` flag is set for pages which have
> +        ``PAGE_IS_FILE`` set and ``PAGE_IS_SWAPPED`` un-set, ``required_mask``

                                                        unset,

> +        is set to ``PAGE_IS_FILE``, ``exclude_mask`` is set to
> +        ``PAGE_IS_SWAPPED`` and ``return_mask`` is set to ``PAGE_IS_WRITTEN``.
> +        The output buffer in ``vec`` and length must be specified in ``vec_len``.
> +    2. To find pages which have either ``PAGE_IS_FILE`` or ``PAGE_IS_SWAPPED``
> +       set, ``anyof_masks`` is set to  ``PAGE_IS_FILE | PAGE_IS_SWAPPED``.
> +    3. To find written pages and engage write protect, ``PAGE_IS_WRITTEN`` is
> +       specified in ``required_mask`` and ``return_mask``. In addition to
> +       specifying the output buffer in ``vec`` and length in ``vec_len``, the
> +       ``PM_SCAN_OP_WP`` is specified in ``flags`` to perform write protect
> +       on the range as well.
> +
> +The ``PAGE_IS_WRITTEN`` flag can be considered as the better and correct
> +alternative of soft-dirty flag. It doesn't get affected by household chores (VMA

                                                              housekeeping ?

> +merging) of the kernel and hence the user can find the true soft-dirty pages
> +only. This IOCTL adds the atomic way to find which pages have been written and
> +write protect those pages again. This kind of operation is needed to efficiently
> +find out which pages have changed in the memory.
> +
> +To get information about which pages have been written-to or optionally write

                                                  written to

> +protect the pages, following must be performed first in order:
> + 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
> + 2. The ``UFFD_FEATURE_WP_UNPOPULATED`` and ``UFFD_FEATURE_WP_ASYNC`` features
> +    are set by ``UFFDIO_API`` IOCTL.
> + 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
> +    through ``UFFDIO_REGISTER`` IOCTL.
> + 4. Then the any part of the registered memory or the whole memory region must

            "the" or "any". Probably "any". Not both.

> +    be write protected using ``PAGEMAP_SCAN`` IOCTL with flag ``PM_SCAN_OP_WP``
> +    or the ``UFFDIO_WRITEPROTECT`` IOCTL can be used. Both of these perform the
> +    same operation. The former is better in terms of performance.
> + 5. Now the ``PAGEMAP_SCAN`` IOCTL can be used to either just find pages which
> +    have been written-to and/or optionally write protect the pages as well.

                 written to


-- 
~Randy
