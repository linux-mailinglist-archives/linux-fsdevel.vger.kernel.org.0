Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D586CC07D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1NUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjC1NUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:20:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5177285
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 06:20:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kc4so11590847plb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680009614; x=1682601614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToSbE3DDwxVFHNPOcsSb7PwDjlKTin0uEusdBEZc9Wg=;
        b=B7T7e92TP5Hran6MFlZ1I9U8xnXKNNJQggYd5CayJBJL7p8YnEB9DAnya0FePZzvWX
         0xA3ngZhrS1/yWkFUPKvWZHe/ycJhaphvQreUaUEibrexc1JdHQwpfgkozj5FHKkUzKw
         Se7XIG2vGlffj+XWTsvnlBVDJrS6gNuv5Hb5xsEc2ykZDlld9kowBGpEzZAjVhc2FUmo
         BzAuNtiSYJj6LLKUghoqpIOuCywaUA3k/dXxgOJXLC+eUb4xBMuqJQojgpF+fMMlOIQn
         xMNVqqwCr3i+QlwySh+oEq4qMW2inve4D/b+YhPtIPisnvU1F8FbG+z81myTMi8XTpEV
         y03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009614; x=1682601614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToSbE3DDwxVFHNPOcsSb7PwDjlKTin0uEusdBEZc9Wg=;
        b=01d9FD/64VExKnSXkU7bftqOXmEB9tbq1WGbLjyFdLXPxUK5URgtPeQNteNPXVMQdu
         sya9XpLaq30PEQOnE96Mtn++LcgW4pAQ8ddodi4yeZcmkZ8CoxrELsGJ4GW/VTOnt6qG
         /wKeKTdcrLXC6rMo9xuFV+2Qb0XPYgcafhWfVh/YL5LEgdN/szjHAmhFskfuyObyxHbI
         8FLvff+O+2FmqHMf+DO//6xVkZCzhdBYLpWOGZOin1RgN1FYAxmRdeq/TAdnf7I7/CZ0
         e2NtVPJOchLEVla/NH8AHKecD+mMSS5nxno2BQiU6gzo8Zzkik4kWJqKZ+kjtG7CQISJ
         5aZA==
X-Gm-Message-State: AO0yUKUGYwawDnK29R9alIXuaYB6wHdmXF5ULPDiN5iY03QkxBya9+wi
        rISndEPkE0wWBMsmVdAqFQw+iA==
X-Google-Smtp-Source: AK7set9BH6MqerdXhMfw/LnpH/KZJgxTd0lEAErDh1IkWWdWfrWtdPrv/xZAlhYx32pUBd4QOoEy8g==
X-Received: by 2002:a05:6a20:7da6:b0:da:9fa3:66e7 with SMTP id v38-20020a056a207da600b000da9fa366e7mr15029168pzj.0.1680009613894;
        Tue, 28 Mar 2023 06:20:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k16-20020a63f010000000b004fbd021bad6sm19764506pgh.38.2023.03.28.06.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:20:13 -0700 (PDT)
Message-ID: <82be389c-a901-5455-49e6-f130ac2e446c@kernel.dk>
Date:   Tue, 28 Mar 2023 07:20:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] iov_iter: import single vector iovecs as ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230327232713.313974-1-axboe@kernel.dk>
 <20230327232713.313974-4-axboe@kernel.dk> <20230328000811.GJ3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230328000811.GJ3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 6:08 PM, Al Viro wrote:
> On Mon, Mar 27, 2023 at 05:27:13PM -0600, Jens Axboe wrote:
>> Add a special case to __import_iovec(), which imports a single segment
>> iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
>> to iterate than ITER_IOVEC, and for a single segment iovec, there's no
>> point in using a segmented iterator.
> 
> Won't that enforce the "single-segment readv() is always identical to
> read()"?  We'd been through that before - some of infinibarf drvivers
> have two different command sets, one reached via read(), another - via
> readv().  It's a userland ABI.  Misdesigned one, but that's infinibarf
> for you.

How so? We're not changing how we pick ->read vs ->read_iter, just
how the iterator is setup. Either method should be happy with either
iterator type.

-- 
Jens Axboe


