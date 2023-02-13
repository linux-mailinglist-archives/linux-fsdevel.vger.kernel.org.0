Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F869435F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 11:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBMKqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 05:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBMKq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:46:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD1017CE6;
        Mon, 13 Feb 2023 02:45:56 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52B43660210A;
        Mon, 13 Feb 2023 10:44:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676285100;
        bh=rFkR6He2/D7jQAmT+MR3vtWZDzSsN2bw42gGtGr6rVg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DkbzWwYhAeY8Fk994zFJ9wdOCf6fh4VbSbfaGFd+KnglkqtWyNTpCG3nUy4+Wwzxf
         ql7ZNTdPN6jsOIFVpIqvT0KD/diMMHPupvPM7y3WBaiJje7xAO03ZBmidGzFOrA18s
         7fgmPgLtrQAkfjthYcyWCMRkHCw3k1SoBytBa/fz+wdAHs6o6iJbLPwaaIKdDmW3VL
         oFM943VJWOS0IpZDvwLbHaJhbrceTDF0dQu1lGm4Pq2dljtZOY8KcmJKFgN6gq58mb
         1HQMRZ4rPbyUHn6ragP+qxa/Dycyu9MuvHCK0zJQn9r3oBE4tzojh0ki07JY+7g+JX
         61rJmBeKnE+wg==
Message-ID: <83382901-6d0b-b38f-27cd-3a45259eee85@collabora.com>
Date:   Mon, 13 Feb 2023 15:44:48 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN
 IOCTL
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-6-usama.anjum@collabora.com> <Y+VI8HfM1k3uPA5t@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+VI8HfM1k3uPA5t@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/23 12:26 AM, Peter Xu wrote:
> On Thu, Feb 02, 2023 at 04:29:14PM +0500, Muhammad Usama Anjum wrote:
>> Add some explanation and method to use write-protection and written-to
>> on memory range.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  Documentation/admin-guide/mm/pagemap.rst | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>> index 6e2e416af783..1cb2189e9a0d 100644
>> --- a/Documentation/admin-guide/mm/pagemap.rst
>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>> @@ -230,3 +230,27 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
>>  always 12 at most architectures). Since Linux 3.11 their meaning changes
>>  after first clear of soft-dirty bits. Since Linux 4.2 they are used for
>>  flags unconditionally.
>> +
>> +Pagemap Scan IOCTL
>> +==================
>> +
>> +The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get and/or clear
>> +the info about page table entries. The following operations are supported in
>> +this IOCTL:
>> +- Get the information if the pages have been written-to (``PAGE_IS_WRITTEN``),
>> +  file mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``) or swapped
>> +  (``PAGE_IS_SWAPPED``).
>> +- Write-protect the pages (``PAGEMAP_WP_ENGAGE``) to start finding which
>> +  pages have been written-to.
>> +- Find pages which have been written-to and write protect the pages
>> +  (atomic ``PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE``)
> 
> Could we extend this section a bit more?  Some points for reference:
> 
>   - The new struct you introduced, definitions of each of the fields, and
>     generic use cases for each of the field/ops.
> 
>   - It'll be nice to list the OPs the new interface supports (GET,
>     WP_ENGAGE, GET+WP_ENGAGE).
> 
>   - When should people use this rather than the old pagemap interface?
>     What's the major problems to solve / what's the major difference?
>     (Maybe nice to reference the Windows API too here)
I'll update the documentation.

> 
>> +
>> +To get information about which pages have been written-to and/or write protect
>> +the pages, following must be performed first in order:
>> + 1. The userfaultfd file descriptor is created with ``userfaultfd`` syscall.
>> + 2. The ``UFFD_FEATURE_WP_ASYNC`` feature is set by ``UFFDIO_API`` IOCTL.
>> + 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
>> +    through ``UFFDIO_REGISTER`` IOCTL.
>> +Then the any part of the registered memory or the whole memory region can be
>> +write protected using the ``UFFDIO_WRITEPROTECT`` IOCTL or ``PAGEMAP_SCAN``
>> +IOCTL.
> 
> This part looks good.
> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
