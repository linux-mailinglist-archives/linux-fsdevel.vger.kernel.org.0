Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12192D696D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 22:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404608AbgLJVHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 16:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392154AbgLJVHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:07:21 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5917C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 13:06:40 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i18so7133998ioa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apET3TzT7X2gFEqFUfLZxUZDvlyf6N54T9CIp6YhGpg=;
        b=1lOQneS57T4DCXzg/wTZrZtg3spfHe7i5OX41Mie4X2unNKWUR+0VPl7KD5o1g4Pro
         yBPK9ZJlsg4DubYIBEzD4sXKmfe0utj1N4U/v195/JeM1FcTJ+cUlaP8kNPo86DTo/Q7
         5xwjspAk+9252tz6xwckZCZjziOotCmU6MmBQz72beaZocpwrku0fizf2fta/c0Ax/I/
         NEP3/c5h9EU57k3oSfsaS6xPfWW7MsswgjkONYY8XuBzH9Ydh83UJoZUDmFbviatkzps
         CzPAAYyxgE+x7Mn6BuaanJ4BiD2VsgA8rB3fne46Ri97ASYrh1Zt84TJ3AxMRMZJ3zWz
         +xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apET3TzT7X2gFEqFUfLZxUZDvlyf6N54T9CIp6YhGpg=;
        b=TtQW32vkSF58a5B7jQti/2BTWlPOwTlbvlVTbqhRslgEUcJ7us/hg1LA8XicO41vIy
         LYMf7ui4q3Y5zsmzrp0x9oyC29egto+SJJBSClr2BSb/ecq0bla4JQQ1hLPRFY1YVfK3
         dT1DsysUG9YSSjBZrH8MqPHiwg+b5MIexOosJ1hKY6fpw1ZMsoO+GLn20f2fEjFUPY5m
         iAuuJnJicVMZbkY33VklkjNHVnflvfK9TpCpwxjFbzEQEmNlDpqqKrIMSWFL+rviUOtD
         5l7eWh4m2Gzd4ZnorT9sAd2uSQNvBWcoylMDY3Rvd9ZkILBg8g6ZVCMntu6AjQt07uj2
         0bvw==
X-Gm-Message-State: AOAM530vRuEsHveczZMj6knv8Uwzt99Grqlw8daR4oO9OWEmqFXcSd+K
        4+r08GsCG9rGzLjkX1HMTDiUFA==
X-Google-Smtp-Source: ABdhPJxxELSN2c5oFE6kjwKeKDcwcNUnPGWLcqsoXng3bA792nBWczlkZV3v6+3vih9MreSbPCXQUQ==
X-Received: by 2002:a05:6638:216e:: with SMTP id p14mr10911739jak.70.1607634400237;
        Thu, 10 Dec 2020 13:06:40 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o7sm3214832iov.1.2020.12.10.13.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:06:39 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
 <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <139ecda1-bb08-b1f2-655f-eeb9976e8cff@kernel.dk>
Date:   Thu, 10 Dec 2020 14:06:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wif32e=MvP-rNn9wL9wXinrL1FK6OQ6xPMtuQ2VQTxvqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/20 1:53 PM, Linus Torvalds wrote:
> On Thu, Dec 10, 2020 at 12:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> io_uring always punts opens to async context, since there's no control
>> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
>> just doing the fast RCU based lookups, which we know will not block. If
>> we can do a cached path resolution of the filename, then we don't have
>> to always punt lookups for a worker.
> 
> Ok, this looks much better to me just from the name change.
> 
> Half of the patch is admittedly just to make sure it now returns the
> right error from unlazy_walk (rather than knowing it's always
> -ECHILD), and that could be its own thing, but I'm not sure it's even
> worth splitting up. The only reason to do it would be to perhaps make
> it really clear which part is the actual change, and which is just
> that error handling cleanup.
> 
> So it looks fine to me, but I will leave this all to Al.

I did consider doing a prep patch just making the error handling clearer
and get rid of the -ECHILD assumption, since it's pretty odd and not
even something I'd expect to see in there. Al, do you want a prep patch
to do that to make the change simpler/cleaner?

-- 
Jens Axboe

