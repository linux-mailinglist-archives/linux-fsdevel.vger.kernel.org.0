Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E11AFA76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDSNUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDSNUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:20:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF42C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 06:20:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so6609390wrb.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gfteIevr1qH0eyyotr6S9TJR2AolDVoJEiAoA/Iu81o=;
        b=b7aNmTEYIps1E25elTaxF8+FzkMcl95gG5xpCL1rDDLJVews1roKIsVxrnxncbclCW
         DJAARJzzZHlcSIO3mGBVpI1l/pab97c9SteJDjIreA7diAITfwtvvF25yblrOZ4MaOh6
         MfzlDOtxRj2G+f83n8X8K4KBzyqfPud6R1c/tz5U7lQ1QWJfXJAT/X9iwT4QciZ5C7fs
         H2LOgD8OIfPdryF0487cg5A7Srt3zoFgZlP9EogiV+Pq3QkbH8ETL4Fog/GOCM/v+f9Q
         zDx/r8DBkdnZxznGmwuKejAevlFl88QDjJWZU+5oIvd1hLcM6suyAgOlfPA5LvlgvHZv
         Iv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gfteIevr1qH0eyyotr6S9TJR2AolDVoJEiAoA/Iu81o=;
        b=AUftWrV4tAX9uGWJSK9RWECnv+vhkAVaJFMOH3+Y2rnildbgloPJQ4twEk8GmSAOrS
         buPCHGvhWXAbArMwg2/+mULRRN1BbF//vdxdW7E6FzE1GzQw3HSgKBI84LADGXWMKo9s
         G8xXyKmtyDfVEKV7CgIWGT6KB9IJo8LaHjdMaFhUUdp3VtqahZBk6ESsUPlMPDevPnJz
         GERM+qOBpKWUSD826Eo/9A5e7wQhK7Ntz2/SgjkaqxrZAwo3GHAlBlq0cphj6TRvgyVP
         V2Psy400Gfp8yAVTBGxMpQHjldp9vFUU2Ku4HVnXUW4s5GITjzRFP+OHORgOvGBln2Ww
         RD1w==
X-Gm-Message-State: AGi0PuYEQjrkb1PSswyEL4FUN7EjKiLgJTqUAbMBn93wn1edPtdtxman
        5hS+P3AAgRgt/9oLm3H2PwLsH3SQdx8=
X-Google-Smtp-Source: APiQypIrRUCRZbvIUTJ5RptKmr5dkPQEb31o8PzuJ73mtE+tv4k53QurIQyNGz5lDjE8PVGl3ped+g==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr14723494wrh.254.1587302449296;
        Sun, 19 Apr 2020 06:20:49 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2? ([2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id o129sm10302312wme.16.2020.04.19.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 06:20:48 -0700 (PDT)
Subject: Re: [PATCH 1/5] fs/buffer: export __clear_page_buffers
To:     Nikolay Borisov <nborisov@suse.com>, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200418225123.31850-2-guoqing.jiang@cloud.ionos.com>
 <58a5dcf3-3599-dda7-2b63-b026d82b701d@suse.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <599eaf96-ee0c-023b-18fa-60822bb108bf@cloud.ionos.com>
Date:   Sun, 19 Apr 2020 15:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <58a5dcf3-3599-dda7-2b63-b026d82b701d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.04.20 09:56, Nikolay Borisov wrote:
>
> On 19.04.20 г. 1:51 ч., Guoqing Jiang wrote:
>> Export the function so others (such as md, btrfs and iomap) can reuse it.
>>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   fs/buffer.c                 | 4 ++--
>>   include/linux/buffer_head.h | 1 +
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index f73276d746bb..05b7489d9aa3 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -123,13 +123,13 @@ void __wait_on_buffer(struct buffer_head * bh)
>>   }
>>   EXPORT_SYMBOL(__wait_on_buffer);
>>   
>> -static void
>> -__clear_page_buffers(struct page *page)
>> +void __clear_page_buffers(struct page *page)
>>   {
>>   	ClearPagePrivate(page);
>>   	set_page_private(page, 0);
>>   	put_page(page);
>>   }
>> +EXPORT_SYMBOL(__clear_page_buffers);
> Since this is being exported there is no reason to have __ prefix.
> Rename the function as well,

Yes, it need to be renamed.

>   also why are you exporting it EXPORT_SYMBOL
> and not EXPORT_SYMBOL_GPL just for the sake of consistency with other
> functions in this file or some other reason?

Because I followed EXPORT_SYMBOL(__wait_on_buffer).

Thanks,
Guoqing
