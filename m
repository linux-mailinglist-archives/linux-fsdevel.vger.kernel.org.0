Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304C53AE40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiFAUr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiFAUrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055791E8299
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 13:41:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q1so6088729ejz.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5mcrmCWuAAdbPHfrDc3j0Y3Y9fXO5pJ7wBIk1OP74A=;
        b=X7Tv7jSyurwqAxOftMCv8MB8L2erC6H7qza7nZau5SMv9NuJDXz++xqv2TCO8O1eNZ
         fqueWV6byN8z2Gu+uMcXfpESO4zCepIeF9lE38C7p3G9ruL4ZOJc2FAVWNdk/Nm5vop/
         sQfYhypjYychJXBmewMMJChgZZn1Gv4yaRaNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5mcrmCWuAAdbPHfrDc3j0Y3Y9fXO5pJ7wBIk1OP74A=;
        b=xt3qJa0dGzvZyfEVP1hXJNBHM0WkVh2OvP07/76kZ5uDu9eT3e8tX7g6XSkJWBsIH1
         1UJwfwR1/RHE+Zl9K0rTftrzjJ9NosDABjEI+wwNTEsoAT9Tbp8KgFgeHIMla0+mwwS8
         iEMxSRHbYr5CABicg26ZlUUZn5m9CB8DBtoEHaByHG+5gwVPtIIxzlIoYHoBexnRTIuV
         vDRkUt7CF0PTM0s8Qldd36vaSPky11V1EVMdEd/wxKT9Ptn0jLAhZSQW4VtrnLNYTw/F
         tATSmq/B/fnEFALOPnrdSebhd4ZPXR29WTT96TwcF0CWirhnlJKaKZ3jQEIILVRm3NfG
         CoUA==
X-Gm-Message-State: AOAM532HjqEBrCuZfpZgYwWg8nTGz6YL5WV7IET9lKZubgNAKfhubxXr
        wyLCiOy9/L1nM99Qf8FSmSJrBzeq/4QzGfeO
X-Google-Smtp-Source: ABdhPJyNMQL77C2RfgA5JUCKg5E3Q1jfL+zOht6SriHADYdfjV3kjtrYarryffDs7RkPH8CJ32YJ7w==
X-Received: by 2002:a05:6402:448f:b0:42d:dac4:9602 with SMTP id er15-20020a056402448f00b0042ddac49602mr1483540edb.152.1654111937443;
        Wed, 01 Jun 2022 12:32:17 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090612d800b006feb6438264sm1016127ejb.93.2022.06.01.12.32.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 12:32:15 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so3624206wmh.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 12:32:14 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr872637wmc.8.1654111934219; Wed, 01 Jun
 2022 12:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <5ec6759ab3b617f9c12449a9606b6f0b5a7582d0.1654086665.git.legion@kernel.org>
 <Ype7skNJzEQ1W96v@casper.infradead.org> <CAHk-=wiTtYMia0FR4h7_nV2RZ5pq=wR-7oMMK3o8o=EgAxMsmg@mail.gmail.com>
 <Ype9ILKm+8WLOq9W@casper.infradead.org>
In-Reply-To: <Ype9ILKm+8WLOq9W@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 12:31:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqoV60WtDM2V=Abx5U33yqx6wVqvPg0V5NyizsKtoG_w@mail.gmail.com>
Message-ID: <CAHk-=whqoV60WtDM2V=Abx5U33yqx6wVqvPg0V5NyizsKtoG_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] sysctl: API extension for handling sysctl
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 1, 2022 at 12:25 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I wasn't suggesting the iovec.  Just the iocb, instead of passing in the
> ki_filp and the ki_pos.

I guess that would work, but would it actually help anything?

I think it's a lot more obvious when it just looks mostly like a
"read/write()" system call (ok, pread/pwrite since you get the pos,
but still).

There is nothing that could possibly be relevant in the kiocb. All
those fields are about odd async or atomicity issues (or "report
completion" issues) that simply cannot possibly be valid for a sysctl
value.

And if they are, that sysctl value is doing something really really
really wrong. So we absolutely don't want to encourage that.

This is not a "do IO" interface. This is a "read or write value" interface.

               Linus
