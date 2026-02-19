Return-Path: <linux-fsdevel+bounces-77694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFX+JZvPlmkZoQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:53:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2B15D20D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBB530263FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A0335098;
	Thu, 19 Feb 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=preferred.jp header.i=@preferred.jp header.b="Y4c/XF2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CE334373
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491222; cv=pass; b=u0wse5JcuNcx3EMO8cJ7HIArGEjk7Swtc92L45g3TQom66MWIVmsIN7n9si141D8AlgMxAgyUZXBVDo2i4NFYPRQ1xZ68pL/FXoG8OXbMB2enTvTvJ7U0LHTqmsXwzUV/nSoGz8Mo+MXwsQnYGwCHPODKa5k6skc3xjukEbb1W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491222; c=relaxed/simple;
	bh=2Z37UknHdfEmu6EzNUZ/Wm/7+gIp2RWZkRG5ASGOTjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7uQzyXB7MWN+edO2UcSept957RVaXgjSLY6iukH34u02UxF0oEHL0TV93vgYKu7WGX2zdjivTft8Bbd+MnRcmdlN7rj1k+h0nEpN4LumVPpzlaqZJxEIZDymh1Lw1I22XlA08SpJ61HN+jyHfaRpNeBxrvWgJKwI3yagWGbBCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=preferred.jp; spf=pass smtp.mailfrom=preferred.jp; dkim=pass (2048-bit key) header.d=preferred.jp header.i=@preferred.jp header.b=Y4c/XF2o; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=preferred.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=preferred.jp
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506b6663a36so1186461cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 00:53:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771491219; cv=none;
        d=google.com; s=arc-20240605;
        b=k+s3IripJJNADvEWc32eE5P4IIbQz/RITcmdjLRcWrmhBTCtKRqHNc55DmdBXg2hnU
         d550+C77stkq4VKdcsmkDdu47ba/gAXG5URN8zcuKP6PuM5wnHLL1hFf9HvCFbS54oK4
         uenUQz2YolEyDEoG9aEr60h1CbQ+L5Pjjx2e7l0kL+MkZ3NhBWn1RpNoJeWrywZPovrI
         q3oEM635DR/F1z0Of/HiPg00gH+0/VOyS1CbBHJjtMw22PNCJW+oqxO71HhLQY7etrfg
         zlT+Yl7GpYx3nzpEQAn5m6ZfcsjcWqrlMoJdla/oR1YbkCRfjU2boyXXbLB35q4s8vGf
         HVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6MXi+iRm0MTdGT6Ba+AzL8QY3gsZXbVDEv55SpTrIY=;
        fh=/D0kMBfzyfH9w5mvVBdEoEPbwjqMrEK+ap8UhG5cUlo=;
        b=di2lu56o1MncDNNLO44A5kL0XZAZqZehR/itcrUUWUHMoO0OPCF3Oc5L3oe3HyLQfB
         Nr4AtFd2N5j6LA2zA/+GsGrA3GVMsJ7ZZIagyo4NDpYhsBPIMlPxV+g9fkPP+HFK2j+h
         n+0ZlXhiUwGzBNLhM7GGTt6GJhRdu8ctX0meGC1DcYxApf3YbDIJ3B6WDWxoKA0fXtGO
         CiG/6Qw5bZ1Z3E6slLkwtPUWq4hvivj17RIoi7/PaMk7biFNNX3h2KaJHvTR29ya3p3s
         zIZHyPvQucDjqceTQG6/HWPGwf17aUmCtnBj8PrHOxkl5GKrOFgmtr10ui7xTlVgZiD5
         8c6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=preferred.jp; s=google; t=1771491219; x=1772096019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6MXi+iRm0MTdGT6Ba+AzL8QY3gsZXbVDEv55SpTrIY=;
        b=Y4c/XF2o7mSxxZrjkFKdy4HvIjEEzZKQHjlSQasJ5k0uQdwf3guY0QXQa3VRyRmIgw
         C3Q5k3XcIiL0nAssZWU8M8lV0MM/h4HjdZHwF4B/ENxhNoOEeOisKJPleE8MHfsjb6CE
         K6LzCbD41l/1vtInsDkh2csD9Irtn1qBNdPt57K0K1AmJ5aUoOELyCo6xTJS8RRpWqcr
         cjsYeuHAkXpcD4fh91iV+yi/vFINfQcqxMA8BSIWNnShwJMxS/CBMnA1EvwNrwpuPYyv
         S3htHhUSNZ6nDmhyObt83f7RmwPl9wgqlo0Ht2ungPbeZLZiBn0QAHqUPI4kPVxAukqH
         9xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771491219; x=1772096019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6MXi+iRm0MTdGT6Ba+AzL8QY3gsZXbVDEv55SpTrIY=;
        b=HEJnj1Z3wx/+DZohRjIqWuN5tdApC0nYUeXw64MP5p/On+02RJOzaS0sIxizPWqDY3
         gr1K64v9b26Ve0kzqwBo1SsM6KgZhsOGaOtbV+Gx/n7hI1a6Phg2XpvyGUVAbvlllpnT
         0+WvsIZyEPuavEhuTNqrvljj90YbZ7Tufa3InXupZj1A/H3ZsouOoPR8vJFOfobYgZIE
         ZFMs388ARuKESw9FlZoxRRLy97mq6JIsnNGS2zatM3j+sdZYSkAZ5oW4VdxZ2RWolFif
         RPgJIJYU3Fe5tiPIy58uYCLyZ/nw5IITcs8vac7Y/mlptOPGU3KfIvuwet89Mye+Pr5s
         7eNA==
X-Forwarded-Encrypted: i=1; AJvYcCUlIsEprDbiH+b9qDdHZxnZ87btUxgK6cyZDXz7iE2mvYOpeLrVY6eI7Sm6MfNiKL5nAFboGWAJdcEkLQNA@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyGuu/SEeRbacCpyeUy0eGql41VNiSAxDccKWXqhcVzhad/uK
	Gg+lAvWQ6Zg831Pii6BfCqMQ0LR9ra0IaWQQTPiJuZ8YcaKpvvX217ZGYhSQTfLIQTFWCIIhInP
	lP4RDh96qaS8/RAuq0LFKPx4Bh0OOMnoCz84EKMzRlw==
X-Gm-Gg: AZuq6aKOr7W9Xtpro9AEmL9axU6uXVf0opeuGvFtcUjVk6V8jKywew4feR8qoUMlEyU
	rj81APlEoI9NmAJ/M2NIFPMO8aYg79k4Ut2zTRa1KK+Kttf0KGuXrUJp03f/oAeh1zfh2QM8Fwp
	RSfh/5Sy6WunLxN3YIw0DOTVXWgwOgcH9BcM8fsIV+aMafkxxGJMKXjs93Scqukf65K/ld10jcO
	cu/PlqtlDLMZjfRuNo/xt6skS9iD/GFjOB1N7QZubqvaonOmEt/6xGt8p6J/ZvvJPQQaSwwiMgu
	d71uDFw3/vlMsf0V6QdDMoyj8bU39CtECuAX7tfE
X-Received: by 2002:ac8:7f82:0:b0:4f4:b372:db38 with SMTP id
 d75a77b69052e-506a6a7e4c3mr216494071cf.5.1771491219468; Thu, 19 Feb 2026
 00:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
 <CAJqdLrqNzXRwMF2grTGCkaMKCEXAwemQLEi3wsL5Lp2W9D-ZVg@mail.gmail.com>
 <e0be58df89ffaf41763312dfffe8402fdcb9d023.camel@kernel.org> <177146267901.8396.9601896246772305364@noble.neil.brown.name>
In-Reply-To: <177146267901.8396.9601896246772305364@noble.neil.brown.name>
From: Kohei Sugihara <ksugihara@preferred.jp>
Date: Thu, 19 Feb 2026 17:53:00 +0900
X-Gm-Features: AaiRm50jPBxWPod9hsVLk0IwJJa7_hpa82MowfxDEHYTeiCBKTPRCCr-PKlSPAY
Message-ID: <CAGY9O4mFJz1fbVUUsdhvFTBcgAGcYYrQBLQxkdOWoQe7LvDYWQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stgraber@stgraber.org, brauner@kernel.org, utam0k@preferred.jp, 
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, 
	miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com, trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[preferred.jp:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[preferred.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77694-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mihalicyn.com,lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,preferred.jp,oracle.com,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ksugihara@preferred.jp,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[preferred.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ownmail.net:email,lpc.events:url,preferred.jp:url,preferred.jp:dkim]
X-Rspamd-Queue-Id: E5A2B15D20D
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 9:58=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Thu, 19 Feb 2026, Jeff Layton wrote:
> > On Wed, 2026-02-18 at 15:36 +0100, Alexander Mikhalitsyn wrote:
> > > Am Mi., 18. Feb. 2026 um 14:49 Uhr schrieb Jeff Layton <jlayton@kerne=
l.org>:
> > > >
> > > > On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > > > > Dear friends,
> > > > >
> > > > > I would like to propose "VFS idmappings support in NFS" as a topi=
c for discussion at the LSF/MM/BPF Summit.
> > > > >
> > > > > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] a=
nd cephfs [1] with support/guidance
> > > > > from Christian.
> > > > >
> > > > > This experience with Cephfs & FUSE has shown that VFS idmap seman=
tics, while being very elegant and
> > > > > intuitive for local filesystems, can be quite challenging to comb=
ine with network/network-like (e.g. FUSE)
> > > > > FSes. In case of Cephfs we had to modify its protocol (!) (see [2=
]) as a part of our agreement with
> > > > > ceph folks about the right way to support idmaps.
> > > > >
> > > > > One obstacle here was that cephfs has some features that are not =
very Linux-wayish, I would say.
> > > > > In particular, system administrator can configure path-based UID/=
GID restrictions on a *server*-side (Ceph MDS).
> > > > > Basically, you can say "I expect UID 1000 and GID 2000 for all fi=
les under /stuff directory".
> > > > > The problem here is that these UID/GIDs are taken from a syscall-=
caller's creds (not from (struct file *)->f_cred)
> > > > > which makes cephfs FDs not very transferable through unix sockets=
. [3]
> > > > >
> > > > > These path-based UID/GID restrictions mean that server expects cl=
ient to send UID/GID with every single request,
> > > > > not only for those OPs where UID/GID needs to be written to the d=
isk (mknod, mkdir, symlink, etc).
> > > > > VFS idmaps API is designed to prevent filesystems developers from=
 making a mistakes when supporting FS_ALLOW_IDMAP.
> > > > > For example, (struct mnt_idmap *) is not passed to every single i=
_op, but instead to only those where it can be
> > > > > used legitimately. Particularly, readlink/listxattr or rmdir are =
not expected to use idmapping information anyhow.
> > > > >
> > > > > We've seen very similar challenges with FUSE. Not a long time ago=
 on Linux Containers project forum, there
> > > > > was a discussion about mergerfs (a popular FUSE-based filesystem)=
 & VFS idmaps [5]. And I see that this problem
> > > > > of "caller UID/GID are needed everywhere" still blocks VFS idmaps=
 adoption in some usecases.
> > > > > Antonio Musumeci (mergerfs maintainer) claimed that in many cases=
 filesystems behind mergerfs may not be fully
> > > > > POSIX and basically, when mergerfs does IO on the underlying FSes=
 it needs to do UID/GID switch to caller's UID/GID
> > > > > (taken from FUSE request header).
> > > > >
> > > > > We don't expect NFS to be any simpler :-) I would say that suppor=
ting NFS is a final boss. It would be great
> > > > > to have a deep technical discussion with VFS/FSes maintainers and=
 developers about all these challenges and
> > > > > make some conclusions and identify a right direction/approach to =
these problems. From my side, I'm going
> > > > > to get more familiar with high-level part of NFS (or even make Po=
C if time permits), identify challenges,
> > > > > summarize everything and prepare some slides to navigate/plan dis=
cussion.
> > > > >
> > > > > [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.1=
82101-1-aleksandr.mikhalitsyn@canonical.com
> > > > > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/525=
75
> > > > > [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMn=
jk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > > > > [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/202409031=
51626.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > > > > [5]
> > > > > mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that=
-you-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-=
mount-is-there-a-workaround/25336/11?u=3Damikhalitsyn
> > > > >
> > > > > Kind regards,
> > > > > Alexander Mikhalitsyn @ futurfusion.io
> > > >
> > >
> > > Hi Jeff,
> > >
> > > thanks for such a fast reply! ;)
> > >
> > > >
> > > > IIUC, people mostly use vfs-layer idmappings because they want to r=
emap
> > > > the uid/gid values of files that get stored on the backing store (d=
isk,
> > > > ceph MDS, or whatever).
> > >
> > > yes, precisely.
> > >
> > > >
> > > > I've never used idmappings myself much in practice. Could you lay o=
ut
> > > > an example of how you would use them with NFS in a real environment=
 so
> > > > I understand the problem better? I'd start by assuming a simple set=
up
> > > > with AUTH_SYS and no NFSv4 idmapping involved, since that case shou=
ld
> > > > be fairly straightforward.
> > >
> > > For me, from the point of LXC/Incus project, idmapped mounts are used=
 as
> > > a way to "delegate" filesystems (or subtrees) to the containers:
> > > 1. We, of course, assume that container enables user namespaces and
> > > user can't mount a filesystem
> > > inside because it has no FS_USERNS_MOUNT flag set (like in case of Ce=
phfs, NFS,
> > > CIFS and many others).
> > > 2. At the same time host's system administrator wants to avoid
> > > remapping between container's user ns and
> > > sb->s_user_ns (which is init_user_ns for those filesystems). [
> > > motivation here is that in many
> > > cases you may want to have the same subtree to be shared with other
> > > containers and even host users too and
> > > you want UIDs to be "compatible", i.e UID 1000 in one container and
> > > UID 1000 in another container should
> > > land as UID 1000 on the filesystem's inode ]
> > >
> > > For this usecase, when we bind-mount filesystem to container, we appl=
y
> > > VFS idmap equal to container's
> > > user namespace. This makes a behavior I described.
> > >
> >
> > Ok: so you have a process running in a userns as UID 2000 and you want
> > to use vfs layer idmapping so that when you create a file as that user
> > that it ends up being owned by UID 1000. Is that basically correct?
> >
> > Typically, the RPC credentials used in an OPEN or CREATE call is what
> > determines its ownership (at least until a SETATTR comes in). With
> > AUTH_SYS, the credential is just a uid and set of gids.
> >
> > So in this case, it sounds like you would need just do that conversion
> > (maybe at the RPC client layer?) when issuing an RPC. You don't really
> > need a protocol extension for that case.
>
> You also need to consider the conversion when receiving an RPC.
>
> If you use krb5 and NFSv3 then you really want the mapping between krb5
> identity and uid to be the same on client and server, so then when an
> application creates a file and the stats it, it sees that it owns it.
>
> If I use a krb5 identity in an idmapped NFS filesystem I'll want the
> server to map the identity to the "underlying" uid (was would be stored
> in a local filesystem) and then when the client gets a GETATTR reply,
> the VFS maps back to the uid seen by the application.


Thank you Alex for the proposal and quick follow-ups. We're really
interested in this feature and we'd like to share our use case.

> > > But this is just one use case. I'm pretty sure there are some more
> > > around here :)
> > > I know that folks from Preferred Networks (preferred.jp) are also
> > > interested in VFS idmap support in NFS,
> > > probably they can share some ideas/use cases too.

Our use case is running multi-tenant Kubernetes clusters with
Kubernetes User Namespaces [1]. Basically we need to share a single
storage endpoint among multiple pods using ReadWriteMany (RWX) access
mode. Implementations that support both RWX and ID-mapped mount are
limited [2].

NFS is operationally common, so I am interested in supporting NFS for
ID-mapping, but NFS is complex due to its variety of mount options and
security features as Trond mentioned. We'd like to share our use case
and define the minimum goal. Our goal is here:

- 1: Mount the same NFS export as a persistent volume from multiple
Kubernetes Pods running on different compute nodes. Each tenant has
its own exports.
- 2: UID/GID in a container in the pod can be configurable to an
arbitrary value by runAsUser/runAsGroup (e.g. runAsUser/Group is set
to 1000).
- 3: We can access the export from the container as 1000:1000. At
minimum, ownership should be consistent from the container view (i.e.
stat shows 1000:1000 for files that the container creates). Today,
ID-mapped mount does not support NFS. The NFS client ends up using the
host-mapped uid/gid (e.g. container 1000 becomes host 11000), so the
container view becomes inconsistent across nodes.

There are (at least) two possible models here:
a) the NFS client sends 1000:1000 on the wire and the server stores
1000:1000 (so server-side ownership matches the container uid/gid), or
b) the server stores the host uid/gid (e.g. 11000:11000) and the
client/VFS maps it so that the container still sees 1000:1000.
My intuition is that (a) is simpler for a multi-node RWX setup, but it
may have security / policy implications depending on how the server
does authorization (especially with sec=3Dsys). I think it=E2=80=99s worth
discussing what the safe and reasonable minimum should be.

In this case, UID/GID in the host node is not deterministic for the
process in the container due to user_namespaces(7), so we need to do
ID-mapping to unify UID/GID between container and file system. Also,
we likely need to consider both request and reply paths (e.g. GETATTR)
to keep the view consistent.

> Mixing in AUTH_GSS and real idmapping will be where things get harder,
> so let's not worry about those cases for now.
I totally agree with Jeff. We can start a minimum PoC with AUTH_SYS.

> With NFSv4 and the idmapper you wouldn't need (or want) the kernel
> idmapping to be used at all.  You would want the idmapper deamon to run
> in the user-namespace and map from on-the-wire names to the appropriate
> app-level uids.
> This would mean that a given NFS mount would need to be an a given user
> namespace.  Maybe that isn't desired.
Neil, thank you for your comment. We initially expected it to be in
NFSv4. I totally agree with you and exactly our concern is how do we
make it consistent with idmapd(8). In the Kubernetes case, we cannot
pass CAP_SYS_ADMIN to allow pods to mount NFS directly, so mount will
be done on the host. As you mentioned, we think we can share a single
NFS export from multiple hosts and pods, so I think introducing
ID-mapping into the VFS layer (with referencing local id-mapping
table) is appropriate.

We can start by picking a small case. My concern was whether this
could violate NFS protocol or not, whether things can be done on the
client side or not, and this topic is suitable for dealing with this
as the VFS community. If things can be done on the client side, we can
cover existing NFS server implementations (e.g. OpenZFS, proprietary
appliances). I believe this can be applied to recent containerized
runtime environments, even this small working set.

Adding more context, Kubernetes and the container community actively
work on host isolation using the Linux user namespace feature.
Recently they experienced RCE vulnerabilities on container runtime but
it could be mitigated by host isolation using the user namespace
isolation [3]. Along with migrating the runtime environment to user
namespace, extending file system support will be worth discussing.

Kind regards,
Kohei

[1] https://kubernetes.io/docs/concepts/workloads/pods/user-namespaces/
[2] https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-=
modes
[3] https://lpc.events/event/19/contributions/2065/

