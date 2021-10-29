Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DDB43F7B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 09:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhJ2HNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 03:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhJ2HNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635491484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCTTbBJsrfXvFYN8/T5V0SHnU8uYrvusDcCssMFXxdU=;
        b=DMVpjVOy1HP20ozXjz263R0fGP+rAAXsvVaKAGKEBdWVkLUTrqJji6+xbQAu3E0e46Qq1i
        +n4cEQc+zG/B79eynxKAWDDlaNrX+Vpz7c7e/lZ6CH0qinYvJU2dTmPyEVUOLDx1B2fsAo
        ohj/gkqOOAXdQXO9iokRa9hl12ZH8XA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-1mVg68yuMnWOzysP1FkL-w-1; Fri, 29 Oct 2021 03:11:22 -0400
X-MC-Unique: 1mVg68yuMnWOzysP1FkL-w-1
Received: by mail-wr1-f69.google.com with SMTP id j12-20020adf910c000000b0015e4260febdso3076402wrj.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=LCTTbBJsrfXvFYN8/T5V0SHnU8uYrvusDcCssMFXxdU=;
        b=8N8mjbpx3vJ4rE7bJVGZUduOF0r4JkZwn6351cybshT3aDLvXMErOEWHsYBSNBCBpK
         owZ7eCtSViftaZLAJPLaSM+7Oz3qtBL0leDQN1tSCgJ+QV0m2NbsHj22dDht5IGPfql1
         4Dfcs9IIs8j4JLFOQQFV0SIhnpCVqGy7x8LnuyD8sGI8g0DjcEI+ciB6x84iggwP93kE
         IaU5jd5WCAfKBS1GZsL0hmJ6LOK7AauGiSes0USpSu1p5/aTX7hOo+fIrRdZkOpJDN/T
         p9ERWbXdb55QFqG+P1bFYuq9jPx4xiahIM1fXrZxOiYy4mo/e2YQ6ZUidopmzj/g3BF1
         0OtQ==
X-Gm-Message-State: AOAM532W2kD48Xbsp3JXzyOgzzvVSoSKuf1sxc1z5UvEz0i01etsjeZ0
        gNPxLC+oj7LbXINDwjoMjQeuc62mhI/Tik6+pidDJdAGJDXFpWl8BlMV0EMzpK01lJ+R729h+hN
        KevqZ7EWcFDtYrP91zBfBwlEtHg==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr12197299wry.343.1635491481572;
        Fri, 29 Oct 2021 00:11:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS76O1DPscffsFoErrXA8bL8tphwuCC2AJB6HaGSvmdC6xJu4mAOkmQfN1z+FnFJdOvm5FlA==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr12197272wry.343.1635491481393;
        Fri, 29 Oct 2021 00:11:21 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b86.dip0.t-ipconnect.de. [79.242.59.134])
        by smtp.gmail.com with ESMTPSA id v6sm6025294wrx.17.2021.10.29.00.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 00:11:21 -0700 (PDT)
Message-ID: <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com>
Date:   Fri, 29 Oct 2021 09:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211028205854.830200-1-almasrymina@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
In-Reply-To: <20211028205854.830200-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.10.21 22:58, Mina Almasry wrote:
> From: Yu Zhao <yuzhao@google.com>
> 
> This file lets a userspace process know the page flags of each of its virtual
> pages.  It contains a 64-bit set of flags for each virtual page, containing
> data identical to that emitted by /proc/kpageflags.  This allows the user-space
> task can learn the kpageflags for the pages backing its address-space by
> consulting one file, without needing to be root.
> 
> Example use case is a performance sensitive user-space process querying the
> hugepage backing of its own memory without the root access required to access
> /proc/kpageflags, and without accessing /proc/self/smaps_rollup which can be
> slow and needs to hold mmap_lock.

Can you elaborate on

a) The target use case. Are you primarily interested to see if a page
given base page is head or tail?

b) Your mmap_lock comment. pagemap_read() needs to hold the mmap lock in
read mode while walking process page tables via walk_page_range().

Also, do you have a rough performance comparison?

> 
> Similar to /proc/kpageflags, the flags printed out by the kernel for
> each page are provided by stable_page_flags(), which exports flag bits
> that are user visible and stable over time.

It exports flags (documented for pageflags_read()) that are not
applicable to processes, like OFFLINE. BUDDY, SLAB, PGTABLE ... and can
never happen. Some of these kpageflags are not even page->flags, they
include abstracted types we use for physical memory pages based on other
struct page members (OFFLINE, BUDDY, MMAP, PGTABLE, ...). This feels wrong.

Also, to me it feels like we are exposing too much internal information
to the user, essentially making it ABI that user space processes will
rely on.

Did you investigate

a) Reducing the flags we expose to a bare minimum necessary for your use
case (and actually applicable to mmaped pages).

b) Extending pagemap output instead.

You seem to be interested in the "hugepage backing", which smells like
"what is mapped" as in "pagemap".


-- 
Thanks,

David / dhildenb

