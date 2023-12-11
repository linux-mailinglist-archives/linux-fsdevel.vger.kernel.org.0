Return-Path: <linux-fsdevel+bounces-5552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF580D56A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578592820F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF63E5101A;
	Mon, 11 Dec 2023 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejaujRnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752BB4;
	Mon, 11 Dec 2023 10:24:18 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f408d123bso151098985a.0;
        Mon, 11 Dec 2023 10:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702319057; x=1702923857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTZUGzqXgAgDzLk+TnvpFqLchf/LU4PPH7EmQyI17uI=;
        b=ejaujRnGTm2d7WqGQiQipLhCyW1d9eNLZsXY4CJTCUU7mdPsH172Q8g5NCPKEUU27V
         hn5ySNYRY+4Y6QROhzkKvUhppVhgWg1VY9p91hl/7giD7sHUndh4tMsJwa1UYGg4lF3y
         0rreL6dlru1W9+4ILhe5wtgyeU7wGldEeqmocCEpz9kYxYmMFNnJglNhrheH1/SAHRFO
         8BdI2wTpwfEeAIHCHfBnpPO4LzNi3dkWKYcPSTfN1xE2JA4WERhQwiiYfXQxuTxyISN/
         YePKuWsymbM5gXOj6UwVhDMS6Q0pCf3+dOXIpFtPKLOOJdgm12ATE2qrtQzflIgC2SEn
         JbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702319057; x=1702923857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTZUGzqXgAgDzLk+TnvpFqLchf/LU4PPH7EmQyI17uI=;
        b=XC/+UMv6fn1WAKxfICHZ/ZFMamU8M3XdjH9Zj+i9s8ZJ+ZAJPgbH36swnUdzNt1sgs
         FEVhHnnhhriv6KVxtZOZj5TBso3CgxvpXXqP+Vi+26De9mIISsTf+YZ1hP7Y55iNUzLZ
         xS7brQ7syrmidYLLYa2g4NZvSGUHkOqlxfAST3FerT1sKUdMMOjQCIRQzHxRE5L24AmX
         saoNCsfLxzTgxYq167rmeoBOJaGSweYKpCGxwhh15tpuhi/X6Oqb4cP7NDU8EbGaacEx
         D9NJfmW7XiUcHJXm93Lhh0nUAvA5JkXmF9ihIRAiMwKZVyCanlV2mxSzbOBEDA/06yfs
         WQ1Q==
X-Gm-Message-State: AOJu0YxpWa8NwAGGXATGYjAleAtzHesAkm10YsrF+TqTur58HhVLHnFg
	dTF2awdFhe9IaYBquJcYrKorRU9Xyt3YrnzChOY=
X-Google-Smtp-Source: AGHT+IFU3yIeqVdLEfnUPGvzBPNX6v7stlvCzAenXor4lYkbdAwus2+6wWBqX1pZ2IoqaIniDz+cjPu8ZN6fR7ozR/o=
X-Received: by 2002:ad4:4528:0:b0:67a:259d:8ce0 with SMTP id
 l8-20020ad44528000000b0067a259d8ce0mr2984856qvu.17.1702319057240; Mon, 11 Dec
 2023 10:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner> <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <ZXcsdf6BzszwZc9h@do-x1extreme> <6e05677355d6d134dddd11da56709b424b631079.camel@huaweicloud.com>
 <ZXdDvgbjSNo78zM2@do-x1extreme>
In-Reply-To: <ZXdDvgbjSNo78zM2@do-x1extreme>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Dec 2023 20:24:05 +0200
Message-ID: <CAOQ4uxhquVynV-=f54a7m-Bu2+dQcYxsUo1j2RBqUxCsLARCXg@mail.gmail.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
To: Seth Forshee <sforshee@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, Christian Brauner <brauner@kernel.org>, miklos@szeredi.hu, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com, 
	jlayton@kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 7:15=E2=80=AFPM Seth Forshee <sforshee@kernel.org> =
wrote:
>
> On Mon, Dec 11, 2023 at 04:41:46PM +0100, Roberto Sassu wrote:
> > On Mon, 2023-12-11 at 09:36 -0600, Seth Forshee wrote:
> > > On Mon, Dec 11, 2023 at 03:56:06PM +0100, Roberto Sassu wrote:
> > > > Ok, I will try.
> > > >
> > > > I explain first how EVM works in general, and then why EVM does not
> > > > work with overlayfs.
> > > >
> > > > EVM gets called before there is a set/removexattr operation, and af=
ter,
> > > > if that operation is successful. Before the set/removexattr operati=
on
> > > > EVM calculates the HMAC on current inode metadata (i_ino, i_generat=
ion,
> > > > i_uid, i_gid, i_mode, POSIX ACLs, protected xattrs). Finally, it
> > > > compares the calculated HMAC with the one in security.evm.
> > > >
> > > > If the verification and the set/removexattr operation are successfu=
l,
> > > > EVM calculates again the HMAC (in the post hooks) based on the upda=
ted
> > > > inode metadata, and sets security.evm with the new HMAC.
> > > >
> > > > The problem is the combination of: overlayfs inodes have different
> > > > metadata than the lower/upper inodes; overlayfs calls the VFS to
> > > > set/remove xattrs.
> > >
> > > I don't know all of the inner workings of overlayfs in detail, but is=
 it
> > > not true that whatever metadata an overlayfs mount presents for a giv=
en
> > > inode is stored in the lower and/or upper filesystem inodes? If the
> > > metadata for those inodes is verified with EVM, why is it also necess=
ary
> > > to verify the metadata at the overlayfs level? If some overlayfs
> > > metadata is currently omitted from the checks on the lower/upper inod=
es,
> > > is there any reason EVM couldn't start including that its checksums?
> >
> > Currently, the metadata where there is a misalignment are:
> > i_generation, s_uuid, (i_ino?). Maybe there is more?
> >
> > If metadata are aligned, there is no need to store two separate HMACs.
>
> I can only think of three possible sources for the metadata overlayfs
> presents:
>
>  1. It comes directly from the underlying filesystems
>  2. overlayfs synthesizes if from the underlying filesystem data
>  3. It's purely generated at runtime
>
> Are there others?

3.b. purely generated and persisted in overlay private xattr

but IIRC only s_uuid fits in that category

>
> 1 and 2 should be covered by EVM on the underlying filesystems. If 3 is
> happening then it seems like hashing that data is just confirming that
> overlayfs consistently generates the same values for that data, and
> verifying code behavior doesn't seem in-scope for EVM.

I agree.
I don't think that IMA/EVM has a reason to assets overlayfs specific
metadata.

Thanks,
Amir.

