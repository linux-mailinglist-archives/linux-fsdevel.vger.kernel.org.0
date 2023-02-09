Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE669690D83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 16:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjBIPsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 10:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBIPsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:48:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308165682;
        Thu,  9 Feb 2023 07:47:58 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D07DE6600013;
        Thu,  9 Feb 2023 15:47:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675957676;
        bh=DZlQ60CxgLl8n6XS8Qgeqipg0PlBKRTKHQKI1pQjHGI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=a0yvuy7eszjWUVLqHWLpROKH/zxy11KfPX34pPiLc8JCDbGxHCvg9qy99rQuL0OhI
         K97C/BTsW88Riniwr8O2TBZmJlM/XI/X3vtGD9D7a9iiI2aMs5xHyknhQsiDblF+vx
         z8UX+xcux21XZ4IFxBNxDFqh4W578bvRPOwhawHAz1h+GX+HpGtPse1o1tXKgpFgQT
         b7A6IZQjR7l1REdDbIitkGGsGWmnbwueoLdG5cZeer+QIQ5LaBIBR/w4ntJEwrvIg8
         is9DhcEJ4+Sv+hIC7BbJpEYKoKL3K+UXYiSmVqX4ol9NUjz+bybkwvioYZdPg9FJHA
         BopMV6BZ+VGiw==
Message-ID: <37c563dc-18c0-6eb9-dfb8-fd0e89988075@collabora.com>
Date:   Thu, 9 Feb 2023 20:47:42 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
Subject: Re: [PATCH v10 2/6] userfaultfd: update documentation to describe
 UFFD_FEATURE_WP_ASYNC
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-3-usama.anjum@collabora.com> <Y+QUqrBCwQntpxFx@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+QUqrBCwQntpxFx@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/23 2:31 AM, Peter Xu wrote:
> On Thu, Feb 02, 2023 at 04:29:11PM +0500, Muhammad Usama Anjum wrote:
>> Explain the difference created by UFFD_FEATURE_WP_ASYNC to the write
>> protection (UFFDIO_WRITEPROTECT_MODE_WP) mode.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  Documentation/admin-guide/mm/userfaultfd.rst | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
>> index 83f31919ebb3..4747e7bd5b26 100644
>> --- a/Documentation/admin-guide/mm/userfaultfd.rst
>> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
>> @@ -221,6 +221,13 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
>>  you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
>>  used.
>>  
>> +If ``UFFD_FEATURE_WP_ASYNC`` is set while calling ``UFFDIO_API`` ioctl, the
>> +behaviour of ``UFFDIO_WRITEPROTECT_MODE_WP`` changes such that faults for
> 
> UFFDIO_WRITEPROTECT_MODE_WP is only a flag in UFFDIO_WRITEPROTECT, while
> it's forbidden only when not specified.
> 
>> +anon and shmem are resolved automatically by the kernel instead of sending
>> +the message to the userfaultfd. The hugetlb isn't supported. The ``pagemap``
>> +file can be read to find which pages have ``PM_UFFD_WP`` flag set which
>> +means they are write-protected.
> 
> Here's my version. Please feel free to do modifications on top.
> 
>   If the userfaultfd context (that has ``UFFDIO_REGISTER_MODE_WP``
>   registered against) has ``UFFD_FEATURE_WP_ASYNC`` feature enabled, it
>   will work in async write protection mode.  It can be seen as a more
>   accurate version of soft-dirty tracking, meanwhile the results will not
>   be easily affected by other operations like vma merging.
> 
>   Comparing to the generic mode, the async mode will not generate any
>   userfaultfd message when the protected memory range is written.  Instead,
>   the kernel will automatically resolve the page fault immediately by
>   dropping the uffd-wp bit in the pgtables.  The user app can collect the
>   "written/dirty" status by looking up the uffd-wp bit for the pages being
>   interested in /proc/pagemap.
> 
>   The page will be under track of uffd-wp async mode until the page is
>   explicitly write-protected by ``UFFDIO_WRITEPROTECT`` ioctl with the mode
>   flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
>   that was tracked by async mode userfaultfd-wp is invalid.
> 
>   Currently ``UFFD_FEATURE_WP_ASYNC`` only support anonymous and shmem.
>   Hugetlb is not yet supported.
> 
It'll get replaced the documentation. I'll add a suggested by tag as well.
Thanks.

-- 
BR,
Muhammad Usama Anjum
