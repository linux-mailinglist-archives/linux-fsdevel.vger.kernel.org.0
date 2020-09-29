Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746FE27BFB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgI2Iiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgI2Iiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:38:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B1EC061755;
        Tue, 29 Sep 2020 01:38:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so6102014wme.0;
        Tue, 29 Sep 2020 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dmGf1FRJlXDhCUgK6fiA66lZin9rP4W1yXe+rkN5lfo=;
        b=pRjMRO5D33ilsDuphOJlgFYEuejymTllYwEQ9NL8+sx9tiphg8R8mfSxOqQuMbbaEi
         jCe/ztdfDU4IiL+/ZaTo890rYlE2ON37+Vzui24nT+qJsfycmWRAwBwShTIoVNt7ha6t
         f+rzbyUumVTWZsOzspEIxB/8YpDP/uWJiUpR9QpEtpxYQgQ9AksWRYsX2CmYk/1gMBlG
         2d4d8C35oP6HK5OsCrwueA2GYqlVLnywW3Ua/zd6j+h97yzVSL8tQi3mZgFCSXxzrIbO
         hmXhw2Nh4DBKvH5g2uoieE6S5/YTTTd3KVQFt47CelNpQ8JbJ+ASD1CD3DT3c/xWFJBC
         8iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmGf1FRJlXDhCUgK6fiA66lZin9rP4W1yXe+rkN5lfo=;
        b=iQI4oSJ47ZBwPGr8WJ1UcaI1hstlEP1byQeUI9yjQmDf4n4jx7l9HKkTh2j0EzRXWe
         9TkH6mJI9s2VPrWDd7WIptc63znuiioVttsuozC/TL/Qs5AP0iZyaQxmiRBfEO1oZgmD
         6KJbwTSn3QPOo/yi6XT5cQ1BTDvqA4nPLJJM243tn6jBGYEZV4W072bN6Y31w8/vaIkH
         7GzKGGE3QbYaDawTnr0LUAyhjMpzrIdWdGAxGWYGWO4k02bqcvs9d6UO+UMRZN1tP86d
         nZ6ldOaDQwhlPf6kY6QaIGWC4S6rTuQS00AbzLstIaH8qho/aAOKN5BtDYiz7sHVHRlb
         +n2Q==
X-Gm-Message-State: AOAM532smaB4hG9Kq+6Zm8Q5BhxH6/rpF47Rkl4rT7Sr3loV+fx/0D+V
        NGW6gTx4lm2QDEV4XNuwARRzfORo01U=
X-Google-Smtp-Source: ABdhPJyBHXd39b1Y0Nd8HyE5S8phPtTwTGwEELYDj45/RQlofUJDP7uVEvOWdHxonXnH9wFc7n5rdA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr3304284wme.8.1601368728464;
        Tue, 29 Sep 2020 01:38:48 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id z191sm1470344wme.40.2020.09.29.01.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 01:38:47 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] man/statx: Add STATX_ATTR_DAX
To:     Ira Weiny <ira.weiny@intel.com>
References: <20200505002016.1085071-1-ira.weiny@intel.com>
 <20200928164200.GA459459@iweiny-DESK2.sc.intel.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <ddf4dd69-6bf8-8ca7-cdd7-a949884d997f@gmail.com>
Date:   Tue, 29 Sep 2020 10:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928164200.GA459459@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ira,

On 9/28/20 6:42 PM, Ira Weiny wrote:
> On Mon, May 04, 2020 at 05:20:16PM -0700, 'Ira Weiny' wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> Linux 5.8 is slated to have STATX_ATTR_DAX support.
>>
>> https://lore.kernel.org/lkml/20200428002142.404144-4-ira.weiny@intel.com/
>> https://lore.kernel.org/lkml/20200504161352.GA13783@magnolia/
>>
>> Add the text to the statx man page.
>>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Have I sent this to the wrong list?  Or perhaps I have missed a reply.

No, it's just me being a bit slow, I'm sorry. Thank you for pining.

> I don't see this applied to the man-pages project.[1]  But perhaps I am looking
> at the wrong place?

Your patch is applied now, and pushed to kernel .org. Thanks!

Cheers,

Michael

> [1] git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> 
>> ---
>>  man2/statx.2 | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/man2/statx.2 b/man2/statx.2
>> index 2e90f07dbdbc..14c4ab78e7bd 100644
>> --- a/man2/statx.2
>> +++ b/man2/statx.2
>> @@ -468,6 +468,30 @@ The file has fs-verity enabled.
>>  It cannot be written to, and all reads from it will be verified
>>  against a cryptographic hash that covers the
>>  entire file (e.g., via a Merkle tree).
>> +.TP
>> +.BR STATX_ATTR_DAX (since Linux 5.8)
>> +The file is in the DAX (cpu direct access) state.  DAX state attempts to
>> +minimize software cache effects for both I/O and memory mappings of this file.
>> +It requires a file system which has been configured to support DAX.
>> +.PP
>> +DAX generally assumes all accesses are via cpu load / store instructions which
>> +can minimize overhead for small accesses, but may adversely affect cpu
>> +utilization for large transfers.
>> +.PP
>> +File I/O is done directly to/from user-space buffers and memory mapped I/O may
>> +be performed with direct memory mappings that bypass kernel page cache.
>> +.PP
>> +While the DAX property tends to result in data being transferred synchronously,
>> +it does not give the same guarantees of O_SYNC where data and the necessary
>> +metadata are transferred together.
>> +.PP
>> +A DAX file may support being mapped with the MAP_SYNC flag, which enables a
>> +program to use CPU cache flush instructions to persist CPU store operations
>> +without an explicit
>> +.BR fsync(2).
>> +See
>> +.BR mmap(2)
>> +for more information.
>>  .SH RETURN VALUE
>>  On success, zero is returned.
>>  On error, \-1 is returned, and
>> -- 
>> 2.25.1
>>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
