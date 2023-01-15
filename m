Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539DE66B0D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jan 2023 13:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjAOMFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 07:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjAOME6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:04:58 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67DCDD5;
        Sun, 15 Jan 2023 04:04:57 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g18so6335752lfh.0;
        Sun, 15 Jan 2023 04:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71uR/HEov5DHYjQr21uUwUAdHQnBZ2QO6kQLmE+g0jc=;
        b=pydXXibcbCfrT9nF/qicQk4EV/JNOxmm03zN03F+z/B1/ZmEEBAQdVF1nlM8iCNi4t
         e38ZvFkOxNHKr67yXbQhvV9QIDM66Vfxlgon9Rx1EhBLX5BRyIbkHxB0RowNWOSas4ry
         bi5Onq16Fvx0NSlCMXL0qQv3oXgm0i48GEUS1fjGxjA0K3WcX4ce7A8FP9ecc2zNg6TE
         B7SqMbr/Ojxp8cUse+xC1beu3taSEi2TmtL3tMOKDzngwQF0Fgh/GUl48RnTi/wOFdQ2
         h/0p3ZDmCh78wSLi4KbqxGJzNG3+xg0V/pesZNiQven6V2/epFsn+vQZdOc/cp36FL4l
         QXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71uR/HEov5DHYjQr21uUwUAdHQnBZ2QO6kQLmE+g0jc=;
        b=N4f3hLNhV+3aot+oXLkTHcSAKX99Ys1K+ni4ZkPxbYBpIuM0f0G+nMmrdKYLNvNPfL
         vi0M8oxCLapzbejyhw47sVNKd07uhh6DtdbPaRXoLu68A0O7DsmQDGhai75LoU0I9AEm
         Oeq+9i20s0t+fEklPb/PM43XYhWmXEocl3XNAGVKotK2LnB4JEC/opd4KFo0SDYOSTWG
         xMizHIBkgRUVw95K7PUtYtRRapv+j9pSujWhBOpNWnHsy63SamZCimAegJmlbmZkJUcE
         /UlHd+oHfn5VsNG5RzYTfOSQzW2KCCtk9vNjlT64jcwgUsicdq9JxXlKf5zeOPR1Sa9z
         y6EQ==
X-Gm-Message-State: AFqh2krB5FvLqkqNkK5s/EHgRQR+upCqHEISx87YAClOZy5paqmKpOyI
        zt+zNQa/cwkxH+gZSYk1LfIWAAggB2FDkls65A8=
X-Google-Smtp-Source: AMrXdXuZiMMaI6GQr60G7R1W1fg8EVNZ3MW70Kcq0hYkEwHQj7d791HP/UVwtN2jDqJDim8CfbzLgz071fchF4CvjZM=
X-Received: by 2002:a05:6512:12c8:b0:4cc:98fe:1917 with SMTP id
 p8-20020a05651212c800b004cc98fe1917mr785704lfg.650.1673784295630; Sun, 15 Jan
 2023 04:04:55 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
 <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
 <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
 <CA+icZUUhY7-F5Bpw-jxofhw4nMP3nzyfpt9huzeSWwUguguNsA@mail.gmail.com> <Y8NIYSMqAk7BhSv5@casper.infradead.org>
In-Reply-To: <Y8NIYSMqAk7BhSv5@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 15 Jan 2023 13:04:18 +0100
Message-ID: <CA+icZUV6usk0KOsK=xQSVp0TQmrsx_ELkc3tWjCBFFnUjAO_Vw@mail.gmail.com>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs cpu_relax)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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

On Sun, Jan 15, 2023 at 1:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jan 14, 2023 at 12:28:30PM +0100, Sedat Dilek wrote:
> > [ ... ]
> >
> > > Best is to ask the Debian release-team or (if there exist) maintainers
> > > or responsibles for the IA64 port - which is an ***unofficial*** port.
> > >
> >
> > Here we go:
> >
> > https://lists.debian.org/debian-ia64/
> >
> > Posting address: debian-ia64@lists.debian.org
> >
> > Found via <https://lists.debian.org/completeindex.html>
>
> More useful perhaps is to look at https://popcon.debian.org/
>
> There are three machines reporting popcon results.  It's dead.

Exactly, Debian Popularity Contest was what I was looking for yesterday.

Thanks Matthew.

[1] says in Inst (204701):

Name                              || Number  || %
==================================
binutils-x86-64-linux-gnu || 101548  || 49.61%
binutils-ia64-linux-gnu     ||          11  || 0.01%

HELP: Inst. is the number of people who installed this package (sum of
the four categories below)

There may be more popular packages than binutils.
( binutils might tell something about development happening or not. )

Anyway, I am not a popcon expert and never participated in Debian's
Popularity Contest.

-Sedat-

[1] https://qa.debian.org/popcon.php?package=binutils
