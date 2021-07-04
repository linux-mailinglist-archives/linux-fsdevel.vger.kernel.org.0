Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023D23BAF64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 00:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGDWrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 18:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDWrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:47:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4FC061574
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 15:44:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f13so2255301lfh.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGqC5BUSu2ehzvKSXDbnDhJ8xnzNi8pYNcVJXKy8JEU=;
        b=D649w4q4OxkBSA1lvEBQVo/GHPy3qeR5KImijL8NQR+L0JKOAdLHriM8xcL9de098Q
         sRtPfGnSydxT77lUSdmQB+Pz9ADMcoT/ScQKZo9UH7N2VJ/DIVJlvsqtvKSMU181vctn
         kofK7f3zkUHvFWd+Keakq7yRCz+HKhWao3HH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGqC5BUSu2ehzvKSXDbnDhJ8xnzNi8pYNcVJXKy8JEU=;
        b=SuDbsEwUMDb6aj3T+DNLn1GWmgTWBr/A3NxEgYTsX20bTL3OA2eqBI57K+UNECkRUl
         f9PqQHyxgux3ONQvljYTQO3Qi6Rq3eLw4ACfTc7tMUT9cvDp4NnE3JPvluOvNtLmPjtB
         1gtlX+wtJY1/eErRCicId03bRBorJLi/F6Jm3LVjwYn2+c8GtvekiRcafdllof08luwu
         SnBpgfOcM8BGL2PU+5aztBR069n6a4Gm9VYSeOKuedVBByVbC0WSISWBjsZi96BJdSGM
         ry2U7KLGV2j0k1zkrZiFH906SBbMWKF6bKtAcMsX0Cr7W7uTXQ5oU1USH0qRINqmNJVP
         fy1g==
X-Gm-Message-State: AOAM533mMW9PjbHgb1RCrenJ3+xMA3DT8qpdJENMF7Y2ytfmCH8GsyYr
        +A4syUrdZhPg1t4+zEBlYIGlNulWkyBsAXbn
X-Google-Smtp-Source: ABdhPJw7ittndzu2BcdK03A9EF17PX3T3iHvmUdaG6OXTgfnRK5Ke4HFUXvrS7vVf6KsxFnQ3IfjJA==
X-Received: by 2002:a05:6512:3d0a:: with SMTP id d10mr8282083lfv.143.1625438674561;
        Sun, 04 Jul 2021 15:44:34 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i10sm304788ljg.58.2021.07.04.15.44.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 15:44:34 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a6so22042321ljq.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 15:44:33 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr8539760ljp.251.1625438673695;
 Sun, 04 Jul 2021 15:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net> <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
 <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net>
In-Reply-To: <03a15dbd-bdb9-1c72-a5cd-2e6a6d49af2b@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 15:44:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
Message-ID: <CAHk-=whD38FwDPc=gemuS6wNMDxO-PyVbtvcta3qXyO1ROc4EQ@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 4, 2021 at 2:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> How about the following ?
>
>         WARN_ON_ONCE(IS_ENABLED(CONFIG_MMU) && uaccess_kernel());

Nope, that doesn't work either, because there are no-MMU setups that
don't make the same mistake no-mmu arm and m68k do.

Example: xtensa. But afaik also generic-asm/uaccess.h unless the
architecture overrides something.

So this literally seems like just an arm/m68k bug.

         Linus
