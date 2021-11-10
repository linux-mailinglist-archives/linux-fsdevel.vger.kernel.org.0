Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAA44BE83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 11:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhKJK1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 05:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhKJK1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636539854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1AM6xM7SxUCC79CInqY7ZFCL0tWuszI3QiZ+cxT6yto=;
        b=eIJCVn+CpDDbIq2BiHls8ghjGIqz2aeS+mqjBHcjMBJOlNGnb642428sgznseSAM0h2SZe
        Wcbtwm4w81bGZBc1FuBTHHUbYcJ43mWa09IqMOa9m1KFFvbzKiBMyqnO6FybMnpBuR8fVu
        Iq0ysXL6Og9HHW2FNPiC0mSVxMvmjy8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-KTpqyeOiOjKbdnzkq7xrZw-1; Wed, 10 Nov 2021 05:24:13 -0500
X-MC-Unique: KTpqyeOiOjKbdnzkq7xrZw-1
Received: by mail-wr1-f71.google.com with SMTP id y9-20020a5d6209000000b001684625427eso317222wru.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 02:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1AM6xM7SxUCC79CInqY7ZFCL0tWuszI3QiZ+cxT6yto=;
        b=md+wKEnOGIIeYOGqIxmL7xocdeIjLk8YeuHIXbMMHpScsi5U1d5ykt+qhau+z0TEMa
         SAwEsqVPl/9/IrQIvyQFJNVOaUNlT/3KK00fQDpdmcmRnZwrqSkLwUX2ayMQ+/XC0yrq
         71mKKx/kMwQDbzJrQy59psiPd9YDfxVSDqlPA/yOqPNhpg60U/0dccpOiEVOaOh8369R
         1HH4XrDzlajRd3atZOgqBzvlVfgJtG8ykZi6H0eSYYM/9u62Nf0HA4diu694stQm+tj1
         aNHQ09zvVsvYZikTZR7L6h5O1cr8Kr7wCu6KdXCUUzTP3obETyklQJUHvyIIv047Uk1C
         PpgA==
X-Gm-Message-State: AOAM533XQLom2/YyKmRrdwhhzIUEPlD1YoS+2Rs4K7J8Hrbn15ctB5F2
        kF9/7xpGlPSHiXATtnvcGJw9yn4eCEH7RFzOfDaHNc/iH8qpJMgkXueXvzKqzmMjR8QnHxSkCg9
        oFDfh8Yc1b4B9Q5Ag8nHiVYLfVg==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr18317963wru.2.1636539852585;
        Wed, 10 Nov 2021 02:24:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX3A+4KVwXJvj7AxWl/jJg0VnnA5Opg1sFCSUSqSFzkdUXNL+FUnsAKgEfveOV4qc00zOx+g==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr18317927wru.2.1636539852386;
        Wed, 10 Nov 2021 02:24:12 -0800 (PST)
Received: from [192.168.3.132] (p5b0c604f.dip0.t-ipconnect.de. [91.12.96.79])
        by smtp.gmail.com with ESMTPSA id p13sm5552185wmi.0.2021.11.10.02.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:24:11 -0800 (PST)
Message-ID: <8032a24c-3800-16e5-41b7-5565e74d3863@redhat.com>
Date:   Wed, 10 Nov 2021 11:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s> <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
 <YYuCaNXikls/9JhS@t490s> <793685d2-be3f-9a74-c9a3-65c486e0ef1f@redhat.com>
 <YYuJd9ZBQiY50dVs@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YYuJd9ZBQiY50dVs@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.11.21 09:57, Peter Xu wrote:
> On Wed, Nov 10, 2021 at 09:30:50AM +0100, David Hildenbrand wrote:
>> On 10.11.21 09:27, Peter Xu wrote:
>>> On Wed, Nov 10, 2021 at 09:14:42AM +0100, David Hildenbrand wrote:
>>>> On 10.11.21 08:03, Peter Xu wrote:
>>>>> Hi, Mina,
>>>>>
>>>>> Sorry to comment late.
>>>>>
>>>>> On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
>>>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>>>>>> index fdc19fbc10839..8a0f0064ff336 100644
>>>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>>>>> @@ -23,7 +23,8 @@ There are four components to pagemap:
>>>>>>      * Bit  56    page exclusively mapped (since 4.2)
>>>>>>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>>>>>>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
>>>>>> -    * Bits 57-60 zero
>>>>>> +    * Bit  58    page is a huge (PMD size) THP mapping
>>>>>> +    * Bits 59-60 zero
>>>>>>      * Bit  61    page is file-page or shared-anon (since 3.5)
>>>>>>      * Bit  62    page swapped
>>>>>>      * Bit  63    page present
>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>>> index ad667dbc96f5c..6f1403f83b310 100644
>>>>>> --- a/fs/proc/task_mmu.c
>>>>>> +++ b/fs/proc/task_mmu.c
>>>>>> @@ -1302,6 +1302,7 @@ struct pagemapread {
>>>>>>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>>>>>>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>>>>>>  #define PM_UFFD_WP		BIT_ULL(57)
>>>>>> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)
>>>>>
>>>>> The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
>>>>> "PM_HUGE" (as THP also means HUGE already)?
>>>>>
>>>>> IMHO the core problem is about permission controls, and it seems to me we're
>>>>> actually trying to workaround it by duplicating some information we have.. so
>>>>> it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
>>>>> if it's the permission part that to be enhanced, rather than a new but slightly
>>>>> duplicated interface.
>>>>
>>>> It's not a permission problem AFAIKS: even with permissions "changed",
>>>> any attempt to use /proc/kpageflags is just racy. Let's not go down that
>>>> path, it's really the wrong mechanism to export to random userspace.
>>>
>>> I agree it's racy, but IMHO that's fine.  These are hints for userspace to make
>>> decisions, they cannot be always right.  Even if we fetch atomically and seeing
>>> that this pte is swapped out, it can be quickly accessed at the same time and
>>> it'll be in-memory again.  Only if we can freeze the whole pgtable but we
>>> can't, so they can only be used as hints.
>>
>> Sorry, I don't think /proc/kpageflags (or exporting the PFNs to random
>> users via /proc/self/pagemap) is the way to go.
>>
>> "Since Linux 4.0 only users with the CAP_SYS_ADMIN capability can get
>> PFNs. In 4.0 and 4.1 opens by unprivileged fail with -EPERM.  Starting
>> from 4.2 the PFN field is zeroed if the user does not have
>> CAP_SYS_ADMIN. Reason: information about PFNs helps in exploiting
>> Rowhammer vulnerability."
> 
> IMHO these are two problems that you mentioned.  That's also what I was
> wondering about: could the app be granted with CAP_SYS_ADMIN then?
> 
> I am not sure whether that'll work well with /proc/kpage* though, as it's by
> default 0400.  So perhaps we need to manual adjust the file permission too to
> make sure the app can both access PFNs (with SYS_ADMIN) and the flags.  Totally
> no expert on the permissions..

Me too :)

IIRC changing permissions that was not an option -- which is why the
first approach suggested a new /proc/self/pageflags. But I guess Mina
can remind us (and eventually document all that in the patch description
:) ).


-- 
Thanks,

David / dhildenb

