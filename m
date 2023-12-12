Return-Path: <linux-fsdevel+bounces-5658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C398880E966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CFE1C20AF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14D5C91B;
	Tue, 12 Dec 2023 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPfP6wGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAE09F;
	Tue, 12 Dec 2023 02:45:02 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77f2f492a43so308245385a.2;
        Tue, 12 Dec 2023 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702377902; x=1702982702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjRectGYgBe38M8M8dJVW+G+bLpHLxY0GGSZK1GNZ70=;
        b=SPfP6wGuStgp3YcMF0LtsFbgHR8B0Xyj08lsAzeq0NxssW6Or903phlZlaHzP9LOU2
         Q3/GIWbgQe52famgPH+mSlXQLnfcmEuc8dSczd4brGYA/d61IDdFNbf6dOs5QZbsfCzE
         LZXftQbe8cam1e1gisH+f1OQsNm+G/vEGC8+9BI8aus5OjixcWiPSQG6+eXcsfdVAxlR
         SZdwAp7xu7ounad9KO8QYy3/lqFPpf3oP4tG/qBGifOnT3oxzJyutnBGgC3hx+HAGwhW
         kavWP/w8Bf3YHx1it8D225+sXGXTbbI3K8MRCeUTFhCwuE+MsUBgkKHXDC7BISatgKxb
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377902; x=1702982702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjRectGYgBe38M8M8dJVW+G+bLpHLxY0GGSZK1GNZ70=;
        b=rySmLB/dTfPNUGFd15haaYkh7Fb7i8PM0tLzmCazyHCA9E+beekxU4AjMdERIHFB6l
         Oq00pIJQTIgkX9OKTFVfjEtnqbBwXA/DFfyO639aKLa//b5YXF0w0Kw4qYDFckztCOTa
         iAPIQ2ctjvWLDgWiwnyB827q998xqA1fvgZ+O0xV9YtMc069Mn/TfCTkirP7H0k88KH7
         GGt1VJUvktdbrpZ8Ig6UeKxmUkuk6ZL5+vntxYG/xEqSdjipkYoPojVDnRGpI9lcPmNo
         +D2yTFZ6kDoJJkmqpNcs78jKwu/Vl5SAl7rWk5m3zbXLu/JOsiO1YJYQpwE2PtJ8tTem
         FbFg==
X-Gm-Message-State: AOJu0YwSMy7d9SHuSxwy3xWvnxdjloqxeMmpJsrITwdIWrETKwMyaa+7
	Jt9+y7cVghlamx5xa0ls3/53qKytehCgTn5pGNkBiDyJDIA=
X-Google-Smtp-Source: AGHT+IHogBhzr+LATtjgX6ikAafGWmW4xlRNPjq+QN0iUrChh/jFjI4N139XmFcQa1W0rLJcM+e1sXIvBCJ8jKXPQfk=
X-Received: by 2002:a05:6214:5583:b0:67a:e83e:eb3c with SMTP id
 mi3-20020a056214558300b0067ae83eeb3cmr5706310qvb.60.1702377901707; Tue, 12
 Dec 2023 02:45:01 -0800 (PST)
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
In-Reply-To: <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Dec 2023 12:44:50 +0200
Message-ID: <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com, 
	jlayton@kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Eric Snowberg <eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:25=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On 11.12.23 19:01, Christian Brauner wrote:
> >> The second problem is that one security.evm is not enough. We need two=
,
> >> to store the two different HMACs. And we need both at the same time,
> >> since when overlayfs is mounted the lower/upper directories can be
> >> still accessible.
> >
> > "Changes to the underlying filesystems while part of a mounted overlay
> > filesystem are not allowed. If the underlying filesystem is changed, th=
e
> > behavior of the overlay is undefined, though it will not result in a
> > crash or deadlock."
> >
> > https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlyin=
g-filesystems
> >
> > So I don't know why this would be a problem.
>
> + Eric Snowberg
>
> Ok, that would reduce the surface of attack. However, when looking at:
>
>       ovl: Always reevaluate the file signature for IMA
>
>       Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> i_version")
>       partially closed an IMA integrity issue when directly modifying a f=
ile
>       on the lower filesystem.  If the overlay file is first opened by a
> user
>       and later the lower backing file is modified by root, but the exten=
ded
>       attribute is NOT updated, the signature validation succeeds with
> the old
>       original signature.
>
> Ok, so if the behavior of overlayfs is undefined if the lower backing
> file is modified by root, do we need to reevaluate? Or instead would be
> better to forbid the write from IMA (legitimate, I think, since the
> behavior is documented)? I just saw that we have d_real_inode(), we can
> use it to determine if the write should be denied.
>

There may be several possible legitimate actions in this case, but the
overall concept IMO should be the same as I said about EVM -
overlayfs does not need an IMA signature of its own, because it
can use the IMA signature of the underlying file.

Whether overlayfs reads a file from lower fs or upper fs, it does not
matter, the only thing that matters is that the underlying file content
is attested when needed.

The only incident that requires special attention is copy-up.
This is what the security hooks security_inode_copy_up() and
security_inode_copy_up_xattr() are for.

When a file starts in state "lower" and has security.ima,evm xattrs
then before a user changes the file, it is copied up to upper fs
and suppose that security.ima,evm xattrs are copied as is?

When later the overlayfs file content is read from the upper copy
the security.ima signature should be enough to attest that file content
was not tampered with between going from "lower" to "upper".

security.evm may need to be fixed on copy up, but that should be
easy to do with the security_inode_copy_up_xattr() hook. No?

Thanks,
Amir.

