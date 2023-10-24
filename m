Return-Path: <linux-fsdevel+bounces-1021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDB7D4F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DE51C20BFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE8266DE;
	Tue, 24 Oct 2023 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN3lF06b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94211731
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:04:19 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3A111;
	Tue, 24 Oct 2023 05:04:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so2883079a34.3;
        Tue, 24 Oct 2023 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698149057; x=1698753857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdqDVowVm4vnNj3OSVQUt5P0tkzU8HQzVTEFsc76Es8=;
        b=eN3lF06bNeEtBi4B9cEt+KN6DSRPc4XG9iaPaHjwGQmJ6GINuVA+Kw9IeAwUfkREo4
         7RuXDfAxURqtm2APqLBxRvJpKl9Q9bWsmiEDelPzKy0puXv2UonZ0Fmae1t3Oe6RTKPJ
         Tr/Afmsfj/A94gEKkzJeWrGV7dKFltvqI15hdKKEVqzpjGHJCIGqTKjoX+s9LlitM+DW
         Bbd8HzSs7JUBuYvdWBZE+DZd/x8vVepuW3N/EW9SYeuuQ0fToPpWmrZkUmWG2TObzJ0F
         VARr6oK7tv5YV+Mn3+O//YdTuEJKaZ+m9SoER92Yrte42ut3YH00tONVxXBRuUEFPmCC
         G1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149057; x=1698753857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdqDVowVm4vnNj3OSVQUt5P0tkzU8HQzVTEFsc76Es8=;
        b=kNU+iZpoJFsy2evh7XINUTgh1w48teiojbwdtAQVD4mN1O6bi8BoBVCNKIXhbFYLSh
         Uvkxz2AjvX4JZ9UGgCTUKaBl5njTgdHj8LRxuzyU+ZffFQyFKdY8zY/DVynt2VsGEAQq
         99cz69ks+f5kB1eRNgBWHQujkbpodCLCnmfnNBDqYHPH/wiaP4cCjQAgFUS9HxkAqsej
         HxBE/8tJ9hCoNMPhfRzJvpqRXmv2WDGNb8YnxohnKucDc0CeSAcX6GRPfIKHbdldG7iq
         LHTnfmPYuC7RE47hAR3rt2GFQ4/qFbfvBCP2Pg9WGfmB15bLgC0E9K4eWjdD3BfZgQBF
         F02Q==
X-Gm-Message-State: AOJu0YzhZj3qq8EeuIbhQTeoQaPq4FBpGe/Z6BMHzkUNM2KvxjVex5Jh
	44RRSo+iFleLineWcxKwnGYUP1h24pnP1EgL4MU=
X-Google-Smtp-Source: AGHT+IFXPmDa5xX/+B+xeenmgIN8wGat9sOFdAubKbu6QP2OEmcmhRBnTYWwZZzddG7MkH4oJNzU+ZRiDM3f8udM0Po=
X-Received: by 2002:a05:6808:2189:b0:3a4:225d:8135 with SMTP id
 be9-20020a056808218900b003a4225d8135mr15175785oib.31.1698149057531; Tue, 24
 Oct 2023 05:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024064416.897956-1-hch@lst.de> <20231024064416.897956-3-hch@lst.de>
In-Reply-To: <20231024064416.897956-3-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 24 Oct 2023 14:04:05 +0200
Message-ID: <CAOi1vP-=PMN_ae9qOK1H1HzS2y6=BEzkcd364MNo+5FeqhQb_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] block: update the stable_writes flag in bdev_add
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 8:44=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Propagate the per-queue stable_write flags into each bdev inode in bdev_a=
dd.
> This makes sure devices that require stable writes have it set for I/O
> on the block device node as well.
>
> Note that this doesn't cover the case of a flag changing on a live device
> yet.  We should handle that as well, but I plan to cover it as part of a
> more general rework of how changing runtime paramters on block devices
> works.
>
> Fixes: 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue and=
 a sb flag")
> Reported-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/bdev.c b/block/bdev.c
> index f3b13aa1b7d428..04dba25b0019eb 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -425,6 +425,8 @@ void bdev_set_nr_sectors(struct block_device *bdev, s=
ector_t sectors)
>
>  void bdev_add(struct block_device *bdev, dev_t dev)
>  {
> +       if (bdev_stable_writes(bdev))
> +               mapping_set_stable_writes(bdev->bd_inode->i_mapping);
>         bdev->bd_dev =3D dev;
>         bdev->bd_inode->i_rdev =3D dev;
>         bdev->bd_inode->i_ino =3D dev;
> --
> 2.39.2
>

Tested with RBD which behaves like a DIF/DIX device (i.e. requires
stable pages):

Tested-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

