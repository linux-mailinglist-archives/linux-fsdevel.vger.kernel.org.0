Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4926120010C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 06:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgFSEW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 00:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFSEWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:22:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D52C06174E;
        Thu, 18 Jun 2020 21:22:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so3416453plk.3;
        Thu, 18 Jun 2020 21:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z3GUFsva8EQpwFe5HMmUvMzv7A1xWJY+kiZONaSTGso=;
        b=EUprA435Od+Y8lek6U+HfiNDhNNPXmzEvmh3IotGrECuAHywhJoec/xQnwM7tiQaQz
         wrFB+M0XoWLsTVH7XFdCbJxUNHZVgWJHCanK+tmdhgbBwbh9b4r++Jfng1wO5ox7zHv2
         VJMSGCgs2Smvu58ZtQ5MFVy2yDowHSnDk7RarLOEMoCs4zsf5Pr/5fd2aUGkn5VZ3qzZ
         ZVt/YIIy6ilJbS8y/QGzj0Cg4gGEDQ3gPjB7Izi7SumhmydGiO2Jt6tJ4tXMvPUdz7XL
         msoBwbCprL1AZIsBLbseZK63Zg3VCS9gPT/5H1vY8wwUiLOKyKz2uyuv1NtjDujxEJ1+
         Qfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3GUFsva8EQpwFe5HMmUvMzv7A1xWJY+kiZONaSTGso=;
        b=F+OaaFWAQMADYnKTkaz7ErqOpKJF0ML9HkvH98SsK5d/MSdoY7eqb8UuwJSyW5CvNk
         nOEkpBY//hNndCmZTj3/6EouG7su1dAD4D/rlGuiRtb49Je9cy03snRtA13UHb+ZyYro
         gg/IDKEwFOHY0lgAHMhqexWSJHXNz9aKWC7A/uGWY2R31TMkXzADGxdRXf0JMBrYFoyZ
         RlODkPWPuly9PJSC/Pnwj465uEMX8QsFu9aS+T2O9v7uxi79vw/W0H5aFAONvVzLBkOc
         xo4imGEWYS0ayhOdMO4mrCCPghAgwXILRHwFEDoLdbCYMgXsNBSz0nbZjzbGpN8F7MHE
         HcjA==
X-Gm-Message-State: AOAM530hM33MrE8BzmojFomalWOo6QcrH/IBYZxCa/U5vvJYcV8neukg
        bTRTIHB6v7Sx2Yz8V8jQEV0Yp2NX8tE=
X-Google-Smtp-Source: ABdhPJymq9m4Ug+KBob+tkN8AU2UPVKb07m77ZsScNRLIsRPt3uzaI3IYl11BJKFxgzvBGkDCEqsGQ==
X-Received: by 2002:a17:902:ea82:: with SMTP id x2mr6779510plb.88.1592540544767;
        Thu, 18 Jun 2020 21:22:24 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:f960:d5b8:822f:1ca1? ([2404:7a87:83e0:f800:f960:d5b8:822f:1ca1])
        by smtp.gmail.com with ESMTPSA id 27sm3870622pjg.19.2020.06.18.21.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 21:22:24 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
 <20200616021808.5222-1-kohada.t2@gmail.com>
 <414101d64477$ccb661f0$662325d0$@samsung.com>
 <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
 <500801d64572$0bdd2940$23977bc0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <0a93d1a1-dc34-f799-240e-843d7f021bbf@gmail.com>
Date:   Fri, 19 Jun 2020 13:22:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <500801d64572$0bdd2940$23977bc0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I mentioned rmdir as an example.
>> However, this problem is not only with rmdirs.
>> VOL_DIRTY remains when some functions abort with an error.
>> In original, VOL_DIRTY is not cleared even if performe 'sync'.
>> With this patch, it ensures that VOL_DIRTY will be cleared by 'sync'.
>>
>> Is my description insufficient?
> 
> I understood what you said. However, it is a natural result
> when deleting the related code with EXFAT_SB_DIRTY flag.
> 
> So I thought it would be better to separate it into new problems
> related to VOL_DIRTY-set under not real errors.

I see.
It seems that it is better to consider separately when consistency is corrupted and when it is kept.

>> BTW
>> Even with this patch applied,  VOL_DIRTY remains until synced in the above
>> case.
>> It's not  easy to reproduce as rmdir, but I'll try to fix it in the future.
> 
> I think it's not a problem not to clear VOL_DIRTY under real errors,
> because VOL_DIRTY is just like a hint to note that write was not finished clearly.
> 
> If you mean there are more situation like ENOTEMPTY you mentioned,
> please make new patch to fix them.

Hmm.
VOL_DIRTY is easily cleared by another write operation.
For that purpose, I think MediaFailure is more appropriate.

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
