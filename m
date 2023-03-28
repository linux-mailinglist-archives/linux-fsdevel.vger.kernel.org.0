Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E026E6CC9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjC1Rwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjC1Rwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:40 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527D10252
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:52:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o14so5706480ioa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680025932; x=1682617932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+SuK11rckyfiBRH5vnqIeUeUaEVZMIZlYeEZiqyXvM=;
        b=NGsHe5ETDGFcBm3J7hGRTiNwH7zDg1+aTyuiY6WLsZjIz9uIE5hS7WD1yLwi8YQBNA
         AgP3IhsmapnuwHMaOq+JFdx43uSgSyNKVZNE4Pk6TP91R7wENAuja+ezHcfiRznqMN5n
         vaSkkIcaM0bZKn2BU/HZ5J4tkebdgFldZ4WhHrC/GzJrT3r3p/fVOIN7gHpuc7eCotX2
         eGEu1YsbKv1CwBRZ+T+zU1Q/KjCD+fMZ1mQLJCS8FfReav0OAJ1QUF+jY1lCH6IF6qbL
         UZjNXQ1U0iXZA4HIU4sTQgBEnAUxeTi8DavgdxnVPfV/6YEPvcCPm/r1f8PeJase5WtI
         pYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025932; x=1682617932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+SuK11rckyfiBRH5vnqIeUeUaEVZMIZlYeEZiqyXvM=;
        b=fZHa1o6dPFpbp2xWS7EMkgorPbDjt0ZswVpjsq3+r7ucG0T7iABerFzWTNburtPTi6
         jLkApkOCWdLbuMfnT9Rnj9u5V8p8SjDSl/nTsIWBI36CIcm5L817D+H+MM4Xbsgz4aCp
         6n61FXTBjWx6+gz228SstA1iIYMhyrWsQKjzrh3xzAQ2WhvTFIgIL+BcJlZMm/bj6eqz
         od7nbrf/+cTCHsh4i0CdkbvmPkz67E7fuCUZu0RnOuDKFgJNqxO6ziSVhIFlqMEgxoqd
         UwUoFU6AcSaCinSmgnWj7H7h3G9iK7f6tLhvqsIMlA+QcXV/gOZ9SfOJ+j4VHXDloQuQ
         PcnQ==
X-Gm-Message-State: AO0yUKWCZRDfyQTT93QziKM0T+oCybQuOqg1jPcHJ0wlvuFojSI99uvQ
        nSL+S9DzEmFSNVcjV0ESurc9Y7irVruULCQ1WnnSGg==
X-Google-Smtp-Source: AK7set+YeXfRJlqZ5rqf3dJdu+7Cm8GeFQoXX8GrXjDIN0z+B2qUpQUybZWZnYpnPa6kGfAeQZ45kg==
X-Received: by 2002:a5d:9d96:0:b0:757:f2a2:affa with SMTP id ay22-20020a5d9d96000000b00757f2a2affamr10812542iob.1.1680025931777;
        Tue, 28 Mar 2023 10:52:11 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a15-20020a02940f000000b00408df9534c9sm4235164jai.130.2023.03.28.10.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 10:52:11 -0700 (PDT)
Message-ID: <2f94dc05-6803-e65c-196d-6b23cb56bc40@kernel.dk>
Date:   Tue, 28 Mar 2023 11:52:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/8] snd: make snd_map_bufs() deal with ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-5-axboe@kernel.dk>
 <CAHk-=whiy4UmtfcpMSWSWRGvS1XGkqsPhZkLzi+Cph18FPJzbQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whiy4UmtfcpMSWSWRGvS1XGkqsPhZkLzi+Cph18FPJzbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 11:50 AM, Linus Torvalds wrote:
> On Tue, Mar 28, 2023 at 10:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> @@ -3516,23 +3516,28 @@ static void __user **snd_map_bufs(struct snd_pcm_runtime *runtime,
>>                                   struct iov_iter *iter,
>>                                   snd_pcm_uframes_t *frames, int max_segs)
>>  {
>> +       int nr_segs = iovec_nr_user_vecs(iter);
> 
> This has a WARN_ON_ONCE() for !user_backed, but then..
> 
>>         void __user **bufs;
>> +       struct iovec iov;
>>         unsigned long i;
>>
>>         if (!iter->user_backed)
>>                 return ERR_PTR(-EFAULT);
> 
> here the code tries to deal with it.
> 
> So I think the two should probably be switched around.

True, it was actually like that before I refactored it to include
that common helper. I'll swap them around, thanks.

-- 
Jens Axboe


