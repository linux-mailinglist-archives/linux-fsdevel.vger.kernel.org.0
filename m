Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784BE1F328A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 05:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFIDXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 23:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgFIDXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:23:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4146C03E969
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 20:23:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so7462187plb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 20:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CikN5uJqvlOM+XCX07wH6NvzglBksPHFpI0r8Y/5dEk=;
        b=i+Jsq+kQVTzA/t2WaVTYk9MoaNGneCMik+zNROLkr5KRdUAS6KJa4DkuzwwZo+MBXH
         BjxsuoYgegySIjQYwi7ljJ4136B2aHdlAQ3hAtsizkRI1Z67tnAQxsltmKcuGVVD8ifd
         pXdmxxdFRuj8C4RQsZ27WkNDkEOem3Y70cgp05vv2JD+SaSwK2QcXkrZFslLK75mJ/D0
         p0wt/t9YlvD8+vd4QLQHuehXJq5Y2QAKB7LbBRxi0hVwhdWpIi2lJBbu3lQeRlwf97Kg
         eeKIDzSCsXepXzOmSnH95XtknLD2eQepehQ1ohk/zpesvkYAvi7fERIvehUmZ7xmcinp
         gS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CikN5uJqvlOM+XCX07wH6NvzglBksPHFpI0r8Y/5dEk=;
        b=O07Eocx35y5kv9KxP8jGAtoq/1IXHY8C3Rm+SQTjt+hgIpRSl7opKYv+Zq4i5aVKJ9
         o7IzF5/JYaG9qfX2h/pnSrIofJ4pzieFOGXtsvhor1KDxsLBOxLJvCtyKBXQ4jZ+nrXe
         BHxP+vc7yyZLgFxnbshGPwDII8cBtQ18zR9UyM4GoF0HyL52WeR1dDVkz3jmALDINgoS
         YZS834yiyLnzSIWeS810HHID8PYa6kMrcUYbwvTxUxU3U7wmLGB5eggyAHE+M/NWpydz
         dZrkVgsGziqoajucvH2nN/41X0lHQb9feegTamp0ZlCf5TeJqqFM4UDyZ/X8n4Idetmv
         GDuw==
X-Gm-Message-State: AOAM532THyh3EanL0vzbVCHU02kD5pzonpSVB7yTUIIuCEXrr0WtdW1R
        +jlOoYN0+bfiDgxiJn55C/VLBNoeKacLIA==
X-Google-Smtp-Source: ABdhPJxkepVibnntrm8h5d72LbPKsY8224EUmDft4jH/nipN2p/anZIg7Oxl1LjRl2Km3x8D3SXdMw==
X-Received: by 2002:a17:90b:1955:: with SMTP id nk21mr2591197pjb.66.1591672996285;
        Mon, 08 Jun 2020 20:23:16 -0700 (PDT)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id cm13sm818907pjb.5.2020.06.08.20.23.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 20:23:15 -0700 (PDT)
Subject: Re: [PATCH] exfat: clear filename field before setting initial name
To:     Sungjong Seo <sj1557.seo@samsung.com>, namjae.jeon@samsung.com
Cc:     linux-fsdevel@vger.kernel.org
References: <CGME20200609004931epcas1p3aa54bf8fdf85e021beab20d402226551@epcas1p3.samsung.com>
 <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
 <000001d63e0a$88a83b50$99f8b1f0$@samsung.com>
From:   hyeongseok <hyeongseok@gmail.com>
Message-ID: <583c96d1-d875-c3a1-8d62-e0380c9d4e63@gmail.com>
Date:   Tue, 9 Jun 2020 12:23:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <000001d63e0a$88a83b50$99f8b1f0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/20 12:03 PM, Sungjong Seo wrote:
>> Some fsck tool complain that padding part of the FileName Field is not set
>> to the value 0000h. So let's follow the filesystem spec.
> As I know, it's specified as not "shall" but "should".
> That is, it is not a mandatory for compatibility.
> Have you checked it on Windows?
Right, it's not mandatory and only some fsck'er do complain for this.
But, there's no benefit by leaving the garbage bytes in the filename 
entry. Isn't it?
Or, are you saying about the commit message?
>> Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
>> ---
>>   fs/exfat/dir.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index de43534..6c9810b 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct exfat_dentry
>> *ep,
>>   	exfat_set_entry_type(ep, TYPE_EXTEND);
>>   	ep->dentry.name.flags = 0x0;
>>
>> +	memset(ep->dentry.name.unicode_0_14, 0,
>> +		sizeof(ep->dentry.name.unicode_0_14));
>> +
>>   	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
>>   		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
>>   		if (*uniname == 0x0)
>> --
>> 2.7.4
>
>

