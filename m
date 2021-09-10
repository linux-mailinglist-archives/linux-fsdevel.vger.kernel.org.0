Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31894065E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhIJDIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhIJDIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:08:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A0C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 20:07:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n24so557485ion.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 20:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oVmXRE2WfTKY/BU1muJfhKrtciXuxWuOv9P+ywGe1Co=;
        b=SdsIzHzB3Kh4WyoyTSIVrQs7RuaA7ZO5wvD9Z7VUURvgdAE5rHkCwX23myp+qEWlh+
         upGQNrkJqu1w1pGjJcpGZsLn7U1emw4z1MnmaFASLbgD6bggAI8nXMrIu9y6nPuNJgZh
         njF+XHADMV8eumTIiCWZmYf+sFnr/mpVaEIEs7YSX/r7gRgHELKKVQfFAioAc9U1VDzP
         c18EaG5Vm1xRXHOn2L0ccRqMZVQ7Vcy2Vd2uXW7lmQ9atqd25vP9kw2brJ+BZA70GlIt
         mKXy7OaciOQJYHFWHXdtMmEGNAaYW2KfSEURfxezZLudGIEzf8xWtanh3aCAzDyX8/3m
         r67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVmXRE2WfTKY/BU1muJfhKrtciXuxWuOv9P+ywGe1Co=;
        b=lgG1ieGpiS1ZwGUOEL1C4d6SAo6heCBG2efCI0Om35XRYH8At7Bf7XtCG0msqvZBhM
         3ztcI7eBIG0nDhiFG08+GFUnrgYb7RrDZUYmg9cN/D1GmdkhWEeXciYiWdoPnl8pUgzf
         xePiuPFBLJfY4qKuTIJ3mm+0EuMyUdNto+NabE3L1gQodavAN/UHBLGHybpo5YEEklIf
         gRV6anGjbAo57MGda45RQmNm2r4C7SC1oUn5iJXc3Q9yQiEZ5ZvL1pH0vAQFPZBk7k7/
         JWs5nKmMT7wwELFVORk/2wJ3zISuT553YcXb5Y52Ov1gMSClydwKNBabKwfMGv6hN3m1
         ehfA==
X-Gm-Message-State: AOAM530rSqHScypp2ysCOzYUaXvyr3iPrWbtZbnLmqBn6OIK8fmByPbF
        d+olvm2OLo8X0lGq+GX4CLkAIje8pApc4A==
X-Google-Smtp-Source: ABdhPJx9MqCxAHhRkFkaloY11WiCNFESjY9s1IVnTLgKMNlhYnQHQ1+rKcs6krSid++B74rAbvbZpg==
X-Received: by 2002:a02:cc30:: with SMTP id o16mr2549726jap.101.1631243219107;
        Thu, 09 Sep 2021 20:06:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l25sm1789725iob.41.2021.09.09.20.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 20:06:58 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d9e4f7c-bcf4-2751-9978-6283cabeda52@kernel.dk>
Date:   Thu, 9 Sep 2021 21:06:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrHYYEQslQzvnWW@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 8:48 PM, Al Viro wrote:
> On Thu, Sep 09, 2021 at 07:35:13PM -0600, Jens Axboe wrote:
> 
>> Yep ok I follow you now. And yes, if we get a partial one but one that
>> has more consumed than what was returned, that would not work well. I'm
>> guessing that a) we've never seen that, or b) we always end up with
>> either correctly advanced OR fully advanced, and the fully advanced case
>> would then just return 0 next time and we'd just get a short IO back to
>> userspace.
>>
>> The safer way here would likely be to import the iovec again. We're
>> still in the context of the original submission, and the sqe hasn't been
>> consumed in the ring yet, so that can be done safely.
> 
> ... until you end up with something assuming that you've got the same
> iovec from userland the second time around.
> 
> IOW, generally it's a bad idea to do that kind of re-imports.

That's really no different than having one thread do the issue, and
another modify the iovec while it happens. It's only an issue if you
don't validate it, just like you did the first time you imported. No
assumptions need to be made here.

If it's no longer valid, it'll get failed, and it's really on the
application having buggy behavior. The iovec cannot be modified until
we've signaled that it's been consumed, which hasn't happened yet. No
different than if an application modifies it mid readv(2) syscall.

-- 
Jens Axboe

