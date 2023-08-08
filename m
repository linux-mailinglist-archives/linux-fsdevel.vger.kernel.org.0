Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6784F774BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjHHVAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjHHVAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23544FB2E;
        Tue,  8 Aug 2023 09:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B2F627D4;
        Tue,  8 Aug 2023 16:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F79C433C7;
        Tue,  8 Aug 2023 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691513677;
        bh=T813JjphMtewVHJosf6QiGfL5FaDrRFvV4YXC23AuNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOhTJpEDd9+N5roNISEjkAckSG64c7MdII+qi7swOIK6ZCpgjPVd0FSwHQpPFMRy8
         OX3Uq49lk5fzxMklDpo4HsC8DbuKgkmNxh8ceW+bq/w+ZAwM2g9ve1yOkE/2iuwlY/
         XCsmAIC1kEATGu5MyR67tWPrs3nQycSLSa1sfiWq7WKnfPTVhaoGvZg+vD/jUQeCEc
         PoEx8199hbJHTTFndqA4MNGdZqrTWMysjc1EizMdEKMdal6a0MJNRZnCVRTH1yoGt4
         JBlSlBv3sqGSTOqfvqZhjiicEP2I0DfnOnWQUqAKxHuz+FBLcFiRQwNbc7WGeJ9SQj
         jiTmjLg/EEwTQ==
Date:   Tue, 8 Aug 2023 09:54:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/13] xfs: reformat the xfs_fs_free prototype
Message-ID: <20230808165436.GO11377@frogsfrogsfrogs>
References: <20230808161600.1099516-1-hch@lst.de>
 <20230808161600.1099516-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808161600.1099516-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:15:48AM -0700, Christoph Hellwig wrote:
> The xfs_fs_free prototype formatting is a weird mix of the classic XFS
> style and the Linux style.  Fix it up to be consistent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index bf6e0a261a49e6..0a294659c18972 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1933,7 +1933,8 @@ xfs_fs_reconfigure(
>  	return 0;
>  }
>  
> -static void xfs_fs_free(
> +static void
> +xfs_fs_free(
>  	struct fs_context	*fc)
>  {
>  	struct xfs_mount	*mp = fc->s_fs_info;
> -- 
> 2.39.2
> 
