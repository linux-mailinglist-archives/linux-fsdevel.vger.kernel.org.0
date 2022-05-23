Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B67530719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 03:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346251AbiEWBXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 21:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiEWBXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 21:23:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0DDFA5
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:23:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso16091856pjj.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ln+qOeU+jH5oc7Aye4YuD/ciN5rO9Xqhcre1LeTOHJ4=;
        b=d2EeaBqvZpJ30OrKyya8MwNnSgUTOrlOLRfx32EzvU9Cx936mnWjp5Q58V8wTER/zt
         TJ6kIfRP51bypMKWt5cDBH+59jpUn9rNkNy/ixli5X6b7SxY6+n8kHqe2HUhVcD3PFtR
         yj5vXOUexBrgjHhDo5laeQhbDNukRKG0CX7D5afiwrw/ded/S/MHj0wFxbmwWBHHvX+K
         JtIrvrPwZ1IgNa9G/Y1Drj/JRpXh0MEmP2VVX5MaDnHKzXnQ98KT/Ja5uhA9VsM3Cd2L
         IM+6htdX0zESb7gyt73R9fltESLdt0n5ei8Wmk1o7sY7V2uzAt3aJ4it+ONO3Q0CTxKK
         8tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ln+qOeU+jH5oc7Aye4YuD/ciN5rO9Xqhcre1LeTOHJ4=;
        b=cClukxea2QkhaZqS/v+QUzXwClvmhbfenU+LuHO/iLiT7L4QmZoyHQ+4DQaELFh3kX
         1OToIW2NbsakjjaRqP/yBn8Nh0TC79uDM094PF5QnXh9U/WcoIedGraAWVeKXY/ahZ+6
         KBIokQuH6P2XGYu+KHpCu12PowT4GfrAK4UlCnnhAJBHvcna0LoEQfNbOfcWvdYYDf9w
         l6ON+y4bfC1+WzQd6cemntHKC7DXQpip44GBZHVtgMCb6FevMWcUd/RAR5zJY4ehet4U
         p10QvTmkbhWFd++MaOAOWy8BUTeExagHTRa96m3Yzqjln2TbIJAzufF1XK6VgJ9KFBoV
         POUw==
X-Gm-Message-State: AOAM5320iNYk983bM670MNmwXAqd9H+62RECLI7bwReifPDeWqK6Jo5V
        GB9LTBX71EZD4yJbhX+85xZlqA==
X-Google-Smtp-Source: ABdhPJztMmxIWvieNPrbyu62yWljGILnIouy13/Z36pRWbSbO1moiaSPkHbM2tVf/zqoyp0wvZdALA==
X-Received: by 2002:a17:902:c2d8:b0:15e:fa17:56cc with SMTP id c24-20020a170902c2d800b0015efa1756ccmr20641832pla.40.1653268981203;
        Sun, 22 May 2022 18:23:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902e01100b0016198062800sm3696544plo.161.2022.05.22.18.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:23:00 -0700 (PDT)
Message-ID: <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
Date:   Sun, 22 May 2022 19:22:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
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

On 5/22/22 6:42 PM, Al Viro wrote:
> On Sun, May 22, 2022 at 02:03:35PM -0600, Jens Axboe wrote:
> 
>> Right, I'm saying it's not _immediately_ clear which cases are what when
>> reading the code.
>>
>>> up a while ago.  And no, turning that into indirect calls ended up with
>>> arseloads of overhead, more's the pity...
>>
>> It's a shame, since indirect calls make for nicer code, but it's always
>> been slower and these days even more so.
>>
>>> Anyway, at the moment I have something that builds; hadn't tried to
>>> boot it yet.
>>
>> Nice!
> 
> Boots and survives LTP and xfstests...  Current variant is in
> vfs.git#work.iov_iter (head should be at 27fa77a9829c).  I have *not*
> looked into the code generation in primitives; the likely/unlikely on
> those cascades of ifs need rethinking.

I noticed too. Haven't fiddled much in iov_iter.c, but for uio.h I had
the below. iov_iter.c is a worse "offender" though, with 53 unlikely and
22 likely annotations...

> I hadn't added ITER_KBUF (or KADDR, whatever); should be an easy
> incremental, though.
> 
> At the moment it's carved up into 6 commits:
> 	btrfs_direct_write(): cleaner way to handle generic_write_sync() suppression
> 	struct file: use anonymous union member for rcuhead and llist
> 	iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
> 	keep iocb_flags() result cached in struct file
> 	new iov_iter flavour - ITER_UBUF
> 	switch new_sync_{read,write}() to ITER_UBUF
> 
> Review and testing would be welcome, but it's obviously not this
> window fodder.

I'll take a look at it tomorrow, but did run a quick test on my vm and
it looks good. It's < 1% now for me, which is a big improvement.

-- 
Jens Axboe

