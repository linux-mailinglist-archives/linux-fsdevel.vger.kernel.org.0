Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622E6350FE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDAHMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhDAHMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:12:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0FC0613E6;
        Thu,  1 Apr 2021 00:12:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h8so556233plt.7;
        Thu, 01 Apr 2021 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nxMNAPqfEecVrR9nsQ3IMQjDvIPPMionqLgGG/C5wWA=;
        b=aAdIzAP/zZ+sCtwAMULjg8RvFRaUxbhfDBsKNuVR/XLjizIfWzDd3hUB/KicPKPnaC
         02SG/m9gHQWaYwbykIIVmU8qS3ZSJfm+QB+hicInaV35nmphZneW5raMdoZelMgvkttF
         oainkJuCjUbTJZvnT/QBcGMX4czVcKORLF64O34qQKY1HgrcosMTkxDccPg6DMcHfres
         1wUAKSe4/3Ri9POKIIFzlUBoK+V3frEp3BNmCjuyE37qf1MTLnCc0j6/R+vhEM/06Lel
         SHcZnQkxyKsa/kFfguLzr9cVP1LeXG8Y2eTcOVZ+0STaexxY5wynMrBmA8M0GWfVCCX8
         GeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxMNAPqfEecVrR9nsQ3IMQjDvIPPMionqLgGG/C5wWA=;
        b=m2nboxFkwhg3SXXACFc37/y79qK5djnbUPntTPON39+vH3s04uFgGL7+FzWFAY7juS
         8bbCZF1CCGgrcMT8m0kasc+xlWOLNEcDCXs/W2I3sH20zUoRoPy5oiAxfoxcY7xn87/D
         BkCI6wEB0Q2GDNFtUw9uuc807nbXNvJvBvFCySUNVS8a278SGH04fUH1Lw+ZbOxSK9hO
         qIM9GjqUTivsc4mlwU5W6cRzMzoKUA66gtKUY7oeuC3toPdAlI/Cmnz1OqUHQnzl3s50
         PdxOs6VGR+mg6uvIXPec9kpuoeVRX6YmoaK0EriYAyLNUmTxRDFmjY5kPcFGVkXEfCVN
         s3FQ==
X-Gm-Message-State: AOAM531bf6/wwP3XE5P807xvK7d9ulbXzW6+Q82bHJBDqzD3tzuld+Fn
        QTF3OUqXg/mdeWVI+jcZOlQ=
X-Google-Smtp-Source: ABdhPJx54GLu44ceRw1VOt4nY0MtGnri8a1v/wQ/JC9/nOhtBatQ1/YNYXNfg6t3Zm5Ef8q/zt/jjA==
X-Received: by 2002:a17:90a:fa89:: with SMTP id cu9mr7702778pjb.204.1617261152822;
        Thu, 01 Apr 2021 00:12:32 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id v2sm4292271pjg.34.2021.04.01.00.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:12:32 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:42:30 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v3 07/10] iomap: Introduce iomap_apply2() for operations
 on two files
Message-ID: <20210401071230.wbrawpzk3opzmntv@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-8-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> Some operations, such as comparing a range of data in two files under
> fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
> we introduce iomap_apply2() to accept arguments from two files and
> iomap_actor2_t for actions on two files.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/iomap/apply.c      | 56 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |  7 +++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 26ab6563181f..fbc38ce3d5b6 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -97,3 +97,59 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>
>  	return written ? written : ret;
>  }
> +
> +loff_t
> +iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2, loff_t pos2,
> +		loff_t length, unsigned int flags, const struct iomap_ops *ops,
> +		void *data, iomap_actor2_t actor)
> +{
> +	struct iomap smap = { .type = IOMAP_HOLE };
> +	struct iomap dmap = { .type = IOMAP_HOLE };
> +	loff_t written = 0, ret, ret2 = 0;
> +	loff_t len1 = length, len2, min_len;
> +
> +	ret = ops->iomap_begin(ino1, pos1, len1, flags, &smap, NULL);
> +	if (ret)
> +		goto out_src;

if above call fails we need not call ->iomap_end() on smap.

> +	if (WARN_ON(smap.offset > pos1)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	if (WARN_ON(smap.length == 0)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	len2 = min_t(loff_t, len1, smap.length);
> +
> +	ret = ops->iomap_begin(ino2, pos2, len2, flags, &dmap, NULL);
> +	if (ret)
> +		goto out_dest;

ditto

> +	if (WARN_ON(dmap.offset > pos2)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	if (WARN_ON(dmap.length == 0)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	min_len = min_t(loff_t, len2, dmap.length);
> +
> +	written = actor(ino1, pos1, ino2, pos2, min_len, data, &smap, &dmap);
> +
> +out_dest:
> +	if (ops->iomap_end)
> +		ret2 = ops->iomap_end(ino2, pos2, len2,
> +				      written > 0 ? written : 0, flags, &dmap);
> +out_src:
> +	if (ops->iomap_end)
> +		ret = ops->iomap_end(ino1, pos1, len1,
> +				     written > 0 ? written : 0, flags, &smap);
> +

I guess, this maynot be a problem, but I still think we should be
consistent w.r.t len argument we are passing in ->iomap_end() for both type of
iomap_apply* family of functions.
IIUC, we used to call ->iomap_end() with the length argument filled by the
filesystem from ->iomap_begin() call.

whereas above breaks that behavior. Although I don't think this is FATAL, but
still it is better to be consistent with the APIs.
Thoughts?


> +	if (ret)
> +		return written ? written : ret;
> +
> +	if (ret2)
> +		return written ? written : ret2;
> +
> +	return written;
> +}

	if (written)
		return written;

	return ret ? ret : ret2;

Is above a simpler version?

-ritesh
