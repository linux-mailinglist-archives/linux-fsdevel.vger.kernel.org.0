Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52D42EC65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhJOIcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhJOIcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:32:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899DAC061570;
        Fri, 15 Oct 2021 01:30:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y15so38567077lfk.7;
        Fri, 15 Oct 2021 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpGoqEWei5FXrKy5qTqsLJCtKd2jpbBDiauT/XgCqN4=;
        b=H72WQZEscxVJsu+eWElnCHCUXOukvxf46e1VnF83K6j9v7nsP3+19wEpz7B4f1RH7D
         7CDRwUD6+N8ffcFTc90gVU5pND2FXfQAczcVAyc+7cURXriueOD/4YDedzYVABpNoroD
         CYbL7Ap6c6L+IZ0oFn6Pp5fXTPK0x0xQ/yv6IXBB+YOnmisCKrOhBEB9/p0/K6f4hgNc
         4Tugx6JtZJ0lXyGs+rBo7PkhfDGk9dg/c22xac9tr0RwGtyshlFFRFrcoSvnpaHcqizc
         lv6y93SrtuS8i213itZv+77Ns3DncA1EpLruBOAv5Tasi/5JHb8KOa8ck10lCQclIq9H
         yYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpGoqEWei5FXrKy5qTqsLJCtKd2jpbBDiauT/XgCqN4=;
        b=bxssPl+b27tIwn//q/KKfP27Pfp6vRULefCMY7DGvIHKrODsIK7QgUmPH7oTIWQRLN
         mWbX0j3yQuzcMkPMYOReOR6/cuXVAz8H3tk2t6lQIOb4H8wfHaPKX0YC6wyq1JjXJny4
         PEhrxoToi/YfCpRf/oRhTFd+zLbLF7DGtnuTCAUxClMNGEI457djFe2DnbMWLXDcacBA
         qed/b+wXKcE0fMP3NEpmY5PaLEN0YyNBtwSuC1q4+OLlFWQS951NDZln7DgkJMpvdP4X
         /cqPne4439hYMbmQg7PpVWJv1IbqsQRbIZ2SbobjDgpUnRRNlFf8rRx+KrTM2UyG57Yr
         DqFg==
X-Gm-Message-State: AOAM531ypMPuGTvHHbWWxYDgi1FdX51isOlLGBtkWiRgr/STZ5Gkj1bp
        xUMrsxJ7LwkFxeizBx0VFjQ=
X-Google-Smtp-Source: ABdhPJyjX7GxxUZgQH2jAvzQ0Vlt+MCNSvpXHNNMMUEhpz//xRQC+cI+Z0eCH4vbBVyhrGxxsefqfg==
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr11452577ljj.357.1634286627882;
        Fri, 15 Oct 2021 01:30:27 -0700 (PDT)
Received: from localhost (80-62-117-201-mobile.dk.customer.tdc.net. [80.62.117.201])
        by smtp.gmail.com with ESMTPSA id s12sm438870lfc.256.2021.10.15.01.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:30:27 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:30:26 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211015083026.3geaix6r6kcnncu7@quentin>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 01:12:24PM +0200, Christoph Hellwig wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2b80c98fc373e..2a8689e949b4c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -25,6 +25,7 @@ struct request;
>  struct sg_io_hdr;
>  struct blkcg_gq;
>  struct blk_flush_queue;
> +struct kiocb;
>  struct pr_ops;
>  struct rq_qos;
>  struct blk_queue_stats;
> @@ -550,7 +551,7 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
>  
>  extern int blk_register_queue(struct gendisk *disk);
>  extern void blk_unregister_queue(struct gendisk *disk);
> -blk_qc_t submit_bio_noacct(struct bio *bio);
> +void submit_bio_noacct(struct bio *bio);
>  
>  extern int blk_lld_busy(struct request_queue *q);
>  extern void blk_queue_split(struct bio **);
> @@ -568,7 +569,8 @@ blk_status_t errno_to_blk_status(int errno);
>  #define BLK_POLL_ONESHOT		(1 << 0)
>  /* do not sleep to wait for the expected completion time */
>  #define BLK_POLL_NOSLEEP		(1 << 1)
Minor comment: Could we also have a flag #define BLK_POLL_SPIN 0?
It can improve the readability from the caller side instead of having
just a 0 to indicate spinning.

Regards, 
Pankaj Raghav
