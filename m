Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E996B4D5232
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbiCJTLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 14:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240343AbiCJTLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:11:32 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E81959F8
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:10:30 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id l1so4440857ilv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z2XnAIZo4F9dSg2/HrPYqXkXeLAaoG9uThWsD0uBJlA=;
        b=Zs/K8Ho3umHLToueBxMUNe97QzEdc/fHEZhQ7JtJWKvwOgjZ11JXrAWoy0GAhtd0zI
         Ds6PmqoMAoryy9OdN7rCKqG2max0dWACJrmkby+3VU+kNc3YdiHD6MKmOmJIMwD261Ze
         dL/7enTzi3bbl5vjuQxDFNp5GXWQswLJnMNLb7qYpVP8pKmByGMd5Am5wz28FHIOq+XV
         o5C2rZRsaiK45ER8KOtnr0QXOt8DHrHvG92aZN2cjSrzOljHkSygMGXA7+ZxntMUjzG+
         slLqs+vTgysxjiGW9RnhGNWaCke+QjEcm3wPYCf04fHEuZhflaQSWQmA8WClSMy+EGRI
         b67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z2XnAIZo4F9dSg2/HrPYqXkXeLAaoG9uThWsD0uBJlA=;
        b=nQiCYjmiDAsF9B+svS21H4UMB+7iYI3HYw0kRGWWJcrJlohzw4OCrGQNvY+rcxZEgB
         5W/3lwsDEDXtwXTBKDtiG8KmrcXaRLVx9pUzL+5U5sNHmBuA5P7NqqVmQJvRxeLgnJQa
         fdMscHkK0BlKJNaty2om7rzenAw/+hnb1EK2grfxBG9wsLOzCf4vOCq6kCwtJ9hJl/Hx
         B5PwwnaPXddHi8qkZ6fUkme09EZP8XdA+PCNAX0f1qxAqucKSC56j4ubHF8LQRj8J0C8
         JfsHOpbrU4v9HDHVEZRsTf5LPy2/vppLyqGQ8gAT9FYLfx6Kpk/kSyATBd2tUJuoDbMr
         lg6Q==
X-Gm-Message-State: AOAM5330ujLvlMH+C6eBDoiEUsJE9I6uMSYq7ASu9Rg6Zu+b461dbmam
        izUycEnTVo23diyKdjflYZEEJtduESmfBbcg
X-Google-Smtp-Source: ABdhPJwx7bekaEdUtL1Ejn1IAjB6lGjVlrk24NZLRa7bis8QL16ikKs73/7JzgQhljRrnvGpFxNraA==
X-Received: by 2002:a05:6e02:1a8e:b0:2c7:6e36:e154 with SMTP id k14-20020a056e021a8e00b002c76e36e154mr1897043ilv.180.1646939429515;
        Thu, 10 Mar 2022 11:10:29 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k1-20020a056e021a8100b002c64cf94399sm3435510ilv.44.2022.03.10.11.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:10:29 -0800 (PST)
Message-ID: <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
Date:   Thu, 10 Mar 2022 12:10:27 -0700
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
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
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

On 3/10/22 11:50 AM, Luca Porzio (lporzio) wrote:
> Micron Confidential
> 
>>
>> You do both realize that this is just the file specific hint? Inode based hints
>> will still work fine for UFS.
>>
>> --
>> Jens Axboe
> 
> Jens,
> 
> Thanks for this reply.
> 
> This whole patch series removes support for per-bio write_hint. 
> Without bio write_hint, F2FS won't be able to cascade Hot/Warm/Cold 
> information to SCSI / UFS driver.
> 
> This is my current understanding. I might be wrong but I don't think we 
> Are concerned with inode hint (as well as file hints).

But ufs/scsi doesn't use it in mainline, as far as I can tell. So how
does that work?

-- 
Jens Axboe

