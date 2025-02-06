Return-Path: <linux-fsdevel+bounces-41084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342DA2AB30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60401697F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1622E41C;
	Thu,  6 Feb 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="YGyNQ4np"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB03225A30;
	Thu,  6 Feb 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852025; cv=none; b=pT74jU6jQ1dNNOxwt5W3VJIFiP78VU+b07JrXCvjcYu9JnPdrGyak7sAS7qYaJEm30FfX3APKFj5oCW4i/ITmFFxYPWWnEx7A+CG2I/dgO/ub0svxOfQuBvs2ht266TQPiqyI6r+h/FMHBBHIEgxp5MVb081xj2yagwcr5FIu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852025; c=relaxed/simple;
	bh=iVCLCbK7Yjlk20kLR2pWEGX1YRsFz35BRApmT2khLyc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff1GmbOgXMDGES/+TEeLjEK/Q+Rk3UdqGszq3xMD5NAvjvaZ9sSNUbswggXQyLfpt2QT4O2QzbIp1C99oF0inb6QD3g3Oi891WeYUQvK71XtZ4Hwq/ZWsfaBdx9HmgLwIX41zLZAr+PmB8LdpZFzl8rBaLKo7/ueYZbiy5Xo/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=YGyNQ4np; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1738852015; x=1739111215;
	bh=iVCLCbK7Yjlk20kLR2pWEGX1YRsFz35BRApmT2khLyc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YGyNQ4npdiUmvfnhC5rdpkgyg5d+nGB4yBdAA1kfRv/s3n2czK/61VJHspRdWofVO
	 CrkcTZqxffmDBbU7HmWcRv6mcHLzLM5BIcMvmBnHmblPzk2U+8ne8IqBbXE3Ueze6e
	 sGZ+zDljAsuycK2KWbLFS/4MJyo8VJ7d2r9I1NK/AbSz6yZpyjSuYgtb6gdTkQXf2j
	 p2JXaqYl8D5efKGBHNPUS1BtqEDmzfUTie6qtdBF0NNRg5Lspk69BRW/afTj16FtvA
	 6sCqF6l1iobNP3HP9/fyFeLUJZJ2x4j5wtsCMhV5x3GglV1eYGtD7VONAC7hNCZ1Po
	 xrBlBwdN67KwQ==
Date: Thu, 06 Feb 2025 14:26:51 +0000
To: Christian Brauner <brauner@kernel.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "cgzones@googlemail.com" <cgzones@googlemail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat() syscalls
Message-ID: <Ah2vDyFwRPpHngjgEblSFQWijS6qnrD_LSbpUrdefKpgTotaT4CyzL4RqaWM7axQamVuGi3hPdIzuXl9qBlfHZ9m4-hcUWaWuaoc35Gt8D8=@yhndnzj.com>
In-Reply-To: <20250206-wisst-rangieren-d59f7882761a@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com> <20250206-uhrwerk-faultiere-7a308565e2d3@brauner> <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com> <20250206-erbauen-ornament-26f338d98f13@brauner> <cfnfHaahrrXJJOgvNjb5hFbU0qh8gVXJ62R9uP9AItBEywyNH9vNBRzJbPR8xTv-LtFaUJYTHvyuLBfkznwJPt3fEcqNBFxf_yKJeZKwL3I=@yhndnzj.com> <20250206-wisst-rangieren-d59f7882761a@brauner>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: deb37af898534a00969af632521ea1a05b5f9593
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-02-06 at 14:35, Christian Brauner <brauner@kernel.org> wrote:
>=20
> On Thu, Feb 06, 2025 at 01:25:19PM +0000, Mike Yuan wrote:
>=20
> > On 2/6/25 11:03, Christian Brauner brauner@kernel.org wrote:
> >=20
> > > On Thu, Feb 06, 2025 at 09:51:33AM +0000, Mike Yuan wrote:
> > >=20
> > > > On 2/6/25 10:31, Christian Brauner brauner@kernel.org wrote:
> > > >=20
> > > > > On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
> > > > >=20
> > > > > > Cited from commit message of original patch [1]:
> > > > > >=20
> > > > > > > One use case will be setfiles(8) setting SELinux file context=
s
> > > > > > > ("security.selinux") without race conditions and without a fi=
le
> > > > > > > descriptor opened with read access requiring SELinux read per=
mission.
> > > > > >=20
> > > > > > Also, generally all at() syscalls operate on O_PATH fds, unlike
> > > > > > f() ones. Yet the O_PATH fds are rejected by *xattrat() syscall=
s
> > > > > > in the final version merged into tree. Instead, let's switch th=
ings
> > > > > > to CLASS(fd_raw).
> > > > > >=20
> > > > > > Note that there's one side effect: f*xattr() starts to work wit=
h
> > > > > > O_PATH fds too. It's not clear to me whether this is desirable
> > > > > > (e.g. fstat() accepts O_PATH fds as an outlier).
> > > > > >=20
> > > > > > [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoetts=
che@seltendoof.de/
> > > > > >=20
> > > > > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > > > > Signed-off-by: Mike Yuan me@yhndnzj.com
> > > > > > Cc: Al Viro viro@zeniv.linux.org.uk
> > > > > > Cc: Christian G=C3=B6ttsche cgzones@googlemail.com
> > > > > > Cc: Christian Brauner brauner@kernel.org
> > > > > > Cc: stable@vger.kernel.org
> > > > > > ---
> > > > >=20
> > > > > I expanded on this before. O_PATH is intentionally limited in sco=
pe and
> > > > > it should not allow to perform operations that are similar to a r=
ead or
> > > > > write which getting and setting xattrs is.
> > > > >=20
> > > > > Patches that further weaken or dilute the semantics of O_PATH are=
 not
> > > > > acceptable.
> > > >=20
> > > > But the at() variants really should be able to work with O_PATH fds=
, otherwise they're basically useless? I guess I just need to keep f() as-i=
s?
> > >=20
> > > I'm confused. If you have:
> > >=20
> > > filename =3D getname_maybe_null(pathname, at_flags);
> > > if (!filename) {
> > > CLASS(fd, f)(dfd);
> > > if (fd_empty(f))
> > > error =3D -EBADF;
> > > else
> > > error =3D file_setxattr(fd_file(f), &ctx);
> > >=20
> > > Then this branch ^^ cannot use fd_raw because you're allowing operati=
ons
> > > directly on the O_PATH file descriptor.
> > >=20
> > > Using the O_PATH file descriptor for lookup is obviously fine which i=
s
> > > why the other branch exists:
> > >=20
> > > } else {
> > > error =3D filename_setxattr(dfd, filename, lookup_flags, &ctx);
> > > }
> > >=20
> > > IOW, your patch makes AT_EMPTY_PATH work with an O_PATH file descript=
or
> > > which isn't acceptable. However, it is already perfectly fine to use =
an
> > > O_PATH file descriptor for lookup.
> >=20
> > Well, again, [1] clearly stated the use case:
> >=20
> > > Those can be used to operate on extended attributes,
> > > especially security related ones, either relative to a pinned directo=
ry
> > > or [on a file descriptor without read access, avoiding a
> > > /proc/<pid>/fd/<fd> detour, requiring a mounted procfs].
> >=20
> > And this surfaced in my PR to systemd:
> >=20
> > https://github.com/systemd/systemd/pull/36228/commits/34fe16fb177d2f917=
570c5f71dfa8f5b9746b9a7
> >=20
> > How are xattrat() syscalls different from e.g. fchmodat2(AT_EMPTY_PATH)=
 in that regard? I can agree that the semantics of fxattr() ought to be lef=
t untouched, yet I fail to grok the case for _at variants.
>=20
>=20
> man openat:
>=20
> O_PATH (since Linux 2.6.39)
> Obtain a file descriptor that can be used for two purposes: to indicate a=
 location in the filesystem tree and to perform operations that act purely =
at the file descriptor level.
> The file itself is not opened, and other file operations (e.g., read(2), =
write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2)) fail with =
the error EBADF.
>=20
> The following operations can be performed on the resulting file descripto=
r:
>=20
> =E2=80=A2 close(2).
>=20
> =E2=80=A2 fchdir(2), if the file descriptor refers to a directory (since =
Linux 3.5).
>=20
> =E2=80=A2 fstat(2) (since Linux 3.6).
>=20
> =E2=80=A2 fstatfs(2) (since Linux 3.12).
>=20
> =E2=80=A2 Duplicating the file descriptor (dup(2), fcntl(2) F_DUPFD, etc.=
).
>=20
> =E2=80=A2 Getting and setting file descriptor flags (fcntl(2) F_GETFD and=
 F_SETFD).
>=20
> =E2=80=A2 Retrieving open file status flags using the fcntl(2) F_GETFL op=
eration: the returned flags will include the bit O_PATH.
>=20
> =E2=80=A2 Passing the file descriptor as the dirfd argument of openat() a=
nd the other "*at()" system calls. This includes linkat(2) with AT_EMPTY_PA=
TH (or via procfs using AT_SYM=E2=80=90
> LINK_FOLLOW) even if the file is not a directory.
>=20
> =E2=80=A2 Passing the file descriptor to another process via a UNIX domai=
n socket (see SCM_RIGHTS in unix(7)).
>=20
> Both fchownat() and fchmodat() variants have had this behavior which
> is a bug. And not a great one because it breaks O_PATH guarantees.
> That's no reason to now also open up further holes such as getting and
> setting xattrs.

AFAICS that's not really what the kernel development has been after.
fchmodat2(2) in particular was added fairly recently (6.6,
https://github.com/torvalds/linux/commit/09da082b07bbae1c11d9560c8502800039=
aebcea).
One of the highlights was to add support for O_PATH + AT_EMPTY_PATH).

And to me the semantics seem reasonably OK really: O_PATH fds are a way to
pin the inode (i.e. still within the boundry of getting a reference to
a file system object (without opening it) if I shall put it). All the calls
mentioned above operate on the file system object metadata, not the actual =
data,
hence O_PATH is just providing a file _location_.

The separation of *at() and regular f*() versions have remained pretty cons=
istent too
(of cource, not with this patch, which is mostly an RFC) - fchmod() and fch=
own()
refuse O_PATH fds while the at() counterparts accept them. Did all these su=
ddenly
change overnight?

> If you want to perform read/write like operations you need a proper file
> descriptor for that and not continue to expand the meaning of O_PATH
> until it is indistinguishable from a regular file descriptor.

I definitely agree. But xattr is metadata, not data. listxattr() does not e=
ven
do any POSIX permission check...

