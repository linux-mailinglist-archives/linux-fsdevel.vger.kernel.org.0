Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA846CAC8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC0SBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC0SBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:01:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA170EC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:01:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id bl9so4237196iob.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679940070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwakD5470vLW4EispVruOmxOgUCeuIwZc3ZLRQrVLEs=;
        b=VeydmAlpXVXIRJlB2WXoUUOln+y4yGM20Lb3oLSkeYTttBfke6u6SfydU0k9olOyeT
         24EcyIMQ2e22sHhI+mtdwogDL6QP0GAfq5j7LzlRTkEUlTYjAE4jadbBvhJ1DzOpn+3S
         MXnW7i9hEOMWxqemrH+zFMYb3HpptjQpH8Ysj/HOC/TK+pAvSqU6c3BY58/wZeqdzfHH
         OEY74OqNcSZ6beU/qWFLYgeDT5HlCW1sGfmpJh0QSSpHRVSHz2Lczn5g0jYK3I1SuH5e
         F0J08STDDjEjSQzSO4QCpQUTP1QHlptX8R17XcBjrCDYc6il/yR4AdVAluzqdUPX5qtX
         +dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwakD5470vLW4EispVruOmxOgUCeuIwZc3ZLRQrVLEs=;
        b=gDeSTi1CLGjvsx96+egAUkcv/WwPqkq0pvrrwnP/sJFJgqYH0h69zq10fQ/xsjR3Ba
         XvSs4jDd794x4zOnme9FjebSbcdqofQwrRs++IDeugkwc0J/aSVEFA5bm6aVjHdYTzHx
         Xxrpts6jKyVcz49JS/SwARuh0kFfY62Jr+8htkm6NK9uKVDgBOX4vCK/gHrV1yXJmA2S
         7HKOvzbY1nJRtx6dyZQRdblvpcLVx9otRS6KwU5w4VM6RYO8FJIzQG64x8OZCVo26WHv
         iuxaZTuTQl0I/A+zD5zmGSKANUi/vnrbb/awaQ6GE194CFmIkgy7Wx/0RKcsy4JXedm7
         nUbw==
X-Gm-Message-State: AO0yUKUhCID1bV/o1RRkOR9445x0LsCnPOBiQcsXkeytPqMAabsS0ReG
        X7k3amQnbKlMld6Ty+yRCLXbuA==
X-Google-Smtp-Source: AK7set+ZZ4r2f54yhpGXpZYCFf24MAg3VdVTU0q/ZaZD0vol0yRa/35ZUqWm7r/uzIvZxg4bB29vJQ==
X-Received: by 2002:a05:6602:395:b0:758:5653:353a with SMTP id f21-20020a056602039500b007585653353amr7533238iov.0.1679940070116;
        Mon, 27 Mar 2023 11:01:10 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t4-20020a025404000000b004061dfd9e23sm9426828jaa.19.2023.03.27.11.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:01:09 -0700 (PDT)
Message-ID: <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
Date:   Mon, 27 Mar 2023 12:01:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230324204443.45950-1-axboe@kernel.dk>
 <20230325044654.GC3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230325044654.GC3390869@ZenIV>
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

On 3/24/23 10:46 PM, Al Viro wrote:
> On Fri, Mar 24, 2023 at 02:44:41PM -0600, Jens Axboe wrote:
>> Hi,
>>
>> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
>> spots, as the latter is cheaper to iterate and hence saves some cycles.
>> I recently experimented [1] with io_uring converting single segment READV
>> and WRITEV into non-vectored variants, as we can save some cycles through
>> that as well.
>>
>> But there's really no reason why we can't just do this further down,
>> enabling it for everyone. It's quite common to use vectored reads or
>> writes even with a single segment, unfortunately, even for cases where
>> there's no specific reason to do so. From a bit of non-scientific
>> testing on a vm on my laptop, I see about 60% of the import_iovec()
>> calls being for a single segment.
>>
>> I initially was worried that we'd have callers assuming an ITER_IOVEC
>> iter after a call import_iovec() or import_single_range(), but an audit
>> of the kernel code actually looks sane in that regard. Of the ones that
>> do call it, I ran the ltp test cases and they all still pass.
> 
> Which tree was that audit on?  Mainline?  Some branch in block.git?

It was just master in -git. But looks like I did miss two spots, I've
updated the series here and will send out a v2:

https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf

-- 
Jens Axboe


