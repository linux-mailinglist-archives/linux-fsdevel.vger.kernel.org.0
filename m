Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530B5314C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiEWQDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbiEWQDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 12:03:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D54BFDA
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 09:03:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so14121343pjf.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=vSCjcvJ2ZRHtedxxM6RJiAnBTIw2Jkv1Z+FzU8zPfUI=;
        b=ZASa2PtKSJ8YfWOYobC6aheWblf+PuFO6WJepVS76NKjivHb2FIqEyHQCmWfm8PJZD
         3pWR+3hXXYyHMcfjY6ITpz3f1R27PveGOGI46Wyh6uKLeRPCUdhsOPsx1Gph+yOMYPkM
         KbgZut3YrfOcKxakvFRZ5b3fLijdMW81JvR00UP/xA7CrUy/sFwfgbn5NPszVXJpOi/q
         vrhOlarwCJ0LZuUmKVRxN7gAZ7Qba66XmBsVF3lhzi6n2YeBmntiiHKEAHrHsWfE4pPC
         flXeDasVrhJxCXeoOg+J/EQGQfnraIPnEnq150MmP//lp/Wx9Ebhv3GdWY30vsaObeoP
         nY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=vSCjcvJ2ZRHtedxxM6RJiAnBTIw2Jkv1Z+FzU8zPfUI=;
        b=1YM8MZ1PIgI+FGObE0jqxLy06Iv6rNcDqVfEmM8MNgXV75IhJmGEatl6L9Tg6u7FiC
         XtLvaDVH4kgZxhAi5B7oVJc1rHSuTl2OTyAvJUlle5HHj2/GwPU2dTAVVLTyNs+P/KDc
         s4QFofUfKWH6NhWDa76rbL3pigZRIBBEoLv2Wa7r8M6Y4vgtW5weffA+QjRbcMcEoBQ1
         sx6Me6a1yMn4Rm6UaSNGM7dhHsvh6iOqiPcjqIpPJHYADm8s38VdpqTFFXV7b5vhn0h5
         eo8GQhSLL1uM7T7tB6n3WByCEcSZYvtNZH9wEY0s93Nx2x9nwbByR2+JCFbkbtVQ2pJx
         77Tw==
X-Gm-Message-State: AOAM5316FYOubI8lPMw+C0Ko/QWA00YbTJ7O6rl6isVJrLY2ft6cgDK6
        6gHWjRXmBueB7JVDK6BTTcInzQ==
X-Google-Smtp-Source: ABdhPJwUJL/dEKkP0OQIR6hIL/lw9waPI2mynzq551a/81N5h8MQyM/nMgAyijZebY1ehg6BiMoCRg==
X-Received: by 2002:a17:90b:3142:b0:1df:77f2:e169 with SMTP id ip2-20020a17090b314200b001df77f2e169mr27101732pjb.245.1653321827990;
        Mon, 23 May 2022 09:03:47 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b0015e8d4eb2e1sm5282737plp.299.2022.05.23.09.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 09:03:46 -0700 (PDT)
Message-ID: <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
Date:   Mon, 23 May 2022 10:03:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
References: <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
 <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
In-Reply-To: <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/23/22 9:55 AM, Jens Axboe wrote:
> Was going to test on aarch64 next...

Just for completeness, before diving into that thread. On aarch64, 16k
native page size, but running in a vm with 4k page size:

clear_user()
32	~96MB/sec
64	195MB/sec
128	386MB/sec
1k	2.7GB/sec
4k	7.8GB/sec
16k	14.8GB/sec

copy_from_zero_page()
32	~96MB/sec
64	193MB/sec
128	383MB/sec
1k	2.9GB/sec
4k	9.8GB/sec
16k	21.8GB/sec

Tad slower on <= 128 bytes, 1k a bit faster, and substantially faster
above that. Eg same logic would be sane on aarch64 as it is on x86-64,
use copy_from_zero_page at > 128 bytes.

-- 
Jens Axboe

