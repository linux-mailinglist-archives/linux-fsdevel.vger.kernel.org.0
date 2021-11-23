Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6E45AFE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhKWXQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235038AbhKWXQv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:16:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0598E60FC1;
        Tue, 23 Nov 2021 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637709223;
        bh=0lx8GFaumCvYFKCqIo5atmiVFp/pn2IMyOP4olSlTJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmrMJlCXXOUq098AjY55dEGQriwsEd/zsWv3kkKPJgdshScXkfBUmLoy/XMwhVsc9
         O/mlmEayflyVLaWvLIyFQcOF0OFYTa4CSjHFlZ/YU8LirvRyA12SC/tupkmtai7wmG
         xh9+tR6CqjsTkxNXjN2maqJxgIgDZRZ+JjVRIYiFZA8Ub74VLy5HtaTClmtPWXFeQM
         mtsNdJ0bO5jpxRPNMzE1EEd7DT2lltp3eu8XNwz66KKDFZFvJaM7mm4bD3I9uIrHad
         XpEKdq/bOnmFUZBItfTvQx/+CiGS1lCeim+CdWb86PECfthdvijctiMnO8k/Jrk9d+
         gKMaIHNoxpuiQ==
Date:   Tue, 23 Nov 2021 15:13:42 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
Message-ID: <20211123231342.GW266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-30-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:09AM +0100, Christoph Hellwig wrote:
> The file system DAX code now does not require the block code.  So allow
> building a kernel with fuse DAX but not block layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 6d608330a096e..7a2b11c0b8036 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -42,6 +42,8 @@ source "fs/nilfs2/Kconfig"
>  source "fs/f2fs/Kconfig"
>  source "fs/zonefs/Kconfig"
>  
> +endif # BLOCK
> +
>  config FS_DAX
>  	bool "File system based Direct Access (DAX) support"
>  	depends on MMU
> @@ -89,8 +91,6 @@ config FS_DAX_PMD
>  config FS_DAX_LIMITED
>  	bool
>  
> -endif # BLOCK
> -
>  # Posix ACL utility routines
>  #
>  # Note: Posix ACLs can be implemented without these helpers.  Never use
> -- 
> 2.30.2
> 
