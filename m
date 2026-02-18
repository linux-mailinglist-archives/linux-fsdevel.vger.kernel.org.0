Return-Path: <linux-fsdevel+bounces-77594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCI2GIzrlWkXWgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:40:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9A157CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D74B301C10F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A123431F8;
	Wed, 18 Feb 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="CXRYt2yP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E691322753
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432806; cv=pass; b=jsEx8OpxYJyQ4pHVDxVFoDAHkJ0TMu6+znPpiNXAX4yAYoBOzW97rsrHJt30zVwnrn5WtZgx+nY8cZZcT5YPTOnAZqZBLEEkSsmagX+e7mSlJkb5QFcWJfybY7R3NjXc4Dhf5Ts043aUJMNTZQlLQrfF7t1jCAeJwBHeJKZrNYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432806; c=relaxed/simple;
	bh=m1ktfIB0w8fcvz9qM7nb2FcqrkVz621CJag99CSqtuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpRJsR+vvgyBM4VPZzaYLfbYpg/1YZkHxYojURYx8jZSSHCLl8jO62h8CVgyHauHGqcjmo5/R6iXrmbfOdwqZuFyYWnopxcds+QTa1nPa4zY4hmO0ZPq8+06CB4lxeXoecROii6DuhD4lPKyKQcBi+yKQmBc5sNoCFQ6iOU844U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=CXRYt2yP; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso90973e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 08:40:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771432803; cv=none;
        d=google.com; s=arc-20240605;
        b=O6prglICW5+Bp6k/3c8TSASKDfK8+HSJ7Jo2Z3QhKr8F60mC6p5hQFqeUKe/KsfxgG
         8CgxgOHc6eBWG2wsKka5UVAp0Owh1YheYBu5i69fgc7yr80kExub6Rp3kmw1QAhXAf2r
         B/fr7KKdhIMC2zEUqFI2S2qgmEu18IbevRkFYwj2iEqb3PUc9bBlHZvJZf0CI6UYi+Oo
         +vCWTLCviyLpZZcnZ80+ZXAlpUQktFWegiaqIlyCu6/W9V1J/YhSZMPUT0a8U4deA5Vb
         zRBbxXbGnVRBe3ij5C69K/fgurX0ZxBpf9IcD13SUS69Md94Aq4zBUHeYrRap/dEammE
         M0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m1ktfIB0w8fcvz9qM7nb2FcqrkVz621CJag99CSqtuA=;
        fh=8nw+IegcoLabGXTSTa+Cl+jVT+M+AU9HufL/D7f/H1o=;
        b=QhGDTsKmTEpAVR7sazIPDANY4SBglHzKWR36E1TgDodLpsOW4qdRgXpLUWfdF4+RJg
         Vh8qMVrn3zwkYTEQ3PYoSY/2FU0tUdFE0nmJNE15Pir4P/aWX2sDRTd7vF8XJir/x3VY
         H8LcGNadsGxxkzhnEGSGIaP/tKCF1NkF43lpBdzvkaND7xLX9rcepu2MZqaF+a6B4HeR
         uUbS26sF3PhBDVCZXEOvQDtgNa0VGa+CfmMEQxPk2Vu8pVspm/dMK+JoEvdh2qpEZ/Vy
         uGMg12lq5gzv+v0VJ2lwM5EIVUJDZ+eq6OSM+qyx5XTr5HucNr/8OjBzVfQS2w/EUdTK
         G5qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1771432803; x=1772037603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m1ktfIB0w8fcvz9qM7nb2FcqrkVz621CJag99CSqtuA=;
        b=CXRYt2yPjwLI5qe6z5N/pjwLCoEiUwG2xe6qxjMDBjhgIHE0fe0DaskjrRX3hKjdml
         4kkbe824AZiUPQAbgvLMht56qNWa3M9Z+fAEbeiNLTgcKWXy2hmkd3f50vCP69dvoIGa
         qy+Qli+sUhDJc+ZHM9/VR4x2dSafOq1Zr7T70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771432803; x=1772037603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1ktfIB0w8fcvz9qM7nb2FcqrkVz621CJag99CSqtuA=;
        b=OVIqViyQdTOI9PQd3Zm8DTfu3IkY+1ORz063uUKMIR9w3q5rrriqF3BwMTwxznXD9Q
         l2+n3qNjvVgDw5qW0yhgVlvJ4IMObGTrp9j7gOMpayXQ8VV+tQNibynU9jE/UuJg7sMD
         Opjc3OfZED3lOg1p82ZLjVLNiyb3xB8YNI8jkvMLLV3LFflae1NiAMRdXn+odgc0PxmJ
         wVN8ZZpsNJqAeZJA9oUmO1HzcBWxOgyNh1hEQb/VGesF4zotpWEFyOQsmEeDlP6gc4rq
         I62jTx4T1llCZ1PPeWlXQxEGzt3GfhnnjazLZwd+l8HPjwnRJv3EBUIXPe+PvrKOBHiH
         uZNw==
X-Forwarded-Encrypted: i=1; AJvYcCVewLjqqvEcDjXEZXUwFUPE1z6QvYx0FVjzutLhb4X6ol98JnzOwI0Zy0Ati3lfVplpwXOXmFjZtMSsURYg@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOsvgTRsW8xZyxGrb5bdoZdRbXkDby+GvZ1k7Ai4M7TnllGX/
	Jw81W3HMvw2xP3T8bc9w7ZMLDQKwQqRu64TFDTHnLkhDY1ETXptpSWMsFO2eUUt9TmFEXANkeRt
	e75zQ+FIY6ObRy4Q5IIFQJBR+Kig7agACF7J8Fhw5gXcP8z8StLwbf/B8NA==
X-Gm-Gg: AZuq6aJaXA6QpjHZpW1rCmsRGbi6zoe+uaumaIr5sGu1lUq+rAIytfWlLwYAWa3J7LM
	mM2MnXJIpwH3Avd2sPS/BQbNrJrWDP4lmUK6Zqzd+jUHY2q6wr5P93D1wFTNctd8Ly7et6SAtJj
	gstXD3ONtNQdsQoGdVl5k4GzYMQ6TBGvQ0zqW1FUAbz72gdvDEEt9VkUAEMPSYmGfWkui4XY+Wa
	9RVk0Fd+lWH5pnX3fdrsa2Jzcn6cVQym4kBpm/WX+Z2PXuRTMnY9vpbhNHEZgDOw1q9n/loA5s5
	B2LuvV4WIaB4Md/6h8wVZBZppAnknkUJEBPv+EaEm3yFToABfA==
X-Received: by 2002:a05:6512:3992:b0:59e:174e:fce0 with SMTP id
 2adb3069b0e04-59f83bbc8aamr610250e87.42.1771432802362; Wed, 18 Feb 2026
 08:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
 <CAJqdLrqNzXRwMF2grTGCkaMKCEXAwemQLEi3wsL5Lp2W9D-ZVg@mail.gmail.com> <e0be58df89ffaf41763312dfffe8402fdcb9d023.camel@kernel.org>
In-Reply-To: <e0be58df89ffaf41763312dfffe8402fdcb9d023.camel@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Feb 2026 17:39:50 +0100
X-Gm-Features: AaiRm51yY6iEct1M5bj0p76xR9TnBDMKSGswofCxCOOfFq3o4D0xBdy9tozVhCc
Message-ID: <CAJqdLrri3ojGyus71Mzk1rsLaCKo5HZMqP=UNNvR0sn9Oyxk-g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stgraber@stgraber.org, brauner@kernel.org, ksugihara@preferred.jp, 
	utam0k@preferred.jp, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz, 
	amir73il@gmail.com, trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77594-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,preferred.jp:url]
X-Rspamd-Queue-Id: ECC9A157CFD
X-Rspamd-Action: no action

Am Mi., 18. Feb. 2026 um 17:01 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> On Wed, 2026-02-18 at 15:36 +0100, Alexander Mikhalitsyn wrote:
> > Am Mi., 18. Feb. 2026 um 14:49 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
> > >
> > > On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > > > Dear friends,
> > > >
> > > > I would like to propose "VFS idmappings support in NFS" as a topic for discussion at the LSF/MM/BPF Summit.
> > > >
> > > > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and cephfs [1] with support/guidance
> > > > from Christian.
> > > >
> > > > This experience with Cephfs & FUSE has shown that VFS idmap semantics, while being very elegant and
> > > > intuitive for local filesystems, can be quite challenging to combine with network/network-like (e.g. FUSE)
> > > > FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) as a part of our agreement with
> > > > ceph folks about the right way to support idmaps.
> > > >
> > > > One obstacle here was that cephfs has some features that are not very Linux-wayish, I would say.
> > > > In particular, system administrator can configure path-based UID/GID restrictions on a *server*-side (Ceph MDS).
> > > > Basically, you can say "I expect UID 1000 and GID 2000 for all files under /stuff directory".
> > > > The problem here is that these UID/GIDs are taken from a syscall-caller's creds (not from (struct file *)->f_cred)
> > > > which makes cephfs FDs not very transferable through unix sockets. [3]
> > > >
> > > > These path-based UID/GID restrictions mean that server expects client to send UID/GID with every single request,
> > > > not only for those OPs where UID/GID needs to be written to the disk (mknod, mkdir, symlink, etc).
> > > > VFS idmaps API is designed to prevent filesystems developers from making a mistakes when supporting FS_ALLOW_IDMAP.
> > > > For example, (struct mnt_idmap *) is not passed to every single i_op, but instead to only those where it can be
> > > > used legitimately. Particularly, readlink/listxattr or rmdir are not expected to use idmapping information anyhow.
> > > >
> > > > We've seen very similar challenges with FUSE. Not a long time ago on Linux Containers project forum, there
> > > > was a discussion about mergerfs (a popular FUSE-based filesystem) & VFS idmaps [5]. And I see that this problem
> > > > of "caller UID/GID are needed everywhere" still blocks VFS idmaps adoption in some usecases.
> > > > Antonio Musumeci (mergerfs maintainer) claimed that in many cases filesystems behind mergerfs may not be fully
> > > > POSIX and basically, when mergerfs does IO on the underlying FSes it needs to do UID/GID switch to caller's UID/GID
> > > > (taken from FUSE request header).
> > > >
> > > > We don't expect NFS to be any simpler :-) I would say that supporting NFS is a final boss. It would be great
> > > > to have a deep technical discussion with VFS/FSes maintainers and developers about all these challenges and
> > > > make some conclusions and identify a right direction/approach to these problems. From my side, I'm going
> > > > to get more familiar with high-level part of NFS (or even make PoC if time permits), identify challenges,
> > > > summarize everything and prepare some slides to navigate/plan discussion.
> > > >
> > > > [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com
> > > > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > > > [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > > > [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > > > [5]
> > > > mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mount-is-there-a-workaround/25336/11?u=amikhalitsyn
> > > >
> > > > Kind regards,
> > > > Alexander Mikhalitsyn @ futurfusion.io
> > >
> >
> > Hi Jeff,
> >
> > thanks for such a fast reply! ;)
> >
> > >
> > > IIUC, people mostly use vfs-layer idmappings because they want to remap
> > > the uid/gid values of files that get stored on the backing store (disk,
> > > ceph MDS, or whatever).
> >
> > yes, precisely.
> >
> > >
> > > I've never used idmappings myself much in practice. Could you lay out
> > > an example of how you would use them with NFS in a real environment so
> > > I understand the problem better? I'd start by assuming a simple setup
> > > with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> > > be fairly straightforward.
> >
> > For me, from the point of LXC/Incus project, idmapped mounts are used as
> > a way to "delegate" filesystems (or subtrees) to the containers:
> > 1. We, of course, assume that container enables user namespaces and
> > user can't mount a filesystem
> > inside because it has no FS_USERNS_MOUNT flag set (like in case of Cephfs, NFS,
> > CIFS and many others).
> > 2. At the same time host's system administrator wants to avoid
> > remapping between container's user ns and
> > sb->s_user_ns (which is init_user_ns for those filesystems). [
> > motivation here is that in many
> > cases you may want to have the same subtree to be shared with other
> > containers and even host users too and
> > you want UIDs to be "compatible", i.e UID 1000 in one container and
> > UID 1000 in another container should
> > land as UID 1000 on the filesystem's inode ]
> >
> > For this usecase, when we bind-mount filesystem to container, we apply
> > VFS idmap equal to container's
> > user namespace. This makes a behavior I described.
> >
>
> Ok: so you have a process running in a userns as UID 2000 and you want
> to use vfs layer idmapping so that when you create a file as that user
> that it ends up being owned by UID 1000. Is that basically correct?

In our case, we have a UID 1000 (inside user namespace), which mapped to
something like 10000 + 1000 (in the init_user_ns). And then we have
NFS mount (sb->s_user_ns = init_user_ns, ofc), so if user UID 1000
(inside the container)
creates a file, it will be 11000, right? But we do bind-mount of that
NFS mount+VFS idmap,
so that once file is created it has owner_uid = 1000. (This scenario
is covered by [1] and [2])

[1] https://docs.kernel.org/filesystems/idmappings.html#example-3
[2] https://docs.kernel.org/filesystems/idmappings.html#example-3-reconsidered

>
> Typically, the RPC credentials used in an OPEN or CREATE call is what
> determines its ownership (at least until a SETATTR comes in). With
> AUTH_SYS, the credential is just a uid and set of gids.
>
> So in this case, it sounds like you would need just do that conversion
> (maybe at the RPC client layer?) when issuing an RPC. You don't really
> need a protocol extension for that case.
>
> As Trond points out though, AUTH_GSS and NFSv4 idmapping will make this
> more complex. Once you're using kerberos credentials for
> authentication, you don't have much control over what the UIDs and GIDs
> will be on newly-created files, but is that really a problem? As long
> as all of the clients have a consistent view, I wouldn't think so.

I absolutely agree.

>
> > But this is just one use case. I'm pretty sure there are some more
> > around here :)
> > I know that folks from Preferred Networks (preferred.jp) are also
> > interested in VFS idmap support in NFS,
> > probably they can share some ideas/use cases too.
> >
> >
>
> Yes, we don't want to focus too much on a single use-case, but I find
> it helpful to focus on a single simple problem first.

Yes, I could prepare RFC patches before LSF/MM/BPF for that simple case so
we have something to start with.

> --
> Jeff Layton <jlayton@kernel.org>

