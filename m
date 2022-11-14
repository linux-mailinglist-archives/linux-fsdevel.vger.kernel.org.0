Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5630B627519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 05:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiKND77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 22:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiKND75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:59:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D125E009
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 19:59:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g62so9888249pfb.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 19:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQZZjpNqvZsbs1aZ+f9L6Zj8PA0ItCU0rBc0b1FARyw=;
        b=vdB5fAHXaRnl7hEGIoiRCjv4822lI+8QizRapf66BmUN2RvoLmk1izUL25FAw8x4c0
         Fg1r5WnIaf5BUQwu7KlU9RU+15lhg9x+V0K9tRRu6XunTvyOe2M+d9p0Z8UCfB+IjmFo
         6HgrdONadSO1rj4QGrvMn46maeMM1yZeED2aU8PhbJvHIo1pyk7Ggu4QDktXJlqbQ3zH
         GR3dlDfqu/90Dwu8sr159TzENYpVbOaHtEYQmJ7PVkmtlxE2QQbo6Mq1E2yM+i4kxQ4p
         2HyTY4R02QmKE+UbuWvcM2grft8OfjzohGFcD0oJs2HAifkoivRgDqMQbopDaKIVW7kS
         kYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQZZjpNqvZsbs1aZ+f9L6Zj8PA0ItCU0rBc0b1FARyw=;
        b=5Il9c9SVLgVotI4jLl0ue54ebR48AszrIKyc3j9gFP9haJVxd6mAq+jTdKUy4tfWul
         HxfVowjfSSJfk9p3pL2LOAWFTCc356oHBK3YGbPk4s8te86apTGVNKGPWSuh4cKOzk58
         MwLTnUQC6n6+gJq3ayT0x1ZuyUWPG/8z7CDjAGbL0wZaGivydRWo6T6iDW2hyH7PgCV+
         4AH/3TSDWVEzyCtckqTfWTsolttOIzCNCT7ZFmn4LVlKrhf0PJuf2yf/XCuzy9wvilI4
         zONqNnOxi31qcOzbQwdJs9F6eb4QZugljiOW9KQkP8Y5kghwZnK5wnWv6jv1KxxeGKa+
         S7Cw==
X-Gm-Message-State: ANoB5plJ2iir/Gdr3Eu/WH+FeVetQP6jvUTlGC87QFMWwMko22QYCrSq
        3ueLnZjei6C3C6R0fd+hiIvgmg==
X-Google-Smtp-Source: AA0mqf72JWncrSTFwDOEPs30Ny/aQyU6SBZ2m0gCMhNu13fXnwcY9AQ7OCeL8R/ZUFswDSD0+buZ2w==
X-Received: by 2002:a63:1d49:0:b0:476:898c:ded5 with SMTP id d9-20020a631d49000000b00476898cded5mr2276339pgm.299.1668398395776;
        Sun, 13 Nov 2022 19:59:55 -0800 (PST)
Received: from [10.254.69.19] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b00168dadc7354sm6061996plo.78.2022.11.13.19.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 19:59:55 -0800 (PST)
Message-ID: <039ce475-f935-e0c2-4734-1dd57519d961@bytedance.com>
Date:   Mon, 14 Nov 2022 11:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2] mm: fix unexpected changes to
 {failslab|fail_page_alloc}.attr
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     dvyukov@google.com, jgg@nvidia.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <Y2kxrerISWIxQsFO@nvidia.com>
 <20221108035232.87180-1-zhengqi.arch@bytedance.com>
 <CAC5umygzc=H-9dCa_pLoqodS4Qz90OVmQkrvFOCPv27514tP3A@mail.gmail.com>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAC5umygzc=H-9dCa_pLoqodS4Qz90OVmQkrvFOCPv27514tP3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/9 01:36, Akinobu Mita wrote:
> 2022年11月8日(火) 12:52 Qi Zheng <zhengqi.arch@bytedance.com>:
>>
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
>> ---
>>   v1: https://lore.kernel.org/lkml/20221107033109.59709-1-zhengqi.arch@bytedance.com/
>>
>>   Changelog in v1 -> v2:
>>    - add comment for __should_failslab() and __should_fail_alloc_page()
>>      (suggested by Jason)
> 
> Looks good.
> 
> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks. And hi Andrew, seems no action left for me, can this patch
be applied to mm-unstable tree for testing? :)

-- 
Thanks,
Qi
