Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758D6559D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiFXPaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiFXP36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:29:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1C30573
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jun 2022 08:29:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id k6so1727852ilq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jun 2022 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2hs1f7jeGoG2uZdKdIrv89g81apP4iF3ARLUcOcdLP0=;
        b=vgN9m7GFpwF8Hvp7paiW/USJX1EgzxyEnhJ78jrrg3Z9uZX2bGIn6hxQZC1VMMrAVX
         rm/Hzzv+DqqIhohtxoVLUUCD+kwpwOCVrgNxYyUkb/Zu4KR4Da0dAMX3maLnxsNmX97L
         BuHbTsntXix3u0S3c9bU9VobzlBVLn9joLsDfICg8PUmG5wXnngTTC1L5dHTSYlg29+0
         XrfIPtLx7/3CdqKGN2g9vOsPe0rNeS3IQxBv2x64DS8vg1wEp82fiA+/oqdE7s87Jfyb
         ODuHo00eFB4zzFHEtdh8jd0/Juh+JGgX37WYcrJWksPZdcoZ8Fnx4xepwczY3uobObFy
         5POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2hs1f7jeGoG2uZdKdIrv89g81apP4iF3ARLUcOcdLP0=;
        b=vW2fG+IVGfx3DmyDw9kWa8lM/ApEzu45rnd/EdoQMzSCQJwdrfqdCqs9FfVMk6J59R
         AqJ89i9c/0ZWBDzJU6RLF0hKeHDVeBjk8d20u1QVQFQSf9IbRiX1oJUxsgWCsMRZNE9f
         yfeeJgP/CreptPZwqdoBs+3daF79coYzmIGNH75E18rvlR9GVppjoGKggd4EnzfmMD9j
         iS5GyjwBQnz81s9x6d5K/Tl0/yTeVFZ4/7vyCklGqyXZGvNy1rWvRBRyZ5qXgZzQOXrf
         99lbgKJBRzIfWph6iXUnI3T50CMaa0G+6JfS0bJR7hIcXz1O4znEajN99lnzL+YPGvx5
         GsvQ==
X-Gm-Message-State: AJIora/JznfkQaZ3Xka/8d8OAGl77Hh0doz27s80GE/+hlUyFDcBCJNv
        HCaZUcmSq7WicbzqW83x5hok8Q==
X-Google-Smtp-Source: AGRyM1uHMw2DITKQ+uHb0jGlQ5HFn99ATtPXeF6AqEyv9DFM2mUPaMAaV7E8KX8wpEaUVA7jT1Nzmw==
X-Received: by 2002:a05:6e02:18c6:b0:2da:6f33:71e8 with SMTP id s6-20020a056e0218c600b002da6f3371e8mr499111ilu.229.1656084596603;
        Fri, 24 Jun 2022 08:29:56 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k3-20020a6bef03000000b0067511446707sm337573ioh.21.2022.06.24.08.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:29:55 -0700 (PDT)
Message-ID: <adaa40ed-8acd-53ee-7adf-62441f83093e@kernel.dk>
Date:   Fri, 24 Jun 2022 09:29:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH v9 00/14] io-uring/xfs: support async buffered
 writes
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, jack@suse.cz,
        willy@infradead.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20220623175157.1715274-1-shr@fb.com> <YrTNku0AC80eheSP@magnolia>
 <YrVINrRNy9cI+dg7@infradead.org>
 <2189b2ff-e894-a85c-2d1b-5834c22363d5@kernel.dk>
 <4ce26ef8-b70f-9213-3210-41f32867df63@gnuweeb.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4ce26ef8-b70f-9213-3210-41f32867df63@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/22 9:27 AM, Ammar Faizi wrote:
> On 6/24/22 9:49 PM, Jens Axboe wrote:
>> On 6/23/22 11:14 PM, Christoph Hellwig wrote:
>>> On Thu, Jun 23, 2022 at 01:31:14PM -0700, Darrick J. Wong wrote:
>>>> Hmm, well, vger and lore are still having stomach problems, so even the
>>>> resend didn't result in #5 ending up in my mailbox. :(
>>>
>>> I can see a all here.  Sometimes it helps to just wait a bit.
>>
>> on lore? I'm still seeing some missing. Which is a bit odd, since eg b4
>> can pull the series down just fine.
> 
> I'm still seeing some missing on the io-uring lore too:
> 
>    https://lore.kernel.org/io-uring/20220623175157.1715274-1-shr@fb.com/ (missing)
> 
> But changing the path to `/all/` shows the complete series:
> 
>    https://lore.kernel.org/all/20220623175157.1715274-1-shr@fb.com/ (complete)
> 
> b4 seems to be fetching from `/all/`.

Ah, I see. Konstantin, do you know what is going on here? tldr - /all/
has the whole series, io-uring list does not.

-- 
Jens Axboe

