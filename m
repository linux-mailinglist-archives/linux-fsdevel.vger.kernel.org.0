Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C836B9292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 13:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCNMFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjCNMFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:05:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E519FBCE
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 05:04:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bj12so488639pfb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678795407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K40F4TjvJGHxKPB21JsMu7hGeZYzNOvc1IUh37/5wq8=;
        b=U9xxjuDlcKOtKaSV4pbRn7UTM8s6IBziOZ4Ie6zrx01/eN06Y6oAvjL6cGwGym8OPr
         r7KHeTKdhYbr0bVlkq1ke5mdR5w19RmLfF0juZUFH8IcTaYFkQCe28LzZVPmX+6OQUfk
         sS3kJ5s3HLetqXFNQSmJ5SX48cN9dhIZplLrqfVr/6X1W+SjqdozWZyrCFTDJlCTgSUc
         IInVOTAVcv9MPEQYepDNAILW46LQD7rayx4UrjD8WCdDbpNf/giz/muYugthavngr7u5
         Y2FLzqbxSKzmSI5M4bH4TdZSlrq/0jxx7vZWGZRf3qmdboFzkDMe//LbQmyNra39ulkQ
         CU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678795407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K40F4TjvJGHxKPB21JsMu7hGeZYzNOvc1IUh37/5wq8=;
        b=QrXkqGKU8SvOJ5jZyZWt7A462VWHPAXovyZ5YfFjbPzglcXqGmr09+PQTI06u7fYv9
         KrVrsdBsIXsnrLxJgJRsr5i24CeB/RXFz0foQCQAMX0CqH+ZiAz4YAc2lu7v7yECBDsP
         3O135ZSxeufkdrFNOF0IrUeuxAfy7f+D/DNrWu1NJprqduLFsJr3P88rOTJ1lSgXgA4Q
         020t5ckH26u0MtEJWlvTaavdDZJjR3AUxqghEVkXWoXnrFBZD2skWPS2EKORTM+0SJQX
         mXlVM/JHs6cXPJcjpBNezftc3t28ZWbYp8rFdUdVnERh8HlyrijSDq30FgEkEDxKSf7g
         KtIQ==
X-Gm-Message-State: AO0yUKUaBtAGrQDFVP7rcshY4hCAtwwsn0f1wfP0WyDkkYPNFBdxIlwu
        229rKqqtQTj6nXZ0wE/2VT7rHxLPM05BMIr3ulkK6Q==
X-Google-Smtp-Source: AK7set9yqbEOlYOnt0yiH9Y5YrBfM/otgedDGLnL9/eLM8JHF5Z2G7s694xdJQaD/RX7tDTGBSJpQg==
X-Received: by 2002:a05:6a00:418f:b0:5e2:3086:f977 with SMTP id ca15-20020a056a00418f00b005e23086f977mr14960911pfb.2.1678795407433;
        Tue, 14 Mar 2023 05:03:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a19-20020a62e213000000b005a8a9950363sm1464261pfi.105.2023.03.14.05.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:03:26 -0700 (PDT)
Message-ID: <609a0997-5c1d-9322-f20e-1d514b54761b@kernel.dk>
Date:   Tue, 14 Mar 2023 06:03:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] pipe: enable handling of IOCB_NOWAIT
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230308031033.155717-1-axboe@kernel.dk>
 <20230308031033.155717-3-axboe@kernel.dk>
 <20230314092605.odhpxvlalqgb27gv@wittgenstein>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230314092605.odhpxvlalqgb27gv@wittgenstein>
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

On 3/14/23 3:26?AM, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 08:10:32PM -0700, Jens Axboe wrote:
>> @@ -493,9 +507,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>>  			int copied;
>>  
>>  			if (!page) {
>> -				page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>> +				gfp_t gfp = __GFP_HIGHMEM | __GFP_ACCOUNT;
>> +
>> +				if (!nonblock)
>> +					gfp |= GFP_USER;
> 
> Just for my education: Does this encode the assumpation that the
> non-blocking code can only be reached from io_uring and thus GFP_USER
> can be dropped for that case? IOW, if there's other code that could in
> the future reach the non blocking condition would this still be correct?

You can already reach that if you do preadv2(..., RWF_NOWAIT). There
should be no assumptions here on the user of it, semantics should be the
same. The gfp mask is just split so we avoid __GFP_WAIT for the
nonblocking case.

> 
>> +				page = alloc_page(gfp);
>>  				if (unlikely(!page)) {
>> -					ret = ret ? : -ENOMEM;
>> +					ret = ret ? : nonblock ? -EAGAIN : -ENOMEM;
> 
> Hm, could we try and avoid the nested "?:?:" please. Imho, that's easy
> to misparse. Idk, doesn't need to be exactly that code but sm like:
> 
>    				if (!nonblock) {
>    					gfp |= GFP_USER;
> 					ret = -EAGAIN;
> 				} else {
> 					ret = -ENOMEM;
> 				}
> 
>    				page = alloc_page(gfp);
>    				if (unlikely(!page))
> 					break;
> 				else
> 					ret = 0;
>    				pipe->tmp_page = page;
> 
> or sm else.

Yeah this is much better, I think I was a bit too lazy here, not really
a fan of ternaries myself... I'll fix that up. Thanks!

-- 
Jens Axboe

