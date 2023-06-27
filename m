Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806773F032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 03:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjF0BOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjF0BN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:13:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBAC173B
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 18:13:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-656bc570a05so1036840b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687828436; x=1690420436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQ/IjqmtE16kQNQEnAAcOTmBTtwuTHwVotfjuZpxuOk=;
        b=Qh0TdwgR7cXBEXeK5cmdtXosn/XHZ8bChAZlYL8hsZEzYoduf1shHWb2RecxQZPqSU
         55krgRpDZFhTfysMsHQDkUAZN/Hy8ArK0LNqNRaPnPwhyEvKBgsQCMlI1t+T8e2m8Jnn
         yS5m0VEHcx726/05Gh/CaTA+PBBY5HkCFo3lP3mpj3cpYcWS7MoE14Rqx2zXa9Dgh6eP
         RzOu4++eXsf2wbFJ6ySIqQSLHaVfhmoErl9f8ohuehHLV8iLqmrpl2SGqUYAM4GqSy01
         Bcr2IiFeqqaX3NMqn0dqGEXRXDy/wy6AeSBsLKv8mbvK1Ro+WWRzA1tE1ijjAFP4KcFs
         Arww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687828436; x=1690420436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ/IjqmtE16kQNQEnAAcOTmBTtwuTHwVotfjuZpxuOk=;
        b=VRxexz5niSRo5Ox4B13nqcLOf235c7cQo4C2bMI9goJZc5O4tqKPgwOrs95jYB4QEH
         dSPjOjeBYr+kgl1RyqwlM0/6SkkIqIc3wA/Y6ENXrWEIrGsfbMHHlgFuSbulO4nsxqmF
         vJ3z7/7GoHbswkFNll1eijnITs1Y8vu89LdsxUdLhx7eL3oDGXtjY6H64O0sD/YObUv4
         UUkJ8fMTwc20ftBjFZOfSxRubxF+WOC6HEKbhJLJ27tQnPZWc2fQTuDNVgzTcKTdjsIH
         tk72acQWtp6zb+7eoSFK05AxksfJSnNM3HL8QWqRBupofiPLY3i7lTzD8lQkxUBidajt
         Lkdg==
X-Gm-Message-State: AC+VfDwGRhosjZYMzAhzqcno86iWwHueqJY1C0NK3cBuMym9Rdag8E9Q
        rjnsSBz1zQD5SXsx7tJ2DCn1dQ==
X-Google-Smtp-Source: ACHHUZ6Hji3PWg/+1y1c/8GC5/7oraS0lnPCcB+YX5+KRwILp3HpyMg3HHBinA0tMs9CT3eKf+vs5Q==
X-Received: by 2002:a05:6a21:6d9c:b0:125:6443:4eb8 with SMTP id wl28-20020a056a216d9c00b0012564434eb8mr17562093pzb.5.1687828435896;
        Mon, 26 Jun 2023 18:13:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b001a072aedec7sm4754717plg.75.2023.06.26.18.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 18:13:55 -0700 (PDT)
Message-ID: <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
Date:   Mon, 26 Jun 2023 19:13:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/26/23 6:06?PM, Kent Overstreet wrote:
> On Mon, Jun 26, 2023 at 05:11:29PM -0600, Jens Axboe wrote:
>>> (Worth noting the bug causing the most test failures by a wide margin is
>>> actually an io_uring bug that causes random umount failures in shutdown
>>> tests. Would be great to get that looked at, it doesn't just affect
>>> bcachefs).
>>
>> Maybe if you had told someone about that it could get looked at?
> 
> I'm more likely to report bugs to people who have a history of being
> responsive...

I maintain the code I put in the kernel, and generally respond to
everything, and most certainly bug reports.

>> What is the test case and what is going wrong?
> 
> Example: https://evilpiepirate.org/~testdashboard/c/82973f03c0683f7ecebe14dfaa2c3c9989dd29fc/xfstests.generic.388/log.br
> 
> I haven't personally seen it on xfs - Darrick knew something about it
> but he's on vacation. If I track down a reproducer on xfs I'll let you
> know.
>
> If you're wanting to dig into it on bcachefs, ktest is pretty easy to
> get going: https://evilpiepirate.org/git/ktest.git
> 
>   $ ~/ktest/root_image create
>   # from your kernel tree:
>   $ ~/ktest/build-test-kernel run -ILP ~/ktest/tests/bcachefs/xfstests.ktest/generic/388
> 
> I have some debug code I can give you from when I was tracing it through
> the mount path, I still have to find or recreate the part that tracked
> it down to io_uring...

Doesn't reproduce for me with XFS. The above ktest doesn't work for me
either:

~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest/generic/388
realpath: /home/axboe/git/ktest/tests/bcachefs/xfstests.ktest/generic/388: Not a directory
Error 1 at /home/axboe/git/ktest/build-test-kernel 262 from: ktest_test=$(realpath "$1"), exiting

and I suspect that should've been a space, but:

~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest generic/388
Running test xfstests.ktest on m1max at /home/axboe/git/linux-block
No tests found
TEST FAILED

If I just run generic/388 with bcachefs formatted drives, I get xfstests
complaining as it tries to mount an XFS file system...

As a side note, I do get these when compiling:

fs/bcachefs/alloc_background.c: In function ‘bch2_check_alloc_info’:
fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
 1526 | }
      | ^
fs/bcachefs/reflink.c: In function ‘bch2_remap_range’:
fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
  388 | }
      | ^


-- 
Jens Axboe

