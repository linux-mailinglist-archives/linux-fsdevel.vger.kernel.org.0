Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93D666C5CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjAPQK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 11:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjAPQJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:09:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB3223DB0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 08:06:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z4-20020a17090a170400b00226d331390cso31471383pjd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9gM8x3cA80HqU3e2luPT3SBWdSZm60Sxg3tlhcnbas=;
        b=YVvQ/VNmlxI9+70G9+L+xZiF8Yt9U7zV43DBl9Rt9ZB+aiOkNsGX8xmxrxdl4od2I3
         23+PVRwUalnF5kxsnwMH6teOhr2HB4Mhv+kex3/o2repuRxP6Vfs3z38VZonsnsEuCQL
         cWJvQF7JXvJpbUrV/dozhhy9/6HFVpvHDCdXRMbDXE1SbYQB5A6WDl82X6+MSvRCGkDB
         urJyNNnyo2cXGnxm59yt3r30pnid+dmJNOjAxo383FJTGnILsCTrnq5JRoyEPd2klpMK
         Io68eE1qrnWlBX92es8RJmKDcOC+twlvIhU0WtXP8yyx0box2wBOSUtXn5Xf/9psurpU
         tHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gM8x3cA80HqU3e2luPT3SBWdSZm60Sxg3tlhcnbas=;
        b=qaqHElLziVUuKoc597xYA+Q5r6/nsvwiYG8dc6wQBqzpQ55L1JIzlSsMznYw2fE9G5
         mZCM8si6uPuhq72Cu6cJpurNCOBkC4R2cT0MEUWgC0Ooge5I+al54twZMyUjpSphzP6G
         5Itgm0t69R27jum8QbUyNU/5U6dDMIybmH5kcULqZ4Z4SN9RLoWnBewLfmnbHimdVPFR
         dDQ+ZK99YgDHTsA2HE0w1xv0fgYNQlKnZTgO6uGqcUlMi1rV5ZL3OmlOEUxkghAyLvW9
         hsyc2zYzj0SySv08QT7KRG/mo14Oh1c78Ncf9C4V1kGBzq8WZGB/7zmmHYLCsb1dsfR3
         RP9w==
X-Gm-Message-State: AFqh2kpNkNkojsJp7p8JjMkmiGS3TxHGcegj8s0awpJHcZRPMxrD1led
        LEtryFl46aPkEpPIa0jKCUog6w==
X-Google-Smtp-Source: AMrXdXsLh8uS3Aoxku3KEh1nP9y/QeKTnjERWbT/UnhUamaax19+qcuq1F44NN6vFG4lX2YX1a8sgA==
X-Received: by 2002:a17:902:7041:b0:194:5b98:4342 with SMTP id h1-20020a170902704100b001945b984342mr57781plt.5.1673885189855;
        Mon, 16 Jan 2023 08:06:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b0017f72a430adsm19677815plg.71.2023.01.16.08.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:06:29 -0800 (PST)
Message-ID: <70e4869e-1ab8-9838-5af8-8cd41a536f2b@kernel.dk>
Date:   Mon, 16 Jan 2023 09:06:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Is there a reason why REQ_OP_READ has to be 0?
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2117829.1673884910@warthog.procyon.org.uk>
 <Y8V1n4e/eeOd4n8/@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8V1n4e/eeOd4n8/@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/16/23 9:04?AM, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 04:01:50PM +0000, David Howells wrote:
>> Hi Jens, Christoph,
>>
>> Do you know if there's a reason why REQ_OP_READ has to be 0?  I'm seeing a
>> circumstance where a direct I/O write on a blockdev is BUG'ing in my modified
>> iov_iter code because the iterator says it's a source iterator (correct), but
>> the bio->bi_opf == REQ_OP_READ (which should be wrong).
>>
>> I thought I'd move REQ_OP_READ to, say, 4 so that I could try and see if it's
>> just undefined but the kernel BUGs and then panics during boot.
> 
> There's all kind of assumptions of that from basically day 1 of
> Linux.  The most obvious one is in op_is_write, but I'm pretty sure
> there are more hidden somewhere.

I didn't get this original email...

I would not change this frivilously, as Christoph says we've used 0/1
for basic read/write data direction since basically forever. So for all
intents and purposes, yes that is basically hardwired.

-- 
Jens Axboe

