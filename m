Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF411BD1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 20:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLKTeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 14:34:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41682 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:34:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so11231294pgk.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 11:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oTBM3Y8vtSCzFzu0QQg+BVLSXCcLcCz6WCWWZBR21KA=;
        b=UEc8drWiceCBzQdP4WwAoRAD4V9C8sKEg1FLZDGDXLCkv8SbOs8zwnIk4j4teD70TQ
         zu3XDVEqS0EnJllQjOUM6+x7WDFpjiN4tCdoxtd96kpgrZuojVNnQ3WCdzO8hrIGimef
         fnHc55Fbo/bxYc1XfbgqN+dNMxRvtkS8JevaSnJTIpvmwnaB67TAKCMCf14UO4Bl4zu5
         UqJm0hPSbnuKp8beqgNeMsf3+YE1GCzj/K0Jz7y78tfQBKFvsoND1kjiaOAfHBmqr9kL
         Hgm29eQ9eqkD1sv7X41r2IVl2JBbKD7xK/4WEFU32jHuSskS0ODdtjXYeUMqwtsz0s2e
         nQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTBM3Y8vtSCzFzu0QQg+BVLSXCcLcCz6WCWWZBR21KA=;
        b=TStuCzVG+3neHhdlDqQj4pr+1Pa53slHwY0+BSxefVpRRjjgiK1+4UqhvyJ1w1c+cc
         ae8altr/cUGrnRfKQyJEk2/7ex2wTgmgGwqvZLnu72detRxRVfYtRCDIXcP2VmQ9FD2G
         vvCmtJyxwu8XNDsXypSfh04qoEMeWFxvoMgZve3A5h2fElA3her4Zz8R+SqxWaFVzdIs
         a+GgOICRHkJ1iiTfcQCgMNMUZnkfRRKM484sSqdhmhPb8fHTTNRbFfhh1Pcs6oPNBU05
         ksjw0CN028T1uhWTLrt/xil1GeHzmBH02qH1LTkTIEgQaaIsY2ImQqLv1ua3q3omWUY4
         X7iw==
X-Gm-Message-State: APjAAAXZ6ZOCbHIgX2812WtdSkvkxEz7vb0vvOySfMxLT08+Ejtw5EzW
        siac0NnJgiujO7qXkTixYhhN2w==
X-Google-Smtp-Source: APXvYqxakjCkHk+LpBa3tkB5k/nQDmnN7UkDoqLLam7NqycuO4Nc8u97kPkYrw0QIsVKOd/vBhCxbw==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr5515581pgc.401.1576092883494;
        Wed, 11 Dec 2019 11:34:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id p38sm3138206pjp.27.2019.12.11.11.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:34:42 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
Message-ID: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
Date:   Wed, 11 Dec 2019 12:34:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 10:56 AM, Jens Axboe wrote:
>> But I think most of the regular IO call chains come through
>> "mark_page_accessed()". So _that_ is the part you want to avoid (and
>> maybe the workingset code). And that should be fairly straightforward,
>> I think.
> 
> Sure, I can give that a go and see how that behaves.

Before doing that, I ran a streamed read test instead of just random
reads, and the behavior is roughly the same. kswapd consumes a bit less
CPU, but it's still very active once the page cache has been filled. For
specifics on the setup, I deliberately boot the box with 32G of RAM, and
the dataset is 320G. My initial tests were with 1 320G file, but
Johannes complained about that so I went to 32 10G files instead. That's
what I'm currently using.

For the random test case, top of profile for kswapd is:

+   33.49%  kswapd0  [kernel.vmlinux]  [k] xas_create                          ◆
+    7.93%  kswapd0  [kernel.vmlinux]  [k] __isolate_lru_page                  ▒
+    7.18%  kswapd0  [kernel.vmlinux]  [k] unlock_page                         ▒
+    5.90%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk                  ▒
+    5.64%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave              ▒
+    5.57%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list                    ▒
+    3.48%  kswapd0  [kernel.vmlinux]  [k] __remove_mapping                    ▒
+    3.35%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages                   ▒
+    3.14%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache            ▒

Next I ran with NOT calling mark_page_accessed() to see if that makes a
difference. See patch below, I just applied this on top of this patchset
and added a new RWF_NOACCESS flag for it for ease of teting. I verified
that we are indeed skipping the mark_page_accessed() call in
generic_file_buffered_read().

I can't tell a difference in the results, there's no discernable
difference between NOT calling mark_page_accessed() or calling it.
Behavior seems about the same, in terms of pre and post page cache full,
and kswapd still churns a lot once the page cache is filled up.

-- 
Jens Axboe

