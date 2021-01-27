Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4D3060F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhA0QYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 11:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343587AbhA0QXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:23:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC54C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 08:22:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g15so1671094pjd.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVjq9S8vPnIaMaJuKUlW9AEfrTuqdOcWOcfrMncSWG8=;
        b=MSwLyioJQHmb3RlWN5K/h0uCtQwuaTflKp4FvbqSJzDh+ijpnoSGkjnrg0bMXr75bn
         QOcgxcMfAQhpl8vFKZOJFTqcd2YRMtk9enO2yAEYF9ykZBArE+IYcr2l/lxj1gbYwfnW
         LCZylyc17znb9pcfUGlnSwYmT5dxXP8fiCR25+QUf4EfvTtPm4jkLYYmtqxCzVKx10H2
         5HjvUtO943SH4+dD6DARX8sdz77VWGfS/GWz3VaKoejOlLOzlOhfE8wx5rVMZOxGbg50
         5J6NTqjydgV5jLgspOH0d8Tu/wP/FfxPT3I60VKD5yfy9pJ1mCP2zBe4/NSTn9MBHHBu
         1VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVjq9S8vPnIaMaJuKUlW9AEfrTuqdOcWOcfrMncSWG8=;
        b=X26efgEKfciVuJxcu3fLU6VvJRdI2uAaWRJH9EnN1Kb7egYU9v/KifUSBpeDB7o2xI
         /i33fdEAtSllm6cWStBxLC6R5WAQm8aAMqn7njgcAff+2ynDrQv7SDo3lQzXp1sTd1Dw
         geZIgqUVFU6/W4JjwFBvhK3qi+1Cp5a0eHgYG8jeILLWNMbD22YDSYKSr3kLpCuP9iyp
         M3oTgUUQaoog2B/Ne5RxSwJL7C1OfUltkvLzbGWjfq4sqkFvqtdRbWCyBIfQWokzt2/h
         icKVh9i8yKi8KspRMFMn4wzUrqu/mHf7shTPjn0UpfzpRS0+DiTZE8uUjrP4OKUn2qrx
         1ViQ==
X-Gm-Message-State: AOAM531cVJC227Zp31WnKQqybstG83RlN51F5KPyFx4j6n9v6f5ustll
        Q7kbHNw6mq0kRdqp+5Vc+Zcw5oZ3J5LLWA==
X-Google-Smtp-Source: ABdhPJzmzHNGRy7gsxRAlKffUjZofNt/Y279WX8g0zuIMUfGldmkIIeLNyGOkRskF48NZdhidRDKyA==
X-Received: by 2002:a17:902:f68d:b029:e1:d20:8641 with SMTP id l13-20020a170902f68db02900e10d208641mr1155803plg.81.1611764569786;
        Wed, 27 Jan 2021 08:22:49 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s24sm2873032pfd.118.2021.01.27.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:22:49 -0800 (PST)
Subject: Re: [PATCH 0/2] io_uring: add mkdirat support
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     io-uring <io-uring@vger.kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
References: <20201116044529.1028783-1-dkadashev@gmail.com>
 <3bb5781b-8e48-e4db-a832-333c01dba8ab@kernel.dk>
 <CAOKbgA6CAe22WknmGC7-bYDkwHRLBVqm9vUq6tz7Qp9ZECztpQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86ab3221-ea4f-3578-6937-8ec2c191c6af@kernel.dk>
Date:   Wed, 27 Jan 2021 09:22:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOKbgA6CAe22WknmGC7-bYDkwHRLBVqm9vUq6tz7Qp9ZECztpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/21 4:06 AM, Dmitry Kadashev wrote:
> On Wed, Jan 27, 2021 at 5:35 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/15/20 9:45 PM, Dmitry Kadashev wrote:
>>> This adds mkdirat support to io_uring and is heavily based on recently
>>> added renameat() / unlinkat() support.
>>>
>>> The first patch is preparation with no functional changes, makes
>>> do_mkdirat accept struct filename pointer rather than the user string.
>>>
>>> The second one leverages that to implement mkdirat in io_uring.
>>>
>>> Based on for-5.11/io_uring.
>>
>> I want to tentatively queue this up. Do you have the liburing support
>> and test case(s) for it as well that you can send?
> 
> I do, I've sent it in the past, here it is:
> https://lore.kernel.org/io-uring/20201116051005.1100302-1-dkadashev@gmail.com/

I thought so, thanks. I'll queue it up once we have agreement on the
kernel side.

> I need to (figure out the way to) fix the kernel / namei side after Al's
> comments though.

Thanks, yes please do and re-post it.

-- 
Jens Axboe

