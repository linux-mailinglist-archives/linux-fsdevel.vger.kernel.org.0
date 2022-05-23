Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC15C5311F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiEWPMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbiEWPMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:12:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23968579A0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:12:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so17787680pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tzv5Nx2NSNgWihp3lbXa6vLxHocNadu02gVBuX78XzY=;
        b=V0VQ6emXo43V/OOt7PSEa9j9OxYGrAibnq0jlIfDsuOWYQpoBvW2C0EVAwKBeAAsJL
         e9fYFFG2WMbm9Tgv6x+VfcM8SYBm7slu+yz/1fMcoZzV7Sp9nPtF0CJm8oFiVHUEvtWC
         UdFBMed6OEhSrF1NDRJyUP0O23KW6GOKk21vLjbgQpJXOfnj5gjNU1pkfK/2NXLZ2m8Z
         mVewdWsoE0VU3vtV0zyowN3HQ325jznuMXxZtPNANdfgkhjLoBgVeDeJBpMGUPEG0a+o
         owt5i+5DQgEowhCxRX6sv53Bbcde4jBGYCtH1bhshRLo1RrnyXSJwM1jYtIW336PGteO
         pc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tzv5Nx2NSNgWihp3lbXa6vLxHocNadu02gVBuX78XzY=;
        b=QbqQ5P1gQIN0KoK+pxLG03ZdRlST/LbHSgvsToM0NCX8mNnrObOyKo1n48wFyprhLP
         M0pvsU/ZrwyHHhREjeQRRdEQgr4KSn4rPPzbFuec3fLHEiUrXcz6qsvaxIlcQmuFrgA8
         dC89/sn9l9nNPOUytHEBbDwd43N5DH1uos0yhiMmdfZkM131pNNCqFstpV35Pod6gWL2
         8tmzHKa9k/TUSTo92JFbkAcUu73x1xWCQIGgE8zBofd5feW71IG+HXu11dUEo96gFtC8
         vUAlATR/A8DkmAsjTJJBVkkmCMoiqu85gikxNpQwTdrSdbjq76DL/ByMNuFg9d0SzeVa
         YTEw==
X-Gm-Message-State: AOAM530OHhvVNygCYq0/tYjB8NWG4pGbeP5H1n+sOpnxs4/NB+QpGxcS
        zmYnV22pbTZM8QXXgt2JBeE8QToQMNXy/Q==
X-Google-Smtp-Source: ABdhPJx16hmoh+BY5DENUZp0HG3OBdtf8GOzrmVAP6qlG4Zeii/ZLu236fyS4Q/+QEGVvqLjZG+4cg==
X-Received: by 2002:a17:902:b083:b0:161:955e:f16e with SMTP id p3-20020a170902b08300b00161955ef16emr22961287plr.73.1653318754525;
        Mon, 23 May 2022 08:12:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a31-20020a056a001d1f00b00517c84fd24asm7343281pfx.172.2022.05.23.08.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:12:33 -0700 (PDT)
Message-ID: <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
Date:   Mon, 23 May 2022 09:12:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
 <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk>
 <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
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

On 5/23/22 8:47 AM, Al Viro wrote:
> On Mon, May 23, 2022 at 08:34:44AM -0600, Jens Axboe wrote:
>> On 5/23/22 08:22, Al Viro wrote:
>>> On Sun, May 22, 2022 at 08:43:26PM -0600, Jens Axboe wrote:
>>>
>>>> Branch here:
>>>>
>>>> https://git.kernel.dk/cgit/linux-block/log/?h=iov-iter
>>>>
>>>> First 5 are generic ones, and some of them should just be folded with
>>>> your changes.
>>>>
>>>> Last 2 are just converting io_uring to use it where appropriate.
>>>>
>>>> We can also use it for vectored readv/writev and recvmsg/sendmsg with
>>>> one segment. The latter is mostly single segment in the real world
>>>> anyway, former probably too. Though not sure it's worth it when we're
>>>> copying a single iovec first anyway? Something to test...
>>>
>>> Not a good idea.  Don't assume that all users of iov_iter are well-behaving;
>>> not everything is flavour-agnostic.  If nothing else, you'll break the hell
>>> out of infinibarf - both qib and hfi check that ->write_iter() gets
>>> IOV_ITER target and fail otherwise.
>>
>> OK, I'll check up on that.
>>
>>> BTW, #work.iov_iter is going to be rebased and reordered; if nothing else,
>>> a bunch of places like
>>>         dio->should_dirty = iter_is_iovec(iter) && iov_iter_rw(iter) == READ;
>>> need to be dealt with before we switch new_sync_read() and new_sync_write()
>>> to ITER_UBUF.
>>
>> I already made an attempt at that, see the git branch I sent in the last email.
> 
> There's several more, AFAICS (cifs, ceph, fuse, gfs2)...  The check in
> /dev/fuse turned out to be fine - it's only using primitives, so we
> can pass ITER_UBUF ones there.  mm/shmem.c check... similar, but I
> really wonder if x86 clear_user() really sucks worse than
> copy_to_user() from zero page...

Yep, not surprised if it isn't complete, I just tackled the ones I
found. I do like the idea of having a generic check for that rather
than implicit knowledge about which iter types may contain user memory.

I haven't looked at clear_user() vs copy_to_user() from the zero page.
But should be trivial to benchmark and profile. I'll try and do that
when I find some time.

> FWIW, I'd added bool ->user_backed next to ->data_source, with
> user_backed_iter() as an inline predicate checking it.  Seems to get
> slightly better iov_iter.c code generation that way...

OK that sounds fine too, I pondered doing something similar rather than
have the helper since there is an existing hole in there anyway.

> Current branch pushed to #new.iov_iter (at the moment; will rename
> back to work.iov_iter once it gets more or less stable).

Sounds good, I'll see what I need to rebase.

-- 
Jens Axboe

