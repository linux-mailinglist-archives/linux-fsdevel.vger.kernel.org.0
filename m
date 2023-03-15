Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87F6BB72E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjCOPMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjCOPML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:12:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7C12F3F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 08:12:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o14so2403860ioa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678893129; x=1681485129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaHoE3Jwmi0hzc/yQqb5w2JDDslGKL6hwG1uoV6O69s=;
        b=wh/sVrgJRyz4ODCunBgSLWBLcJYQ/vHLS2RF5/KuPMD5EVxfc6297O7jkYtGYH3ERe
         qQv5iflpJtrRF2GOp8XQp+bEWSPcqHPYLWehN2WNzOUxDtPw/wdHaXaHnH9bJudqFNpf
         30hJiz6NRjKySKPxDs7O6QSMl51n2nc+fN7gSx4Y70gank2rBc+l2AW4+yhpD587qYyS
         9Kdvb4WFtCcRGLg1OXzrr+Q8LFqZ3VPKDfQyTEoQdf/yN1DYPZ/ipqYXxrNJR3B6zVVn
         CwhW3QqqPn/ap+V9BbsWr/DSLnZ1gC1nzxTnwQCS6bKW6Xk8qv4iwtm1X3IjbUDw2ZZ4
         m7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893129; x=1681485129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaHoE3Jwmi0hzc/yQqb5w2JDDslGKL6hwG1uoV6O69s=;
        b=QHkMOTLKQMHUdxwm6/f/IAXObKgL/Nm8d/3Fu0A4j1O1S+Jax2iz5rCH6lA2U7g2cE
         ljrb3c0opPA+CikBLL1C74r/aGlspPUM/8iKQSj0HI1ZZ8KnOipD+8bsl7jgnJNQL5yi
         gcaxAQdGYJxmuUX3VwEXLCE2/c5KkJOaziamEYd17drjWt1KBtbMf0wUpuq4+TRLXcYm
         iNLR7Em8dXSYclK4MC4LFKh4HrSM+Hn0W78IvOYowua2ZHmaHh69olk2nJhLmhPWMJdh
         uMbdhyvF7U/uTTveY80rrGQ2XJsTJzx1Z3EapsI7Q4h2dOnKQq/JYnf3FvzCW77GDxj6
         oebg==
X-Gm-Message-State: AO0yUKW92dS+IEQxCRoaegklvfnFr5c6mnzLS2IAhkIOoV8yNGYdGT55
        nhFP658iuZMiXF2dEZ427q5k0jRos3rpaPne56CL8Q==
X-Google-Smtp-Source: AK7set+iN9r9+jFHE+63KZhffSbZG9CcTKh3r3MZA9kT3So0Tu9nDpgyc9Du/NX3TmYcuFQu265fzQ==
X-Received: by 2002:a6b:14d2:0:b0:72c:f57a:a37b with SMTP id 201-20020a6b14d2000000b0072cf57aa37bmr1794168iou.2.1678893129419;
        Wed, 15 Mar 2023 08:12:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k8-20020a6b4008000000b0074ca38eb11fsm1753647ioa.8.2023.03.15.08.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:12:08 -0700 (PDT)
Message-ID: <f93b4292-9507-5a11-be47-0e0e99a5fe27@kernel.dk>
Date:   Wed, 15 Mar 2023 09:12:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] pipe: enable handling of IOCB_NOWAIT
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
References: <20230314154203.181070-1-axboe@kernel.dk>
 <20230314154203.181070-3-axboe@kernel.dk>
 <20230315082321.47mw5essznhejv7z@wittgenstein>
 <38781e4c-29b7-2fbc-44a9-f365189f5381@kernel.dk>
 <20230315150237.iwhoj7a3nb4vwazd@wittgenstein>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230315150237.iwhoj7a3nb4vwazd@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/23 9:02 AM, Christian Brauner wrote:
> On Wed, Mar 15, 2023 at 08:16:19AM -0600, Jens Axboe wrote:
>> On 3/15/23 2:23 AM, Christian Brauner wrote:
>>> On Tue, Mar 14, 2023 at 09:42:02AM -0600, Jens Axboe wrote:
>>>> In preparation for enabling FMODE_NOWAIT for pipes, ensure that the read
>>>> and write path handle it correctly. This includes the pipe locking,
>>>> page allocation for writes, and confirming pipe buffers.
>>>>
>>>> Acked-by: Dave Chinner <dchinner@redhat.com>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>
>>> Looks good,
>>> Reviewed-by: Christian Brauner <brauner@kernel.org>
>>
>> Thanks for the review, I'll add that. Are you OK with me carrying
>> these patches, or do you want to stage them for 6.4?
> 
> I'n not fuzzed. Since it's fs only I would lean towards carrying it. I
> can pick it up now and see if Al has any strong opinions on this one.

Either way is fine with me - let me know if you pick it up, and
I can drop it from my tree.

-- 
Jens Axboe


