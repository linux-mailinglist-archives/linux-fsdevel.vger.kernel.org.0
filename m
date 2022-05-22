Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDEE53031F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiEVMjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiEVMjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:39:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB42ED42
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:39:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u15so11410699pfi.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9ApF5MtOGo9t55VvLjWDSe34SdPV0T1w/8qr7Iyth8U=;
        b=S9Hs/AdAiM90nzYYWMdF9GtfvbEppC60+fg+VnViztvyepUV2YngakPjDsUZ0PRwkk
         6Tyi9ZG2oyrsJcdiEDboo2W/hsCYaMzLuOc0aUBmCxoK4qZ5EMtjMCb8sbArAfqKqeGW
         VAG9xwq8wpntc6SNGQQNVBHwbeMDnklqBIDv23BS+oE1ZZ0pzbnbyVrqwXxe5rsdzORr
         4a68lB0KYOfTng538v4ORbk66ng+ClXZKwCDaGhbxRZhYjltKLB+tsFLmLFJvcnLl00V
         F0t/LRQxemWg3anl6d5oMwU7hv+DYfZSS9/IOQOS4S3kiY01pkr9ME1r37WCAe/qpluL
         wKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ApF5MtOGo9t55VvLjWDSe34SdPV0T1w/8qr7Iyth8U=;
        b=5KCfrG7GRDA3nfQBXJ/oJJiR8+oulCGx5Pmhrd1csvhUsjzYdvDyPqA9DoRbUpBpsC
         1AbZvht6YfV/roCwfO728sWWwZ2AQqxnPjt0GgIIZDx4daZ02TE2kMqsFhhNBWfsvAAP
         yhmXTEYJPlWy1nKHWpHq7s8zyrAVFPmHrEZSId8W21uP+6lrBSKdmXS0QCtrSejpWSSE
         nTUJiOvc5uhuxmk3YALKv9r9+bBOVrm41/nHTBykrElvP2HqXKOGHCKpjZwHiN+ZAEPg
         UFgmfN+Cgj23+598lI/Nl3OuGF969hAq8zLt1UlgM6DJ1MMT7cVELukVeDt9Q2Hshr9W
         QEUA==
X-Gm-Message-State: AOAM532iQ1l5nsWjyv3esQLDiGD6U3geEr5sHg6CjNsnGypu/lOeGWj1
        ag1JQVoYESGGsdVfQXQ9lUAH3g0075dpKg==
X-Google-Smtp-Source: ABdhPJwWdN5m2nu1lbWX6fJo5vjFyOzqqDBi/PqUdR+cotg3REGOvbCfU3BkqyWS6w+q4QuyBNvG3g==
X-Received: by 2002:a62:a516:0:b0:505:722e:15d5 with SMTP id v22-20020a62a516000000b00505722e15d5mr19127533pfm.52.1653223181207;
        Sun, 22 May 2022 05:39:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78710000000b0050dc76281ebsm5078392pfo.197.2022.05.22.05.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:39:40 -0700 (PDT)
Message-ID: <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
Date:   Sun, 22 May 2022 06:39:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <20210621142235.GA2391@lst.de>
 <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk> <20210621143501.GA3789@lst.de>
 <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk>
 <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk>
 <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
 <20220522074508.GB15562@lst.de> <YooPLyv578I029ij@casper.infradead.org>
 <YooSEKClbDemxZVy@zeniv-ca.linux.org.uk>
 <Yoobb6GZPbNe7s0/@casper.infradead.org> <20220522114540.GA20469@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220522114540.GA20469@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 5:45 AM, Christoph Hellwig wrote:
> On Sun, May 22, 2022 at 12:15:59PM +0100, Matthew Wilcox wrote:
>>> 	Direct kernel pointer, surely?  And from a quick look,
>>> iov_iter_is_kaddr() checks for the wrong value...
>>
>> Indeed.  I didn't test it; it was a quick patch to see if the idea was
>> worth pursuing.  Neither you nor Christoph thought so at the time, so
>> I dropped it.  if there are performance improvements to be had from
>> doing something like that, it's a more compelling idea than just "Hey,
>> this removes a few lines of code and a bit of stack space from every
>> caller".
> 
> Oh, right I actually misremembered what the series did.  But something
> similar except for user pointers might help with the performance issues
> that Jens sees, and if it does it might be worth it to avoid having
> both the legacy read/write path and the iter path in various drivers.

Right, ITER_UADDR or something would useful. I'll try and test that,
should be easy to wire up.

Agree with Al that it's orthogonal to the miserable kiocb init code,
would be nice to get that sorted out too. Al's patch cut 1/3 of the code
out of those paths for me.

-- 
Jens Axboe

