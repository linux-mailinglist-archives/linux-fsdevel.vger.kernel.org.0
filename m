Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5016630FD88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 21:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhBDT7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 14:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhBDT6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:58:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8AC06178C;
        Thu,  4 Feb 2021 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0HxWZfz3W3M/WFGpU2ZZhpTfeSKRLfLuDtTHq7CE0OU=; b=ACh73T1wg/Dg0hUSsxqNqCOOWR
        s8BUucN7GMlUn+fePuaIbJux8JCvFS835ypdDs9E6MR0pStE07I6gHd3sKzPKXZsh6AANZQKf7Epg
        TIuC3YGOd/wh8KJN6QA6EWDq8QDZrgiILecJDrxAbEN7Xwsr5fAb3DmsK1khx8u6BS2y6/hte/1Jv
        eqOleqMEg2rwxjnIuVTqpt4s7JrDHgWkcCnbDintkjUmqwIWDsNQsW0D89N6xgaRrC1wjioFpOWZ5
        UNUlLnqud2qviYdAQu+e1KXwO0CL1X4a3i8+4RGNZD0O72WUrt1mqyB7TPPAO20lv1jxUlXft0tRm
        eDJaDcmg==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7klA-0004UU-17; Thu, 04 Feb 2021 19:57:48 +0000
Subject: Re: [PATCH v4 09/10] userfaultfd: update documentation to describe
 minor fault handling
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-10-axelrasmussen@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bb81e2b1-eb6b-0dfb-c2d6-82843d3750e7@infradead.org>
Date:   Thu, 4 Feb 2021 11:57:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210204183433.1431202-10-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Axel-

one typo found:

On 2/4/21 10:34 AM, Axel Rasmussen wrote:
> Reword / reorganize things a little bit into "lists", so new features /
> modes / ioctls can sort of just be appended.

Good plan.

> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 107 ++++++++++++-------
>  1 file changed, 66 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 65eefa66c0ba..cfd3daf59d0e 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst

[snip]

> -
> -Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
> -be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
> -register a memory range in the ``userfaultfd`` by setting the
> +events, except page fault notifications, may be generated:
> +
> +- The ``UFFD_FEATURE_EVENT_*`` flags indicate that various other events
> +  other than page faults are supported. These events are described in more
> +  detail below in the `Non-cooperative userfaultfd`_ section.
> +
> +- ``UFFD_FEATURE_MISSING_HUGETLBFS`` and ``UFFD_FEATURE_MISSING_SHMEM``
> +  indicate that the kernel supports ``UFFDIO_REGISTER_MODE_MISSING``
> +  registrations for hugetlbfs and shared memory (covering all shmem APIs,
> +  i.e. tmpfs, ``IPCSHM``, ``/dev/zero``, ``MAP_SHARED``, ``memfd_create``,
> +  etc) virtual memory areas, respectively.
> +
> +- ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
> +  ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
> +  areas.
> +
> +The userland application should set the feature flags it intends to use

(ah, userspace has moved to userland temporarily. :)

> +when envoking the ``UFFDIO_API`` ioctl, to request that those features be

        invoking

> +enabled if supported.


thanks.
-- 
~Randy

