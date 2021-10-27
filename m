Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A343D351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbhJ0U5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhJ0U5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:57:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6DC061745
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 13:54:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 187so3853264pfc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MW2+yuOLdVC2FiYNaHWFO+PStoIyhupC83aZvNmdg00=;
        b=xAWE2Gs6elQhyFnpgWWwNUZcIIN+S0dTB23e1v1SGSkr3xAYgCO6FZbQyPbRQqQf23
         9I8Y78UczhWRyEynzMK/aUvy5wOw4Vy6/4LxJus/eHVGZMzDNjEAK+zx722FS9qK0he2
         1U1cd8YzY36X3CDASwjtuR6iKB/eUu6jn2zPH05rfMggNUg3QvABlXcipTgHgz3k7BuS
         H+rhb1Vq1z7S7EkZGdXP0ONpo163cZlk5BsINHv2ASIpi7dd31Nuhi/Qnq9EJvDvkYxw
         Pntfc80cc9CfDzJp6vju7flE64Efz7hVPlBsr/GGmt1WhUviknbfEb0n+v3Q2OiU1RqV
         8kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MW2+yuOLdVC2FiYNaHWFO+PStoIyhupC83aZvNmdg00=;
        b=kUu6z5V4fdO/dZcPUdLlhNWbo46ypGJJj8+gFRKAupmeXQS3cPXzk89wqrPB1dmMyz
         hIPbDaF6B43UeCiEALWh7aOgZQv5akpUZiLpDa/qliAy6HXwxHg5X0mI8R/WvTVLCP5B
         ujgDlrJ8yXfmrPXwTYUyy1mHh/sxrggGmd4vMCVM8sBUyhbh3NrAlklTHmZzpzkdww4u
         5RncFFZwjZl+y2qtRgK51ypyZXM6Q08ASt7XuoHftNXpXyxV89D4GOlhszjYxJRNAroX
         f5FQa+j5DTLb5qQNn3NWsi/ecXsav0MXdeRyLkIDNOwet1WAH12FNAam/RQVtylo9fft
         eXjg==
X-Gm-Message-State: AOAM530FihPUk8Twn9p0UalufmULS2yXuPvw5iMdHgucxSkS3ZTvtA7j
        mq/j6cnGDGIc3aGLVfxa0SmM945Li8nfLnd9/fEJQYQcbTk=
X-Google-Smtp-Source: ABdhPJxqYRzrssHaaThSAQ3S9v6yHWHIiMadGqtNgSbRxpNG6jDSA2a4I6mJJqbjxV8Pnl8ItfliO9eaeQbTvv574gs=
X-Received: by 2002:a63:770e:: with SMTP id s14mr43824pgc.377.1635368076533;
 Wed, 27 Oct 2021 13:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-3-hch@lst.de>
In-Reply-To: <20211018044054.1779424-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 13:54:25 -0700
Message-ID: <CAPcyv4jAd5O=keOkvtKzrnqpy21dfH0sJSk7Oo16wYrFfPnk=Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] dax: remove CONFIG_DAX_DRIVER
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Looks good, I don't think an s390 ack is needed for this one.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/Kconfig        | 4 ----
>  drivers/nvdimm/Kconfig     | 2 +-
>  drivers/s390/block/Kconfig | 2 +-
>  fs/fuse/Kconfig            | 2 +-
>  4 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index d2834c2cfa10d..954ab14ba7778 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -1,8 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config DAX_DRIVER
> -       select DAX
> -       bool
> -
>  menuconfig DAX
>         tristate "DAX: direct access to differentiated memory"
>         select SRCU
> diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> index b7d1eb38b27d4..347fe7afa5830 100644
> --- a/drivers/nvdimm/Kconfig
> +++ b/drivers/nvdimm/Kconfig
> @@ -22,7 +22,7 @@ if LIBNVDIMM
>  config BLK_DEV_PMEM
>         tristate "PMEM: Persistent memory block device support"
>         default LIBNVDIMM
> -       select DAX_DRIVER
> +       select DAX
>         select ND_BTT if BTT
>         select ND_PFN if NVDIMM_PFN
>         help
> diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
> index d0416dbd0cd81..e3710a762abae 100644
> --- a/drivers/s390/block/Kconfig
> +++ b/drivers/s390/block/Kconfig
> @@ -5,7 +5,7 @@ comment "S/390 block device drivers"
>  config DCSSBLK
>         def_tristate m
>         select FS_DAX_LIMITED
> -       select DAX_DRIVER
> +       select DAX
>         prompt "DCSSBLK support"
>         depends on S390 && BLOCK
>         help
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 40ce9a1c12e5d..038ed0b9aaa5d 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -45,7 +45,7 @@ config FUSE_DAX
>         select INTERVAL_TREE
>         depends on VIRTIO_FS
>         depends on FS_DAX
> -       depends on DAX_DRIVER
> +       depends on DAX
>         help
>           This allows bypassing guest page cache and allows mapping host page
>           cache directly in guest address space.
> --
> 2.30.2
>
