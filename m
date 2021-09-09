Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B1405F58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhIIWWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbhIIWWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:22:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A637C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 15:21:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m21-20020a17090a859500b00197688449c4so63726pjn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZYRCogdjrmnSAVx4pAQ8/+G6/DhQ9wIsSfrzKtwXjnw=;
        b=UGFT2Mu6b8not/9wAFQwXTaYtxlHjeRVEz8Kgt52x4i9O51VzldSh0tCJ7frnQXn4v
         NmiSBoZG0MseTNF5GJaQo76UobX66Ce/KaAjYw1zDrI54pXOZSm5KHY+GrDtpe68o2AQ
         TPojFdd7jEZDJbUpmMmydqJnvmIcOXIn7CEsObKdRfh0P19JdJ6u6SwDbcVBoN8yUxOU
         ZX9Xs+GPA27fn/+ri/zZpSJGXuEIwrQjxn/2ygwFSbXXqFaQkePsJNPPOhtlsUgHEV6G
         JOiYJXGRzOD/nXh04c8fOzUWGC+yh5uQrHFtSIJzkPA1uhxF442bzHpNLclT0ooEiZfJ
         GG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZYRCogdjrmnSAVx4pAQ8/+G6/DhQ9wIsSfrzKtwXjnw=;
        b=im7B8OHr3P1UlEoyGUJiXnKi++93QvqrMZlHAgRFjssWqXnIJP+708LiFru/ITKpxR
         8PIGPxdgCUtgHG+yQEF7ykHti14Y1FsVyVVeGGPFfZWKwQMz7aVCOSs942lEBxaN4GBn
         E8s3yV7JqZpT25uUiawzmqAcE+uC9jrnlrODS2jFwiz/W6yznAqVzPT9ZwQTHTu8Nyvd
         Y/diKOSgDFlTH2VuKTVsp0SXVWB9cXX4fjRkvyX4/KKGi8pkgohoun/77MJuRHISyDJm
         hE3XzKpSuQax8ulLOhy0rc1U2vxEB+PDQgF2dFvyQIc+Mg3dcDcKmkCP/hHIoXA0N08c
         RSTw==
X-Gm-Message-State: AOAM5303GdHihZW+s1v/q3YtLPQp5aVUpTpfyRxmI2UQx+8u/D+KTBWs
        jRf0ZRv7FoTIss85iQbsTvwmoj+CnGeKixZo
X-Google-Smtp-Source: ABdhPJynnS2UzUsFLJWTjN9+tqX3GhiYjQZwxG4Ry0y0PzSYQM0Jl4jLqq/yL4u93BoqbB8ny7IAew==
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr5984420pjv.39.1631226089094;
        Thu, 09 Sep 2021 15:21:29 -0700 (PDT)
Received: from ?IPv6:2600:380:493f:1449:e28:511f:af71:e967? ([2600:380:493f:1449:e28:511f:af71:e967])
        by smtp.gmail.com with ESMTPSA id q2sm3044603pjo.27.2021.09.09.15.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:21:28 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
Date:   Thu, 9 Sep 2021 16:21:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 3:56 PM, Linus Torvalds wrote:
> On Thu, Sep 9, 2021 at 2:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> OK, one that I immediately found is just doing O_DIRECT to a block
>> device or file on XFS. As pages are mapped and added, the iov_iter is
>> advanced. If we then go and submit and get -EAGAIN, for example, then we
>> return with what we mapped already consumed.
> 
> Ok, that's annoying but understandable. Dave points to a commit that
> removes one of the EAGAIN cases, but apparently not some others.

That one just catches it upfront so we -EAGAIN immediately, which does
make it a lot easier to handle. But yes, that's an example.

The case I mention we basically always consume the whole iov, to the
extent that we can map it to a bio. But there's really no way around
that, we have to map it before we can attempt to do that IO.

> I do kind of wonder if you can't have the exact same case when *some*
> of the IO succeeds, though.
> 
> IOW, can't we have  that
> 
>         ret = io_iter_do_read(req, iter);
> 
> return partial success - and if XFS does that "update iovec on
> failure", I could easily see that same code - or something else -
> having done the exact same thing.
> 
> Put another way: if the iovec isn't guaranteed to be coherent when an
> actual error occurs, then why would it be guaranteed to be coherent
> with a partial success value?
> 
> Because in most cases - I'd argue pretty much all - those "partial
> success" cases are *exactly* the same as the error cases, it's just
> that we had a loop and one or more iterations succeeded before it hit
> the error case.

Right, which is why the reset would be nice, but reexpand + revert at
least works and accomplishes the same even if it doesn't look as pretty.
We do return how much IO was actually done from the various
->read/write_iter() obviously, and that cannot be incorrect. It's just
that the iov_iter doesn't necessarily agree with that view and more (or
all) may have been consumed regardless of the return value. The truncate
was really the part that made it impossible to handle.

-- 
Jens Axboe

