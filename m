Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC266AB2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 12:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjANL3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 06:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjANL3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:29:10 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822176AD;
        Sat, 14 Jan 2023 03:29:09 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id y19so3687208ljq.7;
        Sat, 14 Jan 2023 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J454pkV9x088Xk1LCtd7Klprj/qr0Ti1c3F79rejMvw=;
        b=a+9Pq8xgGNN7sQ06zWv9LJoR0UbAKyfbeGHm5UwJ5hari93Mm5bs07UMpUA/dJFXKl
         b9Delo3UYvChotwZibmVoSpUpwjR0ykLPn/FZIILUxG0S/Jquv2rThKFVdB8++LYkjXL
         jmEYA2m94sFh2JOVAc2+S4aMyWK+9mMi0VkmQfcjXac7gIc27Qs6YRYBicitHqaSzDhP
         qix7FBcITeRhB1a7eDYnpZuh9OGD0Q3PaiHSyqZdOH8uzPkS3EQgsi1Ray99ud1PFhnm
         nNtQDPaHCtSJvie5MNJGGVVb22b8MpHDSWw+KrEISI9D3Rc8ra0wNmJTydpsebjE+4Ts
         tPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J454pkV9x088Xk1LCtd7Klprj/qr0Ti1c3F79rejMvw=;
        b=HrjMuWquA0R0rvSbGdKVgjupT73QNlaC4A3azHEo8zUFlAqyzRY3T/Z82ZrsTNEn8K
         SZy08pd3SDjRL0vYxAv78P3PqxzvWvBCAB5zWNrY7GtvfNWJ2fvZ3/eiWGe41Kg6Bl/G
         Aqt0GXIlXam/HUJRwfVDtk9+cjKfPYPUr7algIuTRvheuSXjSJeGHpcJYvsRs3fduiU+
         X37kDsBLCz1WwIoiR7iGxRZ6LsdpDN+pc9jJ4InwiqIi7PKF5eQq47sCh7nd7+cs5Fga
         eT/FXHrEhi7eCVaiT7iEpb0GnRMqeGUHqbPc7AuhIeoZUQixJJ3Cq5xv8Q0tEXAl7sfy
         KFBg==
X-Gm-Message-State: AFqh2koJ087s+xoURFDPVfgmZQ0BGQ62U0fUFCgU8iSYZTyxs434ixjo
        6VXt/9vqBRdJ1bYR/1z94Iuqz5ug/iOU8KRs3qc=
X-Google-Smtp-Source: AMrXdXt9P26wU2KaxUPQ7u+dDkaFi/gJPVRtrNjzK7YwvRjaDioXiMHSHfoocsW+UWn//GyhRRT335zTz6XSa5pIu+o=
X-Received: by 2002:a05:651c:179e:b0:27f:eef3:921d with SMTP id
 bn30-20020a05651c179e00b0027feef3921dmr4234301ljb.515.1673695747727; Sat, 14
 Jan 2023 03:29:07 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
 <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com> <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
In-Reply-To: <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 14 Jan 2023 12:28:30 +0100
Message-ID: <CA+icZUUhY7-F5Bpw-jxofhw4nMP3nzyfpt9huzeSWwUguguNsA@mail.gmail.com>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs cpu_relax)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ ... ]

> Best is to ask the Debian release-team or (if there exist) maintainers
> or responsibles for the IA64 port - which is an ***unofficial*** port.
>

Here we go:

https://lists.debian.org/debian-ia64/

Posting address: debian-ia64@lists.debian.org

Found via <https://lists.debian.org/completeindex.html>

-Sedat-
