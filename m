Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C562405FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 00:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbhIIW4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhIIW4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:56:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE64C061574;
        Thu,  9 Sep 2021 15:55:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso76897wmb.2;
        Thu, 09 Sep 2021 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8RfK6zZYm79jc1UWDGWZHStgyLyqAUG2I3xlomOJYS0=;
        b=OMx3TsuQkmhmujRmLGVx4VtWG2G/O6XnzGNdO/X2y6uIF2z06bv1nNyoIupwtbWnF/
         PIz2OKIHI3SyNkOzZvJ64HkRox5sqrg4Mh5+JScFg3+h5zeSolIIvFCnFcxS1ZvKP8Qs
         AWBr2961kWZ1vM2Ls20uAFrPYXbPNed0q4SYto/O05hnDmBuvSEsPZ9SbwfzSm7gweGI
         ApMv3rrZJrOO151XTt3tVoXoJ9GweXD3X3tAjcXoXWQXjZNEUdpByXs1GfaSa/+KYppg
         zz+V20UVGhKCXDaklDSI3UsUSXo99NUWft6YoToNGA13j+TxW6aHz/juZhS0vVwCeEHt
         iqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RfK6zZYm79jc1UWDGWZHStgyLyqAUG2I3xlomOJYS0=;
        b=YUpb7XZOqcfRU88J6yTlE2p0M2l741WvGXrl9gnAWDUcJWQ93r4HxgCguCEq60b9wz
         lQ7X2SCmRRPO0mLlAxYhEUHWv3EfAN3LfEysWuaS/RpktqsB1P8EZu+YE+IURgRPnFz+
         FrP0Egd/W7Zv0xgJmS5jyeBlVn3/bwtNjR67sn/HPUuZu1XhZLfSoxvJvJ0oTZx3rUH3
         dorL5NEIijVuW0OFOKoG1p73wIrvE8Rb4gSLs6r7llERL+t+A3Wa1TyJKXrj5hHOYvBT
         mbUdIB6EWRrnhFW3+zxgpaQtVZKSOJa1+s7jULONGm2C1xqGu28mruVwpraLyKWcnGsF
         wh4g==
X-Gm-Message-State: AOAM5308X7s04YtFWQuhhWuVpTxNNwcvh77ctQTUgOraKeXkXKuz3x/U
        guKOsEJCxDi2S0sKNhIoY4+TvDZTh2Y=
X-Google-Smtp-Source: ABdhPJy56AbH4cxWBlK46RaxejsdsXaBiGKCMMDxz3nMM5H9yUnjQ+SD59jqJqkz3DsY3gL4Bj3s/g==
X-Received: by 2002:a1c:7417:: with SMTP id p23mr5284139wmc.116.1631228132660;
        Thu, 09 Sep 2021 15:55:32 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.235.167])
        by smtp.gmail.com with ESMTPSA id h18sm2986876wrb.33.2021.09.09.15.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:55:32 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <84c85780-fe43-e95b-312d-b7671c65a7aa@gmail.com>
Date:   Thu, 9 Sep 2021 23:54:58 +0100
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

Maybe was worded not too clearly, my apologies.


> It really smells like io-uring is doing a "iov_iter_revert()" using a
> number that it pulls incorrectly out of its arse.

It's not invented by io_uring,

filemap.c : generic_file_direct_[write,read]()

do the same thing. Also, the block layer was not re-expanding before
~5.12, so it looks it was possible to trigger a similar thing without
io_uring, but I haven't tried to reproduce. Was mentioned in the
cover-letter.

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

Right. It was covered by v1-v2, which were failing requests with
additional fallback in v2 [1], but I dropped in v3 [2] because there
is a difference. Namely io_resubmit_prep() might be called deeply down
the stack, e.g. in the block layer.

It was intended to get fixed once the first part is merged, and I do
believe that was the right approach, because there were certain
communication delays. The first version was posted a month ago, but
we missed the merged window. It appeared to me that if we get anything
more complex 

 



do that at the bottom of stack.




 how deep in the stack we do that. It was indended to
be 


[1] https://lkml.org/lkml/2021/8/12/620
[2] https://lkml.org/lkml/2021/8/23/285

> 
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
