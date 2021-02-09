Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9031518A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 15:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhBIO13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 09:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhBIO11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:27:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60522C06178A
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 06:26:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f16so3313248wmq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 06:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:from:subject:message-id:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Uc4hLLfkzcuaU372Q8Ip+lqv8soO3u0k2b73t1eaFus=;
        b=n9UozebptPP2PPvDim1k4FxcVXje29hmjNsONdbZ5u7jjioGjQPGJV1oOajW7zw4zu
         JQw2WxxRulBdmUafraawGTZbzFndIYdPqdRgoe9g/1GhszCEeDOPFH5G2WcL/qQxIjI/
         qoc2hW5vvxTdLPV3675zX6hefLyIBaqo6Qpjm08HVFK87v7qzED5z5LITq/EE1vIHCew
         dLdVEOOBvu5sDhhDehEGc5nhT7bWAK4kFeiJv4Q7DZJikN1rI+VAFhMZBOE1YjU+rgVV
         J5gayV8gIRvQupK3pXnaGPppGj+++5KZPjQGuYeV3VbPoI2ligcg/rwnvgAOCDmt2KC/
         loeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uc4hLLfkzcuaU372Q8Ip+lqv8soO3u0k2b73t1eaFus=;
        b=r9q0DWmrTOwh/RVHeMY5nHQ7UxJVS6O03yUBYAn/OtaYqH5x3LXMKOB2hag7CIFiwj
         SwKuIKebHHLrED4KIdnrTgBzD7Lw9NsS6wvq3x0Izgugk5HYqBkQ1KbZLasqQJE3QVdN
         62VN6nCszajvjCAY6QEdT3OiZh1ttsUevS3FAPM9zJD6ndjUtwjAD1Z0uG7FuGEZ8AdK
         xVUn322DTZ9PDcygpgJCFnh9RdON2USylSWn9rR1ceQe2Mr7NNkcIz7Of4cTxNIAXcl+
         7Qwz9DB7/PxzOz6jqJIhcXwuknYBdQ614PA5wu8PnUL/ucfEBKEIhVz3hzm0FOCRl5dd
         cf7Q==
X-Gm-Message-State: AOAM532ql0qZ/0INRkWXVZxvOGd28JRfq4SIh+Igijq4pouUJhN5zRIf
        yYIJlGg0lXhqi+ddO4hXzv2Wgg==
X-Google-Smtp-Source: ABdhPJwv+DvJmRgxDf0fCMECeVERTy5UALceUi2tv/8UPY8cpppnpNJqhbI4CBtV4sA8TjumeiSkuQ==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3677321wml.75.1612880806014;
        Tue, 09 Feb 2021 06:26:46 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t8sm4337913wmq.36.2021.02.09.06.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:26:45 -0800 (PST)
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Patrick Daly <pdaly@codeaurora.org>
References: <20210208234508.iCc6kmL1z%akpm@linux-foundation.org>
 <c85a7dba-2f2a-c518-ab9d-26a0c934adda@infradead.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: mmotm 2021-02-08-15-44 uploaded
 (mm-cma-print-region-name-on-failure.patch)
Message-ID: <05e2ea61-af8b-7a75-f458-f936dc8cf65a@linaro.org>
Date:   Tue, 9 Feb 2021 16:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <c85a7dba-2f2a-c518-ab9d-26a0c934adda@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 06:03, Randy Dunlap wrote:
> On 2/8/21 3:45 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2021-02-08-15-44 has been uploaded to
>>
>>     https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
>>
>> This tree is partially included in linux-next.  To see which patches are
>> included in linux-next, consult the `series' file.  Only the patches
>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>> linux-next.
> 
> mm-cma-print-region-name-on-failure.patch:
> 
> This causes a printk format warning on i386 (these used to be readable):
> 
> In file included from ../include/linux/printk.h:7:0,
>                   from ../include/linux/kernel.h:16,
>                   from ../include/asm-generic/bug.h:20,
>                   from ../arch/x86/include/asm/bug.h:93,
>                   from ../include/linux/bug.h:5,
>                   from ../include/linux/mmdebug.h:5,
>                   from ../include/linux/mm.h:9,
>                   from ../include/linux/memblock.h:13,
>                   from ../mm/cma.c:24:
> ../mm/cma.c: In function ‘cma_alloc’:
> ../include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
>   #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                    ^
> ../include/linux/kern_levels.h:11:18: note: in expansion of macro ‘KERN_SOH’
>   #define KERN_ERR KERN_SOH "3" /* error conditions */
>                    ^~~~~~~~
> ../include/linux/printk.h:343:9: note: in expansion of macro ‘KERN_ERR’
>    printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>           ^~~~~~~~
> ../mm/cma.c:503:3: note: in expansion of macro ‘pr_err’
>     pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
>     ^~~~~~
> ../mm/cma.c:503:45: note: format string is defined here
>     pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
>                                             ~~^
>                                             %lu
> 
> because the type of count is not the same as the type of cma->count.
> 
> Furthermore, are you sure that cma->count is the same value as count?
> I'm not.

Good catch. Sorry, it was not intentional.

> 
> (also s/convienience/convenience/ in the patch description)

Thanks! I have fixed these and sent v2.

BR,
Georgi
