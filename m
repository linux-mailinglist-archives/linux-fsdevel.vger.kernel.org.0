Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63FC58DC9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 18:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbiHIQ7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbiHIQ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:59:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AC623BEF
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 09:59:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f22so15879632edc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wd497S56+K95g5FaqzrmxaFzjMGRAlDYX8elVPh1XVU=;
        b=BU2X6qpa/x075cReLXeIooVs+K5g3X+YtWLif1Vi9M9uo8Jntz/7IsCFIT4sdxTUKC
         k/DJVSY3ZerzpUWGkUpXFuRKGKexKRZ5Rrlmkl6WVL5OXhP+58+DzkLrRROI9V5iprRB
         VwWszW99AuOHZBNx6muATlWHDRvNuDi3fumVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wd497S56+K95g5FaqzrmxaFzjMGRAlDYX8elVPh1XVU=;
        b=eVtDB99BAJfU50avh/j4Yb5cesGaP/W3EPjQY4FRfjoLLqGhn0BF5TE8ydJ0EybHTf
         fxOxEdj0qsiujHvwhK/IhhxDKuJh0OdNAzC5HFIfiulT931QLxMmneA3AzKdUiHiopkG
         YkW1rN4OaVRqum1JlKJiBjvi0sem32BaQDtzTRYJBfRl/h+A5eXJgBxNM70GWOoV5emQ
         Ii8nrcOdtyfElOPII6hUXOL9i9QF+J1V3XcKNG1iOB4w+MrR5kkWwjmGaWcdeqdwYOon
         2RzTkvU/W7ID4ndTG4u/zAHZ/ZhOPogHFrpOEHcI51KqoQ3kvjNOlaMf+lB/yyXPgztw
         hwmw==
X-Gm-Message-State: ACgBeo3kXHWy48D/prhIM4KNz8L/DqdpG+0C1I/Xm7NnH4LkrkLMDT98
        OYS7+9102MI8fs3z35ZGrQ/tSgvkeYDkYM7r
X-Google-Smtp-Source: AA6agR5ucEKh4bSdlseYxNplTHdQJ4UvMYYxk5myF4eB1J3NSLzcmXRxnXcbA5GOuvrcX3v/CGttiA==
X-Received: by 2002:aa7:d053:0:b0:43d:b75:fd96 with SMTP id n19-20020aa7d053000000b0043d0b75fd96mr22477464edo.12.1660064353495;
        Tue, 09 Aug 2022 09:59:13 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id ky16-20020a170907779000b00730a73cbe08sm1288565ejc.169.2022.08.09.09.59.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:59:12 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id j15so15012001wrr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 09:59:12 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr14642883wrw.281.1660064352374; Tue, 09
 Aug 2022 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220809103957.1851931-1-brauner@kernel.org>
In-Reply-To: <20220809103957.1851931-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 09:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5pHi37dk0Ru93yvmJYU-FpcTpJ6tRcOQqO83SDkgMeQ@mail.gmail.com>
Message-ID: <CAHk-=wi5pHi37dk0Ru93yvmJYU-FpcTpJ6tRcOQqO83SDkgMeQ@mail.gmail.com>
Subject: Re: [GIT PULL] setgid inheritance for v5.20/v6.0
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
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

On Tue, Aug 9, 2022 at 3:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Finally a note on __regression potential__. I want to be very clear and open
> that this carries a non-zero regression risk which is also why I defered the
> pull request for this until this week because I was out to get married last
> week and wouldn't have been around to deal with potential fallout:

.. excuses, excuses.

Congratulations.

              Linus
