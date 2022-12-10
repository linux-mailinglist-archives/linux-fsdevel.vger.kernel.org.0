Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35D649046
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 19:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLJS4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 13:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLJS4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:56:14 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A7140E4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:56:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k7so8134045pll.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BAfj1TUWcLU/4xi1NPgM5DxMY1WtLCmBV7r8HGWOig=;
        b=V1PfQkIgRuQmvy52c2VEJIERS7c0lpvgINy11k/zAAXxfHSdZn5t477BC1OlPdJ6WI
         +nb0BN9iRJgfksoL/+IFfL14QqJkCPVq0lK3EblpZ4BJo4igISFL+MWOgbvU3LnLt9qK
         R81Z8kiOzf7MlyNosacufHlTPa3faGJnmt3SRS6CncIFp16XPVmY8rR3iu8teTe1E7Tp
         wtIpZliYQvEPDmyke1hsGvEA3/vYFa0W1dn18GDimRRLNkoB0pqkfWUCJUpRtVLrbWFc
         O/HLU/iy0FHWaSGxQEGgzB1CZ4UcoQv7wGhyWv0gLZz6koGUucBCVoHtTIOuHUxsAAsT
         Np5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BAfj1TUWcLU/4xi1NPgM5DxMY1WtLCmBV7r8HGWOig=;
        b=EecIG5Bh+hVMklLbA8ETwLMIG/e5m9lO4mXeEb8ddL3IgE2wKxBDpyezc9zLpcFZrt
         NLYb+rLDIwNAILFocB9aM3dvmD0buek8ghvSGPc3Eg6QFKNCtaF4SkPSrovLg9ydxTl1
         9GkH9V/qTJq2lV3F0j3PMuLZbVo1UI8XrmM3Zg/Xh0nXqjzCyEsE7sRuNWfn8kft+veQ
         jsad7NthQru95T6Hdy2pXbuNY1MQHDK/hv4QmAn5Tmlb0ahHbCfj8YwQ5ZtIQg5uXA3C
         fKYwhhkwv+vV2Ya7VOsgg/tMP0gzybB7lguRrKsoLpeBBdQUW5tjeC4Nnbs0rt67dAvA
         vWcA==
X-Gm-Message-State: ANoB5pm35aVSGOFbfl08en1EPnJP/yIkMA25NnduPmvLCEhLS1Jdvf+D
        aCksrZVeZfhxP3VQrzc2MODOUuoB0UKhj9GlyCs=
X-Google-Smtp-Source: AA0mqf7MQ4eiXna6U+eypaYqb3hRmzoEsawWB7Ge9/W6CPtRtl1Ctxu9XcsQfStv/UKk0u7RQ9HxJw==
X-Received: by 2002:a17:90a:5798:b0:213:bee0:84bc with SMTP id g24-20020a17090a579800b00213bee084bcmr2380054pji.0.1670698572246;
        Sat, 10 Dec 2022 10:56:12 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a670900b002190eabb890sm2877967pjj.25.2022.12.10.10.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:56:11 -0800 (PST)
Message-ID: <a144f353-760a-a8f3-ba7f-3255c283540b@kernel.dk>
Date:   Sat, 10 Dec 2022 11:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] Writeback fix
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
 <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
 <b2785384-dfc3-a073-523f-4cbf5610f005@kernel.dk>
 <CAHk-=whi+0Kjd+QgUQwuWZaGmmc5x1Fdxi_VsobWkJnM+o7WSA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whi+0Kjd+QgUQwuWZaGmmc5x1Fdxi_VsobWkJnM+o7WSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/22 11:14 AM, Linus Torvalds wrote:
> On Sat, Dec 10, 2022 at 10:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Just to be clear, this was deliberately held for the 6.2 merge window,
>> but I can also see that I completely missed that in the pull request.
>> Sorry about that, that should've been clear.
> 
> Oh, it looked very much like a "lastminute single fix for 6.1".

Yeah understandably, that was my fault.

> Your other pull requests are in my "for 6.2" queue.

Great, thanks.

-- 
Jens Axboe


