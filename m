Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE15B0EA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIGUzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIGUzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:55:48 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B459C8F7
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 13:55:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cr9so11406007qtb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7QDpSKyGoyq0TfdmAsz5OOGorpsRw7jW9ugW7EIFS1Y=;
        b=5x2RRgeSS/INucnvmU9HgGyW5hG2MO6YHA9sFrzyddKdJsIP38EUxb3H++yiBZr3Vw
         MsrHqXqa76W0Ey39IRZ5xe8tKA/oN26D2czzVtwEekXbGdrBaGQBQSMSWLxtgay9YGRT
         P8CO93qG4JAMzClS//KoyvwjCb27Bl4EKy4+/cIkb6qhqgZn3v26qjJMARXx58lPLoxL
         QKaMXjCUwiYMkfHM1VfouuQmWzkCe1fDIwJWuT2FQ3wowsAioahwvaFqPQPi5cDrHWtz
         k+hYXmKtQvJ0HbPISbzqfw66DZDVsameyPl2cmHt6ut5FmF9IkcD4lCRoPfrZSa3HYnl
         AIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7QDpSKyGoyq0TfdmAsz5OOGorpsRw7jW9ugW7EIFS1Y=;
        b=5BAyPFRc5gcw0Hx7PTOwnkoeM8+d/OANQO+00TXF8rEYsnamdeaQIyjqyloT/nFSTd
         38d9LhB0w0iUPnc4keJUTCdJRcDFT49XOaKmpN1nipRvDMgEW22JtYhNq9jSsd1H45CJ
         JsFuWeNmbJ7XCa7pcdQp/+jTgaXZ3/YNeeHgnbnXzQ7jVC5/I8WrAt421ZAskrbbMxib
         yq5+JsJ5sAUvNRbNCZtk5t9JfF/UUCwrnVHMZqa1xsJIe7qBxuOlgyIJuQkq58j8PcY6
         sIdj0hx8eMoCCK3hy7QP5TnVgmz+NdARDypXCTkwS2yJs1/4hgPbp56jr/KSkf61Ajzr
         M/7A==
X-Gm-Message-State: ACgBeo1Outi2KZLidEPzVKG6ZQKL+G/zLlTtl2xHgOpHKD1ia6P1b2KG
        /rLktPZwv72fIsXQUJqnZCpqxg==
X-Google-Smtp-Source: AA6agR6ZQ6FvGTHSjDRFmG4lPsnCGnHrEaMWr7Z46AK+gbY20ojw8yPogoqFqXUdktjW0eJ5BrWzXw==
X-Received: by 2002:ac8:5f4a:0:b0:344:5dd9:27d8 with SMTP id y10-20020ac85f4a000000b003445dd927d8mr5070628qta.543.1662584146882;
        Wed, 07 Sep 2022 13:55:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006b8d9d53605sm15287968qkp.125.2022.09.07.13.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:55:46 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:55:45 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        osandov@osandov.com
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <YxkFUeLBWhnufb7U@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-8-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:06AM +0300, Christoph Hellwig wrote:
> Currently the I/O submitters have to split bios according to the
> chunk stripe boundaries.  This leads to extra lookups in the extent
> trees and a lot of boilerplate code.
> 
> To drop this requirement, split the bio when __btrfs_map_block
> returns a mapping that is smaller than the requested size and
> keep a count of pending bios in the original btrfs_bio so that
> the upper level completion is only invoked when all clones have
> completed.
> 
> Based on a patch from Qu Wenruo.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/volumes.c | 106 +++++++++++++++++++++++++++++++++++++--------
>  fs/btrfs/volumes.h |   1 +
>  2 files changed, 90 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5c6535e10085d..0a2d144c20604 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -35,6 +35,7 @@
>  #include "zoned.h"
>  
>  static struct bio_set btrfs_bioset;
> +static struct bio_set btrfs_clone_bioset;
>  static struct bio_set btrfs_repair_bioset;
>  static mempool_t btrfs_failed_bio_pool;
>  
> @@ -6661,6 +6662,7 @@ static void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode,
>  	bbio->inode = inode;
>  	bbio->end_io = end_io;
>  	bbio->private = private;
> +	atomic_set(&bbio->pending_ios, 1);
>  }
>  
>  /*
> @@ -6698,6 +6700,57 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
>  	return bio;
>  }
>  
> +static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
> +{
> +	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
> +	struct bio *bio;
> +
> +	bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> +			&btrfs_clone_bioset);
> +	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
> +
> +	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
> +	orig_bbio->file_offset += map_length;

I'm worried about this for the ONE_ORDERED case.  We specifically used the
ONE_ORDERED thing because our file_offset was the start, but our length could go
past the range of the ordered extent, and then we wouldn't find our ordered
extent and things would go quite wrong.

Instead we should do something like

if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
	orig_bbio->file_offset += map_length;

I've cc'ed Omar since he's the one who added this and I'm a little confused
about how this can happen.

> +
> +	atomic_inc(&orig_bbio->pending_ios);
> +	return bio;
> +}
> +
> +static void btrfs_orig_write_end_io(struct bio *bio);
> +static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
> +				       struct btrfs_bio *orig_bbio)
> +{
> +	/*
> +	 * For writes btrfs tolerates nr_mirrors - 1 write failures, so we
> +	 * can't just blindly propagate a write failure here.
> +	 * Instead increment the error count in the original I/O context so
> +	 * that it is guaranteed to be larger than the error tolerance.
> +	 */
> +	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
> +		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
> +		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
> +		

Whitespace error here.  Thanks,

Josef
