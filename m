Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8064443072B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Oct 2021 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbhJQIMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Oct 2021 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhJQIMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Oct 2021 04:12:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B13C061765;
        Sun, 17 Oct 2021 01:10:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n7so2698595ljp.5;
        Sun, 17 Oct 2021 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uVvk0GkTxHaq+zMgcywPyhp00COcyzzLvDsUILCtVnQ=;
        b=UXS43IeMFnuTbNf0Qx3NrjWUyJBLg0El+hSwvwbl7ZSDbO1ADomHLAd93j/07a4Djj
         u70rjjmyd0uMiQCkxBqHARA3EyWqnlGQV0leu8vXEAkb6clxBcspBgWsTh+h6MdZouXq
         /9t2TWyvpRJcwjsrXi1gGy2uX2CScM70vSYp2GI+WPKePpKhOWdsFo2HZNoXj4Zzh3Gr
         L1O38ov03wliUgnazRd8+SsaWbOjGLPTcsWMGuZw6XXezly/RnjPRASQsShGt0/hbxUl
         ORy08sM6uAEQdCFCP/XdejoJ3NKULDowqeY2EUnrqb4KF/CAELE4yZ8+UvK5aPkzwQzA
         uA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVvk0GkTxHaq+zMgcywPyhp00COcyzzLvDsUILCtVnQ=;
        b=G4ANFf7UUApHJhlY+RtM5W5i2qmtGGEd960oKgYAg3Wi68puTfZX3XvILcenECoFbA
         SIoyg1Am+nE9WjtiR+XiRJgalarZQai8UWNegpn+zqJ8uJycA3STnXagNL7aosVUwkiE
         W5RqM9UFO+n+ZiWmEFVjTA/9c+upGxUjP/PysCVdxfbNa3ad4OdHZJP29zCck7iWPkqA
         p6aUcyRpKxDWSRa0hZTuYwVBaFJd7CNQ1mUGwp5zymUuoFaSoSbBnQXQdVnzV2wBr9T1
         3JWOPi0TkG700zdXBLFZLSTa55BVnYxvRJjIw8dO8OqKT7tCvNUd2kFHmyyMc3XhtTW4
         clgw==
X-Gm-Message-State: AOAM533CKc0WSkO12+DwRX6qgM7hzFrgdo5YMao86WgArRnx/8omm2Io
        a10WUnEhdw4GbjS7+bBUZqpO/o472L0=
X-Google-Smtp-Source: ABdhPJzh1BYjoxhUnC+38CDk89mP0e2ywkEjhqSnAL9dbH+0/dkLRrAedtdTvbPRq8pNaNT3VJ2/Bw==
X-Received: by 2002:a2e:361a:: with SMTP id d26mr24619050lja.104.1634458230351;
        Sun, 17 Oct 2021 01:10:30 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t13sm1093053lfc.34.2021.10.17.01.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 01:10:29 -0700 (PDT)
Date:   Sun, 17 Oct 2021 11:10:27 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs/ntfs3: Rework ntfs_utf16_to_nls
Message-ID: <20211017081027.zxh2hbbxdk7ffwqn@kari-VirtualBox>
References: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
 <5f5a0b13-90bd-b97c-aa50-c646bb243bde@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5a0b13-90bd-b97c-aa50-c646bb243bde@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:47:03PM +0300, Konstantin Komarov wrote:
> Now ntfs_utf16_to_nls takes length as one of arguments.
> If length of symlink > 255, then we tried to convert
> length of symlink +- some random number.
> Now 255 symbols limit was removed.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/dir.c     | 19 ++++++++-----------
>  fs/ntfs3/ntfs_fs.h |  2 +-
>  2 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
> index 785e72d4392e..fb438d604040 100644
> --- a/fs/ntfs3/dir.c
> +++ b/fs/ntfs3/dir.c
> @@ -15,11 +15,10 @@
>  #include "ntfs_fs.h"
>  
>  /* Convert little endian UTF-16 to NLS string. */
> -int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
> +int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
>  		      u8 *buf, int buf_len)

I just like to point out that this patch break the build. We cannot
break build in any commit. If you make change you need to make sure
everything still works. This is of course now late, but I just bring it
up if you did not know it already.

Problem here is that you change callers to match this in patch 2/5. You
need to make it in same patch. Basically every patch should build it is
own and even all tests should work.

Reason here is git bisecting. We really want to easy way to bisect bugs
and if some commit break something then it make bisecting more
difficult.

I also wonder why 0day bot did not report this. Maybe because there was
no base or something, but I have to look into that as for now that is
only CI system we have. When we get ntfs3 to kernel.org then we also can
use patchwork and then my first thing to do is to start CI system that
reports results to patchwork.

I will use Snowpatch to fetch patches from patchwork and Jenkins to CI.

>  {
> -	int ret, uni_len, warn;
> -	const __le16 *ip;
> +	int ret, warn;
>  	u8 *op;
>  	struct nls_table *nls = sbi->options->nls;
>  
> @@ -27,18 +26,16 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
>  
>  	if (!nls) {
>  		/* UTF-16 -> UTF-8 */
> -		ret = utf16s_to_utf8s((wchar_t *)uni->name, uni->len,
> -				      UTF16_LITTLE_ENDIAN, buf, buf_len);
> +		ret = utf16s_to_utf8s(name, len, UTF16_LITTLE_ENDIAN, buf,
> +				      buf_len);
>  		buf[ret] = '\0';
>  		return ret;
>  	}
>  
> -	ip = uni->name;
>  	op = buf;
> -	uni_len = uni->len;
>  	warn = 0;
>  
> -	while (uni_len--) {
> +	while (len--) {
>  		u16 ec;
>  		int charlen;
>  		char dump[5];
> @@ -49,7 +46,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
>  			break;
>  		}
>  
> -		ec = le16_to_cpu(*ip++);
> +		ec = le16_to_cpu(*name++);
>  		charlen = nls->uni2char(ec, op, buf_len);
>  
>  		if (charlen > 0) {
> @@ -304,8 +301,8 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
>  	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
>  		return 0;
>  
> -	name_len = ntfs_utf16_to_nls(sbi, (struct le_str *)&fname->name_len,
> -				     name, PATH_MAX);
> +	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
> +				     PATH_MAX);
>  	if (name_len <= 0) {
>  		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
>  			  ino);
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 38b7c1a9dc52..9277b552f257 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -475,7 +475,7 @@ bool are_bits_set(const ulong *map, size_t bit, size_t nbits);
>  size_t get_set_bits_ex(const ulong *map, size_t bit, size_t nbits);
>  
>  /* Globals from dir.c */
> -int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
> +int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
>  		      u8 *buf, int buf_len);
>  int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
>  		      struct cpu_str *uni, u32 max_ulen,
> -- 
> 2.33.0
> 
> 
