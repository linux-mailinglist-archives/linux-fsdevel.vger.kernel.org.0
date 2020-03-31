Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464BB199F30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCaTew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 15:34:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39649 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCaTew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:34:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id a43so26624376edf.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlSJUrrtp+elCcnlxjegQ1+2cP9J0LpeSgRiaNQtR0s=;
        b=Zy2QcGdq96G717VvvW34Dy4QXOTaxcKIc7ZNiy53geXC8plgwU9BjibuKZtmLKW6gn
         m8mNVysOYxT1n8/aMgaH2yO34cOed9Q+6ts04a4bZmAuNwyDDO7SRKAXy+kpPzkg+vIY
         TZYj+3JG41xlb594XCd4xTqHYQkwJu6pExStc8t/U5eVOOb5v6HYRFT0zX9Ctzo0fFYe
         c9LKx1cQW3Q9sX3jbf0+sV8qHwdkhtW/zboEBhkp9l/782K7pjiDC/V8siom7J9b2Y9Z
         ywOChx5Ti45Jd8kzhPU7ZhIuaBYou5Kjj7dlZ8I7+AXuzI/yzK8yUlKOHJBU3AGKT2KM
         b6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlSJUrrtp+elCcnlxjegQ1+2cP9J0LpeSgRiaNQtR0s=;
        b=VYMgXvBUy93b+6I2fjIlgNzedqdlo/B6S/LmV18rK6u/veNSvjlG/0dDiR5pG5qzAD
         Ea/XgeqSu3v48aZI/ia7eSA0HqQYWox+JdWuONIjXGvzVFFp0bMnMypnDneto3uxL28v
         IWiYe7MGlfdZSj5/BOyFu3LZSa3A31vhqNCeCt8teR+CpEvZvP8bGb6tZGD1Chc2QvAw
         P77gEg0hoWM2HRvnlU/NPzuh4hb091m0wQJcqQGS1otnBg0BCcjwz6RBTRgYQbC49kOU
         HvlhF+BzdHVpP+ETkLe7x+qQwZe6sWPDT5emAu+0mnJfJ7NONZ64pvMbh4VLra7R+cFT
         l1XA==
X-Gm-Message-State: ANhLgQ1ob/Zo2YQ5FWr4W8zMrX27FBIkX1Q1QixnzMcwbnCjNH8xwqVt
        W+xBGFmoAhr+LSv7zNqKEcWQ98r1Vkmi84RFLnbvrg==
X-Google-Smtp-Source: ADFU+vsrR9MztC+EwEAW0InOpTF7vKxHzltbCfwaPTJVFLJjv2U252HQlig7Y4YqehaKRemZ8x8lDhVxwSEZWjFKJ8E=
X-Received: by 2002:a17:906:4bc4:: with SMTP id x4mr11811524ejv.201.1585683288829;
 Tue, 31 Mar 2020 12:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com> <20200228163456.1587-5-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-5-vgoyal@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Mar 2020 12:34:36 -0700
Message-ID: <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dm,dax: Add dax zero_page_range operation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        david <david@fromorbit.com>, jmoyer <jmoyer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Mike Snitzer <msnitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Add Mike ]

On Fri, Feb 28, 2020 at 8:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This patch adds support for dax zero_page_range operation to dm targets.

Mike,

Sorry, I should have pinged you earlier, but could you take a look at
this patch and ack it if it looks ok to go through the nvdimm tree
with the rest of the series?

>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/md/dm-linear.c        | 18 ++++++++++++++++++
>  drivers/md/dm-log-writes.c    | 17 +++++++++++++++++
>  drivers/md/dm-stripe.c        | 23 +++++++++++++++++++++++
>  drivers/md/dm.c               | 30 ++++++++++++++++++++++++++++++
>  include/linux/device-mapper.h |  3 +++
>  5 files changed, 91 insertions(+)
>
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 8d07fdf63a47..e1db43446327 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -201,10 +201,27 @@ static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
>         return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
> +static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> +                                     size_t nr_pages)
> +{
> +       int ret;
> +       struct linear_c *lc = ti->private;
> +       struct block_device *bdev = lc->dev->bdev;
> +       struct dax_device *dax_dev = lc->dev->dax_dev;
> +       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> +
> +       dev_sector = linear_map_sector(ti, sector);
> +       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
> +       if (ret)
> +               return ret;
> +       return dax_zero_page_range(dax_dev, pgoff, nr_pages);
> +}
> +
>  #else
>  #define linear_dax_direct_access NULL
>  #define linear_dax_copy_from_iter NULL
>  #define linear_dax_copy_to_iter NULL
> +#define linear_dax_zero_page_range NULL
>  #endif
>
>  static struct target_type linear_target = {
> @@ -226,6 +243,7 @@ static struct target_type linear_target = {
>         .direct_access = linear_dax_direct_access,
>         .dax_copy_from_iter = linear_dax_copy_from_iter,
>         .dax_copy_to_iter = linear_dax_copy_to_iter,
> +       .dax_zero_page_range = linear_dax_zero_page_range,
>  };
>
>  int __init dm_linear_init(void)
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index 99721c76225d..8ea20b56b4d6 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -994,10 +994,26 @@ static size_t log_writes_dax_copy_to_iter(struct dm_target *ti,
>         return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
>  }
>
> +static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> +                                         size_t nr_pages)
> +{
> +       int ret;
> +       struct log_writes_c *lc = ti->private;
> +       sector_t sector = pgoff * PAGE_SECTORS;
> +
> +       ret = bdev_dax_pgoff(lc->dev->bdev, sector, nr_pages << PAGE_SHIFT,
> +                            &pgoff);
> +       if (ret)
> +               return ret;
> +       return dax_zero_page_range(lc->dev->dax_dev, pgoff,
> +                                  nr_pages << PAGE_SHIFT);
> +}
> +
>  #else
>  #define log_writes_dax_direct_access NULL
>  #define log_writes_dax_copy_from_iter NULL
>  #define log_writes_dax_copy_to_iter NULL
> +#define log_writes_dax_zero_page_range NULL
>  #endif
>
>  static struct target_type log_writes_target = {
> @@ -1016,6 +1032,7 @@ static struct target_type log_writes_target = {
>         .direct_access = log_writes_dax_direct_access,
>         .dax_copy_from_iter = log_writes_dax_copy_from_iter,
>         .dax_copy_to_iter = log_writes_dax_copy_to_iter,
> +       .dax_zero_page_range = log_writes_dax_zero_page_range,
>  };
>
>  static int __init dm_log_writes_init(void)
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index 63bbcc20f49a..fa813c0f993d 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -360,10 +360,32 @@ static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
>         return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
> +static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> +                                     size_t nr_pages)
> +{
> +       int ret;
> +       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> +       struct stripe_c *sc = ti->private;
> +       struct dax_device *dax_dev;
> +       struct block_device *bdev;
> +       uint32_t stripe;
> +
> +       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> +       dev_sector += sc->stripe[stripe].physical_start;
> +       dax_dev = sc->stripe[stripe].dev->dax_dev;
> +       bdev = sc->stripe[stripe].dev->bdev;
> +
> +       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
> +       if (ret)
> +               return ret;
> +       return dax_zero_page_range(dax_dev, pgoff, nr_pages);
> +}
> +
>  #else
>  #define stripe_dax_direct_access NULL
>  #define stripe_dax_copy_from_iter NULL
>  #define stripe_dax_copy_to_iter NULL
> +#define stripe_dax_zero_page_range NULL
>  #endif
>
>  /*
> @@ -486,6 +508,7 @@ static struct target_type stripe_target = {
>         .direct_access = stripe_dax_direct_access,
>         .dax_copy_from_iter = stripe_dax_copy_from_iter,
>         .dax_copy_to_iter = stripe_dax_copy_to_iter,
> +       .dax_zero_page_range = stripe_dax_zero_page_range,
>  };
>
>  int __init dm_stripe_init(void)
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index b89f07ee2eff..aa72d9e757c1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1198,6 +1198,35 @@ static size_t dm_dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>         return ret;
>  }
>
> +static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +                                 size_t nr_pages)
> +{
> +       struct mapped_device *md = dax_get_private(dax_dev);
> +       sector_t sector = pgoff * PAGE_SECTORS;
> +       struct dm_target *ti;
> +       int ret = -EIO;
> +       int srcu_idx;
> +
> +       ti = dm_dax_get_live_target(md, sector, &srcu_idx);
> +
> +       if (!ti)
> +               goto out;
> +       if (WARN_ON(!ti->type->dax_zero_page_range)) {
> +               /*
> +                * ->zero_page_range() is mandatory dax operation. If we are
> +                *  here, something is wrong.
> +                */
> +               dm_put_live_table(md, srcu_idx);
> +               goto out;
> +       }
> +       ret = ti->type->dax_zero_page_range(ti, pgoff, nr_pages);
> +
> + out:
> +       dm_put_live_table(md, srcu_idx);
> +
> +       return ret;
> +}
> +
>  /*
>   * A target may call dm_accept_partial_bio only from the map routine.  It is
>   * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
> @@ -3199,6 +3228,7 @@ static const struct dax_operations dm_dax_ops = {
>         .dax_supported = dm_dax_supported,
>         .copy_from_iter = dm_dax_copy_from_iter,
>         .copy_to_iter = dm_dax_copy_to_iter,
> +       .zero_page_range = dm_dax_zero_page_range,
>  };
>
>  /*
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 475668c69dbc..af48d9da3916 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -141,6 +141,8 @@ typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn);
>  typedef size_t (*dm_dax_copy_iter_fn)(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i);
> +typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
> +               size_t nr_pages);
>  #define PAGE_SECTORS (PAGE_SIZE / 512)
>
>  void dm_error(const char *message);
> @@ -195,6 +197,7 @@ struct target_type {
>         dm_dax_direct_access_fn direct_access;
>         dm_dax_copy_iter_fn dax_copy_from_iter;
>         dm_dax_copy_iter_fn dax_copy_to_iter;
> +       dm_dax_zero_page_range_fn dax_zero_page_range;
>
>         /* For internal device-mapper use. */
>         struct list_head list;
> --
> 2.20.1
>
