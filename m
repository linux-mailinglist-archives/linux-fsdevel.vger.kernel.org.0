Return-Path: <linux-fsdevel+bounces-5982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ADA811A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383BA1F21B13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9613A28E;
	Wed, 13 Dec 2023 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iumBcq/K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E11DD;
	Wed, 13 Dec 2023 08:52:11 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b9f8c9307dso4072632b6e.0;
        Wed, 13 Dec 2023 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486331; x=1703091131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn2LQrRHuyBOrFQpLnvxY7FFQLx8DGIahG91siXRMzA=;
        b=iumBcq/Ko9g9IGTv7WNxZ1AJfjAa0TDZBcG4SrrYM6iA8qRTYBLsspfu6aSaVK1/va
         eU5cEii19tGFK63eiBntIRkUXmOo1Ce3DzughblmvECtmo0I7JIDnwoA4Tu1qEBuUx+3
         acslsa3D23Hm2tDKmhKdk+KBXeqQUlA+NS28KDPfNO2EpOlmkae+lvh1HqpfL70qErQe
         MfS5CFpsDvUflpwmqrLOMP2kDX+IZKCnThj9jwp+fQFUBpeigNlxu2Vkpyt1RZcsgl7N
         TlO7wV7wrdJY66wvUQoi/MbnveAYhZAiOEV8HUkW0M+dyiPHasIqBiPJyN0ieRWVqfVH
         hwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486331; x=1703091131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn2LQrRHuyBOrFQpLnvxY7FFQLx8DGIahG91siXRMzA=;
        b=CspCd7xKrmdjP+lfjBt2ga20KIY2PD86HqJwmp+7O0pdrT6wS2XQW2gN0yVP+7drQh
         2XbVYmRtnnv9MMC0CZFpRcvhxH91Aki/+CCnrP1+XaqCjcAYV6+JPlE8c+Ezd5PBh/Je
         3+S99R6bPzokS61ciWzThJHv5ZitLlrF3KcGuV2OC8Lzexb+1A6jQdVeuMUWINq35Dm7
         dmAM+f8EGUQPzj0R4DHIT0KBsFghPyQEL6HhJYrStNx71X80HBy5uDvPK3pXTO7g2mnb
         JkPqtVncSSaOldaOoy5Ltm86Wfb+0mAPn4F8C/DTCNHFJfD9xDUX1vn6ie/IWNuQefp/
         dxgg==
X-Gm-Message-State: AOJu0YxXwmVVZEWSZ5VHqEOgJjPYp01ARfdB3kvrI0HCQCvx2G7WbRqm
	0341XTGHEvUsVrHmwpsc7a/dGDs0a3j7SuxMsRU=
X-Google-Smtp-Source: AGHT+IGQVaLaZCAEUxZCneLTseyDtM91xFC+skaNgPLS4wOnX+qIuGenyGOaibcb8Lxy82isx1azUCGNBOSqVaoeMic=
X-Received: by 2002:a05:6870:ed8b:b0:1fb:75c:3ff1 with SMTP id
 fz11-20020a056870ed8b00b001fb075c3ff1mr11041512oab.81.1702486331103; Wed, 13
 Dec 2023 08:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213150703.6262-1-bschubert@ddn.com>
In-Reply-To: <20231213150703.6262-1-bschubert@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Dec 2023 18:51:59 +0200
Message-ID: <CAOQ4uxh3KqagHvLMV5PxUeeW9Sk8kY3pmg-k+OhXtjwtr_Cccw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	Hao Xu <howeyxu@tencent.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dharmendra Singh <dsingh@ddn.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 5:07=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> There were multiple issues with direct_io_allow_mmap:
> - fuse_link_write_file() was missing, resulting in warnings in
>   fuse_write_file_get() and EIO from msync()
> - "vma->vm_ops =3D &fuse_file_vm_ops" was not set, but especially
>   fuse_page_mkwrite is needed.
>
> The semantics of invalidate_inode_pages2() is so far not clearly defined
> in fuse_file_mmap. It dates back to
> commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
> Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVAT=
E
> only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
> and writes out dirty pages, it should be save to call

typo: safe to call...

> invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.
>
> Cc: Hao Xu <howeyxu@tencent.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: e78662e818f9 ("fuse: add a new fuse init flag to relax restriction=
s in no cache mode")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>  fs/fuse/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a660f1f21540..174aa16407c4 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2475,7 +2475,10 @@ static int fuse_file_mmap(struct file *file, struc=
t vm_area_struct *vma)
>
>                 invalidate_inode_pages2(file->f_mapping);
>
> -               return generic_file_mmap(file, vma);
> +               if (!(vma->vm_flags & VM_MAYSHARE)) {
> +                       /* MAP_PRIVATE */
> +                       return generic_file_mmap(file, vma);
> +               }
>         }
>
>         if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
> --
> 2.40.1
>

