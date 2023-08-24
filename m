Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2908786F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbjHXMvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbjHXMvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390ECD0;
        Thu, 24 Aug 2023 05:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C623C65267;
        Thu, 24 Aug 2023 12:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27832C433C8;
        Thu, 24 Aug 2023 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692881458;
        bh=lBZ5c/CUDVkywfcL++OEneM4SWhyv382iCUDsA/wTRI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eQ4x0KUNpLdBSAUkoOXOOiGyRazWlKYs1IKWqIPDvsUeF+eogO2elA6xPeeFwoQfx
         CYIPfK7MmLjskY1gbZ+T6qYKnW2PNc72ML9NYg0qkyrGT8VWU9v3HyqcvwV00JMLjy
         OE8Hky/uf0h6VE7nYqX/CFyr3gTVdE/9JwUatS03GdfATtzwPFBdmBJNBD3M0IS0Uz
         DQzE4IaTEyHL0L07r4UaDiIOz2KRMJbJH8vUapl0VTIFxgS2xRhNuyHE+cCSy5ZraL
         NjeUhtdoXTfTmXfb9S+VYWca3QFmHnoWje528Khl8fUP3J6FW1uJ2xBMovQCnyimn+
         TU0DOs/4s3ZJg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56d8bc0d909so4134645eaf.3;
        Thu, 24 Aug 2023 05:50:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxcPk0HOiDBcMgN+wDO6Gm2LazGVq1AY8G61LBoyqT3Q6dnyEEB
        rUuGX9eui4JimIE7WGsIx+06vwVHty2zkN4HjNE=
X-Google-Smtp-Source: AGHT+IG3yEzQiDIJs4ioyXvdDknlK6YC1qUMG58DDDFHOUSHXKP4BX/kGvgMJu1eV6agiFbS5W2iw6kTsC1LVjV3XJU=
X-Received: by 2002:a4a:6c1d:0:b0:56c:8d61:f66f with SMTP id
 q29-20020a4a6c1d000000b0056c8d61f66fmr2277742ooc.2.1692881457272; Thu, 24 Aug
 2023 05:50:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1186:0:b0:4e8:f6ff:2aab with HTTP; Thu, 24 Aug 2023
 05:50:56 -0700 (PDT)
In-Reply-To: <1a1af1dd-fb30-1af6-ab2a-d146ff230989@gmail.com>
References: <1a1af1dd-fb30-1af6-ab2a-d146ff230989@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 24 Aug 2023 21:50:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8xsszN7NOe8bL-PCEsy3X2Y3FkOfSX1ETMKbH05xmUBg@mail.gmail.com>
Message-ID: <CAKYAXd8xsszN7NOe8bL-PCEsy3X2Y3FkOfSX1ETMKbH05xmUBg@mail.gmail.com>
Subject: Re: [PATCH] exfat: add ioctls for accessing attributes
To:     Jan Cincera <hcincera@gmail.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-08-16 3:29 GMT+09:00, Jan Cincera <hcincera@gmail.com>:
> Add GET and SET attributes ioctls to enable attribute modification.
> We already do this in FAT and a few userspace utils made for it would
> benefit from this also working on exFAT, namely fatattr.
>
> Signed-off-by: Jan Cincera <hcincera@gmail.com>
> ---
>  fs/exfat/exfat_fs.h |  6 +++
>  fs/exfat/file.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 729ada9e26e8..ebe8c4b928f4 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -149,6 +149,12 @@ enum {
>  #define DIR_CACHE_SIZE		\
>  	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
>
> +/*
> + * attribute ioctls, same as their FAT equivalents.
> + */
> +#define EXFAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u32)
> +#define EXFAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
> +
>  struct exfat_dentry_namebuf {
>  	char *lfn;
>  	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 3cbd270e0cba..b358acbead27 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -8,6 +8,8 @@
>  #include <linux/cred.h>
>  #include <linux/buffer_head.h>
>  #include <linux/blkdev.h>
> +#include <linux/fsnotify.h>
> +#include <linux/security.h>
>
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -316,6 +318,96 @@ int exfat_setattr(struct mnt_idmap *idmap, struct
> dentry *dentry,
>  	return error;
>  }
>
> +/*
> + * modified ioctls from fat/file.c by Welmer Almesberger
> + */
> +static int exfat_ioctl_get_attributes(struct inode *inode, u32 __user
> *user_attr)
> +{
> +	u32 attr;
> +
> +	inode_lock_shared(inode);
> +	attr = exfat_make_attr(inode);
> +	inode_unlock_shared(inode);
> +
> +	return put_user(attr, user_attr);
> +}
> +
> +static int exfat_ioctl_set_attributes(struct file *file, u32 __user
> *user_attr)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
> +	int is_dir = S_ISDIR(inode->i_mode);
> +	u32 attr, oldattr;
> +	struct iattr ia;
> +	int err;
> +
> +	err = get_user(attr, user_attr);
> +	if (err)
> +		goto out;
> +
> +	err = mnt_want_write_file(file);
> +	if (err)
> +		goto out;
> +	inode_lock(inode);
> +
> +	/*
> +	 * ATTR_VOLUME and ATTR_SUBDIR cannot be changed; this also
> +	 * prevents the user from turning us into a VFAT
> +	 * longname entry.  Also, we obviously can't set
> +	 * any of the NTFS attributes in the high 24 bits.
> +	 */
This comments seems to be wrong. In particular, The comment about
longfilename and ATTR_VOLUME for vfat should be removed.

> +	attr &= 0xff & ~(ATTR_VOLUME | ATTR_SUBDIR);
> +	/* Merge in ATTR_VOLUME and ATTR_DIR */
> +	attr |= (EXFAT_I(inode)->attr & ATTR_VOLUME) |
> +		(is_dir ? ATTR_SUBDIR : 0);
We need to mask exfat file attribute bits like the following not to
set reserved fields(+ ATTR_SUBDIR). And there is no ATTR_VOLUME field
in exfat.

Table 28 FileAttributes Field Structure
ReadOnly        0	1	This field is mandatory and conforms to the MS-DOS
definition.
Hidden             1     	1	This field is mandatory and conforms to
the MS-DOS definition.
System            2	1	This field is mandatory and conforms to the
MS-DOS definition.
Reserved1       3	1	This field is mandatory and its contents are reserved.
Directory          4	1	This field is mandatory and conforms to the
MS-DOS definition.
Archive            5	1	This field is mandatory and conforms to the
MS-DOS definition.
Reserved2	6	10	This field is mandatory and its contents are reserved.

Thanks.
