Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC4721D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 07:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFEFU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFEFU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:20:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1239B7;
        Sun,  4 Jun 2023 22:20:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so688617466b.3;
        Sun, 04 Jun 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685942424; x=1688534424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJqOJ4TGS4+/9SuggMaeRjtiR+OGYGSKJJE+bQYPCaA=;
        b=ZQYAYZiIPqH7NtGQq4WEBtwCju7zpA0e2lR7XMFduHauproREh7guxD10tfA6pMW46
         ZclhcVjOMbAs091FKICmaZ2U4EgYIwZyI2Ol+XUTaI/PYmx077z3bTeTy9UBQaY1YN9W
         q4OT3U9Jfrp0rCJ7bhlS3Ye/rZcmsxXWqfh0MF8wM2I7ehG8xDpQZUgcu+QDljEfdG8c
         twn+Jat8hWwZfSNqfWoOgSLu1tE1ax4aXahGy6x93CGMz5KYDWin4rj/fmwHKvKBp7PP
         fzoznKpJfOu98v6iILtyM4CkpNCd+vaB6Ygb/Xz0XXShj2XXp4jIB61zsJ7s6TdeYM9m
         sVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685942424; x=1688534424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJqOJ4TGS4+/9SuggMaeRjtiR+OGYGSKJJE+bQYPCaA=;
        b=DRkj28lcYjrtkLavl3QdYD1Ld3VI+/EtcUoxNt6/4+qaISNVlGTrUt2+Hi7vmjGL8Q
         yeimcDWm5VRrnrH6I6FpNl4rOwP4lQfJHgEJj5i3Q0jFmLDGgH6NFzEVYIjkfRKtRb9S
         20SezDFWGVLQ+xkWjqtuqmbeksuFups5oKPiGQrw3rrlPeoxDILU9EfZb9k6GOA6c913
         kBm4esM2xThfRNfUEM9Va8VqPCxCU0Do6KkpgrhK2aap6ii0IQ4ZPqfdT1uc4B5l2l9t
         Vf9PLInHEoXdm9cS122K3WYIQVagJNSREBTXnlABDZJBvDqJHNcduuLFLBAiuWwZ3ucF
         00Tw==
X-Gm-Message-State: AC+VfDyFFpxPWtxaTUyEW/RgUvf2Vpgol0dE3paqPsH91z9AKLLP9Xpo
        Rm+SapE2DJ6d1y6ny0y1pISPgpPHmRGl7MrrdLo=
X-Google-Smtp-Source: ACHHUZ4Syx1eaMiJ3JdN84+O2NXyf7KrmlCP0ixBqE8lnvg+YsarUc+rZTquZRWWYaB2quOOhBHqMxb7Xxf5XBIL+fQ=
X-Received: by 2002:a17:907:6d86:b0:957:2e48:5657 with SMTP id
 sb6-20020a1709076d8600b009572e485657mr6041580ejc.68.1685942424175; Sun, 04
 Jun 2023 22:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685900733.git.ritesh.list@gmail.com> <c38a4081e762e38b8fc4c0a54d848741d28d7455.1685900733.git.ritesh.list@gmail.com>
 <ZH1elxw5ddP+bjEa@casper.infradead.org>
In-Reply-To: <ZH1elxw5ddP+bjEa@casper.infradead.org>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Date:   Mon, 5 Jun 2023 10:50:13 +0530
Message-ID: <CALk7dXpVwwmT5v3bS10OZRFTq3bGqnC7e6DhoXyEOz5y_-Xrqg@mail.gmail.com>
Subject: Re: [PATCHv6 5/5] iomap: Add per-block dirty state tracking to
 improve performance
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
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

On Mon, Jun 5, 2023 at 9:33=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Jun 05, 2023 at 07:01:52AM +0530, Ritesh Harjani (IBM) wrote:
> > +static void iop_set_range_dirty(struct inode *inode, struct folio *fol=
io,
> > +                             size_t off, size_t len)
> > +{
> > +     struct iomap_page *iop =3D to_iomap_page(folio);
> > +     unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> > +     unsigned int first_blk =3D off >> inode->i_blkbits;
> > +     unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
> > +     unsigned int nr_blks =3D last_blk - first_blk + 1;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&iop->state_lock, flags);
> > +     bitmap_set(iop->state, first_blk + blks_per_folio, nr_blks);
> > +     spin_unlock_irqrestore(&iop->state_lock, flags);
> > +}
> > +
> > +static void iomap_iop_set_range_dirty(struct inode *inode, struct foli=
o *folio,
> > +                             size_t off, size_t len)
> > +{
> > +     struct iomap_page *iop =3D to_iomap_page(folio);
> > +
> > +     if (iop)
> > +             iop_set_range_dirty(inode, folio, off, len);
> > +}
>
> Why are these separate functions?  It'd be much better written as:

It got discussed here [1] on the preference would be to have it in a
separate helper.
[1]: https://lore.kernel.org/linux-xfs/ZGYnzcoGuzWKa7lh@infradead.org/

>
> static void iomap_iop_set_range_dirty(struct inode *inode, struct folio *=
folio,
>                 size_t off, size_t len)
> {
>         struct iomap_page *iop =3D to_iomap_page(folio);
>         unsigned int start, first, last;
>         unsigned long flags;
>
>         if (!iop)
>                 return;
>
>         start =3D i_blocks_per_folio(inode, folio);
>         first =3D off >> inode->i_blkbits;
>         last =3D (off + len - 1) >> inode->i_blkbits;
>
>         spin_lock_irqsave(&iop->state_lock, flags);
>         bitmap_set(iop->state, start + first, last - first + 1);
>         spin_unlock_irqrestore(&iop->state_lock, flags);
> }
>
> > +static void iop_clear_range_dirty(struct inode *inode, struct folio *f=
olio,
> > +                               size_t off, size_t len)
> > +{
> > +     struct iomap_page *iop =3D to_iomap_page(folio);
> > +     unsigned int blks_per_folio =3D i_blocks_per_folio(inode, folio);
> > +     unsigned int first_blk =3D off >> inode->i_blkbits;
> > +     unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
> > +     unsigned int nr_blks =3D last_blk - first_blk + 1;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&iop->state_lock, flags);
> > +     bitmap_clear(iop->state, first_blk + blks_per_folio, nr_blks);
> > +     spin_unlock_irqrestore(&iop->state_lock, flags);
> > +}
> > +
> > +static void iomap_iop_clear_range_dirty(struct inode *inode,
> > +                             struct folio *folio, size_t off, size_t l=
en)
> > +{
> > +     struct iomap_page *iop =3D to_iomap_page(folio);
> > +
> > +     if (iop)
> > +             iop_clear_range_dirty(inode, folio, off, len);
> > +}
>
> Similarly
>
> > +bool iomap_dirty_folio(struct address_space *mapping, struct folio *fo=
lio)
> > +{
> > +     struct iomap_page __maybe_unused *iop;
> > +     struct inode *inode =3D mapping->host;
> > +     size_t len =3D folio_size(folio);
> > +
> > +     iop =3D iomap_iop_alloc(inode, folio, 0);
>
> Why do you keep doing this?  Just throw away the return value from
> iomap_iop_alloc().  Don't clutter the source with the unnecessary
> variable declaration and annotation that it's not used!
>

Sorry, it got leftover. I will quickly fix this.

> > +static int iomap_write_delalloc_punch(struct inode *inode, struct foli=
o *folio,
> > +             loff_t *punch_start_byte, loff_t start_byte, loff_t end_b=
yte,
> > +             int (*punch)(struct inode *inode, loff_t offset, loff_t l=
ength))
> > +{
> > +     struct iomap_page *iop;
> > +     unsigned int first_blk, last_blk, i;
> > +     loff_t last_byte;
> > +     u8 blkbits =3D inode->i_blkbits;
> > +     int ret =3D 0;
> > +
> > +     if (start_byte > *punch_start_byte) {
> > +             ret =3D punch(inode, *punch_start_byte,
> > +                             start_byte - *punch_start_byte);
> > +             if (ret)
> > +                     goto out_err;
> > +     }
> > +     /*
> > +      * When we have per-block dirty tracking, there can be
> > +      * blocks within a folio which are marked uptodate
> > +      * but not dirty. In that case it is necessary to punch
> > +      * out such blocks to avoid leaking any delalloc blocks.
> > +      */
> > +     iop =3D to_iomap_page(folio);
> > +     if (!iop)
> > +             goto skip_iop_punch;
> > +
> > +     last_byte =3D min_t(loff_t, end_byte - 1,
> > +             (folio_next_index(folio) << PAGE_SHIFT) - 1);
> > +     first_blk =3D offset_in_folio(folio, start_byte) >> blkbits;
> > +     last_blk =3D offset_in_folio(folio, last_byte) >> blkbits;
> > +     for (i =3D first_blk; i <=3D last_blk; i++) {
> > +             if (!iop_test_block_dirty(folio, i)) {
> > +                     ret =3D punch(inode, i << blkbits, 1 << blkbits);
> > +                     if (ret)
> > +                             goto out_err;
> > +             }
> > +     }
> > +
> > +skip_iop_punch:
> > +     /*
> > +      * Make sure the next punch start is correctly bound to
> > +      * the end of this data range, not the end of the folio.
> > +      */
> > +     *punch_start_byte =3D min_t(loff_t, end_byte,
> > +                     folio_next_index(folio) << PAGE_SHIFT);
> > +
> > +     return ret;
> > +
> > +out_err:
> > +     folio_unlock(folio);
> > +     folio_put(folio);
> > +     return ret;
> > +
> > +}
> > +
> >  /*
> >   * Scan the data range passed to us for dirty page cache folios. If we=
 find a
> >   * dirty folio, punch out the preceeding range and update the offset f=
rom which
> > @@ -940,26 +1074,9 @@ static int iomap_write_delalloc_scan(struct inode=
 *inode,
> >               }
> >
> >               /* if dirty, punch up to offset */
> > -             if (folio_test_dirty(folio)) {
> > -                     if (start_byte > *punch_start_byte) {
> > -                             int     error;
> > -
> > -                             error =3D punch(inode, *punch_start_byte,
> > -                                             start_byte - *punch_start=
_byte);
> > -                             if (error) {
> > -                                     folio_unlock(folio);
> > -                                     folio_put(folio);
> > -                                     return error;
> > -                             }
> > -                     }
> > -
> > -                     /*
> > -                      * Make sure the next punch start is correctly bo=
und to
> > -                      * the end of this data range, not the end of the=
 folio.
> > -                      */
> > -                     *punch_start_byte =3D min_t(loff_t, end_byte,
> > -                                     folio_next_index(folio) << PAGE_S=
HIFT);
> > -             }
> > +             if (folio_test_dirty(folio))
> > +                     iomap_write_delalloc_punch(inode, folio, punch_st=
art_byte,
> > +                                        start_byte, end_byte, punch);
> >
> >               /* move offset to start of next folio in range */
> >               start_byte =3D folio_next_index(folio) << PAGE_SHIFT;
>
> I'm having trouble following this refactoring + modification.  Perhaps
> I'm just tired.
>

Let me refactor this part out in the next revision.

-ritesh
