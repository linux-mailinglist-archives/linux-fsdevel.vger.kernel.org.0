Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40A1D9129
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 09:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgESHgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgESHgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 03:36:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49002C05BD09
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 00:36:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u188so2253189wmu.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2I0Cwdw6DhsE7UCLIzHUkREHb8Z7quMrqFm7k861wNU=;
        b=Zfm+GoDGAh6O02kDPdw+5lm+mfVDoQFoQhO59WXiVOjRyP70rU3Q68xjWYdAH/lRcE
         gOSWlKUSr7lDTl+t8mLf8NlPFysXqalk8HsdRai1ewWANsIf79IfTkkk292KkmnyCG9t
         y6enMk0cUjyajrdDRsPizDqg8pEIpcARF25oD+vUqk23qIx9hJFUHLT4ZjFu2nFvMkzY
         +hqC2D146wcsXnAvkXXdfAhaOig6kK9oSpOm6mBDf/6chopXBgF23EhSrA/sAMAQQfdP
         GSk+lGzF/sqWsdgYckZgGDRxvGIzc1t1lEAaa7iQRmx/BQMN06FajyELdZtWSi7MAhkQ
         C6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2I0Cwdw6DhsE7UCLIzHUkREHb8Z7quMrqFm7k861wNU=;
        b=mdhZW6DnNlW5gdEo4eB8AWdHheZKuoSlABJSpBPaHITbchcR0QuXveM2qgt1EhnqxX
         WNyT7U5umeR/mpRG3Anm3jkJ6Es95Q8DoteHCCF3d0BbiTXtcmynAs/9umsvMDkTwXFB
         EedIoSz+3JVkYXPiLoDMQolOqfPAJpKRscvUeC9oNpFrw+zwwapBRqZK8KYwQcsD9oaX
         3oCoH7hcI9tQ10wNLjymW9EeL+nWzrUrvu/QKbIKgjCVH0TzNI/TKoNnPu6oD4M5E1R6
         qwY5L7rLR+yJy+3raH0LKsFQHJ4o94M7ReqWGNPrYL+/iW7edKRGpfBm0iyh8/GEUYvK
         G/Og==
X-Gm-Message-State: AOAM533X9ZzWHjvjmiMiS3N3Y6s9L4FkE1gWR8JtTrpRloGpmC1HIq/h
        5X5/ZIcjBLovsUTxyymFFCkPGItvkjvF7w==
X-Google-Smtp-Source: ABdhPJzIrzt6E86Ntqvw6Kik1NO2R+nekuZj+7j8JCrJZslvo541OcVjHEtEOWZiZNG8sG5Enxlwxw==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr3784958wma.34.1589873760226;
        Tue, 19 May 2020 00:36:00 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4852:3600:e80e:f5df:f780:7d57? ([2001:16b8:4852:3600:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id n9sm19679494wrv.43.2020.05.19.00.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 00:35:59 -0700 (PDT)
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, willy@infradead.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
 <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <aade5d75-c9e9-4021-6eb7-174a921a7958@cloud.ionos.com>
Date:   Tue, 19 May 2020 09:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/20 7:12 AM, Andrew Morton wrote:
> On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:
>
>> We can cleanup code a little by call detach_page_private here.
>>
>> ...
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>>   	if (rc != MIGRATEPAGE_SUCCESS)
>>   		goto unlock_buffers;
>>   
>> -	ClearPagePrivate(page);
>> -	set_page_private(newpage, page_private(page));
>> -	set_page_private(page, 0);
>> -	put_page(page);
>> +	set_page_private(newpage, detach_page_private(page));
>>   	get_page(newpage);
>>   
>>   	bh = head;
> mm/migrate.c: In function '__buffer_migrate_page':
> ./include/linux/mm_types.h:243:52: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
>   #define set_page_private(page, v) ((page)->private = (v))
>                                                      ^
> mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
>    set_page_private(newpage, detach_page_private(page));
>    ^~~~~~~~~~~~~~~~
>
> The fact that set_page_private(detach_page_private()) generates a type
> mismatch warning seems deeply wrong, surely.
>
> Please let's get the types sorted out - either unsigned long or void *,
> not half-one and half-the other.  Whatever needs the least typecasting
> at callsites, I suggest.

Sorry about that, I should notice the warning before. I will double 
check if other
places need the typecast or not, then send a new version.

> And can we please implement set_page_private() and page_private() with
> inlined C code?  There is no need for these to be macros.

Just did a quick change.

-#define page_private(page)             ((page)->private)
-#define set_page_private(page, v)      ((page)->private = (v))
+static inline unsigned long page_private(struct page *page)
+{
+       return page->private;
+}
+
+static inline void set_page_private(struct page *page, unsigned long 
priv_data)
+{
+       page->private = priv_data;
+}

Then I get error like.

fs/erofs/zdata.h: In function ‘z_erofs_onlinepage_index’:
fs/erofs/zdata.h:126:8: error: lvalue required as unary ‘&’ operand
   u.v = &page_private(page);
         ^

I guess it is better to keep page_private as macro, please correct me in 
case I
missed something.

Thanks,
Guoqing

