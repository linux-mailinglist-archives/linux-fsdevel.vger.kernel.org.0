Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCBD406610
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhIJDYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhIJDYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:24:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88074C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 20:23:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m11so608604ioo.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 20:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fS/gR13+AKdfezCz28++1Ca4/7qZ+GYaCjPbEeBXIPY=;
        b=gdqp/JXhJeD1F2Z+eIhcH+/OsDfko22xIFfFSjhmF2S3sahK/IeQz7m0QAKtp7Lqgv
         VdDUWsY60fZblKMUnJ6S6EtgaplJKMMpIWC3U0mV3NjrDcKqh4U/KXu0FU0vhO3+lrLO
         MeytRKpdiWTzjlEBH8q49aSa+VEOtjdgkwI7M+lXJwUp0UBXC/s1Bzp1J6WULwV8Tp0R
         2FOTahVG3SDkIb3nqZEkTlyM0O90+ZW1gAqhGNWVLLCR/blsEt03ERjaMSlho+0e74K1
         Xk1OOwe4yYq1pZG/o2uRpmA8I2Z2oUNsFJ5kCYpqi4Do20DyQTSxIxd19RmzcppnkLP8
         UbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fS/gR13+AKdfezCz28++1Ca4/7qZ+GYaCjPbEeBXIPY=;
        b=g/H7D/Z0eoOciWyqvRJ9gyOrAzLXAswLqHWCGqRFixDp/Wib83znupA33XJYxuCLgf
         5lAGVJ4qPEYN7D9bMftuT0WxSj5OuZWpG+tMGa2El0bqS3JuwqLwEYnhBoNISgEcMFsm
         KLHqzDGiAe8NQdnoH3R9+hRiUX1/aE/rxUreqM9Qrxzdg080rwwRvrUO0gg8u2PzG3Zq
         xWHgfiaZ5ZSJUnt8UaKRZGaSHWCNPFzxYLFPwhwXBel2naV5zNcpPyrx3wPPW/8mTkYZ
         Ga/5uNSGuW/xXB4LYEtsSQRBPMq3dSchRRul81f5DQRXWL/NuW5rcr7xhGTxzwzgMCbj
         Pnlw==
X-Gm-Message-State: AOAM5327+eLUwsMQs229kL3Jjs0cwDouRUdLCZj5895jpBpLrBjE86et
        6VfjQ4eRbIjoRS9/6AR6a9MooQCkVjvZ4w==
X-Google-Smtp-Source: ABdhPJz2rZMCNGrPg1/QvbFfCQp0I7vEfik3keDmvED/I7ny+b/ACLuAQEVvjwKpH74bSNgDAqcvBQ==
X-Received: by 2002:a05:6638:1613:: with SMTP id x19mr2636902jas.77.1631244189785;
        Thu, 09 Sep 2021 20:23:09 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x21sm1766764ioh.55.2021.09.09.20.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 20:23:09 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
 <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
 <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
 <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
 <YTrHYYEQslQzvnWW@zeniv-ca.linux.org.uk>
 <8d9e4f7c-bcf4-2751-9978-6283cabeda52@kernel.dk>
 <YTrN16wu/KE0X/QZ@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <641dbf64-b1c4-41f1-6522-e3b0ac9328c2@kernel.dk>
Date:   Thu, 9 Sep 2021 21:23:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrN16wu/KE0X/QZ@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 9:15 PM, Al Viro wrote:
> On Thu, Sep 09, 2021 at 09:06:58PM -0600, Jens Axboe wrote:
>> On 9/9/21 8:48 PM, Al Viro wrote:
>>> On Thu, Sep 09, 2021 at 07:35:13PM -0600, Jens Axboe wrote:
>>>
>>>> Yep ok I follow you now. And yes, if we get a partial one but one that
>>>> has more consumed than what was returned, that would not work well. I'm
>>>> guessing that a) we've never seen that, or b) we always end up with
>>>> either correctly advanced OR fully advanced, and the fully advanced case
>>>> would then just return 0 next time and we'd just get a short IO back to
>>>> userspace.
>>>>
>>>> The safer way here would likely be to import the iovec again. We're
>>>> still in the context of the original submission, and the sqe hasn't been
>>>> consumed in the ring yet, so that can be done safely.
>>>
>>> ... until you end up with something assuming that you've got the same
>>> iovec from userland the second time around.
>>>
>>> IOW, generally it's a bad idea to do that kind of re-imports.
>>
>> That's really no different than having one thread do the issue, and
>> another modify the iovec while it happens. It's only an issue if you
>> don't validate it, just like you did the first time you imported. No
>> assumptions need to be made here.
> 
> 	It's not "need to be made", it's "will be mistakenly made by
> somebody several years down the road"...

If the application changes the iovec passed in while it hasn't been
consumed yet, it's buggy. Period. We obviously need to ensure that we
only do this re-import IFF we're in the same original submit context
still.

-- 
Jens Axboe

