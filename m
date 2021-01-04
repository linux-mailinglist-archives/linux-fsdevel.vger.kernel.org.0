Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407382E9785
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhADOn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 09:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhADOn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:43:57 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29712C061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jan 2021 06:43:17 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o6so25151772iob.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jan 2021 06:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGVk4w6jP2DKMQ5Tg3ZhtV3hHEvTAKkxCcA25JB7GiA=;
        b=YSYFp8hI3gqzNT0VLITElzDPdY7QBuLrppqkSWfBOgWdG3Yt9DVGvcJzHg8hrwHSau
         9rM7ZvMt6cUzOXrTHC4PixOQBODw/xWal5s541G2m1ypfS7aqQaQRkqYSnfABZaQsOC+
         4Nlcmpx9pEAdEMOHa2C35tP7JsRqlxUbg8rLrI7eb6Oihho+0fVBivvPyENrMJl0q6EI
         1a8Cv75/047peKxi/Y43yVT5eBq8CKGcIs8TZZI+8QcjnojZ1C6OgJ+rc8EtzAMcnHp9
         O3eJhSy0mO+eDlj+n7V4JYlNx2wdTXSonDmk75nAlMwZVpXIRuZvUCfYY911pm+wwerG
         J3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGVk4w6jP2DKMQ5Tg3ZhtV3hHEvTAKkxCcA25JB7GiA=;
        b=tAPF8q5srbMvRmb0zNrGQRtAzawcTkbBrB8b7x84xRTXQhcdP3RQuBjDo+PBUD9N7G
         u3MW9eN6j53w1T1kjnaOmqV1vxUeltpwy+1alW84tVuwjHMpiPbNtBejick05abh5Xlo
         uCfn+XPPHkWO4tGQ1Q+GJd1V58hF8sIvOr2xWZECaz9kh3mRettRGLYwKzRmhBQbaCN5
         WLlladbe7r2oCr4Ya2LA3B8aXUPFfX0O0KTzQB3MZcMuBW2YiFftaPW3lJPqI/TxEPMC
         juJg/uVus9kp5zRMcRmPZmJ0B9UC7gtuLLjGSdFp+K3q9dJzvd1ZNHt7Fzf81f0tNkUp
         QoKQ==
X-Gm-Message-State: AOAM532+nwLET3oVPYJ5rp27IjUnv3kTooIRbLcVDr1LRU5t5UDaoMCb
        ZOEM94Ew4/4Ici2jEJffqbPXT5myEwkQ3Q==
X-Google-Smtp-Source: ABdhPJz3wY7JGVjnZv5SRAibNjqVy3kD5YDtB3sQynSckJxhIP0g7MjAo2Isjx/Ct9IdZ00Hxrfcsg==
X-Received: by 2002:a02:ceb0:: with SMTP id z16mr62414233jaq.40.1609771396524;
        Mon, 04 Jan 2021 06:43:16 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 12sm42216795ily.42.2021.01.04.06.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:43:15 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20210104053112.GH3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a51a2db9-716a-be20-5f71-5180394a992b@kernel.dk>
Date:   Mon, 4 Jan 2021 07:43:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104053112.GH3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/3/21 10:31 PM, Al Viro wrote:
> On Mon, Dec 14, 2020 at 12:13:20PM -0700, Jens Axboe wrote:
>> Hi,
>>
>> Wanted to throw out what the current state of this is, as we keep
>> getting closer to something palatable.
>>
>> This time I've included the io_uring change too. I've tested this through
>> both openat2, and through io_uring as well.
>>
>> I'm pretty happy with this at this point. The core change is very simple,
>> and the users end up being trivial too.
>>
>> Also available here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=nonblock-path-lookup
> 
> OK, pushed with modifications into vfs.git #work.namei
> 
> Changes: dropped a couple of pointless pieces in open_last_lookups()/do_open(),
> moved O_TMPFILE rejection into build_open_flags() (i.e. in the third of your
> commits).  And no io_uring stuff in there - your #4 is absent.
> 
> I've not put it into #for-next yet; yell if you see any problems with that
> branch, or it'll end up there ;-)

Thanks Al - but you picked out of v3, not v4. Not that there are huge
changes between the two, from the posting of v4:

- Rename LOOKUP_NONBLOCK -> LOOKUP_CACHED, and ditto for the RESOLVE_
  flag. This better explains what the feature does, making it more self
  explanatory in terms of both code readability and for the user visible
  part.

- Remove dead LOOKUP_NONBLOCK check after we've dropped LOOKUP_RCU
  already, spotted by Al.

- Add O_TMPFILE to the checks upfront, so we can drop the checking in
  do_tmpfile().

and it sounds like you did the last two when merging yourself. I do like
LOOKUP_CACHED better than LOOKUP_NONBLOCK, mostly for the externally
self-documenting feature of it. What do you think?

Here's the v4 posting, fwiw:

https://lore.kernel.org/linux-fsdevel/20201217161911.743222-1-axboe@kernel.dk/

-- 
Jens Axboe

