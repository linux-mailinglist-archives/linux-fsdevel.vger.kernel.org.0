Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12352722897
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjFEORN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjFEOQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5755E58
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685974547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DkdjkZWlqpOSQQRzq31kjhMhTMi6RVAa/rU1qaw3gM=;
        b=cs2BlpaT3xFTrRSSPu+7a2elVIHxeAZWF2Npb9HXz+Ypxzc/sVCTLbBDrCI3DdvV9RE4Gw
        o3eQfcoPx8z7gk7zHbVsku9YF4tSWJYZW7zWQAEOO7udb4p07d9jhw92gbJOpTyXv57XJt
        ZWpcazR+XLO0Y6ETkO2bspaEnLmPt1I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-nOLEIPwcOq-FEIE7Ufhlug-1; Mon, 05 Jun 2023 10:15:45 -0400
X-MC-Unique: nOLEIPwcOq-FEIE7Ufhlug-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b0116fef51so18844725ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 07:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685974544; x=1688566544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DkdjkZWlqpOSQQRzq31kjhMhTMi6RVAa/rU1qaw3gM=;
        b=I6l+Gf3SA6rSpa/OPMZhZWda9pYuTtq8b8Q9r5WpOgaVyXJYgw1jwQMdU9i4xYGjcn
         Un3qePEYKo4swsFiIun3vALS/QeYDi7SuuiCnbqIXmbcKX8IAL0NeLfaty4lVY5f6yjJ
         ZhKECwvNxgf22m254+0RbieOvWq90tnjENBFwuv2X+9TZFSUCPji1i4fr4LAWcVZgU0D
         fD+UurCbACPisG7++zS7ujoL01FvGpFOJS9JFs8U2aSYmrgGr3LwfOpCqotRS1gxC3ym
         0EE9VDTm2mcRKHBb9AQqsZ5qyvn/Injt75wLtHYz2n58DAwS/vjn1ePetqsMiklpv4s3
         +i0A==
X-Gm-Message-State: AC+VfDy2aZkJkTAMC1LGhf5apTjDz9owGE7mm57A9pUuUiOeF8bsZ3JH
        zoJzSu8pjp+wV42qCrFSozXlfAsTit/rY3HpzG3t2M/RZD9AuxwpWCEiTD4jdGt5+SmjNHujK2n
        HsAfZcRL4a4wQ5A8fEXAspVPWEzMdSNhQ32HdFgDENg==
X-Received: by 2002:a17:902:c14d:b0:1b0:577c:2d1 with SMTP id 13-20020a170902c14d00b001b0577c02d1mr3041954plj.31.1685974544222;
        Mon, 05 Jun 2023 07:15:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BkD2vqkMcyt1frJRl0gFOs7X+OAtaIDMgW+d5VUhWYocpMLMyJfzDnGxaLQ0F+DHH3hJvGA6m2DNYP0H4ujY=
X-Received: by 2002:a17:902:c14d:b0:1b0:577c:2d1 with SMTP id
 13-20020a170902c14d00b001b0577c02d1mr3041925plj.31.1685974543831; Mon, 05 Jun
 2023 07:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685962158.git.ritesh.list@gmail.com> <4fe4937718d44c89e0c279175c65921717d9f591.1685962158.git.ritesh.list@gmail.com>
In-Reply-To: <4fe4937718d44c89e0c279175c65921717d9f591.1685962158.git.ritesh.list@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 5 Jun 2023 16:15:31 +0200
Message-ID: <CAHc6FU7xZaDAnmQ5UhO=MCnW_nGV2WNs93=PTAoVWCYuSCnrAQ@mail.gmail.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 5, 2023 at 12:55=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
> We would eventually use iomap_iop_** function naming by the rest of the
> buffered-io iomap code. This patch update function arguments and naming
> from iomap_set_range_uptodate() -> iomap_iop_set_range_uptodate().
> iop_set_range_uptodate() then becomes an accessor function used by
> iomap_iop_** functions.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 111 +++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 48 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6fffda355c45..136f57ccd0be 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -24,14 +24,14 @@
>  #define IOEND_BATCH_SIZE       4096
>
>  /*
> - * Structure allocated for each folio when block size < folio size
> - * to track sub-folio uptodate status and I/O completions.
> + * Structure allocated for each folio to track per-block uptodate state
> + * and I/O completions.
>   */
>  struct iomap_page {
>         atomic_t                read_bytes_pending;
>         atomic_t                write_bytes_pending;
> -       spinlock_t              uptodate_lock;
> -       unsigned long           uptodate[];
> +       spinlock_t              state_lock;
> +       unsigned long           state[];
>  };
>
>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
> @@ -43,6 +43,48 @@ static inline struct iomap_page *to_iomap_page(struct =
folio *folio)
>
>  static struct bio_set iomap_ioend_bioset;
>
> +static bool iop_test_full_uptodate(struct folio *folio)
> +{
> +       struct iomap_page *iop =3D to_iomap_page(folio);
> +       struct inode *inode =3D folio->mapping->host;
> +
> +       return bitmap_full(iop->state, i_blocks_per_folio(inode, folio));
> +}

Can this be called iop_test_fully_uptodate(), please?

> +
> +static bool iop_test_block_uptodate(struct folio *folio, unsigned int bl=
ock)
> +{
> +       struct iomap_page *iop =3D to_iomap_page(folio);
> +
> +       return test_bit(block, iop->state);
> +}
> +
> +static void iop_set_range_uptodate(struct inode *inode, struct folio *fo=
lio,
> +                                  size_t off, size_t len)
> +{
> +       struct iomap_page *iop =3D to_iomap_page(folio);

Note that to_iomap_page() does folio_test_private() followed by
folio_get_private(), which doesn't really make sense in places where
we know that iop is defined. Maybe we want to split that up.

> +       unsigned int first_blk =3D off >> inode->i_blkbits;
> +       unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
> +       unsigned int nr_blks =3D last_blk - first_blk + 1;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&iop->state_lock, flags);
> +       bitmap_set(iop->state, first_blk, nr_blks);
> +       if (iop_test_full_uptodate(folio))
> +               folio_mark_uptodate(folio);
> +       spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_iop_set_range_uptodate(struct inode *inode,
> +               struct folio *folio, size_t off, size_t len)
> +{
> +       struct iomap_page *iop =3D to_iomap_page(folio);
> +
> +       if (iop)
> +               iop_set_range_uptodate(inode, folio, off, len);
> +       else
> +               folio_mark_uptodate(folio);
> +}

This patch passes the inode into iomap_iop_set_range_uptodate() and
removes the iop argument. Can this be done in a separate patch,
please?

We have a few places like the above, where we look up the iop without
using it. Would a function like folio_has_iop() make more sense?

> +
>  static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>                                 struct folio *folio, unsigned int flags)
>  {
> @@ -58,12 +100,12 @@ static struct iomap_page *iomap_iop_alloc(struct ino=
de *inode,
>         else
>                 gfp =3D GFP_NOFS | __GFP_NOFAIL;
>
> -       iop =3D kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_block=
s)),
> +       iop =3D kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks))=
,
>                       gfp);
>         if (iop) {
> -               spin_lock_init(&iop->uptodate_lock);
> +               spin_lock_init(&iop->state_lock);
>                 if (folio_test_uptodate(folio))
> -                       bitmap_fill(iop->uptodate, nr_blocks);
> +                       bitmap_fill(iop->state, nr_blocks);
>                 folio_attach_private(folio, iop);
>         }
>         return iop;
> @@ -72,14 +114,12 @@ static struct iomap_page *iomap_iop_alloc(struct ino=
de *inode,
>  static void iomap_iop_free(struct folio *folio)
>  {
>         struct iomap_page *iop =3D to_iomap_page(folio);
> -       struct inode *inode =3D folio->mapping->host;
> -       unsigned int nr_blocks =3D i_blocks_per_folio(inode, folio);
>
>         if (!iop)
>                 return;
>         WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>         WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> -       WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=3D
> +       WARN_ON_ONCE(iop_test_full_uptodate(folio) !=3D
>                         folio_test_uptodate(folio));
>         folio_detach_private(folio);
>         kfree(iop);
> @@ -111,7 +151,7 @@ static void iomap_adjust_read_range(struct inode *ino=
de, struct folio *folio,
>
>                 /* move forward for each leading block marked uptodate */
>                 for (i =3D first; i <=3D last; i++) {
> -                       if (!test_bit(i, iop->uptodate))
> +                       if (!iop_test_block_uptodate(folio, i))
>                                 break;
>                         *pos +=3D block_size;
>                         poff +=3D block_size;
> @@ -121,7 +161,7 @@ static void iomap_adjust_read_range(struct inode *ino=
de, struct folio *folio,
>
>                 /* truncate len if we find any trailing uptodate block(s)=
 */
>                 for ( ; i <=3D last; i++) {
> -                       if (test_bit(i, iop->uptodate)) {
> +                       if (iop_test_block_uptodate(folio, i)) {
>                                 plen -=3D (last - i + 1) * block_size;
>                                 last =3D i - 1;
>                                 break;
> @@ -145,30 +185,6 @@ static void iomap_adjust_read_range(struct inode *in=
ode, struct folio *folio,
>         *lenp =3D plen;
>  }
>
> -static void iomap_iop_set_range_uptodate(struct folio *folio,
> -               struct iomap_page *iop, size_t off, size_t len)
> -{
> -       struct inode *inode =3D folio->mapping->host;
> -       unsigned first =3D off >> inode->i_blkbits;
> -       unsigned last =3D (off + len - 1) >> inode->i_blkbits;
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&iop->uptodate_lock, flags);
> -       bitmap_set(iop->uptodate, first, last - first + 1);
> -       if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
> -               folio_mark_uptodate(folio);
> -       spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> -}
> -
> -static void iomap_set_range_uptodate(struct folio *folio,
> -               struct iomap_page *iop, size_t off, size_t len)
> -{
> -       if (iop)
> -               iomap_iop_set_range_uptodate(folio, iop, off, len);
> -       else
> -               folio_mark_uptodate(folio);
> -}
> -
>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>                 size_t len, int error)
>  {
> @@ -178,7 +194,8 @@ static void iomap_finish_folio_read(struct folio *fol=
io, size_t offset,
>                 folio_clear_uptodate(folio);
>                 folio_set_error(folio);
>         } else {
> -               iomap_set_range_uptodate(folio, iop, offset, len);
> +               iomap_iop_set_range_uptodate(folio->mapping->host, folio,
> +                                            offset, len);
>         }
>
>         if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
> @@ -214,7 +231,6 @@ struct iomap_readpage_ctx {
>  static int iomap_read_inline_data(const struct iomap_iter *iter,
>                 struct folio *folio)
>  {
> -       struct iomap_page *iop;
>         const struct iomap *iomap =3D iomap_iter_srcmap(iter);
>         size_t size =3D i_size_read(iter->inode) - iomap->offset;
>         size_t poff =3D offset_in_page(iomap->offset);
> @@ -232,15 +248,14 @@ static int iomap_read_inline_data(const struct ioma=
p_iter *iter,
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
>         if (offset > 0)
> -               iop =3D iomap_iop_alloc(iter->inode, folio, iter->flags);
> -       else
> -               iop =3D to_iomap_page(folio);
> +               iomap_iop_alloc(iter->inode, folio, iter->flags);
>
>         addr =3D kmap_local_folio(folio, offset);
>         memcpy(addr, iomap->inline_data, size);
>         memset(addr + size, 0, PAGE_SIZE - poff - size);
>         kunmap_local(addr);
> -       iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
> +       iomap_iop_set_range_uptodate(iter->inode, folio, offset,
> +                                    PAGE_SIZE - poff);
>         return 0;
>  }
>
> @@ -277,7 +292,7 @@ static loff_t iomap_readpage_iter(const struct iomap_=
iter *iter,
>
>         if (iomap_block_needs_zeroing(iter, pos)) {
>                 folio_zero_range(folio, poff, plen);
> -               iomap_set_range_uptodate(folio, iop, poff, plen);
> +               iomap_iop_set_range_uptodate(iter->inode, folio, poff, pl=
en);
>                 goto done;
>         }
>
> @@ -452,7 +467,7 @@ bool iomap_is_partially_uptodate(struct folio *folio,=
 size_t from, size_t count)
>         last =3D (from + count - 1) >> inode->i_blkbits;
>
>         for (i =3D first; i <=3D last; i++)
> -               if (!test_bit(i, iop->uptodate))
> +               if (!iop_test_block_uptodate(folio, i))
>                         return false;
>         return true;
>  }
> @@ -591,7 +606,7 @@ static int __iomap_write_begin(const struct iomap_ite=
r *iter, loff_t pos,
>                         if (status)
>                                 return status;
>                 }
> -               iomap_set_range_uptodate(folio, iop, poff, plen);
> +               iomap_iop_set_range_uptodate(iter->inode, folio, poff, pl=
en);
>         } while ((block_start +=3D plen) < block_end);
>
>         return 0;
> @@ -698,7 +713,6 @@ static int iomap_write_begin(struct iomap_iter *iter,=
 loff_t pos,
>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t =
len,
>                 size_t copied, struct folio *folio)
>  {
> -       struct iomap_page *iop =3D to_iomap_page(folio);
>         flush_dcache_folio(folio);
>
>         /*
> @@ -714,7 +728,8 @@ static size_t __iomap_write_end(struct inode *inode, =
loff_t pos, size_t len,
>          */
>         if (unlikely(copied < len && !folio_test_uptodate(folio)))
>                 return 0;
> -       iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos),=
 len);
> +       iomap_iop_set_range_uptodate(inode, folio, offset_in_folio(folio,=
 pos),
> +                                    len);
>         filemap_dirty_folio(inode->i_mapping, folio);
>         return copied;
>  }
> @@ -1630,7 +1645,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc=
,
>          * invalid, grab a new one.
>          */
>         for (i =3D 0; i < nblocks && pos < end_pos; i++, pos +=3D len) {
> -               if (iop && !test_bit(i, iop->uptodate))
> +               if (iop && !iop_test_block_uptodate(folio, i))
>                         continue;
>
>                 error =3D wpc->ops->map_blocks(wpc, inode, pos);
> --
> 2.40.1
>

Thanks,
Andreas

