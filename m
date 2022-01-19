Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01B4493D3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 16:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbiASPdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 10:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiASPdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:33:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED95C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 07:33:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f17so5343031edw.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ls4oJs6fjZ2al5mHDHmAP430pKGIHTChze7QOzvid0=;
        b=RkLog8m2MYBMRLjnz/lmwOPkWvyatJOpnc2C+SFqCB8A5+CgOtZNqgIcBiMLkIoMyh
         gEr8s1UGmpgpAGNwUfZNYyRI9qEflB+nBcS9X+xsueK5rC4Ez4sCexRGgPhN4+3TFriB
         ojHLQx/So9q0DEpS6wCB+RQONR2hQN+ZDAFsafTmgU6TGyrFxA/6lV1xY4IJet52lmjl
         bSyn079RsjIcJeBi+nhFSujNuqtCPXIfKFb/dYwAiTdrCxy5wjkDmXd+/ZabmuFSO4A1
         5WQvp91C0WXDM8k7HDlkHelCzGm9OlpjE9UBZJN4WZKlgYFI7B59vtkfpfd/tSS650gp
         aHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ls4oJs6fjZ2al5mHDHmAP430pKGIHTChze7QOzvid0=;
        b=bPYJCYeSK0JBWZSOuCAgU52JpoZSqZbjjgFvictkpgkrkrkrZyaelENWbkqC8QwUIp
         o3Zm2u2yQDgn2QDdyWNG2dhpeZY2TyloBwRgxVtzdrsB6TByCaPCXwZmkm88qCpTZC/y
         7j8x2lWx3r5EuBXHA0vqS2R6z1DDo1zAS2B+fHz7bQyzH/BOagYNQKuIqo4boVEH0ncz
         ZKp0PerCt02LNnBkYs9jfDOyS63KZ63oXJF2T04JbZRF6MXYZjPQyJmxqstHJsb7SmcK
         D+3rQY4YSXgGZhEvGFrtBGvLbOzDjH8S8RNOuQ8HSDVdrquYUZ7UH2dWSbucOobBoeLv
         1Erg==
X-Gm-Message-State: AOAM531mc1vE13fNLLIfyhvhmuc1FurY9OmOTRtXGB1XCqN7M482MeqM
        Ur+MmtrtBUPm7avZ/IhiRoHgwQ/PYJR4tjIh6a6DlQ==
X-Google-Smtp-Source: ABdhPJxQu27Nzc9iLtmZju+JlEp2t2xBOVP/vALHsIADO5/2M/D93HCsSqLZHtj0tHiYz0k26Hu4vZztU4HAIUpxob0=
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr30344219edv.174.1642606389887;
 Wed, 19 Jan 2022 07:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20220118071952.1243143-1-hch@lst.de> <20220118071952.1243143-12-hch@lst.de>
In-Reply-To: <20220118071952.1243143-12-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Jan 2022 16:32:58 +0100
Message-ID: <CAMGffE=gbN_oxdvzBdX66CaEPKQr6oc1TS1mf8GVz39e5Jme7Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] rnbd-src: remove struct rnbd_dev_blk_io
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

On Tue, Jan 18, 2022 at 8:20 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only the priv field of rnbd_dev_blk_io is used, so store the value of
> that in bio->bi_private directly and remove the entire bio_set overhead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
there is one typo in the subject line, should be rnbd-srv.
> ---
>  drivers/block/rnbd/rnbd-srv-dev.c |  4 +---
>  drivers/block/rnbd/rnbd-srv-dev.h | 13 ++-----------
>  drivers/block/rnbd/rnbd-srv.c     | 30 +++++-------------------------
>  drivers/block/rnbd/rnbd-srv.h     |  1 -
>  4 files changed, 8 insertions(+), 40 deletions(-)
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
> index 65c670e96075b..b1ac1414b56d5 100644
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
> @@ -152,20 +149,16 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>         priv->sess_dev = sess_dev;
>         priv->id = id;
>
> -       bio = bio_alloc_bioset(GFP_KERNEL, 1, sess_dev->rnbd_dev->ibd_bio_set);
> +       bio = bio_alloc(GFP_KERNEL, 1);
>         if (bio_add_page(bio, virt_to_page(data), datalen,
>                         offset_in_page(data))) {
>                 rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
>                 err = -EINVAL;
> -               goto sess_dev_put;
> +               goto bio_put;
ok, bio_put is used here, I think it's better the move to patch 10.
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
> @@ -180,7 +173,6 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>
>  bio_put:
>         bio_put(bio);
> -sess_dev_put:
>         rnbd_put_sess_dev(sess_dev);
>  err:
>         kfree(priv);
> @@ -261,7 +253,6 @@ static void destroy_sess(struct rnbd_srv_session *srv_sess)
>
>  out:
>         xa_destroy(&srv_sess->index_idr);
> -       bioset_exit(&srv_sess->sess_bio_set);
>
>         pr_info("RTRS Session %s disconnected\n", srv_sess->sessname);
>
> @@ -290,16 +281,6 @@ static int create_sess(struct rtrs_srv_sess *rtrs)
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
> @@ -748,8 +729,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
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
with it fixed,  the patch looks good to me.

Thanks!
