Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6D1382C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2020 18:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgAKR5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jan 2020 12:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgAKR5y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jan 2020 12:57:54 -0500
Received: from localhost (unknown [84.241.193.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C4E2084D;
        Sat, 11 Jan 2020 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578765473;
        bh=5vqrRTSv0UYc63jQmXzDlf5c/h7W9lj6SrJ/3ve1hNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCQd+LNRA2rTKFb0Iz2vL6HS97FsW+9BRT+M9KcxS7WCLus5MUCqFtxJrXnD5uKH/
         FE+7zeohS0Mkyc9tQkOnXY9ZRCuKcAqStKN3YpLYjnlRTDlfYuoDrTMmpIg8pQP4T8
         OHTQXMtUyeyPAoQKzxd1bfePyxmOaL4dksaZlC4c=
Date:   Sat, 11 Jan 2020 18:56:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        Namjae Jeon <namjae.jeon@samsung.com>, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: make staging/exfat and fs/exfat mutually
 exclusive
Message-ID: <20200111175611.GA422540@kroah.com>
References: <20200111121419.22669-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111121419.22669-1-linkinjeon@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 11, 2020 at 09:14:19PM +0900, Namjae Jeon wrote:
> From: Namjae Jeon <namjae.jeon@samsung.com>
> 
> Make staging/exfat and fs/exfat mutually exclusive to select the one
> between two same filesystem.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> ---
>  drivers/staging/exfat/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
> index 292a19dfcaf5..9a0fccec65d9 100644
> --- a/drivers/staging/exfat/Kconfig
> +++ b/drivers/staging/exfat/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config STAGING_EXFAT_FS
>  	tristate "exFAT fs support"
> -	depends on BLOCK
> +	depends on BLOCK && !EXFAT_FS

There is no such symbol in the kernel tree, so this isn't going to do
anything :(

When/if EXFAT_FS does show up, I will be glad to add this.  Or better
yet, just have this as part of the "real" exfat patchset, that would
make the most sense, right?

thanks,

greg k-h
