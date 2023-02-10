Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C646929A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 22:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjBJVyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 16:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjBJVyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:54:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E887360A2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 13:54:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 144so4366494pfv.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676066071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8utCxvYjDZ8Ky1caNcP1wX8sj0JjcEPoVN++BwSe+Rs=;
        b=L5cDckAuUr0rOTx1u3hbvgfMJms7q96GWwMtPaZ13L2NIIekv+YVRSD2HjuqZ8SFlP
         OLwA88Sm87iDd8Z2Pebw8yJXi6pTBD7+qr8/dR2zGnjAoJky5u9013QqTBmMhCR91Mf1
         9ekskjap2zcMwq2+Q2hNW4mOVaXUPZ8fDcnjEVy8jidyyG38FkZzs+mei/ZFJEQkxrbp
         bZkgXLIEhazqQYXy/mLnHVZ5q3WXEXOFTwLJ68D5KHBPSsLt1X1qHG2G8FuWThynViQA
         rlpiufQPxTu0oIAhmEiuHE1leUZK4e1yzIjopunPitLJIaPQ5QGhAbieswzD9AGMEIw3
         k+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676066071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8utCxvYjDZ8Ky1caNcP1wX8sj0JjcEPoVN++BwSe+Rs=;
        b=BxdVx0712vTin8Ymv0NyX0gsgd+gcjukSzL115+bwmlauVdggzVvMrFLaU1sGuNKOI
         neJOUd1xy2X7CJk5/j2sQmiHqh30/r80ilclqlTmTDWjihFs57Ev7al3wyj1Sz4uraDV
         t+Si89AXU/8v1bBfXVu2YKp7ZdhC9Arzm4wabgpeg4YLZFGDoKFcxklMq6V8yKaXCfmI
         0RUtL6nfl5o+r+Q0yDg54KAiP4qBme9E19C7iMinUvbIjSL9e0Y5glQ3xiCI9el8512u
         94wzIGHtK5Uk6w3iqa5iKCpKOw/jnw5ia3i8KHLSfVoJu5U5ZWmX161FTM3Y1IpMAQxo
         O8Mg==
X-Gm-Message-State: AO0yUKXM9soABk8UqkmvNQ/syrTD42W7+ygcZGOoSo2HtiRyWNjM+8T3
        zj2pF1VWuiXCuPMFn8PjmZlxgrHSEx3A63pV
X-Google-Smtp-Source: AK7set/YvEgdkrcaYPrEosuzDs3EadB5ufHzTv33GebDcHz1BHHTW3FpGAnZ8MXMp2qZ+zL2olvXnQ==
X-Received: by 2002:a62:a10b:0:b0:587:bdcc:bf0d with SMTP id b11-20020a62a10b000000b00587bdccbf0dmr15095397pff.0.1676066071475;
        Fri, 10 Feb 2023 13:54:31 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s22-20020a62e716000000b005a817973a81sm3687647pfh.43.2023.02.10.13.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 13:54:31 -0800 (PST)
Message-ID: <95efc2bd-2f23-9325-5a38-c01cc349eb4a@kernel.dk>
Date:   Fri, 10 Feb 2023 14:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
References: <20230210153212.733006-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230210153212.733006-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/23 8:32 AM, Ming Lei wrote:
> Hello,
> 
> Add two OPs which buffer is retrieved via kernel splice for supporting
> fuse/ublk zero copy.
> 
> The 1st patch enhances direct pipe & splice for moving pages in kernel,
> so that the two added OPs won't be misused, and avoid potential security
> hole.
> 
> The 2nd patch allows splice_direct_to_actor() caller to ignore signal
> if the actor won't block and can be done in bound time.
> 
> The 3rd patch add the two OPs.
> 
> The 4th patch implements ublk's ->splice_read() for supporting
> zero copy.
> 
> ublksrv(userspace):
> 
> https://github.com/ming1/ubdsrv/commits/io_uring_splice_buf
>     
> So far, only loop/null target implements zero copy in above branch:
>     
> 	ublk add -t loop -f $file -z
> 	ublk add -t none -z
> 
> Basic FS/IO function is verified, mount/kernel building & fio
> works fine, and big chunk IO(BS: 64k/512k) performance gets improved
> obviously.

Do you have any performance numbers? Also curious on liburing regression
tests, would be nice to see as it helps with review.

Caveat - haven't looked into this in detail just yet.

-- 
Jens Axboe


