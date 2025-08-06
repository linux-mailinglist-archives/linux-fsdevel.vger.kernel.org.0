Return-Path: <linux-fsdevel+bounces-56874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E2B1CB92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47CD18C385C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA41F8723;
	Wed,  6 Aug 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="yNHRukNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239691B960;
	Wed,  6 Aug 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503378; cv=none; b=rCxlnfRgbrHXRIToLfN56iD50PVdhpwzhOGzvVkNMsSyp2boZajsljKbRvqIpWfFOark4pFR0C3OXG4TtROy8PVAZxU2RmsH3Tf4xKofEtMw0en3HtelXG5uW3seTDZbN/hdfIuhb9fkTQTA7yCIncJXPrLbNseaFkYCieF3evA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503378; c=relaxed/simple;
	bh=i+HIYjZwsSEIApmr8/P/PkZHmqlNO0ko8SgjKiB8jOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha78W8GFQ5yt1+CYil79GUP9/brDMtmd/270MrDj4SwyGk3RLg1wubGs7MhKUOKNiCTORhGbxexr5T6ZF9QqTsD4nvChWycyvbtoT6EraPT1U0gXChdUvanNVMCGbtCinIIc07YtNPKQevu+oGBReaBiRVutTMZvtCeyv34Q1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=yNHRukNS; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bxynS0p1Rz9tfY;
	Wed,  6 Aug 2025 20:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754503372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcSx0xTYEEub8lUPdI8CKTyYuFBsdUD5lOH8ZHS1BNM=;
	b=yNHRukNSHwxPGXF7LNLhxt6HKY68gCvSULsDcf8q+hnTM1+ZohhyS4kN9CzjZlViOC2ynJ
	DdeZXJIbYCv4XuIvPSVwk1hZjM1bFhtfqKzqu96XYtVpZNQsdwz0PSui1NW905vWk1RBYp
	RtUyZ5NdG3Xw3Dc3C/1hEPeJsOA8av4c30uuCfXYRSu1IkF0nRb12FKjUzzpHI3x6t6WhC
	QufLlwTusMUSgdkXE1azuFpluAS9i91LLLmSFkITteeNaDLzefknPOmT01Wd6ztMADFQnG
	VtRdkYDiPyPzIPoKFF0KkCPVb8//lhvsmvt/Hc05GgOTvEaVYl09lyzPJYLH5A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 7 Aug 2025 04:02:41 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Message-ID: <2025-08-06.1754503216-vulgar-pinch-more-tasks-meager-grader-93KeQn@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250805-procfs-pidns-api-v4-3-705f984940e7@cyphar.com>
 <9027aa89-b3b2-46c8-8338-6c37f1c5b97a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eu46eil6qrlqkmuz"
Content-Disposition: inline
In-Reply-To: <9027aa89-b3b2-46c8-8338-6c37f1c5b97a@infradead.org>
X-Rspamd-Queue-Id: 4bxynS0p1Rz9tfY


--eu46eil6qrlqkmuz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
MIME-Version: 1.0

On 2025-08-05, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
>=20
> On 8/4/25 10:45 PM, Aleksa Sarai wrote:
> > /proc has historically had very opaque semantics about PID namespaces,
> > which is a little unfortunate for container runtimes and other programs
> > that deal with switching namespaces very often. One common issue is that
> > of converting between PIDs in the process's namespace and PIDs in the
> > namespace of /proc.
> >=20
> > In principle, it is possible to do this today by opening a pidfd with
> > pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> > contain a PID value translated to the pid namespace associated with that
> > procfs superblock). However, allocating a new file for each PID to be
> > converted is less than ideal for programs that may need to scan procfs,
> > and it is generally useful for userspace to be able to finally get this
> > information from procfs.
> >=20
> > So, add a new API to get the pid namespace of a procfs instance, in the
> > form of an ioctl(2) you can call on the root directory of said procfs.
> > The returned file descriptor will have O_CLOEXEC set. This acts as a
> > sister feature to the new "pidns" mount option, finally allowing
> > userspace full control of the pid namespaces associated with procfs
> > instances.
> >=20
> > The permission model for this is a bit looser than that of the "pidns"
> > mount option (and also setns(2)) because /proc/1/ns/pid provides the
> > same information, so as long as you have access to that magic-link (or
> > something equivalently reasonable such as being in an ancestor pid
> > namespace) it makes sense to allow userspace to grab a handle. Ideally
> > we would check for ptrace-read access against all processes in the pidns
> > (which is very likely to be true for at least one process, as
> > SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set by most
> > programs), but this would obviously not scale.
> >=20
> > setns(2) will still have their own permission checks, so being able to
> > open a pidns handle doesn't really provide too many other capabilities.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  Documentation/filesystems/proc.rst |  4 +++
> >  fs/proc/root.c                     | 68 ++++++++++++++++++++++++++++++=
++++++--
> >  include/uapi/linux/fs.h            |  4 +++
> >  3 files changed, 74 insertions(+), 2 deletions(-)
> >=20
>=20
>=20
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 0bd678a4a10e..68e65e6d7d6b 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -435,8 +435,12 @@ typedef int __bitwise __kernel_rwf_t;
> >  			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> >  			 RWF_DONTCACHE)
> > =20
> > +/* This matches XSDFEC_MAGIC, so we need to allocate subvalues careful=
ly. */
> >  #define PROCFS_IOCTL_MAGIC 'f'
> > =20
> > +/* procfs root ioctls */
> > +#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 32)
>=20
> Since the _IO() nr here is 32, Documentation/userspace-api/ioctl/ioctl-nu=
mber.rst
> should be updated like:
>=20
> -'f'   00-0F  linux/fs.h                                                c=
onflict!
> +'f'   00-1F  linux/fs.h                                                c=
onflict!

Should this be 00-20 (or 00-2F) instead?

Also, is there a better value to use for this new ioctl? I'm not quite
sure what is the best practice to handle these kinds of conflicts...

> (17 is already used for PROCFS_IOCTL_MAGIC somewhere else, so that probab=
ly should
> have update the Doc/rst file.)
>=20
> > +
> >  /* Pagemap ioctl */
> >  #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
> > =20
> >=20
> Thanks.
> --=20
> ~Randy
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--eu46eil6qrlqkmuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJOYwQAKCRAol/rSt+lE
b52DAP9rIrvzDbmNWooTppIvB6Vs+2oyk+y2Sxown5C5ATO0CQD/TQ/lk5cTOfxc
D2lZstD5/hT/9cMIIbLE7OIfp3stEwA=
=Dzjt
-----END PGP SIGNATURE-----

--eu46eil6qrlqkmuz--

