Return-Path: <linux-fsdevel+bounces-78228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBx0FQ1onWlgPQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:57:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76011841A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F35331343C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70736920D;
	Tue, 24 Feb 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsCVfk2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F7368276;
	Tue, 24 Feb 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923277; cv=none; b=Flaa4tnJ14oIpd8Ek+NdQuaRMglMb0lbetuO0jUfOP/K9woNxu9HdyxKj6yrs4XG0rQ5+sfMsS6p1Yd9OpUtxRDv32M2OYTSJPFGyuXVeKIRw3IOq2pYVIMqCeqp/ao8iZyxqjexHHPf7LM3Tn4rUO7IfMPymNZtJMCr2V2cMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923277; c=relaxed/simple;
	bh=+fH3lSsZu9D7GVuFPuK+C/cKUuKAdkgXib0DwMXQijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGKlc0ph3F5oW5CSNHeiEMZ9LITPXNqVt4REOq8N5ckl3BrgcgLwpj+Pdcclp8bi1vSH/b0HhxlfwJj6xmnuGvP1WzhdZjA13ZspejkjP3t5xJDRlBe70Yoo4x7Qe4mda4MduVTCc5Suue570iJUzMos7zqDdupQh9iC1CBhwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsCVfk2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C0CC116D0;
	Tue, 24 Feb 2026 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771923277;
	bh=+fH3lSsZu9D7GVuFPuK+C/cKUuKAdkgXib0DwMXQijc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsCVfk2sawWIhzsqQ+HrMfwZN4zos8A9H7n7qfPACHlMkNV4Hcwzd1cYKnflJb9yb
	 0O2Il81r2ZkblLeLjQDVfgzu2vomIUkIt5nDiY3GHLuaVS+nMncvRwRquAJifqnqik
	 3F7xHXKl6mh5FxoftBRjweFjC9PXabaMB8C7QWeZrvEb0beFuSmAgI70PMj77eq9nf
	 F0k7Ere+E3yYvMbmFVlGVVZID2IrdDSNZe4svOF/nGS3mdxQRlJsLBHa3Ckh3UHh5m
	 Jh8P1tag8oIZmxZtqhpcrlwafOcO5UMsiWgN5+R8fuX9eNA2H5SBuIOlhzLIS67tMn
	 X2stESgVE4syQ==
Date: Tue, 24 Feb 2026 09:54:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, stgraber@stgraber.org, 
	ksugihara@preferred.jp, utam0k@preferred.jp, trondmy@kernel.org, anna@kernel.org, 
	jlayton@kernel.org, chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, 
	jack@suse.cz, amir73il@gmail.com, trapexit@spawn.link
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
Message-ID: <20260224-bannen-waldlauf-481ad13899a9@brauner>
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <980c04e5-5685-43a2-a4fb-9d3a842205aa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <980c04e5-5685-43a2-a4fb-9d3a842205aa@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78228-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mihalicyn.com,lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,preferred.jp,kernel.org,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A76011841A6
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 01:44:26AM -0500, Demi Marie Obenour wrote:
> On 2/18/26 07:44, Alexander Mikhalitsyn wrote:
> > Dear friends,
> > 
> > I would like to propose "VFS idmappings support in NFS" as a topic for discussion at the LSF/MM/BPF Summit.
> > 
> > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and cephfs [1] with support/guidance
> > from Christian.
> > 
> > This experience with Cephfs & FUSE has shown that VFS idmap semantics, while being very elegant and
> > intuitive for local filesystems, can be quite challenging to combine with network/network-like (e.g. FUSE)
> > FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) as a part of our agreement with
> > ceph folks about the right way to support idmaps.
> > 
> > One obstacle here was that cephfs has some features that are not very Linux-wayish, I would say.
> > In particular, system administrator can configure path-based UID/GID restrictions on a *server*-side (Ceph MDS).
> > Basically, you can say "I expect UID 1000 and GID 2000 for all files under /stuff directory".
> > The problem here is that these UID/GIDs are taken from a syscall-caller's creds (not from (struct file *)->f_cred)
> > which makes cephfs FDs not very transferable through unix sockets. [3]
> > 
> > These path-based UID/GID restrictions mean that server expects client to send UID/GID with every single request,
> > not only for those OPs where UID/GID needs to be written to the disk (mknod, mkdir, symlink, etc).
> > VFS idmaps API is designed to prevent filesystems developers from making a mistakes when supporting FS_ALLOW_IDMAP.
> > For example, (struct mnt_idmap *) is not passed to every single i_op, but instead to only those where it can be
> > used legitimately. Particularly, readlink/listxattr or rmdir are not expected to use idmapping information anyhow.
> > 
> > We've seen very similar challenges with FUSE. Not a long time ago on Linux Containers project forum, there
> > was a discussion about mergerfs (a popular FUSE-based filesystem) & VFS idmaps [5]. And I see that this problem
> > of "caller UID/GID are needed everywhere" still blocks VFS idmaps adoption in some usecases.
> > Antonio Musumeci (mergerfs maintainer) claimed that in many cases filesystems behind mergerfs may not be fully
> > POSIX and basically, when mergerfs does IO on the underlying FSes it needs to do UID/GID switch to caller's UID/GID
> > (taken from FUSE request header).
> > 
> > We don't expect NFS to be any simpler :-) I would say that supporting NFS is a final boss. It would be great
> > to have a deep technical discussion with VFS/FSes maintainers and developers about all these challenges and
> > make some conclusions and identify a right direction/approach to these problems. From my side, I'm going
> > to get more familiar with high-level part of NFS (or even make PoC if time permits), identify challenges,
> > summarize everything and prepare some slides to navigate/plan discussion.
> > 
> > [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com
> > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > [5]
> > mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mount-is-there-a-workaround/25336/11?u=amikhalitsyn
> > 
> > Kind regards,
> > Alexander Mikhalitsyn @ futurfusion.io
> 
> The secure case (strong authentication) has similar problems to
> In both cases, there is no way to store the files with the UID/GID/etc

It's easy to support idmapped mounts without user namespaces. They're
completely decoupled from them already for that purpose so they can
support id squashing and so on going forward. The only thing that's
needed is to extend the api so that we can specific mappings to be used
for a mount. That's not difficult and there's no need to adhere to any
inherent limit on the number of mappings that user namespaces have.

It's also useful indepent of all that for local filesystems that want to
expose files with different ownership at different locations without
getting into namespaces at all.

> that the VFS says they should have.  The server (NFS) or kernel
> (virtiofsd) simply will not (and, for security reasons, *must not*)
> allow this.
> 
> I proposed a workaround for virtiofsd [1] that I will also propose
> here: store the mapped UID and GID as a user.* xattr.  This requires

xattrs as an ownership side-channel are an absolute clusterfuck. The
kernel implementation for POSIX ACLs and filesystem capabilities that
slap ownership information that the VFS must consume on arbitraries
inodes should be set on fire. I've burned way too many cycles getting
this into an even remotely acceptable shape and it still sucks to no
end. Permission checking is a completely nightmare because we need to go
fetch stuff from disk, cache it in a global format, then do an in-place
translation having to parse ownership out of binary data stored
alongside the inode.

Nowever, if userspace wants to consume ownership information by storing
arbitrary ownership information as user.* xattrs then I obviously
couldn't care less but it won't nest, performance will suck, and it will
be brittle to get this right imho.

> no special permissions, and so it completely solves this problem.
> It is also the only solution I know of that scales to NFS servers
> with over 2^16 users, which might well exist.
> 
> The only better solution I can think of is to replace the numeric
> UID/GID with hierarchical identifier, such as a Windows-style SID.
> Those are much more complex, though.
> 
> [1]: https://gitlab.com/virtio-fs/virtiofsd/-/issues/225
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)






