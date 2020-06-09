Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A301F335A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 07:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFIF16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 01:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIF14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:27:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C91C03E969
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 22:27:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so9787012pgo.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OZfAjF56M7FXdkOqqZ8lFl4ImbDyO1gjSaSbJRoWnTk=;
        b=YtiX6YT7zwk3/8+e+dUW058hQyzEHSF466MdzDFjLPyxuvF6K/20bn9C4iwmFN8BvU
         3WgPWIq7N5rCnZ0tP9jWsSTdl0T8PXINaWF1h4aEsptYcLBGq3ChHkmGnX8uXsN97mpf
         8u59OHIgmmeClDgb6NpDxq4ItT2vMhVHXIZnqpyTLlj11GMscssvzQ6AxizOjdYgwzOu
         4bCPYTU/iMt0izcKtvte866b+dTC+5W2ALhe49aSZgxIbRQZTY3REtRMOe+t267l5f5A
         HyMHjjK1YYbmaJ5jkURmEkE812I18CIJnSXYR4P0lM4TRltSeu1Ur+Xjjhz9A5IPddlk
         GA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OZfAjF56M7FXdkOqqZ8lFl4ImbDyO1gjSaSbJRoWnTk=;
        b=rK4xjqH6XJKdV2lSTJuOu9dYGvkl0WZdmPNTcm8vgzbSVk1pXdK7UaWgNiv29wM+AQ
         Ao6a1VoIger+pc2wEVYU+5CNbUMwD4MoUISJmFFzkbgByLiIvrH20R/S//t+0LR4IxEx
         pr/D9wMj41G1fcWNP/gpPc6sZsvMfdBXnnIBPN5ERE3C7rzpxaqP96m3bbqiEGlWqbKO
         8Pg1PWIzKx3akW4kGgWjiQy3M7J1MXIG2kncJlsI3DokdFjC2QIrgJBUzPnrTWSl5sk+
         1tF1za2WgS38EQFv19mlvDxLChvbSa9BeNPjYYEd5zlT8Mhs8GscqBMHoV5yVTP8X/V2
         fg9A==
X-Gm-Message-State: AOAM533LLq2yiqd35qReacGq1DsP9pS6cmP/VyGtT3Bdyio0cyMNW5PB
        LRRN7PLPyUxrbswGL8TR/DLZjFHho3fvEQ==
X-Google-Smtp-Source: ABdhPJzJutHfOmCwVck65Nn+a7YrycCSVenuNLiN+wD62V20xOK6KGXWgWmCEg5JaJ79+m9wPKGfzQ==
X-Received: by 2002:aa7:8a47:: with SMTP id n7mr23316470pfa.219.1591680475283;
        Mon, 08 Jun 2020 22:27:55 -0700 (PDT)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id 63sm8708300pfd.65.2020.06.08.22.27.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 22:27:54 -0700 (PDT)
Subject: Re: [PATCH] exfat: clear filename field before setting initial name
To:     Sungjong Seo <sj1557.seo@samsung.com>, namjae.jeon@samsung.com
Cc:     linux-fsdevel@vger.kernel.org
References: <CGME20200609004931epcas1p3aa54bf8fdf85e021beab20d402226551@epcas1p3.samsung.com>
 <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
 <000001d63e0a$88a83b50$99f8b1f0$@samsung.com>
 <583c96d1-d875-c3a1-8d62-e0380c9d4e63@gmail.com>
 <027c01d63e1a$2587fff0$7097ffd0$@samsung.com>
From:   hyeongseok <hyeongseok@gmail.com>
Message-ID: <c2685948-ff90-36a4-c5b0-34f3de7cc73e@gmail.com>
Date:   Tue, 9 Jun 2020 14:27:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <027c01d63e1a$2587fff0$7097ffd0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/20 1:55 PM, Sungjong Seo wrote:
>> On 6/9/20 12:03 PM, Sungjong Seo wrote:
>>>> Some fsck tool complain that padding part of the FileName Field is
>>>> not set to the value 0000h. So let's follow the filesystem spec.
>>> As I know, it's specified as not "shall" but "should".
>>> That is, it is not a mandatory for compatibility.
>>> Have you checked it on Windows?
>> Right, it's not mandatory and only some fsck'er do complain for this.
>> But, there's no benefit by leaving the garbage bytes in the filename entry.
>> Isn't it?
>> Or, are you saying about the commit message?
> The latter, I'm just saying this is not a spec-violation :)
Yes, I got it.
Thanks.
>>>> Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
>>>> ---
>>>>    fs/exfat/dir.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..6c9810b
>>>> 100644
>>>> --- a/fs/exfat/dir.c
>>>> +++ b/fs/exfat/dir.c
>>>> @@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct
>>>> exfat_dentry *ep,
>>>>    	exfat_set_entry_type(ep, TYPE_EXTEND);
>>>>    	ep->dentry.name.flags = 0x0;
>>>>
>>>> +	memset(ep->dentry.name.unicode_0_14, 0,
>>>> +		sizeof(ep->dentry.name.unicode_0_14));
>>>> +
>>>>    	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
>>>>    		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
>>>>    		if (*uniname == 0x0)
>>>> --
>>>> 2.7.4
>>>
>
>

