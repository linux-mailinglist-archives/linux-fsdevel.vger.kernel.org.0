Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5D3B673B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhF1RHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhF1RHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:07:09 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D45C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 10:04:43 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so11586658otq.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hpONEaqBQxYmSiWEo61ED+3hk4MhjvI97ewhAU4t6GU=;
        b=bZBAb0DSlifI363pN+eHQygNAljNHZLMGUMQlRKFEgSLWmYNpsMeXFEg/hmRqmHaRs
         2qX+bwY9ifACVFK1FPt2OsbhQP60C+ra2dhBGOcyamI1MFz21xPlgxUJKfBf1n+Jgpba
         9Fsz0lAwYiGzR01C8TqNwmDoTeEA1z8gpm4jdr7DMIr5UyzW6kMSJxNBW3kGpE46gemJ
         bMe059GGXMzUFHKpZKP1jNsAQcnDas1UDtzsFVMqd3CihOLrwkfZuK1iwERXe1bAck7G
         zSgc1xbv095juale+9GSf4gYD1EESw6rZiDWEK2s3UGxLa2hURnhLQfLlkuDKM0fblN3
         E+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hpONEaqBQxYmSiWEo61ED+3hk4MhjvI97ewhAU4t6GU=;
        b=mZoXoQJFYrNG+dnKaZ6D/bBBWQ3QrJjJnzyIyZENyhegFzcGycJGReb4Z6C/9gj2NY
         8FxdARm2V/RhHl9eBttMZ7jiTTm9t2N7b8s+bmUKU5rx8k2vpGZi5xRoC2bgCTZWX7yC
         wipaoMle83YzYkmCyC6D+3gmbKSxhUNG8xaByaU0c9MnMW470aRfa12s2F0BAr7CtXKv
         8GLpyRCq9P4ez/SPfqDrmhDOU7x4C0qRJAcbYLSL0yLtrqpVa6yesNlNxTzrKWBSrifo
         wnsMpSoua/APvBzlDQbeo5GzMoCaOxjtnC5TsshJbFweQQrpAEGRIQAwBuRBBlvYgNyk
         fAmw==
X-Gm-Message-State: AOAM533lwqhvksSQ6wYlX397S+/hfG7HpD8vIYdBhuJoRJwl+yqNrc07
        ws/ANA2zoL2NvJ1l1r0cc48B8Q==
X-Google-Smtp-Source: ABdhPJy6nRb5Z1qTNbUyn2i9bQELzg0tfg2eWubMvuuvR370zfsSgBHmnp/yX2j52eEc+U6ird/PeA==
X-Received: by 2002:a05:6830:90c:: with SMTP id v12mr483880ott.7.1624899882849;
        Mon, 28 Jun 2021 10:04:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:f8e3:a853:8646:6bc8])
        by smtp.gmail.com with ESMTPSA id w12sm3068450oor.35.2021.06.28.10.04.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:04:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] hfsplus: report create_date to kstat.btime
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210416172147.8736-1-cccheng@synology.com>
Date:   Mon, 28 Jun 2021 10:04:39 -0700
Cc:     christian.brauner@ubuntu.com,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        jamorris@linux.microsoft.com, axboe@kernel.dk,
        cccheng@synology.com, Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E07732F5-A3AA-4E32-80C4-8020E2086987@dubeyko.com>
References: <20210416172147.8736-1-cccheng@synology.com>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 16, 2021, at 10:21 AM, Chung-Chiang Cheng <shepjeng@gmail.com> =
wrote:
>=20
> The create_date field of inode in hfsplus is corresponding to =
kstat.btime
> and could be reported in statx.
>=20
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
> fs/hfsplus/inode.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 078c5c8a5156..aab3388a0fd7 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -278,6 +278,11 @@ int hfsplus_getattr(struct user_namespace =
*mnt_userns, const struct path *path,
> 	struct inode *inode =3D d_inode(path->dentry);
> 	struct hfsplus_inode_info *hip =3D HFSPLUS_I(inode);
>=20
> +	if (request_mask & STATX_BTIME) {
> +		stat->result_mask |=3D STATX_BTIME;
> +		stat->btime =3D hfsp_mt2ut(hip->create_date);
> +	}
> +
> 	if (inode->i_flags & S_APPEND)
> 		stat->attributes |=3D STATX_ATTR_APPEND;
> 	if (inode->i_flags & S_IMMUTABLE)
> --=20
> 2.25.1
>=20

Looks good for me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

