Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3636C6AFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWOat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWOas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:30:48 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992520A0E
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:30:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x8so14188837qvr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112; t=1679581846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW5cWuSORuMPl9h4M/OMu4zN6Ab689Cgd2Jmn907uzA=;
        b=uga6xPblyjNwQ0nys0O9OMOnWPlxzoqUx0tub1g4jl3Ds7H0qu2WTey6xF5KYLxKjC
         SCNdX/4AXYIE5IhDdtecko+9IOBtUIc3U2CM4hPqaHHiSjJXBWP+o6JLCwKslIKRmAED
         TXE8V7Fa5Vj5MdO1Sgso1Toii0RePFj640IY5JVqwEa1uZwDrQZ5LDzFX93GFGZY9IjQ
         hb8Z808MK7gqHrpq+J6Wxii0pqN6Kedc0VTbCmzHxDcz5RluBsBf5YY47foQKVJ8WL5w
         Hhs7tyAu+HDhks/IkXKF2t4EX3GViwlbB8pSikG3+R69thN52bWR4mIjSGgorkjzAiC0
         GC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW5cWuSORuMPl9h4M/OMu4zN6Ab689Cgd2Jmn907uzA=;
        b=nGd4f7M0SZcNVLMVCNpa1uND4m3/6QyojLLBuvYiyKRQJUmgydJE7KOS1GmZ4ZDBR3
         brFU+I/Xq0ScWMAQvZAi/SDZuMJvZYvgQe43M3I0eDeQxMnRVcVek7c6F37xgXPq2ItD
         GOdtMFEoQswyRMZjJpw5uTarsn5IQSG/tgB51EAFaZpus3qCqie/XTkTC2jFQKxV/0Kx
         PcWdXlqvzucf8OAFm/GR2DlxYzT++Bkp1b8jxgaWPc6YWyj/sPEb4vMzzmBbGT7TEEJ5
         mU9rPQKaUCaJ3iPHyDLsAM3vK1G5EJ3ZY8D76cDbpbUn1J5YvUxwawloDVvanGOeRlbh
         Ru+Q==
X-Gm-Message-State: AO0yUKVhNVZTP27XTjWrg5834RUaJfLudHRCqsj+fn3xtlxZaua4Pt6L
        UMqPS1drGQ81YDBo1US9bdrVkImDONiMdTWzFLp4qQ==
X-Google-Smtp-Source: AK7set/trVllkfcEi+yg3oqpS8DY+A/uEckTTWNRYDqUdJd5erFFIJB2DTR1p2z4pS/Mo+VlMX55/q/gvrdpE0I/XKA=
X-Received: by 2002:a05:6214:8c7:b0:537:7476:41f7 with SMTP id
 da7-20020a05621408c700b00537747641f7mr1552535qvb.3.1679581846154; Thu, 23 Mar
 2023 07:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
 <20230322135013.197076-1-p.raghav@samsung.com>
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 23 Mar 2023 10:30:35 -0400
Message-ID: <CAOg9mSRvPDysNF-GV_ZGf8bu1-50wA5y7L=LuZwGp+vEVzsu1Q@mail.gmail.com>
Subject: Re: [RFC v2 0/5] remove page_endio()
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, martin@omnibond.com, mcgrof@kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have tested this patch on orangefs on top of 6.3.0-rc3, no
regressions.

It is very easy to build a single host orangefs test system on
a vm. There are instructions in orangefs.rst, and also I'd
be glad to help make them better...

-Mike

On Wed, Mar 22, 2023 at 9:50=E2=80=AFAM Pankaj Raghav <p.raghav@samsung.com=
> wrote:
>
> It was decided to remove the page_endio() as per the previous RFC
> discussion[1] of this series and move that functionality into the caller
> itself. One of the side benefit of doing that is the callers have been
> modified to directly work on folios as page_endio() already worked on
> folios.
>
> mpage changes were tested with a simple boot testing. zram and orangefs i=
s
> only build tested. No functional changes were introduced as a part of
> this AFAIK.
>
> Open questions:
> - Willy pointed out that the calls to folio_set_error() and
>   folio_clear_uptodate() are not needed anymore in the read path when an
>   error happens[2]. I still don't understand 100% why they aren't needed
>   anymore as I see those functions are still called in iomap. It will be
>   good to put that rationale as a part of the commit message.
>
> [1] https://lore.kernel.org/linux-mm/ZBHcl8Pz2ULb4RGD@infradead.org/
> [2] https://lore.kernel.org/linux-mm/ZBSH6Uq6IIXON%2Frh@casper.infradead.=
org/
>
> Pankaj Raghav (5):
>   zram: remove zram_page_end_io function
>   orangefs: use folios in orangefs_readahead
>   mpage: split bi_end_io callback for reads and writes
>   mpage: use folios in bio end_io handler
>   filemap: remove page_endio()
>
>  drivers/block/zram/zram_drv.c | 13 +----------
>  fs/mpage.c                    | 44 ++++++++++++++++++++++++++++-------
>  fs/orangefs/inode.c           |  9 +++----
>  include/linux/pagemap.h       |  2 --
>  mm/filemap.c                  | 30 ------------------------
>  5 files changed, 42 insertions(+), 56 deletions(-)
>
> --
> 2.34.1
>
