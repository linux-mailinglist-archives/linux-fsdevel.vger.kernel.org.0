Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A164D5178
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbiCJTfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 14:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343639AbiCJTfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:35:48 -0500
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2668D14D707;
        Thu, 10 Mar 2022 11:34:47 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id e6so5569870pgn.2;
        Thu, 10 Mar 2022 11:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o7PndJI501rkr9gmwF/udE5TGyFYFXZE5Syas0Qrj84=;
        b=aN1NMLHohp58VImx7oXMDCMRHaQJ3v/QVd38oImX9CWIaPWZ42m60UHankid6ECd0Z
         9itvsAJDgbMf7H2l6bs7RB+dRaULlzLmiRlk9t18WZQwDJBtXjxF+jcT1wCIETYEtfuS
         mYk5vS7/KYnMblxNdbuNYAAE4ppi+N1vUyoAI9l5WMVgZxBj0G/0inRpubOa1d8OVCW3
         J6GnakRcv07vzTWNtypBSTdfLflth9BkLD/BCxd49Mzer3jXixqwEZ3CjXXsjhLQ3Gxq
         20qcnsV9/XIw3T4SYgnjf2/YGzjA1HtShkjsKXbPr7jOjZOW94qFXYFrjVYEPr4Ii93W
         yOmA==
X-Gm-Message-State: AOAM532uA3QZDEUMfTqPrcA+xNpD73CTV0K6FDkjeyx3429ODyTzJAfH
        MS/myExyZKrzMje8KYGncGOiuzN9q6A=
X-Google-Smtp-Source: ABdhPJxgm6AqE8kHcxQEoxRzzLFn66z5SVUx1Kz9Qkq3sTGTHT/Hr8ElW/IypR19OtkCCKG08u/bxw==
X-Received: by 2002:a63:c011:0:b0:378:74a6:9c31 with SMTP id h17-20020a63c011000000b0037874a69c31mr5348347pgg.585.1646940886455;
        Thu, 10 Mar 2022 11:34:46 -0800 (PST)
Received: from ?IPV6:2620:0:1000:2514:57c0:65bf:1736:4f17? ([2620:0:1000:2514:57c0:65bf:1736:4f17])
        by smtp.gmail.com with ESMTPSA id f194-20020a6238cb000000b004f6ce898c61sm7669112pfa.77.2022.03.10.11.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:34:46 -0800 (PST)
Message-ID: <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
Date:   Thu, 10 Mar 2022 11:34:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
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
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/22 11:10, Jens Axboe wrote:
> On 3/10/22 11:50 AM, Luca Porzio (lporzio) wrote:
>> Micron Confidential
>>
>>>
>>> You do both realize that this is just the file specific hint? Inode based hints
>>> will still work fine for UFS.
>>>
>>> --
>>> Jens Axboe
>>
>> Jens,
>>
>> Thanks for this reply.
>>
>> This whole patch series removes support for per-bio write_hint.
>> Without bio write_hint, F2FS won't be able to cascade Hot/Warm/Cold
>> information to SCSI / UFS driver.
>>
>> This is my current understanding. I might be wrong but I don't think we
>> Are concerned with inode hint (as well as file hints).
> 
> But ufs/scsi doesn't use it in mainline, as far as I can tell. So how
> does that work?

Hi Luca,

I'm not aware of any Android branch on which the UFS driver or the SCSI 
core uses bi_write_hint or the struct request write_hint member. Did I 
perhaps overlook something?

Thanks,

Bart.


