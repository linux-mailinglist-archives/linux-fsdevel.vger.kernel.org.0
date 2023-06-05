Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121072328B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjFEVuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 17:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFEVux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:50:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BDF2;
        Mon,  5 Jun 2023 14:50:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso64098251fa.2;
        Mon, 05 Jun 2023 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686001850; x=1688593850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgVh6B4b5d1xPtyx1HecTGbQCfb0JPACDmuJc8CU3yk=;
        b=Wuof9leEUkarR2buAsXGIzBHMvIBP2NXL3SOMe7sSmUo9T+/W6lcWeCKr8RmlWtpW2
         Cos4OjtKj6qT5kSLpYloMKAgwimpDczd4kKrSNk3ggLs97m8jHUB+jZGZAOxe1wUJQPz
         Gz8V9MReoz3B0qZviKwQ4t+nFK+7a72hXpHp03jb17WAnvvGf1fNkZnfdzKFtpBGA2Gh
         1EkGRYuXO+v1gL1lN7DdvkMFsuI4vXdkqjBJ1xgZbSn4bG2wCxe3Hqq8z54G7czdvKCA
         wdsjsSg0eHO8mMqfv5bJgQSoWG1M1Q7oFSoGtKKsTaUh9WITkAovqDuUrUa/6KUAEva/
         RMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001850; x=1688593850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgVh6B4b5d1xPtyx1HecTGbQCfb0JPACDmuJc8CU3yk=;
        b=YuG/GvjpNx+TLh+DH7NI308cAinhBVwkgtjLh5gsFP/s5vdCSv/uR3ebjq7N/v1nr0
         vTCYJzZdEslltb9ca2pX7xx3cwWuutlkB311vm1WiIWzOkbVbSMMsc6LhAWTrh4JynMu
         hHeuKdfECzVfBSmhD9DmqyGDIdzlsyvDIPtLOgsIy4vDytimy0IxQQ/Jj+w4g5Xayt2E
         2eqeGTGdAw9JrscdVC+Vwpc2/flzNIAqrd9L3gjm1CXyLsb/BwuaqFaDkISoH9jtQwXy
         ahU8upGpLgNgv7pPweD6CiACmghx6cc6MThO9r8b6J4d/JTMIvC+ZDN5UXmce4kmDWWu
         zNoA==
X-Gm-Message-State: AC+VfDwu0PhXz9LjuG2VGRP9EjR6eOAzAAvTErw6+eZgTNiaWtyRR1i6
        FTTs58Dgq/40wSyqfLVAuxVlgtjIa2zD1SFwEqg=
X-Google-Smtp-Source: ACHHUZ7tjnGAcKbFxVovJXgOzw0tUQxxKYswQxnid+gWoGnZ+ObVi0VX+vlawUMOLPq0gbGKUZtQcincap4XuICvDi4=
X-Received: by 2002:a2e:b16f:0:b0:2b1:d19a:f190 with SMTP id
 a15-20020a2eb16f000000b002b1d19af190mr235764ljm.49.1686001849607; Mon, 05 Jun
 2023 14:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU7xZaDAnmQ5UhO=MCnW_nGV2WNs93=PTAoVWCYuSCnrAQ@mail.gmail.com>
 <87pm69k4kf.fsf@doe.com>
In-Reply-To: <87pm69k4kf.fsf@doe.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 5 Jun 2023 23:50:38 +0200
Message-ID: <CAHpGcM+kYGwh2AQNhThQYwLRzcwL_v+iWqbD7k+vyhfGz=sjtg@mail.gmail.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 5. Juni 2023 um 23:05 Uhr schrieb Ritesh Harjani
<ritesh.list@gmail.com>:
> Andreas Gruenbacher <agruenba@redhat.com> writes:
> > On Mon, Jun 5, 2023 at 12:55=E2=80=AFPM Ritesh Harjani (IBM) <ritesh.li=
st@gmail.com> wrote:
> >> We would eventually use iomap_iop_** function naming by the rest of th=
e
> >> buffered-io iomap code. This patch update function arguments and namin=
g
> >> from iomap_set_range_uptodate() -> iomap_iop_set_range_uptodate().
> >> iop_set_range_uptodate() then becomes an accessor function used by
> >> iomap_iop_** functions.
> >>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/iomap/buffered-io.c | 111 +++++++++++++++++++++++-----------------=
-
> >>  1 file changed, 63 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 6fffda355c45..136f57ccd0be 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -24,14 +24,14 @@
> >>  #define IOEND_BATCH_SIZE       4096
> >>
> >>  /*
> >> - * Structure allocated for each folio when block size < folio size
> >> - * to track sub-folio uptodate status and I/O completions.
> >> + * Structure allocated for each folio to track per-block uptodate sta=
te
> >> + * and I/O completions.
> >>   */
> >>  struct iomap_page {
> >>         atomic_t                read_bytes_pending;
> >>         atomic_t                write_bytes_pending;
> >> -       spinlock_t              uptodate_lock;
> >> -       unsigned long           uptodate[];
> >> +       spinlock_t              state_lock;
> >> +       unsigned long           state[];
> >>  };
> >>
> >>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
> >> @@ -43,6 +43,48 @@ static inline struct iomap_page *to_iomap_page(stru=
ct folio *folio)
> >>
> >>  static struct bio_set iomap_ioend_bioset;
> >>
> >> +static bool iop_test_full_uptodate(struct folio *folio)
> >> +{
> >> +       struct iomap_page *iop =3D to_iomap_page(folio);
> >> +       struct inode *inode =3D folio->mapping->host;
> >> +
> >> +       return bitmap_full(iop->state, i_blocks_per_folio(inode, folio=
));
> >> +}
> >
> > Can this be called iop_test_fully_uptodate(), please?
> >
>
> IMHO, iop_test_full_uptodate() looks fine. It goes similar to
> bitmap_full() function.

Nah, it really isn't fine, it's "the bitmap is full" vs. "the iop is
fully uptodate"; you can't say "the iop is full uptodate".

Thanks,
Andreas
