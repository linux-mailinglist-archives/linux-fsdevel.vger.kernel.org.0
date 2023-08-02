Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AA476D571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjHBRep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHBRe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:34:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21D1735
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:32:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34770dd0b4eso28805ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690997502; x=1691602302;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpOZ1yMdB0doiB97dI1sOacNOsYT6Oppo/8QWL1dVEk=;
        b=5k5dVLGmg7gxRx7no7XxXmRgJRfUAVK30crPsWhEJp5Pm1VaSz80TQcE4wJtQP14Ow
         ej2H6bgI5gj1OZZ+AErMHAuJO/+rR5VReAwiInVRykSOTIpn++kaWsCPuAYFEh0Ramv6
         sFp/WDFEC8v7WQjdTworyf4Ft8QoGGqJRDrDcVpjcKjELficcpH6XPQtYzGcy9wj9k3f
         eMGDZOaqYcoJZmF8dFaz1FH9gY6r13o9HXCGZM2Zrs2C/dQHi+DVtjLKQPoGU0K4tzNF
         Qg1QOUimGURmJQ82AA1p19o/KeIXMj9md6tiwd5LmhZ5jKQr6ojiKEzdZF5OhneI0opc
         GvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997502; x=1691602302;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpOZ1yMdB0doiB97dI1sOacNOsYT6Oppo/8QWL1dVEk=;
        b=fGoDwp/X+iSmP8WslAikTqnA7OaxkQrw2ibNaHhhH4wMUyOF7TzquHn9lEtgOnZhcZ
         kooQRF75HpOjNss03msBiiCoHR9TlLJXTIXeExhNcBtoSMGPDSUrQyzeS4+1ZnwltfRM
         Jp93h+Ojid5tnuqp4imXDrwizE8b08+/OQh+f9lJVACokc0h/NGzbzd4DLGnM5ySn8zU
         QRqHd9bsAkEqiQ8HNszapYT7BcxttbOwuFnRX9eedTM8CXqoDcGYdSCExaGCwCM2CFdn
         //knDd6Ql3Yv4oK+PuO6KXB7+85D7VHzt6k1q5hVPWjXo5okT/K+rzxI0VRmGFXrQrzL
         C3Pw==
X-Gm-Message-State: ABy/qLbDn6RCts8UwnK3R1LfvbmAGHeZQCuqBMhwi6VboNmYCKbi2sQL
        pr+KvNE1neV9EGeEIUVtPhG1uwK4acg3gCk/Q48=
X-Google-Smtp-Source: APBJJlH6gAeA2Snt7XaYLyXjuVtKlSDsG1Ag4tIBjfkoFOcKgHwcPrjIoeQGJRWLYqhluo+DWw378g==
X-Received: by 2002:a92:d08b:0:b0:345:e55a:615f with SMTP id h11-20020a92d08b000000b00345e55a615fmr12875954ilh.2.1690997502393;
        Wed, 02 Aug 2023 10:31:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v15-20020a02b90f000000b0042b4e2fc546sm4535683jan.140.2023.08.02.10.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:31:41 -0700 (PDT)
Message-ID: <aa730341-de7a-6923-f341-9a2be7f59061@kernel.dk>
Date:   Wed, 2 Aug 2023 11:31:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [axboe-block:xfs-async-dio] [fs] f9f8b03900:
 stress-ng.msg.ops_per_sec 29.3% improvement
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
References: <202308022138.a9932885-oliver.sang@intel.com>
 <029f3c86-c206-0ad5-9c42-04ea0b683367@kernel.dk>
 <a2a6e445-1cbd-1c28-af60-3e449f9673ea@kernel.dk>
In-Reply-To: <a2a6e445-1cbd-1c28-af60-3e449f9673ea@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/23 11:01?AM, Jens Axboe wrote:
> On 8/2/23 10:38?AM, Jens Axboe wrote:
>> On 8/2/23 7:52?AM, kernel test robot wrote:
>>>
>>> hi, Jens Axboe,
>>>
>>> though all results in below formal report are improvement, Fengwei (CCed)
>>> checked on another Intel(R) Xeon(R) Gold 6336Y CPU @ 2.40GHz (Ice Lake)
>>> (sorry, since this machine doesn't belong to our team, we cannot intergrate
>>> the results in our report, only can heads-up you here), and found ~30%
>>> stress-ng.msg.ops_per_sec regression.
>>>
>>> but by disable the TRACEPOINT, the regression will disappear.
>>>
>>> Fengwei also tried to remove following section from the patch:
>>> @@ -351,7 +361,8 @@ enum rw_hint {
>>>  	{ IOCB_WRITE,		"WRITE" }, \
>>>  	{ IOCB_WAITQ,		"WAITQ" }, \
>>>  	{ IOCB_NOIO,		"NOIO" }, \
>>> -	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }
>>> +	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
>>> +	{ IOCB_DIO_DEFER,	"DIO_DEFER" }
>>>
>>> the regression is also gone.
>>>
>>> Fengwei also mentioned to us that his understanding is this code update changed
>>> the data section layout of the kernel. Otherwise, it's hard to explain the
>>> regression/improvement this commit could bring.
>>>
>>> these information and below formal report FYI.
>>
>> Very funky. I ran this on my 256 thread box, and removing the
>> IOCB_DIO_DEFER (which is now IOCB_CALLER_COMP) trace point definition, I
>> get:
>>
>> stress-ng: metrc: [4148] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>> stress-ng: metrc: [4148]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
>> stress-ng: metrc: [4148] msg           1626997107     60.61    171.63   4003.65  26845470.19      389673.05
>>
>> and with it being the way it is in the branch:
>>
>> stress-ng: metrc: [3678] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
>> stress-ng: metrc: [3678]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
>> stress-ng: metrc: [3678] msg           1287795248     61.25    140.26   3755.50  21025449.92      330563.24
>>
>> which is about a -21% bogo ops drop. Then I got a bit suspicious since
>> the previous strings fit in 64 bytes, and now they don't, and I simply
>> shortened the names so they still fit, as per below patch. With that,
>> the regression there is reclaimed.
>>
>> That's as far as I've gotten yet, but I'm guessing we end up placing it
>> differently, maybe now overlapping with data that is dirtied? I didn't
>> profile it very much, just for an overview, and there's really nothing
>> to observe there. The task and system is clearly more idle when the
>> regression hits.
> 
> Better variant here. I did confirm via System.map that layout
> drastically changes when we use more than 64 bytes of string data. I'm
> suspecting your test is sensitive to this and it may not mean more than
> the fact that this test is a bit fragile like that, but let me know how
> it works for you with the below.

Thinking about this just a bit more - it's clear that the bigger strings
change your layour as well. For some cases, that ends up being a big
win, for some it ends up being a loss. This is just the very nature of
how the kernel is linked, and things like LTO deal with that
specifically.

I don't think there's anything to do here, your test case is just
sensitive to the layout changes caused. That doesn't mean they are
either good or bad, it just means that changes happened and they
happened to impact your test case in either direction.

-- 
Jens Axboe

