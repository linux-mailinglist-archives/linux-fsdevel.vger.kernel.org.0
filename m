Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00AB1997F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgCaNzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 09:55:22 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33930 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaNzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:55:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id b5so13546038vsb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/B2A1qcKH7oSSG9mXAFj0tT6t/BTjeCiRoD7zqWTYM=;
        b=LMXF+WcQmxVGp1YzB1UZyrpBVUbhIsrrqHHsK9TQ8EPk7nbI1osljohmYskrWJmNVT
         AHzLrBoCVNxRWL8k39IlPdHopiRDLbwkRdpV2S0JFauXIn1Ltfvx9iAiNY55Ys3TWcZR
         108tpjKrCKUBd1aGR8yA7XPu9DI1L4g4in9Bd48VT4do/7wptV50wDT4A1UaJVVlabD5
         fOLZ77ML4hxhrGdPPqnRurOdQnHJ8erIUtxqyNfDKXDevC3wt9l1W/B30ggi7YcRPFzT
         Fxn85w8fWPkxsvI285WldxldKAXBv3IlbKdxuWiCRym1oS5ZjSSMA/IrZItu1t+lsKPv
         XMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/B2A1qcKH7oSSG9mXAFj0tT6t/BTjeCiRoD7zqWTYM=;
        b=W4s7JwX3yo9Gke+AMTI26VWtkNnu/lcDm0Xmz+NhAqoww6L3gtN5TRvln9eI0ozc4h
         p4EFCZtt5u97sfDQ2aGmxFeOHrZ39sJrXUQUqEOIM03OdBMuTXAtuaUTMphThyaffnlY
         7VIldxWSRr78A8uN6hkWRrGvJ+LA0CFpso1ZKkDO0I0+NaEnC5pvCnbpx4Ixo3YU4Ny0
         5bqWTZAgk/IKwrOb+ggrjrqXYdaZrx//qb3kAoUE/7r5JDc+yklS1x2XMvuPxILsRprL
         qD6AUaITH/bAc7e5fuiBAewS6zDj+DATm2UZMjeO6C2r6IK5ggC7XSYz4e45Y6/atJD0
         KsHg==
X-Gm-Message-State: AGi0PuanQeaRU8H4WXl2W+nO8BI4RPvoTjNNYoqxeJQPGTueOHcsWiM/
        3osFzETOUx1j0T9F5ArMqQZi9wuGMFAw16gRcYY+mg==
X-Google-Smtp-Source: APiQypK3E0gQuHc1rDbqi+XmKXyimxuhv22EhSnCoIfh0XJFz9xgZieqE30qhe75Tm5i3/nN2aeRc4kOspHycosyIwY=
X-Received: by 2002:a67:80d6:: with SMTP id b205mr11605054vsd.137.1585662921374;
 Tue, 31 Mar 2020 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200326170705.1552562-1-hch@lst.de> <20200326170705.1552562-2-hch@lst.de>
In-Reply-To: <20200326170705.1552562-2-hch@lst.de>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 31 Mar 2020 09:55:09 -0400
Message-ID: <CAOg9mST05zXRU1rmgTNdYPb93zHsO9N3TOMhuGGj8Q=6=_j=kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "orangefs: remember count when reading."
To:     Christoph Hellwig <hch@lst.de>
Cc:     Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph...

Thanks for the patches... the revision of c2549f8c (which I dreamed up :-) )
might hose up some other stuff with our recent page cache revisions,
though I have no doubt about your concerns... I'll post back after I've
run some tests...

-Mike

On Thu, Mar 26, 2020 at 1:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> ->read_iter calls can race with each other and one or more ->flush calls.
> Remove the the scheme to store the read count in the file private data
> as is is completely racy and can cause use after free or double free
> conditions.
>
> This reverts commit c2549f8c7a28c00facaf911f700c4811cfd6f52b.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/orangefs/file.c            | 26 +-------------------------
>  fs/orangefs/orangefs-kernel.h |  4 ----
>  2 files changed, 1 insertion(+), 29 deletions(-)
>
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index c740159d9ad1..173e6ea57a47 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -346,23 +346,8 @@ static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
>      struct iov_iter *iter)
>  {
>         int ret;
> -       struct orangefs_read_options *ro;
> -
>         orangefs_stats.reads++;
>
> -       /*
> -        * Remember how they set "count" in read(2) or pread(2) or whatever -
> -        * users can use count as a knob to control orangefs io size and later
> -        * we can try to help them fill as many pages as possible in readpage.
> -        */
> -       if (!iocb->ki_filp->private_data) {
> -               iocb->ki_filp->private_data = kmalloc(sizeof *ro, GFP_KERNEL);
> -               if (!iocb->ki_filp->private_data)
> -                       return(ENOMEM);
> -               ro = iocb->ki_filp->private_data;
> -               ro->blksiz = iter->count;
> -       }
> -
>         down_read(&file_inode(iocb->ki_filp)->i_rwsem);
>         ret = orangefs_revalidate_mapping(file_inode(iocb->ki_filp));
>         if (ret)
> @@ -650,12 +635,6 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
>         return rc;
>  }
>
> -static int orangefs_file_open(struct inode * inode, struct file *file)
> -{
> -       file->private_data = NULL;
> -       return generic_file_open(inode, file);
> -}
> -
>  static int orangefs_flush(struct file *file, fl_owner_t id)
>  {
>         /*
> @@ -669,9 +648,6 @@ static int orangefs_flush(struct file *file, fl_owner_t id)
>         struct inode *inode = file->f_mapping->host;
>         int r;
>
> -       kfree(file->private_data);
> -       file->private_data = NULL;
> -
>         if (inode->i_state & I_DIRTY_TIME) {
>                 spin_lock(&inode->i_lock);
>                 inode->i_state &= ~I_DIRTY_TIME;
> @@ -694,7 +670,7 @@ const struct file_operations orangefs_file_operations = {
>         .lock           = orangefs_lock,
>         .unlocked_ioctl = orangefs_ioctl,
>         .mmap           = orangefs_file_mmap,
> -       .open           = orangefs_file_open,
> +       .open           = generic_file_open,
>         .flush          = orangefs_flush,
>         .release        = orangefs_file_release,
>         .fsync          = orangefs_fsync,
> diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
> index ed67f39fa7ce..e12aeb9623d6 100644
> --- a/fs/orangefs/orangefs-kernel.h
> +++ b/fs/orangefs/orangefs-kernel.h
> @@ -239,10 +239,6 @@ struct orangefs_write_range {
>         kgid_t gid;
>  };
>
> -struct orangefs_read_options {
> -       ssize_t blksiz;
> -};
> -
>  extern struct orangefs_stats orangefs_stats;
>
>  /*
> --
> 2.25.1
>
