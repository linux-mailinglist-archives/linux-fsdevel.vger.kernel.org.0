Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA61A6CCB99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 22:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjC1Uqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 16:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC1Uqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:46:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F197F12B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:46:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id dw14so8890369pfb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680036408; x=1682628408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPYwdjkjHsYqtyNet8lMZ2rsrMZz+lYwXVu/dGr+CBU=;
        b=LZpS5MZfE1TsLikXWwwCpexGi148ctlntmNMAZBrsMtc61LhSwKgxAHFad/ylsXUd8
         gqP3hDAJGMm1pnrI5Tqb3okAb+wFxDqnsm+s684ilCNG5P6MtkONT1KkSu0L2tRWFaUh
         dPHYys+0gB/FA2TPCjo0k55gNsY3IR6HM0G/F14fQwrem5wdAQWcnvWKVEO5VjneQP28
         eLIU4uUCw4xs6TfLsCZiR9W7Xl6jxJY66OWspyUCHoW+Anbxh6IRZCD1YfiPW/zGpNUi
         ehZ6QpQt6SPONStl1imcUWxF1oNs9Bk/5xUpbm7otRUR6DzNIG7S8BxPha4YG3wJIImH
         uSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680036408; x=1682628408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPYwdjkjHsYqtyNet8lMZ2rsrMZz+lYwXVu/dGr+CBU=;
        b=4TsBLjLx4oYxXoF0Q6XCOZMDARqxT5prlsfSmBFz47mxHK726lmgegTt5feCDj3Ke/
         mMs2oBvty3bKZaoywwn9Ij3G3nNwc8Z5Nx5H81ctrlh42kBzSbME3R6kmJQTg605hEl2
         ULwVdOFvWp1ipA0f1kTeI5er7EReXYasuf7ro15lask2glA/GJBTRX9Cw/DneUlDfymY
         lr+aRpr8+SxOZWHnMjLSuZjHDu21WRxNQZYitt/LXi9eo7R8cSf8FyhN40NVzWV7Hbir
         2TTqT4xEMrceTuVed32PAPCPXOpUGctogZfyM7wFi9xJx7etcjcc2KSS16Ikf8CXgwhY
         BQFA==
X-Gm-Message-State: AAQBX9eVvFh4f8TRpjPP6/hzhlRoHOe7iigdSjmHeJTuwAoXhHsMwcnJ
        +TEPBLfLjCH2lB3MAHcdRat+HK/KXfP4AURm5iGdrQ==
X-Google-Smtp-Source: AKy350bliQ5gVYAPpkFUSzcJCJ/Bj11770N4jIai/BQfw54Om9Qk/fz4F7myoQAHVek13apXwJpGfQ==
X-Received: by 2002:a05:6a00:e13:b0:627:ff64:85cc with SMTP id bq19-20020a056a000e1300b00627ff6485ccmr14721657pfb.0.1680036408358;
        Tue, 28 Mar 2023 13:46:48 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm22229540pfo.141.2023.03.28.13.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 13:46:48 -0700 (PDT)
Message-ID: <eebfb2dc-a5d3-2075-6568-e567c6859f2a@kernel.dk>
Date:   Tue, 28 Mar 2023 14:46:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
 <20230328203803.GN3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230328203803.GN3390869@ZenIV>
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

On 3/28/23 2:38 PM, Al Viro wrote:
> On Tue, Mar 28, 2023 at 11:43:34AM -0700, Linus Torvalds wrote:
> 
>> And if you go blind from looking at that patch, I will not accept
>> responsibility.
> 
> ... and all that, er, cleverness - for the sake of a single piece of shit
> driver for piece of shit hardware *and* equally beautiful ABI.
> 
> Is it really worth bothering with?  And if anyone has doubts about the
> inturdprize kwality of the ABI in question, I suggest taking a look at
> hfi1_user_sdma_process_request() - that's where the horrors are.

It is horrible code, I only go as far as that very function before
deciding that I wasn't going to be touching it as part of this.

I do like the cleverness of the overlay, the only practical downside
I see are things that _assign_ to eg iter->iovec after setting it
up. That would lead to some, ehm, interesting side effects.

-- 
Jens Axboe


