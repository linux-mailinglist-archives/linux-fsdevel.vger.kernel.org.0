Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF54EB4CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 22:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiC2UpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiC2UpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:45:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A04D9CF;
        Tue, 29 Mar 2022 13:43:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q5so25023167ljb.11;
        Tue, 29 Mar 2022 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1jJnriHBqYsOMa1zkCTaJhRMnwMPDEtIKRlxtq+1sQ=;
        b=FqJ3jhO9W0nuuyWg+d8UHndZiG7gf7FAcaV5fHn/bxT7FExG89/gILPESlBqqlpeYJ
         g3uiYfIuQPXxJ5eQM+4WEOnaTF+isCwcBAwEso1rggEyjSlIi8tyUG38t7Ri75KHeEct
         DWiZasihv3n8eKI0hOVQaC1AGOTo88RbArV90lP6X+SgPFksN7Y9qz2oUUI5V+B4wTiZ
         6xAEhBSFekNX/7xBqWpGa6jupVMqeq+pJKRYVAMKoFELRXXZTEPFTohHLQeKcze9MrFl
         XGOBQ/pkGfZhm3C9VR1J1UEKiztsAjOYvILSwatate7qjbReKSmF6EczhCe8/rgux7DM
         shWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1jJnriHBqYsOMa1zkCTaJhRMnwMPDEtIKRlxtq+1sQ=;
        b=tsj6doIbXhEHG+fcaht54Mip2m2sJn25WA4rXxQTvTYdXM2NGhjb8JYFl89Ah+TZ0U
         /XM8jIZFSknyZheL21bDycyBpnkhlVik9WnoKEY9SOVPNjL9PSf5G/8KyD8uiXBIKERU
         HxIrEKS1qgaPoEEYLrImASug5H71QDezkz/x8+QiPWh/3pxkm1WqST69zGIrGmm1P4Qb
         37zWfkd/PBdqDha48ZOh3UtzcwhGvroK4IetmJqqto30hsMJ9zJ1bMtpr/64ckHUSDoj
         wDgM3rX1GwZHioCsc3fho/ucWcmvPFPmFXkWRG17pXLI2MQvE7wo6Hv+LFLALxvhPaK9
         aL5g==
X-Gm-Message-State: AOAM530oSqsydNSqLGm0IzWZ9AfvLsH6bbBLZo1lUKV9DL3vniKOugXH
        Hbv/Iw8MVqwmXvk8nrBBp6c=
X-Google-Smtp-Source: ABdhPJw3S4ZXS8ygFUVeRDCfH/JYMHR4kqK5Ota8n8q4qbcReTL7UN0t6A9ugzwLsElWthKCBwdhMA==
X-Received: by 2002:a05:651c:1989:b0:247:deaa:4e5a with SMTP id bx9-20020a05651c198900b00247deaa4e5amr4175402ljb.274.1648586606312;
        Tue, 29 Mar 2022 13:43:26 -0700 (PDT)
Received: from fedor-zhuzhzhalka67.localnet (109-252-148-208.dynamic.spd-mgts.ru. [109.252.148.208])
        by smtp.gmail.com with ESMTPSA id d12-20020ac241cc000000b004437eab8187sm2098671lfi.73.2022.03.29.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:43:25 -0700 (PDT)
From:   aissur0002@gmail.com
X-Google-Original-From: FedorPchelkin@fedor-zhuzhzhalka67
To:     Fedor Pchelkin <aissur0002@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Date:   Tue, 29 Mar 2022 23:44:54 +0300
Message-ID: <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67>
In-Reply-To: <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67> <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Btw, do you have a pointer to the syzbot report? I see the repro and
> the crashlog you attached, but it would be good to have that pointer
> to the syzbot original too.
> 
> Or did you just do this by running syzkaller yourself and there is no
> external report?

Alexey V. Khoroshilov (<khoroshilov@ispras.ru>) will soon answer about
the syzbot original, I suppose. Personally, I possess  only Crashlog and
repro.c file which I ran on a local machine and I don't know whether
there is an external report.

As for the solution you proposed, I agree with it: definitely the problem
was caused by an incorrect alignment of max_fds. Frankly speaking, I
didn't know that
> sane_fdtable_size() really should never return a value that
> isn't BITS_PER_LONG aligned 
because there is no explicit alignment of max_fds value in the code as
I can see.   




