Return-Path: <linux-fsdevel+bounces-41075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19444A2A9C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444801650D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567741624C2;
	Thu,  6 Feb 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="hw6cuxop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC51EA7FF;
	Thu,  6 Feb 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848338; cv=none; b=T65cjcJz1cZrKv+YwEM/EUqUAObul+KslZ7I8z5K+9FzCnN2nLhTYmG+z9Oa3JV7zFwHlyfB5D1X5ujVeU+kHzwSr7jea5JKuTLVcZ5LIs4XXdxDaRWkNQSl2c1LzYMc7BQjsiQIzPWInS1nxOQh4qPj9ORW32S+GtUgNK+dxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848338; c=relaxed/simple;
	bh=5NpQ4X93HhWFIWaadKzTlPn/L/mmiE35/1eMueqdciw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4O8vhLOKtjlLgMbk34SCJI/mKp9HHfsFW2e9d6R8L/L8itFtyb79h8+XT6yofI52NdN4kmsn/8M50jtp+LdkNG/hYm0IfuXAklUDJe0Kg8ALSzJ64i9VaaRKMy8ZnmwJQ/LHvRAkXqSymgUrehfGoT9C5SmrBBBrH9zs1GMLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=hw6cuxop; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1738848326; x=1739107526;
	bh=Ruke8ibh7q4d9OfDm4mTFJ0uMb4IfmsuXxLQqR6Dag0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=hw6cuxopyk6Q8KYNSARUXrVfUa2aW8/7mK3AvLCLF6j1hq7bJltQvmfCoQUwx5zRk
	 ICg9FhiN52gLfepKxmLnc3i96cDYucmXMW+FuYA/19IM/9uTKPj2Iu352wiq9jI0bu
	 0UGidB3fVNuO3XqmBHx7ZwVbg2DNamVBpu44MysWkqogioJ7BDxTGumyY8yirvJhRJ
	 fdqFrFcaepMuI7txptEU8tv525XHQQOiac2PvC6Uc8cBLRuuJe1xd1f0G18UsLbQjK
	 5Gs9mna1fStqhRqL5llCiZwB8JcwP5gJAWN2Z31CJxXYTD0sKOaw1csam4d+V/IJYw
	 M34wXsih5cjjg==
Date: Thu, 06 Feb 2025 13:25:19 +0000
To: "brauner@kernel.org" <brauner@kernel.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "cgzones@googlemail.com" <cgzones@googlemail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat() syscalls
Message-ID: <cfnfHaahrrXJJOgvNjb5hFbU0qh8gVXJ62R9uP9AItBEywyNH9vNBRzJbPR8xTv-LtFaUJYTHvyuLBfkznwJPt3fEcqNBFxf_yKJeZKwL3I=@yhndnzj.com>
In-Reply-To: <20250206-erbauen-ornament-26f338d98f13@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com> <20250206-uhrwerk-faultiere-7a308565e2d3@brauner> <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com> <20250206-erbauen-ornament-26f338d98f13@brauner>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 11e3e903fb487a66c3ef10bdd2e7699505872930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/25 11:03, Christian Brauner <brauner@kernel.org> wrote:

>  On Thu, Feb 06, 2025 at 09:51:33AM +0000, Mike Yuan wrote:
>  > On 2/6/25 10:31, Christian Brauner <brauner@kernel.org> wrote:
>  >
>  > >  On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
>  > >  > Cited from commit message of original patch [1]:
>  > >  >
>  > >  > > One use case will be setfiles(8) setting SELinux file contexts
>  > >  > > ("security.selinux") without race conditions and without a file
>  > >  > > descriptor opened with read access requiring SELinux read permi=
ssion.
>  > >  >
>  > >  > Also, generally all *at() syscalls operate on O_PATH fds, unlike
>  > >  > f*() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
>  > >  > in the final version merged into tree. Instead, let's switch thin=
gs
>  > >  > to CLASS(fd_raw).
>  > >  >
>  > >  > Note that there's one side effect: f*xattr() starts to work with
>  > >  > O_PATH fds too. It's not clear to me whether this is desirable
>  > >  > (e.g. fstat() accepts O_PATH fds as an outlier).
>  > >  >
>  > >  > [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsch=
e@seltendoof.de/
>  > >  >
>  > >  > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
>  > >  > Signed-off-by: Mike Yuan <me@yhndnzj.com>
>  > >  > Cc: Al Viro <viro@zeniv.linux.org.uk>
>  > >  > Cc: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>  > >  > Cc: Christian Brauner <brauner@kernel.org>
>  > >  > Cc: <stable@vger.kernel.org>
>  > >  > ---
>  > >
>  > >  I expanded on this before. O_PATH is intentionally limited in scope=
 and
>  > >  it should not allow to perform operations that are similar to a rea=
d or
>  > >  write which getting and setting xattrs is.
>  > >
>  > >  Patches that further weaken or dilute the semantics of O_PATH are n=
ot
>  > >  acceptable.
>  >
>  > But the *at() variants really should be able to work with O_PATH fds, =
otherwise they're basically useless? I guess I just need to keep f*() as-is=
?
> =20
>  I'm confused. If you have:
> =20
>          filename =3D getname_maybe_null(pathname, at_flags);
>          if (!filename) {
>                  CLASS(fd, f)(dfd);
>                  if (fd_empty(f))
>                          error =3D -EBADF;
>                  else
>                          error =3D file_setxattr(fd_file(f), &ctx);
> =20
>  Then this branch ^^ cannot use fd_raw because you're allowing operations
>  directly on the O_PATH file descriptor.
> =20
>  Using the O_PATH file descriptor for lookup is obviously fine which is
>  why the other branch exists:
> =20
>          } else {
>                  error =3D filename_setxattr(dfd, filename, lookup_flags,=
 &ctx);
>          }
> =20
>  IOW, your patch makes AT_EMPTY_PATH work with an O_PATH file descriptor
>  which isn't acceptable. However, it is already perfectly fine to use an
>  O_PATH file descriptor for lookup.

Well, again, [1] clearly stated the use case:

> Those can be used to operate on extended attributes,
especially security related ones, either relative to a pinned directory
or [on a file descriptor without read access, avoiding a
/proc/<pid>/fd/<fd> detour, requiring a mounted procfs].

And this surfaced in my PR to systemd:

https://github.com/systemd/systemd/pull/36228/commits/34fe16fb177d2f917570c=
5f71dfa8f5b9746b9a7

How are *xattrat() syscalls different from e.g. fchmodat2(AT_EMPTY_PATH) in=
 that regard? I can agree that the semantics of f*xattr() ought to be left =
untouched, yet I fail to grok the case for _at variants.

>  >
>  > >  >  fs/xattr.c | 8 ++++----
>  > >  >  1 file changed, 4 insertions(+), 4 deletions(-)
>  > >  >
>  > >  > diff --git a/fs/xattr.c b/fs/xattr.c
>  > >  > index 02bee149ad96..15df71e56187 100644
>  > >  > --- a/fs/xattr.c
>  > >  > +++ b/fs/xattr.c
>  > >  > @@ -704,7 +704,7 @@ static int path_setxattrat(int dfd, const cha=
r __user *pathname,
>  > >  >
>  > >  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  > >  >  =09if (!filename) {
>  > >  > -=09=09CLASS(fd, f)(dfd);
>  > >  > +=09=09CLASS(fd_raw, f)(dfd);
>  > >  >  =09=09if (fd_empty(f))
>  > >  >  =09=09=09error =3D -EBADF;
>  > >  >  =09=09else
>  > >  > @@ -848,7 +848,7 @@ static ssize_t path_getxattrat(int dfd, const=
 char __user *pathname,
>  > >  >
>  > >  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  > >  >  =09if (!filename) {
>  > >  > -=09=09CLASS(fd, f)(dfd);
>  > >  > +=09=09CLASS(fd_raw, f)(dfd);
>  > >  >  =09=09if (fd_empty(f))
>  > >  >  =09=09=09return -EBADF;
>  > >  >  =09=09return file_getxattr(fd_file(f), &ctx);
>  > >  > @@ -978,7 +978,7 @@ static ssize_t path_listxattrat(int dfd, cons=
t char __user *pathname,
>  > >  >
>  > >  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  > >  >  =09if (!filename) {
>  > >  > -=09=09CLASS(fd, f)(dfd);
>  > >  > +=09=09CLASS(fd_raw, f)(dfd);
>  > >  >  =09=09if (fd_empty(f))
>  > >  >  =09=09=09return -EBADF;
>  > >  >  =09=09return file_listxattr(fd_file(f), list, size);
>  > >  > @@ -1079,7 +1079,7 @@ static int path_removexattrat(int dfd, cons=
t char __user *pathname,
>  > >  >
>  > >  >  =09filename =3D getname_maybe_null(pathname, at_flags);
>  > >  >  =09if (!filename) {
>  > >  > -=09=09CLASS(fd, f)(dfd);
>  > >  > +=09=09CLASS(fd_raw, f)(dfd);
>  > >  >  =09=09if (fd_empty(f))
>  > >  >  =09=09=09return -EBADF;
>  > >  >  =09=09return file_removexattr(fd_file(f), &kname);
>  > >  >
>  > >  > base-commit: a86bf2283d2c9769205407e2b54777c03d012939
>  > >  > --
>  > >  > 2.48.1
>  > >  >
>  > >  >
>  > >
>  

