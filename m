Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BC3589448
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 00:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiHCWJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:09:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309871D31C
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 15:09:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gk3so21617894ejb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FsfXSqaJQraxiba0yKE7C4urEnasCW26TAfDOCyD+rA=;
        b=D7xk4B/0uc5gGnqzfFElxKP+Iqc42KSnPce+upGB7rCrR4jPtMdmFjUR2TyN7QB4OP
         b+/beAlyubgUFEawoiWGHAmM/UFwEl0BIVLs9Gvi9qpIgY2phnW1G1SfFywK9rfRft+F
         nx8uD+1PQTNufdAH1gYGsaqjTN1kcFCXwg2Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FsfXSqaJQraxiba0yKE7C4urEnasCW26TAfDOCyD+rA=;
        b=hwJa0IFxA/YZoXZJ6ZQM6CDBStyX6e5CBRahxbjogLte7HfP3F8faZDDce3rztu/vH
         LFhGEn1gCKcabBZR5YjRxT/fphXhzh5SrCRGQi3OFzqCXRElPhfS9rWwovi3KfA3AV4z
         /16PXLA0rgE2maw8Evz/SQFnNmj6Ma3dyAAlu84Kqtj0IlERtyfkzRdl6S9CNn8fmgUB
         O1ifIzPDIASyCuhHfw5jitIWFhrAB20PQpEeJ6NpOL2JKiWtFsuGxfngdOlI7HJScIex
         bmuWh5pPiXpI6sDiMY99vn91eiWuvY78Dq/0EzbEejNRv6iuVn26Q75x5zqEzXWnoXPN
         D7ww==
X-Gm-Message-State: ACgBeo3kQJElPK3LhG7OIbX7AgZnVo1sfYLMmCTDsQDiaNqW2sMb95eC
        ASuTj/KkMTR7sgVLlyLgBxEGSbPvxKRoNN2U
X-Google-Smtp-Source: AA6agR7JDjJEZhJtlzLLSzLxAmWf7nLvHhhJe+k3a6+ZCy0b7WzLnjN5zB39vh/hoQz6Vwf3vCu9GA==
X-Received: by 2002:a17:906:8470:b0:730:ca57:2e83 with SMTP id hx16-20020a170906847000b00730ca572e83mr232732ejc.740.1659564580546;
        Wed, 03 Aug 2022 15:09:40 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709062f1700b0072ff4515792sm7718038eji.54.2022.08.03.15.09.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 15:09:40 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id j1so14697635wrw.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 15:09:39 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr17429839wro.274.1659564579607; Wed, 03
 Aug 2022 15:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV> <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org>
In-Reply-To: <YuruqoGHJONpdZcK@home.goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 15:09:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
Message-ID: <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 2:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The original patch years ago use to have:
>
>  preempt_disable_rt()
>
>  preempt_enable_rt()

That may be visually simpler, but I dislike how it's named for some
implementation detail, rather than for the semantic meaning.

Admittedly I think "preempt_enable_under_spinlock()" may be a bit
*too* cumbersome as a name. It does explain what is going on - and
both the implementation and the use end up being fairly clear (and the
non-RT case could have some debug version that actually tests that
preemption has already been disabled).

But it is also a ridiculously long name, no question about that.

I still feel is less cumbersome than having that
"IS_ENABLED(CONFIG_PREEMPT_RT)" test that also then pretty much
requires a comment to explain what is going on.

            Linus
