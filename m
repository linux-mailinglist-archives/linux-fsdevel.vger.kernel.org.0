Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B325FA213
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJJQmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJJQmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:42:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669C6DFA2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 09:42:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h12so4535126pjk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+X0dPUNTzvXsxSJGYhvGB/UduBVQg8zNVHQH+Kp9jQ=;
        b=eVCfkkkCkVgQuSb4QlPgq/2erp2lpWi8z0RZhA7C/aNm1ryA2KL2HGi2tJdq6mOpSO
         WuXGAjiirI7U10uM01RcSKJh8syoKd80r4J9HjkukfdWHJdmIwxIQuPiFOgB+eIBVopK
         jBeWUolzRg2C11i9Zy4jhkAKGDVPBE+oz3FhXEZ4GYVX20ZlHL6h53UAvoKZm4ckMPkZ
         +DbTFd9cYNC8CSOF4i3zIOg+40YGb8f1lE52HMat42SH/4mOSV0cEPSuPFHx4TwYaegO
         3f346LPCE4dJK9Wc1VYUZ13QEKKdlGshSU8Rilx20RzdPiYfXu6qE8068aTIWcnzOc82
         55TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+X0dPUNTzvXsxSJGYhvGB/UduBVQg8zNVHQH+Kp9jQ=;
        b=5scRQcrn2DOe3tM9yov4i5k/MtVepta0d+txpnnel+cm0BwJmTZGIZ5EmCap5JGl6r
         1gM2LarABg8qhOt8Pc/hCe/MSHLMpA4O3WF6P3bBmvpJqlzGeuJRLPKfgyOlcQTMPdfU
         HEczOAqtjTNynFd/jyPcFrIWM2FmGtOf28RrAzEPmVjc5JSDKKyk3YZDptPR4PqhSNAX
         TONI/LqAUKcNitkWLxjD2CvO3hRMK3rXIab25IzTzWXUj4EiC1WBvAeOz+Ngk0gvfkbz
         d1nvbcmrbKv4/vWj9rfoYaAaxrKlGOejllpcLYLTUTPX1f3KF4cAx4ETwM4snZla9W7P
         NjkQ==
X-Gm-Message-State: ACrzQf2zM/kKea9OBbJ2LFKf4xo7dJ2NNyUkV8rHrX98hu5dmJo26n5N
        tnpC7WlIZ7YMu/7UUXNZY2PaNQNcGeQhTLXidkcPWw==
X-Google-Smtp-Source: AMsMyM5dNVNTY7K3+ncFOHk+OeTpeT8OH00IQspK/gDrewkWzjoXpQQCcmk0OWiDXIO2CGOxDrblgnKbzMTHV98NIUI=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr32777961pjb.102.1665420163240; Mon, 10
 Oct 2022 09:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
 <20221007201140.1744961-1-ndesaulniers@google.com> <20221010074409.GA20998@lst.de>
In-Reply-To: <20221010074409.GA20998@lst.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 09:42:31 -0700
Message-ID: <CAKwvOdm1yMbUUHGeqnKYBptBEqSO0T4k=sUy5i0Bhy3g41+nDg@mail.gmail.com>
Subject: Re: [PATCH] fs/select: mark do_select noinline_for_stack for 32b
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Oct 10, 2022 at 12:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Oct 07, 2022 at 01:11:40PM -0700, Nick Desaulniers wrote:
> > Effectively a revert of
> > commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
> >
> > Various configs can still push the stack useage of core_sys_select()
> > over the CONFIG_FRAME_WARN threshold (1024B on 32b targets).
> >
> >   fs/select.c:619:5: error: stack frame size of 1048 bytes in function
> >   'core_sys_select' [-Werror,-Wframe-larger-than=]
>
> Btw, I also see a warning here with all my KASAN x86_64 gcc builds.

Thanks for the report.  That might be another interesting data point;
I haven't been able to reproduce that locally though:

$ make -j$(nproc) defconfig
$ ./scripts/config -e KASAN
$ make -j$(nproc) olddefconfig fs/select.o
$ gcc --version | head -n1
gcc (Debian 12.2.0-1) 12.2.0

I also tried enabling CONFIG_KASAN_INLINE=y but couldn't reproduce.
Mind sending me your .config that reproduces this?
-- 
Thanks,
~Nick Desaulniers
