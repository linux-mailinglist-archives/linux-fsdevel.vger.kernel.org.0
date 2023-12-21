Return-Path: <linux-fsdevel+bounces-6752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9681B9E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C3288AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C64B13D;
	Thu, 21 Dec 2023 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr/DFr0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA36D6D7;
	Thu, 21 Dec 2023 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4669068a20bso188487137.1;
        Thu, 21 Dec 2023 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703170487; x=1703775287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pURYtu0NLCnQlpjaLQBb3A9CXAcN65Ivjf7L8viYZIQ=;
        b=fr/DFr0B2e2D5pVAdRa8efpUmsqmuL2g3QPZBhjlG3AKquL6JIi+P/pwiOurUM+Krp
         E8jOaHtXIoPU+ASnXxD/WU+K/VNMfFPqrfUx6VQ0rRmT8Mr0p+L2bMgQ33KT1YBpanT5
         7LW+1EkG89UMJ78nqCi0fjvxIugayr3H6l25dY2AWUI32pOCJnGtRXNP8lRmto9u4Cqs
         aciB5LcgZsEoAN9oMA78JVOUCDvrhJIDbtKIQMEHh50OdbB0R7f2UVJMOOy5PqhCQzsS
         xE2krxIQmkhbo+7kOqMqYuqO3ztnTdxpCUnTfodfTsslG18eVAluCR+r1lIebDLR/j+b
         B7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170487; x=1703775287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pURYtu0NLCnQlpjaLQBb3A9CXAcN65Ivjf7L8viYZIQ=;
        b=lMJq6webPomHaUSuC44KN+Y6mKw9tcqg9I7AXceK4Vfz31mvR/pofNbotUqLArlpJe
         WSu45gjs9Apoy+Wrnz6g7k5yX93fLOjeAn8ZltZzmHsUG74N+l/q1z7IFVETso8YouHt
         6Pg45PvHga0trHcwR6fb40c/uPoS/z5VNKUofjaUG8doHHYxriNCqtX+w6eISyhEk4qC
         6HGl/PYDWD5jvLKUs9nLHf9hJVwTLv1OpJ05StG5XIzt0biLqlDGAtaRFQOmebLWnXS3
         IpvGlxPQaHgZFNWK0SoJyCuGEFX50Lr44sSIqOph7QLFFytxw910U/L5DjX/Yoq47NuF
         1Pog==
X-Gm-Message-State: AOJu0YycRWFzlvy6n8Q6oniyXgpBkR93BXMRVhZsEh/zJqYpttIKdbKn
	J6XmrZk/cIVA96ISUxyt1zxfHzcAuwXdM2XyVDc=
X-Google-Smtp-Source: AGHT+IFN1NuYgs8WiPh35+AiECRKwSlqz0ZEDe3FqBLZ5rzeC9cKopqWDVql1xxie4BTiSGNKZ2Qkn8RU8vM8AW8lKI=
X-Received: by 2002:a05:6102:2c19:b0:466:a0dd:4b2 with SMTP id
 ie25-20020a0561022c1900b00466a0dd04b2mr1276429vsb.51.1703170487175; Thu, 21
 Dec 2023 06:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com> <20231221085839.1768763-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231221085839.1768763-1-yukuai1@huaweicloud.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 21 Dec 2023 23:54:30 +0900
Message-ID: <CAKFNMo=TuhzyEs_NEOdYgJz+UVizU6Ojx4ZKXowDaux3kKddUQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 12/17] nilfs2: use bdev api in nilfs_attach_log_writer()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de, 
	kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com, 
	josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com, willy@infradead.org, 
	akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 6:00=E2=80=AFPM Yu Kuai wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_device.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  fs/nilfs2/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 55e31cc903d1..a1130e384937 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2823,7 +2823,7 @@ int nilfs_attach_log_writer(struct super_block *sb,=
 struct nilfs_root *root)
>         if (!nilfs->ns_writer)
>                 return -ENOMEM;
>
> -       inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
> +       bdev_attach_wb(nilfs->ns_bdev);
>
>         err =3D nilfs_segctor_start_thread(nilfs->ns_writer);
>         if (unlikely(err))
> --
> 2.39.2
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

