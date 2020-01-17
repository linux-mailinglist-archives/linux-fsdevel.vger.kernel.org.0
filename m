Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6EB1408C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAQLRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:17:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAQLRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:17:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so22361574wru.4;
        Fri, 17 Jan 2020 03:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lb6HArX/g/KCKLiMjLu+XY17yFYbcyDDPVo4BbaNQSA=;
        b=lXaFjflMUG4KgT+rHlgrZ2J6LX3z9dCr8qA60GhCyRv+braKqnWg2MZC3qFFx5VGbt
         Q2v1pDIdvpR2I4FQoWw4/JRe+ZlCdYXP/IXQszlbox2QbN90fb4K1kxMXDA4Rz1FCOFB
         X4zbsiEG0Ahox5iTJqmx1WMlmmOrxhfCwuiq2qAJxOPa2cIHYm/mPsX/TmpMINCiT1LH
         xMVChRQ05te11fUbNPK9x8ZD+jh5Kp29Zg9RhAi2YRVKNZs7iWwsJN5w1mzzN1TbIDqq
         yS6ZBGr1ImR1g+JTUAi0RS11cX7l+NDOKGN0Et5fvExSC5tGbFmKSywr+0BLscG2CGij
         Yv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lb6HArX/g/KCKLiMjLu+XY17yFYbcyDDPVo4BbaNQSA=;
        b=k++LrseueUmZGgp7Jn/ZpBMRr9TABX7L/ul8UVPQjVAMtK05rTXhzC2TjaE1SQe/Yq
         jNZkFvUD01o6hNBkyJ+U7mz7TOKd09tg/ObwSnXOBTAJW206NTSCpkrylIthgdIJydRf
         i1duf55xSUfGcSB5lpMc2Qnf1NConChI8rtLa1aAixmyTYwJbly9hDZiAI8P1L3f4clp
         6sbkY2YwL7ooNZWSqJy3J3m/9K3SMZTxP0ShPg1GhLq0cXkV3GGrAk+XotC3Aa6jvyAv
         PLcI/z85y0f66KN6xCsFugFAfDAqKKtWWikFQtkqYJFMcJ6YZCHocfGhyt/mC/QQnTCP
         yyDQ==
X-Gm-Message-State: APjAAAUd0LSYI0mqdgKcPni9vfpmKIFFG0QHNehQ7LNLxhBgjE9thBCn
        KmRFW/1SxzhYWb7IRulMq8I=
X-Google-Smtp-Source: APXvYqykJEE5W6CkA+zQNXrcARlTK82n1dxVOTXXCX4nxgev1aRy2vD4CFEiHWUELiH1xO/i5uypvw==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr2427569wro.194.1579259832362;
        Fri, 17 Jan 2020 03:17:12 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p18sm8936190wmg.4.2020.01.17.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:17:11 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:17:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 03/14] exfat: add inode operations
Message-ID: <20200117111710.pfo4k53vay4fhkoo@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082820epcas1p34ebebebaf610fd61c4e9882fca8ddbd5@epcas1p3.samsung.com>
 <20200115082447.19520-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115082447.19520-4-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 17:24:36 Namjae Jeon wrote:
> This adds the implementation of inode operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/inode.c |  667 +++++++++++++++++++++
>  fs/exfat/namei.c | 1442 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2109 insertions(+)
>  create mode 100644 fs/exfat/inode.c
>  create mode 100644 fs/exfat/namei.c
> 

...

> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> new file mode 100644
> index 000000000000..7298de74e9b8
> --- /dev/null
> +++ b/fs/exfat/namei.c

...

> +/* lookup a file */
> +static int exfat_find(struct inode *dir, struct qstr *qname,
> +		struct exfat_dir_entry *info)
> +{

...

> +
> +		exfat_get_entry_time(sbi, &info->ctime,
> +				ep->dentry.file.create_time,
> +				ep->dentry.file.create_date,
> +				ep->dentry.file.create_tz);

Here is missing processing of create_time_ms.

> +		exfat_get_entry_time(sbi, &info->mtime,
> +				ep->dentry.file.modify_time,
> +				ep->dentry.file.modify_date,
> +				ep->dentry.file.modify_tz);

And here modify_time_ms.

> +		exfat_get_entry_time(sbi, &info->atime,
> +				ep->dentry.file.access_time,
> +				ep->dentry.file.access_date,
> +				ep->dentry.file.access_tz);
> +		kfree(es);
> +
> +		if (info->type == TYPE_DIR) {
> +			exfat_chain_set(&cdir, info->start_clu,
> +				EXFAT_B_TO_CLU(info->size, sbi), info->flags);
> +			count = exfat_count_dir_entries(sb, &cdir);
> +			if (count < 0)
> +				return -EIO;
> +
> +			info->num_subdirs = count + EXFAT_MIN_SUBDIR;
> +		}
> +	}
> +	return 0;
> +}

-- 
Pali Rohár
pali.rohar@gmail.com
