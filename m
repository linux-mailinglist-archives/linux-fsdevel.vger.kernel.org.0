Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B934065DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhIJDG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhIJDG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:06:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2EC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 20:05:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q3so577281iot.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckHEoUSZG06/v0xdmjoglvI+4kzhx1aBPoVlF1LTWhE=;
        b=HROPzrfaFpiM1E4ykNGOLXBxtZIhRdkQKnw0lcMLVTlhM9/MEoi4ZouuJ43EdrZsKU
         BVqpVQvHv8gCW6fOu2LJcnsviGDSYfDfE7vArHf0WzYPsQUFAzKMboanKLzJti/6V7iR
         Xakm/4xHp4w10kPFpJLfqngb9WVOU1lgg9dWKiy0GCkjxivcit9OIeUDa3IzmUdy08Ni
         R7UQOWYUREEqMCY3wC9KASvJg4aZ4J7wAM+E+CZXrdAQXkXzsZjFX94DZ29rhRbpAX/B
         EVOGcaKgbwKgwexZLEkoYcFoA/XOy0JSJj3zIDf6/D+YJv3MUG2FqOl076Mclw9oUfhA
         JRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckHEoUSZG06/v0xdmjoglvI+4kzhx1aBPoVlF1LTWhE=;
        b=KPkC89jkVRt+FnGfnveg8Ji8rjE72elqKlgDEMh0LBCMw0U/gGf70A8p0S3jni/2Fh
         q0UFuJpoQUoHdsYmBePuXIZGqHzi/S1MZdJqm2gOXCNuXNqySe/npjpQoYE2FfNwkNMX
         nCvFZp9dB766QQIgCX1z+hEJsT7GsXz4nRhTzqLPNvt3qT9BWRbHEn8qXPWzLmFGNjLs
         1jC9ZdOt4dDdFdKGjko6DWeuD8hgMszN0R9JqWZJyZaNzvgrQdgRRWm0ndoqLgR1SnB3
         fIgjV/ZRusHE3M1lj8LGza6WLpGXKthMKCENC4mQv7k4DTYGmOc1sdoDYLYml7G7Xkry
         qbEg==
X-Gm-Message-State: AOAM530MXwBJbvYIKNHad63X5FTjp4Fq4gU8O23Upy7+KO8i2nxwp8su
        EBvaTPE6/XFy4MTx24Ws56piS0ZppC6hrA==
X-Google-Smtp-Source: ABdhPJwoj5RGTA++VCvN7Up/YDu7Ra1urWH5EBcmwuWgjCaj0gCKJ3CUtTiEqd4O0/1AndH0GQIwjQ==
X-Received: by 2002:a02:c6b3:: with SMTP id o19mr2613095jan.5.1631243115081;
        Thu, 09 Sep 2021 20:05:15 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u15sm1854658ilk.53.2021.09.09.20.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 20:05:14 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
Date:   Thu, 9 Sep 2021 21:05:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 8:57 PM, Al Viro wrote:
> On Thu, Sep 09, 2021 at 03:19:56PM -0600, Jens Axboe wrote:
> 
>> Not sure how we'd do that, outside of stupid tricks like copy the
>> iov_iter before we pass it down. But that's obviously not going to be
>> very efficient. Hence we're left with having some way to reset/reexpand,
>> even in the presence of someone having done truncate on it.
> 
> "Obviously" why, exactly?  It's not that large a structure; it's not
> the optimal variant, but I'd like to see profiling data before assuming
> that it'll cause noticable slowdowns.

It's 48 bytes, and we have to do it upfront. That means we'd be doing it
for _all_ requests, not just when we need to retry. As an example, current
benchmarks are at ~4M read requests per core. That'd add ~200MB/sec of
memory traffic just doing this copy.

Besides, I think that's moot as there's a better way.

-- 
Jens Axboe

