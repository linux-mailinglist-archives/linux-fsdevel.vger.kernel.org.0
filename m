Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD01B996C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD0IKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgD0IKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:10:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F58BC061A10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so19405731wma.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1dLU8YduWUBDKIvk9hl+sTzDJ6YHT5GLBFDPP+SjQU8=;
        b=J+CAqwB2QPN0E5CdjjxES0Yqz9lutFE6OrUW+aWlSRQAVoFskQIOQSp/tXnrrFcY+S
         pfPm9kzykgdcv5B1jTlNiflWU8tkErfeWOEBGdoh0wqB23/ypAx9G4SDqJnsQYrZoIKH
         X3y71AJ9OtH6jCWpLQIt8drRVFp9fLyL8gJJQ3g6cX91BvylB2ea48hyfzvV8CgsfIZ3
         exmB6/AGgR7uZ7coa3aXGWLVxtz6+AwQQKh/9m8YXJOWEpf3UDedfuJp3nrHNhoLmMiB
         PQ9PhY4SXnN8NPL7rTpmpiUGZcojr7xbYpiuvmesL+WLUZ5or7t1Sr7zh01rgfO/kexf
         3gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1dLU8YduWUBDKIvk9hl+sTzDJ6YHT5GLBFDPP+SjQU8=;
        b=MJJXDeNLXe2+4hUSHv6+nEKT/HuU0uFHjf15mWdyofEGxH4PGXjuwqAJUNhh7ftsQW
         a2tGfmnD2XybYvCTKyDw2ZQo7slGZWY0iRrDQ4TuPH+qfvE8q7r2L3AnQd4ykZbQQXOe
         OoOhfH2sKFg6MGJCJOqXFY6ZcjUdJE/vZotCGICLb2Cb4TR08YI5X28RgJm94aRJkQEQ
         77dMpZ2l0JkXn6ToaDGi/cgBhmiHRZOEnVrmWEnGqUawM82eLp8cugZ1Bmmi/54T476Q
         EvCip8jvbiGzvf7wu2aC29eSq8XnQuQUmdq6DppKRyFxqldhyealyW7wyDJszw3oocRL
         UC9A==
X-Gm-Message-State: AGi0PuY3rdqUlPu/HNuKkN9rTa7SXD6I700q9emO5UUFgpLhYVBIOE9O
        eBNDx+8WvYm+m/l8aqho788tIQ==
X-Google-Smtp-Source: APiQypLn3J3RCB8ryYsKWizfosaGEJo/2w9hat+vzkU31n7Rr0/0iPIQaWP6YM/tdzVZON9yzrUYlA==
X-Received: by 2002:a1c:a794:: with SMTP id q142mr24729255wme.4.1587975007193;
        Mon, 27 Apr 2020 01:10:07 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4886:8400:6d4b:554:cd7c:6b19? ([2001:16b8:4886:8400:6d4b:554:cd7c:6b19])
        by smtp.gmail.com with ESMTPSA id d7sm19574961wrn.78.2020.04.27.01.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:10:06 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] include/linux/pagemap.h: introduce
 set/clear_fs_page_private
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, willy@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-2-guoqing.jiang@cloud.ionos.com>
 <20200427055255.GA16709@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <125d6be2-eabb-16d1-19de-82c2e7de3851@cloud.ionos.com>
Date:   Mon, 27 Apr 2020 10:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427055255.GA16709@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On 4/27/20 7:52 AM, Christoph Hellwig wrote:
> Why not attach_page_private and clear_page_private as that conveys
> the use case a little better?

Yes, thanks for the good suggestion. Will rename them if no one else
has new idea ...

>> +static inline void *set_fs_page_private(struct page *page, void *data)
>> +{
>> +	get_page(page);
>> +	set_page_private(page, (unsigned long)data);
>> +	SetPagePrivate(page);
>> +
>> +	return data;
>> +}
>> +
>> +static inline void *clear_fs_page_private(struct page *page)
>> +{
>> +	void *data = (void *)page_private(page);
>> +
>> +	if (!PagePrivate(page))
>> +		return NULL;
>> +	ClearPagePrivate(page);
>> +	set_page_private(page, 0);
>> +	put_page(page);
>> +
>> +	return data;
>> +}
> Can you add kerneldoc comments describing them, including why we
> take the refernces?

Ok, will do.

> Also what is the point of the return value of set_fs_page_private?

In this way, iomap_page_create can just return the function, but you
don't like this way as you replied, will change the return value to "void".

Thanks,
Guoqing

