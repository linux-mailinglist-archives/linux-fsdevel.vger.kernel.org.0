Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4709405FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbhIIW7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 18:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347720AbhIIW73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:59:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB07C061574;
        Thu,  9 Sep 2021 15:58:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so4791269wrn.5;
        Thu, 09 Sep 2021 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nQIIbOTPU84wYixGqsJc2KwMpuc10heb+NPlS1k9aAw=;
        b=WGOgkMn0LJB6V4vhSi38sJykkcVGiy/7Aw5L7AFp0YOXz1zBKGR22dfHPrsSXTZmyQ
         J1h6MLoSuiK24iErqfTWPWQSQxpnDTUkNPzf8II2qHf+qU8G/3Kqj9eQRKC09I9IfwRW
         oSTRNGFjReMkQnlbiW9TCD4LjJIl1WFzx/iqnAurSS7lBnnGKARsVa5LXpz0XLCl2HOP
         tx8mGhPg8qnv66n8IrjN4A4HkFIx7Dxw64U911JTbuyNyxL7lX/XroaTtmsaepkHjxnA
         LzoSQyytyk01clLneIcjL7b3/lYPBPBmJD2Iwhsk/1A8OoPuRpFRhPCqvI3pHQclM35h
         9YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQIIbOTPU84wYixGqsJc2KwMpuc10heb+NPlS1k9aAw=;
        b=7eCvwZTZ9GYZ9wlmdukqoqIhgh/geHr8HMu5sgKwm7KdqxnWkGM8y2SbT26X8j7Hav
         GfS60ALzgUdpQhSI2F+4kTL5nSaMmM5QcYUhY1cK81Cz55ANlrIdtVx8tJXw7s5dj5tM
         RRfnBAsWKdWKBbVUbp0l6QOCxLAuKqIvKlQyys/GeJWii+mhXUtZODvbFXoE4jplntSn
         xgFs6ulOCKuok8Pv9/2FIzsCbKiVtf/o5CoLxrVt8HGsYE9fF9w1U74MDLtaZBOT3NVe
         Gfvz4CL4BbiIDIipYrrMyMxumDaPpIiEcL2RQKQNtwaOL9U3zHOe4l0V1c+2QjcybLZm
         wfew==
X-Gm-Message-State: AOAM5322r59xpmtYYJJCKQYVPHR2K20qkv7MKda4PGp5V0T64IcsYVqC
        6fOEq2rQL1UbDvc9lSuRN1+hUH+ylKc=
X-Google-Smtp-Source: ABdhPJwGstaxInfY7Xs108Wuq4drePqRB/+fZwmYQPlln6Yt/M5T6PdPtopcp/tkfGZtYkMlRjfLIw==
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr6301918wrb.100.1631228297661;
        Thu, 09 Sep 2021 15:58:17 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.235.167])
        by smtp.gmail.com with ESMTPSA id o10sm3360454wrc.16.2021.09.09.15.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:58:17 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <84c85780-fe43-e95b-312d-b7671c65a7aa@gmail.com>
Message-ID: <4ba3123b-6437-74b8-8205-1466065b8252@gmail.com>
Date:   Thu, 9 Sep 2021 23:57:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <84c85780-fe43-e95b-312d-b7671c65a7aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 11:54 PM, Pavel Begunkov wrote:
> On 9/9/21 8:37 PM, Linus Torvalds wrote:
>> On Wed, Sep 8, 2021 at 9:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>
>>>         Fixes for io-uring handling of iov_iter reexpands
>>
>> Ugh.
>>
>> I have pulled this, because I understand what it does and I agree it
>> fixes a bug, but it really feels very very hacky and wrong to me.
> 
> Maybe was worded not too clearly, my apologies.
> 
> 
>> It really smells like io-uring is doing a "iov_iter_revert()" using a
>> number that it pulls incorrectly out of its arse.
> 
> It's not invented by io_uring,
> 
> filemap.c : generic_file_direct_[write,read]()
> 
> do the same thing. Also, the block layer was not re-expanding before
> ~5.12, so it looks it was possible to trigger a similar thing without
> io_uring, but I haven't tried to reproduce. Was mentioned in the
> cover-letter.
> 
>> So when io-uring does that
>>
>>                 iov_iter_revert(iter, io_size - iov_iter_count(iter));
>>
>> what it *really* wants to do is just basically "iov_iter_reset(iter)".
>>
>> And that's basically what that addition of that "iov_iter_reexpand()"
>> tries to effectively do.
>>
>> Wouldn't it be better to have a function that does exactly that?
>>
>> Alternatively (and I'm cc'ing Jens) is is not possible for the
>> io-uring code to know how many bytes it *actually* used, rather than
>> saying that "ok, the iter originally had X bytes, now it has Y bytes,
>> so it must have used X-Y bytes" which was actively wrong for the case
>> where something ended up truncating the IO for some reason.
>>
>> Because I note that io-uring does that
>>
>>         /* may have left rw->iter inconsistent on -EIOCBQUEUED */
>>         iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));
>>
>> in io_resubmit_prep() too, and that you guys missed that it's the
>> exact same issue, and needs that exact same iov_iter_reexpand().
> 
> Right. It was covered by v1-v2, which were failing requests with
> additional fallback in v2 [1], but I dropped in v3 [2] because there
> is a difference. Namely io_resubmit_prep() might be called deeply down
> the stack, e.g. in the block layer.
> 
> It was intended to get fixed once the first part is merged, and I do
> believe that was the right approach, because there were certain
> communication delays. The first version was posted a month ago, but
> we missed the merged window. It appeared to me that if we get anything
> more complex 

Dammit, apologies for the teared email.

... It was intended to get fixed once the first part is merged, and I do
believe that was the right approach, because there were certain
communication delays. The first version was posted a month ago, but
we missed the merged window. It appeared to me that if anything
more complex is posted, it would take another window to get it done.


> [1] https://lkml.org/lkml/2021/8/12/620
> [2] https://lkml.org/lkml/2021/8/23/285
> 
>>
>> That "req->result" is once again the *original* length, and the above
>> code once again mis-handles the case of "oh, the iov got truncated
>> because of some IO limit".
>>
>> So I've pulled this, but I think it is
>>
>>  (a) ugly nasty
>>
>>  (b) incomplete and misses a case
>>
>> and needs more thought. At the VERY least it needs that
>> iov_iter_reexpand() in io_resubmit_prep() too, I think.
>>
>> I'd like the comments expanded too. In particular that
>>
>>                 /* some cases will consume bytes even on error returns */
>>
>> really should expand on the "some cases" thing, and why such an error
>> isn't fatal buye should be retried asynchronously blindly like this?
>>
>> Because I think _that_ is part of the fundamental issue here - the
>> io_uring code tries to just blindly re-submit the whole thing, and it
>> does it very badly and actually incorrectly.
>>
>> Or am I missing something?
>>
>>            Linus
>>
> 

-- 
Pavel Begunkov
