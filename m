Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFAE4E3714
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 04:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiCVDCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCVDBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:01:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859463CC079
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 20:00:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c23so3246290plo.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RzVuelNI2AwOdHgTJeZRkK10NlR1LXLVgV6an4tPhcQ=;
        b=SF0Mrb+pFyaMJs4NpQlsEJFtzjpeajvb9wsy7EXksQ1pskc0b3dnSIM/S5+47acrJn
         ExawpbsCRP3ASC8QNyWJlYDTPsRNK+9KWVkHAEkVmTnpOBVnN5mVT+hemjUg65kg1pRQ
         MiNzvRW+xoF1DrFWXMIVXD/1mbT3tZ13nSQ81DbZK29Gr+gMPFIRGbElH6cD7UY0YNjz
         GcxS6iSPAacOYC1BUB69cHgorboHCmGMZkWB9tiUkgRL3j9OwFYgjFpbfQvTChiyQOqS
         Ys9HBn4QtzN9psBnUKfGZTeBKzWxr8SL8l8w2SOmspV2PyLSlas4tIhoTs8bwyH2vtbC
         bWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RzVuelNI2AwOdHgTJeZRkK10NlR1LXLVgV6an4tPhcQ=;
        b=0Ksp9kHLTaJN7w/I25P1Uuy79twb+KDKfG01jWJD+BdAyx5fTLjaJhM7z32P1dZ6bL
         E8eBkOsgZPLbLwb5zD5B5RwehoYvgQNqw80EjG17JH2hxT7ZgaHFi9zTKZaEnYJtk/vx
         wY8dKadvDJ1p1Wsm4lyxNia323KBs7ZAzibnK7cxeQeiYlnLl+rydibRDJWnbVygivbQ
         Zxy3+ZzxPvObb021L5qyrFUh6gr1LzTsDBrzoKd9Ud3Lr6Nb6P4XfwAI4kSO3+deUQVR
         dltjlPzEWsdzEL7G4ke5oG0dpR+f+x0l5Q/UR0PMG2S+KGTJxpfIZqdTRDNA2CxzD+Ct
         uG9Q==
X-Gm-Message-State: AOAM532emPmH+EuXOzquRIzbAQwqrzuQtifNOoUwh/ccH+Fh46as2MF4
        Fs8i5havEu+el2x6veZ/RPiZAg==
X-Google-Smtp-Source: ABdhPJzqsWzFp8b5ujjHvCW8qMWrQJIDysrei1NqqhWmcubE9Ovdk3wLZdEbYFtQx0sUDow/QYikJQ==
X-Received: by 2002:a17:90b:1d0e:b0:1c7:6148:9c4b with SMTP id on14-20020a17090b1d0e00b001c761489c4bmr548055pjb.67.1647918028903;
        Mon, 21 Mar 2022 20:00:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b004fa79973c94sm11306670pfn.165.2022.03.21.20.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 20:00:28 -0700 (PDT)
Message-ID: <4c2c548a-9a00-a5f5-5bb6-7653df5ae567@kernel.dk>
Date:   Mon, 21 Mar 2022 21:00:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
 <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
 <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
 <Yjk4LNtLLYOCswC3@casper.infradead.org>
 <d4fe91bf-5285-862d-4c2c-219161daec26@kernel.dk>
 <Yjk7EWuODBnkFiz6@kbusch-mbp.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yjk7EWuODBnkFiz6@kbusch-mbp.dhcp.thefacebook.com>
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

On 3/21/22 8:57 PM, Keith Busch wrote:
> On Mon, Mar 21, 2022 at 08:50:10PM -0600, Jens Axboe wrote:
>> On 3/21/22 8:45 PM, Matthew Wilcox wrote:
>>> On Mon, Mar 21, 2022 at 08:13:10PM -0600, Jens Axboe wrote:
>>>> On 3/8/22 5:55 PM, Jens Axboe wrote:
>>>>> On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
>>>>>> This field is entirely unused now except for a tracepoint in f2fs, so
>>>>>> remove it.
>>>>>>
>>>>>>
>>>>>
>>>>> Applied, thanks!
>>>>>
>>>>> [1/2] fs: remove kiocb.ki_hint
>>>>>       commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
>>>>> [2/2] fs: remove fs.f_write_hint
>>>>>       commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf
>>>>
>>>> Upon thinking about the EINVAL solution a bit more, I do have a one
>>>> worry - if you're currently using write_hints in your application,
>>>> nobody should expect upgrading the kernel to break it. It's a fine
>>>> solution for anything else, but that particular point does annoy me.
>>>
>>> But if your application is run on an earlier kernel, it'll get
>>> -EINVAL. So it must already be prepared to deal with that?
>>
>> Since support wasn't there, it's not unreasonable to expect that an
>> application was written on a newer kernel. Might just be an in-house or
>> application thing, who knows? But the point is that upgrading from 5.x
>> to 5.x+1, nobody should expect their application to break. And it will
>> with this change. If you downgrade a kernel and a feature didn't exist
>> back then, it's reasonable to expect that things may break.
>>
>> Maybe this is being overly cautious, but... As a matter of principle,
>> it's unquestionably wrong.
>>
>> We can just let Linus make the decision here, arming him with the info
>> he needs to make it in terms of hardware support. I'll write that up in
>> the pull request.
> 
> It's really just an advisory hint at the hardware level anyway, so
> returning success without actually doing anything with it technically
> satisfies the requirement.

Yes that's my point, nobody will know that the hints do nothing, all I
care about here is that the user ABI doesn't change. I know I originally
advocated for -EINVAL and I do think it's correct for _most_ cases, it's
just that it does have the potential to mess up a legit kernel upgrade
scenario which is exactly the kind of thing we don't want to happen.

-- 
Jens Axboe

