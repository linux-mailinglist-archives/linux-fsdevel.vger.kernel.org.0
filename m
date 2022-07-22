Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4757E612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiGVR4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiGVR4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:56:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695112A725;
        Fri, 22 Jul 2022 10:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 058A7622CD;
        Fri, 22 Jul 2022 17:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D25AC341C6;
        Fri, 22 Jul 2022 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658512569;
        bh=usMJ5IkRBymLsvZbfr3kKlCJ3I9XVG0lpJzhNLYD2PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAn2zA6DR502CJOVwmJvHSEGXMlSHPg4mHIFva8j8UV+yXgyiPF/cR0EitlvvYFh3
         CqR6OBMgO3IZutLH6yxs2liaYVbZrm/O5ivTuPS3KCP7Op64vIcomeouN0Fh75UoY8
         rxCZ5oJk9ObpqCOtbiySA6mzUYnn5uZZsVvXl1Q6duZetuFmns0cgf1VI/IvePksQb
         xEABrvSqctjOGGiHOShBlBG5EkUcXSdXd7mXfs2gZWGDzo8ZuIT/D99zz1DEfrSkji
         rZ0SR78AyvOs6VOdQnPKPeotn+lpG/KCMqRZveAYb5EL2qbbCPBJBnS/dbvv7SvbEK
         YUg6SjEGarBEw==
Date:   Fri, 22 Jul 2022 10:56:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] iomap: remove iomap_writepage
Message-ID: <YtrkuKm0iQ3+J7BJ@magnolia>
References: <20220719041311.709250-1-hch@lst.de>
 <20220719041311.709250-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719041311.709250-5-hch@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 06:13:11AM +0200, Christoph Hellwig wrote:
> Unused now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 15 ---------------
>  include/linux/iomap.h  |  3 ---
>  2 files changed, 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d2a9f699e17ed..1bac8bda40d0c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1518,21 +1518,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	return 0;
>  }
>  
> -int
> -iomap_writepage(struct page *page, struct writeback_control *wbc,
> -		struct iomap_writepage_ctx *wpc,
> -		const struct iomap_writeback_ops *ops)
> -{
> -	int ret;
> -
> -	wpc->ops = ops;
> -	ret = iomap_do_writepage(page, wbc, wpc);
> -	if (!wpc->ioend)
> -		return ret;
> -	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> -}
> -EXPORT_SYMBOL_GPL(iomap_writepage);
> -
>  int
>  iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e552097c67e0b..911888560d3eb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -303,9 +303,6 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
>  void iomap_sort_ioends(struct list_head *ioend_list);
> -int iomap_writepage(struct page *page, struct writeback_control *wbc,
> -		struct iomap_writepage_ctx *wpc,
> -		const struct iomap_writeback_ops *ops);
>  int iomap_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops);
> -- 
> 2.30.2
> 
