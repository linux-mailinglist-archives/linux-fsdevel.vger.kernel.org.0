Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC54FEDBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 05:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiDMDqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiDMDqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDE2717F;
        Tue, 12 Apr 2022 20:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33CEF61AC8;
        Wed, 13 Apr 2022 03:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEACC385A4;
        Wed, 13 Apr 2022 03:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649821419;
        bh=0DLLBeYwX1EazBWCyswzOSP0z4T9DNS48VoVkPhWQWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7Q9OgGTTbcsomv0uXxUg650jNH3wKN4FbtkJVyags73Dp/G1v2QWwzMBkXYh8lIh
         Jjhp41kWiDIof6GNJAFXlfk0r63zf7SHyp7AFZdBIwYAzSaO8ylDQSEA2OUCi7YWD/
         bl0Bq+yEL8f/jxb7BUSbicnjjvPk0iyL6/FQ5hXfFM3t2DXguZtptf5nHjUROrEeyo
         hZYJhAh86pVd5nNeSHNm3ggselWq6RdZ8BoiV+KCiEoe2maOkzO0nXA/J8UBHqJ/k2
         QxLcWKhR4luc0FGpoQOWw5KG4P5brZnjV9vX+VkshjVvGn9U4Wxb/LGkNarhw6Xj9R
         vR+cgVIxk/Lqw==
Date:   Tue, 12 Apr 2022 20:43:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: update IOMAP FILESYSTEM LIBRARY and XFS
 FILESYSTEM
Message-ID: <20220413034339.GN16799@magnolia>
References: <1649812810-18189-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649812810-18189-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:20:10AM +0800, Tiezhu Yang wrote:
> In IOMAP FILESYSTEM LIBRARY and XFS FILESYSTEM, the M(ail): entry is
> redundant with the L(ist): entry, remove the redundant M(ail): entry.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Much better now.  Apologies again for the loud reply earlier.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f11..726608f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10238,8 +10238,6 @@ F:	drivers/net/ethernet/sgi/ioc3-eth.c
>  IOMAP FILESYSTEM LIBRARY
>  M:	Christoph Hellwig <hch@infradead.org>
>  M:	Darrick J. Wong <djwong@kernel.org>
> -M:	linux-xfs@vger.kernel.org
> -M:	linux-fsdevel@vger.kernel.org
>  L:	linux-xfs@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Supported
> @@ -21596,7 +21594,6 @@ F:	drivers/xen/*swiotlb*
>  XFS FILESYSTEM
>  C:	irc://irc.oftc.net/xfs
>  M:	Darrick J. Wong <djwong@kernel.org>
> -M:	linux-xfs@vger.kernel.org
>  L:	linux-xfs@vger.kernel.org
>  S:	Supported
>  W:	http://xfs.org/
> -- 
> 2.1.0
> 
