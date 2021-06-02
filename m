Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAB3993FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBT4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 15:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhFBT4P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:56:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D97B613EE;
        Wed,  2 Jun 2021 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622663672;
        bh=7IekTvQ7CS5QD1TW6WqSq7COBCKEeOkMr3jBpyWe7ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRi2utBngfyVZe6SNXoEqEEWfnwtYuiD+nA0zi9s8YwkvF7J9sLnFeNxeWNIx2Dca
         cOeYCfXYeHPZJOvIBycxDHDkR6fISULpZ+WRGwub/XKBI13m2dg3j3U9Mlc5LxCCPG
         /s5rY7811rmKQ4dZnP0GCtX/6ttaRq/LT4txxINCh/GMSlUQdVVyyL+14Z/Yrb6Q0o
         FL5O8MfVLRbGFt1Vu7cBqlz8QiBidKXrQxjf8eyYhh0ho2rE7EQKjxUfUTkYSGIBi2
         yLeG8mBoxwrNGGi3v25bVRESRr65vm9nf2db3k0VWBQVQ2MiPQrNAYpoMlC7zDEdJd
         n+IapTdxt7TGA==
Date:   Wed, 2 Jun 2021 12:54:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] f2fs: Advertise encrypted casefolding in sysfs
Message-ID: <YLfh9pv1fDT+Q3pe@sol.localdomain>
References: <20210602041539.123097-1-drosen@google.com>
 <20210602041539.123097-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602041539.123097-3-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:15:39AM +0000, Daniel Rosenberg wrote:
> +#ifdef CONFIG_UNICODE
> +F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
> +#endif

Shouldn't it be defined(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)?

>  #endif
>  #ifdef CONFIG_BLK_DEV_ZONED
>  F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> @@ -815,6 +823,9 @@ static struct attribute *f2fs_feat_attrs[] = {
>  #ifdef CONFIG_FS_ENCRYPTION
>  	ATTR_LIST(encryption),
>  	ATTR_LIST(test_dummy_encryption_v2),
> +#ifdef CONFIG_UNICODE
> +	ATTR_LIST(encrypted_casefold),
> +#endif

Likewise here.

- Eric
