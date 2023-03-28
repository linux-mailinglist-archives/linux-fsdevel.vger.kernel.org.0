Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF26CCA9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjC1T2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1T2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:28:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506522690
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:28:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13so11896554pjh.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680031724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3C1gojdR3OEeY4M0qhx5gkvuekaf5ARjH6MbGbOV7Gg=;
        b=g2IWCd4xCL4XdYFoTaxd6lRVcRAO3wx66PbLmEqZFzxlFpIZOuF+L+DrZq5WwNWf1z
         i3xqsld+X92n4sLZPdJoWVv+Oxj9DZIbi1MLcLBsaUeK0ArvyZ7rKLb+H4HpHNIyPWDc
         vgAqVpf6K63NwyMBOcOP3U52AFwu5I7bG6eCI0PT7WecVyYCIJhHKByAZWyhLHF7gfil
         bYf2F2gIiyHdyJZHOPd8nZOEr8AfOIVsJXORA41vSWA3AL4aEy/j8uF/W63yel8NRQ3G
         BGWDuUmqUre9O2UgGJbRWPQmjPl5sdoSeYRUGfNwgJcuQny0+9ja5WzLdeUeHave5wWJ
         YspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3C1gojdR3OEeY4M0qhx5gkvuekaf5ARjH6MbGbOV7Gg=;
        b=fouDaUnh+z7pEsTU8klVIeQinm5E6tUGCyCouqqM7TB/kpSzYYgi7J7BCMv36JBHaS
         SvN8uVl6hWyOe2s7S4qUL3v4X89bDikDCvSjS/tClLtOnU5YgIGljebnJYFPZ/Q1dOPN
         Nv3T599+t/NdFDsja4MOFikKHivzfnKwROIDn3GCDIjnMt1Kd4srWFcKs7+EBlneTJzy
         gZY8iq4s9b7aHlusthPMaE06z1lFOpMCUreIHVLgbLIIINM48KXAcVM8/nAV9VT+Hzia
         uvjoZEm5NHBb3DjaEtZXPac5hg0zzOtKRhWQfqPuJN+IvhCd43dqjZS8HvJRCh75IpH/
         cSNQ==
X-Gm-Message-State: AAQBX9frD/mLTHOXs47IBN+t5M6Iw1Z4k9OS0R3HrrMTfu0q4P9PL9UG
        mFqKF8v1Zv29anvSt+oxX8dhiHZsm+y0mBRKis/NiQ==
X-Google-Smtp-Source: AKy350Zw86dEYnmRECesWe8ZSrATRz2fChzdm3w4UYVFQT6fuDeok9mx9at4KTcrv8QDWw8ebGMn6Q==
X-Received: by 2002:a17:90a:a598:b0:23f:3b90:8bd7 with SMTP id b24-20020a17090aa59800b0023f3b908bd7mr12704715pjq.1.1680031723658;
        Tue, 28 Mar 2023 12:28:43 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902724100b001a198adb190sm21542962pll.88.2023.03.28.12.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:28:43 -0700 (PDT)
Message-ID: <e9bde0d6-08dd-b097-fc53-c5555eb14986@kernel.dk>
Date:   Tue, 28 Mar 2023 13:28:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/8] snd: make snd_map_bufs() deal with ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-5-axboe@kernel.dk>
 <CAHk-=whiy4UmtfcpMSWSWRGvS1XGkqsPhZkLzi+Cph18FPJzbQ@mail.gmail.com>
 <2f94dc05-6803-e65c-196d-6b23cb56bc40@kernel.dk>
 <20230328185224.GM3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230328185224.GM3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 12:52 PM, Al Viro wrote:
> On Tue, Mar 28, 2023 at 11:52:10AM -0600, Jens Axboe wrote:
>> On 3/28/23 11:50 AM, Linus Torvalds wrote:
>>> On Tue, Mar 28, 2023 at 10:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> @@ -3516,23 +3516,28 @@ static void __user **snd_map_bufs(struct snd_pcm_runtime *runtime,
>>>>                                   struct iov_iter *iter,
>>>>                                   snd_pcm_uframes_t *frames, int max_segs)
>>>>  {
>>>> +       int nr_segs = iovec_nr_user_vecs(iter);
>>>
>>> This has a WARN_ON_ONCE() for !user_backed, but then..
>>>
>>>>         void __user **bufs;
>>>> +       struct iovec iov;
>>>>         unsigned long i;
>>>>
>>>>         if (!iter->user_backed)
>>>>                 return ERR_PTR(-EFAULT);
>>>
>>> here the code tries to deal with it.
>>>
>>> So I think the two should probably be switched around.
>>
>> True, it was actually like that before I refactored it to include
>> that common helper. I'll swap them around, thanks.
> 
> Umm...  That looks really weird - if nothing else, it seems that this
> thing quietly ignores the ->iov_len on all but the first iovec.

I agree, but this is how it currently works...

> Might make sense to ask ALSA folks what the hell is going on there;
> it's readv()/writev() on pcm device, and it looks like userland ABI
> is really perverted here... ;-/

I have sent them email separately to confirm that the only cases
that makes sense here is nr_segs >= 2. But the ABI is what it is,
however horrible it may be :/

-- 
Jens Axboe


