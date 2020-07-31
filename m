Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8F233CDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgGaB3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 21:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgGaB3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:29:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B77C061574;
        Thu, 30 Jul 2020 18:29:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so6259531pjb.1;
        Thu, 30 Jul 2020 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPX14SfgZIqanMjmDVIeyMD8ehnyG/kjpUhwRu/f6rQ=;
        b=BHp2ipeZ58rNCZXiTbuFYzN3/UUzDE4xRhyn4L5TXcE7Zd9Yrb9xUk9PMk9cZgp5tL
         GBLU4JizBTs60MEHH6uBeZPyjDcgtJ23sa4+qduV9YbUI05YrZQjNuDdK7c872RUcbgm
         Lmw6eAqBNhO/ZwF7Va1hP224Q4+i0uABlQLv1UISs67lRkgUodTSMMX9CB5GrD//G3Ov
         CWmvtXq9vklvj4ECGv5l4YJoZ9qZjU8a6mkj0NP51mQyklFon/uFx7A4eWmCXqUg1kFH
         MxI3YozfdOdZvzE6pNdZ2dT0wizGuXwRLywbWNG9XBTPPKCqaueL+j9WfAUIXoRHBPA2
         iRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPX14SfgZIqanMjmDVIeyMD8ehnyG/kjpUhwRu/f6rQ=;
        b=RroAQOlq0q7iSWoDUkaDYaGObQETqR/sKjFofXmgcfeik5zlQSyHV2LCOPKFqaXr+T
         uYzi7e/NjCYGPqF3IQ2x7tMUFQVejGLnd+/vol4uy8jYz2KUXZ/nCTLPvs5FahRYmgDG
         jGvDocHYFSBBwlNvAZ8LEPBkFkczlBPYk8i6imO9yiY6O7yPjn8f/WdwjoCvXt2G07yZ
         ry38ACA4m5OpopMlbjW6X8+naP7wvB8CI2L2CwsWFWMIhWa40AOu+tyrEdh1cdS9HaNN
         bVRV63C0DzgZDCuV+DtCKx+UNVxwfeHjJidWG0HgIK1JJYWkBZd8X+rH4SQzc+0PDsXx
         IdSw==
X-Gm-Message-State: AOAM531DM6DLVlmPTBV1fFH98EE9C97PlHLZGTKIXuatypV8u+BJEb/R
        xHMCMoxVSDMNUekv8gwXQddTrMb6MqE=
X-Google-Smtp-Source: ABdhPJxMSuhsi9iAXJl9/S+bfy/y45icxXoATN7aJ/1sUWGAXybv9EWOwKXp489telv249Z2R7vwpQ==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr1636513plb.206.1596158985620;
        Thu, 30 Jul 2020 18:29:45 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:3191:c776:c32a:7a53? ([2404:7a87:83e0:f800:3191:c776:c32a:7a53])
        by smtp.gmail.com with ESMTPSA id f18sm7656107pgv.84.2020.07.30.18.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 18:29:45 -0700 (PDT)
Subject: Re: [PATCH] exfat: retain 'VolumeFlags' properly
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        Motai.Hirotaka@aj.MitsubishiElectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
 <20200708095746.4179-1-kohada.t2@gmail.com>
 <005101d658d1$7202e5d0$5608b170$@samsung.com>
 <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
 <015801d65a4a$ebedd380$c3c97a80$@samsung.com>
 <ad0beeab-48ba-ee6d-f4cf-de19ec35a405@gmail.com>
 <fa122230-e0fd-6ed6-5473-31b17b56260c@gmail.com>
 <015e01d6663e$e99e4ec0$bcdaec40$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <a33a4315-973d-4216-4b7d-714486ef415f@gmail.com>
Date:   Fri, 31 Jul 2020 10:29:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <015e01d6663e$e99e4ec0$bcdaec40$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/30 15:59, Namjae Jeon wrote:
>> Ping..
> Hi Tetsuhiro,

Thank you for your reply.


>> On 2020/07/15 19:06, Tetsuhiro Kohada wrote:
>>>> It looks complicated. It would be better to simply set/clear VOLUME DIRTY bit.
>>>
>>> I think exfat_set_vol_flags() gets a little complicated, because it
>>> needs the followings (with bit operation)
>>>    a) Set/Clear VOLUME_DIRTY.
>>>    b) Set MEDIA_FAILUR.
>>
>> How about splitting these into separate functions  as below?
>>
>>
>> exfat_set_volume_dirty()
>> 	exfat_set_vol_flags(sb, sbi->vol_flag | VOLUME_DIRTY);
>>
>> exfat_clear_volume_dirty()
>> 	exfat_set_vol_flags(sb, sbi->vol_flag & ~VOLUME_DIRTY);
> Looks good.
> 
>>
>> exfat_set_media_failure()
>> 	exfat_set_vol_flags(sb, sbi->vol_flag | MEDIA_FAILURE);
> Where will this function be called? We don't need to create unused functions in advance...


Sorry. I ran ahead without explaining.
I would like to set MEDIA_FAILURE when a format error is detected so that fsck will be run on the next mount.
This patch is the basis for setting MEDIA_FAILURE.

But, I have no reason to implement this right now, as you say.
I'll add it in a patch that sets MEDIA_FAILURE.


BTW
I would like your opinion on the timing of clearing VOLUME_DIRTY.
https://lore.kernel.org/linux-fsdevel/c635e965-6b78-436a-3959-e4777e1732c1@gmail.com/#t

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
