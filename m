Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559646CF3C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjC2T4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjC2T4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:56:02 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6479CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:55:57 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s1so8680854ild.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680119757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wg3YbcX6eqfscs3MgrIjDmGZert1ueovnXqRGD0eH4=;
        b=7jDv4qJn6lqY+MBvZA0T847PxhJwJpCp099Sr8ASWgNh6mItBs+fanGYDzcsfbwMey
         ESZwAM+kmDFKojOg3bA16f/yNlPKezFA+Rjabl4tSjuHWVZKT0ZKZ4aKx/GEL4/he/8+
         mC7E6ImvldFHwCRrmMQDOMjxnCfAKEimPpJ6btH/cyPK9BGua7ImJ0TaWnt8tgsyFJUI
         HuDm4L98jJxkyWoiXDyMns+HpBFFhGqpWwrvEd1NxZiDUY5uVRKnV7PQF6bgXcCo8wEH
         cGKh8cH6+orNTGh4dnEck3m2IgvKQuXBggsHg1WVItz8FGP7ocBtqmAGrlZ2iH2b+kb3
         rXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wg3YbcX6eqfscs3MgrIjDmGZert1ueovnXqRGD0eH4=;
        b=lzzMMXEGdvz4PtiF9IqtX9x6dXG7yTarNQmsYF7KSnpPLGFzl29nVZ7x2uIsR5CyFm
         ZUsYS5wGupuyd9yUM1/s7gZYb8sKk2k7kUkvCy3x8c/jwKGKZJJPQX5Rrd9Y6Y7vVZFw
         8pixYhQ859PyTf+hC1Nu0DAV9E+7JhSQ63YCkZft2HccQyfgRxYUflkU98Ce4zNxcFVU
         g93jGMZAFyzN2J79xZM5MheN0rHoXJXcnotTon7wtxPdPLTIMWY+YmqJYBpS6qhJmUvi
         pVRzHiERdNbb+HMtL49zOfEQWS/LcBH6EgSwC50Ko3jLQGG7e6p9cEdJy9tsMdIBDLl1
         5Sdg==
X-Gm-Message-State: AAQBX9fLxgtBkq8E/Znz1EtKcI5jHyJD9yd/VlL8oLKxFSSN9VE5+ItD
        AB+uiMVVrUWu653KPnXAldrKDA==
X-Google-Smtp-Source: AKy350Y3uuXd9pWnGZscnwUH4n7UjAlp5l1ARThZAMN12i7WAmorNLmfOfgIyer/PTjUiMTjWv8m6g==
X-Received: by 2002:a92:cda6:0:b0:31f:9b6e:2f52 with SMTP id g6-20020a92cda6000000b0031f9b6e2f52mr12896572ild.0.1680119757044;
        Wed, 29 Mar 2023 12:55:57 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y17-20020a927d11000000b00325cdcd8ac6sm4825969ilc.74.2023.03.29.12.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:55:56 -0700 (PDT)
Message-ID: <a28ab6a2-23fc-91a3-e75a-3e23097fbb58@kernel.dk>
Date:   Wed, 29 Mar 2023 13:55:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET v6 0/11] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230329184055.1307648-1-axboe@kernel.dk>
 <CAHk-=whjCu0Scau47RAGXO5FF8Xtc__Nw11Qh50gyMNWVcwh_A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whjCu0Scau47RAGXO5FF8Xtc__Nw11Qh50gyMNWVcwh_A@mail.gmail.com>
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

On 3/29/23 1:44 PM, Linus Torvalds wrote:
> On Wed, Mar 29, 2023 at 11:41 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Passes testing, and verified we do the right thing for 1 and multi
>> segments.
> 
> Apart from the pointer casting rant, this looks sane to me.
> 
> I feel like 02/11 has a few potential cleanups:
> 
>  (a) it feels like a few too many "iter.__iov" uses remaining, but
> they mostly (all?) look like assignments.
> 
> I do get the feeling that any time you assign __iov, you should also
> assign "nr_segs", and it worries me a bit that I see one without the
> other. Maybe room for another helper that enforces a "if you set the
> __iov pointer, you must be setting nr_segs too"?
> 
> And maybe I'm just being difficult.

No, I think that's valid, and the cover letter does touch upon that.
The thought of doing an iov assign helper has occurred to me as well.
I just wanted to get general feelings on the direction first, then
do a round of polish when prudent rather than prematurely.

>  (b) I see at least one "iov = iter_iov(from)" that precedes a later
> check for "iter_is_iovec()", which again means that *if* we add some
> debug sanity test to "iter_iov()", it might trigger when it shouldn't?
> 
> The one I see is in snd_pcm_writev(), but I th ink the same thing
> happens in snd_pcm_readv() but just isn't visible in the patch due to
> not having the context lines.

I think that's mostly a patch ordering issue. Should probably just
push the sound and IB patches to the front of the series.

-- 
Jens Axboe


