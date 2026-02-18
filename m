Return-Path: <linux-fsdevel+bounces-77590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ObREl/ilWliVwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:01:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C61578E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 597FD301875C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785C342503;
	Wed, 18 Feb 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz853NXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EA33373E;
	Wed, 18 Feb 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430480; cv=none; b=ROMDU7anjA3Ugar0c+K0M/1YUp0UIlyQCX3ZTRu9CUyI8H87qY2CiDV4CM0aYFbRhxZ68qfzQc7nNvtYvpMh8AEeUo3GCZEI8Sg8z2Vw7QM8mMaRcPexFu+CUSzX0zKnVEUfc0ip1L8t9ZG64fnGY7yAA6lx7kK0dLrI4h2ue+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430480; c=relaxed/simple;
	bh=INZqfbN/D59+LHdLP9VRpEOnXZG0qlidg7YVC3kEYU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gefIQXE25tLYzz+fmSVSZooeAcwkc5spM1qBghviWkrFnjkQc7aIg4x3G8UEvZEs1USdGgAuxSLPKIzgp6+oDG2+kL0D7JiYdC6ujjXYZuWZMTazuVM6J0JasnDqH4gjZrpFNdCP4EGSAeiSY7tiHiVdz/rBvTPI3Q2Z4MNRZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz853NXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D299C116D0;
	Wed, 18 Feb 2026 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771430479;
	bh=INZqfbN/D59+LHdLP9VRpEOnXZG0qlidg7YVC3kEYU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pz853NXxw9Y9noItYLpY8pxphX0A8NWEUq0qJ+EUEz9guv1Ncm5h6yMl3TS5XSRkl
	 nU8iB3/ht7ie3QRR5gTB3bn8dmw9HO+4GPF3nBaphw2mtQht3q/KMeUElAIsg4V2+6
	 T0q/cNJTJeejNds2HgY7QoWuUtkgAO+AW/FJ/YX8F6fQevjhcXPZK8twCgRJrgnN8P
	 qcU/c/VXJuYCSuaKWKAd60g8e1EIbHOaM0btffoKdn+yE9l2H4QIyQDhOvf0G62Sue
	 AMJSUAaIZnH2vJkO9LFVlGjhX872u5yT3zmqjpzMI7P5zxEYNA1W9kRUvkCZREyAif
	 vu9iWZ6dENUJQ==
Message-ID: <e0be58df89ffaf41763312dfffe8402fdcb9d023.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io,
 	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stgraber@stgraber.org, 	brauner@kernel.org, ksugihara@preferred.jp,
 utam0k@preferred.jp, 	trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, neilb@suse.de, 	miklos@szeredi.hu, jack@suse.cz,
 amir73il@gmail.com, trapexit@spawn.link
Date: Wed, 18 Feb 2026 11:01:16 -0500
In-Reply-To: <CAJqdLrqNzXRwMF2grTGCkaMKCEXAwemQLEi3wsL5Lp2W9D-ZVg@mail.gmail.com>
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
	 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
	 <CAJqdLrqNzXRwMF2grTGCkaMKCEXAwemQLEi3wsL5Lp2W9D-ZVg@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77590-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[preferred.jp:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E99C61578E2
X-Rspamd-Action: no action

On Wed, 2026-02-18 at 15:36 +0100, Alexander Mikhalitsyn wrote:
> Am Mi., 18. Feb. 2026 um 14:49 Uhr schrieb Jeff Layton <jlayton@kernel.or=
g>:
> >=20
> > On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > > Dear friends,
> > >=20
> > > I would like to propose "VFS idmappings support in NFS" as a topic fo=
r discussion at the LSF/MM/BPF Summit.
> > >=20
> > > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and c=
ephfs [1] with support/guidance
> > > from Christian.
> > >=20
> > > This experience with Cephfs & FUSE has shown that VFS idmap semantics=
, while being very elegant and
> > > intuitive for local filesystems, can be quite challenging to combine =
with network/network-like (e.g. FUSE)
> > > FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) a=
s a part of our agreement with
> > > ceph folks about the right way to support idmaps.
> > >=20
> > > One obstacle here was that cephfs has some features that are not very=
 Linux-wayish, I would say.
> > > In particular, system administrator can configure path-based UID/GID =
restrictions on a *server*-side (Ceph MDS).
> > > Basically, you can say "I expect UID 1000 and GID 2000 for all files =
under /stuff directory".
> > > The problem here is that these UID/GIDs are taken from a syscall-call=
er's creds (not from (struct file *)->f_cred)
> > > which makes cephfs FDs not very transferable through unix sockets. [3=
]
> > >=20
> > > These path-based UID/GID restrictions mean that server expects client=
 to send UID/GID with every single request,
> > > not only for those OPs where UID/GID needs to be written to the disk =
(mknod, mkdir, symlink, etc).
> > > VFS idmaps API is designed to prevent filesystems developers from mak=
ing a mistakes when supporting FS_ALLOW_IDMAP.
> > > For example, (struct mnt_idmap *) is not passed to every single i_op,=
 but instead to only those where it can be
> > > used legitimately. Particularly, readlink/listxattr or rmdir are not =
expected to use idmapping information anyhow.
> > >=20
> > > We've seen very similar challenges with FUSE. Not a long time ago on =
Linux Containers project forum, there
> > > was a discussion about mergerfs (a popular FUSE-based filesystem) & V=
FS idmaps [5]. And I see that this problem
> > > of "caller UID/GID are needed everywhere" still blocks VFS idmaps ado=
ption in some usecases.
> > > Antonio Musumeci (mergerfs maintainer) claimed that in many cases fil=
esystems behind mergerfs may not be fully
> > > POSIX and basically, when mergerfs does IO on the underlying FSes it =
needs to do UID/GID switch to caller's UID/GID
> > > (taken from FUSE request header).
> > >=20
> > > We don't expect NFS to be any simpler :-) I would say that supporting=
 NFS is a final boss. It would be great
> > > to have a deep technical discussion with VFS/FSes maintainers and dev=
elopers about all these challenges and
> > > make some conclusions and identify a right direction/approach to thes=
e problems. From my side, I'm going
> > > to get more familiar with high-level part of NFS (or even make PoC if=
 time permits), identify challenges,
> > > summarize everything and prepare some slides to navigate/plan discuss=
ion.
> > >=20
> > > [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.18210=
1-1-aleksandr.mikhalitsyn@canonical.com
> > > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > > [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21=
qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > > [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/2024090315162=
6.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > > [5]
> > > mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you=
-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-moun=
t-is-there-a-workaround/25336/11?u=3Damikhalitsyn
> > >=20
> > > Kind regards,
> > > Alexander Mikhalitsyn @ futurfusion.io
> >=20
>=20
> Hi Jeff,
>=20
> thanks for such a fast reply! ;)
>=20
> >=20
> > IIUC, people mostly use vfs-layer idmappings because they want to remap
> > the uid/gid values of files that get stored on the backing store (disk,
> > ceph MDS, or whatever).
>=20
> yes, precisely.
>=20
> >=20
> > I've never used idmappings myself much in practice. Could you lay out
> > an example of how you would use them with NFS in a real environment so
> > I understand the problem better? I'd start by assuming a simple setup
> > with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> > be fairly straightforward.
>=20
> For me, from the point of LXC/Incus project, idmapped mounts are used as
> a way to "delegate" filesystems (or subtrees) to the containers:
> 1. We, of course, assume that container enables user namespaces and
> user can't mount a filesystem
> inside because it has no FS_USERNS_MOUNT flag set (like in case of Cephfs=
, NFS,
> CIFS and many others).
> 2. At the same time host's system administrator wants to avoid
> remapping between container's user ns and
> sb->s_user_ns (which is init_user_ns for those filesystems). [
> motivation here is that in many
> cases you may want to have the same subtree to be shared with other
> containers and even host users too and
> you want UIDs to be "compatible", i.e UID 1000 in one container and
> UID 1000 in another container should
> land as UID 1000 on the filesystem's inode ]
>=20
> For this usecase, when we bind-mount filesystem to container, we apply
> VFS idmap equal to container's
> user namespace. This makes a behavior I described.
>=20

Ok: so you have a process running in a userns as UID 2000 and you want
to use vfs layer idmapping so that when you create a file as that user
that it ends up being owned by UID 1000. Is that basically correct?

Typically, the RPC credentials used in an OPEN or CREATE call is what
determines its ownership (at least until a SETATTR comes in). With
AUTH_SYS, the credential is just a uid and set of gids.

So in this case, it sounds like you would need just do that conversion
(maybe at the RPC client layer?) when issuing an RPC. You don't really
need a protocol extension for that case.

As Trond points out though, AUTH_GSS and NFSv4 idmapping will make this
more complex. Once you're using kerberos credentials for
authentication, you don't have much control over what the UIDs and GIDs
will be on newly-created files, but is that really a problem? As long
as all of the clients have a consistent view, I wouldn't think so.

> But this is just one use case. I'm pretty sure there are some more
> around here :)
> I know that folks from Preferred Networks (preferred.jp) are also
> interested in VFS idmap support in NFS,
> probably they can share some ideas/use cases too.
>=20
>=20

Yes, we don't want to focus too much on a single use-case, but I find
it helpful to focus on a single simple problem first.
--=20
Jeff Layton <jlayton@kernel.org>

