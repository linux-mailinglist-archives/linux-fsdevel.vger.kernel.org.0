Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC6156C89
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 22:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBIVLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 16:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgBIVLc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 16:11:32 -0500
Received: from localhost (unknown [38.98.37.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2CF2080C;
        Sun,  9 Feb 2020 21:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581282690;
        bh=XRL7i1B3kKNa/58HEXB6dproAWB8DTgLR58h7kpLpQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8smSIPcM3a8+2AHUUrnv0r1hYurIu+hwNH2XQnSgvGKqg7eMcEM7x2bmnSanOkO6
         k0MZC9nNrvjTjjvvDTI/ykA1YoxNA7/wc4dLsuLWPnT/8hRcRpB8J2JUlFgg5rOhwQ
         rS+EolpE9i8UMAwAcS2vVJVl2qbV+qdsZ6lwpLo0=
Date:   Sun, 9 Feb 2020 22:09:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     JieunKim <jieun.kim4758@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: Replace printk with pr_info
Message-ID: <20200209210950.GA54745@kroah.com>
References: <20200209204810.9899-1-jieun.kim4758@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209204810.9899-1-jieun.kim4758@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:48:10AM +0900, JieunKim wrote:
> pr_info is preferred to use than printk.
> pr_info calls printk with KERN_INFO macros by itself.
> ---
>  drivers/staging/exfat/exfat_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index b81d2a87b82e..3806036c0ef6 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -364,7 +364,7 @@ static int ffsMountVol(struct super_block *sb)
>  	exfat_bdev_open(sb);
>  
>  	if (p_bd->sector_size < sb->s_blocksize) {
> -		printk(KERN_INFO "EXFAT: mount failed - sector size %d less than blocksize %ld\n",
> +		pr_info("EXFAT: mount failed - sector size %d less than blocksize %ld\n",
>  		       p_bd->sector_size,  sb->s_blocksize);
>  		ret = -EINVAL;
>  		goto out;
> -- 
> 2.17.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
