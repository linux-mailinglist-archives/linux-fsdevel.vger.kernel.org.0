Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08053CA57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiFCNEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiFCNEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:04:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7F10E5
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jun 2022 06:04:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso4303951wmn.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jun 2022 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xefno9BRMaznVjGWpJqFujzBMkdM7h0wTTai3ECWRnw=;
        b=DSGw+PQnD1zilwmt8UG6eTzMKU/KiULGYnvDBrk9sNsYbtG24Z5PJyRFmRQKDDVFRv
         JgVgL6yt5+ii1kPjHe8MdjYzvNOxzCkxJGnZ/8/ND5LADeQcHqwxG/aH2rNhEiVxlmG3
         puB3M5aKburUFpm7XdPSf304z11btuh6vPQOrlmtBMXZUGaO8t2lY1YJC6zNK19HfQAV
         XOeQt11YIIs2MQBOeXl7c8WJ9fE9wc2RFPGjQw2BizqZyz2IoZCS6FJ4Cu1mAzx3P73g
         MXtyWvgLpNMxm0HTT2wwW3BgXOBOIEi1V+XG82LPalMIIS9zG+OWzD9/Q1WAwH635nS+
         NvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xefno9BRMaznVjGWpJqFujzBMkdM7h0wTTai3ECWRnw=;
        b=6T0VcCryyVhAmZlRNfItrKGFTCJjfvJdYbGhRUanVxB+x2ukn1AcN6BRCBsSlgpYpV
         PWEU7D/i5DqKJGj7axYdv6EeqStcTW11rAzwbg/dYzNDhuwNTidEBDGWQXOy/tIxwd0i
         b7xtg3VWUtAlRNCb0aLih45cYDhZ4T+VXzL9LCltPIvsxlWHUFHyCi0iDJkTPnC8WGw9
         T6GikmlejfdGW9xp3vf3rCSnAdVSVkZ2Z/BcVEmhBAOZuJC2GcQopgstYVudue9wfHYD
         jyIGz/ZC9Nd8ROFO62UjJRYH1+fRnJ9cMvsBvamjk2Sfwcml0qdB8Py4fIbisKpLWfeQ
         TREg==
X-Gm-Message-State: AOAM531/XYlOZwe43fNpfoqqYU2yrRWh66UR0P7kuXUnsZ/QxYK/76l2
        xCkgQCbHxxG+XVLUCfNI47E4eQ==
X-Google-Smtp-Source: ABdhPJyFiUIiXqa6BnyIIt8MXwIskAfhmGqYHLaz1nxTa+gqvCOZ9W8kKM3ThR27pu9THilhOOyoaw==
X-Received: by 2002:a05:600c:35c1:b0:394:8621:a1d5 with SMTP id r1-20020a05600c35c100b003948621a1d5mr37855746wmq.196.1654261474422;
        Fri, 03 Jun 2022 06:04:34 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003942a244f53sm11611241wmq.44.2022.06.03.06.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 06:04:33 -0700 (PDT)
Message-ID: <324b506e-ad35-797d-d7d7-cfc8bec26e8e@kernel.dk>
Date:   Fri, 3 Jun 2022 07:04:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 00/15] io-uring/xfs: support async buffered writes
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, hch@infradead.org
References: <20220601210141.3773402-1-shr@fb.com>
 <545ab14b-a95a-de2e-dbc6-f5688b09b47c@kernel.dk>
 <20220603024329.GI1098723@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220603024329.GI1098723@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/2/22 8:43 PM, Dave Chinner wrote:
> On Thu, Jun 02, 2022 at 02:09:00AM -0600, Jens Axboe wrote:
>> On 6/1/22 3:01 PM, Stefan Roesch wrote:
>>> This patch series adds support for async buffered writes when using both
>>> xfs and io-uring. Currently io-uring only supports buffered writes in the
>>> slow path, by processing them in the io workers. With this patch series it is
>>> now possible to support buffered writes in the fast path. To be able to use
>>> the fast path the required pages must be in the page cache, the required locks
>>> in xfs can be granted immediately and no additional blocks need to be read
>>> form disk.
>>
>> This series looks good to me now, but will need some slight rebasing
>> since the 5.20 io_uring branch has split up the code a bit. Trivial to
>> do though, I suspect it'll apply directly if we just change
>> fs/io_uring.c to io_uring/rw.c instead.
>>
>> The bigger question is how to stage this, as it's touching a bit of fs,
>> mm, and io_uring...
> 
> What data integrity testing has this had? Has it been run through a
> few billion fsx operations with w/ io_uring read/write enabled?

I'll let Stefan expand on this, but just mention what I know - it has
been fun via fio at least. Each of the performance tests were hour long
each, and also specific test cases were written to test the boundary
conditions of what pages of a range where in page cache, etc. Also with
data verification.

Don't know if fsx specifically has been used it.

-- 
Jens Axboe

