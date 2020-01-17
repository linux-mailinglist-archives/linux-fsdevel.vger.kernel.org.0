Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640B3140614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 10:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgAQJd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 04:33:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41638 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgAQJdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:33:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so21622725eds.8;
        Fri, 17 Jan 2020 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jSBTkJwtcUerpe5D53vGoy3o8kE/mglpH/syhpG7qgc=;
        b=Dae11mxXI7xzPj9oLj+8qe2n1K9uZRbfEULM8ZnQ8VthlUUa3g9WGpEutXAx75Dila
         RzuEcvtPCbDSHztA3G6JJN+efdyBqbw5VUYD8noVZQklvaC2r3reAD696Wq5rmtr0VHR
         C3cfehhQ8rl5VORtFPRQpnjkgqPqkcjvPu/WmqCIBwcfuKQ/PLrn0NExhoDrdGA67gZb
         mlQ6VzxBzjsm5y+MLPoxu8pMpenZvTlPcyluAyS70IdZnkBw1BWvLIUzzNVx4B/r9wfA
         bifmWiXV7o3MK8Jka9Nr1tvR6i2r9F59oOPOGNcn205jec2wmcqfJJOJylr2XSZ5Zl4J
         DVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jSBTkJwtcUerpe5D53vGoy3o8kE/mglpH/syhpG7qgc=;
        b=iEprUu5xbtsJzy0X3zV/pA2Iq6lDbOHy0Z/FDq4DsAKF9wq88Ah3hp/P9b38eHE8W1
         Hy4JlIJwfOmDTeS/hNrHr5kVVlLsbgC3E8ZVBaHnSbV7fYMS2/T7l2sw4OdTPLSiwTYf
         Pj5XOEKNasPTC8U7pRFQnQuvSwfca78A3Ib9HyMYmZI69DcnV/Sfjf24x1kobzAAwMi3
         EK4ISSVLNaA0tFkDp/p/e4eOPIas6kX2nN35EhBfsNivl15ukfXXE4/b2QMdozbCNmWc
         TOMEb77c4tSHgzjhMCBGYM/LgYYyjTm65aX4ufs2JFvW8D1tdJL2ezZG+QQWHamqFJYV
         uZ/A==
X-Gm-Message-State: APjAAAUulZpBsICVLZKPVqTRAr3kcjwZwIeyFJ38+4ObyW8Kzpr+yegK
        yb+RCHscOabjEw5G0afgSJPWONZM
X-Google-Smtp-Source: APXvYqy3/PrY1adqexEo9QZ4ojVjDe/bPHeUwG0RJarlzo6SmgKei80eBsp7arJuV0Ogq5+Qyayptw==
X-Received: by 2002:adf:e591:: with SMTP id l17mr2007406wrm.139.1579253128997;
        Fri, 17 Jan 2020 01:25:28 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x10sm32358781wrv.60.2020.01.17.01.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:25:28 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:25:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 03/14] exfat: add inode operations
Message-ID: <20200117092527.5m4i2fvo7mge7z37@pali>
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
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> new file mode 100644
> index 000000000000..56cf09db1920
> --- /dev/null
> +++ b/fs/exfat/inode.c
> @@ -0,0 +1,667 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/buffer_head.h>
> +#include <linux/mpage.h>
> +#include <linux/bio.h>
> +#include <linux/blkdev.h>
> +#include <linux/time.h>
> +#include <linux/writeback.h>
> +#include <linux/uio.h>
> +#include <linux/random.h>
> +#include <linux/iversion.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +static int __exfat_write_inode(struct inode *inode, int sync)
> +{
> +	int ret = -EIO;
> +	unsigned long long on_disk_size;
> +	struct exfat_dentry *ep, *ep2;
> +	struct exfat_entry_set_cache *es = NULL;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	bool is_dir = (ei->type == TYPE_DIR) ? true : false;
> +
> +	if (inode->i_ino == EXFAT_ROOT_INO)
> +		return 0;
> +
> +	/*
> +	 * If the indode is already unlinked, there is no need for updating it.
> +	 */
> +	if (ei->dir.dir == DIR_DELETED)
> +		return 0;
> +
> +	if (is_dir && ei->dir.dir == sbi->root_dir && ei->entry == -1)
> +		return 0;
> +
> +	exfat_set_vol_flags(sb, VOL_DIRTY);
> +
> +	/* get the directory entry of given file or directory */
> +	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES,
> +		&ep);
> +	if (!es)
> +		return -EIO;
> +	ep2 = ep + 1;
> +
> +	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
> +
> +	/* set FILE_INFO structure using the acquired struct exfat_dentry */
> +	exfat_set_entry_time(sbi, &inode->i_ctime,
> +			&ep->dentry.file.create_time,
> +			&ep->dentry.file.create_date,
> +			&ep->dentry.file.create_tz);

And here is missing updating of create_time_ms entry too.

> +	exfat_set_entry_time(sbi, &inode->i_mtime,
> +			&ep->dentry.file.modify_time,
> +			&ep->dentry.file.modify_date,
> +			&ep->dentry.file.modify_tz);

And here modify_time_ms too.

> +	exfat_set_entry_time(sbi, &inode->i_atime,
> +			&ep->dentry.file.access_time,
> +			&ep->dentry.file.access_date,
> +			&ep->dentry.file.access_tz);
> +
> +	/* File size should be zero if there is no cluster allocated */
> +	on_disk_size = i_size_read(inode);
> +
> +	if (ei->start_clu == EXFAT_EOF_CLUSTER)
> +		on_disk_size = 0;
> +
> +	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
> +	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
> +
> +	ret = exfat_update_dir_chksum_with_entry_set(sb, es, sync);
> +	kfree(es);
> +	return ret;
> +}

-- 
Pali Rohár
pali.rohar@gmail.com
