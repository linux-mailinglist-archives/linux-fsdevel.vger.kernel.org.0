Return-Path: <linux-fsdevel+bounces-5553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6AB80D629
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A8F1F21AEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0051C25;
	Mon, 11 Dec 2023 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tpkr1hxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865DAC;
	Mon, 11 Dec 2023 10:31:45 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a89dc1ef1so31219316d6.3;
        Mon, 11 Dec 2023 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702319504; x=1702924304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTW8PXqixb5wSH5WvPY2gNC1fyQ7CohqHF+38plcVqE=;
        b=Tpkr1hxcOOXTCrewysaLPE4YOBt4UeOLlr71vma+brDelC4ls5AkIPV/E6A9X4qcsu
         DvpzmPoTv31nYsdygOhooQGUNZLDmnnHhc37b3RRpRBVyHBeoW18NaLP95hpXeXGb4tO
         gI5CSzdmXMsvNuXUK5wbmeZkAUyBa7/eIdfUcvtMF82xqIIkgzvCF7TMZfB8CUAonsxl
         t5uc1OML0QrZcVQTtA5+sgIbE3zbyoBTHg+jA6ng6oJ5MPFpR9MKC1Ex77MsRckZgTDR
         8eVQ3ybP39VWXGOH/s0JE9XGYHc+wdEH2MfFWT994YGITqkBccd5eCM6GReAaqXCAwu6
         RuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702319504; x=1702924304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTW8PXqixb5wSH5WvPY2gNC1fyQ7CohqHF+38plcVqE=;
        b=tcvJQgLEZKeZHjX2Y8jlnvl5uIakKTooncjBZFOKn30TjM2r5Bg2R9cLstHjb5zI1n
         lEQDOmgjZbuq4lgF+SAyC88zoSaONDK+bElbGEP/n7RaE4SYQh4hfMwuFRMVYLceyE4G
         o5rIywfGxgBEJNHXoT2w1YWEfm5F7C4mwJ279TJH+042EQl3WiClQHadFRwwH2PbHq4Q
         A5EXn9JnphO4q8wNR8J0y/IbPpblDNyC46PAPBSzoHdeYU5Mu6vdctIoF1ngiSz1qn0f
         PnDbu8hQa/i9k0TOBgYORZw3x/He8z1Mc/n4g9uUu2gYUmis+V8Sk6bCAFjJCxxI+1p4
         qwHA==
X-Gm-Message-State: AOJu0Yx6DkaxbvOwPF9gxdMf1CcYOSE072hUNjWmsCq3X/WByaZbSux6
	FcNa+A6YJ4T59mdZQrkKkabdneMB4okCsuQbA9I=
X-Google-Smtp-Source: AGHT+IESLxkN3UOj4BAZ/9t1FY45KlxzL7wvht1++ac8e3nzghJbM1myeGPn9aNJSkj5V2NV5DFzNES2c2VpziT/xAg=
X-Received: by 2002:a05:6214:154c:b0:67a:dc5a:4fb8 with SMTP id
 t12-20020a056214154c00b0067adc5a4fb8mr6393575qvw.17.1702319504602; Mon, 11
 Dec 2023 10:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner> <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
In-Reply-To: <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Dec 2023 20:31:33 +0200
Message-ID: <CAOQ4uxgvKb520_Nbp+Y7KDq3_7t1tx65w5pOP8y6or1prESv+Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com, 
	jlayton@kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:56=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2023-12-08 at 23:01 +0100, Christian Brauner wrote:
> > On Fri, Dec 08, 2023 at 11:55:19PM +0200, Amir Goldstein wrote:
> > > On Fri, Dec 8, 2023 at 7:25=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >
> > > > EVM updates the HMAC in security.evm whenever there is a setxattr o=
r
> > > > removexattr operation on one of its protected xattrs (e.g. security=
.ima).
> > > >
> > > > Unfortunately, since overlayfs redirects those xattrs operations on=
 the
> > > > lower filesystem, the EVM HMAC cannot be calculated reliably, since=
 lower
> > > > inode attributes on which the HMAC is calculated are different from=
 upper
> > > > inode attributes (for example i_generation and s_uuid).
> > > >
> > > > Although maybe it is possible to align such attributes between the =
lower
> > > > and the upper inode, another idea is to map security.evm to another=
 name
> > > > (security.evm_overlayfs)
> > >
> > > If we were to accept this solution, this will need to be trusted.over=
lay.evm
> > > to properly support private overlay xattr escaping.
> > >
> > > > during an xattr operation, so that it does not
> > > > collide with security.evm set by the lower filesystem.
> > >
> > > You are using wrong terminology and it is very confusing to me.
> >
> > Same.
>
> Argh, sorry...
>
> > > see the overlay mount command has lowerdir=3D and upperdir=3D.
> > > Seems that you are using lower filesystem to refer to the upper fs
> > > and upper filesystem to refer to overlayfs.
> > >
> > > >
> > > > Whenever overlayfs wants to set security.evm, it is actually settin=
g
> > > > security.evm_overlayfs calculated with the upper inode attributes. =
The
> > > > lower filesystem continues to update security.evm.
> > > >
> > >
> > > I understand why that works, but I am having a hard time swallowing
> > > the solution, mainly because I feel that there are other issues on th=
e
> > > intersection of overlayfs and IMA and I don't feel confident that thi=
s
> > > addresses them all.
>
> This solution is specifically for the collisions on HMACs, nothing
> else. Does not interfere/solve any other problem.
>
> > > If you want to try to convince me, please try to write a complete
> > > model of how IMA/EVM works with overlayfs, using the section
> > > "Permission model" in Documentation/filesystems/overlayfs.rst
> > > as a reference.
>
> Ok, I will try.
>
> I explain first how EVM works in general, and then why EVM does not
> work with overlayfs.
>

I understand both of those things.

What I don't understand is WHY EVM needs to work on overlayfs?
What is the use case?
What is the threat model?

The purpose of IMA/EVM as far as I understand it is to detect and
protect against tampering with data/metadata offline. Right?

As Seth correctly wrote, overlayfs is just the composition of existing
underlying layers.

Noone can tamper with overlayfs without tampering with the underlying
layers.

The correct solution to your problem, and I have tried to say this many
times, in to completely opt-out of IMA/EVM for overlayfs.

EVM should not store those versions of HMAC for overlayfs and for
the underlying layers, it should ONLY store a single version for the
underlying layer.

Because write() in overlayfs always follows by write() to upper layer
and setxattr() in overlayfs always follows by setxattr() to upper layer
IMO write() and setxattr() on overlayfs should by ignored by IMA/EVM
and only write()/setxattr() on underlying fs should be acted by IMA/EVM
which AFAIK, happens anyway.

Please let me know if I am missing something,

Thanks,
Amir.

