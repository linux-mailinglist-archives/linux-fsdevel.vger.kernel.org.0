Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0834E3689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiCVCP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiCVCP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:15:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060A2C65C
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:13:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so939212pjm.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=/P5OxnbhR7ZamFX8YYhdx2mwWRK3X+/iFJvuu8S48vM=;
        b=NGSKX/X2mKuUyToosxIS5+0WGOeH6xO2NjvXT2cYuoflZZ/P/WiIXlGIQtN02Upp17
         A7DBJ8v/QjGQJul0eXdlJaG4ctmIcMT55c5YupMT198Na/PeRVZIvL45M1qECr6TP3Xo
         XL4XgFL+Doswxa6cUUhkLEZ9XeSbLVyFkUQXRf/SM2vEU97jDFug9Sa+UmfPMnotF5NC
         pUgjQQ5JqWncjm1j6jlWZwjuo6mBD0XMvS0NQUyIsYqt1GuQLFnLAG3ElL/jieTwbkcc
         BR4SunEIes66nKmKDLC3LqmJ2RMpAqIcjrAdFqirgf2g+KTXkT/E2tkDYkQ+/Iv27/I4
         PUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/P5OxnbhR7ZamFX8YYhdx2mwWRK3X+/iFJvuu8S48vM=;
        b=6H2tIR2F8AbdZus+jTKmdo+WSZRi7rjR21w2hVH4SFC6Vtvp2GauQ8XvQ/y7M3nbNO
         RdNauNj9fWcujR7fn7VgoWUzupstAOzHc/MM/d4vf0FcFvrcIjz/DfFoWJlc7+oEhHCu
         Kug2M1Fdv5ADbwdJ37B3m3amEDfMtTRnP7EFGpUIX+aMOGwvlBoP50ROYGfTLaDSeDjZ
         52qyhYZplyy2nXSPWu9IoJoZqGLfhc8Tvv5x8V1POg7jeGgQQmOhAjiTpDzme/dTrX2+
         MGTRZbVB/kWIQBQHRZezYcTYXSPUlZZvcFqco7tWZfPQhmd8fA3/xHtYBLs+mAOYHbpk
         ZrZw==
X-Gm-Message-State: AOAM5318yxClsHhDfUCLd/YhbXfKnqVp/9l/xMnxhnEmiAF8GcJmIoqL
        Msm8pTX3YG6BP2yobFihMT8Nww==
X-Google-Smtp-Source: ABdhPJzplrucW/7UezO/Un55ans41N13Nr5a+oBs0xCS/lvmLB3S9aGEDvHKbAi1A5AC/7B0uXAkow==
X-Received: by 2002:a17:902:b590:b0:153:a243:3331 with SMTP id a16-20020a170902b59000b00153a2433331mr16410436pls.129.1647915191809;
        Mon, 21 Mar 2022 19:13:11 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm11321713pgd.27.2022.03.21.19.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:13:11 -0700 (PDT)
Message-ID: <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
Date:   Mon, 21 Mar 2022 20:13:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
 <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
In-Reply-To: <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/8/22 5:55 PM, Jens Axboe wrote:
> On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
>> This field is entirely unused now except for a tracepoint in f2fs, so
>> remove it.
>>
>>
> 
> Applied, thanks!
> 
> [1/2] fs: remove kiocb.ki_hint
>       commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
> [2/2] fs: remove fs.f_write_hint
>       commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf

Upon thinking about the EINVAL solution a bit more, I do have a one
worry - if you're currently using write_hints in your application,
nobody should expect upgrading the kernel to break it. It's a fine
solution for anything else, but that particular point does annoy me.

So perhaps it is better after all to simply pretend we set the
hint just fine? That should always be safe.

What do you think?

-- 
Jens Axboe

