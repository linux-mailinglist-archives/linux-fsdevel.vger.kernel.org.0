Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4F406622
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhIJDbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhIJDbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:31:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713CEC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 20:30:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y18so645362ioc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXYbtWblEJcF2zfz8Yn4cLU+2BUVFcCI1K7VifHDE1s=;
        b=p1y/qGcXoKWZcUAlrwfT0Fsvdv7LxRypTQ8KdV5FN8DbgZPkUvM2pvI/lyth2z+NSq
         KJRcMD7EmucrLBsYgDc2F+fk5yK31EWWrYEJh8sIYiYbW5Q7SEMXxCWyMFJ9ofxyyvj6
         VNUjYeJO0vxATyibQsx+M50JstjbZs2DT2oCvTdkWRXoqzwq+3QXDlXnR2Pc6HIM82ST
         RsR651xGyGsfgL3vVzrRf3hbuH6VSbrfjaQE7+ZSVjhRP81F+LDMfm1wnlvU3pWOmT56
         0MMH71jqkg6eDhbNPlFWaiguiRnL6TK3Ea9FkPyUTJHYjqfY9M6uG36i9nAvnmZNK+bs
         jGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXYbtWblEJcF2zfz8Yn4cLU+2BUVFcCI1K7VifHDE1s=;
        b=HxG7CxZIuKovLGlobsEwmxFWePbnujS+3rSAwFNGOLSee5fFjLM+DUq49CouEfowKO
         j5oPmIYlSKQuk0+5s7Ab7KFHycXzTCFuMTgSm7ISduHd1xJR/jvRiNx63AzCLpLs4c/J
         vFPqB9gO0Dcs586c5Go2i/ZwrmHpnxAwaORkPHdaZqGcSrELe3AohFjdWmouZXGrwykl
         1vNOeI780EHedSytOEQoZJu4feJTGi5OC2jWVKBFCVe17JzXfQg7AWy0ELUF8F8lJVVz
         KLLMCM0+bjRHpoPSED/byzs5aVrp4jW2kq5Dy3y5nI/LnCzgaGfFTsPjF4dBCHolywae
         iWyA==
X-Gm-Message-State: AOAM530pkN1LCH48SIFp423vc30I1pyUHsV6ci2AEBGSmK0ByfmjJ/2k
        ZXA5iHoM0iPdvnlYIdm85QVVxFPus/riAg==
X-Google-Smtp-Source: ABdhPJyErDPUCKjfI20dAubh5KMMj5+ZFXekMLlnax4QLOcx0p84nKWYJJhlowooE7DdUFWA3dt62A==
X-Received: by 2002:a6b:2c45:: with SMTP id s66mr5416313ios.213.1631244604715;
        Thu, 09 Sep 2021 20:30:04 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l15sm1859934ilo.22.2021.09.09.20.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 20:30:04 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
Date:   Thu, 9 Sep 2021 21:30:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 9:27 PM, Al Viro wrote:
> On Thu, Sep 09, 2021 at 09:22:30PM -0600, Jens Axboe wrote:
>> On 9/9/21 9:11 PM, Al Viro wrote:
>>> On Thu, Sep 09, 2021 at 09:05:13PM -0600, Jens Axboe wrote:
>>>> On 9/9/21 8:57 PM, Al Viro wrote:
>>>>> On Thu, Sep 09, 2021 at 03:19:56PM -0600, Jens Axboe wrote:
>>>>>
>>>>>> Not sure how we'd do that, outside of stupid tricks like copy the
>>>>>> iov_iter before we pass it down. But that's obviously not going to be
>>>>>> very efficient. Hence we're left with having some way to reset/reexpand,
>>>>>> even in the presence of someone having done truncate on it.
>>>>>
>>>>> "Obviously" why, exactly?  It's not that large a structure; it's not
>>>>> the optimal variant, but I'd like to see profiling data before assuming
>>>>> that it'll cause noticable slowdowns.
>>>>
>>>> It's 48 bytes, and we have to do it upfront. That means we'd be doing it
>>>> for _all_ requests, not just when we need to retry. As an example, current
>>>> benchmarks are at ~4M read requests per core. That'd add ~200MB/sec of
>>>> memory traffic just doing this copy.
>>>
>>> Umm...  How much of that will be handled by cache?
>>
>> Depends? And what if the iovec itself has been modified in the middle?
>> We'd need to copy that whole thing too. It's just not workable as a
>> solution.
> 
> Huh?  Why the hell would we need to copy iovecs themselves?  They are
> never modified by ->read_iter()/->write_iter().
> 
> That's the whole fucking point of iov_iter - the iovec itself is made
> constant, with all movable parts taken to iov_iter.
> 
> Again, we should never, ever modify the iovec (or bvec, etc.) array in
> ->read_iter()/->write_iter()/->sendmsg()/etc. instances.  If you see
> such behaviour anywhere, report it immediately.  Any such is a blatant
> bug.

Yes that was wrong, the iovec is obviously const. But that really
doesn't change the original point, which was that copying the iov_iter
itself unconditionally would be miserable.

-- 
Jens Axboe

