Return-Path: <linux-fsdevel+bounces-41049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E3A2A527
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FEF164659
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFD422653D;
	Thu,  6 Feb 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="l2bpM0JJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64E1FDE08
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835511; cv=none; b=YnfqpdZzEphj2MV8JyzwPZwG+7fpbBVk8ofMMOA2dnVfm0GRcQsXCyINIgfXCyI6rPQ7/Z+W5lixSi3RdaTxrX+++6sMQEKmSc6gUNCwmQKla0U9g4gIw8Qvq6Qct0WqeBinCaGZFnGhvh3eui2S8bhWHvVe6Op/kNYiN+x0BlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835511; c=relaxed/simple;
	bh=Ni8gutXVKMRqos6yCMp4awMbgZVqcfe2letlDQuVQfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgf14SuhGGDNbRWlaYf6OKgJRD+oHN218RMPsSCAg+HklJQQgoh8m2FJPBQ2nhjZCM8oBRUXL/UNmyQNtgXTu7wY9ekV2b8Ii/B20pCFn8mbXuOVMKp67Jqbc06UGJx8Jh1fiYECdD56fKQFA9uq5n4Nuytdteb0KVbSlE26cbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=l2bpM0JJ; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1738835500; x=1739094700;
	bh=L6gAvZL7PgSB+nG1k5fJgwlRsKzBynySE+dxg3Aa6uc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=l2bpM0JJVRIsa/cTQElE6hrDbyFw7hIhO5dKxN5KLi7FMIOVpt3GzzQZ4un0nG6GE
	 H8ezuNG8NB+irQQ/6kup179c/MQ/H/rAHxThCc2o1/pjy7zN5i4HE8NEGZakXFiRgU
	 ifrVlKnnjhCuBldmFAtn08n3kfcVWwRsUe/tk4xmg52SHY6LxbP2DkQ5j5Dh1AHs1y
	 n4s3i+Buk0Sh+yrOKosD0QBMD5uk1ej6Etu09KKJsSLT2hIAXb7wIlo3aUxXc0VxyX
	 eeWQGE/7NUAqE1MCpTOd75K6xerDKv3IGeTnhe4jZDRKXNVcrQ8DxQnb5ZWYzIcbDe
	 tRHoitHcpklqw==
Date: Thu, 06 Feb 2025 09:51:33 +0000
To: "brauner@kernel.org" <brauner@kernel.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "cgzones@googlemail.com" <cgzones@googlemail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat() syscalls
Message-ID: <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com>
In-Reply-To: <20250206-uhrwerk-faultiere-7a308565e2d3@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com> <20250206-uhrwerk-faultiere-7a308565e2d3@brauner>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 3a961205d5f56ec1f7e40996895013c95d3b8356
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/25 10:31, Christian Brauner <brauner@kernel.org> wrote:

>  On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
>  > Cited from commit message of original patch [1]:
>  >
>  > > One use case will be setfiles(8) setting SELinux file contexts
>  > > ("security.selinux") without race conditions and without a file
>  > > descriptor opened with read access requiring SELinux read permission=
.
>  >
>  > Also, generally all *at() syscalls operate on O_PATH fds, unlike
>  > f*() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
>  > in the final version merged into tree. Instead, let's switch things
>  > to CLASS(fd_raw).
>  >
>  > Note that there's one side effect: f*xattr() starts to work with
>  > O_PATH fds too. It's not clear to me whether this is desirable
>  > (e.g. fstat() accepts O_PATH fds as an outlier).
>  >
>  > [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsche@sel=
tendoof.de/
>  >
>  > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
>  > Signed-off-by: Mike Yuan <me@yhndnzj.com>
>  > Cc: Al Viro <viro@zeniv.linux.org.uk>
>  > Cc: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>  > Cc: Christian Brauner <brauner@kernel.org>
>  > Cc: <stable@vger.kernel.org>
>  > ---
> =20
>  I expanded on this before. O_PATH is intentionally limited in scope and
>  it should not allow to perform operations that are similar to a read or
>  write which getting and setting xattrs is.
> =20
>  Patches that further weaken or dilute the semantics of O_PATH are not
>  acceptable.

But the *at() variants really should be able to work with O_PATH fds, other=
wise they're basically useless? I guess I just need to keep f*() as-is?

>  >  fs/xattr.c | 8 ++++----
>  >  1 file changed, 4 insertions(+), 4 deletions(-)
>  >
>  > diff --git a/fs/xattr.c b/fs/xattr.c
>  > index 02bee149ad96..15df71e56187 100644
>  > --- a/fs/xattr.c
>  > +++ b/fs/xattr.c
>  > @@ -704,7 +704,7 @@ static int path_setxattrat(int dfd, const char __u=
ser *pathname,
>  >
>  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  >  =09if (!filename) {
>  > -=09=09CLASS(fd, f)(dfd);
>  > +=09=09CLASS(fd_raw, f)(dfd);
>  >  =09=09if (fd_empty(f))
>  >  =09=09=09error =3D -EBADF;
>  >  =09=09else
>  > @@ -848,7 +848,7 @@ static ssize_t path_getxattrat(int dfd, const char=
 __user *pathname,
>  >
>  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  >  =09if (!filename) {
>  > -=09=09CLASS(fd, f)(dfd);
>  > +=09=09CLASS(fd_raw, f)(dfd);
>  >  =09=09if (fd_empty(f))
>  >  =09=09=09return -EBADF;
>  >  =09=09return file_getxattr(fd_file(f), &ctx);
>  > @@ -978,7 +978,7 @@ static ssize_t path_listxattrat(int dfd, const cha=
r __user *pathname,
>  >
>  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  >  =09if (!filename) {
>  > -=09=09CLASS(fd, f)(dfd);
>  > +=09=09CLASS(fd_raw, f)(dfd);
>  >  =09=09if (fd_empty(f))
>  >  =09=09=09return -EBADF;
>  >  =09=09return file_listxattr(fd_file(f), list, size);
>  > @@ -1079,7 +1079,7 @@ static int path_removexattrat(int dfd, const cha=
r __user *pathname,
>  >
>  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  >  =09if (!filename) {
>  > -=09=09CLASS(fd, f)(dfd);
>  > +=09=09CLASS(fd_raw, f)(dfd);
>  >  =09=09if (fd_empty(f))
>  >  =09=09=09return -EBADF;
>  >  =09=09return file_removexattr(fd_file(f), &kname);
>  >
>  > base-commit: a86bf2283d2c9769205407e2b54777c03d012939
>  > --
>  > 2.48.1
>  >
>  >
>  

