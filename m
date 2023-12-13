Return-Path: <linux-fsdevel+bounces-5843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E084810FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E7E1C20967
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C123777;
	Wed, 13 Dec 2023 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaOAaiSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFCF7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:23:20 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f44cd99c6so468316185a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702466600; x=1703071400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+wJ9vFM/IgThXX52/0rZ/Tj2ItIG0ir2z1keB5SKVYg=;
        b=QaOAaiSaIvKjx2CncHSfsXh0dG2Absn9WEundkATiT85nZQCqN/MnAJNWEGZyHUM59
         +cCxHs4m9y4c+JpgR0mjE4m0XWAC2LIqlcl0l5YTWR5KB86OoOiKHdeyl0Ypc7062zgg
         HOGpFfoXbxHk6pczO3QZQ/2Aycp6y3r71kgYSvXwDvKGDyd0CILHxG7m7UAWaVCj8oXG
         SWW3QVd9u0LHMAcOs7Z6h8G3Q7utdtRqBiRPNsy4ApudTchGMSLXy1dYfxtx6+nSpbRh
         S2ZkesJzhFcDIPyDxPGcz6ZHXni8f9ARipD6QwtHgZXcVbX/HnrIuRnrJZYA+CBSFKEx
         3/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466600; x=1703071400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wJ9vFM/IgThXX52/0rZ/Tj2ItIG0ir2z1keB5SKVYg=;
        b=d96MEbymw8ZhGtzpnj9PPW5hsPPGMKk9UKfuxIDjTxlnZk9Ck6VzLDcfZi4PNFuZ9y
         wvjp8/Y7woOfJKVk99cXT+N1noEWrGLmLJu1JHFgxlwtlGsLUskjKB3WMdvl+L+Q0b0s
         2yMKh9qfNR4F4G8KvigIRM/zrcDO+ILAdDEyvindGuFJU4+4G1R1DxryVmDWf0cPvYKm
         t8oLsBS1z3rPKkjF4ff5CgaIL0GrQY3kwacA3E8kkbyX9QhGYBNT6IMoY+a2VEynkJDW
         b/tMFfOICg4V2S0BrqFKyw0YZFCoPqYMZlcMPzBOTk6S6QJWT6fUrqAMKnoNSAHrkecl
         e6kQ==
X-Gm-Message-State: AOJu0YzAf0nDUXLIPv/l/+JX4BtTE2Bj4b6RP4eitoxo1W+61QcngNc1
	CvFIacx3H8ZT3bZmxNwr7BgVWy9F3FIqrwU6kXzby/h8FII=
X-Google-Smtp-Source: AGHT+IH96AOR0QF8AO4ps2lU5vAQoetDsUoDJq7p0/XTsq3IxTcF7EnE7BFUqB0HOazoBouOthvXvqrpua9uo3VOQGg=
X-Received: by 2002:a05:620a:d58:b0:77e:fbba:645c with SMTP id
 o24-20020a05620a0d5800b0077efbba645cmr10224640qkl.59.1702466599800; Wed, 13
 Dec 2023 03:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm> <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm> <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm> <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm> <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm> <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <2e2f0cd1-99fe-4336-9cc8-47416be02451@fastmail.fm> <CAOQ4uxh=aBFEiBVBErEA_d+mWcTOysLgbgWVztSzL+D2BvMLdA@mail.gmail.com>
 <b48f7aae-cd84-4f7d-a898-f3552f1195ae@fastmail.fm>
In-Reply-To: <b48f7aae-cd84-4f7d-a898-f3552f1195ae@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Dec 2023 13:23:08 +0200
Message-ID: <CAOQ4uxjnSkZwgQNQTLiLK+juWKNo+ecVPcxm7ZPzPPZCxh0A0w@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	gmaglione@redhat.com, Max Reitz <hreitz@redhat.com>, Hao Xu <howeyxu@tencent.com>, 
	Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"

> >
> >     Thanks Amir, I'm going to look at it in detail in the morning.
> >     Btw, there is another bad direct_io_allow_mmap issue (part of it is
> >     invalidate_inode_pages2, which you already noticed, but not alone).
> >     Going to send out the patch once xfstests have passed
> >     https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c <https://github.com/bsbernd/linux/commit/3dae6b05854c4fe84302889a5625c7e5428cdd6c>
> >
> >
> > Nice!
> > But I think that invalidate pages issue is not restricted to shared mmap?
>
> So history for that is
>
> commit 3121bfe7631126d1b13064855ac2cfa164381bb0
> Author: Miklos Szeredi <mszeredi@suse.cz>
> Date:   Thu Apr 9 17:37:53 2009 +0200
>
>      fuse: fix "direct_io" private mmap
>
>      MAP_PRIVATE mmap could return stale data from the cache for
>      "direct_io" files.  Fix this by flushing the cache on mmap.
>
>      Found with a slightly modified fsx-linux.
>
>      Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 0946861b10b7..06f30e965676 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1298,6 +1298,8 @@ static int fuse_direct_mmap(struct file *file, struct vm_area_struct *vma)
>          if (vma->vm_flags & VM_MAYSHARE)
>                  return -ENODEV;
>
> +       invalidate_inode_pages2(file->f_mapping);
> +
>          return generic_file_mmap(file, vma);
>   }
>
>
> I don't have a strong opinion here - so idea of this patch is to avoid
> exposing stale data from a previous mmap. I guess (and probably hard to achieve
> semantics) would be to invalidate pages when the last mapping of that _area_
> is done?
> So now with a shared map, data are supposed to be stored in files and
> close-to-open consistency with FOPEN_KEEP_CACHE should handle the invalidation?
>

Nevermind, it was just my bad understanding of invalidate_inode_pages2().
I think it calls fuse_launder_folio() for dirty pages, so data loss is
not a concern.

> >
> > I think that the mix of direct io file with private mmap is common and
> > doesn't have issues, but the mix of direct io files and caching files on
> > the same inode is probably not very common has the same issues as the
> > direct_io_allow_mmap regression that you are fixing.
>
> Yeah. I also find it interesting that generic_file_mmap is not doing such
> things for files opened with O_DIRECT - FOPEN_DIRECT_IO tries to do
> strong coherency?
>
>
> I'm going to send out the patch for now as it is, as that might become a longer
> discussion - maybe Miklos could comment on it.
>

I think your patch should not be avoiding invalidate_inode_pages2()
in the shared mmap case.

You have done that part because of my comment which was wrong,
not because it reproduced a bug.

Thanks,
Amir.

