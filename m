Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E752B6ED789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjDXWIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDXWIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:08:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7E9ED8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:07:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b621b1dabso1556078b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682374043; x=1684966043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dRw3ZuCGQ4L6hUkul9wpsWJC+pumrtpXIkrF71AKzg=;
        b=3khdx0Pbh7dboOsA/SQbLr+pThfrOhlsUVR9wi/ngcb/YMYufGZY1hhbwTaJZPNEv3
         O1J130sRQYLR1rGY2zCd5qRceSMqVkIEoJJpxoeKvWOfYTm+sMN3RA2wWxaZ2sjntcRg
         yKhJG8brRG/tMc0/zViwM///8LGYNcjgDdFqwCYcIBsxMvqGuIZn1OvyB9Sw+SXUKaat
         /FZNXoxznzO2ful/U38P3afDzHRxMjOJKrJw39/kMhy82MAsNZmnNm/GOfbVH2KO2psN
         osWBaiHOIBa2RgMCUv6na9fnE7AR0tUHQwcCVpj2ubCZpkXWqPCgHNbw4yeNxslRf28i
         byfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374043; x=1684966043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dRw3ZuCGQ4L6hUkul9wpsWJC+pumrtpXIkrF71AKzg=;
        b=gzAtBCg1alSigKcpf/puYnVP3m7l9egD5To3hgZa/3WBcerMjtobfClO8Xu+sYFh36
         nNj1JEJMV+4u9Mwq1q01FZNBdIQ8wT+xqfAbO4t9rqSUmqrZcNVAlNwWFLc9og1dTCd5
         qtUvBy8dxFPmsUU2K3QYk8aUeXH65codCO4BP7ip4Uuj7kEn01YSeE6LAsmgeWMuu0YX
         fJW4nb+zihadikAmO+4a4w3Mmk+DXVbdZ/KiJOweU7Bp7nWZnJjO19+7jKBODErvMS+C
         o8E/Ln2qAL12Chdd9g9Y9eP2Vz36FlZ6aAOMWdfEu49tuGokp5k/9ceYUdzdtE9o5oi4
         WM0A==
X-Gm-Message-State: AAQBX9eZSKXHnB3IecFYAwqDXS7zACk3dBU61AIXdwXgZdy66jrx+gnj
        Ar0Prd6EripGNlMBfQoe7DZGvIKgPLnVPz7SZZo=
X-Google-Smtp-Source: AKy350YJ6Y1ozgYMQvy0Di+6WfdGyjFKUuR/diJvgDuLAk/2d/BmfR/WVPhTyWIZfGtTCit8MFZ8gg==
X-Received: by 2002:a05:6a21:9982:b0:e8:dcca:d9cb with SMTP id ve2-20020a056a21998200b000e8dccad9cbmr19617367pzb.5.1682374043298;
        Mon, 24 Apr 2023 15:07:23 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e13-20020a63db0d000000b0050f7208b4bcsm6924377pgg.89.2023.04.24.15.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:07:23 -0700 (PDT)
Message-ID: <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
Date:   Mon, 24 Apr 2023 16:07:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 3:58?PM, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 2:37?PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> And I completely refuse to add that trylock hack to paper that over.
>> The pipe lock is *not* meant for IO.
> 
> If you want to paper it over, do it other ways.
> 
> I'd love to just magically fix splice, but hey, that might not be possible.

Don't think it is... At least not trivially.

> But possible fixes papering this over might be to make splice "poison
> a pipe, and make io_uring falls back on io workers only on pipes that
> do splice. Make any normal pipe read/write load sane.
> 
> And no, don't worry about races. If you have the same pipe used for
> io_uring IO *and* somebody else then doing splice on it and racing,
> just take the loss and tell people that they might hit a slow case if
> they do stupid things.
> 
> Basically, the patch might look like something like
> 
>  - do_pipe() sets FMODE_NOWAIT by default when creating a pipe
> 
>  - splice then clears FMODE_NOWAIT on pipes as they are used
> 
> and now io_uring sees whether the pipe is playing nice or not.
> 
> As far as I can tell, something like that would make the
> 'pipe_buf_confirm()' part unnecessary too, since that's only relevant
> for splice.
> 
> A fancier version might be to only do that "splice then clears
> FMODE_NOWAIT" thing if the other side of the splice has not set
> FMODE_NOWAIT.
> 
> Honestly, if the problem is "pipe IO is slow", then splice should not
> be the thing you optimize for.

I think that'd be an acceptable approach, and would at least fix the
pure pipe case which I suspect is 99.9% of them, if not more. And yes,
it'd mean that we don't need to do the ->confirm() change either, as the
pipe is already tainted at that point.

I'll respin a v2, post, and send in later this merge window.

-- 
Jens Axboe

