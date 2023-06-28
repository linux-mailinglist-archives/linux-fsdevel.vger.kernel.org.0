Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB337419D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjF1Uob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjF1UoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:44:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF8273C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:44:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3ecb17721so683705ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687985058; x=1690577058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejsKIyVRBFan8VJ9IKuG6jAxQwsigCKUHf+edp4flfk=;
        b=mBe4zOsrI2jrJH45CDZ+NoK4Ynp7o8trm5fFOz+/0bMUk5Sa4k5xVTWcvtfVGlXqb+
         f0BHD7t9cPoMEJe/sr9pgTBeJKUiJ/YK5kKAKYuUAZfyjejopmbDZYmedX8ClE91tIOP
         Mwc5XiMakJf2L3vreUoGP3r/YSJnqBY2iMJpWh3h+eIMLZSO96z8auHPdd+96b1d9zok
         e9taQrwkzo9yJys0Pio9hsB0LnIDYRGqC0G7Yf95mmxp3QYmoqdRPbFtmaDXK94uLCdN
         UG5Ko2ylS5KNnxRgHWv4/lhdyr8Oa0HkrbWNjEr/iico6IppyaVq9Ok9KMOkpE+hK5xI
         dDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985058; x=1690577058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejsKIyVRBFan8VJ9IKuG6jAxQwsigCKUHf+edp4flfk=;
        b=Mvm5tIaLfrxoZrxDRPjRwT5J6hKzqb9RU8uatBsVk1XqPZpWdq4E47RSZll022FzAp
         lFiAnok8u+qSgyKIXSCNVahTI5iQcBWPGLw0Umz/5L2R87bXParJd1IT6IjycyMo2bFD
         sTR/vGBmtjTFixkpXDMe2q0PATKYzG3zQCg1BGeUWSrJgCla4lSxiQmqqdNWQclbCCin
         pxi8wyj5qDX/3p2ZGO2JbND21p9yh9Rq2+ysE0pHYZQJLNrI0VPReAiLDo6RNQTEdtbw
         P4ZT3ysRGBvIKfSmZ0FxOp7YqWhjEf/WmaVRCPJZnTi3YNX0jDHiwObTccf4E1zb0Rce
         uYbw==
X-Gm-Message-State: AC+VfDxEbZy6GQzNGHEbRKBP/GMzmUdokD4qKvPIInfK0kWpI/9gW8T+
        GEZUJuwsQYbECJMjWHi6oSlNIw==
X-Google-Smtp-Source: ACHHUZ53mbHNFgI8GCEXV6OHDatzKRTaQZh/XOOmI00YVS41O32qDosm0pHM0a/937YX5tFl8tB+AA==
X-Received: by 2002:a17:902:f688:b0:1ad:e3a8:3c4 with SMTP id l8-20020a170902f68800b001ade3a803c4mr42420454plg.4.1687985058005;
        Wed, 28 Jun 2023 13:44:18 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a0ccf00b0025bfda134ccsm8878153pjt.16.2023.06.28.13.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:44:17 -0700 (PDT)
Message-ID: <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
Date:   Wed, 28 Jun 2023 14:44:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
References: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 11:52?AM, Kent Overstreet wrote:
> On Wed, Jun 28, 2023 at 10:57:02AM -0600, Jens Axboe wrote:
>> I discussed this with Christian offline. I have a patch that is pretty
>> simple, but it does mean that you'd wait for delayed fput flush off
>> umount. Which seems kind of iffy.
>>
>> I think we need to back up a bit and consider if the kill && umount
>> really is sane. If you kill a task that has open files, then any fput
>> from that task will end up being delayed. This means that the umount may
>> very well fail.
>>
>> It'd be handy if we could have umount wait for that to finish, but I'm
>> not at all confident this is a sane solution for all cases. And as
>> discussed, we have no way to even identify which files we'd need to
>> flush out of the delayed list.
>>
>> Maybe the test case just needs fixing? Christian suggested lazy/detach
>> umount and wait for sb release. There's an fsnotify hook for that,
>> fsnotify_sb_delete(). Obviously this is a bit more involved, but seems
>> to me that this would be the way to make it more reliable when killing
>> of tasks with open files are involved.
> 
> No, this is a real breakage. Any time we introduce unexpected
> asynchrony there's the potential for breakage: case in point, there was
> a filesystem that made rm asynchronous, then there were scripts out
> there that deleted until df showed under some threshold.. whoops...

This is nothing new - any fput done from an exiting task will end up
being deferred. The window may be a bit wider now or a bit different,
but it's the same window. If an application assumes it can kill && wait
on a task and be guaranteed that the files are released as soon as wait
returns, it is mistaken. That is NOT the case.

> this would break anyone that does fuser; umount; and making the umount
> lazy just moves the race to the next thing that uses the block device.
> 
> I'd like to know how delayed_fput() avoids this.

What is "this" here? The delayed fput list is processed async, so it's
really down to timing for the size of the window. Either the 388 test is
fixed so that it monitors for sb release like Christian described, or we
can paper around it with a sync and sleep or something like that. The
former would obviously be a lot more reliable.

-- 
Jens Axboe

