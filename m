Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A103F2284
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 23:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhHSVx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhHSVx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:53:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4FCC061575;
        Thu, 19 Aug 2021 14:53:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y7so13903625ljp.3;
        Thu, 19 Aug 2021 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gh7P+bJgD4ftBn8Xyzyldousp27lYpH1a6zXj2KjV24=;
        b=XZbj/Sdebgb0gcuT1OyWLtHFrLJTQj9LA+coAC9fb0pHjyxdCKO9C4w2Y5rI84fuId
         QX1KgfEw+8IW3VdphwJ7fLI/nx2cVKKVWiwD6sMWoNTxyYvQxdUR0RGO8A79jADBooyx
         tL6mYdbkri53XlFvnGOnik+xAExIWM5cCPD1T6uF5mUEPnY0QcP13dwzNDLAcDM4rn0b
         zvO4DMwi5Mur1VoFrsenaICWSbP4Co/pPUBWdKiEW643ZP+xAhY3oRCvcm1VYZR4ER7O
         RKve46kIY1+Q+kOQR1DNr5+ppQY+DVi4WYN5Nn4xBgTrwIPKsgpaIgh7AFveFI1tw8Kw
         KnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gh7P+bJgD4ftBn8Xyzyldousp27lYpH1a6zXj2KjV24=;
        b=C4fSV1P4EHYgIwFYYQyhC/WFS6q7BojvWpAsmfuIRKk6MsSm4ARknYtW4gHDoH/Vvo
         OqsAyEXMb1dd8hOPIffu671rEFZeYOcrmLN9PiNn4ayxQxnYxH2ooO/CySISdwsEn3ZD
         dVDyFG7hng8COZrLmVGxkjHFCac04/MHYfR6r3hs/SpQP9fviLjPxO5vW/rcrKyjsvz0
         aXdnUwBlA6BxPgWho4xhU6DA7pe0jzUyXQg0d1Bpo14o653IAwCh9viXRSBGwmNVD1TZ
         aSVtja92FARmbjwOUFLAUfm3hYQ3AxPu/dgHshc/x1EuRnpFYRsfyV9MSOzvwrz4GDeo
         H4KA==
X-Gm-Message-State: AOAM5326QIzOghG7BNBFKAR+FaTBVf/y9u3i3UpaUymlRPwXBq+CPi42
        yaqoJaS4yWobq6hd3wGAYIE=
X-Google-Smtp-Source: ABdhPJzTm68pE189pRq4MGEImt0mACD+8SqkCBSoHcqbpUBBeTYQqd6d49J7CZ4NhKj010k4o5ajFA==
X-Received: by 2002:a2e:a713:: with SMTP id s19mr3835976lje.177.1629409998665;
        Thu, 19 Aug 2021 14:53:18 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b14sm364264ljr.111.2021.08.19.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 14:53:18 -0700 (PDT)
Date:   Fri, 20 Aug 2021 00:53:15 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Message-ID: <20210819215315.uhst4ppwdbed65x7@kari-VirtualBox>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-4-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-4-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:26:30AM +0300, Kari Argillander wrote:
> We have now new mount api as described in Documentation/filesystems. We
> should use it as it gives us some benefits which are desribed here
> lore.kernel.org/linux-fsdevel/159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk/
> 
> Nls loading is changed a to load with string. This did make code also
> little cleaner.
> 
> Also try to use fsparam_flag_no as much as possible. This is just nice
> little touch and is not mandatory but it should not make any harm. It
> is just convenient that we can use example acl/noacl mount options.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

I will send new patches when Komarov has take a look of these. I have
found some bugs and how to improve things. Please take a look below my
second comment.

>  fs/ntfs3/super.c   | 392 +++++++++++++++++++++++----------------------

> +static void ntfs_fs_free(struct fs_context *fc)
> +{
> +	struct ntfs_sb_info *sbi = fc->s_fs_info;
> +
> +	if (sbi)
> +		put_ntfs(sbi);
> +}
> +
> +static const struct fs_context_operations ntfs_context_ops = {
> +	.parse_param	= ntfs_fs_parse_param,
> +	.get_tree	= ntfs_fs_get_tree,
> +	.reconfigure	= ntfs_fs_reconfigure,
> +	.free		= ntfs_fs_free,
> +};
> +
> +static int ntfs_init_fs_context(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
> +	struct ntfs_sb_info *sbi;
> +
> +	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	/* Default options */
> +	sbi->options.fs_uid = current_uid();
> +	sbi->options.fs_gid = current_gid();
> +	sbi->options.fs_fmask_inv = ~current_umask();
> +	sbi->options.fs_dmask_inv = ~current_umask();
> +
> +	fc->s_fs_info = sbi;
> +	fc->ops = &ntfs_context_ops;
> +
> +	return 0;
>  }
 
In this code I did not like that we make whole new sbi everytime.
Especially because we do zalloc. So when we regonfigure then new sbi
is allocated just for options. I notice that example xfs does allocate
their "sbi" everytime. Then I notice that example squashfs allocate
just mount options.

I have impression that we should allocate sbi if it first time so I
did "between code". I would like to do things like they are intended
with api so can Christoph comment that is this "right" thing to do
and is there any draw backs which I should know.

static void ntfs_fs_free(struct fs_context *fc)
{
	struct ntfs_mount_options *opts = fc->fs_private;
	struct ntfs_sb_info *sbi = fc->s_fs_info;

	if (sbi)
		put_ntfs(sbi);

	if (opts)
		clear_mount_options(opts);
}

static int ntfs_init_fs_context(struct fs_context *fc)
{
	struct ntfs_mount_options *opts;
	struct ntfs_sb_info *sbi = NULL;

	fc->ops = &ntfs_context_ops;

	opts = ntfs_zalloc(sizeof(struct ntfs_mount_options));
	if (!opts)
		return -ENOMEM;

	/* Default options. */
	opts->fs_uid = current_uid();
	opts->fs_gid = current_gid();
	opts->fs_fmask_inv = ~current_umask();
	opts->fs_dmask_inv = ~current_umask();

	fc->fs_private = opts;

	/* No need to initialize sbi if we just reconf. */
	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
		return 0;

	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
	if (!sbi) {
		ntfs_free(opts);
		return -ENOMEM;
	}

	mutex_init(&sbi->compress.mtx_lznt);
#ifdef CONFIG_NTFS3_LZX_XPRESS
	mutex_init(&sbi->compress.mtx_xpress);
	mutex_init(&sbi->compress.mtx_lzx);
#endif

	sbi->options = opts;
	fc->s_fs_info = sbi;

	return 0;
}
