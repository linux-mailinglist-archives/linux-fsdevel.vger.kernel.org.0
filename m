Return-Path: <linux-fsdevel+bounces-29952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC59841F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54E11F2140A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25B15572E;
	Tue, 24 Sep 2024 09:22:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8D84A50;
	Tue, 24 Sep 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169736; cv=none; b=aRJhvDz7470x9BfnrdXySsX9IE/o0G7vVLiZMB4gLnPkScXUEbDRGNgXx7cSCnu08OXXJKsrB2IhdUjoBXUxfVtxXqZsK6fd4cED9WbGCN9IHtlwKO/flsNC8yDc+oXXj748/YAWD/s5tXQCH0u9VReIEQITWGfiUo/ZlZE70r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169736; c=relaxed/simple;
	bh=mNZpzHYocrxxSBhWTUitiiBlrxI0MDt3X+nyc3PncTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIEmwOoP8CGzMyPCod3IigdtBnqaNGenEL3HNIUr33nr/diwGZ/RSnYal2N+RJArYhfXjNiVdv2iGV7Fg7EJ/5T0uDv0nw/Bqom0XZl3OR7Irs1TTC43T0dwRC4LonsMZ4dMUIWDakJmi1Ypeggh/YIVIJnlmLx/wSiXTItdC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ddd758aaf4so38128877b3.2;
        Tue, 24 Sep 2024 02:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169733; x=1727774533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezXFARLli0XopvazaZI4WJPLJgg9ymKuou4RbS/PT28=;
        b=BASM3ESNk4+AURqP5PX3rY8sSmfohwiSIqhzf2gOU+/A4AGpq8ZuAsN6y0m7lufyy0
         jrzUqy/hkgy9DVAHuICkF6C5N84oTIfO6gNleWDT61teTGjnDS0bhw3S5eHJsCr2+iFd
         wY5lVkX0UG/CW/sxnvFrA8mxb5M/kqlT/gOu4i8CE7IEalv7l9GqJSM0hp1ZTSTLdYS9
         4YzFNEIBoTz/GZQ+a6iv2Xq6+bW4TQ8kypyaOaERlEE5gNTGGNh/oPJpNYkF8vxg+lRE
         aiUpP1NYo7zyTmf/ChYAKnDhDtlsU+42Q1ag+W49dpU8CGQQHcT810gDxbyKyf+Vg1/u
         4uBA==
X-Forwarded-Encrypted: i=1; AJvYcCUKzGx2Ri4vV0e4G6tQVqffJDb4hs2ibKtEnLFEnMRanyK8UVfIoLWX5Paq922iC7cFiu/O1023/8UemC5D@vger.kernel.org, AJvYcCWVaxP/UA9UrKS+053AULZgnDPilwrMyc6KwVNieXppLHT4oUVw+1X8fJxrf9o0fwUmJ6EfSwEKHqbqGbLO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JQmlnkfmtAh+nb34K7Lomt4O93aI6kDNMJE0MjqFz8iBRGJe
	nJYImQwRhzRiPqmbZjSH3vTlzdbpEXIVlN9xbe/zkTAjxIZj6nw9xBHq+qsY
X-Google-Smtp-Source: AGHT+IHmHwNQEz4rHjfTONxzEAP97+r7PhVrpf90lh2Cxe1bGCm77sjOD4YfMdX/V5RazydmbRd5Ug==
X-Received: by 2002:a05:690c:6604:b0:6e2:12e5:35b4 with SMTP id 00721157ae682-6e212e55256mr6036607b3.0.1727169732651;
        Tue, 24 Sep 2024 02:22:12 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d2a44b3sm1819777b3.131.2024.09.24.02.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:22:11 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dffe3fe4fcso28550687b3.1;
        Tue, 24 Sep 2024 02:22:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvmPClUN2qx7v2fOM37rjrViZ1rpgGiGLHI5AzK4XlE+3lCS3GAJFNtcY18tItd9E9Tj3MHcS7d2ru9Q1H@vger.kernel.org, AJvYcCWTa3xsUDF9XCr40oXXUajwq1oPVAv5rseY79qpEzjVVPc94wtKPBScZpo8pAGCAEd0pv1HwgW83lCxkQlP@vger.kernel.org
X-Received: by 2002:a05:690c:fc1:b0:6e2:ffd:c123 with SMTP id
 00721157ae682-6e20ffdc6ffmr10422617b3.7.1727169731405; Tue, 24 Sep 2024
 02:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 11:21:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Message-ID: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao,

CC vfs

On Fri, Aug 30, 2024 at 5:29=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
> It actually has been around for years: For containers and other sandbox
> use cases, there will be thousands (and even more) of authenticated
> (sub)images running on the same host, unlike OS images.
>
> Of course, all scenarios can use the same EROFS on-disk format, but
> bdev-backed mounts just work well for OS images since golden data is
> dumped into real block devices.  However, it's somewhat hard for
> container runtimes to manage and isolate so many unnecessary virtual
> block devices safely and efficiently [1]: they just look like a burden
> to orchestrators and file-backed mounts are preferred indeed.  There
> were already enough attempts such as Incremental FS, the original
> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> for current EROFS users, ComposeFS, containerd and Android APEXs will
> be directly benefited from it.
>
> On the other hand, previous experimental feature "erofs over fscache"
> was once also intended to provide a similar solution (inspired by
> Incremental FS discussion [2]), but the following facts show file-backed
> mounts will be a better approach:
>  - Fscache infrastructure has recently been moved into new Netfslib
>    which is an unexpected dependency to EROFS really, although it
>    originally claims "it could be used for caching other things such as
>    ISO9660 filesystems too." [3]
>
>  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>    enhancements.  For example, the failover feature took more than
>    one year, and the deamonless feature is still far behind now;
>
>  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>    perfectly supersede "erofs over fscache" in a simpler way since
>    developers (mainly containerd folks) could leverage their existing
>    caching mechanism entirely in userspace instead of strictly following
>    the predefined in-kernel caching tree hierarchy.
>
> After "fanotify pre-content hooks" lands upstream to provide the same
> functionality, "erofs over fscache" will be removed then (as an EROFS
> internal improvement and EROFS will not have to bother with on-demand
> fetching and/or caching improvements anymore.)
>
> [1] https://github.com/containers/storage/pull/2039
> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=3Dw_AeM6Y=
M=3DzVixsUfQ@mail.gmail.com
> [3] https://docs.kernel.org/filesystems/caching/fscache.html
> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
>
> Closes: https://github.com/containers/composefs/issues/144
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks for your patch, which is now commit fb176750266a3d7f
("erofs: add file-backed mount support").

> ---
> v2:
>  - should use kill_anon_super();
>  - add O_LARGEFILE to support large files.
>
>  fs/erofs/Kconfig    | 17 ++++++++++
>  fs/erofs/data.c     | 35 ++++++++++++---------
>  fs/erofs/inode.c    |  5 ++-
>  fs/erofs/internal.h | 11 +++++--
>  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
>  5 files changed, 100 insertions(+), 44 deletions(-)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..1428d0530e1c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>
>           If you are not using a security module, say N.
>
> +config EROFS_FS_BACKED_BY_FILE
> +       bool "File-backed EROFS filesystem support"
> +       depends on EROFS_FS
> +       default y

I am a bit reluctant to have this default to y, without an ack from
the VFS maintainers.

> +       help
> +         This allows EROFS to use filesystem image files directly, witho=
ut
> +         the intercession of loopback block devices or likewise. It is
> +         particularly useful for container images with numerous blobs an=
d
> +         other sandboxes, where loop devices behave intricately.  It can=
 also
> +         be used to simplify error-prone lifetime management of unnecess=
ary
> +         virtual block devices.
> +
> +         Note that this feature, along with ongoing fanotify pre-content
> +         hooks, will eventually replace "EROFS over fscache."
> +
> +         If you don't want to enable this feature, say N.
> +
>  config EROFS_FS_ZIP
>         bool "EROFS Data Compression Support"
>         depends on EROFS_FS

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

