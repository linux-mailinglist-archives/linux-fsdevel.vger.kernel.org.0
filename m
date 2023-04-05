Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C136D75C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjDEHsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 03:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDEHsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD010F1;
        Wed,  5 Apr 2023 00:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7713E6359D;
        Wed,  5 Apr 2023 07:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF390C433D2;
        Wed,  5 Apr 2023 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680680882;
        bh=iG+5hwZ+00F79HrZr+lwoC/xHcVnBc+M7O/KLljWetw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1DKSbXsJkksJc50fMfe9E5d0vBrvfPBTXO+qnnm/ZTsLLxsc3tXPBZId8QVlQtiU
         tWKlNvtJ2Q9dVvvTQaFHWMtwuARGM7dZZzXwR1ttFnc3yyiYR3q57p8NorQfAf9uMS
         WsYimi1fhn1ocdkp7W7ZJLsA6QYxBXFg7FavFla8XWJ5S5YKn159fdD1V4pR8gIHND
         qxBCxbTyh5rPT8Q+Juc3t5cHT4YE/gnWHSbjyB0IaJjhxN+JqgPh5ilGsz5wD3K0w/
         xDKn7EIvgns7JH0LBxr6f6iI2aFLM9jWYK+if8Z7xiHJJyBx7qo9ajvgpuWUUL/rKD
         j5n5m82ILoILw==
Date:   Wed, 5 Apr 2023 09:47:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, amir73il@gmail.com, djwong@kernel.org,
        anand.jain@oracle.com
Subject: Re: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
Message-ID: <20230405-idolisieren-sperren-3c7042b9ed1f@brauner>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-5-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-5-zlang@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 01:14:10AM +0800, Zorro Lang wrote:
> Some people contribute to someone specific fs testing mostly, record
> some of them as Reviewer.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> If someone doesn't want to be in cc list of related fstests patch, please
> reply this email, I'll remove that reviewer line.
> 
> Or if someone else (who contribute to fstests very much) would like to a
> specific reviewer, nominate yourself to get a review.
> 
> Thanks,
> Zorro
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 620368cb..0ad12a38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -108,6 +108,7 @@ Maintainers List
>  	  or reviewer or co-maintainer can be in cc list.
>  
>  BTRFS
> +R:	Filipe Manana <fdmanana@suse.com>
>  L:	linux-btrfs@vger.kernel.org
>  S:	Supported
>  F:	tests/btrfs/
> @@ -137,16 +138,19 @@ F:	tests/f2fs/
>  F:	common/f2fs
>  
>  FSVERITY
> +R:	Eric Biggers <ebiggers@google.com>
>  L:	fsverity@lists.linux.dev
>  S:	Supported
>  F:	common/verity
>  
>  FSCRYPT
> +R:	Eric Biggers <ebiggers@google.com>
>  L:      linux-fscrypt@vger.kernel.org
>  S:	Supported
>  F:	common/encrypt
>  
>  FS-IDMAPPED

I'd just make this VFS since src/vfs/ covers generic vfs functionality.

But up to you,

Acked-by: Christian Brauner <brauner@kernel.org>

> +R:	Christian Brauner <brauner@kernel.org>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Supported
>  F:	src/vfs/
> @@ -163,6 +167,7 @@ S:	Supported
>  F:	tests/ocfs2/
>  
>  OVERLAYFS
> +R:	Amir Goldstein <amir73il@gmail.com>
>  L:	linux-unionfs@vger.kernel.org
>  S:	Supported
>  F:	tests/overlay
> @@ -174,6 +179,7 @@ S:	Supported
>  F:	tests/udf/
>  
>  XFS
> +R:	Darrick J. Wong <djwong@kernel.org>
>  L:	linux-xfs@vger.kernel.org
>  S:	Supported
>  F:	common/dump
> -- 
> 2.39.2
> 
