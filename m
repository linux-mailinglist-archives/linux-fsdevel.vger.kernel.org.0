Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF873A21C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFJBOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 21:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:14:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D88DC061574;
        Wed,  9 Jun 2021 18:11:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c138so12859839qkg.5;
        Wed, 09 Jun 2021 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w+F1Qa5qLSBBzzu+wJp6x/sjcWUxdv1J6Gk4VtIXQps=;
        b=lki+T/E467sPZJcI14fubHDKlCo2yQkfriHEyLJuIZicjP8zOGFQn96GqsdaOvRn21
         7ahSzhT8cboSYxG6tReYJ/21iHuzr3j1rjq5ZDvUN+i50FrFYOPMuRlj3YavV8AnGRic
         ZLdtR3F5WbRn5V0kbbDfoxEjM3U0b5darEXOZbTcip7iDpidY1nUjJEQm/QxDdqeenBt
         8e2XbqdTewZnvnL0OLySvvGKxo2o0c1KK90R2wuG+eOHh+QKljGLFnnfZNBG18UndT0R
         DDrb8bBAar/fNswPs//xLBwr2kF3aer36SiuS0AkF9lZbq/o9IbrO1YY6jwqoElagTyD
         uAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w+F1Qa5qLSBBzzu+wJp6x/sjcWUxdv1J6Gk4VtIXQps=;
        b=fFKMqHHNlvGvNSftEz2QcYz3lome3IaE9qAmDw/w5EvqO19Ut91HCZJZzeHCohbohn
         I3INHSoHpIhiqvkSa9kjcelsRs2sKMsAdoAA2B0ocYTOw5YRe8JDB4+CofetbbobHlAk
         99w2B1d3/sTRLtXAZIYmMJeAxsL6rUFw4kClrjtrZNRyFeE8zRrkwsKaz2XSZlbMoN/9
         m7D4t+qSJ5gIb2nsvdWDpg2V4uOPu+HEVN4Gd23cq1gyszM7a9fYGmhjn5crdHgeqoIN
         kos6FuG15iM/eAdR5L+wzy9TH0tf9NVa3Ec4d0B38aGPx8oGJ5onQoNBKwVZpL2Z388B
         sJYQ==
X-Gm-Message-State: AOAM531Vlzu2BkAU+f65MxL5UfYNOqJQxTz7JPWjy7613qRoEAB/USA3
        k2kxhRJ8mzvLCMDglVsMiST7d0PhNgflJg==
X-Google-Smtp-Source: ABdhPJwFKhzSmzANdMCDj3f85Qk9X0smIlAZFdBJ5JwlzE3vMtgN0daBdJkcbAYvQ1Tujg2L9fN5rg==
X-Received: by 2002:a37:73c7:: with SMTP id o190mr2466115qkc.314.1623287514949;
        Wed, 09 Jun 2021 18:11:54 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-195-35.bstnma.fios.verizon.net. [173.48.195.35])
        by smtp.gmail.com with ESMTPSA id n194sm1200673qka.66.2021.06.09.18.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 18:11:54 -0700 (PDT)
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <DM6PR04MB7081477ECBE0BB4EC27D2C90E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <751402df-606d-092d-e845-c423b69e3f84@gmail.com>
Date:   Wed, 9 Jun 2021 21:11:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081477ECBE0BB4EC27D2C90E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/21 8:16 PM, Damien Le Moal wrote:
> On 2021/06/10 3:47, Bart Van Assche wrote:
>> On 6/9/21 11:30 AM, Matthew Wilcox wrote:
>>> maybe you should read the paper.
>>>
>>> " Thiscomparison demonstrates that using F2FS, a flash-friendly file
>>> sys-tem, does not mitigate the wear-out problem, except inasmuch asit
>>> inadvertently rate limitsallI/O to the device"
>> It seems like my email was not clear enough? What I tried to make clear
>> is that I think that there is no way to solve the flash wear issue with
>> the traditional block interface. I think that F2FS in combination with
>> the zone interface is an effective solution.
>>
>> What is also relevant in this context is that the "Flash drive lifespan
>> is a problem" paper was published in 2017. I think that the first
>> commercial SSDs with a zone interface became available at a later time
>> (summer of 2020?).
> Yes, zone support in the block layer and f2fs was added with kernel 4.10
> released in Feb 2017. So the authors likely did not consider that as a solution,
> especially considering that at the time, it was all about SMR HDDs only. Now, we
> do have ZNS and things like SD-Express coming which may allow NVMe/ZNS on even
> the cheapest of consumer devices.
>
> That said, I do not think that f2fs is not yet an ideal solution as is since all
> its metadata need update in-place, so are subject to the drive implementation of
> FTL/weir leveling. And the quality of this varies between devices and vendors...
>
> btrfs zone support improves that as even the super blocks are not updated in
> place on zoned devices. Everything is copy-on-write, sequential write into
> zones. While the current block allocator is rather simple for now, it could be
> tweaked to add some weir leveling awareness, eventually (per zone weir leveling
> is something much easier to do inside the drive though, so the host should not
> care).
>
> In the context of zoned storage, the discussion could be around how to best
> support file systems. Do we keep modifying one file system after another to
> support zones, or implement weir leveling ? That is *very* hard to do and
> sometimes not reasonably feasible depending on the FS design.
>
> I do remember Dave Chinner talk back in 2018 LSF/MM (was it ?) where he
> discussed the idea of having block allocation moved out of FSes and turned into
> a kind of library common to many file systems. In the context of consumer flash
> weir leveling, and eventually zones (likely with some remapping needed), this
> may be something interesting to discuss again.
>
Some of the other bits that make this hard in the embedded space include 
layering on top of device mapper - using dm verity for example - and our usual 
problem of having apps that drive too many small IO's down to service sqlite 
transactions.

Looking to get some measurements done to show the write amplification - measure 
the amount of writes done in total by applications - and what that translates 
into for device requests. Anything done for metadata, logging, etc all counts as 
"write amplification" when viewed this way.

Useful to try and figure out what the best case durability of parts would be for 
specific workloads.

Measuring write amplification inside of a device is often possible as well so we 
could end up getting a pretty clear picture.

Regards,

Ric




