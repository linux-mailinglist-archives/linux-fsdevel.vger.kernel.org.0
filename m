Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33763405FEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 01:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbhIIXQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 19:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhIIXQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:16:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C7C061574;
        Thu,  9 Sep 2021 16:15:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso91611wme.4;
        Thu, 09 Sep 2021 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KMTbwzwcjYnRQvQNdjEYNklaNCqiGe953Wg0iDkUSI=;
        b=EomIaYlrmL0pDDibIkOOlCkdWy7uUai/odvkN6t3YoudNHjrMsQpvdpmqLaeXG2/Ir
         d/Xzn81T75JNS0lWekyaN3s6JquTcPXttLHb2w7JFcjY8ilTAPSFtIJXHTWvxVKEezKp
         HmG1yNTxA5nFCX34VjsTh0ZoiR8tbrboHI+VdC0gA6YT1dAKytUljdvTrQZwoSTn4x6e
         oCsC8X+PsU7bydXuBHJC6Kaijv7h6iabxvbKuscWIqcSIOrjsEpC/MhVgg8YDWb7+QGx
         2nw2dhjdVeX+i7UmBe9dJ4nxOuZkmwIL5cyAJOrdSJt78Epq4un4JcMdhHQUQaRRf6do
         J7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KMTbwzwcjYnRQvQNdjEYNklaNCqiGe953Wg0iDkUSI=;
        b=ZS5/HRPfWWUCDZFnY1RZQVCCAn92J2q/1uUzxrc6VjlnL8TowntdASwCxJpOCLMiVj
         boJjYaf75c3xsgafYB8LV7aY/Nd7Uqb8t4Zwr72QA2XD9P8w5VzYrYGv2jmmJmjE+3m3
         Q0iiGcdTxKNEXVgGTNypFvajkqCHg8ZxRAiy6YHUby9tjLwDB448lVPjuRjEmn+qGbMt
         +JGr/USo2rTzLO8YoU9iHXPb3OrSPllXiY+ww5AsWnEJAAE1CGU4Zc1Wdp4lkNaxVffU
         2Mz86qI2kM/RoK9yJEuppiXF2GlBj8JTvWiveJArmHsC5NcX94UQoO62KeLKIWlNibR5
         IoDw==
X-Gm-Message-State: AOAM532dfBE6u0M6nXU5PVwXTwQODS4grmTbFPjIzLcRvrxpdNsk6kJR
        gb1jsYBcUihjaCEGZNJqsC+/KnxTUlo=
X-Google-Smtp-Source: ABdhPJwZV3I1lE+UDnBl1PUfkp0e91qV/5KmLHjf9inYP+WhELn1ZVc0bx+sAnN/HWsHOeMwA7F0DQ==
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr5448551wmj.103.1631229318378;
        Thu, 09 Sep 2021 16:15:18 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.235.167])
        by smtp.gmail.com with ESMTPSA id a133sm2979523wme.5.2021.09.09.16.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 16:15:18 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <1864ae51-be13-23f9-1502-550be6624cf3@gmail.com>
Date:   Fri, 10 Sep 2021 00:14:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 8:37 PM, Linus Torvalds wrote:
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
> 
> Alternatively (and I'm cc'ing Jens) is is not possible for the
> io-uring code to know how many bytes it *actually* used, rather than
> saying that "ok, the iter originally had X bytes, now it has Y bytes,
> so it must have used X-Y bytes" which was actively wrong for the case
> where something ended up truncating the IO for some reason.
> 
> Because I note that io-uring does that
> 
>         /* may have left rw->iter inconsistent on -EIOCBQUEUED */
>         iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));
> 
> in io_resubmit_prep() too, and that you guys missed that it's the
> exact same issue, and needs that exact same iov_iter_reexpand().
> 
> That "req->result" is once again the *original* length, and the above
> code once again mis-handles the case of "oh, the iov got truncated
> because of some IO limit".
> 
> So I've pulled this, but I think it is
> 
>  (a) ugly nasty

Should have mentioned, I agree that it's ghastly, as mentioned
in the cover-letter, but I just prefer to first fix the problem
ASAP, and then carry on with something more fundamental and right.


>  (b) incomplete and misses a case
> 
> and needs more thought. At the VERY least it needs that
> iov_iter_reexpand() in io_resubmit_prep() too, I think.
> 
> I'd like the comments expanded too. In particular that
> 
>                 /* some cases will consume bytes even on error returns */
> 
> really should expand on the "some cases" thing, and why such an error
> isn't fatal buye should be retried asynchronously blindly like this?
> 
> Because I think _that_ is part of the fundamental issue here - the
> io_uring code tries to just blindly re-submit the whole thing, and it
> does it very badly and actually incorrectly.
> 
> Or am I missing something?
> 
>            Linus
> 

-- 
Pavel Begunkov
