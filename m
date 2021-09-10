Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3936C4071BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhIJTMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 15:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhIJTMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:12:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4593C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u18so2734328pgf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OxrV+O/CeDbwvzlEEUi1X1nUVONoUScOOLnqA2lPrtI=;
        b=cf7M63qHGucdJ5nIuyxyx87U6Q0r7IEf44Uf9m4ImqdNBVD54amQtC0Hks5tsAn1ex
         s5HKsnYIU3eljyWUKFbiBv2Q4gxQm2MIc/u7aH5uI1py1sZPNj87CU20WOK2Ss1w0csh
         jaM8PLgEIhL19Iq2nOEJHagXnTtvD0NH37B7bGNmp4J9zpcbbAcwkD2K4xr4QMIU8xQ2
         hwIV5bV6Hr0x1ikoj0noaTtEYsVc41g0Rl+OThWnFntrvzAQ2dO/36F3DwL7xSaGKNii
         bXzZL5Gx0SHkjm37AagWCx9pXN5Uri6RdgYTzak2+3dc+ldDgTET8Fz+Cekrz9KXUW2k
         4P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OxrV+O/CeDbwvzlEEUi1X1nUVONoUScOOLnqA2lPrtI=;
        b=xPM3Sw2xNsADoMD2AST/x6EiveWvEn9uP/tT8ZaBBDDBKzk+ibQTRQ2bTtCBtbyy2L
         cWDp/ZP+jcZsJEnOtPqwgkjWhbGmvWUZRtAOcVsDbQB8OsTi+lKZPT3Aqyau2Jd/ybRM
         /8cZou2sob7ibujX76aC41wYdUjKbfx3UHkEhenj4xsLEW3aYFVbMFjDXUBOzpKoTvHk
         1o43V39iT9bB10DOMiEfC6MbnmOtUJo7kP8LHLaiGz+YPauUIvhv8DRL2in/LRKd61ok
         yKhWF7iHFFIDR+2NLvxULxHGk8awT+e3WFD+PH4eqKwsmootRD0merX/jZyP8p14pLE8
         9Akw==
X-Gm-Message-State: AOAM531mYBINBX+WmfLQWgLym9VjCQufU+8Eo85t6J4bJXs5s2UXl55Y
        vt2bu4f8zm3DBwD9XeIA9H8vwLFw+LO9RQ==
X-Google-Smtp-Source: ABdhPJzhpRNYG6nUVDo7ZHpq6f6QzNZu0xj9jZC6NXYCFhL1PDF7PvuylmwORJ/ewoUewqCH+O8vAw==
X-Received: by 2002:a62:158a:0:b0:40d:7fae:d109 with SMTP id 132-20020a62158a000000b0040d7faed109mr9646189pfv.34.1631301048918;
        Fri, 10 Sep 2021 12:10:48 -0700 (PDT)
Received: from ?IPv6:2600:380:4963:7106:aa8b:68a3:b10d:8c01? ([2600:380:4963:7106:aa8b:68a3:b10d:8c01])
        by smtp.gmail.com with ESMTPSA id n3sm5512166pfo.101.2021.09.10.12.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:10:48 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
 <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk>
 <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
 <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b27b3ad3-cc2e-43ba-b990-9dbc6fbe9956@kernel.dk>
Date:   Fri, 10 Sep 2021 13:10:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 12:48 PM, Al Viro wrote:
> On Fri, Sep 10, 2021 at 10:31:00AM -0700, Linus Torvalds wrote:
>> On Fri, Sep 10, 2021 at 10:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 9/10/21 10:58 AM, Linus Torvalds wrote:
>>>> On Fri, Sep 10, 2021 at 9:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>>
>>>>> What's the point of all those contortions, anyway?  You only need it for
>>>>> iovec case; don't mix doing that and turning it into flavour-independent
>>>>> primitive.
>>>>
>>>> Good point, making it specific to iovec only gets rid of a lot of
>>>> special cases and worries.
>>>>
>>>> This is fairly specialized, no need to always cater to every possible case.
>>>
>>> Alright, split into three patches:
>>>
>>> https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter
>>
>> That looks sane to me.
>>
>> Please add some comment about how that
>>
>>         i->iov -= state->nr_segs - i->nr_segs;
>>
>> actually is the right thing for all the three cases (iow how 'iov',
>> 'kvec' and 'bvec' all end up having a union member that acts the same
>> way).
>>
>> But yeah, I like how the io_uring.c code looks better this way too.
>>
>> Al, what do you think?
> 
> I think that sizeof(struct bio_vec) != sizeof(struct iovec):
> struct bio_vec {
>         struct page     *bv_page;
> 	unsigned int    bv_len;
> 	unsigned int    bv_offset;
> };
> takes 3 words on 32bit boxen.
> struct iovec
> {
>         void __user *iov_base;  /* BSD uses caddr_t (1003.1g requires void *) */
> 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
> };
> takes 2 words on 32bit boxen.

Ouch yes. I guess we do have to special case BVEC for now, as I do actually
need that one internally. I'll add a BUILD_BUG_ON() for the other one while
at it.

-- 
Jens Axboe

