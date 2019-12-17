Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FA122C88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 14:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLQNKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 08:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQNKJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:10:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1CCC206EC;
        Tue, 17 Dec 2019 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576588209;
        bh=VuA5j+HiO8k+dTpbodT30fg4jaxkinHr0PKqpPnHmqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwOOzUyW1FpWAecxpBukxpV/ivxDEldZYnwzg8ZbjL7824T8OF2ehytcPDiR6n+zZ
         pdaLe6vrM8ggs4mHXSIlTEl5fKgkCaIAZULf7Yb/pMnAzF5YGtkMoDyWNSM19glSIH
         4UiY8ob9GitvGvJP7HfB27Hnd0+EvrZFTNGHYVzA=
Date:   Tue, 17 Dec 2019 14:10:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Preis <julian.preis@fau.de>
Cc:     devel@driverdev.osuosl.org, valdis.kletnieks@vt.edu,
        Johannes Weidner <johannes.weidner@fau.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/staging/exfat/exfat_super.c: Clean up
 ffsCamelCase function names
Message-ID: <20191217131007.GA3233328@kroah.com>
References: <y>
 <20191216141623.22379-1-julian.preis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216141623.22379-1-julian.preis@fau.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 03:16:23PM +0100, Julian Preis wrote:
> Rename every instance of <ffsCamelCaseExample> to <ffs_camel_case_example>
> in file exfat_super.c. Fix resulting overlong lines.
> 
> Co-developed-by: Johannes Weidner <johannes.weidner@fau.de>
> Signed-off-by: Johannes Weidner <johannes.weidner@fau.de>
> Signed-off-by: Julian Preis <julian.preis@fau.de>
> ---
> Changes in v2:
> - Add email recipients according to get_maintainer.pl
> - Add patch versions
> - Use in-reply-to
> 
>  drivers/staging/exfat/exfat_super.c | 99 +++++++++++++++--------------
>  1 file changed, 51 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index 6e481908c59f..14ff3fce70fb 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -343,7 +343,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
>  		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
>  }
>  
> -static int ffsMountVol(struct super_block *sb)
> +static int ffs_mount_vol(struct super_block *sb)

Why do these static functions even have to have "ffs" at the front of
them anyway?  There's no requirement here, right?  Shouldn't this just
be "mount_vol()"?

thanks,

greg k-h
