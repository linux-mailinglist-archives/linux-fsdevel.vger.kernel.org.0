Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D26D709B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 01:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjDDXXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbjDDXXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 19:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1434481;
        Tue,  4 Apr 2023 16:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F75663886;
        Tue,  4 Apr 2023 23:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E7C433EF;
        Tue,  4 Apr 2023 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680650582;
        bh=n/9jmBZO4HC87mIQyzeLEmcpGLyNDj01f1vbSC9mn1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5+6maz5xNhwYCtGwMq8kBY6ewuVOIdTUKUDsuMQwiiVGRZ4JLKIYUBPjB2R83qK2
         jmGenLfcD91UqsPu8iPNLDQItXW3gHeC3I3+QXoAFh+P/RTje+RB6N+AVCH6go5t7H
         lFGiVsSBrnYilekJWLE6vxyxrlVTrpCB4T4Y9zy6W5+71+O7LZHNDuLkkIeCmSFMdd
         LnjJ5ISVLkFIasoDRJ2L6Z+C/842tcZjmW0jqL8fTsEkpwRvnDkEqNPwfaJWuniC/G
         qFkKLchRB/hFADz1nfVP1I1Ba9kxaadE3S8FPdnJd+Kyn/HycjKR2qAf5p461PbUhh
         fEgpj2mzxoQVg==
Date:   Tue, 4 Apr 2023 16:23:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        anand.jain@oracle.com
Subject: Re: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
Message-ID: <20230404232302.GD109960@frogsfrogsfrogs>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-5-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-5-zlang@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

For this one hunk,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  L:	linux-xfs@vger.kernel.org
>  S:	Supported
>  F:	common/dump
> -- 
> 2.39.2
> 
