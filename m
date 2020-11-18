Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200E12B83E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 19:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKRSdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 13:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKRSdR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:33:17 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D642076E;
        Wed, 18 Nov 2020 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605724396;
        bh=BjKcTAHgEEjZHw2S0jY4URW2XCqx1wgwKoGTacZch84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyK8uf67iCtixRi8uO42elgp56Fhal5a2BOHB2UID2/arUXXL4CgZvP/zwwngPCR4
         oax/yC6Ha8U7UeA8AqYXGwDwVtZ/1eB4iJAEggskLBm0MPSR19hvxrH+/yac5zj1Vj
         Y2tg5TgPUUqJ1UCa4zmzEcGhGHFRUWGPfqfNeEXI=
Date:   Wed, 18 Nov 2020 10:33:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] fscrypt: Have filesystems handle their d_ops
Message-ID: <X7Vo6mikGB8ile7C@sol.localdomain>
References: <20201118064245.265117-1-drosen@google.com>
 <20201118064245.265117-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118064245.265117-3-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 06:42:44AM +0000, Daniel Rosenberg wrote:
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 1fbe6c24d705..cb3cfa6329ba 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -570,7 +570,3 @@ int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  	return valid;
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
> -
> -const struct dentry_operations fscrypt_d_ops = {
> -	.d_revalidate = fscrypt_d_revalidate,
> -};

The declaration of fscrypt_d_ops in fs/crypto/fscrypt_private.h should be
removed too.

Otherwise this patch looks good; feel free to add:

	Acked-by: Eric Biggers <ebiggers@google.com>

- Eric
