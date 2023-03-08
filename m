Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD526B0B34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjCHOau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCHOac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:30:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC53E098
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 06:30:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so2563334pjh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678285804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yY7u9xj2PP/RlF/ssszj6uSRq/HUki12YAm8rAPgEVA=;
        b=XGPxnLkzi6lfNhxwIqeZg0us113ORKSRsubmUVLcB8i5an6xePO9CewN3Jczuj2EJN
         G7ccnPSyJbUU+NLVPTCfVYlaWvTkLPNV/kC5p+ZUAbrX6GYVbpa/g/rNX2rpCynw/9rk
         HqLIyeQhyFRDxydlS1RDiS7cjSLLgBZ2KawThD1lIanE+DkESY1vRiHhVXyHxqLf2KQj
         7dgxeYfTPiI85oUSqi6ffG0lsrJBzl9OfovrInqjRx1LCIkJBPaABjXeAHR9RoytTbV4
         4Az0cVrc5L4ziIvQuZsYWiq/O7ORPYgzr3IhGUWlh1D/idJhs+bXlq5Fyn2tLUuc29Lb
         O5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY7u9xj2PP/RlF/ssszj6uSRq/HUki12YAm8rAPgEVA=;
        b=cd4nagNa6U4Dyfzl3dt6fuAx86uagqIrrnhJrbA2m4qN9q0LHcc4pF7Znf8X35cI8p
         H/4B/mAHobi4pFDcKKJr6qQwVNANjB7qRSdq4cbDkT7IbuZKX9di7RgFKAExTR8vCQi0
         0KvhIlzWeDz0PfFep+4+zfVBbk04CsYWgtjk5hmgjUXrWR6O6QsFVYibe2Y9K9k0/PzG
         5hHWfIE2ZKXXb7B39JLgyGyw3r+Zom1tjrMqajq9PPJiArZGFvYM0bVHhp5KR3MZBrBv
         260A5T6fnl6TDsxyxt5TdAxQYqHhcGYba/5qTUOd5xRR+l4oKiArozup842lhrA5ZvPN
         e0pw==
X-Gm-Message-State: AO0yUKWZ5G2phcqRIXDxdwldJizIio1iAd/2RQRKrwJgFq6+YuC8FSjw
        BtT2ye7vldXhCjiwa1BCZX343U5FtjQd9wT9b+8=
X-Google-Smtp-Source: AK7set/UsDw/FvstUhPh/rIRtP6oPNGen0KsfV3cFq3Suu/T6JgGzrb+0yTS7CgN3pO4XYpAoPtOjQ==
X-Received: by 2002:a17:902:cecc:b0:19a:7217:32af with SMTP id d12-20020a170902cecc00b0019a721732afmr21008038plg.5.1678285804282;
        Wed, 08 Mar 2023 06:30:04 -0800 (PST)
Received: from [172.20.4.229] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id ke13-20020a170903340d00b0019cb131b8a5sm9947040plb.32.2023.03.08.06.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:30:03 -0800 (PST)
Message-ID: <1c4b5923-6560-0eea-4970-de7e77999b1e@kernel.dk>
Date:   Wed, 8 Mar 2023 07:30:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHSET for-next 0/3] Add FMODE_NOWAIT support to pipes
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230308031033.155717-1-axboe@kernel.dk>
 <30edf51c-792e-05b9-9045-2feab70ec427@kernel.dk>
 <20230308064648.GT2825702@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230308064648.GT2825702@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/23 11:46?PM, Dave Chinner wrote:
> On Tue, Mar 07, 2023 at 08:33:24PM -0700, Jens Axboe wrote:
>> On 3/7/23 8:10?PM, Jens Axboe wrote:
>>> Curious on how big of a difference this makes, I wrote a small benchmark
>>> that simply opens 128 pipes and then does 256 rounds of reading and
>>> writing to them. This was run 10 times, discarding the first run as it's
>>> always a bit slower. Before the patch:
>>>
>>> Avg:	262.52 msec
>>> Stdev:	  2.12 msec
>>> Min:	261.07 msec
>>> Max	267.91 msec
>>>
>>> and after the patch:
>>>
>>> Avg:	24.14 msec
>>> Stdev:	 9.61 msec
>>> Min:	17.84 msec
>>> Max:	43.75 msec
>>>
>>> or about a 10x improvement in performance (and efficiency).
>>
>> The above test was for a pipe being empty when the read is issued, if
>> the test is changed to have data when, then it looks even better:
>>
>> Before:
>>
>> Avg:	249.24 msec
>> Stdev:	  0.20 msec
>> Min:	248.96 msec
>> Max:	249.53 msec
>>
>> After:
>>
>> Avg:	 10.86 msec
>> Stdev:	  0.91 msec
>> Min:	 10.02 msec
>> Max:	 12.67 msec
>>
>> or about a 23x improvement.
> 
> Nice!
> 
> Code looks OK, maybe consider s/nonblock/nowait/, but I'm not a pipe
> expert so I'll leave nitty gritty details to Al, et al.

We seem to use both somewhat interchangably throughout the kernel. Don't
feel strongly about that one, so I'll let the majority speak on what
they prefer.

> Acked-by: Dave Chinner <dchinner@redhat.com>

Thanks, added.

-- 
Jens Axboe

