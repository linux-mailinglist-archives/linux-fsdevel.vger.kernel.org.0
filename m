Return-Path: <linux-fsdevel+bounces-77580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GqEN6fOlWnjUwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:37:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B95157187
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B71C3019441
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36157334C2B;
	Wed, 18 Feb 2026 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrnQhCXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68702D77FF;
	Wed, 18 Feb 2026 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771425439; cv=none; b=C2QAHppg2wREpvLs6s1W+8dbI0O0iWHUC4/q7r+BaN4mgjbPv+0YZQBs9rX1gFgI4Zi2J9FKVLBQsL7++kzdezg0rVTrhJXF5bWXWokV3kkMdVGEVLG6TBdxyjAxcpQK1nmx6jpb89LLb+bwP+3pprlqy5HZd23xk79K8gpk7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771425439; c=relaxed/simple;
	bh=WVrTOELnfJzl9+EaWv4I60Yg619nZ93eNj6+a+T9StA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBsoaMgCex9dzHMmccWrnzSg1Yf4Jj/oUvV5owibncnPIkBQvuJ7ltr7EecvLfuaAVcxoDrYgaewIZwrQG9zxgYvwN4XQCQmG+TF9qnz6bF1yTpRFpxWlJ2GOp2oC3bSREGk/BFCvZIZNFHrCxYdOjv/6G7227Yv00sMIvwBbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrnQhCXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24462C116D0;
	Wed, 18 Feb 2026 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771425439;
	bh=WVrTOELnfJzl9+EaWv4I60Yg619nZ93eNj6+a+T9StA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rrnQhCXwI5XK9dARklcKjMRgQ1zNQ4TrTcCBv3XeIIoo0OtQfZEzdQas1WHQOGdLe
	 ko05y73toYV67FwhZdZ4LfF5SpPjHWaxMFj2Viwchk4zy8e1xAvCbVapq84vfPRIax
	 OdUU5U27UuMyRrScczgYqJ83ph+JiXFegVvNybZe2TnAUyqlue8mvHVm5iC6PVJ0TL
	 xcDRzvIhsu6Wtz4WWifFgSNTfH8RV6OqOzuUQfEOQyoFrIeUNkddbx1HsnueX/UyLU
	 XOTU3ccJbFdHDt+OllrOoN0fPGxj9wwScD/rJd1Z4FG//G4fIex9AT0MIOG4UGx5od
	 rDHAGVFmYOEgA==
Message-ID: <f86345b7aa2b69e15c67ca0d8344533d8f099931.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Alexander Mikhalitsyn
	 <alexander@mihalicyn.com>, lsf-pc@lists.linux-foundation.org
Cc: aleksandr.mikhalitsyn@futurfusion.io, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stgraber@stgraber.org, brauner@kernel.org, 
	ksugihara@preferred.jp, utam0k@preferred.jp, anna@kernel.org, 
	chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz, 
	amir73il@gmail.com, trapexit@spawn.link
Date: Wed, 18 Feb 2026 09:37:17 -0500
In-Reply-To: <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
	 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77580-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxcontainers.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54B95157187
X-Rspamd-Action: no action

On Wed, 2026-02-18 at 08:49 -0500, Jeff Layton wrote:
> On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > Dear friends,
> >=20
> > I would like to propose "VFS idmappings support in NFS" as a topic
> > for discussion at the LSF/MM/BPF Summit.
> >=20
> > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and
> > cephfs [1] with support/guidance
> > from Christian.
> >=20
> > This experience with Cephfs & FUSE has shown that VFS idmap
> > semantics, while being very elegant and
> > intuitive for local filesystems, can be quite challenging to
> > combine with network/network-like (e.g. FUSE)
> > FSes. In case of Cephfs we had to modify its protocol (!) (see [2])
> > as a part of our agreement with
> > ceph folks about the right way to support idmaps.
> >=20
> > One obstacle here was that cephfs has some features that are not
> > very Linux-wayish, I would say.
> > In particular, system administrator can configure path-based
> > UID/GID restrictions on a *server*-side (Ceph MDS).
> > Basically, you can say "I expect UID 1000 and GID 2000 for all
> > files under /stuff directory".
> > The problem here is that these UID/GIDs are taken from a syscall-
> > caller's creds (not from (struct file *)->f_cred)
> > which makes cephfs FDs not very transferable through unix sockets.
> > [3]
> >=20
> > These path-based UID/GID restrictions mean that server expects
> > client to send UID/GID with every single request,
> > not only for those OPs where UID/GID needs to be written to the
> > disk (mknod, mkdir, symlink, etc).
> > VFS idmaps API is designed to prevent filesystems developers from
> > making a mistakes when supporting FS_ALLOW_IDMAP.
> > For example, (struct mnt_idmap *) is not passed to every single
> > i_op, but instead to only those where it can be
> > used legitimately. Particularly, readlink/listxattr or rmdir are
> > not expected to use idmapping information anyhow.
> >=20
> > We've seen very similar challenges with FUSE. Not a long time ago
> > on Linux Containers project forum, there
> > was a discussion about mergerfs (a popular FUSE-based filesystem) &
> > VFS idmaps [5]. And I see that this problem
> > of "caller UID/GID are needed everywhere" still blocks VFS idmaps
> > adoption in some usecases.
> > Antonio Musumeci (mergerfs maintainer) claimed that in many cases
> > filesystems behind mergerfs may not be fully
> > POSIX and basically, when mergerfs does IO on the underlying FSes
> > it needs to do UID/GID switch to caller's UID/GID
> > (taken from FUSE request header).
> >=20
> > We don't expect NFS to be any simpler :-) I would say that
> > supporting NFS is a final boss. It would be great
> > to have a deep technical discussion with VFS/FSes maintainers and
> > developers about all these challenges and
> > make some conclusions and identify a right direction/approach to
> > these problems. From my side, I'm going
> > to get more familiar with high-level part of NFS (or even make PoC
> > if time permits), identify challenges,
> > summarize everything and prepare some slides to navigate/plan
> > discussion.
> >=20
> > [1] cephfs
> > https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-aleksandr=
.mikhalitsyn@canonical.com
> > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > [3] cephfs & f_cred
> > https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxk=
Y0eX+dOjw@mail.gmail.com/
> > [4] fuse/virtiofs
> > https://lore.kernel.org/linux-fsdevel/20240903151626.264609-1-aleksandr=
.mikhalitsyn@canonical.com/
> > [5]
> > mergerfs
> > https://discuss.linuxcontainers.org/t/is-it-the-case-that-you-
> > cannot-use-shift-true-for-disk-devices-where-the-source-is-a-
> > mergerfs-mount-is-there-a-workaround/25336/11?u=3Damikhalitsyn
> >=20
> > Kind regards,
> > Alexander Mikhalitsyn @ futurfusion.io
>=20
>=20
> IIUC, people mostly use vfs-layer idmappings because they want to
> remap
> the uid/gid values of files that get stored on the backing store
> (disk,
> ceph MDS, or whatever).
>=20
> I've never used idmappings myself much in practice. Could you lay out
> an example of how you would use them with NFS in a real environment
> so
> I understand the problem better? I'd start by assuming a simple setup
> with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> be fairly straightforward.
>=20
> Mixing in AUTH_GSS and real idmapping will be where things get
> harder,
> so let's not worry about those cases for now.

I think you do need to worry about those cases. As the NFS and RPC
protocols stand today, strong authentication will defeat any client
side idmapping scheme, because the server can't know what uids or gids
the client is using on its end; it just knows about the account that
was used to authenticate.

I think if you do want to implement something generic, you're going to
have to consider how the client and server can exchange (and store) the
information needed to allow the client to perform the mapping of file
owners/group owners on its end. The client would presumably also need
to be in charge of enforcing permissions for such mappings.
It would be a very different security model than the one used by NFS
today, and almost certainly require protocol extensions.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

