Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF50C30FF13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 22:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhBDVJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 16:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBDVJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:09:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757BC0613D6;
        Thu,  4 Feb 2021 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/6flMUs4q/9e4K9Y4oNKr3UzQiLVqc1VXmMcTE8n99U=; b=1MUnI9zX+7iDTvEFR0Pt6icYxu
        mZ0ZyOaeDZsskWkqJeU7vtB0JnCkIOLZyfNXASIxi0b4QTf5IaRht1p94TCyh3zegg2ykVxwoY5Zh
        +unY6QrqC1Mr60qKAWBi0wN/j8dzfalXVyy2Itpw/nxhPi4S4KqVafbacIx5ejEXJoTmPZBz24wVA
        O/DZiE8A+2YvwFWzzW94kinajywJXZCDfRceMOxs3+LCZbtohSXpQ4seC/yBmnE8fTy3PL4xfE8ed
        X+2ju8NWiVdnoHmvi2aIjYxPzuPcRnLVZ8SdWx4pl+NwEn8QDhZ36x13b8CqXDTCX1T5yxCLcVoF9
        sAGB1qSg==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7lrD-00043v-4y; Thu, 04 Feb 2021 21:08:07 +0000
Subject: Re: [PATCH v4 09/10] userfaultfd: update documentation to describe
 minor fault handling
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-10-axelrasmussen@google.com>
 <bb81e2b1-eb6b-0dfb-c2d6-82843d3750e7@infradead.org>
 <CAJHvVchiABBitTRkr4boSj7pkBN3_y7-1kLVxyhCo5w4m=PEEA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d457b1bf-023a-89c0-fad0-c61b2792dfb3@infradead.org>
Date:   Thu, 4 Feb 2021 13:07:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJHvVchiABBitTRkr4boSj7pkBN3_y7-1kLVxyhCo5w4m=PEEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/21 1:04 PM, Axel Rasmussen wrote:
> On Thu, Feb 4, 2021 at 11:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi Axel-
>>
>> one typo found:
>>
>> On 2/4/21 10:34 AM, Axel Rasmussen wrote:
>>> Reword / reorganize things a little bit into "lists", so new features /
>>> modes / ioctls can sort of just be appended.
>>
>> Good plan.
>>
>>>
>>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>>> ---
>>>  Documentation/admin-guide/mm/userfaultfd.rst | 107 ++++++++++++-------
>>>  1 file changed, 66 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
>>> index 65eefa66c0ba..cfd3daf59d0e 100644
>>> --- a/Documentation/admin-guide/mm/userfaultfd.rst
>>> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
>>
>> [snip]
>>
>>> -
>>> -Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
>>> -be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
>>> -register a memory range in the ``userfaultfd`` by setting the
>>> +events, except page fault notifications, may be generated:
>>> +
>>> +- The ``UFFD_FEATURE_EVENT_*`` flags indicate that various other events
>>> +  other than page faults are supported. These events are described in more
>>> +  detail below in the `Non-cooperative userfaultfd`_ section.
>>> +
>>> +- ``UFFD_FEATURE_MISSING_HUGETLBFS`` and ``UFFD_FEATURE_MISSING_SHMEM``
>>> +  indicate that the kernel supports ``UFFDIO_REGISTER_MODE_MISSING``
>>> +  registrations for hugetlbfs and shared memory (covering all shmem APIs,
>>> +  i.e. tmpfs, ``IPCSHM``, ``/dev/zero``, ``MAP_SHARED``, ``memfd_create``,
>>> +  etc) virtual memory areas, respectively.
>>> +
>>> +- ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
>>> +  ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
>>> +  areas.
>>> +
>>> +The userland application should set the feature flags it intends to use
>>
>> (ah, userspace has moved to userland temporarily. :)
> 
> For better or worse, other parts of the document I'm not touching also
> use this wording. Maybe we should s/userland/userspace/g, but perhaps
> better done as a separate commit to keep this diff focused?
> Anecdotally, the use of "userland" doesn't seem to be completely
> unprecedented (e.g. grep -r "userland" | wc -l yields 566 matches in
> the kernel tree).
> 
> I don't have strong feelings, and I was amused by picturing some
> Shire-esque countryside with a friendly sign that reads: ~userland
> welcomes you~. :)

I'm OK with not changing it. Up to you.

-- 
~Randy

