Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261E8535DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiE0KPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350907AbiE0KPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:15:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53936ED726
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B34B82433
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 10:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56912C34114
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 10:15:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f18EfSn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653646513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wse9rpeYvGD8jxoI2gHuKrz0sCtF1vkk43/06rCxSI=;
        b=f18EfSn6eE2nP8CSRv8tSGOr6MuZzBE+M5M+5fDnaf/ZmEzBIBG0mDGeeGz7JiHGwgEzos
        xHkJhJPGin9eU51jrMlRwcoF9lL0ymiQDHCzUrce+r5i3CQQi73wPIjyqNMRPwjxTrs9S4
        +uogG/EY/U93OjUVYVDvOBMyemS6iFU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cadb86de (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-fsdevel@vger.kernel.org>;
        Fri, 27 May 2022 10:15:12 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3043b3f7d8fso32181447b3.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:15:12 -0700 (PDT)
X-Gm-Message-State: AOAM530gCJaPR3OYl2eZvQxdiOWg00rvlEeykhifErKL3Kb/KwshSoSb
        vzvYCPbXnJpWAaWiRa+q8gCObeEloOrRRKdlwB0=
X-Google-Smtp-Source: ABdhPJxfGjyMIMwCDMvCstNu7Y2rRoVDiZnCsUeqbq6ZU3iq5F+ffA37pnIgoMEcMC5pBug0T9mKdY1aC8itSOR8Bk8=
X-Received: by 2002:a81:14ca:0:b0:303:1dbd:e524 with SMTP id
 193-20020a8114ca000000b003031dbde524mr6651887ywu.404.1653646511609; Fri, 27
 May 2022 03:15:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Fri, 27 May 2022
 03:15:10 -0700 (PDT)
In-Reply-To: <YpCjaL9QuuCB23A5@gmail.com>
References: <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
 <YouYvxEl1rF2QO5K@zeniv-ca.linux.org.uk> <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk> <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk> <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk> <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
 <Yo+S4JtT6fjwO5GL@zx2c4.com> <YpCjaL9QuuCB23A5@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 27 May 2022 12:15:10 +0200
X-Gmail-Original-Message-ID: <CAHmME9q5i971a8gD4ANqQvL79=2nF2MDiDsn+0uA40wGRCyLLg@mail.gmail.com>
Message-ID: <CAHmME9q5i971a8gD4ANqQvL79=2nF2MDiDsn+0uA40wGRCyLLg@mail.gmail.com>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Samuel Neves <sneves@dei.uc.pt>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ingo,

On 5/27/22, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
>> On Mon, May 23, 2022 at 10:03:45AM -0600, Jens Axboe wrote:
>> > clear_user()
>> > 32	~96MB/sec
>> > 64	195MB/sec
>> > 128	386MB/sec
>> > 1k	2.7GB/sec
>> > 4k	7.8GB/sec
>> > 16k	14.8GB/sec
>> >
>> > copy_from_zero_page()
>> > 32	~96MB/sec
>> > 64	193MB/sec
>> > 128	383MB/sec
>> > 1k	2.9GB/sec
>> > 4k	9.8GB/sec
>> > 16k	21.8GB/sec
>>
>> Just FYI, on x86, Samuel Neves proposed some nice clear_user()
>> performance improvements that were forgotten about:
>>
>> https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt/
>> https://lore.kernel.org/lkml/Yk9yBcj78mpXOOLL@zx2c4.com/
>>
>> Hoping somebody picks this up at some point...
>
> Those ~2x speedup numbers are indeed looking very nice:
>
> | After this patch, on a Skylake CPU, these are the
> | before/after figures:
> |
> | $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> | 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s
> |
> | $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> | 446476320768 bytes (446 GB, 416 GiB) copied, 15 s, 29.8 GB/s
>
> Patch fell through the cracks & it doesn't apply anymore:
>
>   checking file arch/x86/lib/usercopy_64.c
>   Hunk #2 FAILED at 17.
>   1 out of 2 hunks FAILED
>
> Would be nice to re-send it.

I don't think Samuel is going to do that at this point, so I think
it's probably best if you do it.

Jason
