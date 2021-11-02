Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2A442CFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 12:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKBLpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 07:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhKBLpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635853364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xee5JhjhnGt3CxdHmyRlw/DMJ/pTVtpU9WjkRwoLrVc=;
        b=aaM1x4GziE6eNE20oq5BnhMcHeo5f8AMsSRSRC3j63Hqzo018zBcpkwvxOBZXX9eAUl3Tm
        KOFuKEjKT67J1FwsrZMGs9hnf8R+eRFKhm6IrPJnBLbGSx2G0SWufZT93/aX6Zvzc39ld/
        H1v5VKXLLB0lFsJ1DcX47K1Q+T3W/ls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-Lz7hDCkhOSGosBnOJ1YUaA-1; Tue, 02 Nov 2021 07:42:44 -0400
X-MC-Unique: Lz7hDCkhOSGosBnOJ1YUaA-1
Received: by mail-wm1-f72.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so994382wmc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 04:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=xee5JhjhnGt3CxdHmyRlw/DMJ/pTVtpU9WjkRwoLrVc=;
        b=kGVyhn258Yb9gjetV+EalvfwD555C0hZfTrR9iejV23hcIRmxg3LEAmomdBwEQskYS
         plJQOEF8OYKku786M8jwRIDpsqeNQFYcpjmE9aW5eEhQS2lBqfRDcqP4A2BFsBG4LLDr
         c2+hEp2iCQUTbDUbWFf7k2dkpgiEorMUfVnPke4VVzHx7QJCwmlaG9jE4W6p8v8o33Ms
         FlU51J7SgNTDAGocY1bLRuU5AdvVYc4+3n9vlnTfM0XHyusTOWYvMzg2TK0s6lXhWhAc
         Uh3m2zxjvUX32fB6bBnZ7L4sN7OKHEYndx1dXRYs3PuJQ6x0OHQfCAZzrLhXqDRexvgO
         KE8w==
X-Gm-Message-State: AOAM532Y5DPY9wzTWhLxXdKvtJ2vvVJYI/QDBwUluQsvYSdlk3HG7tTy
        27pmM78n22Fr3E3txJjyK6KD4TCQFWi6J0jRYzhQgudWKDpL3EOL+Cgk1hFvQyEnzLHnT8eUbCO
        Rf6l0X0YHsS9XhtboZ5KoLUerDg==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr38727430wrt.122.1635853362684;
        Tue, 02 Nov 2021 04:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYlFsUlGRluXgAGhyhBxCMa89zjN2XsplD6uC5lnBgtaPtWkNjyIH27zVcWiuRjB5lpXwQzA==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr38727399wrt.122.1635853362447;
        Tue, 02 Nov 2021 04:42:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6810.dip0.t-ipconnect.de. [91.12.104.16])
        by smtp.gmail.com with ESMTPSA id z18sm13052470wrq.11.2021.11.02.04.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 04:42:41 -0700 (PDT)
Message-ID: <9fd0a86f-c012-4bb7-78eb-7413346448e0@redhat.com>
Date:   Tue, 2 Nov 2021 12:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>
Cc:     Nathan Lewis <npl@google.com>, Yu Zhao <yuzhao@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211028205854.830200-1-almasrymina@google.com>
 <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com>
 <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
 <e02b1a75-58ab-2b8a-1e21-5199e3e3c5e9@redhat.com>
 <CAHS8izOkvuZ2pEGZXaYb0mfwC3xwpvXSgc9S+u_R-0zLWjzznQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
In-Reply-To: <CAHS8izOkvuZ2pEGZXaYb0mfwC3xwpvXSgc9S+u_R-0zLWjzznQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Bit 58-60 are still free, no? Bit 57 was recently added for uffd-wp
>> purposes I think.
>>
>> #define PM_SOFT_DIRTY           BIT_ULL(55)
>> #define PM_MMAP_EXCLUSIVE       BIT_ULL(56)
>> #define PM_UFFD_WP              BIT_ULL(57)
>> #define PM_FILE                 BIT_ULL(61)
>> #define PM_SWAP                 BIT_ULL(62)
>> #define PM_PRESENT              BIT_ULL(63)
>>
>> PM_MMAP_EXCLUSIVE and PM_FILE already go into the direction of "what is
>> mapped" IMHO. So just a thought if something in there (PM_HUGE? PM_THP?)
>> ... could make sense.
>>
> 
> Thanks! I _think_ that would work for us, I'll look into confirming.
> To be honest I still wonder if eventually different folks will find
> uses for other page flags and eventually we'll run out of pagemaps
> bits, but I'll yield to whatever you think is best here.

Using one of the remaining 3 bits should be fine. In the worst case,
we'll need pagemap_ext at some point that provides more bits per PFN, if
we ever run out of bits.

But as mentioned by Matthew, extending mincore() could also work: not
only indicating if the page is resident, but also in which "form" it is
resident.

We could separate the cases "cont PTE huge page" vs. "PMD huge page".

I recall that the information (THP / !THP) might be valuable for users:
there was a discussion to let user space decide where to place THP.
(IIRC madvise() extension to have something like MADV_COLLAPSE_THP /
MADV_DISSOLVE_THP)

-- 
Thanks,

David / dhildenb

