Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE040660C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhIJDXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhIJDXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:23:43 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4DCC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 20:22:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s16so609760ilo.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EvIKhcEAdqIX2oPTeV2qcqjuPBERBJ9PR89hwHrrM/g=;
        b=zo7SZOF+zEI1ym97HonQU2W1Yus3eovW6l82Jvq6a0nxgBIH9mrs8aus1GjvBiXqEj
         fmjTSd9kNsEzETkPJW90TgsV4yjffghQHrgWH3+5lN4b0liLQvP8+OjSPmsKhdO/pOle
         57HRdc9jqClJVs8LsmUB5rMq1e6NNItgKEeVfAR9ekzN6ZJnObKuDesZnhiA/9JLHPO+
         f5O44vMJtLZalIE7eQq/TuLp7+sTyKFbD1ZGXGX8qPNpPEywVqJ1gC5Yy2ORXfM8aht6
         INEYNHI7LpUo+J0BxONN636yJuBRO07yCwYb4SaXLoE5P3V/jk3nmdhhM7k25T8674Al
         qy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EvIKhcEAdqIX2oPTeV2qcqjuPBERBJ9PR89hwHrrM/g=;
        b=S1NtDSv5aWN9WuoLbSwiwwtLcRMpz8xMV0YJQ2m/3xPvZTRc+KdEJd5EyV4qhDGnT4
         CDlZJh+M58/jok3RwMVX1G6xubTy56Saxwtp0+28VRPzYTcYm0ZiQgS3MFxoev1RQ+Q8
         KQ3CNtXHF8gnkWMFdXH+891JXYVIgIy1t1r8CXAgdSypGXPx7S6W4UhJ+sGu5l3tgSZ+
         mHmmuerzb5s2Zx770U+gizJFq0cwESbciv0A5u5deR9sbLI8k0uKapdODbhd2JqGAt+H
         pEc+tQVBlJw/lcsgM5c4DOipUx6+NJtb9PGZwwEQ/6n+p0lduB5rl1TLsFQdQfQqcEAm
         SJEw==
X-Gm-Message-State: AOAM530rLvqjS1p0TvwzjnpWuiEaVu7msiRsGmi0HGIHmbIzc6YvKfHC
        1YyAIGSSbKJVMAYJlwnBnIRbuV9sajrBEw==
X-Google-Smtp-Source: ABdhPJzmZ236OO7DLFvFfRKWpAeT2W3uSVeBClLTwXMD2qRNpAMlCOCiEfrguqYJEyaD38nPELeMtg==
X-Received: by 2002:a05:6e02:1074:: with SMTP id q20mr4867076ilj.204.1631244151770;
        Thu, 09 Sep 2021 20:22:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t14sm1858429ilu.67.2021.09.09.20.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 20:22:31 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
Date:   Thu, 9 Sep 2021 21:22:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 9:11 PM, Al Viro wrote:
> On Thu, Sep 09, 2021 at 09:05:13PM -0600, Jens Axboe wrote:
>> On 9/9/21 8:57 PM, Al Viro wrote:
>>> On Thu, Sep 09, 2021 at 03:19:56PM -0600, Jens Axboe wrote:
>>>
>>>> Not sure how we'd do that, outside of stupid tricks like copy the
>>>> iov_iter before we pass it down. But that's obviously not going to be
>>>> very efficient. Hence we're left with having some way to reset/reexpand,
>>>> even in the presence of someone having done truncate on it.
>>>
>>> "Obviously" why, exactly?  It's not that large a structure; it's not
>>> the optimal variant, but I'd like to see profiling data before assuming
>>> that it'll cause noticable slowdowns.
>>
>> It's 48 bytes, and we have to do it upfront. That means we'd be doing it
>> for _all_ requests, not just when we need to retry. As an example, current
>> benchmarks are at ~4M read requests per core. That'd add ~200MB/sec of
>> memory traffic just doing this copy.
> 
> Umm...  How much of that will be handled by cache?

Depends? And what if the iovec itself has been modified in the middle?
We'd need to copy that whole thing too. It's just not workable as a
solution.

>> Besides, I think that's moot as there's a better way.
> 
> I hope so, but I'm afraid that "let's reload from userland on e.g. short
> reads" is not better - there's a plenty of interesting corner cases you
> need to handle with that.

As long as we're still in the context of the submission, it is tractable
provided we import it like we did originally.

-- 
Jens Axboe

