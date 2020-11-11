Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022282AE700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 04:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgKKDW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 22:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgKKDW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:22:58 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B32AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:22:58 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so755985pfd.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+INKkjIDZT3D1i6UtnttTDRAE8G2FcYmKLz7U0uR9c=;
        b=JOosOqkxOcZllws4ecN2id5Fe6UwVCj2cPtfVf0pyLIXCSFSSvTSZeGKT3fq/ezVt5
         KgcY8zcYBIplyi9d9oQ/9QTFuB2YDgE6RmMNJ8o7RYYUguheYDhNU3hp0JNlxNdJtqFz
         Gexrvs9uU78mNQL9gd3oe+jELMbHQBqZNiY9PEkwkL1dzN7fqCNqK4G8WgiA5lOY6M/Q
         7GJpfITLytNdp0b1BJUPFd+O23TuN9OryMFMmHWa5BwHsNoWQv9FLDU7JgIUMPZakIW8
         VZ+6zTHk1hCMqR6GnLIDAlID9LUFMXPI6okp8bEw3p+mDz8KqluLN7dU6g3oQNY7CmrN
         /mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+INKkjIDZT3D1i6UtnttTDRAE8G2FcYmKLz7U0uR9c=;
        b=A8uybxR3h5GKrTRqJwWPjXrsTT34gBeWxbWBGJxW6N1U3Gu4PwLco85m/poWak90K3
         7XjW+jX6ceNrJD5kyzxim8ogKNC0rE2Xlg9Gv08TySL3i+6jVfk/l0pHhTRd9dJBP7Yu
         nAaGEqlmNCQRNzqvfLnqVh0IyUk38W7TY/QRPscOjOi6i6TNSPIZWKpIaMsn3it6Gib1
         erRdplE2w/rNK2Qx08VvC5eVFoGN61dJojcDGwRjh4gHRZ0fkg+76smozr7B+94NAWov
         EqjqUE6v4X2Yj6eogPHHaUKyf2tCmneMTDBUg/pIA8r1akPEg3kOU7efR0ZPFqjyv2EO
         7mqA==
X-Gm-Message-State: AOAM532gtXIeZvR6IW92uZ+tioqeHkI5ZycTjCOiYR7wOPDyChIj/Qvq
        gJMmUbERn/fZyB2jJen/Py1OppEFiOZQrPQp9V6mBg==
X-Google-Smtp-Source: ABdhPJzGT8N4NW+RVlPTeogdZpkCaeOCNCxDbSreds3iADW9boMPn78RQuijNHX62TFpNpPq2MucJDiBiXFCUcLBotI=
X-Received: by 2002:aa7:9095:0:b029:164:75c4:5d15 with SMTP id
 i21-20020aa790950000b029016475c45d15mr21053662pfa.49.1605064978215; Tue, 10
 Nov 2020 19:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-5-songmuchun@bytedance.com> <20201109164825.GA17356@linux>
 <CAMZfGtWxNV874j9io_xcsVm+C6_shrZCw=W9ugJzxrnBpXb_Mw@mail.gmail.com> <877a4620-fa5c-c5b5-8a42-fdd67a869a38@oracle.com>
In-Reply-To: <877a4620-fa5c-c5b5-8a42-fdd67a869a38@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 11 Nov 2020 11:22:22 +0800
Message-ID: <CAMZfGtWtd2OKpjTw+PEREeP3xEaAJ0k8KNCAQ226=ifObSOmtw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 04/21] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 3:40 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/9/20 6:42 PM, Muchun Song wrote:
> > On Tue, Nov 10, 2020 at 12:48 AM Oscar Salvador <osalvador@suse.de> wrote:
> >>
> >> On Sun, Nov 08, 2020 at 10:10:56PM +0800, Muchun Song wrote:
> >>
> >> Unrelated to this patch but related in general, I am not sure about Mike but
> >> would it be cleaner to move all the vmemmap functions to hugetlb_vmemmap.c?
> >> hugetlb code is quite tricky, so I am not sure about stuffing more code
> >> in there.
> >>
> >
> > I also think that you are right, moving all the vmemmap functions to
> > hugetlb_vmemmap.c may make the code cleaner.
> >
> > Hi Mike, what's your opinion?
>
> I would be happy to see this in a separate file.  As Oscar mentions, the
> hugetlb.c file/code is already somethat difficult to read and understand.

Got it. I will do this. Thanks.

> --
> Mike Kravetz



-- 
Yours,
Muchun
