Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A286B9299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 13:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCNMFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCNMF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:05:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D132E62
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 05:04:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id p6so8774853pga.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678795474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPBOK1C4IbcoM0/ywvEaqwF73HOJT79t3iQlchMtOYs=;
        b=lOOlEyQCKMgOg6NHsAgdUmeFXQn8soeOeW7+ib8AUJby6J9R64gAm/S+N7rQh96hm2
         dK39dfxuYSCgoTbIbqJYUMh3uEmoTbQLdlhXxW7FQDPgGJckV45pJz6rNEi7094AhS22
         w+Peow/VSWOsG1SWk3xnH+B7XQKXs6fxDq0TJwaMyQtqfRc6eMeYdhD1VnMvpfSRXx9H
         l04+FGVmivZfrXBtYK2GWQuMULJG2xOjxClpPgU2RZuSKZNRgmMyohEtaq7N3awbnfjo
         UNpSQ4vH8vupGW9vI+wgKqd6VuFYsIs5+E2E/6tFnq/yWZFD5IyIxeM1Gze5do74BuKZ
         AM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678795474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPBOK1C4IbcoM0/ywvEaqwF73HOJT79t3iQlchMtOYs=;
        b=4Y85dCYL+w8wMm2sO3mjzk/lllbXp8UF/dgIA7vw8FfNKq9x/OIHnBNGzAUrJboP1c
         zFQN1Wlt9Zvio6UWvqLnuv5QLNdvssR1fkult5DzJvoDgE+BIuhzJ69BeX3piUMdqGPE
         Bt0vz6cmQR2ClE6yblwwtgbfprV8SsHDD+2Htd9HLmtyzP1q2sV/8ukjw1ioJ587qEZY
         /F9nQOsCvgz7ZDDQi33/KmHcfSEFlN1BgDBOkAay01ceoqbT26T50pyo5Ih7DbAUuqNQ
         1ub/bv45I2T07HHQ8zcz7CvcsUJvL9crh3zM61BzZvrmzFRg4r/vT5wl9Y7V0QanVcfb
         mz5g==
X-Gm-Message-State: AO0yUKXsY7YF9QvtGDT7gGeA0BG0fLMkuWniJyAyDV7rqq0ISES0EH2m
        UcSpCovnb55lYpZtAnjMGAHQgA==
X-Google-Smtp-Source: AK7set8APD7WqHOJnbrWMLgna6F234oYpxPZK26LvWhX7pAYo1Bzg/RD0SX86qcYYY8uE/w/czk9lA==
X-Received: by 2002:aa7:8591:0:b0:625:6439:657a with SMTP id w17-20020aa78591000000b006256439657amr1798035pfn.0.1678795473566;
        Tue, 14 Mar 2023 05:04:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b005a9ea5d43ddsm1482273pfn.174.2023.03.14.05.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:04:33 -0700 (PDT)
Message-ID: <7f5666c8-6950-57aa-5be4-1ecb78168130@kernel.dk>
Date:   Tue, 14 Mar 2023 06:04:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] pipe: enable handling of IOCB_NOWAIT
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230308031033.155717-1-axboe@kernel.dk>
 <20230308031033.155717-3-axboe@kernel.dk>
 <ZBBAoqTUlU7XJImT@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBBAoqTUlU7XJImT@casper.infradead.org>
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

On 3/14/23 3:38?AM, Matthew Wilcox wrote:
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
>> +				page = alloc_page(gfp);
> 
> Hmm, looks like you drop __GFP_HARDWALL in the nonblock case.  People who
> use cpusets might be annoyed by that.

Ah good catch! Yes, that's an oversight, I'll rectify that in v2.

>>  				if (unlikely(!page)) {
>> -					ret = ret ? : -ENOMEM;
>> +					ret = ret ? : nonblock ? -EAGAIN : -ENOMEM;
> 
> double ternary operator?  really?

yeah sorry... See reply to Christian, I'll make this cleaner.

-- 
Jens Axboe

