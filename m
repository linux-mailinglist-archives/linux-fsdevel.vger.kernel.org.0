Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94B766CE92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjAPSPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 13:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjAPSOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:14:32 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DD2CFF4
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:25 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j9so2484986qtv.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=hC8rifHiuHXCPgttcmOOf/xO+1ZeeDOeIZfW9Ym8Ory+CkzNJPkrfO/C3JXy2EE1LL
         2kTaAysayLbTpr+7RDLLrKq0FCECx/EKRPZa3mKY+K67nyLJZ8f7PA4gCRWG73mV4Yn4
         5cdNgXBpvhk8M9iRXw8+R8fW3tOu/c3Ashp10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc4Nv1UCPS28NNVDYePaLaV2Wpsm+mIPEHiAzrTw9MM=;
        b=ABeKMzxhfVKcsDFuL1XVWTGMKd11nmqIDjqIA2Ek3pDMz36nVMqsoFJs4m5nJPcBs5
         t5aZf2oeZ1fQSnwzNI1Gfd5+hcmbX3mxDjwoZNjghL6o/n2/MoMI9E1W64R4oxaaBsCZ
         KYGMD0t1xnwlLMBi3xtEgbwC3KOMukfy5PbaDBnY/XxfYtwOpRVO4k4B0fBWnJUOopyN
         RSJC3jH5yT7YPV3E/LZrTVcb2FHxRHKx1IWBQACx8yDhyY8NLaJP5v4Upjtqy5rG2IvD
         bgdcI1x7JMhk11Psv/w/kaBn9AhHol+iaHsYWj/GNMN9XcvYcVZAWirUZvYw1GpJeokD
         Df6w==
X-Gm-Message-State: AFqh2kqqpFvRZj+eC7vv2+uX1q+OxnbcqRuc85tJMTrEzqjLmM2/NlYs
        hyo7SfuhSAepnzaeLcAA5uvTxBO4GEqWbuYR
X-Google-Smtp-Source: AMrXdXtUj6k+N/VRXDQg4nefGRUUltaYcxhs0tKd9WFUdZeaZw3l461zoly7JgaHQhYeT7DvzelBPw==
X-Received: by 2002:a05:622a:2298:b0:3b6:2ff8:3009 with SMTP id ay24-20020a05622a229800b003b62ff83009mr62704qtb.2.1673892084686;
        Mon, 16 Jan 2023 10:01:24 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006cfc01b4461sm18819281qko.118.2023.01.16.10.01.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:01:19 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id p22so2472489qkm.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 10:01:19 -0800 (PST)
X-Received: by 2002:a05:622a:250f:b0:3b2:d164:a89b with SMTP id
 cm15-20020a05622a250f00b003b2d164a89bmr364175qtb.452.1673892068650; Mon, 16
 Jan 2023 10:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 10:00:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Message-ID: <CAHk-=whpkWbdeZE1zask8YPzVYevJU2xOXqOposBujxZsa2-tQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Back from travel, so trying to make sense of this series.. ]

On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
>
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v6.2-rc2.

Ugh. I hate how this adds random patterns like

        if (timeout == MAX_SCHEDULE_TIMEOUT)
                sdt_might_sleep_strong(NULL);
        else
                sdt_might_sleep_strong_timeout(NULL);
   ...
        sdt_might_sleep_finish();

to various places, it seems so very odd and unmaintainable.

I also recall this giving a fair amount of false positives, are they all fixed?

Anyway, I'd really like the lockdep people to comment and be involved.
We did have a fairly recent case of "lockdep doesn't track page lock
dependencies because it fundamentally cannot" issue, so DEPT might fix
those kinds of missing dependency analysis. See

    https://lore.kernel.org/lkml/00000000000060d41f05f139aa44@google.com/

for some context to that one, but at teh same time I would *really*
want the lockdep people more involved and acking this work.

Maybe I missed the email where you reported on things DEPT has found
(and on the lack of false positives)?

               Linus
