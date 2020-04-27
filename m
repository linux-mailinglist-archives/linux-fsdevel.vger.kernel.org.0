Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10391B9981
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD0IOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgD0IOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:14:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4DFC061A10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 01:14:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so19404575wrw.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f6CJ5aFyM4fKRrqTopc0jdq9pjjYqi1LoBaq/GKwyZs=;
        b=YPBiRy+nSq7IDK5dHSxRvySgNwZeUbkN5WsiUUOGc2HJOCgjuglFRT7b8nnu6y1HnQ
         uJLTaudaJm20tSJnrFLETUfVRHfPX5SHg3OOqC6acpYCvnp4vRi1MigN6eQVbYxWmmye
         gPe+mDLZa8/oUy3/BebhPUF4BoNh4+pqsUTk5bLhd57BfaLYPYCBzh/SLmcasKUeycIf
         otN07fP1OXNprz5X7YG8TikAyBD69M/8guh6JxDV/OraipfOUQ2vNjvipHAjvd2u6l6V
         Cz4nJgQw3zPh8lGc4aWL4e/2/Hdny3j1yiLswyUHv9GvTBbQ7CfBGt6gw4VtIlvPAlQc
         XXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f6CJ5aFyM4fKRrqTopc0jdq9pjjYqi1LoBaq/GKwyZs=;
        b=YDPAzbLLtlHCqtP5iKvu1aFbrCB6oTsMXk0ZhOyYtL+0bXDQ/uXlIDMNOlUaEa8K+X
         /2yaAKt38vSvijWdsxohXAYuDEbif2CNVcuc9pzNZ4+bL3GkQNdxRqRLITkjBcO0WIPC
         svD0qMm/XkiMG+geQ4CTCgkpc0M7XrZotJ7bNP0PkmngtHsSPxTTc1tSDy85FxfBLyyK
         Micu9/onEwMMoWvRdi/qXWOand9y1JZPRN12YQDJ/nBDohkKNG6A+n5Ar0bdOn928+Kk
         kK68mlkZCOIsuP7LBmmaeNyYFRHIkJYsqWA0W4F4eR/pUPaMUF3w/xDhZ9MEuZULTN7A
         AdbQ==
X-Gm-Message-State: AGi0PubuXHDpgr/yE98Pp1dxiGkOAxLYdSfN5jI1Jcrtcq3NeZa3cKHi
        lvrS39ZU8Av6C/vANTgKAKdmhdEF3lvPEsNC
X-Google-Smtp-Source: APiQypKDr9PH7j2xW1VNF+k9cYxYrb4mxRqEK1bORvBgVs2xSEuJvac87v7oyXbhb5xVW4Y6gEaDNg==
X-Received: by 2002:adf:f187:: with SMTP id h7mr26406493wro.331.1587975259110;
        Mon, 27 Apr 2020 01:14:19 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:8400:6d4b:554:cd7c:6b19? ([2001:16b8:4886:8400:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id r17sm19610415wrn.43.2020.04.27.01.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:14:18 -0700 (PDT)
Subject: Re: [RFC PATCH 3/9] btrfs: use set/clear_fs_page_private
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-4-guoqing.jiang@cloud.ionos.com>
 <20200426222054.GA2005@dread.disaster.area>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f0471728-6a03-3e44-f0cc-adb1a6bd3470@cloud.ionos.com>
Date:   Mon, 27 Apr 2020 10:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426222054.GA2005@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/20 12:20 AM, Dave Chinner wrote:
> On Sun, Apr 26, 2020 at 11:49:19PM +0200, Guoqing Jiang wrote:
>> Since the new pair function is introduced, we can call them to clean the
>> code in btrfs.
>>
>> Cc: Chris Mason <clm@fb.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: David Sterba <dsterba@suse.com>
>> Cc: linux-btrfs@vger.kernel.org
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ....
>
>>   void set_page_extent_mapped(struct page *page)
>>   {
>> -	if (!PagePrivate(page)) {
>> -		SetPagePrivate(page);
>> -		get_page(page);
>> -		set_page_private(page, EXTENT_PAGE_PRIVATE);
>> -	}
>> +	if (!PagePrivate(page))
>> +		set_fs_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> Change the definition of EXTENT_PAGE_PRIVATE so the cast is not
> needed? Nothing ever reads EXTENT_PAGE_PRIVATE; it's only there to
> set the private flag for other code to check and release the extent
> mapping reference to the page...

Not know the code well, so I just make the cast ...

>> @@ -8331,11 +8328,9 @@ static int btrfs_migratepage(struct address_space *mapping,
>>   
>>   	if (page_has_private(page)) {
>>   		ClearPagePrivate(page);
>> -		get_page(newpage);
>> -		set_page_private(newpage, page_private(page));
>> +		set_fs_page_private(newpage, (void *)page_private(page));
>>   		set_page_private(page, 0);
>>   		put_page(page);
>> -		SetPagePrivate(newpage);
>>   	}
> This is just:
> 		set_fs_page_private(newpage, clear_fs_page_private(page));
>

Thanks a lot! It is more better.

Thanks,
Guoqing
