Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB6648FC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 17:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLJQXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 11:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLJQXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:23:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95BF30
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 08:23:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o12so7816360pjo.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmZQ+2OuVpNbAMZAF8HQ9Wo8B4LQhqBG+y0v6wlrdS8=;
        b=28Cbvy1KKL/NOAZpDxDz6tBVo/uyT8JBmNTrlPqUi6HYBnLpB0ZHRnYK3Y4v+jm6xl
         3Uq9i1Hc2NFSqyc62pn70h/UABjcrRXuc0jZv0RyvsVb39GLhTH2TvBmtdxx9Io5awXP
         84AqhFBhdx7ZEg+3n05nfTwZ1OT7khFvdlZTw0ngdj+31r7BJwkJgHB84aOUbUZzyqOX
         FQ7xl7f4OWJ8VNBtNJxlsMALm9IL46hrGHd/rVyXz3CTDBa21GuBgEkbsKiX6VBwyk0T
         C416iXn+XLfPcLQhxAG+NI3C/68F4OgopJR5avAfh23aafiAjZLh4/cINjZC0wrw2GfR
         Bn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmZQ+2OuVpNbAMZAF8HQ9Wo8B4LQhqBG+y0v6wlrdS8=;
        b=dVx4XSWIkm4Hg5IJ/KrdSjD/vki/M4qGji5Ztw8EpsHOrHWDPGhOaQ2baRvTRUTun9
         2lYQFRXUaJpi9GgbdynJWzERY+PxT10otNq1aiUvBq/3FrqeR9hVdVLqYl4KuCd326hI
         nRZVEmt+QEEXZgradqC8s5fZhnHCCukQ7yKaNZW6WKvCcxrDYw8XKRgWWLccFZ96C3oX
         a5eMMWe+pIZp9MV0OB5SMd80NkzhtxIyG0wFhiokZj6VJBUXSeJ47bN12+jRbkpZKUmM
         mL4maRgJxemAK9W9K/RYaj5L34vn+xwrNoJfIMHuFhJDvOvzh0qSngN2U3VWJ16gvT2T
         h4/Q==
X-Gm-Message-State: ANoB5pljgNZlnFozXliuTzTEkoKZ0KMrPCqceg5t1FAYS/c/2Yd93V7n
        Icmd3ENUCjRSk9GYyi7WTlsJe2oZ+gBewOVc8aw=
X-Google-Smtp-Source: AA0mqf4JUyJ2DCv8l1wDNr7dUqqBq84xsojWN7pcWoYcEohvfqUnJb+4SXpAihgF/Yj1f/BSiGgzOA==
X-Received: by 2002:a17:90a:6304:b0:219:ccc2:c0a5 with SMTP id e4-20020a17090a630400b00219ccc2c0a5mr2149757pjj.0.1670689409951;
        Sat, 10 Dec 2022 08:23:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090acc0700b00219eefe47c7sm2701889pju.47.2022.12.10.08.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 08:23:29 -0800 (PST)
Message-ID: <68cf6d34-037b-bf66-7c28-5bf6a65c494f@kernel.dk>
Date:   Sat, 10 Dec 2022 09:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] Add support for epoll min wait time
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <b0901cba-3cb8-a309-701e-7b8cb13f0e8a@kernel.dk>
 <20221210155811.GA22540@1wt.eu>
 <e55d191b-d838-88a8-9cdb-e9b2e9ef4005@kernel.dk>
 <20221210161714.GA22696@1wt.eu>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221210161714.GA22696@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> This last patch fixes a bug introduced by the 5th one. Why not squash it
>>> instead of purposely introducing a bug then its fix ? Or maybe it was
>>> just overlooked when you sent the PR ?
>>
>> I didn't want to rebase it, so I just put the fix at the end. Not that
>> important imho, only issue there was an ltp case getting a wrong error
>> value. Hence didn't deem it important enough to warrant a rebase.
> 
> OK. I tend to prefer making sure that a bisect session can never end up
> in the middle of a patch set for a reason other than a yet-undiscovered
> bug, that's why I was asking.

If the bug in question is a complete malfunction, or a crash for
example, then I would certainly have squashed and rebased. But since
this one is really minor - checking for the return value in an error
condition, I didn't see it as important enough to do that. It's not
something you'd run into at runtime, except if you were running LTP...

-- 
Jens Axboe


