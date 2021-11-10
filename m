Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430CF44BCE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 09:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhKJIdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 03:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbhKJIdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636533056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayTHtFS6vxG5PWHe3XGZ+Bm3dOMLAgqt3D/qHsMzfog=;
        b=RYAOpQQNGdaEu9ilgY0JRqOPOaeYJgi9E7G7GcykkN1zqwBRVBZzvC9pku/nQceb6QlvVt
        qFSUDb2VNPll0t5Oa0oXYWyt/GNM5itg1gufC/ij9b7/jzINDekpmbEEYzl91HZDJE2T+3
        UF+A2W7+q3pn4lhhqb4Q0Jkz763XVDs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-LF-DacV8M7ODtjwO7ZDGRQ-1; Wed, 10 Nov 2021 03:30:54 -0500
X-MC-Unique: LF-DacV8M7ODtjwO7ZDGRQ-1
Received: by mail-wm1-f69.google.com with SMTP id g80-20020a1c2053000000b003331a764709so2756012wmg.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 00:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ayTHtFS6vxG5PWHe3XGZ+Bm3dOMLAgqt3D/qHsMzfog=;
        b=l+l0DhfxLHA/HdHV5aDJUrZqgOr4+zMAiFapH4UUvne9GtwSwPD23r1nPquDmhS/d/
         sv8KfMlM3NHFLCYNmu/RqgrYFX8S4e0kH9g2hYXYZdgBVpR6/lar8TNlMvJ2m5hDKD5Z
         GlR0+ISw8XwzbC3IetKCFncV5ZeY6/tOa3Le68FGBhN6gymioww2+1vtGdTtmM7q1Rpy
         0YrNyLicN1y2IRdoBQdMHLgjWsKz7MxaouljvSmvW2I4o9GcUhgqeK6lXcTGc4cgCQjP
         9DsbouBOReWEegHw4exfy1Xy9Vj1fnuJvdACkbJ/mLBKXMRtgpTKiG6A7r7TTGFDMPIJ
         1STQ==
X-Gm-Message-State: AOAM530a3wEZLr7BKSLSnnmOWGiHdBjXTEOpgm7OG3Bu8LwYwyfPTKOj
        72EBJfPtZ0GZvmT2+kKW0ZWkgfVHnqrQsFGnU1kHQgfKLztcKS8G77wPZWk6xhkj9xuY6VkXkXU
        phF9ArE6ePn8yneuNOwzVOcGw/Q==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr17184401wrx.155.1636533053353;
        Wed, 10 Nov 2021 00:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8YcFMEsRvKaXtzYm0YXi/nOXwlwvFD48+I3aZMgZRH2q7e3nrnFqGxYiGaWtqCC/IDnNoZA==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr17184370wrx.155.1636533053092;
        Wed, 10 Nov 2021 00:30:53 -0800 (PST)
Received: from [192.168.3.132] (p5b0c604f.dip0.t-ipconnect.de. [91.12.96.79])
        by smtp.gmail.com with ESMTPSA id c5sm19156137wrd.13.2021.11.10.00.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:30:52 -0800 (PST)
Message-ID: <793685d2-be3f-9a74-c9a3-65c486e0ef1f@redhat.com>
Date:   Wed, 10 Nov 2021 09:30:50 +0100
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
 <YYuCaNXikls/9JhS@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YYuCaNXikls/9JhS@t490s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.11.21 09:27, Peter Xu wrote:
> On Wed, Nov 10, 2021 at 09:14:42AM +0100, David Hildenbrand wrote:
>> On 10.11.21 08:03, Peter Xu wrote:
>>> Hi, Mina,
>>>
>>> Sorry to comment late.
>>>
>>> On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>>>> index fdc19fbc10839..8a0f0064ff336 100644
>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>>> @@ -23,7 +23,8 @@ There are four components to pagemap:
>>>>      * Bit  56    page exclusively mapped (since 4.2)
>>>>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
>>>>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
>>>> -    * Bits 57-60 zero
>>>> +    * Bit  58    page is a huge (PMD size) THP mapping
>>>> +    * Bits 59-60 zero
>>>>      * Bit  61    page is file-page or shared-anon (since 3.5)
>>>>      * Bit  62    page swapped
>>>>      * Bit  63    page present
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index ad667dbc96f5c..6f1403f83b310 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -1302,6 +1302,7 @@ struct pagemapread {
>>>>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>>>>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>>>>  #define PM_UFFD_WP		BIT_ULL(57)
>>>> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)
>>>
>>> The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
>>> "PM_HUGE" (as THP also means HUGE already)?
>>>
>>> IMHO the core problem is about permission controls, and it seems to me we're
>>> actually trying to workaround it by duplicating some information we have.. so
>>> it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
>>> if it's the permission part that to be enhanced, rather than a new but slightly
>>> duplicated interface.
>>
>> It's not a permission problem AFAIKS: even with permissions "changed",
>> any attempt to use /proc/kpageflags is just racy. Let's not go down that
>> path, it's really the wrong mechanism to export to random userspace.
> 
> I agree it's racy, but IMHO that's fine.  These are hints for userspace to make
> decisions, they cannot be always right.  Even if we fetch atomically and seeing
> that this pte is swapped out, it can be quickly accessed at the same time and
> it'll be in-memory again.  Only if we can freeze the whole pgtable but we
> can't, so they can only be used as hints.

Sorry, I don't think /proc/kpageflags (or exporting the PFNs to random
users via /proc/self/pagemap) is the way to go.

"Since Linux 4.0 only users with the CAP_SYS_ADMIN capability can get
PFNs. In 4.0 and 4.1 opens by unprivileged fail with -EPERM.  Starting
from 4.2 the PFN field is zeroed if the user does not have
CAP_SYS_ADMIN. Reason: information about PFNs helps in exploiting
Rowhammer vulnerability."

> 
>>
>> We do have an interface to access this information from userspace
>> already: /proc/self/smaps IIRC. Mina commented that they are seeing
>> performance issues with that approach.
>>
>> It would be valuable to add these details to the patch description,
>> including a performance difference when using both interfaces we have
>> available. As the patch description stands, there is no explanation
>> "why" we want this change.
> 
> I didn't notice Mina mention about performance issues with kpageflags, if so
> then I agree this solution helps. 
The performance issue seems to be with /proc/self/smaps.

-- 
Thanks,

David / dhildenb

