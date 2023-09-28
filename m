Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA97B15F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjI1IX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjI1IX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:23:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5C95
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 01:23:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52f1ece3a76so3126735a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695889404; x=1696494204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjyoWJ1tpx/uEpVSCmTksL+kF4CTyeGA4CWSET/lKz0=;
        b=HWmtgcdSxPUB9k4SIG12WzfmaNU8HpGSTDY3s+X0Q1j70bpT4Z4JxDiDkSubkPUiYJ
         oCL+NF6PG0RDW4JadTdiw6BquWCWa6zYpzbr1pW/wBEXFcJgaKGfvVKaLUleo0fou88T
         tBoj57jIvFMH+1JcRFB/1ifT0UOjxsS2qu+DI0qNJjj/06M81ydWRdb20DC9/0u0fnC7
         YlCBnE3No5SdTU8ip9F34TePtGbMLlXsqpzkB9NnPY4KDkn7YtEXmS2j396VPLSlSSWs
         KHP3BGFKHPzXf+hWoRZfl4wmuqbZt0uZxH3qVla/dKRrioQCLb/owysuUtg4kq46oe8f
         Yw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889404; x=1696494204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjyoWJ1tpx/uEpVSCmTksL+kF4CTyeGA4CWSET/lKz0=;
        b=P2ZTnCmpFkvwnr9AZ0Usuu1vKJejKtQ/WY57SZ8w1RaYp7a3MVsEITxIGvfsAjrWLd
         UO9W90QnmuazciVCa5AJJoPyAw74uIGeGqh5UACMwLoJi/K6QHr3+70bpnxR/9sp4/Pr
         rB/WFm8Ualqcv1+P8lQ16q+ci0zTF0puBmwH6oMTtl7wLx5zQoW5KcRmktSmasQqv2dQ
         ZtqFSG8Jjs1GExq7n6sYmbOpkTcUq61G99uGFlaByJ9B1JceFkZ4cSHYAEXXrZQT5B81
         QBrnRDkBTHETdpZjUngH1giLLr8XQu7bkUvBJdRISLhbZG1jl5wAK+h3cuYPF5vSYEqq
         dYEg==
X-Gm-Message-State: AOJu0YyldZddvGPVp8/KLEP6+hyAkSqh4BdvjlU+ea9DeiLehR3FkrAk
        0dKmCdWrULY1xDWjU6p2Wcnuzw==
X-Google-Smtp-Source: AGHT+IGkSxoPxgcGj0zywDnIp2o/7chIx7WOK8WG2TawfeZFzulDbE/nRCSrGAnc9oYFDg3kZAzQuA==
X-Received: by 2002:a05:6402:2808:b0:523:f69:9a0d with SMTP id h8-20020a056402280800b005230f699a0dmr583570ede.4.1695889404485;
        Thu, 28 Sep 2023 01:23:24 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id p17-20020aa7d311000000b00532bec5f768sm9345793edq.95.2023.09.28.01.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 01:23:23 -0700 (PDT)
Message-ID: <84dd8b92-0b1a-4632-8e1f-33e4724e503a@kernel.dk>
Date:   Thu, 28 Sep 2023 02:23:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] IO_URING: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Xiaobing Li <xiaobing.li@samsung.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        io-uring@vger.kernel.org, kun.dou@samsung.com,
        peiwei.li@samsung.com, joshi.k@samsung.com,
        kundan.kumar@samsung.com, wenwen.chen@samsung.com,
        ruyi.zhang@samsung.com
References: <20230928022228.15770-1-xiaobing.li@samsung.com>
 <CGME20230928023015epcas5p273b3eaebf3759790c278b03c7f0341c8@epcas5p2.samsung.com>
 <20230928022228.15770-4-xiaobing.li@samsung.com>
 <20230928080114.GC9829@noisy.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230928080114.GC9829@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/23 2:01 AM, Peter Zijlstra wrote:
> All of this is quite insane, but the above is actually broken. You're
> using wall-time to measure runtime of a preemptible thread.

Would have to agree with that... wall-time specifics aside, this whole
thing seems to attempt to solve an issue quite the wrong way around.

> Now, I see what you're trying to do, but who actually uses this data?

This is the important question - and if you need this data, then why not
just account it in sqpoll itself and have some way to export it? Let's
please not implicate the core kernel bits for that.

-- 
Jens Axboe

