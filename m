Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7F46694B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376421AbhLBRoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376415AbhLBRoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:44:15 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1FC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:40:52 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n66so586251oia.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lj8hbYvXYjFOWZTXIMLA3YN1MiMhgj1UM9C/K1aqIo4=;
        b=HTmGj60R6L67Zx/2PkW1lYVVD11ldGD14oCvasa748Er/cuIWxE1KSodVBAr/eQ4tj
         HzgYQv9o7BoCCqDLravqWj709rqKenRYoQrq0ZtYdvrZwNOs8E1JJQJ45xXTntMgA9Cz
         EnZCInwvBz/I6lRtlgxNQznwLA7Hxx0CgZxNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lj8hbYvXYjFOWZTXIMLA3YN1MiMhgj1UM9C/K1aqIo4=;
        b=GrP1L+01onCB1jpV4P3d3u9eVABfeFT+D3216Dov83W4D0gEXDtc88NWqblJULy8oG
         6MAsFsFpF1VStTR0iYwFYqXLkR6qEtsPtK067vupnLhSq/veQzcogkAMI1InSkngFCVC
         /x2ZR2M4pUX/cC8LKT4qoFkheDr5ZpPa1rmBa9eYa1avKrCaTrcUukjZ6UWN/9lPHLej
         iMmhn/mIHYEwB+J0pFANSId9+Pc1gus8xC3NCfugvplvLAyvBCbR5RW0PJLbmWHY+5dm
         B5AffeVabT1KFYDpY9wzQEip0jK/PlA9beRRSShKf4RjCkluCeEc1HaFh03mqDbnHlBV
         BrrQ==
X-Gm-Message-State: AOAM532XXJsQ0pADCOegPxeCx8aIhMJ38kV71L8Tb7Yp9HMbcFBqlxmS
        mrsYYf8FFnIlSebtywUa88C5Mw==
X-Google-Smtp-Source: ABdhPJw5cCQP4vjqtymKqf2ZQoeggGICgsLLmm5/duUqOqg80e6oUQd4uM4cj6S4wlC730sfw7JCvQ==
X-Received: by 2002:a05:6808:ecf:: with SMTP id q15mr5575230oiv.57.1638466852115;
        Thu, 02 Dec 2021 09:40:52 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id k1sm151214otj.61.2021.12.02.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:40:51 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:40:51 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 09/10] fs: add i_user_ns() helper
Message-ID: <YakFI/xMoZBHP1/x@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-10-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-10-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:31PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Since we'll be passing the filesystem's idmapping in even more places in
> the following patches and we do already dereference struct inode to get
> to the filesystem's idmapping multiple times add a tiny helper.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-10-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> /* v2 */
> unchanged
> ---
>  include/linux/fs.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7c0499b63a02..c7f72b78ab7e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1600,6 +1600,11 @@ struct super_block {
>  	struct list_head	s_inodes_wb;	/* writeback inodes */
>  } __randomize_layout;
>  
> +static inline struct user_namespace *i_user_ns(const struct inode *inode)
> +{
> +	return inode->i_sb->s_user_ns;
> +}
> +
>  /* Helper functions so that in most cases filesystems will
>   * not need to deal directly with kuid_t and kgid_t and can
>   * instead deal with the raw numeric values that are stored
> @@ -1607,22 +1612,22 @@ struct super_block {
>   */
>  static inline uid_t i_uid_read(const struct inode *inode)
>  {
> -	return from_kuid(inode->i_sb->s_user_ns, inode->i_uid);
> +	return from_kuid(i_user_ns(inode), inode->i_uid);
>  }
>  
>  static inline gid_t i_gid_read(const struct inode *inode)
>  {
> -	return from_kgid(inode->i_sb->s_user_ns, inode->i_gid);
> +	return from_kgid(i_user_ns(inode), inode->i_gid);
>  }
>  
>  static inline void i_uid_write(struct inode *inode, uid_t uid)
>  {
> -	inode->i_uid = make_kuid(inode->i_sb->s_user_ns, uid);
> +	inode->i_uid = make_kuid(i_user_ns(inode), uid);
>  }
>  
>  static inline void i_gid_write(struct inode *inode, gid_t gid)
>  {
> -	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
> +	inode->i_gid = make_kgid(i_user_ns(inode), gid);
>  }
>  
>  /**
> -- 
> 2.30.2
> 
