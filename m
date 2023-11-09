Return-Path: <linux-fsdevel+bounces-2507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC47E6B07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2278281107
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8131A27E;
	Thu,  9 Nov 2023 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFH82BDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BB18C29
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:11:45 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9DA1FEB;
	Thu,  9 Nov 2023 05:11:45 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so319976241.2;
        Thu, 09 Nov 2023 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699535504; x=1700140304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvkssMDeIaGaw47ancvBHINlm0zu53iwpqFripVzOlY=;
        b=JFH82BDq/jeLNPTqZWuVZrQqzLaQlc8ZLmnCWqzh4Q9PTeLcKuShwr9fboOHaJtsMn
         apoKWjYR4j8TyGXzL1Gb39oJ3Mj3IGnQiphh29RrnZwVOEaunsEWoWMvIHKIIUkGAgDW
         0CFo88v44lbzEsbKTun34RLF0A+IZuP23v/gw4WtdmZ3ePxMkvbl7Z69cl6rE62cFMoz
         t1CpOraJS+KlJfpLzjMB81LJGO0nfTqslnJJdRPLVZoVRndCL348eCs2uTgQmI9LHR2/
         NhSAlWmKdoYzkf5H8p8pWWYu9JMQqyeEUkhUq+M9XGWV/nxy1Va3AWruxqJGOykhdWvj
         8PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535504; x=1700140304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvkssMDeIaGaw47ancvBHINlm0zu53iwpqFripVzOlY=;
        b=iO07aQn0RyJ1CgfC0yjSTx/MYgMGKtyT97idrOJH9z5NYWfGTswwqP00YBoPykgnp1
         wJJB7ceNKNlwKXbo5eTqBF2jp8DFTGYwgq3WSW+jHTg2kIRJo2Q6/4JM0040KwW9egaB
         SQ6Bpcde63sg2cULAh3otrS7onriMKfQpYwbbfIP6rmdPT41yy0CM4ydq544rr09wjEe
         j+lJW1ADi4wIbjk89BqyjZ7cSxhveXwVBP854iMLshphCN/xRo9YrIAIz2ldk3XTQjwq
         7mgIjqulZVqMmyqvy9p/q0V6owt/wd9hpsj6v74cprSYNsSnH+1rwcpwjGPg2XPkizqE
         OuEg==
X-Gm-Message-State: AOJu0YxdBSmZPYFweT7JxwpQJzaJBYAjrBOZBU3+CGJyICK4m6RgBMTj
	pQTPMObi6bhiO61/Zu2nqH90KJwvubRDFejpyubYXbWMgjw=
X-Google-Smtp-Source: AGHT+IHNxCrVzzKqd6b0wdGufR0o6T6sn4oZ6aN0+VTd8EvYMCGFK2EgjaRk0MRIotBC6zBg0Idv04qxZNhnXnervG8=
X-Received: by 2002:a05:6102:109d:b0:45e:461e:e59c with SMTP id
 s29-20020a056102109d00b0045e461ee59cmr4502569vsr.34.1699535504188; Thu, 09
 Nov 2023 05:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106173903.1734114-1-willy@infradead.org> <20231106173903.1734114-12-willy@infradead.org>
In-Reply-To: <20231106173903.1734114-12-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 9 Nov 2023 22:11:27 +0900
Message-ID: <CAKFNMomYhk2D6F9=mee4=H_QtvrfWYYSsiXrKjCms8pz61xhAQ@mail.gmail.com>
Subject: Re: [PATCH 11/35] nilfs2: Convert nilfs_page_mkwrite() to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:39=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Using the new folio APIs saves seven hidden calls to compound_head().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/file.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

I'm still in the middle of reviewing this series, but I had one
question in a relevant part outside of this patch, so I'd like to ask
you a question.

In block_page_mkwrite() that nilfs_page_mkwrite() calls,
__block_write_begin_int() was called with the range using
folio_size(), as shown below:

        end =3D folio_size(folio);
        /* folio is wholly or partially inside EOF */
        if (folio_pos(folio) + end > size)
                end =3D size - folio_pos(folio);

        ret =3D __block_write_begin_int(folio, 0, end, get_block, NULL);
        ...

On the other hand, __block_write_begin_int() takes a folio as an
argument, but uses a PAGE_SIZE-based remainder calculation and BUG_ON
checks:

int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
                get_block_t *get_block, const struct iomap *iomap)
{
        unsigned from =3D pos & (PAGE_SIZE - 1);
        unsigned to =3D from + len;
        ...
        BUG_ON(from > PAGE_SIZE);
        BUG_ON(to > PAGE_SIZE);
        ...

So, it looks like this function causes a kernel BUG if it's called
from block_page_mkwrite() and folio_size() exceeds PAGE_SIZE.

Is this constraint intentional or temporary in folio conversions ?

Regards,
Ryusuke Konishi

>
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 740ce26d1e76..bec33b89a075 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -45,34 +45,36 @@ int nilfs_sync_file(struct file *file, loff_t start, =
loff_t end, int datasync)
>  static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
> -       struct page *page =3D vmf->page;
> +       struct folio *folio =3D page_folio(vmf->page);
>         struct inode *inode =3D file_inode(vma->vm_file);
>         struct nilfs_transaction_info ti;
> +       struct buffer_head *bh, *head;
>         int ret =3D 0;
>
>         if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
>                 return VM_FAULT_SIGBUS; /* -ENOSPC */
>
>         sb_start_pagefault(inode->i_sb);
> -       lock_page(page);
> -       if (page->mapping !=3D inode->i_mapping ||
> -           page_offset(page) >=3D i_size_read(inode) || !PageUptodate(pa=
ge)) {
> -               unlock_page(page);
> +       folio_lock(folio);
> +       if (folio->mapping !=3D inode->i_mapping ||
> +           folio_pos(folio) >=3D i_size_read(inode) ||
> +           !folio_test_uptodate(folio)) {
> +               folio_unlock(folio);
>                 ret =3D -EFAULT;  /* make the VM retry the fault */
>                 goto out;
>         }
>
>         /*
> -        * check to see if the page is mapped already (no holes)
> +        * check to see if the folio is mapped already (no holes)
>          */
> -       if (PageMappedToDisk(page))
> +       if (folio_test_mappedtodisk(folio))
>                 goto mapped;
>
> -       if (page_has_buffers(page)) {
> -               struct buffer_head *bh, *head;
> +       head =3D folio_buffers(folio);
> +       if (head) {
>                 int fully_mapped =3D 1;
>
> -               bh =3D head =3D page_buffers(page);
> +               bh =3D head;
>                 do {
>                         if (!buffer_mapped(bh)) {
>                                 fully_mapped =3D 0;
> @@ -81,11 +83,11 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault =
*vmf)
>                 } while (bh =3D bh->b_this_page, bh !=3D head);
>
>                 if (fully_mapped) {
> -                       SetPageMappedToDisk(page);
> +                       folio_set_mappedtodisk(folio);
>                         goto mapped;
>                 }
>         }
> -       unlock_page(page);
> +       folio_unlock(folio);
>
>         /*
>          * fill hole blocks
> @@ -105,7 +107,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault =
*vmf)
>         nilfs_transaction_commit(inode->i_sb);
>
>   mapped:
> -       wait_for_stable_page(page);
> +       folio_wait_stable(folio);
>   out:
>         sb_end_pagefault(inode->i_sb);
>         return vmf_fs_error(ret);
> --
> 2.42.0
>

