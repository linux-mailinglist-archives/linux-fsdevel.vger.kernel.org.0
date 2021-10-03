Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE48F42031F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJCRog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhJCRog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:44:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F043C0613EC;
        Sun,  3 Oct 2021 10:42:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y23so22406432lfb.0;
        Sun, 03 Oct 2021 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fp7K/loU26ruITuOa6jURGENBgeS0ANLVcb3/g9gBd4=;
        b=dF0K5o8nHY63oo44CokXeilF60prm/HLae6dyr3FxuFdCs/vjjZ0+3jh8/xQZ3TzoF
         Xj5UxeCPR39EghbULPgnLky+0MuMtL70n8IokATaE+cLi70VLhk151FT5gAGDAG0W1Ah
         sToCTDLPM9onGwp/R/YQCyHpLMEM3SRk8K0BhoKTUUVVYoaSvJVvVswGJRotDx8WPH9C
         Gvt9GbcTmGQzxq4CJpCJ0xtBs7LmhvCuvIv4nUpL6noOrdihNBwK/wmR6WwYXE/sOSQC
         +BRioV7Rkl1Sc+q/B1Gv/AVr5mKupR4DCgSEPgPlDyGnMhQQH9dCEvhWI8dKI0iZFZGd
         Ul3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fp7K/loU26ruITuOa6jURGENBgeS0ANLVcb3/g9gBd4=;
        b=UZn4TTIgvo1Fd6IySeBSfF6AM72Xopa5eztB0glZMb15/OaMPRgf2YNA7MNMEw2dJM
         FVTyC1El6yx2lIBy/jQ/PcVROJ30qs58vwXb3qiDs89kfFxtREsdsHyS+iH392qORo7c
         Ci0R5qPzy67+uZkV/UQtOmJPTtUQWxQJVUgTaONLyVMskXMACVD/okmi3qGJYaXV78xH
         GtrkEt9XXuuwAjRBXmHNiZpCHcmcab2Uo6+XE6083zYcMOzINZ4fQR2YQTYogXHkk/bJ
         u8SJkPxmtn5OjY5/jPYTw4HqebSJkNF5pAtw5jdaoPte3MkrkR+oSW6967S8IjaDdklL
         W+yA==
X-Gm-Message-State: AOAM530ifhpaXi3Hq0gvNTj2uhxw704YlCOQr95tNZmtXk+UsYQsXWVh
        UjRpF/wJD+mvsh72zO7kzTgmWifZd4A=
X-Google-Smtp-Source: ABdhPJy+MrPj6vOAyRi5R3N/O9eSa7lJw1lpMMD/7A1DBmLl4jx4H1KowNOD1DqLbIlEaftytwWfpw==
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr10553779lji.291.1633282966606;
        Sun, 03 Oct 2021 10:42:46 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o9sm1498430lfl.280.2021.10.03.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 10:42:46 -0700 (PDT)
Date:   Sun, 3 Oct 2021 20:42:44 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/ntfs3: Remove unnecessary includes
Message-ID: <20211003174244.ijg3uxoqdt2ywyqe@kari-VirtualBox>
References: <992eee8f-bed8-4019-a966-1988bd4dd5de@paragon-software.com>
 <43e50860-3708-2887-86f7-e201782a2001@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e50860-3708-2887-86f7-e201782a2001@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 07:02:51PM +0300, Konstantin Komarov wrote:
> All removed includes already included from other headers.

Nack from me. Usually in kernel both header and source file should make
they own includes even when they both include same header file.

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c   | 2 --
>  fs/ntfs3/attrlist.c | 2 --
>  fs/ntfs3/dir.c      | 2 --
>  fs/ntfs3/file.c     | 2 --
>  fs/ntfs3/frecord.c  | 2 --
>  fs/ntfs3/fslog.c    | 2 --
>  fs/ntfs3/fsntfs.c   | 2 --
>  fs/ntfs3/index.c    | 3 ---
>  fs/ntfs3/inode.c    | 2 --
>  fs/ntfs3/lznt.c     | 1 -
>  fs/ntfs3/namei.c    | 2 --
>  fs/ntfs3/ntfs_fs.h  | 1 -
>  fs/ntfs3/record.c   | 2 --
>  fs/ntfs3/run.c      | 2 --
>  fs/ntfs3/super.c    | 4 +---
>  fs/ntfs3/xattr.c    | 2 --
>  16 files changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index 8a00fa978f5f..dd4f1613081d 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -10,8 +10,6 @@
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /*
> diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
> index bad6d8a849a2..c3934a2a28a9 100644
> --- a/fs/ntfs3/attrlist.c
> +++ b/fs/ntfs3/attrlist.c
> @@ -7,8 +7,6 @@
>  
>  #include <linux/fs.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /*
> diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
> index 785e72d4392e..293303f00b66 100644
> --- a/fs/ntfs3/dir.c
> +++ b/fs/ntfs3/dir.c
> @@ -10,8 +10,6 @@
>  #include <linux/fs.h>
>  #include <linux/nls.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /* Convert little endian UTF-16 to NLS string. */
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 5fb3508e5422..13789543a0fb 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -13,8 +13,6 @@
>  #include <linux/falloc.h>
>  #include <linux/fiemap.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 007602badd90..b27f3ca2704b 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -9,8 +9,6 @@
>  #include <linux/fs.h>
>  #include <linux/vmalloc.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  #ifdef CONFIG_NTFS3_LZX_XPRESS
>  #include "lib/lib.h"
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 06492f088d60..4bf340babb32 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -10,8 +10,6 @@
>  #include <linux/random.h>
>  #include <linux/slab.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /*
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 4de9acb16968..85cbbb8f41ea 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -10,8 +10,6 @@
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  // clang-format off
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6f81e3a49abf..a25f04dcb85b 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -8,10 +8,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/buffer_head.h>
>  #include <linux/fs.h>
> -#include <linux/kernel.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  static const struct INDEX_NAMES {
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 7dd162f6a7e2..06113610c529 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -13,8 +13,6 @@
>  #include <linux/uio.h>
>  #include <linux/writeback.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /*
> diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
> index 28f654561f27..d9614b8e1b4e 100644
> --- a/fs/ntfs3/lznt.c
> +++ b/fs/ntfs3/lznt.c
> @@ -11,7 +11,6 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> -#include "debug.h"
>  #include "ntfs_fs.h"
>  
>  // clang-format off
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index bc741213ad84..ed29cd3e98f4 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -8,8 +8,6 @@
>  #include <linux/fs.h>
>  #include <linux/nls.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /*
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 38b7c1a9dc52..e6f37f9993a0 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -29,7 +29,6 @@
>  #include <asm/div64.h>
>  #include <asm/page.h>
>  
> -#include "debug.h"
>  #include "ntfs.h"
>  
>  struct dentry;
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index 861e35791506..3dd7b960ac8d 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -7,8 +7,6 @@
>  
>  #include <linux/fs.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
> diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
> index a8fec651f973..f5a5ce7aa206 100644
> --- a/fs/ntfs3/run.c
> +++ b/fs/ntfs3/run.c
> @@ -10,8 +10,6 @@
>  #include <linux/fs.h>
>  #include <linux/log2.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  /* runs_tree is a continues memory. Try to avoid big size. */
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 705d8b4f4894..bd8d39992b35 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -35,8 +35,6 @@
>  #include <linux/seq_file.h>
>  #include <linux/statfs.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  #ifdef CONFIG_NTFS3_LZX_XPRESS
>  #include "lib/lib.h"
> @@ -772,7 +770,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  		/* No way to use ntfs_get_block in this case. */
>  		ntfs_err(
>  			sb,
> -			"Failed to mount 'cause NTFS's cluster size (%u) is less than media sector size (%u)",
> +			"Failed to mount 'cause NTFS's cluster size (%u) is less than media's sector size (%u)",
>  			sbi->cluster_size, sector_size);
>  		goto out;
>  	}
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 111355692163..0673ba5e8c43 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -10,8 +10,6 @@
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/xattr.h>
>  
> -#include "debug.h"
> -#include "ntfs.h"
>  #include "ntfs_fs.h"
>  
>  // clang-format off
> -- 
> 2.33.0
> 
