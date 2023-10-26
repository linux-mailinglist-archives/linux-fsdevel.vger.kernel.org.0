Return-Path: <linux-fsdevel+bounces-1266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2C87D891D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 21:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BDDB2122E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 19:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F63C078;
	Thu, 26 Oct 2023 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB/H64jN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387193B786
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 19:46:19 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55871AA;
	Thu, 26 Oct 2023 12:46:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d12b3b479so8460676d6.1;
        Thu, 26 Oct 2023 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698349578; x=1698954378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lSRSH0mhmv3CjgtXU9+F7JtvOpTShfmc4Bl2fP9hZQ=;
        b=XB/H64jN68FxP+alhxrGgD+DtA19GZDLlspB5mMpIJ/+ENYRFxsOlgHEMTa9hUgyq7
         MW3oIuZbuAbMbDIxypxkKRxQOw9bJ0BbCYMjrQVN0TILwb0z2w6gdslOLRDYx/5Lm/59
         KV0yIu1IxYLJMGYY6BMRGeyyjZfBHJ/JDYsW/x06A65ziDheWWAAPfUF3mXkcz72Kpkl
         hOBrRttO5pdyOjUlN2O1M8Y8N6YJAU7ACxEZBUaVpJx3GEYvd6FzjpUsuZ7ctcPA0VRR
         3ASfHXmfSrfdFH8p2x2MfszE/p70WLmyONY2JSSY9OgC9xLkxm3vOsbNyKYpVO79BvSq
         lZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698349578; x=1698954378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lSRSH0mhmv3CjgtXU9+F7JtvOpTShfmc4Bl2fP9hZQ=;
        b=T2m2Ke0JGvodiZt5pI3lsudOsMSjJLAu5VMtEQcoVCYeKnmawodEbJVcnw4BsmIbOU
         0LQ1Y/hnu208xahRZ0fH53kGYT4e9pu/VNh1AHK57gaQMvYCw52vK4Y19Bx5yX7zhSDG
         Dg3nxSl4RtEHf2UpMt3niuKrKA6TJL4syCFnI0S2ipCTpwALhRGxxEcdvtrTF7nLHXdk
         5PPuJ1iR2cO2iUPW9QIULuuhnnBzKVcfR+E1Og9J1bLTcmeOj7vgmiy0MrcRXBEd/f2Z
         63Y0ScJJXSsEsfXCAaiBkXk8TrHE8AwSuUEl7wKnIXTkWLvIpgQ1QGvISlBFZ81mg9CU
         dAfg==
X-Gm-Message-State: AOJu0YzRsQVYxYBAnFTeggkG40sTn7WJkStDcJhsHHO+r0j2Vgg4NMEH
	ST00JTJnnEQ08BYj9A9Q4u8ez2Jul/9qrmlqGtU=
X-Google-Smtp-Source: AGHT+IEmarWREXvrbH3L5dUOpWtP7gSzyuNeYnq08iLHmXqfKkFEOdq3D+0jdHX3ciukSyf5b8GXIdf93DsdpcigMP0=
X-Received: by 2002:a05:6214:76d:b0:66d:1d3f:17d7 with SMTP id
 f13-20020a056214076d00b0066d1d3f17d7mr1004811qvz.8.1698349577784; Thu, 26 Oct
 2023 12:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026192830.21288-1-rdunlap@infradead.org>
In-Reply-To: <20231026192830.21288-1-rdunlap@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Oct 2023 22:46:06 +0300
Message-ID: <CAOQ4uxhYiu+ou0SiwYsuSd-YayRq+1=zgUw_2G79L8SxkDQV7g@mail.gmail.com>
Subject: Re: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:28=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> When CONFIG_EXPORTFS=3Dm, there are multiple build errors due to
> the header <linux/exportfs.h> not handling the =3Dm setting correctly.
> Change the header file to check for CONFIG_EXPORTFS enabled at all
> instead of just set =3Dy.
>
> Fixes: dfaf653dc415 ("exportfs: make ->encode_fh() a mandatory method for=
 NFS export")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
>
> ---
>  include/linux/exportfs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/include/linux/exportfs.h b/include/linux/exportfs.h
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -314,7 +314,7 @@ extern struct dentry *exportfs_decode_fh
>  /*
>   * Generic helpers for filesystems.
>   */
> -#ifdef CONFIG_EXPORTFS
> +#if IS_ENABLED(CONFIG_EXPORTFS)
>  int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len=
,
>                             struct inode *parent);
>  #else

Thanks for the fix, but Arnd reported that this fix could cause a link
issue in some configuration - I did not verify.

I would much rather turn EXPORTFS into a bool config
and avoid the unneeded build test matrix.

See comparison to the amount of code of EXPORTFS
to BUFFER_HEAD and FS_IOMAP code which are bool:

~/src/linux$ wc -l fs/exportfs/*.c
636 fs/exportfs/expfs.c

~/src/linux$ wc -l fs/buffer.c fs/mpage.c
  3164 fs/buffer.c
   685 fs/mpage.c
  3849 total

~/src/linux$ wc -l fs/iomap/*.c
 2002 fs/iomap/buffered-io.c
  754 fs/iomap/direct-io.c
  124 fs/iomap/fiemap.c
   97 fs/iomap/iter.c
  104 fs/iomap/seek.c
  195 fs/iomap/swapfile.c
   13 fs/iomap/trace.c
 3289 total

Thanks,
Amir.

