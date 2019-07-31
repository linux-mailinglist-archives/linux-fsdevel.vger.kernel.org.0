Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD927CB1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfGaR5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:57:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36155 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfGaR5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:57:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so56530850wme.1;
        Wed, 31 Jul 2019 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T31WwXYsxgU8fO97C5XG4W+sh6cfy84Mun+fk+tA2/o=;
        b=sX/iidQk0dUvgAG6y3YxYqtNQUGhiSU4kesR+IvEkmGd43zb5yH6iziI4AciHJLuB8
         jq27iR560vhwkgZCmbqw2Je1yW+Glpfp0dKwf5KLywXz2ZSn8Li2tBGqOqePW+xGWTT9
         9zRVLdAq1jm2GwIvZDS6GGhcZ4E66o84q9qvMCvAkS7epxWPvj9ObnL1irGDJ5nSAuSD
         b/ugzxNL8zkMW5ROxvQLKq3Ijn6bhJJUPFv/M3qXMItq8ZqEPNdPSP05qYSRkm46NAXH
         ZbgOwyH25TbHMsHaiGcmUGz54DBcaBKXGptYzB76c6vs524bh+5aO3gkpwluOh9QpN6/
         b7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T31WwXYsxgU8fO97C5XG4W+sh6cfy84Mun+fk+tA2/o=;
        b=mJBidjI7Z7nO54tn1mF0Kg7WpBVcA6AKE08EliHXVHB6dRdF313sNTV3OKLbVSObXy
         6Yc3v5f2X2rYwNqo4Cxb+FLdKDXg0AKDuBDOmpujdlsJZnsPMiqaW8OizX/rW9Oej0cT
         pbfIRqAsG4OGcsm+4+MZoKOT/WAc4oJHOteaH2ngultyY97CaHYFB9KjcpdaaY5O1SAn
         XL+F6Ac/4Ny8X0j3biEvauuchPpg60qbVVjDMphQWK36h8MpJjCP+AJNstnRVevnlcYR
         mbA5k9my3XTLMTNjR+yy9xHIGsQRCfM1zvoIP6ooDIrLkS9BHgQ7rT6V7QnHH8/BM7Kt
         bhRg==
X-Gm-Message-State: APjAAAV/cGj0oPYBqcqb/ABv0L7Nqq21AQmrN6+a7a4WH4s4nHi9vLM3
        6uFcqI/zJjb5GeebBodnr2A=
X-Google-Smtp-Source: APXvYqws+uruLILu52nsmChy6L/7Y5vDVpAORnwVLHjBO84u5ZfNuvY1CLOr83vx9GkjBUtLI/QOlw==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr62622176wmh.76.1564595871090;
        Wed, 31 Jul 2019 10:57:51 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c6sm70486993wma.25.2019.07.31.10.57.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:57:50 -0700 (PDT)
Date:   Wed, 31 Jul 2019 10:57:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 3/3] f2fs: Support case-insensitive file name lookups
Message-ID: <20190731175748.GA48637@archlinux-threadripper>
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723230529.251659-4-drosen@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

<snip>

> diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
> index cc82f142f811f..99e79934f5088 100644
> --- a/fs/f2fs/hash.c
> +++ b/fs/f2fs/hash.c
> @@ -14,6 +14,7 @@
>  #include <linux/f2fs_fs.h>
>  #include <linux/cryptohash.h>
>  #include <linux/pagemap.h>
> +#include <linux/unicode.h>
>  
>  #include "f2fs.h"
>  
> @@ -67,7 +68,7 @@ static void str2hashbuf(const unsigned char *msg, size_t len,
>  		*buf++ = pad;
>  }
>  
> -f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
> +static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
>  				struct fscrypt_name *fname)
>  {
>  	__u32 hash;
> @@ -103,3 +104,35 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
>  	f2fs_hash = cpu_to_le32(hash & ~F2FS_HASH_COL_BIT);
>  	return f2fs_hash;
>  }
> +
> +f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
> +		const struct qstr *name_info, struct fscrypt_name *fname)
> +{
> +#ifdef CONFIG_UNICODE
> +	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
> +	const struct unicode_map *um = sbi->s_encoding;
> +	int r, dlen;
> +	unsigned char *buff;
> +	struct qstr *folded;
> +
> +	if (name_info->len && IS_CASEFOLDED(dir)) {
> +		buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
> +		if (!buff)
> +			return -ENOMEM;
> +
> +		dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
> +		if (dlen < 0) {
> +			kvfree(buff);
> +			goto opaque_seq;
> +		}
> +		folded->name = buff;
> +		folded->len = dlen;
> +		r = __f2fs_dentry_hash(folded, fname);
> +
> +		kvfree(buff);
> +		return r;
> +	}
> +opaque_seq:
> +#endif
> +	return __f2fs_dentry_hash(name_info, fname);
> +}

Clang now warns:

fs/f2fs/hash.c:128:3: warning: variable 'folded' is uninitialized when used here [-Wuninitialized]
                folded->name = buff;
                ^~~~~~
fs/f2fs/hash.c:116:21: note: initialize the variable 'folded' to silence this warning
        struct qstr *folded;
                           ^
                            = NULL
1 warning generated.

I assume that it wants to be initialized with f2fs_kzalloc as well but
I am not familiar with this code and what it expects to do.

Please look into this when you get a chance!
Nathan
