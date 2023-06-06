Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83128723B3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjFFIUx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 6 Jun 2023 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFFIUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:20:51 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299DFA;
        Tue,  6 Jun 2023 01:20:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 89E7C63CC135;
        Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w2bdPD93IvhE; Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 14A1D616B2CD;
        Tue,  6 Jun 2023 10:20:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X5LSD106M-YC; Tue,  6 Jun 2023 10:20:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D62D563CC135;
        Tue,  6 Jun 2023 10:20:46 +0200 (CEST)
Date:   Tue, 6 Jun 2023 10:20:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     hch <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-nvme@lists.infradead.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>,
        linux-nilfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Message-ID: <766259639.3687124.1686039646763.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606073950.225178-26-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-26-hch@lst.de>
Subject: Re: [PATCH 25/31] ubd: remove commented out code in ubd_open
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove commented out code in ubd_open
Thread-Index: XkjrL/wptcQ24bQlPJHDQOJLYTpcmQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "hch" <hch@lst.de>
> This code has been dead forever, make sure it doesn't show up in code
> searches.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 7 -------
> 1 file changed, 7 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 8b79554968addb..20c1a16199c503 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1170,13 +1170,6 @@ static int ubd_open(struct gendisk *disk, fmode_t mode)
> 	}
> 	ubd_dev->count++;
> 	set_disk_ro(disk, !ubd_dev->openflags.w);
> -
> -	/* This should no more be needed. And it didn't work anyway to exclude
> -	 * read-write remounting of filesystems.*/
> -	/*if((mode & FMODE_WRITE) && !ubd_dev->openflags.w){
> -	        if(--ubd_dev->count == 0) ubd_close_dev(ubd_dev);
> -	        err = -EROFS;
> -	}*/

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
