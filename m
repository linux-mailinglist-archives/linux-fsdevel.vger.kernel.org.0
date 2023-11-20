Return-Path: <linux-fsdevel+bounces-3266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059467F1E4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D701F25B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5E28361;
	Mon, 20 Nov 2023 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dIN+TWjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA2D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 12:56:06 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1272437276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700513766; x=1701118566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TZd4/9tDYUVpH+va2bN+Lz+wNAalFU9/JWBiin7Umg=;
        b=dIN+TWjB7DwY0CKa0z9f4TAEhPpuVnITgs51MdVSO/sn+arv6vDkaAE+8j/HKDuUM1
         GwebVP0DAs0QMj1gPJiZPUm9Td7HGYrjiLx979fyGVdPoNdblR/yi5f8aaIMQR7BiX4g
         CSnBeLFLW8wZLEYz0D4KFbH0EDNxXtEhULuNiYReIE1QCLzNuEXvG7IADxCQnNKppQu2
         EmvHtz6I5+wZaFTRUhzV46MrXo3SjchHI2haXaEljwz4B+e29cl/dUwOrRS085VbsWzN
         ISCuNZ/osu1X+QN1ydECzaNHMEtop//t/WxbUQZoJ3wx9xTBFqXKIupURA2uwrOhk/sh
         hGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700513766; x=1701118566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TZd4/9tDYUVpH+va2bN+Lz+wNAalFU9/JWBiin7Umg=;
        b=iK8yfjPr++auPBMTgPYw62XU4Yc0UY36Wdb7YhKvceiKs3q0A0+KL+QhFf0Nb6/U60
         QckwpyvjZkjUyf2ycMUHqEctKbwrv5am7HITf3dSQM3S3rEmskfTZc5gL7qkguK5rvz4
         2MmPAes67Lsg8GImD1nhb5aanpTXQJqP7f/bZZDpYyrLCPXWQ4kNUiMcURZkz0K5vOvx
         rRmNQ82nPmx6+SLarNhm5ruoOq0Rhy+aTcKT1ELSBiQyors4JXr6baQye5A613DfkSjl
         PRzRSYGn74falc4u5XbnfknCzrGtuQxFYxVjXrTmuMvtYyRVqO2WYqOLxTuRGjZAR9oP
         l1XA==
X-Gm-Message-State: AOJu0YwId0EknTV6z8cgmu9O0EHnz9IFkp4Xef6MlUIcRLHCbYyP2HSO
	NtSZy7bv5A0UZCpXiu36m/eZBNZkSeWhYo1EvVIB
X-Google-Smtp-Source: AGHT+IEaRVh061VYZ3MAeHPyfSYqU87TX2/fj8L258pJWZLZTg4+MCecpLfeUh+AQrPfjanR5lZ9zeXYiylSMWWt87o=
X-Received: by 2002:a25:8907:0:b0:da0:400e:750c with SMTP id
 e7-20020a258907000000b00da0400e750cmr7368373ybl.27.1700513765828; Mon, 20 Nov
 2023 12:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
 <20231107134012.682009-12-roberto.sassu@huaweicloud.com> <85c5dda2-5a2f-4c73-82ae-8a333b69b4a7@schaufler-ca.com>
 <1999ed6f77100d9d2adc613c9748f15ab8fcf432.camel@huaweicloud.com> <13f7542f-4039-47a8-abde-45a702b85718@schaufler-ca.com>
In-Reply-To: <13f7542f-4039-47a8-abde-45a702b85718@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Nov 2023 15:55:54 -0500
Message-ID: <CAHC9VhTPC6_dR0ymPtktVfi9rcFrnqXZL8Cq+c58OiijTRgOxg@mail.gmail.com>
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, mic@digikod.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 1:04=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 11/20/2023 9:31 AM, Roberto Sassu wrote:
> > On Tue, 2023-11-07 at 09:33 -0800, Casey Schaufler wrote:
> >> On 11/7/2023 5:40 AM, Roberto Sassu wrote:
> >>> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>>
> >>> In preparation for moving IMA and EVM to the LSM infrastructure, intr=
oduce
> >>> the inode_post_removexattr hook.
> >>>
> >>> At inode_removexattr hook, EVM verifies the file's existing HMAC valu=
e. At
> >>> inode_post_removexattr, EVM re-calculates the file's HMAC with the pa=
ssed
> >>> xattr removed and other file metadata.
> >>>
> >>> Other LSMs could similarly take some action after successful xattr re=
moval.
> >>>
> >>> The new hook cannot return an error and cannot cause the operation to=
 be
> >>> reverted.
> >>>
> >>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>> ---
> >>>  fs/xattr.c                    |  9 +++++----
> >>>  include/linux/lsm_hook_defs.h |  2 ++
> >>>  include/linux/security.h      |  5 +++++
> >>>  security/security.c           | 14 ++++++++++++++
> >>>  4 files changed, 26 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/fs/xattr.c b/fs/xattr.c
> >>> index 09d927603433..84a4aa566c02 100644
> >>> --- a/fs/xattr.c
> >>> +++ b/fs/xattr.c
> >>> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idma=
p,
> >>>             goto out;
> >>>
> >>>     error =3D __vfs_removexattr(idmap, dentry, name);
> >>> +   if (error)
> >>> +           goto out;
> >> Shouldn't this be simply "return error" rather than a goto to nothing
> >> but "return error"?
> > I got a review from Andrew Morton. His argument seems convincing, that
> > having less return places makes the code easier to handle.
>
> That was in a case where you did more than just "return". Nonetheless,
> I think it's a matter of style that's not worth debating. Do as you will.

I'm not too bothered by this in the VFS code, that's up to the VFS
maintainers, but for future reference, in the LSM layer I really
dislike jumping to a label simply to return.

--=20
paul-moore.com

