Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0349E53134B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiEWPz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbiEWPzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:55:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F9483BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:55:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z11so4630473pjc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P4ZfphBhDovakA75HZAhY8GVYg9+YKorXxncvQcZlso=;
        b=YzQjbagMepjAfizZibzvhCJFjXu/HoNku2o23uhUqw3/HPFP304cL4LLRXD6gSw7/N
         DLtMQRZc88+r7fwus8gfYHgbHO0CHUE9zM5lZGYpvJ2SJaqBw0B6JXLbC1YpXiNGIZVH
         tU5eo60h1UUptlqTfh/vaKF4RDk/b7FSGdz8pkIwz2lB+Re1muTk04aaUbr4uYTxGmJ7
         sRiXP6sKoZ50TMaK3Df3BK/Tjw8Ps2tsDHiFDybz0b860LcjMRvjUWdXhq1zjFhPRlXT
         glVq2/2fCocmINuXBEi/g1ppFSiV+Jn45lMmcJ+I5DpOAFiYCofy86ICk50jKQlIUtKn
         IW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P4ZfphBhDovakA75HZAhY8GVYg9+YKorXxncvQcZlso=;
        b=ZZZCl03tV4lfYp0VM/8vt/owGG/FZrl3GGlxcV6Q3UOO3atUAjWLIoslQLk1em3JR3
         z/kwiD6UaxJ5vFCdeH4AAGjsSOCAAnDEFFkg/xe2XJ/IJXDvGlvty9ph3le/qIHqQJvu
         ikPPTKMToZoHDKTKiTfOULUZvP46UcLWR+ZklIoIlagzv0Ir8G6bJ83cVpjBzcSQC4Nx
         ZLx1ymj7je7N0OwUC7KJ0GnAbT/mPiLsFOBrOw381QjxuxhRHmH5xsdxezuWZUEb0vty
         hqo1uWYkdL0qROSg5yM77mvcDQ+gN29KzKVyDEm25C2C4KRPDr3QMVw4a+lKKGh5RJ+A
         d8Vw==
X-Gm-Message-State: AOAM5319euGeq6pSrDw3EciPVJ1lckGvqLO3BY5ENgqKDKIB2+zv3osO
        bpp8xRyAdyDvZ1hbCO2as65U0aFQrTaiWA==
X-Google-Smtp-Source: ABdhPJzuxl1LznThyn0jUUhx1RLQPX9ebBpK75fHPu8UBU2CEy3D+I4iIIx61LK1G/+3Cx4vIxjzhQ==
X-Received: by 2002:a17:90a:8914:b0:1dc:20c0:40f4 with SMTP id u20-20020a17090a891400b001dc20c040f4mr27494552pjn.11.1653321324297;
        Mon, 23 May 2022 08:55:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b0015f0dcd1579sm3758261plh.9.2022.05.23.08.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:55:23 -0700 (PDT)
Message-ID: <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
Date:   Mon, 23 May 2022 09:55:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
References: <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
 <YoutEnMCVdwlzboT@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoutEnMCVdwlzboT@casper.infradead.org>
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

On 5/23/22 9:49 AM, Matthew Wilcox wrote:
> On Mon, May 23, 2022 at 09:44:12AM -0600, Jens Axboe wrote:
>> On 5/23/22 9:12 AM, Jens Axboe wrote:
>>>> Current branch pushed to #new.iov_iter (at the moment; will rename
>>>> back to work.iov_iter once it gets more or less stable).
>>>
>>> Sounds good, I'll see what I need to rebase.
>>
>> On the previous branch, ran a few quick numbers. dd from /dev/zero to
>> /dev/null, with /dev/zero using ->read() as it does by default:
>>
>> 32      260MB/sec
>> 1k      6.6GB/sec
>> 4k      17.9GB/sec
>> 16k     28.8GB/sec
>>
>> now comment out ->read() so it uses ->read_iter() instead:
>>
>> 32      259MB/sec
>> 1k      6.6GB/sec
>> 4k      18.0GB/sec
>> 16k	28.6GB/sec
>>
>> which are roughly identical, all things considered. Just a sanity check,
>> but looks good from a performance POV in this basic test.
>>
>> Now let's do ->read_iter() but make iov_iter_zero() copy from the zero
>> page instead:
>>
>> 32      250MB/sec
>> 1k      7.7GB/sec
>> 4k      28.8GB/sec
>> 16k	71.2GB/sec
>>
>> Looks like it's a tad slower for 32-bytes, considerably better for 1k,
>> and massively better at page size and above. This is on an Intel 12900K,
>> so recent CPU. Let's try cacheline and above:
>>
>> Size	Method			BW		
>> 64	copy_from_zero()	508MB/sec
>> 128	copy_from_zero()	1.0GB/sec
>> 64	clear_user()		513MB/sec
>> 128	clear_user()		1.0GB/sec
> 
> See this thread-of-doom:
> 
> https://lore.kernel.org/all/Ynq1nVpu1xCpjnXm@zn.tnic/

Yikes, will check. Also realized that my > PAGE_SIZE 16k result is
invalid as it should iterate with min(left, PAGE_SIZE). But that just
changes it from 71.2GB/sec to 68.9MB/sec, still a substantial win.
Updated diff below.

Was going to test on aarch64 next...

-- 
Jens Axboe

