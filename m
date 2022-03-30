Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36E4EBACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiC3Gal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbiC3Gac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:30:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087955BE1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a30so18871951ljq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+058yQ0rk1dSz4lOGrP1Pz3rRM6fvoBLkVgOS4k3umk=;
        b=CHuPaTr7VHK4xZuxnF9F3hsYr0aHjZPaHruOVyc2QxKzUQa0aa9p0oScHfUrczNu6j
         9yH3SvjIIFljkwbchTKgwGdQ4b/iETvyDMJay5BuI1nDNDrlTotTD28NAnmKrXWUic0A
         XdQkuc6Qmcwjwzm46QNtw6BY087qsZZ43ZsEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+058yQ0rk1dSz4lOGrP1Pz3rRM6fvoBLkVgOS4k3umk=;
        b=ZcAviS3vxEOwG1rRM+2EBfjBdCt6HI3dIyGdPv+BxWGTlQLEsaLmEi0MDkOH8ZNq5N
         jsWhAw4tJAMMT67a8No3BOw2oIUrrAzdjDcaspr6LA/VwrKPDCDdUtjt+glJ8Jwk2IRm
         QUQPHXTE8+7tfMjd/bBCtTFtw8CUm627qUzuXTTq1Okrfp27uhjNblelf5gU93hpuYpN
         8nw84pFzGUYQoTdg60FRTYF78GSk2GUsoWw9PamdqJQT0l5+vX0quqYi6sxaPR1K01M3
         EShIgzq2YcNVPBlAoYPMYUdEnxTNU5+IbivCNdPOUTfdxZ1Cttl8qBaKWguV0T4jDzTo
         YQbQ==
X-Gm-Message-State: AOAM532iIYP1DyyfPBzPcoTlLfSn9KobzVW+0Ul0E3MV8g2GtvliQv2u
        FgLic9toO8LRlQC8Vf1bZNFIdoc4dkzRNmcI
X-Google-Smtp-Source: ABdhPJwlfJaZ3ruuaJq2jQbs0QdXPFPPDh9IXSnMM6VDx5jkmacDm8pHteAAfXgw2ovXe2JkVNe8lQ==
X-Received: by 2002:a2e:6f0e:0:b0:249:817e:6b23 with SMTP id k14-20020a2e6f0e000000b00249817e6b23mr5529285ljc.147.1648621723820;
        Tue, 29 Mar 2022 23:28:43 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p41-20020a05651213a900b00443e2c39fc4sm2224918lfa.111.2022.03.29.23.28.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:28:43 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id a30so18871883ljq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:42 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr5743894lja.443.1648621722263; Tue, 29
 Mar 2022 23:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
 <YkPo0N/CVHFDlB6v@zx2c4.com> <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
 <YkP2hKKeMeFrdpBW@zx2c4.com>
In-Reply-To: <YkP2hKKeMeFrdpBW@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 23:28:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
Message-ID: <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 11:21 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Yep, that works:

Ok, I'll apply that asap.

I think the "do this better" version is to get rid of
count_open_files() and moving all the logic into sane_fdtable_size(),
and you end up with something like this:

    static unsigned int sane_fdtable_size(struct fdtable *fdt,
unsigned int max_fds)
    {
        unsigned int i;

        max_fds = min(max_fds, fdt->max_fds);
        i = (max_fds + BITS_PER_LONG - 1) / BITS_PER_LONG;
        while (i > 0) {
                if (fdt->open_fds[--i])
                        break;
        }
        return (i + 1) * BITS_PER_LONG;
    }

but considering that I couldn't even get the simple ALIGN() in the
right place, I think going with the obvious version I should have
picked originally is the way to go..

              Linus
