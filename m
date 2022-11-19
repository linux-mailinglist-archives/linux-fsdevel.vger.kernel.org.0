Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5163088F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiKSBnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiKSBmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:42:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75189A28A4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 16:48:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d20so5953217plr.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 16:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSj2/cLHt1SdQObKh67xzbIPuUwvEskces+Lnu0fKrQ=;
        b=Lod+RJl5ay4LW7CCVlbLVUpVW9yWRmjZS7z4BgLn9FMTNVOMqDo575AiTzf60tmQ7k
         1EX58Lueuy4m/3mWqyE+pMkUTKz3s5nj2gQwc6eVlmACBwow8YCLU/nsCqdAbZ8d2mIK
         jF8QPdH+gSoH53sUSzO25R7eb3xC3lTEbIKviDGAW6J5r4ssCLHrEnQrkU0TlZ3k6wGV
         REZwacxFiMi7qyROKMRk4RwZ1VzfdsgggKrDrjMzNMbleR1EmdEEgi+6NPSbBWYoSvOn
         fk3RDude0PcKMooAKfQAuDS/qWB0tlSvfrhCSCJDGUtP3TuZOSvPVzb1db/bRzJ8/bjK
         p/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSj2/cLHt1SdQObKh67xzbIPuUwvEskces+Lnu0fKrQ=;
        b=7Foa/booNMyBxCUAPVT/6/Zk9G6v0X4igXUO7MfINSMpFjZlPGo061LntgVsnKQMrN
         KCKMeec8hxhb2z9IbYQm1UnVokHHNGDIqnpCzR85BSBxZqUq5rOdy8rcLGV/3fD5gFxd
         vYpZpmxa21ZTR1fjm7zYdtTx9Ft8rWJVzV9r2cExc5eUElQcK/g/z40gekB/Njoz03xz
         YKGg6Xcd/btvZpB5CLxlAjyppI9/rWMusccbGNo1/j6FcKRHtwflxGAhp4qHRCkkYsyF
         rzSP+TaPWi+wsDDDts/ToJ+gEZdRgE3hY3C5sr+TCEc5DAdmy6RV6kTutAFzbW6vQ9dz
         YmpQ==
X-Gm-Message-State: ANoB5pmPAs1pGmVUcRi+LAq2V2y22KAt36Be/Y3mqrR15Bhaztst34xB
        HMX9/2PTgTqPOdJNnJNIzF2z4w==
X-Google-Smtp-Source: AA0mqf6swX3sJxyi4BgEUBAbZm2DOjd6hNV4fVJPFohM84Xw+4s8Nshz7t9X6MP8fLm+8fDHRp4zcA==
X-Received: by 2002:a17:902:f391:b0:178:71f9:b8fc with SMTP id f17-20020a170902f39100b0017871f9b8fcmr2021518ple.44.1668818922973;
        Fri, 18 Nov 2022 16:48:42 -0800 (PST)
Received: from [10.255.94.72] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id e8-20020a630f08000000b0046faefad8a1sm3382499pgl.79.2022.11.18.16.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 16:48:42 -0800 (PST)
Message-ID: <4d6eb453-2ba5-12f3-8dff-7074a62441ce@bytedance.com>
Date:   Sat, 19 Nov 2022 08:48:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3] mm: fix unexpected changes to
 {failslab|fail_page_alloc}.attr
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     akinobu.mita@gmail.com, dvyukov@google.com, jgg@nvidia.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
References: <20221118100011.2634-1-zhengqi.arch@bytedance.com>
 <20221118134236.17a67804b3b6e6c157d8ea02@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20221118134236.17a67804b3b6e6c157d8ea02@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/19 05:42, Andrew Morton wrote:
> On Fri, 18 Nov 2022 18:00:11 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> When we specify __GFP_NOWARN, we only expect that no warnings
>> will be issued for current caller. But in the __should_failslab()
>> and __should_fail_alloc_page(), the local GFP flags alter the
>> global {failslab|fail_page_alloc}.attr, which is persistent and
>> shared by all tasks. This is not what we expected, let's fix it.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3f913fc5f974 ("mm: fix missing handler for __GFP_NOWARN")
>> Reported-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
>>
>> ...
>>
>> -bool should_fail(struct fault_attr *attr, ssize_t size)
>> +bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags)
>>   {
>>   	bool stack_checked = false;
>>   
>> @@ -152,13 +149,20 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>>   		return false;
>>   
>>   fail:
>> -	fail_dump(attr);
>> +	if (!(flags & FAULT_NOWARN))
>> +		fail_dump(attr);
>>   
>>   	if (atomic_read(&attr->times) != -1)
>>   		atomic_dec_not_zero(&attr->times);
>>   
>>   	return true;
>>   }
>> +EXPORT_SYMBOL_GPL(should_fail_ex);
> 
> I don't see a need to export this?

Yes, my initial thought was that there might be a driver using this
function, but there really isn't one yet.

And I see you've helped remove this, thanks a lot. :)

> 
> 

-- 
Thanks,
Qi
