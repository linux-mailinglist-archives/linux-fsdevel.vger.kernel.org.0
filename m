Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB16B4D4698
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 13:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbiCJMQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 07:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiCJMQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:16:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4F1480DF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 04:15:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n2so4705430plf.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 04:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hoPWBro4VveouJ4vx2nAAxYFxr+KDw+cTxYyidREMFo=;
        b=3lHvgXyOZWgBu7xmQFS37eeUDuf1cB/DlgDJKt7JktscFsHvnp2Z8HCO7AOl2uhI4v
         IfKhXbGVbCyxw6KBqmCJJj9pXcgNwwx8ywoRtiOyPNStQnrxq6KFtxGsd3biz/AqcHWW
         j/w7UdCS6+jAfG4hgQcTgSKFx6XIqC3Hw8YADTHIrxFAt+0Rmac4VbfJyn/Y1VvMEj6d
         VMO8rDYU5jzoD8Ukc1lKq/tWuwpvqQxOdscRi7bEgiCGO5gHq1sZuu1Qy9OGPoqkq6Bb
         HqFsp7iKPtFoQ8ApxZav7UKCYUNl9udtO7+ktT1RlPCAqGWAg58SD0xHYkrZOrmdn/8K
         1cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hoPWBro4VveouJ4vx2nAAxYFxr+KDw+cTxYyidREMFo=;
        b=wc/4DHb5wLsGuGX6Vq0Ufi8nYyEOuy+r9M4IhyTTBtvtxEUw8DPWdCzCrZR0Yj5ScZ
         fZdfwPdS11dH2BZzZXJ8lKFTLBGv0PkfrjozGWmQq/HbzLbkS2NCc7yQTDd1wazpx8Hu
         8ICD3N2HcbYCHGXD5NDcjF13S4BNQBtDvKhWbRBlpJ/VKSqI0DFw62N9+IRcUJIYE5m0
         neWGi5xSxqxM3JkL11do2Ci/aW047pD6u5rkFsIm1RV43EngyBYkfJ7j8xqH1AirjD/b
         FA4DYjzRhFZdIJb+GXWfOh5dy/E7SfN/Mo3It7I8M+rWlKIzoVWJhf8gKU6JLptby3iq
         RDHQ==
X-Gm-Message-State: AOAM5322bdPjbxYIRwoMrf5Y97dHlOzIy6VbCjUsPxAJ0yKwLso9Db24
        iHRl6vcftA88Oe4UKcAc2bMxGw==
X-Google-Smtp-Source: ABdhPJzSQmxtoIBTxfTuTtDJblYzgJmRRteHsYoyEbd/AE8Ym0coXr6/kU1kFb735T1a56f84F6JHQ==
X-Received: by 2002:a17:90b:3a8f:b0:1bf:ccc:59bc with SMTP id om15-20020a17090b3a8f00b001bf0ccc59bcmr4730847pjb.234.1646914513229;
        Thu, 10 Mar 2022 04:15:13 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o66-20020a17090a0a4800b001bf388fc96esm5918336pjo.21.2022.03.10.04.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:15:12 -0800 (PST)
Message-ID: <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
Date:   Thu, 10 Mar 2022 05:15:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/22 4:34 AM, Luca Porzio (lporzio) wrote:
>> -----Original Message-----
>> From: Manjong Lee <mj0123.lee@samsung.com>
>> Sent: Wednesday, March 9, 2022 2:31 PM
>> To: david@fromorbit.com
>> Cc: axboe@kernel.dk; hch@lst.de; kbusch@kernel.org; linux-
>> block@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
>> nvme@lists.infradead.org; linux-raid@vger.kernel.org; sagi@grimberg.me;
>> song@kernel.org; seunghwan.hyun@samsung.com;
>> sookwan7.kim@samsung.com; nanich.lee@samsung.com;
>> woosung2.lee@samsung.com; yt0928.kim@samsung.com;
>> junho89.kim@samsung.com; jisoo2146.oh@samsung.com
>> Subject: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write hint.
>>
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> you recognize the sender and were expecting this message.
>>
>>
>>> On Sun, ddMar 06, 2022 at 11:06:12AM -0700, Jens Axboe wrote:
>>>> On 3/6/22 11:01 AM, Christoph Hellwig wrote:
>>>>> On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
>>>>>> Yes, I think we should kill it. If we retain the inode hint, the
>>>>>> f2fs doesn't need a any changes. And it should be safe to make the
>>>>>> per-file fcntl hints return EINVAL, which they would on older kernels
>> anyway.
>>>>>> Untested, but something like the below.
>>>>>
>>>>> I've sent this off to the testing farm this morning, but EINVAL
>>>>> might be even better:
>>>>>
>>>>> https://urldefense.com/v3/__http://git.infradead.org/users/hch/bloc
>>>>> k.git/shortlog/refs/heads/more-hint-
>> removal__;!!KZTdOCjhgt4hgw!qsgy
>>>>>
>> oejchUYPeorpCL0Ov3jPGvXpXgxa7hpSCViD7XQy7uJDMDLo3U8v_bmoUtg$
>>>
>>> Yup, I like that.
>>>
>>>> I do think EINVAL is better, as it just tells the app it's not
>>>> available like we would've done before. With just doing zeroes, that
>>>> might break applications that set-and-verify. Of course there's also
>>>> the risk of that since we retain inode hints (so they work), but fail file
>> hints.
>>>> That's a lesser risk though, and we only know of the inode hints
>>>> being used.
>>>
>>> Agreed, I think EINVAL would be better here - jsut make it behave like
>>> it would on a kernel that never supported this functionality in the
>>> first place. Seems simpler to me for user applications if we do that.
>>>
>>> Cheers,
>>>
>>> Dave.
>>> --
>>> Dave Chinner
>>> david@fromorbit.com
>>>
>>
>> Currently, UFS device also supports hot/cold data separation and uses
>> existing write_hint code.
>>
>> In other words, the function is also being used in storage other than NVMe,
>> and if it is removed, it is thought that there will be an operation problem.
>>
>> If the code is removed, I am worried about how other devices that use the
>> function.
>>
>> Is there a good alternative?
> 
> Hi all,
> 
> I work for Micron UFS team. I confirm and support Manjong message above.
> There are UFS customers using custom write_hint in Android and due to the 
> "upstream first" policy from Google, if you remove write_hints in block device,
> The Android ecosystem will suffer this lack.
> 
> Can we revert back this decision? Or think of an alternative solution which 
> may work?

You do both realize that this is just the file specific hint? Inode
based hints will still work fine for UFS.

-- 
Jens Axboe

