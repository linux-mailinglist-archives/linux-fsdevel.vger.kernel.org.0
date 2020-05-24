Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41D31E0195
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbgEXTCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbgEXTCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:02:13 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97026C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:02:13 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s19so13341263edt.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NdExbycL1SPe28Gb+MdOV9nbN2dI2hdaXFPv18IeMAg=;
        b=EihdGDV8DTCCItLUe55UOrENFyb05DSZZFt5otCI2w3esLVZRduPAy8kcVMgQxbbQA
         xrvdLIXUgxy+NtwjL6Tmi61NfUDG8uSN6PVorqtcU7wrOF1GyzNMLLedFfVMI0MITPQM
         g1KzX47Xw9oACK1tTfntYAJsdvZ1SLgavjlemJnNZqHsbppc96a6xyP/YsjIteoWHOoT
         /rMdjcVRaowknGg0F9QJzFuVSua6WfTVGj3IONKQ+AQ0muiNtPSwjX8/dUUM0CvvaZ2E
         4XN3wZEIE7V1REnfs10/U7RzieT8PB5OKxLdBb1AnNo9Ph19Zocu4kuOiU3TyMIkdBEU
         qRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NdExbycL1SPe28Gb+MdOV9nbN2dI2hdaXFPv18IeMAg=;
        b=TFjyoCMeinq42Uxg1LBZ954/mGKwejxcoubG3GFw5f8Q6a2LkdfhV+sUkBZ8KiWSev
         ViSSJEhPj1Szs6ehYrLl1dnmSDc7w+/4xK1BO2o5Sb3jR5gOyFNhYEClr/5yPNkXW/ZB
         ifVSU9RjXOAsYNoB3i6IyXTZTBqshBE3NRqbPBYmPK/SGD6gV8QEb3w1LDdtk3p+ot6d
         vp6abDcthSmVyQG8QleqJVAXYR/JyoEEhycn/O2HBsJPeacxwucOaqWAiVBT28+UxrRw
         BQW32zm2KNqjLZl1X7XeNf47/HY1eCzkWzP6FK6P91nt/o39Vh2FRiaj+TBjl2H2+2hR
         B0Xw==
X-Gm-Message-State: AOAM5310dnKFbqdNE742Kgd1yGiKLigS7x4z0Ft5pFVG3lN5FejzqA0Z
        fltbJqxzOSTuL21vKrAR9OCWYxE9AXg8Vg==
X-Google-Smtp-Source: ABdhPJx70TkLhmO8i+OkEiZF8MWZU6qbvddsMCi218Rg7XEbcs0fAi1TS3ocdNoO6PZr3ncYMGS6lA==
X-Received: by 2002:aa7:d71a:: with SMTP id t26mr6719843edq.123.1590346932202;
        Sun, 24 May 2020 12:02:12 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48bc:3c00:e80e:f5df:f780:7d57? ([2001:16b8:48bc:3c00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id u17sm13588498ejg.1.2020.05.24.12.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 12:02:11 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200521225220.GV2005@dread.disaster.area>
 <906f7469-492d-febc-c7ed-b01830ae900d@cloud.ionos.com>
 <20200522165301.727977de1d39ac5bfb683ed0@linux-foundation.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <54e99e19-0e84-c85b-b3f5-aa2c14ec6d65@cloud.ionos.com>
Date:   Sun, 24 May 2020 21:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522165301.727977de1d39ac5bfb683ed0@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/20 1:53 AM, Andrew Morton wrote:
> On Fri, 22 May 2020 09:18:25 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>
>>>> -	ClearPagePrivate(page);
>>>> -	set_page_private(newpage, page_private(page));
>>>> -	set_page_private(page, 0);
>>>> -	put_page(page);
>>>> +	set_page_private(newpage, detach_page_private(page));
>>> attach_page_private(newpage, detach_page_private(page));
>> Mattew had suggested it as follows, but not sure if we can reorder of
>> the setup of
>> the bh and setting PagePrivate, so I didn't want to break the original
>> syntax.
>>
>> @@ -797,11 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>           if (rc != MIGRATEPAGE_SUCCESS)
>>                   goto unlock_buffers;
>>    
>> -       ClearPagePrivate(page);
>> -       set_page_private(newpage, page_private(page));
>> -       set_page_private(page, 0);
>> -       put_page(page);
>> -       get_page(newpage);
>> +       attach_page_private(newpage, detach_page_private(page));
>>    
>>           bh = head;
>>           do {
>> @@ -810,8 +806,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>    
>>           } while (bh != head);
>>    
>> -       SetPagePrivate(newpage);
>> -
>>           if (mode != MIGRATE_SYNC_NO_COPY)
> This is OK - coherency between PG_private and the page's buffer
> ring is maintained by holding lock_page().

Appreciate for your explanation.

Thanks,
Guoqing

> I have (effectively) applied the above change.
