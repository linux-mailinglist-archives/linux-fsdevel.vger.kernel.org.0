Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A138BD70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 06:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhEUEbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 00:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhEUEbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 00:31:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3481FC061574;
        Thu, 20 May 2021 21:29:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w33so19772768lfu.7;
        Thu, 20 May 2021 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maQS5bwWK1ZC46FsyPgL66ifKdISnTD3BRpN2v/rD4I=;
        b=qLXv66YLf96WKcCjsP+o1116V0epFqjKfPwc8U03FNSNJ8HXrAOYIl/A6WmyL4LWmX
         0At70DqISs92D2yAJe+5BTSJobp3QSeVcrE+Ld/zediooN8UMZZhVFoZ6GdNBcohD0TF
         XMH9O6XX2JBn4Rv7cZMxp4frtHE6f4VQNl9OfgRcQu6cu7YsYKX7mfV8gTLMHjyxbwZM
         wljc6L6srU6gkh6F2AP5DTSQVEeNLd9TlaboRMWU0/7kkvcSfGN0a2tv2s1fYz8h+emV
         xCh5xvr4Z3iwdfxTVYXCoBjvhZ1Kv+I3Cjogusi67EAdwcd139hEqZLkjwC1m6KAjZw2
         xLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maQS5bwWK1ZC46FsyPgL66ifKdISnTD3BRpN2v/rD4I=;
        b=Loh/AZ4IW+sqH+f+NYaenZDQDGSyQMekRD4TQKVbSM+TSNMFDJZEUcYQ+CGYSCs3l0
         Kp4mI3ymuC52Y4tpxCD37zeEkr3sk/NswAfHs1HvK7nj5UA1inDday+CwVT6bFAEs2S6
         s4fNpgwTPRSziapcT6FA0XI/AVKm/AOHO23b6Pd2Lpl+4M1sRx+ayrfNfRMD3zwoQN4p
         HUle8nCBtsqhzEIE/WHDd6KHb4s6PekhW6p3b39zj4q+kYB0e6c1Sk00NOdS68DfoJV+
         8QTWInVdLSTPoTdNgL0vJq3yY/2Jv0iUR6kjyzmwoEcJULDoDA4ATTQY2/RjA21VxzFu
         gk1Q==
X-Gm-Message-State: AOAM530ALDpaXMjP7b6qx1cHzF6gtE/r7gLGXnopinnmAy4+7aHpODMg
        kG/sdTJY5oqYokLE+DovgLNDCiVuHHYU/AjYZYc=
X-Google-Smtp-Source: ABdhPJz5h+od+AbDC2qQKWYCoo09WKOfOEA4/1zm55cg5vaPq8JRuow5VOccXLogxEcr/LePlUduWwBTI3y1CBPILts=
X-Received: by 2002:a19:490f:: with SMTP id w15mr753140lfa.192.1621571390483;
 Thu, 20 May 2021 21:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210517142542.187574-1-dong.menglong@zte.com.cn>
 <20210517151123.GD25760@quack2.suse.cz> <CADxym3ZwUQe0mQfcNxf2_kM1VXdqmtUDK076GptcsfktLWLeog@mail.gmail.com>
 <20210518085519.GA28667@quack2.suse.cz> <CADxym3ZEf7azG+ApRqrg+aUBSm66N5tC0Ybj9FXyHq7BV3ePmg@mail.gmail.com>
 <162155823187.19062.2652820542740740108@noble.neil.brown.name>
In-Reply-To: <162155823187.19062.2652820542740740108@noble.neil.brown.name>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 21 May 2021 12:29:38 +0800
Message-ID: <CADxym3bGfmjmCAjorb_Hq6st7VcKCVjW9v4tD=BKnBtiLOUDGQ@mail.gmail.com>
Subject: Re: [PATCH] init/initramfs.c: add a new mount as root file system
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "hare@suse.de" <hare@suse.de>, "tj@kernel.org" <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Menglong Dong <dong.menglong@zte.com.cn>,
        "song@kernel.org" <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "pmladek@suse.com" <pmladek@suse.com>,
        Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jojing64@gmail.com" <jojing64@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ok, get it!

In fact, I just worried about the 'patchwork'. After resending,
it appeared in the patchwork of fsdev module now.

>
>
> "three days" is not a reasonable expectation.  Give people at least 1
> week before resending or reminding people.
>
> NeilBrown

Thanks for your reminding~
Menglong Dong
