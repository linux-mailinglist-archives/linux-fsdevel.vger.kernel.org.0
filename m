Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD273EF15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 01:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFZXLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZXLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:11:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879F1701
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 16:11:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8053aece3so2303015ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 16:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687821091; x=1690413091;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4CPuQ5HYLfaP9JIMxrmKe7n4kIln48bN6Na9rBaA1Bc=;
        b=Mf0wsMXIpm+R4t+5rDb4/Ck9+QwFYPT5/nb527wI4PfBMEcQfxvBCiige+M1YtFTRN
         J0CQ2au30YqMbKQaRVsev/noR8phdU1Lo3k0kbnQureJDjYEdS9d2eN8bmP9rUmMhGS6
         xhzJTI/UH6e6ACuOjOPe4mO6sDURwj8BiNepVRXlEZhZ30/2dEvQimSnLoFEgJ0LvqTb
         rvW8FSRDSS7ITjan3+RKrbrFgGUc3WzRXFP76knXhXas+Omx6gzDzaSLlF0KOP1Ml+G3
         B5TaEzZjqVQwLEcK8rOAV4leSVVbwWNpCohZzhYcg6fL++KtaN+0NZ8FkyJQ7dqXQafa
         OTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687821091; x=1690413091;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CPuQ5HYLfaP9JIMxrmKe7n4kIln48bN6Na9rBaA1Bc=;
        b=HgFXZeaXb75Zbmg7B4GhDc+f3KRdZdDYbTkSCTqk3IoZvwHE/YRhUT7sRsWLVW6Ree
         yHR4fmFP4g2v0IyEOyk7Gu9SFAhXNlBDCfw8ZMVXs13Aokru4sYRyHvo05ZnehnXnY1I
         4tDyg0d/anFmEKw7h8wC70NRcn/SqjIo2tkkKfAqAcrIX548mrcgF1dZPbik8NQRzl5I
         R3ErikBiTMH2tPzabNN+2O4tyNEh6VBrE9Z42Bl4fOLH7YMkobieXS3vo/ph1tJ50DW/
         crGIjcWIoi1q0/Xm73bHjqBkFwMkh9cND+kT2kkn6QfMTX9P4gwHieBCrYx9t2kBiuhV
         g7dA==
X-Gm-Message-State: AC+VfDxsrmOtyRXVyJbDVbsWN4342F9p8hXael0qjs13K7By7gGYcIRo
        HyTP96SKxx5UqghmvNsgwhomiDLlitGxzfZB3xg=
X-Google-Smtp-Source: ACHHUZ6v/dvpLfopQ3/7RYntaktPdFwjv+AD316VSdGbHxUx/tr7wrQMmGiHs7lMRnYCwERDpyVAaw==
X-Received: by 2002:a17:902:f984:b0:1b8:811:b05a with SMTP id ky4-20020a170902f98400b001b80811b05amr3995296plb.6.1687821091356;
        Mon, 26 Jun 2023 16:11:31 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b001b7f40a8959sm3338143plt.76.2023.06.26.16.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 16:11:30 -0700 (PDT)
Message-ID: <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
Date:   Mon, 26 Jun 2023 17:11:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
Content-Language: en-US
In-Reply-To: <20230626214656.hcp4puionmtoloat@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> (Worth noting the bug causing the most test failures by a wide margin is
> actually an io_uring bug that causes random umount failures in shutdown
> tests. Would be great to get that looked at, it doesn't just affect
> bcachefs).

Maybe if you had told someone about that it could get looked at?
What is the test case and what is going wrong?

>       block: Add some exports for bcachefs
>       block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
>       block: Bring back zero_fill_bio_iter
>       block: Don't block on s_umount from __invalidate_super()

OK...

-- 
Jens Axboe


