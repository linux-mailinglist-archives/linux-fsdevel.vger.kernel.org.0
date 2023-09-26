Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBE67AF07D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjIZQTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjIZQTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:19:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75119F
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 09:19:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405d70d19bcso6476525e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695745167; x=1696349967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgiFA3kumjbFNPriibCglEcERnVvpGRWoa7G1NB+g+E=;
        b=uaiyFzrHw1TzjOvkJbnCMpJeuSQPXC6bg8n1daBt/OYk7MS/qdO0/+ps1sNXaj4ABB
         nq71CdPjnoxM6PDOWrSBu/fTcmc5cv6dM3U3CGIpJaBHCMZZEsnTKDhWEgrduTtZjRbl
         pP4NE4ZNBrKdp9D/gktPwc6YWCc07rLZGoZqrA0FyzoKfLq3A5VaPVif5GXjYXjjleVG
         l3/y4fJQaufqUiKWW+O1utaQl6SibepqWO7k7YG454DCF1xN8f48KXbRI1OFCvdg3tJJ
         jH4vPiK38wec8kcTCgxvSdPoJTt1XLFpXokhS4u9hT4bSM5HTPK+HEV4aIsQlcWp6O3P
         1O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695745167; x=1696349967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgiFA3kumjbFNPriibCglEcERnVvpGRWoa7G1NB+g+E=;
        b=XlPNRukpd5k3ROXspHEtACaaKzc23seYa2EcUUyj39QLI26blQ9sn0gU43UPGxFAXV
         bLvqCNnuRxrkJ7UCb1PDez/KkCOgTaWUkqFisfiAgEljt5+863AEDg3H9AY6tVm3jJ06
         e0lui44twaXcBpWfpjPIn6frv7h/L8lmYhAXzVhkEkhhVxd30PWSCfvN1gMCke4eM/hk
         fsBNQmdkyRBtBK+zNba7k4QP3YaqpzqM/6Pec2dyerl6L7mUg6gDj8Plvn/2v3LY78nT
         /x0PY/oyElhYg0CJMS2AC0VRcSrRYAzFkqhXp7wvlPZy8NezuZt0m2i6+9dGun51PrcL
         r06Q==
X-Gm-Message-State: AOJu0YxP/2igUyLrOnWH4rcYla9b/8r5f3beAU91kQnWI40XDAdFXj4x
        S2BYLM6qJk5t1xS3bhCQZlF47w==
X-Google-Smtp-Source: AGHT+IGrnALS6MXOL18GdQHvBwUr+tfUwGiMIljk1J+C4gVMOnZMM+JdcQOKVH4/Th8Yb6peeqXVUw==
X-Received: by 2002:adf:f30f:0:b0:31a:ed75:75d4 with SMTP id i15-20020adff30f000000b0031aed7575d4mr8570655wro.2.1695745167033;
        Tue, 26 Sep 2023 09:19:27 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id u26-20020adfa19a000000b003232d122dbfsm4894502wru.66.2023.09.26.09.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 09:19:26 -0700 (PDT)
Message-ID: <8620dfd3-372d-4ae0-aa3f-2fe97dda1bca@kernel.dk>
Date:   Tue, 26 Sep 2023 10:19:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v13 08/10] fuse: update inode size/mtime after
 passthrough write
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230519125705.598234-1-amir73il@gmail.com>
 <20230519125705.598234-9-amir73il@gmail.com>
 <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
 <CAOQ4uxh5EFz-50vBLnfd0_+4uzg6v7Vd_6Wg4yE7uYn3+i3uoQ@mail.gmail.com>
 <1dea57e7-87d0-4ed7-9142-3a46dab73805@kernel.dk>
 <CAOQ4uxgdUjr7JLDViyf_c3is69KCuTg46WS+pkJXxgqCH5_=Bg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxgdUjr7JLDViyf_c3is69KCuTg46WS+pkJXxgqCH5_=Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/23 9:48 AM, Amir Goldstein wrote:
> On Tue, Sep 26, 2023 at 6:31?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/25/23 4:43 AM, Amir Goldstein wrote:
>>> Jens,
>>>
>>> Are there any IOCB flags that overlayfs (or backing_aio) need
>>> to set or clear, besides IOCB_DIO_CALLER_COMP, that
>>> would prevent calling completion from interrupt context?
>>
>> There are a few flags that may get set (like WAITQ or ALLOC_CACHE), but
>> I think that should all work ok as-is as the former is just state in
>> that iocb and that is persistent (and only for the read path), and
>> ALLOC_CACHE should just be propagated.
>>
>>> Or is the proper way to deal with this is to defer completion
>>> to workqueue in the common backing_aio helpers that
>>> I am re-factoring from overlayfs?
>>
>> No, deferring to a workqueue would defeat the purpose of the flag, which
>> is telling you that the caller will ensure that the end_io callback will
>> happen from task context and need not be deferred to a workqueue. I can
>> take a peek at how to wire it up properly for overlayfs, have some
>> travel coming up in a few days.
>>
> 
> No worries, this is not urgent.
> I queued a change to overlayfs to take a spin lock on completion
> for the 6.7 merge window, so if I can get a ACK/NACK until then
> It would be nice.
> 
> https://lore.kernel.org/linux-unionfs/20230912173653.3317828-2-amir73il@gmail.com/

That's not going to work for ovl_copyattr(), as ->ki_complete() may very
well be called from interrupt context in general.

>>> IIUC, that could also help overlayfs support
>>> IOCB_DIO_CALLER_COMP?
>>>
>>> Is my understanding correct?
>>
>> If you peek at fs.h and find the CALLER_COMP references, it'll tell you
>> a bit about how it works. This is new with the 6.6-rc kernel, there's a
>> series of patches from me that went in through the iomap tree that
>> hooked that up. Those commits have an explanation as well.
>>
> 
> Sorry, I think my question wasn't clear.
> I wasn't asking specifically about CALLER_COMP.
> 
> Zhang Tianci commented in review (above) that I am not allowed
> to take the inode spinlock in the ovl io completion context, because
> it may be called from interrupt.

That is correct, the inode spinlock is not IRQ safe.

> I wasn't sure if his statement was correct, so this is what I am
> asking - whether overlayfs can set any IOCB flags that will force
> the completion to be called from task context - this is kind of the
> opposite of CALLER_COMP.
> 
> Let me know if I wasn't able to explain myself.
> I am not that fluent in aio jargon.

Ah gotcha. I don't think that'd really work for your case as you don't
need to propagate it, you can just punt your completion handling to a
context that is sane for you, like a workqueue. That is provided that
you don't need any task context there, which presumably you don't since
eg copyattr is already called from IRQ context.

From that context you could then grab the inode lock.

-- 
Jens Axboe

