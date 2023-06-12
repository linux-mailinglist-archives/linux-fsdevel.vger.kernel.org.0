Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8729D72CB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFLQPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbjFLQPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:15:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEA1BCA;
        Mon, 12 Jun 2023 09:14:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so53017581fa.0;
        Mon, 12 Jun 2023 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586487; x=1689178487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKPFSSH+caxQHaov+Wv+3EHEkLI7Kcu9oYB4YOFV98c=;
        b=nA2kSdpXP2aia/RhBgkUf2KODbJBICe97+67Y2LVx1SjZg+SHpRQkHOqP2hMOvdnO8
         FcysiW3xuywRNWp8vhCHePMVuZYrhNuhLVvnAFAFAqpw+eLfYMrlMfu7bS5tgdWzAy3S
         mi/kZ54fxizGcQtwjCf4Jh3ZtieeTyF5bhcj4ujw+KcV/TMIRzKVfso4ZUnX/oYIdqyG
         /A7SnUEmOCN0QLgAC+iSLrfcyhQJmhwO/TtsqaohxoHlOjLFUxLJPuwLD4BJKGuplhZs
         11qbFmDqL8dcbAR3YxmBjYhnvUG7oRcBlRQwggE5fJcZoPYnKymcmqP3q7BfGAW1C8uf
         aang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586487; x=1689178487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKPFSSH+caxQHaov+Wv+3EHEkLI7Kcu9oYB4YOFV98c=;
        b=bD2MeNkHyGWAR7YBuvlNzEiK6MxiWWL+H4y1lYj7Lhg8hSpBwQh08L0ZsAgegm4O3c
         SL8T20mayVntjzc6e5xN/5iSqhzWyTGjvyi7xPnUWl2xH/ZjK5mr59A/1fK2tP5Xgqz1
         fywNeTKmk6s30vgQXF9ZGOPDMRzxZxDVHQCPibMdrtx3cEro7sWGybTIA4JzbIkVEM93
         9HaZ4osODKRTao5Ke0iv0v/Nx4oFx4ijwR6IWv9U9VMWDoeUOTTqWHRp1OYXNAzkAYV0
         5u8wW7CCooLZ/W0x9qfu4H5pihW/JDkWur5sOzHCUDk8lFdGC43e7JhpHtw+gKufD/1M
         fhYg==
X-Gm-Message-State: AC+VfDyeKtRWIqra/8xlbt10wrrb63pkbExhz+cdxgjqxhuzbr7oceCU
        S/QFQ4X7W7sFqqFLNx7toOtwpwzaOyURhjojPXw=
X-Google-Smtp-Source: ACHHUZ4bACLCVxl9cBUvtK3ZXrgKi3PuHQRL9j1bC7LRMjUBRu/yMZHmGFK8gjZ6HnznjkbRC+YxRBBXDVbFnmRNAwU=
X-Received: by 2002:a2e:8606:0:b0:2b1:e74b:2452 with SMTP id
 a6-20020a2e8606000000b002b1e74b2452mr2969829lji.49.1686586486637; Mon, 12 Jun
 2023 09:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU7Hv71ujeb9oEVOD+bpddMMT0KY+KKUp881Am15u-OVvg@mail.gmail.com>
 <87ilbshf56.fsf@doe.com>
In-Reply-To: <87ilbshf56.fsf@doe.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 12 Jun 2023 18:14:35 +0200
Message-ID: <CAHpGcMKV2KGMnBZsjk9NGFRiORZAdOLwpSjW1spGiZCOdNGCzg@mail.gmail.com>
Subject: Re: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for
 ifs state bitmap
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
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

Am Mo., 12. Juni 2023 um 17:43 Uhr schrieb Ritesh Harjani
<ritesh.list@gmail.com>:
> Andreas Gruenbacher <agruenba@redhat.com> writes:
> > On Sat, Jun 10, 2023 at 1:39=E2=80=AFPM Ritesh Harjani (IBM)
> > <ritesh.list@gmail.com> wrote:
> >> This patch adds two of the helper routines iomap_ifs_is_fully_uptodate=
()
> >> and iomap_ifs_is_block_uptodate() for managing uptodate state of
> >> ifs state bitmap.
> >>
> >> In later patches ifs state bitmap array will also handle dirty state o=
f all
> >> blocks of a folio. Hence this patch adds some helper routines for hand=
ling
> >> uptodate state of the ifs state bitmap.
> >>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
> >>  1 file changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index e237f2b786bc..206808f6e818 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_i=
fs(struct folio *folio)
> >>
> >>  static struct bio_set iomap_ioend_bioset;
> >>
> >> +static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
> >> +                                              struct iomap_folio_stat=
e *ifs)
> >> +{
> >> +       struct inode *inode =3D folio->mapping->host;
> >> +
> >> +       return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio=
));
> >
> > This should be written as something like:
> >
> > unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> > return bitmap_full(ifs->state + IOMAP_ST_UPTODATE * blks_per_folio,
> > blks_per_folio);
> >
>
> Nah, I feel it is not required... It make sense when we have the same
> function getting use for both "uptodate" and "dirty" state.
> Here the function anyways operates on uptodate state.
> Hence I feel it is not required.

So we have this iomap_block_state enum now, but IOMAP_ST_UPTODATE must
be 0 or else the code will break. That's worse than not having this
abstraction in the first place because.

Andreas

> >> +}
> >> +
> >> +static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_sta=
te *ifs,
> >> +                                              unsigned int block)
> >> +{
> >> +       return test_bit(block, ifs->state);
> >
> > This function should be called iomap_ifs_block_is_uptodate(), and
> > probably be written as follows, passing in the folio as well (this
> > will optimize out, anyway):
> >
> > struct inode *inode =3D folio->mapping->host;
> > unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> > return test_bit(block, ifs->state + IOMAP_ST_UPTODATE * blks_per_folio)=
;
> >
>
> Same here.
>
> -ritesh
