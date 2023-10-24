Return-Path: <linux-fsdevel+bounces-1020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9E7D4F66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F9B20FE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591B266DE;
	Tue, 24 Oct 2023 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFHpxGxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746111731
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 12:03:50 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B19C122;
	Tue, 24 Oct 2023 05:03:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2e308a751so2231749b6e.0;
        Tue, 24 Oct 2023 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698149028; x=1698753828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYlPiD3AOm3kvpsnrRrWz5bHQ0jndJXS/Z3nE53cRKc=;
        b=IFHpxGxNgEi6jx3YlV7310YJLthxJNQ/04YJrCHzL0f1UNftVePCI5zKhs+xfpU0u+
         U+5Ru7U5VXbNZNHaHVv/K7oG5d25tlNLEn0ofFoee5VVAW8xf5KpacmE6tBFKKM3eTkF
         i2+jfrCPtNiWpUtx2yxty3+0yMHWItuYZ2U+k1sjWCbIhj+oq2ag5ksysPBij+SyFt/v
         9z7Gh9R7OEnbqyRqzGX4VvZopDiyOCPIY3Me3uvj0JjrFFWOF3z6jOJm9WK3p4fxEPry
         8nwjt2CyiUeeCU7Brp7BKJ0EigtXWYP77CuLO9UPMLQ+I7a7stAuqK5vYOki9dZp7VxX
         +Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149028; x=1698753828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYlPiD3AOm3kvpsnrRrWz5bHQ0jndJXS/Z3nE53cRKc=;
        b=PRN89wkKPzKz9kxaaZlAlgm5UtNpE4DeNgm3Z4R3TriZbVuzvuWSWlIdPPUXOUxqYs
         vuEn0Ir6ax/R0bBU0JjM6PJDSBcpbiYn0/HP0sZwyLSaSm5/ZoryziPTj+mzr9Pi4YHm
         vT/EUw1NfgB+xu325hXtIz+ZlgjUWxj1h/QlNoUuT5zWTM4XQkWg9G7aD99iPEKJAHG1
         itdFVFPvV3fsbFh5A/FaplTHF/I5Cjb55uoN0xM+fHcQ6FFFZPhEYVbA0CxoQSVTXLCj
         C3nay4Z1iHv8LEAeNGQEVl6gBrmpYzyvTlJDrlo9bl7qoV9sRo1/gNhUNMkTTJhkqUow
         2rbQ==
X-Gm-Message-State: AOJu0YzZNKd2ASbkMHq+1uQJxRXQkV9tr7sCs/PgaKuoU8GEStMwhdkH
	7z+2ltOrPVPy+AUQaIhEqvYtF523CBaHML6Vpbg=
X-Google-Smtp-Source: AGHT+IF7qHX8rlqEc78PjWgepBvMb5h/sz0mu0uPmIp5Ea9VNofsal6HGp4f37Ou4lMCfxNBgoUIDsLyx9ygI6cg3AA=
X-Received: by 2002:a05:6808:309c:b0:3b2:e9ae:5d50 with SMTP id
 bl28-20020a056808309c00b003b2e9ae5d50mr8956263oib.9.1698149028305; Tue, 24
 Oct 2023 05:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024064416.897956-1-hch@lst.de> <20231024064416.897956-2-hch@lst.de>
In-Reply-To: <20231024064416.897956-2-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 24 Oct 2023 14:03:36 +0200
Message-ID: <CAOi1vP_mF_A6OmNvYPvmBcS-CHQkwOHqsZ1oAZCJXQmow3QUMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] filemap: add a per-mapping stable writes flag
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 8:44=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> folio_wait_stable waits for writeback to finish before modifying the
> contents of a folio again, e.g. to support check summing of the data
> in the block integrity code.
>
> Currently this behavior is controlled by the SB_I_STABLE_WRITES flag
> on the super_block, which means it is uniform for the entire file system.
> This is wrong for the block device pseudofs which is shared by all
> block devices, or file systems that can use multiple devices like XFS
> witht the RT subvolume or btrfs (although btrfs currently reimplements
> folio_wait_stable anyway).
>
> Add a per-address_space AS_STABLE_WRITES flag to control the behavior
> in a more fine grained way.  The existing SB_I_STABLE_WRITES is kept
> to initialize AS_STABLE_WRITES to the existing default which covers
> most cases.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/inode.c              |  2 ++
>  include/linux/pagemap.h | 17 +++++++++++++++++
>  mm/page-writeback.c     |  2 +-
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 84bc3c76e5ccb5..ae1a6410b53d7e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -215,6 +215,8 @@ int inode_init_always(struct super_block *sb, struct =
inode *inode)
>         lockdep_set_class_and_name(&mapping->invalidate_lock,
>                                    &sb->s_type->invalidate_lock_key,
>                                    "mapping.invalidate_lock");
> +       if (sb->s_iflags & SB_I_STABLE_WRITES)
> +               mapping_set_stable_writes(mapping);
>         inode->i_private =3D NULL;
>         inode->i_mapping =3D mapping;
>         INIT_HLIST_HEAD(&inode->i_dentry);      /* buggered by rcu freein=
g */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 351c3b7f93a14e..8c9608b217b000 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,6 +204,8 @@ enum mapping_flags {
>         AS_NO_WRITEBACK_TAGS =3D 5,
>         AS_LARGE_FOLIO_SUPPORT =3D 6,
>         AS_RELEASE_ALWAYS,      /* Call ->release_folio(), even if no pri=
vate data */
> +       AS_STABLE_WRITES,       /* must wait for writeback before modifyi=
ng
> +                                  folio contents */
>  };
>
>  /**
> @@ -289,6 +291,21 @@ static inline void mapping_clear_release_always(stru=
ct address_space *mapping)
>         clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
>  }
>
> +static inline bool mapping_stable_writes(const struct address_space *map=
ping)
> +{
> +       return test_bit(AS_STABLE_WRITES, &mapping->flags);
> +}
> +
> +static inline void mapping_set_stable_writes(struct address_space *mappi=
ng)
> +{
> +       set_bit(AS_STABLE_WRITES, &mapping->flags);
> +}
> +
> +static inline void mapping_clear_stable_writes(struct address_space *map=
ping)

Hi Christoph,

Nit: mapping_clear_stable_writes() is unused.

> +{
> +       clear_bit(AS_STABLE_WRITES, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>  {
>         return mapping->gfp_mask;
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index b8d3d7040a506a..4656534b8f5cc6 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -3110,7 +3110,7 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
>   */
>  void folio_wait_stable(struct folio *folio)
>  {
> -       if (folio_inode(folio)->i_sb->s_iflags & SB_I_STABLE_WRITES)
> +       if (mapping_stable_writes(folio_mapping(folio)))
>                 folio_wait_writeback(folio);
>  }
>  EXPORT_SYMBOL_GPL(folio_wait_stable);
> --
> 2.39.2
>

Tested with RBD which behaves like a DIF/DIX device (i.e. requires
stable pages):

Tested-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

