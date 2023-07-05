Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293D9747C24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 06:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGEEuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 00:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEEuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:50:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08FD10FB;
        Tue,  4 Jul 2023 21:50:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6687446eaccso4738913b3a.3;
        Tue, 04 Jul 2023 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688532613; x=1691124613;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxCAuuLrnW2JQicpLK/Aok480LyTTuz4IIcMu6Q3nu4=;
        b=E0HBOf//hnpGrehyQodpeV0wVBBtXQwzXmepRB0c36ENf6z0gxAhS6QY3lUEHWqEgx
         wbSOACEEnB0RYrIg66sR7f1vtctv5R4AWClrUB9y+sydFAI8/pI00u1Cap5+OQnhUl/Q
         uV+kb0mG4Yri/c2NM+xVc7K+Y2m4uKrtTEStfYf1UF0FknprKWHVZysOLE52l4VM7L/7
         DnJ32fvMgyPiRjz7rAVyWwhHf08CYo7kb/tlGiV0pyDWARg79BnZnBUhUOfOfpuEsSSK
         Bxtd34RXBYCCg0H93NlcRTxs4k++1fegUmDzJdICRx91rqCiTcvzJfcg9AyVV7g4gUeS
         BSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688532613; x=1691124613;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxCAuuLrnW2JQicpLK/Aok480LyTTuz4IIcMu6Q3nu4=;
        b=VbezSdfAwhYaCJ+XjfyS5S7wb0vXVJwOsqao7s11QsUaXEzfvCZF4Szpcp+8XsU0yH
         CrIXpcNe8o5b2xJh+iFdSKZCwUtRBQC7vbVlgP9apOyo0vWajQ+HE+cxpoauXD4yd83i
         EFQDqGWK0GtRed6KvhfGkiiTBaIdugaRnTjhc0AFu3M4kcouWgiidhFGYhcYVePQFehe
         nZWmqk8FCdtcXandvcQllU3x1VBjA7r9o/E6T1dkBuP1/6f7p82nkZlLrkiq9G2r1cpy
         NjccSFGfOhu/kN9rMngwCkQ75q5t/yMALeJ+1ZlD6BXSv2psLyvebS6opt9KT+HTp24M
         uewg==
X-Gm-Message-State: ABy/qLY/fQvzhbKSe9lfrj/ZZIIF12fGJ5EIXNdlIrs4PftatY+HA6iy
        AEC40HaQjD3GUtjdI0pmAoS+dOz0EWQ=
X-Google-Smtp-Source: APBJJlEFfV4+4nQChTbXaYPf3X5/PXLqh03tXmrAYGwoGMq3/GKrBrbNHLmJyKojZKIqU4yquayKCA==
X-Received: by 2002:a05:6a20:42a6:b0:125:29e5:ae53 with SMTP id o38-20020a056a2042a600b0012529e5ae53mr19705167pzj.62.1688532613111;
        Tue, 04 Jul 2023 21:50:13 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b001b89615c10dsm4531538plk.140.2023.07.04.21.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 21:50:12 -0700 (PDT)
Date:   Wed, 05 Jul 2023 10:19:59 +0530
Message-Id: <87mt0bj72g.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     zenghongling <zenghongling@kylinos.cn>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhongling0719@126.com, zenghongling <zenghongling@kylinos.cn>
Subject: Re: [PATCH] fs: Optimize unixbench's file copy test
In-Reply-To: <1688117303-8294-1-git-send-email-zenghongling@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zenghongling <zenghongling@kylinos.cn> writes:

> The iomap_set_range_uptodate function checks if the file is a private
> mapping,and if it is, it needs to do something about it.UnixBench's
> file copy tests are mostly share mapping, such a check would reduce
> file copy scores, so we added the unlikely macro for optimization.
> and the score of file copy can be improved after branch optimization.
> As follows:
>
> ./Run -c 8 -i 3 fstime fsbuffer fsdisk
>
> Before the optimization
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks          3960.0     689276.0   1740.6
> File Copy 256 bufsize 500 maxblocks            1655.0     204133.0   1233.4
> File Copy 4096 bufsize 8000 maxblocks          5800.0    1526945.0   2632.7
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         1781.3
>
> After the optimization
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks          3960.0     741524.0   1872.5
> File Copy 256 bufsize 500 maxblocks            1655.0     208334.0   1258.8
> File Copy 4096 bufsize 8000 maxblocks          5800.0    1641660.0   2830.4
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         1882.6
>
> Signed-off-by: zenghongling <zenghongling@kylinos.cn>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 53cd7b2..35a50c2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -148,7 +148,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	if (PageError(page))
>  		return;
>  
> -	if (page_has_private(page))
> +	if (unlikely(page_has_private(page)))

IIUC likely and unlikely are macros which provides hints to the compiler
to emit code which can produce branch prediction to favour the likely
case. Prefetchers can then prefetch instructions in the pipeline for the
likely case. But if the branch prediction goes wrong, then it could
cause performance problem too.

Now, with large folio support in XFS and for platforms with bs < ps,
this patch is incorrect. As page->private is always true for bs < ps and
it can be sometimes true for a large folio (in the latest upstream code)

I don't think this is the right fix anyway. However I will be curious to know
why did you make this change? Ideally with advanced micro architecture
improvements, I believe the cores already have a branch target history (BTH),
to know which branch to take. So was this showing up in your perf
profiles as branch misses or something?

-ritesh

>  		iomap_iop_set_range_uptodate(page, off, len);
>  	else
>  		SetPageUptodate(page);
> -- 
> 2.1.0
