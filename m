Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A552D2DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiESMqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiESMqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 08:46:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8D36310
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 05:46:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c2so4703254plh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2ZWlEemDZrTKXDOdy25O0sTye2+vppjZ+Zvhbx0G8CM=;
        b=jVaMTqh/9vGO8AgRz8vjEUjwMNXjzZNqAS+wPzoNXDZEQQYtcCDzwDz0NxrfteeFi6
         ZM0YG+Q+FJ13HQBu7KYxMg/sHny/5mlDR52MaKdeONgI01nUdYlTZVcdtIIXnIukS4Ps
         hfJxUxLRJtFbXmVaPv3X9hewE3EfstAYunBR72XrpxZbMYxF1RIZSVFyzQB64PCFrvIU
         m4UVZyB0WkjdPcXUZ8jLRQzAAH8BK4R/NZJGJrFC4+XVHnz9jIhniF399MPl/roWOhwR
         5LbJRuCstBRehBfuKUaaMhjQEatsbYQHEwOvuvN62sSyoP8DmqYqZlJoGtCUWjUuVMd5
         /wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2ZWlEemDZrTKXDOdy25O0sTye2+vppjZ+Zvhbx0G8CM=;
        b=3Uq0ED4ESn13eSv1RI+XQqbA1qeBK7ifofhi5FtOmC5dMvVq0tRJZ74b1DSQIOhH5+
         XVtPxnjFabsFBoKlwOr+utJRiyRrwoWPW7HQQ7DY/KYCC30vS3zHEzLdFJXdeHT161yK
         FSNcipG4flw64F+ngHAnW1M1V63+/KXcCza6YBe65w1rGS+/2iI6o4gVRkmSTO6rojez
         1PcULLqK/9zu17QYhb47L1tav1bNdhBjTww/apQD1RnfcGezLoKyC4HXgEre34FJqhMA
         7XMsgFkqZoB2K5jhYQzBuGzrSLoD0n7pdN4rw9ovAkRjMTyzkoWXyYDXBEO2VUKxcLiX
         Sfjw==
X-Gm-Message-State: AOAM532xO6YURO8A7VFvnJyC/k9AeQ+L+JS81SrNOGEgfHLNm+vUM63D
        yvYrmwpLvcKXTPFTQeRGRbj4Aw==
X-Google-Smtp-Source: ABdhPJzeF1qWqkRiWbULZci50AO29+Nb/8GtFi7I5tFhGULXNKR0KIOSxrWV8X415nx1dqKWrSau0Q==
X-Received: by 2002:a17:90b:388f:b0:1dc:6e0f:372b with SMTP id mu15-20020a17090b388f00b001dc6e0f372bmr4969307pjb.93.1652964370610;
        Thu, 19 May 2022 05:46:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p17-20020a63e651000000b003f5e19c047dsm3456890pgj.37.2022.05.19.05.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:46:10 -0700 (PDT)
Message-ID: <92ee257f-c19f-adee-7bd2-409546b95d47@kernel.dk>
Date:   Thu, 19 May 2022 06:46:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <dc8e7b85-fba1-b45e-231e-9c8054aea505@kernel.dk>
 <20220519074225.GH22301@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519074225.GH22301@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/22 1:42 AM, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 04:45:10PM -0600, Jens Axboe wrote:
>> On 5/18/22 11:11 AM, Keith Busch wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> Including the fs list this time.
>>>
>>> I am still working on a better interface to report the dio alignment to
>>> an application. The most recent suggestion of using statx is proving to
>>> be less straight forward than I thought, but I don't want to hold this
>>> series up for that.
>>
>> This looks good to me. Anyone object to queueing this one up?
> 
> Yes.  I really do like this feature, but I don't think it is ready to
> rush it in.  In addition to the ongoing discussions in this thread
> we absolutely need proper statx support for the alignments to avoid
> userspace growing all kinds of sysfs growling crap to make use of it.

OK fair enough, I do agree that we need a better story for exposing this
data, and in fact for a whole bunch of other stuff that is currently
hard to get programatically. We can defer to 5.20 and get the statx side
hashed out at the same time.

-- 
Jens Axboe

