Return-Path: <linux-fsdevel+bounces-3641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DA7F6C59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981411F20F23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B54A95E;
	Fri, 24 Nov 2023 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfdjMt9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2AB0;
	Thu, 23 Nov 2023 22:36:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548696eac92so2062954a12.3;
        Thu, 23 Nov 2023 22:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700807770; x=1701412570; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEd0FiGVy5VmF1ZrlmZcok7cqApIhcHDIftpbUYcko0=;
        b=EfdjMt9uuWtiW7IEaLNngRCDkaoZCEwcfstetKbQsGrJb9hkO28g9BiTdwqn0n9Hxl
         15/hlyKPzvC/IfAnK00P5MOw7EuuxvVHbEE8KVBHDFMRqWlfse7a2YUUm+iqP5dxk4M6
         c8Cj0+L0KoflauVKeKXAQJ+cPlKpifdn+7wyQQR+i85UNrUAyIpx+p5WHwJ/MclMsxLL
         2NyFx7XFdpcNlhvGoWcmMkDhTuuEfMrwy0ZNAtasaBALK66O9M8uyAS2cwSesu+fEHUn
         fHqROuJoGQIe8ISexAo3tX+BlJsCwkWq9JI0wW1sdYrUwhEv3klCAeBgGJMGokpL4ANM
         nsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700807770; x=1701412570;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEd0FiGVy5VmF1ZrlmZcok7cqApIhcHDIftpbUYcko0=;
        b=Bmb7aGXLQC7f+iK27UNyK/3lgQJiF4HFEgbApA3XcaJKiY9OwNAazlAWqPhE0Xdhjj
         uwAAuYVfJugdXwugDqAePFSbAdcy0CLnp1J+em7t8/cwqwwlj7K2t07vIsV4HdA81DnN
         q4iuCCv4cqQDivSLyobS77JuxQ0y96Qqbrc27i2pFdPMFcYTFSNi02F/WKf5c4MJ6QON
         fI/QZ1cZAwbLRJ1wWD7f0Hb8OVm2rt3Vc8tN/O2DltgIzRxFkAayBtk5TpJUYBjlLEpt
         xQCwYeGyJyXBNldoQNize7HnTVDSoaXhP3fb3jdUYekK/FGkPUcrP9/9a9Rw4gxmCr1V
         HtRQ==
X-Gm-Message-State: AOJu0YxVp/HO3oWP1eLG5SxG3y55AscZ+HvgUnTOVZg2TcT0ga4oxYpi
	g5s0ojNv52xEIMn3x0pPwZ7ZZA+435UgtJuIKRJcxXOCKDI=
X-Google-Smtp-Source: AGHT+IH6iWRv195qNazMTDd6j0f6sJgF97e7g/dgDK5e0EOnFVkxS7bWoTLgAO2i4siw6TUUEqKix9mMqW3w6lGzDts=
X-Received: by 2002:a50:9e49:0:b0:547:6663:a164 with SMTP id
 z67-20020a509e49000000b005476663a164mr821557ede.40.1700807770436; Thu, 23 Nov
 2023 22:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060553.GA575483@ZenIV> <20231124060644.576611-1-viro@zeniv.linux.org.uk>
 <20231124060644.576611-15-viro@zeniv.linux.org.uk>
In-Reply-To: <20231124060644.576611-15-viro@zeniv.linux.org.uk>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 24 Nov 2023 07:35:34 +0100
Message-ID: <CALXu0UcCGjyM6hFfdjG1eHJcmeR=9BVSaq7Vj9rtvKxb9szJdQ@mail.gmail.com>
Subject: d_genocide()? What about d_holodomor(), d_massmurder(),
 d_execute_warcrimes()? Re: [PATCH 15/20] d_genocide(): move the extern into fs/internal.h
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 07:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/internal.h          | 1 +
>  include/linux/dcache.h | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 9e9fc629f935..d9a920e2636e 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -219,6 +219,7 @@ extern void shrink_dcache_for_umount(struct super_block *);
>  extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
>  extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
>                                 const struct qstr *name, unsigned *seq);
> +extern void d_genocide(struct dentry *);

Seriously, who came up with THAT name? "Genocide" is not a nice term,
not even if you ignore political correctness.
Or what will be next? d_holodomor()? d_massmurder()? d_execute_warcrimes()?

Ced

>
>  /*
>   * pipe.c
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 8c5e3bdf1147..b4324d47f249 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -243,9 +243,6 @@ extern void d_invalidate(struct dentry *);
>  /* only used at mount-time */
>  extern struct dentry * d_make_root(struct inode *);
>
> -/* <clickety>-<click> the ramfs-type tree */
> -extern void d_genocide(struct dentry *);
> -
>  extern void d_mark_tmpfile(struct file *, struct inode *);
>  extern void d_tmpfile(struct file *, struct inode *);
>
> --
> 2.39.2
>
>


--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

