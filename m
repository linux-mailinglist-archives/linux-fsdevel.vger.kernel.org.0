Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A55FAA6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 04:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJKCCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 22:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJKCBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:01:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411247DF60
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 19:01:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b2so11879946plc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAEc/49pN/A7I28fNr7F4lPftvaseeDWjDyBYsFrup8=;
        b=lqqwD+aH/xkj5QMB6t2Cs/AXNtlbOk6vgWkm6IneVxa/cvWBnDEJsDZEEpKKquLT34
         RfaMRX6WrtgCD79qsljDP+h/ZODNd3svnrk4AC4DBIMlB/qhMh1gr+u/NPUJnN3adleo
         uyxUYulMsityuuHqowmob/qFA1jpOLQr8bg6l9FVZyJZeAfNzdcgcsqBeHaI9YDLOCzL
         l8lFII+WWgNt4krXfS32D+M4srkHT793PWjljAmR1vXCwJ0UHmk3U3yaStuXa0DlN4Ys
         FZn3Pa2b+sJC79xn5WQ3jvkZbTYZov/NDzW1ezxlY2n6PiwRKf3s8soj+O9gKHHCWgzQ
         OMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAEc/49pN/A7I28fNr7F4lPftvaseeDWjDyBYsFrup8=;
        b=SylpRYgo+w27RuW/cIS5L4y0EYvu5/ZUOMBnS5jJstoPqZVRscA7QekDV0TYB2uVIJ
         lfT1nixB24r8ZB/DYYHl3HjSPgdp1bMsYv8fEXfOrFRHBwWxyHlrXcpt5snWV6cKlfWn
         Tfd1MKL50op/3/noMkbWuF/Lr+WrWyPFT/CUb54RgYk+uWPGi1s8vGfn/NQ6EftiFh9i
         tG6bPM4hrdHA9SWElhqdmao1po5QmAGVAPmoHhnhU4+85gq/Or9XrNrmsUEnZFWw/BaN
         dSorRWpqL7PqNe6c46NTSO2B6fIzuEaI/KazpzHVEK+4rORVJ8OmrGv7JWSQ37UXHAWD
         pQug==
X-Gm-Message-State: ACrzQf2p6ZCFcSODqo5GGotRt9DR1DqmzxGpNxUP/rkwFawoU+B0ndCo
        UMrErAeKIju2VR3FXeKCB8wlzQ==
X-Google-Smtp-Source: AMsMyM54LPT4urYyCBZEkgnyJFbPNheS+qRspWLKKQaKLF6ydB8SVLtTZZvIQTLQH9uYv7AjVB7GOA==
X-Received: by 2002:a17:90a:5308:b0:20b:1eae:c94e with SMTP id x8-20020a17090a530800b0020b1eaec94emr25158007pjh.88.1665453713546;
        Mon, 10 Oct 2022 19:01:53 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d3-20020a63fd03000000b00460d89df1f1sm3996272pgh.57.2022.10.10.19.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 19:01:52 -0700 (PDT)
Message-ID: <697611c3-04b0-e8ea-d43d-d05b7c334814@kernel.dk>
Date:   Mon, 10 Oct 2022 20:01:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [regression, v6.0-rc0, io-uring?] filesystem freeze hangs on
 sb_wait_write()
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Dave Chinner <david@fromorbit.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <20221010050319.GC2703033@dread.disaster.area>
 <20221011004025.GE2703033@dread.disaster.area>
 <8e45c8ee-fe38-75a9-04f4-cfa2d54baf88@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8e45c8ee-fe38-75a9-04f4-cfa2d54baf88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/10/22 7:10 PM, Pavel Begunkov wrote:
> On 10/11/22 01:40, Dave Chinner wrote:
> [...]
>> I note that there are changes to the the io_uring IO path and write
>> IO end accounting in the io_uring stack that was merged, and there
>> was no doubt about the success/failure of the reproducer at each
>> step. Hence I think the bisect is good, and the problem is someone
>> in the io-uring changes.
>>
>> Jens, over to you.
>>
>> The reproducer - generic/068 - is 100% reliable here, io_uring is
>> being exercised by fsstress in the background whilst the filesystem
>> is being frozen and thawed repeatedly. Some path in the io-uring
>> code has an unbalanced sb_start_write()/sb_end_write() pair by the
>> look of it....
> 
> A quick guess, it's probably
> 
> b000145e99078 ("io_uring/rw: defer fsnotify calls to task context")
> 
> From a quick look, it removes  kiocb_end_write() -> sb_end_write()
> from kiocb_done(), which is a kind of buffered rw completion path.

Yeah, I'll take a look.

Didn't get the original email, only Pavel's reply?

-- 
Jens Axboe


