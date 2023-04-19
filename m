Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA20E6E7108
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 04:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDSCPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 22:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSCPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:15:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02E2681
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 19:15:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63d32d21f95so400527b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 19:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681870505; x=1684462505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omaGeiilnWY8neqCu1aYblokWGcDA5y3QiHgOwpl4SY=;
        b=jDO842tOQzUGfFMlpnl+0xVX3t6R3u7QMAu+s1WrMuaCVxUVgycP/Phvb0HoNh58iV
         xLOhkc8EW1Ikvbi+/i+Dg6fvhkyMeYlA+FTVKE2RrVK3A7rpc+FzJHUxR0wTQ7QQ26t8
         L2EaQEaUlrIPN0uaaIg3XDMhAKNjBJvO8Eea6E4VzoBpfKrX4OSVA4FK7j2bOxK6lK/H
         E4/tztiAvNCbQPn0euQIadpatwx8hSQCAS1/vzs89ylaAlw3oJekdbSEM5Fm92E+AwLm
         6hoKbSPftzXTPPbgVF0j/C7FHTHfnxNNnOccSwEzcnySOyWOL8bIUJZfLr1m5oTSOXTu
         9U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681870505; x=1684462505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omaGeiilnWY8neqCu1aYblokWGcDA5y3QiHgOwpl4SY=;
        b=Tv3Sh31K+FMrskHgmoOil7eLs3m0AZ5nHrl4s/U5tDRnFuaGsPKgMwwSAJzzuae+Im
         MoiBGH2hhCuY62bG7UAH/+JC+MrU7xtomRUogtIxnWRGafPRfbNU+htY6Zbl1S1a+erf
         nDd+1OO77ECbgo2Bsd4uuwg2x+R4qxcPh7OsOpWt6V3t9DTQNlkGo559mcTVHsEwUoc6
         S6QgrYh6dnkL5s0bel6munHMSgclv6tCNbngoujhfN5xy+pRduTaHmjWr9+aAJyqWuHd
         4Jt3QVpgzScewEoQ8XPufakwhUvvgeVv96slpabhgD5+sUqR+8+uafAOBy3TB+jeUXGv
         YSZw==
X-Gm-Message-State: AAQBX9c+NFGAF2b/zQ80SU4U7G+HINa/mzm+hyg+4hzCVMkGQ9A5AoMf
        QUNVCCejNE3fSqjdLVvbuT4mEQ==
X-Google-Smtp-Source: AKy350Zy3gIP/wJlOTrxIJOZjD1BKAKhDNMPB17EIgaujgA65bwcNbe8U/3vRZImIHTIB+BoiThlzA==
X-Received: by 2002:a05:6a00:44c6:b0:638:2493:1710 with SMTP id cv6-20020a056a0044c600b0063824931710mr16865100pfb.3.1681870505004;
        Tue, 18 Apr 2023 19:15:05 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c18-20020aa78812000000b0063b73e69ea2sm7275709pfo.42.2023.04.18.19.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 19:15:04 -0700 (PDT)
Message-ID: <7dded5a8-32c1-e994-52a0-ce32011d5e6b@kernel.dk>
Date:   Tue, 18 Apr 2023 20:15:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
Content-Language: en-US
To:     Wen Yang <wenyang.linux@foxmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
 <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
 <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/17/23 10:32?AM, Wen Yang wrote:
> 
> ? 2023/4/17 22:38, Jens Axboe ??:
>> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>
>>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>>> then a read(2) returns 8 bytes containing that value, and the counter's
>>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>>> N event_writes vs ONE event_read is possible.
>>>
>>> However, the current implementation wakes up the read thread immediately
>>> in eventfd_write so that the cpu utilization increases unnecessarily.
>>>
>>> By adding a configurable delay after eventfd_write, these unnecessary
>>> wakeup operations are avoided, thereby reducing cpu utilization.
>> What's the real world use case of this, and what would the expected
>> delay be there? With using a delayed work item for this, there's
>> certainly a pretty wide grey zone in terms of delay where this would
>> perform considerably worse than not doing any delayed wakeups at all.
> 
> 
> Thanks for your comments.
> 
> We have found that the CPU usage of the message middleware is high in
> our environment, because sensor messages from MCU are very frequent
> and constantly reported, possibly several hundred thousand times per
> second. As a result, the message receiving thread is frequently
> awakened to process short messages.
> 
> The following is the simplified test code:
> https://github.com/w-simon/tests/blob/master/src/test.c
> 
> And the test code in this patch is further simplified.
> 
> Finally, only a configuration item has been added here, allowing users
> to make more choices.

I think you'd have a higher chance of getting this in if the delay
setting was per eventfd context, rather than a global thing.

-- 
Jens Axboe

