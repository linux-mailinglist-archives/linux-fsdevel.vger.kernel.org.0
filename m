Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C25499F86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 00:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841425AbiAXW7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 17:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839094AbiAXWtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:49:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329FC08ED73
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jan 2022 13:07:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so24979517ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jan 2022 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePWzg4KksjRUDSjqr+o9tEK0DbR7L8NzVM+5lIUlDPo=;
        b=UryOzKtTd2BAlxPDRNgCwCESf13lD5IW6bNOSpBDepFbuH7r9fjbsT6cE5x5Ghft6m
         mvPNVWtkz01mVJrSqeC/gB7JTH8T6qFvFS/VnIIFZHW5/gP/sOhhcnNoyYhFzrPdUaVF
         FvDL8M4vNuURIqj/n/AdjkvXl39lYlpRohMIl+wO54x442N5Kx3ijGlQ972NHhWQkaPM
         2PB2Ht3BymPWofX9NOCMsDhYcC+73YD1E+ldRp1Zbpzgc9ITLFFrLh5PDvAi6v8hFREw
         ZBIZaScnPoiVR8zI3lCx6RkrB7DD23Vmu/ZR3nC2SK8GmSX6IQ39leUg3dHZiL44CE+y
         QY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePWzg4KksjRUDSjqr+o9tEK0DbR7L8NzVM+5lIUlDPo=;
        b=pWAmb4rH4qLalJgEYByLG5OBi5lZtdaEKqeqH5LSbud7XksE28GnDvduHMV9YSke89
         4/JMrf0JmBs1+GDzvw6wQUVWye6jdwfCw9L0QPuEig/xDAitWkjmCgoE1IUr6GLMiNY9
         /MVM/AQezOGrwdxQvAd/lRyAvc6xUQTWtO0Li+rYZVj/snDddTHGGcOWWTzxwvPYK03J
         eksuPqa5Uog+19Ljo5JFSv+3VvSMfYYX2+OJl3eK9z+7Y8Sn8mfRFyo4v2FlDGXrcpwj
         ciiHmU7pAJGRV5/hO8aD5Cal+B9N+iLGK1Wub1y3JRfrpAW5hqdmC/NPI5/lUkt7Di6X
         XU4Q==
X-Gm-Message-State: AOAM533QyC0Z1AY25vadmLhQA2RfVNvjv/Y/uiZ+TgUGgYSzvAuOroDN
        uqOpi50zL8kZPOd3YLEJxlLnVVP5OE9E+1NmrwssWw==
X-Google-Smtp-Source: ABdhPJxclIDTBsv4yYQkMf2IKJZoaAKnmKikCbThIVE5NKI9QkHybFZsTLU/0wfsssiMKHH11b6mrHEUsG/59h5Yi1w=
X-Received: by 2002:a17:907:1c23:: with SMTP id nc35mr11335786ejc.624.1643058458017;
 Mon, 24 Jan 2022 13:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20220124091107.642561-1-hch@lst.de> <20220124091107.642561-12-hch@lst.de>
In-Reply-To: <20220124091107.642561-12-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 24 Jan 2022 22:07:26 +0100
Message-ID: <CAMGffEknV3j8nm__Bc_q7QUra+MV2kj-CMcq8O2ZdEK+B3om_Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] rnbd-srv: remove struct rnbd_dev_blk_io
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only the priv field of rnbd_dev_blk_io is used, so store the value of
> that in bio->bi_private directly and remove the entire bio_set overhead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Thanks!
> ---
>  drivers/block/rnbd/rnbd-srv-dev.c |  4 +---
>  drivers/block/rnbd/rnbd-srv-dev.h | 13 ++-----------
>  drivers/block/rnbd/rnbd-srv.c     | 27 ++++-----------------------
>  drivers/block/rnbd/rnbd-srv.h     |  1 -
>  4 files changed, 7 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
> index 98d3e591a0885..c5d0a03911659 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.c
> +++ b/drivers/block/rnbd/rnbd-srv-dev.c
> @@ -12,8 +12,7 @@
>  #include "rnbd-srv-dev.h"
>  #include "rnbd-log.h"
>
> -struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
> -                              struct bio_set *bs)
> +struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags)
>  {
>         struct rnbd_dev *dev;
>         int ret;
> @@ -30,7 +29,6 @@ struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
>
>         dev->blk_open_flags = flags;
>         bdevname(dev->bdev, dev->name);
> -       dev->ibd_bio_set = bs;
>
>         return dev;
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index 1a14ece0be726..2c3df02b5e8ec 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -14,25 +14,16 @@
>
>  struct rnbd_dev {
>         struct block_device     *bdev;
> -       struct bio_set          *ibd_bio_set;
>         fmode_t                 blk_open_flags;
>         char                    name[BDEVNAME_SIZE];
>  };
>
> -struct rnbd_dev_blk_io {
> -       struct rnbd_dev *dev;
> -       void             *priv;
> -       /* have to be last member for front_pad usage of bioset_init */
> -       struct bio      bio;
> -};
> -
>  /**
>   * rnbd_dev_open() - Open a device
> + * @path:      path to open
>   * @flags:     open flags
> - * @bs:                bio_set to use during block io,
>   */
> -struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
> -                              struct bio_set *bs);
> +struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags);
>
>  /**
>   * rnbd_dev_close() - Close a device
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 6d228af1dcc35..ff9b389976078 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -116,9 +116,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
>
>  static void rnbd_dev_bi_end_io(struct bio *bio)
>  {
> -       struct rnbd_dev_blk_io *io = bio->bi_private;
> -
> -       rnbd_endio(io->priv, blk_status_to_errno(bio->bi_status));
> +       rnbd_endio(bio->bi_private, blk_status_to_errno(bio->bi_status));
>         bio_put(bio);
>  }
>
> @@ -131,7 +129,6 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>         struct rnbd_srv_sess_dev *sess_dev;
>         u32 dev_id;
>         int err;
> -       struct rnbd_dev_blk_io *io;
>         struct bio *bio;
>         short prio;
>
> @@ -152,7 +149,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>         priv->sess_dev = sess_dev;
>         priv->id = id;
>
> -       bio = bio_alloc_bioset(GFP_KERNEL, 1, sess_dev->rnbd_dev->ibd_bio_set);
> +       bio = bio_alloc(GFP_KERNEL, 1);
>         if (bio_add_page(bio, virt_to_page(data), datalen,
>                         offset_in_page(data)) != datalen) {
>                 rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
> @@ -160,12 +157,8 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>                 goto bio_put;
>         }
>
> -       io = container_of(bio, struct rnbd_dev_blk_io, bio);
> -       io->dev = sess_dev->rnbd_dev;
> -       io->priv = priv;
> -
>         bio->bi_end_io = rnbd_dev_bi_end_io;
> -       bio->bi_private = io;
> +       bio->bi_private = priv;
>         bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
>         bio->bi_iter.bi_sector = le64_to_cpu(msg->sector);
>         bio->bi_iter.bi_size = le32_to_cpu(msg->bi_size);
> @@ -260,7 +253,6 @@ static void destroy_sess(struct rnbd_srv_session *srv_sess)
>
>  out:
>         xa_destroy(&srv_sess->index_idr);
> -       bioset_exit(&srv_sess->sess_bio_set);
>
>         pr_info("RTRS Session %s disconnected\n", srv_sess->sessname);
>
> @@ -289,16 +281,6 @@ static int create_sess(struct rtrs_srv_sess *rtrs)
>                 return -ENOMEM;
>
>         srv_sess->queue_depth = rtrs_srv_get_queue_depth(rtrs);
> -       err = bioset_init(&srv_sess->sess_bio_set, srv_sess->queue_depth,
> -                         offsetof(struct rnbd_dev_blk_io, bio),
> -                         BIOSET_NEED_BVECS);
> -       if (err) {
> -               pr_err("Allocating srv_session for path %s failed\n",
> -                      pathname);
> -               kfree(srv_sess);
> -               return err;
> -       }
> -
>         xa_init_flags(&srv_sess->index_idr, XA_FLAGS_ALLOC);
>         INIT_LIST_HEAD(&srv_sess->sess_dev_list);
>         mutex_init(&srv_sess->lock);
> @@ -747,8 +729,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>                 goto reject;
>         }
>
> -       rnbd_dev = rnbd_dev_open(full_path, open_flags,
> -                                &srv_sess->sess_bio_set);
> +       rnbd_dev = rnbd_dev_open(full_path, open_flags);
>         if (IS_ERR(rnbd_dev)) {
>                 pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %ld\n",
>                        full_path, srv_sess->sessname, PTR_ERR(rnbd_dev));
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> index e5604bce123ab..be2ae486d407e 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -23,7 +23,6 @@ struct rnbd_srv_session {
>         struct rtrs_srv_sess    *rtrs;
>         char                    sessname[NAME_MAX];
>         int                     queue_depth;
> -       struct bio_set          sess_bio_set;
>
>         struct xarray           index_idr;
>         /* List of struct rnbd_srv_sess_dev */
> --
> 2.30.2
>
