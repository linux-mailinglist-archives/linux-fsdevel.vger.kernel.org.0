Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7032405EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 23:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346284AbhIIVVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 17:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhIIVVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:21:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE305C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 14:19:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k24so3156860pgh.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVQsnA+/48NDgsa0ERzz48a22mi7/7hTiVzbzvzJrZA=;
        b=gUjhO46jwOh1PpfmgdU9Us8fJSc9lrNtuZOLqMiM9G2X1/PAMrSshYzVWRuVWxEsWv
         PowFsm89yC3Zhr8pijYn6se6qrPvDU+5w7H+B+KMy36hVsFpuMkPplFS6ARL+C+QJYxr
         W471fmvuhi5s8whbOFk/t6OwgR8WEveOonw1lR3oCjmBf5z2o+dQKF5FFAj4oHIh7cAJ
         +tj6stip6lUiOf1uWoaLC9zNbtKQ0qjF4RNfRfpVyqxy7a9v4/70at7EcMQGDHi8YVPh
         f6jow8d7WJ0b+jJPmdyjy+UY46ljxWkyqm/f1ymCqOlzlRmFFPWZQD2JAX750iVOXz2n
         V9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVQsnA+/48NDgsa0ERzz48a22mi7/7hTiVzbzvzJrZA=;
        b=OLlhNBwtKxW06v8AlciI9qz/QquePc/ybLrQrAjVoS2qFWRgE15i3l/UOS+Y6q6qJk
         n9b3sGWNsGoz/DdQo39cT6tZHPEtmUK6n+HDmRefde7cniNX0YPOkz5FGNEd6clOIVJD
         +TV5Ox//Dh/0Z0xthx8sOYl6k/4aLj2qOqo8xE2h1nPBxpvCp04riAMFJ+FO50G3kZgG
         OapBeLVLW5AsDz8yviZgfeiSxqWcAT8naiCz68lYqKCR/orKdERhLF3wXMo7n1iU2H0z
         K7HymdVTzOrsCb1Z4TQAdzJzZH4XHIPOBsY9KGrHrGXFjF6rAR9g2ewAOLQauXKRzxPV
         kWOA==
X-Gm-Message-State: AOAM532B9gZjin0AJZm+lZMjvITA/2d4/mMG5sK5CPcvBJOkGqZDd/kY
        fRwiaj7vU6oOFlrbzKUtlWuLfeFLFwb5VQ==
X-Google-Smtp-Source: ABdhPJxsWbMsYjKdO1r8JFNw8Giqntq3LlooqZQwtpda9hxwo3o43bG9UP9clPaUbRGBK9gbDm843w==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr4515841pgv.339.1631222397876;
        Thu, 09 Sep 2021 14:19:57 -0700 (PDT)
Received: from ?IPv6:2600:380:496f:85f0:f855:eb52:c00a:147a? ([2600:380:496f:85f0:f855:eb52:c00a:147a])
        by smtp.gmail.com with ESMTPSA id 138sm3090886pfz.187.2021.09.09.14.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 14:19:57 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
Date:   Thu, 9 Sep 2021 15:19:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 1:37 PM, Linus Torvalds wrote:
> On Wed, Sep 8, 2021 at 9:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>>         Fixes for io-uring handling of iov_iter reexpands
> 
> Ugh.
> 
> I have pulled this, because I understand what it does and I agree it
> fixes a bug, but it really feels very very hacky and wrong to me.
> 
> It really smells like io-uring is doing a "iov_iter_revert()" using a
> number that it pulls incorrectly out of its arse.
> 
> So when io-uring does that
> 
>                 iov_iter_revert(iter, io_size - iov_iter_count(iter));
> 
> what it *really* wants to do is just basically "iov_iter_reset(iter)".
> 
> And that's basically what that addition of that "iov_iter_reexpand()"
> tries to effectively do.
> 
> Wouldn't it be better to have a function that does exactly that?

That might indeed be better. Alternatively, consumers that truncate
should expand. Part of the problem here is the inconsistency in how they
are consumed.

> Alternatively (and I'm cc'ing Jens) is is not possible for the
> io-uring code to know how many bytes it *actually* used, rather than
> saying that "ok, the iter originally had X bytes, now it has Y bytes,
> so it must have used X-Y bytes" which was actively wrong for the case
> where something ended up truncating the IO for some reason.

Not sure how we'd do that, outside of stupid tricks like copy the
iov_iter before we pass it down. But that's obviously not going to be
very efficient. Hence we're left with having some way to reset/reexpand,
even in the presence of someone having done truncate on it.

> Because I note that io-uring does that
> 
>         /* may have left rw->iter inconsistent on -EIOCBQUEUED */
>         iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));
> 
> in io_resubmit_prep() too, and that you guys missed that it's the
> exact same issue, and needs that exact same iov_iter_reexpand().

I think you're right on that one, there's no difference between that use
case and the other two...

> That "req->result" is once again the *original* length, and the above
> code once again mis-handles the case of "oh, the iov got truncated
> because of some IO limit".
> 
> So I've pulled this, but I think it is
> 
>  (a) ugly nasty
> 
>  (b) incomplete and misses a case
> 
> and needs more thought. At the VERY least it needs that
> iov_iter_reexpand() in io_resubmit_prep() too, I think.
> 
> I'd like the comments expanded too. In particular that
> 
>                 /* some cases will consume bytes even on error returns */

That comment is from me, and it goes back a few years. IIRC, it was the
iomap or xfs code that I hit this with, but honestly I don't remember
all the details at this point. I can try and play with it and see if it
still reproduces.

> really should expand on the "some cases" thing, and why such an error
> isn't fatal buye should be retried asynchronously blindly like this?

That would certainly make it easier to handle, as we'd never need to
care at that point. Ideally, return 'bytes_consumed' or error. It might
have been a case of -EAGAIN after truncate, I'll have to dig a bit to
find it again. Outside of that error, we don't retry as there's no point
in doing so.

> Because I think _that_ is part of the fundamental issue here - the
> io_uring code tries to just blindly re-submit the whole thing, and it
> does it very badly and actually incorrectly.
> 
> Or am I missing something?

I think the key point here is re-figuring out where the
consumption-on-error comes from. If it just ends up being a truncated
iov, that's all good and fine. If not, that feels like a bug somewhere
else that needs fixing.

-- 
Jens Axboe

