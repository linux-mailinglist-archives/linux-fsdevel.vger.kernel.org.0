Return-Path: <linux-fsdevel+bounces-6117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BB813969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5281F21D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B167E8B;
	Thu, 14 Dec 2023 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct90iv8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C347A6;
	Thu, 14 Dec 2023 10:07:01 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67f07090053so6824266d6.2;
        Thu, 14 Dec 2023 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702577220; x=1703182020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPt868zrOtbkarDAAFymj7NYAgfFW8gD7wm2JeCnHF8=;
        b=Ct90iv8ozqyRIVuGtFCq04zJwrKtXpNuFJibtIphRBlfRPfzSOIn3oHkZqRU7WGESf
         4f7Vs+jU7TDZoQhbsJYVr2+6QLji2QLKyFNXxvMibGraJz8bI/YmFK077TrLg0dtkXRh
         RoFiTAhDuEl2bT+LuPJkEkzrsJPb/MXzQ83FjVXpm2m48ZPa9TXgvvYcJOoGAKIELOSG
         /WrYQVb3ljdgBSr2dx1iLymhlCmwp1GrWVP9YajXRYamSDSUEe+DO8kzVkg2WiDRnuUk
         Z7b35SIywSgR961FEP1EydwVvlp/krbktkVCjaHKo438n5RmKYWBqJnzoMaJRG43XJ5z
         pTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577220; x=1703182020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPt868zrOtbkarDAAFymj7NYAgfFW8gD7wm2JeCnHF8=;
        b=nwJU7Jrff2pfsZ75mY46/JPx/cVfS2pBBgpQcvAGD8tfsuRAbJV2dBzUEQM6oXZ4J7
         ae/+EbfM27sTs3CoMZ8FcI+xWQDbscbrc/IxySZKkkHp037DXwfVHnovLOzZZhor8lVy
         mUOHd80IBzRdew+x+gzHFxnLqE+0BRfezzOxg2o+GEMYJy9TvFUZAGtAQAmrV51dULZ0
         8lXcbQaTRhK2z1QCVn9Qoonj2R1IgqG7Gm9S7F8Cq6rh4YpUJEduhKbSHW/9j5omszsA
         gnRjyXkk2edDHhPksRO+2/RYyWw+it1AuPp5uaTYq+zkitpZoC6XTE+L8v8fPTXYZot+
         u2Ng==
X-Gm-Message-State: AOJu0YyJKLvmTLuMgcCWt4CsHLMnM+ni5UkE6mnSefx1cSChIz6tYJNA
	tT1r+Dz/dx4D1UeX8sifEmHVWltMYVwarf8Ehek=
X-Google-Smtp-Source: AGHT+IEUi+gaYlXxskvCvvCLtLjqz74ZYomEs0zEWavV7J4lTTyTO9bHIEIAXW8ds7NyPbSKNGkACGv8BQyVzl+kzW0=
X-Received: by 2002:a05:6214:f68:b0:67f:d3d:69bf with SMTP id
 iy8-20020a0562140f6800b0067f0d3d69bfmr1521506qvb.42.1702577220395; Thu, 14
 Dec 2023 10:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner> <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <20231211-fortziehen-basen-b8c0639044b8@brauner> <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
 <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
 <59bf3530-2a6e-4caa-ac42-4d0dab9a71d1@huaweicloud.com> <a9297cc1bf23e34aba3c7597681e9e71a03b37f9.camel@linux.ibm.com>
 <d6b43b5780770637a724d129c22d5212860f494a.camel@huaweicloud.com>
 <CAOQ4uxhwHgj-bE7N5SNcRZfnVHn9yCdY_=LFuOxEBkVBbrZKiw@mail.gmail.com> <579803fe4750b2ac1cbf31f4d38929c9ec901a41.camel@linux.ibm.com>
In-Reply-To: <579803fe4750b2ac1cbf31f4d38929c9ec901a41.camel@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Dec 2023 20:06:48 +0200
Message-ID: <CAOQ4uxgra3KNthC_Od8r3fYDPO4AiVUF3u=aUfpUpQzOeeCFvg@mail.gmail.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, stefanb@linux.ibm.com, 
	jlayton@kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Eric Snowberg <eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"

> > > There is another problem, when delayed copy is used. The content comes
> > > from one source, metadata from another.
> > >
> > > I initially created test-file-lower on the lower directory
> > > (overlayfs/data), before mounting overlayfs. After mount on
> > > overlayfs/mnt:
> > >
> > > # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> > > # file: overlayfs/mnt/test-file-lower
> > > security.evm=0x02c86ec91a4c0cf024537fd24347b780b90973402e
> > > security.ima=0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2
> > > security.selinux=0x73797374656d5f753a6f626a6563745f723a756e6c6162656c65645f743a733000
> > >
> > > # chcon -t unconfined_t overlayfs/mnt/test-file-lower
> > >
> > > After this, IMA creates an empty file in the upper directory
> > > (overlayfs/root/data), and writes security.ima at file close.
> > > Unfortunately, this is what is presented from overlayfs, which is not
> > > in sync with the content.
> > >
> > > # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> > > # file: overlayfs/mnt/test-file-lower
> > > security.evm=0x021d71e7df78c36745e3b651ce29cb9f47dc301248
> > > security.ima=0x04048855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4
> > > security.selinux=0x73797374656d5f753a6f626a6563745f723a756e636f6e66696e65645f743a733000
> > >
> > > # sha256sum overlayfs/mnt/test-file-lower
> > > f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  overlayfs/mnt/test-file-lower
> > >
> > > # sha256sum overlayfs/root/data/test-file-lower
> > > 8855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4  overlayfs/root/data/test-file-lower (upperdir)
> > >
> > > We would need to use the lower security.ima until the copy is made, but
> > > at the same time we need to keep the upper valid (with all xattrs) so
> > > that IMA can update the next time overlayfs requests that.
> > >
> >
> > Yap.
> >
> > As Seth wrote, overlayfs is a combination of upper and lower.
> > The information that IMA needs should be accessible from either lower
> > or upper, but sometimes we will need to make the right choice.
> >
> > The case of security.ima is similar to that of st_blocks -
> > it is a data-related metadata, so it needs to be taken from the lowerdata inode
> > (not even the lower inode). See example of getting STATX_BLOCKS
> > in ovl_getattr().
> >
> > I would accept a patch that special cases security.ima in ovl_xattr_get()
> > and gets it from ovl_i_path_lowerdata(), which would need to be
> > factored out of ovl_path_lowerdata().
> >
> > I would also accept filtering out security.{ima,evm} from
> >
> > But I would only accept it if I know that IMA is not trying to write the
> > security.ima xattr when closing an overlayfs file, only when closing the
> > real underlying upper file.
>
> I don't see how that would be possible.  As far as I'm aware, the
> correlation is between the overlay and the underlying lower/uppper
> file, not the other way around.  How could a close on the underlying
> file trigger IMA on an overlay file?
>

Well, you are right. it cannot.

What I meant is that close of overlayfs file should NOT open and read
the overlayfs file and recalculate security.ima to store in overlayfs inode
because close of overlayfs file will follow a close of the upper file that
should recalculate and store security.ima in the upper inode.

It is possible that a close of an overlayfs file will update the security
state of the overlayfs inode by copying the security state from the
upper inode.

But then again, I could be misunderstanding the IMA workflows
and it could be more complicated than I try to present it.
This is the reason that I requested the documentation of how
IMA+overlayfs is *expected* to work.

Thanks,
Amir.

