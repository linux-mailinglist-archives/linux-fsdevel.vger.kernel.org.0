Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B020585FFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiGaQwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGaQwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:52:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC522F
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 09:52:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id uk30so4174145ejc.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pxWZE128SOoi74e8JOBbhE84B0ZObg/+wPX7SefHUuA=;
        b=iHWZ83fSPh2Igp333ox3FD6XSVbvS1kiY+Ie/NNBd/XQk3g85+GgNYG9Z0ZRD3p/GC
         irAFizM3U/s/77M775f/0+JSV/wUM1t/WOnVmQsMkE0N+NljI0Pi3kCN/Bmo1+P/cfF4
         eaQxDmePH9qtjS3M9tAmCUZW+vGGqj+vCOYjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pxWZE128SOoi74e8JOBbhE84B0ZObg/+wPX7SefHUuA=;
        b=gqQVU8sSfUi5o5ceHdKMlxENFQrL91Amsp6JWcAmcQpLMZbV1sPdyfAge1Gy89+mO2
         fdxajupnpf5hKfTQfMeq76kjpoa876Cav3GHhOvXL56sFusxcpr8Vah7dcaMQ6GA2wE/
         ISld0vaX8gylIsw9yXayeeNSQsTf9smFzXa9HxUaMjE7+876NRXJssgH3AphrRzgdlo9
         Iu0YciZFFXuJBnvActkpPNGyimaGx3/NlIKI21tRZoO2vZ6FA/J86Q3QxO8D0zPNKlam
         DCbpStrWcUJHrO0O4xp/dMwiIVoQBjTluLLvcL5p4DrAroQcEtkZZkW/IGJChfwbLO77
         pNkQ==
X-Gm-Message-State: AJIora+ayT9HJnCsZWkVd76Mj1peMPjkSLkLu3r3HsL06vp1oETnVib2
        F/+JVqhF/PaIHcy9cpXGGX0gnBcuZ09J1Iay
X-Google-Smtp-Source: AGRyM1tE2FI1neNhSUWAb3W+yJF1ERrLeYI2L69ZCOhiF/SR5Jqx5qdS8Nw2yBhuMIuCzEFJlZZO6Q==
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id 29-20020a170906029d00b006f018d87be0mr9225474ejf.561.1659286327550;
        Sun, 31 Jul 2022 09:52:07 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c51a000000b0043bba5ed21csm5464908edq.15.2022.07.31.09.52.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 09:52:05 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id j15so3304677wrr.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 09:52:04 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr7759766wrw.281.1659286323647; Sun, 31
 Jul 2022 09:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 09:51:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
Message-ID: <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
Subject: Re: [PATCH v2] make buffer_locked provide an acquire semantics
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
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

[ Will and Paul, question for you below ]

On Sun, Jul 31, 2022 at 8:08 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Also, there is this pattern present several times:
>         wait_on_buffer(bh);
>         if (!buffer_uptodate(bh))
>                 err = -EIO;
> It may be possible that buffer_uptodate is executed before wait_on_buffer
> and it may return spurious error.

I'm not convinced that's actually valid.

They are testing the same memory location, and I don't think our
memory ordering model allows for _that_ to be out-of-order. Memory
barriers are for accesses to different memory locations.

Even alpha is specified to be locally ordered wrt *one* memory
location, including for reads (See table 5-1: "Processor issue order",
and also 5.6.2.2: "Litmus test 2"). So if a previous read has seen a
new value, a subsequent read is not allowed to see an older one - even
without a memory barrier.

Will, Paul? Maybe that's only for overlapping loads/stores, not for
loads/loads. Because maybe alpha for once isn't the weakest possible
ordering.

I didn't find this actually in our documentation, so maybe other
architectures allow it? Our docs talk about "overlapping loads and
stores", and maybe that was meant to imply that "load overlaps with
load" case, but it really reads like load-vs-store, not load-vs-load.

But the patch looks fine, though I agree that the ordering in
__wait_on_buffer should probably be moved into
wait_on_bit/wait_on_bit_io.

And would we perhaps want the bitops to have the different ordering
versions? Like "set_bit_release()" and "test_bit_acquire()"? That
would seem to be (a) cleaner and (b) possibly generate better code for
architectures where that makes a difference?

               Linus
