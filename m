Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971201F328B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 05:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFIDZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFIDZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:25:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C28CC03E969
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 20:25:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w20so9677065pga.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 20:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=03TB4paXAcbFDwg8a3DK/XVRwYMXKk0zltL6mExpRmg=;
        b=JNgqBK3i58CdDJVV3jPFzRV9ZwOuUkQQs90rKSKHejcbUmJ9YsbjXfVRjMr8PO7NOk
         ggGsVI7oOd9OGQ2UYbGWaCyyinlS9r3YP0ZHqVXQd8Fwu0efWaGdFGnQW97EU6sRlJp6
         laKC5c5InT93qdKizPsOk2IEAswlARcPULO4P/s23DhSolyj2eA0u3fHOQUKxd05qs41
         QfLnV9XdyNHzNpVyAKXz/sTCWnVl+5oZXr4p4L7T4AWSoZHXW40UH9oYWGw2mKEMCf05
         MPOQF6LGzeHEl1l5RGTX11PSoUEHTG0R0pneYSbKDI50dn0/x+T8Rf1wJPYrRVeG9DTE
         YYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=03TB4paXAcbFDwg8a3DK/XVRwYMXKk0zltL6mExpRmg=;
        b=NeS8fZO8sqgDpiiPzZshcvmtd/wlM87MBtQ60Re36zZo1ZYoJO4BVR17UfzR8eoKwj
         xuHaiiTwDdVRnmZIePySti3BZ20rQT8IVooDDuzHeisi6VNkjW13qVAyT7Ufb4tiGf4P
         //eYCeG19CHxoWYsLtGynPL3dOgAJvxcYUnkDgdbEs0vQeoccr1b7raMjuCtKMubHPIa
         29Zcq2QiQO6TOnYzhgrvzQFtFm7irhU1fi7i383yX6xE2o1bctYcXKqkk49thn2eMemh
         pAU5vb/FRQGvPzD/w+gHkW8+UNHq/i/jkz6SlzNfZQx1topeE7714As2gCm0uOzOu6hN
         kwgw==
X-Gm-Message-State: AOAM530VGKJK13q5zy0X4zW9wY8KaNr6yB6KvJFvM3kpvJVHgBNu9wHz
        k4sbkK4gFjgenJ1UDDN7BHMiOtyk/L5k8A==
X-Google-Smtp-Source: ABdhPJwT7TQV+YNpi1hW02jBKMSsECW0azxx5eqp6QhuPSr6tkSpuGRPBxpjnzIBQ+fZjmafun0teA==
X-Received: by 2002:a63:c407:: with SMTP id h7mr22238282pgd.174.1591673145758;
        Mon, 08 Jun 2020 20:25:45 -0700 (PDT)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id y4sm7170067pgr.76.2020.06.08.20.25.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 20:25:45 -0700 (PDT)
Subject: Re: [PATCH] exfat: clear filename field before setting initial name
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com
References: <CGME20200609004931epcas1p3f2b10c4dea5b6d236fd1741532b529ec@epcas1p3.samsung.com>
 <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
 <00b601d63e06$cb54b360$61fe1a20$@samsung.com>
From:   hyeongseok <hyeongseok@gmail.com>
Message-ID: <cbb8eed3-656b-c00b-6ca2-29d3c53adb4a@gmail.com>
Date:   Tue, 9 Jun 2020 12:25:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <00b601d63e06$cb54b360$61fe1a20$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/20 11:36 AM, Namjae Jeon wrote:
> Hi Hyeongseok,
>
>> Some fsck tool complain that padding part of the FileName Field is not set to the value 0000h. So
>> let's follow the filesystem spec.
>>
>> Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
>> ---
>>   fs/exfat/dir.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..6c9810b 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
>>   	exfat_set_entry_type(ep, TYPE_EXTEND);
>>   	ep->dentry.name.flags = 0x0;
>>
>> +	memset(ep->dentry.name.unicode_0_14, 0,
>> +		sizeof(ep->dentry.name.unicode_0_14));
>> +
>>   	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
>>   		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
>>   		if (*uniname == 0x0)
> Wouldn't it be better to fill the rest with 0x0000 in this loop?
OK, I'll change like that.
>> --
>> 2.7.4
>
> .
>

