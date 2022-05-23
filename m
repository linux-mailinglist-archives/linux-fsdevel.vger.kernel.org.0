Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCB5312E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiEWOfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiEWOez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 10:34:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D13C11148
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 07:34:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q203so15516169iod.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1COHOGKRFbbG8xAy5JqRam291wm9FVduI8EByUEKtSI=;
        b=fWnsPib7lbMRBULiVOR91uXJsp+8q6X3ngv7ldzkVAEO1MEu3/qqj1RXRMv/daYTkU
         NThUiL6+HdYV4NjScM/7y97xaTWQf1Ve/8/Js2thYG8r1b+mlGg8V9q0BvQLxQL0bWZH
         z8Ksotkoyy0vj6vZLegv6MVKPLFzbpu6zrzp335fHBXjqVtpkBJf9iWTcH1GTfla5ubU
         0kGGMkMEHxvdVbdG+xvk40qvZPlOyzLlj2F8KaDGNZfmQ4c8QvYYvklIlKTg2RlaPtKx
         7bfv2hESlz9mfyZQ2H3zOsFo+fj7iiL3Dbj85m1iVsYAH+WaJ8uJRFaCxlN7hM0T7r5O
         DKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1COHOGKRFbbG8xAy5JqRam291wm9FVduI8EByUEKtSI=;
        b=0rMC8oXrar8HrJkhEiR+BRAW1/z2yKEOzXz8cRpYtTUI75/gOC5eh4ZQLHubWsGHzE
         X2uyV2BIZI72F2Ku5G/9RkuwiAY4ef5q/bN0frDFlhJaSWjvMpQyKgiKmkZakvmJZWHC
         jEX93puaqZZOnfBs2O2pegnl7tpcpKKB2VWetwmVr15xLHPi/iKvEtapecMaozUcfAYK
         Y1OsQf8gEFtMnBsLpB1UVc1DILvwT0946OZMXJg8W9VE2cZIfcsMIaeei+HvXScMYwsJ
         OCBP3sVywO5floW6mIaYQ+QCIpAUId9YDhelDrpWtyjtoWzm1QvZV6ki/pEXJdUCJ3ax
         eufA==
X-Gm-Message-State: AOAM533quVa5V0aILCHsWLK8ncDgkSwmuJtsmdhOUv+ZyCOsht8jL2C/
        KY2TLghdmV7mQFhLdIhaIwj3px6M8Ti5wQ==
X-Google-Smtp-Source: ABdhPJxm8JzKKwEivTkKSPH/9Ik9wm/OFt55rQ+cfsbzCzQZZAV5R2Gs46f7wWQXp4ZNYqER1vpBtA==
X-Received: by 2002:a02:860f:0:b0:32e:99b4:d75e with SMTP id e15-20020a02860f000000b0032e99b4d75emr8143529jai.298.1653316486708;
        Mon, 23 May 2022 07:34:46 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d8-20020a02a488000000b0032e4d3933bcsm1067857jam.122.2022.05.23.07.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:34:46 -0700 (PDT)
Message-ID: <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
Date:   Mon, 23 May 2022 08:34:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/22 08:22, Al Viro wrote:
> On Sun, May 22, 2022 at 08:43:26PM -0600, Jens Axboe wrote:
> 
>> Branch here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=iov-iter
>>
>> First 5 are generic ones, and some of them should just be folded with
>> your changes.
>>
>> Last 2 are just converting io_uring to use it where appropriate.
>>
>> We can also use it for vectored readv/writev and recvmsg/sendmsg with
>> one segment. The latter is mostly single segment in the real world
>> anyway, former probably too. Though not sure it's worth it when we're
>> copying a single iovec first anyway? Something to test...
> 
> Not a good idea.  Don't assume that all users of iov_iter are well-behaving;
> not everything is flavour-agnostic.  If nothing else, you'll break the hell
> out of infinibarf - both qib and hfi check that ->write_iter() gets
> IOV_ITER target and fail otherwise.

OK, I'll check up on that.

> BTW, #work.iov_iter is going to be rebased and reordered; if nothing else,
> a bunch of places like
>         dio->should_dirty = iter_is_iovec(iter) && iov_iter_rw(iter) == READ;
> need to be dealt with before we switch new_sync_read() and new_sync_write()
> to ITER_UBUF.

I already made an attempt at that, see the git branch I sent in the last email.

-- 
Jens Axboe

