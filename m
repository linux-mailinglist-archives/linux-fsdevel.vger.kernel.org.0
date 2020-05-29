Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5AE1E75F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgE2GcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 02:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2GcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 02:32:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1100C03E969;
        Thu, 28 May 2020 23:32:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so763395pjb.0;
        Thu, 28 May 2020 23:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BNoZ2XYJOD/1c9noJbsTLNaWrtFoh6ZcaGy/LqRk1c4=;
        b=UE3NugHUUAkfF0oMX8fpEdkZU0HdWYx3tH6rIdaP1toLR56GvsNrdMRjClM5HYX0UQ
         7JVd1a/KPD3dkhzXGicgwatafJQCvtxhhFrewquf6g+L/EaFJ4s6WjHKxKT3VWDGYfgz
         au10I6+lXS05BXO2s4M7pGkILcT22CGfrEhK8RLClsOl4z2lzNl2OgXMx0k6uuNraVXN
         zFuk5Mf0/xXNxp3CYMTA/Tuecz3jkjU1H/qrcPxSNS1uoClRqrCHSioTemWVNrSX/0O+
         NE6ztpq+r5JxXrMtbTqDYFB42S0Xi3jRpBWug4mAflk3oGaIk54PVblm1DQMp/Wm0jZB
         quAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNoZ2XYJOD/1c9noJbsTLNaWrtFoh6ZcaGy/LqRk1c4=;
        b=dRVvJfOVtS5MpudrzGh1e6BnvI18y0dqQcrSX2eVe30e9GuTMhXvhuu36shIMeWYyk
         imFW6zwWzjoU2pTHmpe/QUgxBJC7kASYE2Djx/4e0Ooi+3rXNkKHWllQ7uXmGFrZtzQ1
         ptOylpBaC4wzifOA+e5eFT9gkS6c5Qlrf7f04nPHywiTGC3wIO9djjtRtLGnDIfck4wd
         ixFYJLfgsPCw4d+t5AIGmc5tUsOlz7NJsqyPzXvdd/ZiV/ovAfQjuWyw1C06L8qNkali
         qaaLbdvQPwaLYBEd7BXxI4k6P8PAdZnO3KbhOUf7KsEbnvNHIe0e2CE7en9aWC+2srNE
         L4Cw==
X-Gm-Message-State: AOAM533qnHyI1ieccId6LI8Z1Y055xy5hGJ3BRM3E7boDce9UGPJUEq4
        FSkM81S8im5214JPuvK1nG4rDjCsNco=
X-Google-Smtp-Source: ABdhPJyLbT0KF3Yvwgqg8u78vq3YhM6WjYTUFafCP/kWyeFqv/kMHWq1L8VCAvlSSfN+ElC/P2O0JA==
X-Received: by 2002:a17:902:c40d:: with SMTP id k13mr6949150plk.342.1590733934955;
        Thu, 28 May 2020 23:32:14 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:3c0d:7bea:2bcd:e53b? ([2404:7a87:83e0:f800:3c0d:7bea:2bcd:e53b])
        by smtp.gmail.com with ESMTPSA id 128sm6230844pfd.114.2020.05.28.23.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 23:32:14 -0700 (PDT)
Subject: Re: [PATCH 1/4] exfat: redefine PBR as boot_sector
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200525115110epcas1p491bfb477b12825536e81e376f34c7a02@epcas1p4.samsung.com>
 <20200525115052.19243-1-kohada.t2@gmail.com>
 <040701d634b1$375a2a40$a60e7ec0$@samsung.com>
 <48fe0abe-8b1c-bea2-820f-71ca141af072@gmail.com>
 <0bd201d63579$f9b03d00$ed10b700$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <308405a2-429d-b9aa-ca1c-a699570ae112@gmail.com>
Date:   Fri, 29 May 2020 15:32:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <0bd201d63579$f9b03d00$ed10b700$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I'll make another small patch, OK?
> 
> No, It make sense to make v3, because you have renamed the variables in
> boot_sector on this patch.

OK.


>> BTW
>> I have a concern about fs_name.
>> The exfat specification says that this field is "EXFAT".
>>
>> I think it's a important field for determining the filesystem.
>> However, in this patch, I gave up checking this field.
>> Because there is no similar check in FATFS.
>> Do you know why Linux FATFS does not check this filed?
>> And, what do you think of checking this field?
> 
> FATFS has the same field named "oem_name" and whatever is okay for its value.
> However, in case of exFAT, it is an important field to determine filesystem.
> 
> I think it would be better to check this field for exFAT-fs.
> Would you like to contribute new patch for checking it?

I already have the code, so I'll add it to [PATCH 2/4 v3].

BR
