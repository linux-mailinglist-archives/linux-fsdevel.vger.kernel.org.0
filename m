Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DC6335B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 08:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKVHNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 02:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVHNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:13:09 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CF2E68E
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 23:13:07 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id e205so14955567oif.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 23:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10BjkhMSoW3U2bUGh0N+e/mWSGo0zobvSPy084Dj9BQ=;
        b=KqyzAPtZWobpeGRi9LQ+DhiSU4wvqjSNU3xs8C1GInmZQbSEtflx9JrArirkib4WQf
         fw3U2sVgpL6y1AQjIQA4pDRp/VCicSAN7+FQDrVlIRNHFwkPLiR9E5idoDEdBajIDGsD
         1tqIsuGX1Y7560n1FGmyImja+PG1ONFldo0V4jlIObwHcxmad27ZV2PJkHbDStIiY8pb
         ikGOjHQWd5ylPVm1jFC43+vlxtrTimvPvKo7ZZGAlGQXx0NdlGNeiFFVGV3PfLiBe1Of
         CPKUiCIceyD08wUn8Xt4YqcSSi2OfK3j+9fElpuyv80rPELXo6t8Fa/6mvvrcL8fr9fm
         ltDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10BjkhMSoW3U2bUGh0N+e/mWSGo0zobvSPy084Dj9BQ=;
        b=FkVxO0Th8taQSOLRIuzOpgpsk8xfxWjzor9ShnQOxbSRsX1mCsNr3mo7J/R/qVxerS
         zITugtwaK4zEjjwbFNyXXgPZIBHYwzQxv/g7V97qC6p9aua/QP2B296MKLkvT3ozD8nK
         oFZ58N9XWQsc8g5clOmIXR7nLj1YYbCKTiQhG+z03Ekis2eWxolc6YmKWyJGGJq+Vk0o
         AosA9L2X5xzUTcISWVCNaFAmii96VL3P7ttCsEE0cT5ZXo8x7xbPyuNr26/M+ey1v7eM
         vtG/jD8ptaDYX2c5o1v1N+sv75dqJzZauZuj3NfWswsaVzn0wmynCGEO5wOoL4ErCuQw
         9NoQ==
X-Gm-Message-State: ANoB5pmrySSUWfGDAo0t/+Tgs4IEpOw4dEQySqrUI4CH4vofAbRpcX4T
        7dqTO4RjK2hwiraHpRxsnLL2YPvpJh8pBr2k9WJV7Q==
X-Google-Smtp-Source: AA0mqf4geafsJBx57KC9nW9HQ4zgwi/eHXhTeMgKKI74g9eXx4OqQNsH/1CqxiROB1z7sy3NpPw80n7ggOmcETXvAyE=
X-Received: by 2002:a05:6808:1115:b0:359:cb71:328b with SMTP id
 e21-20020a056808111500b00359cb71328bmr10640723oih.282.1669101186975; Mon, 21
 Nov 2022 23:13:06 -0800 (PST)
MIME-Version: 1.0
References: <CAO4mrfd4=HRXMrcdZQUorNaFss3AFfrRxuXWMFT3uh+Dvfwb9g@mail.gmail.com>
 <CAO4mrfdU4oGktM8PPFg66=32N0JSGx=gtG80S89-b66tS3NLVw@mail.gmail.com>
 <CAO4mrfftfwBWbt-a1H3q559jtnv93MQ92kp=DFnA+-pRrSObcw@mail.gmail.com>
 <CACT4Y+Zub=+V3Yx=wSagYYeybwhbBt66COyTc=OjFAMOibybxg@mail.gmail.com> <Y3xmSbsjoMRnRIEd@casper.infradead.org>
In-Reply-To: <Y3xmSbsjoMRnRIEd@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Nov 2022 08:12:54 +0100
Message-ID: <CACT4Y+YCqrvj-Z46bQiOe-iHzt8CFvk3XZ-Zt4CSGOSshGg0oA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in gfs2_evict_inode
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Chen <harperchen1110@gmail.com>, rpeterso@redhat.com,
        agruenba@redhat.com, cluster-devel@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Nov 2022 at 07:03, Matthew Wilcox <willy@infradead.org> wrote:
> > > Dear Linux developers,
> > >
> > > The bug persists in upstream Linux v6.0-rc5.
> >
> > If you fix this, please also add the syzbot tag:
> >
> > Reported-by: syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com
> > https://lore.kernel.org/all/000000000000ab092305e268a016@google.com/
>
> Hey Dmitri, does Wei Chen work with you?  They're not responding to
> requests to understand what they're doing.  eg:
>
> https://lore.kernel.org/all/YtVhVKPAfzGmHu95@casper.infradead.org/
>
> https://lore.kernel.org/all/Y0SAT5grkUmUW045@casper.infradead.org/
>
> I'm just ignoring their reports now.

No, I know nothing about this.
