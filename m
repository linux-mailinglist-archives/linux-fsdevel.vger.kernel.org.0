Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3626771618
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjHFQlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjHFQlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:41:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF4BF
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Aug 2023 09:41:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51f64817809so287185a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Aug 2023 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691340073; x=1691944873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vnl3tBw3YI1niJ5TydLVcO6YxwztzFA4jbV40tVanFY=;
        b=hh1zmX7NwxNZeOk99/85QYp6A6gNzoRJA6BoOUqiuIv51NGU0009x+CnUCHjWA5oBL
         IyAZskuQyWj1tLZLI955AnGzmdfpwrGEtnC4kMtaav798hsW95tOJNi14FulJ5oOooV+
         q5Z32wFlGQkP7jqNkwE4bGQ+WqmqkttGYhlAlabG9hULO7nBNK3nB9GjdUyHBqqz/hP7
         LadFfeyKS4pDY4NYYYZGqVL9U8+Wbbx8uznKViieVNt7ayyFngQNMjurZVn5vr0L81cX
         Y1amK1L7Uap0yJV54tr9qWQ6WRH4o5uYFhWar7o145uUpWnVhzWoSSd1Sx4Ni5palK8Y
         2GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691340073; x=1691944873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vnl3tBw3YI1niJ5TydLVcO6YxwztzFA4jbV40tVanFY=;
        b=FCYDDy37M25h/Y851gFERsjbBF5QuJDi7FOmGQhrVujLvHlKNLfNeCcUc0GXjiw6vc
         psMzWCKGMmIIowygqGa/UQJAQrv9KnVyTayz4SK+wUiv3j3aBaxVPx29DZR9e7LKMuNv
         zD0baz1PEB8YYfOAUsuWGBE55HcioYwcYF63P7gkdoybfX3gJV5sN5YAEfxqEQu3EIxs
         9waksdcp1kwD0Tl9QaxD9ktlBmeYKgjVFN5o1d2aYzjRsTZG/O93HcemZdk9h7Vo9I4Q
         F5v0xS6IwHsB/GWUPljynnDN2o6iwKps9cFJ4KOFRX+FFYb01RljnKmsFLCUP65yRWMM
         71/A==
X-Gm-Message-State: ABy/qLYRblryk9ivg7VU9M7tI5ItJ37TvNgl6LszpYHnUfWmyv9nURFj
        jtvNNFnDUQHFDbQhpJKF+d6AXA==
X-Google-Smtp-Source: APBJJlHaJrhRit6lB72vyAi4XrYgFZt7u5QYVx4Pdd5tsa9Hkz7FagEU0t5nMFfGozR08NMf60pZrw==
X-Received: by 2002:a17:90a:faf:b0:268:abc:83d5 with SMTP id 44-20020a17090a0faf00b002680abc83d5mr21967439pjz.4.1691340073398;
        Sun, 06 Aug 2023 09:41:13 -0700 (PDT)
Received: from [172.20.1.218] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id bf22-20020a17090b0b1600b00263987a50fcsm7198103pjb.22.2023.08.06.09.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 09:41:12 -0700 (PDT)
Message-ID: <3fab7978-3dca-a6a8-a908-e9f7d8100dda@kernel.dk>
Date:   Sun, 6 Aug 2023 10:41:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 2/2] io_uring: correct check for O_TMPFILE
Content-Language: en-US
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20230806-resolve_cached-o_tmpfile-v2-0-058bff24fb16@cyphar.com>
 <20230806-resolve_cached-o_tmpfile-v2-2-058bff24fb16@cyphar.com>
 <41b5f092-5422-e461-b9bf-3a5a04c0b9e2@kernel.dk>
 <20230806.063800-dusky.orc.woody.spectrum-98W6qtUkFLgk@cyphar.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230806.063800-dusky.orc.woody.spectrum-98W6qtUkFLgk@cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/23 12:42?AM, Aleksa Sarai wrote:
> On 2023-08-05, Jens Axboe <axboe@kernel.dk> wrote:
>> On 8/5/23 4:48?PM, Aleksa Sarai wrote:
>>> O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
>>> check for whether RESOLVE_CACHED can be used would incorrectly think
>>> that O_DIRECTORY could not be used with RESOLVE_CACHED.
>>>
>>> Cc: stable@vger.kernel.org # v5.12+
>>> Fixes: 3a81fd02045c ("io_uring: enable LOOKUP_CACHED path resolution for filename lookups")
>>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>>> ---
>>>  io_uring/openclose.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
>>> index 10ca57f5bd24..a029c230119f 100644
>>> --- a/io_uring/openclose.c
>>> +++ b/io_uring/openclose.c
>>> @@ -35,9 +35,9 @@ static bool io_openat_force_async(struct io_open *open)
>>>  {
>>>  	/*
>>>  	 * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
>>> -	 * it'll always -EAGAIN
>>> +	 * it'll always -EAGAIN.
>>
>> Please don't make this change, it just detracts from the actual change.
>> And if we are making changes in there, why not change O_TMPFILE as well
>> since this is what the change is about?
> 
> Userspace can't pass just __O_TMPFILE, so to me "__O_TMPFILE open"
> sounds strange. The intention is to detect open(O_TMPFILE), it just so
> happens that the correct check is __O_TMPFILE.

Right, but it's confusing now as the comment refers to O_TMPFILE but
__O_TMPFILE is being used. I'd include a comment in there on why it's
__O_TMPFILE and not O_TMPFILE, that's the interesting bit. As it stands,
you'd read the comment and look at the code and need to figure that on
your own. Hence it deserves a comment.

-- 
Jens Axboe

