Return-Path: <linux-fsdevel+bounces-77585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HKNM/jZlWmmVQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:25:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B615760E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E5D3009537
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FD533D6E2;
	Wed, 18 Feb 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UByg3JOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4642DC76C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428341; cv=pass; b=kRUSVazE2SKQZPVNLwXeAe60x+0u1aBglW0NKp6fjjaKvhUMb3SzW7XDpjH4UJOcItfzf5KOPEq6Ond+ejfVf0uCt2dMYYz3zNTWNZxJBPMn0PH73x8gXystb8FZ2de054ozlahpjTu5pJ/dsPv4OKXD/ulFNw3GReWAA8GySVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428341; c=relaxed/simple;
	bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDlTw58/oH5dO5BlhhbQb0uarr5WnoWp+pXslOcTLiqo3KMiopT37PIFnhTxFuDe5RY96fHE4l8lxmuf0ja/VVnwwxDMNJAahdpzQ4LZuzoSQRGV56Ya7mK3hrytHpPS06DPVNOcyQvzRe6xk7n2izyG66vnlyOpA+spwLSn9gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UByg3JOn; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59de66fda55so5626528e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 07:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771428338; cv=none;
        d=google.com; s=arc-20240605;
        b=MP3ltz+MVz73ADvnRl5ltv+NuK/37nlGqNCvE6WuOHu5swVJWTVT0OjSB8uG1b7R/Z
         WNUfdzJveAEMkgMkcZsOlAhNtfg+rwygitQbRE7JjoiWweZxXL5gi+0dg9e6wdPld3vu
         4ke5HEXZREbWAHbCdQFTZF4TY/bR9PLwzkUf2BQYKudA+yA0OZIIK+wg6aK51qCwx6KR
         TDIjSktzDqqyelD5lFlcxoW+3ssc4eu3xeD0oftUW/zzi36TtH0DDnr/LGTuEjP7n7pO
         yQ0eaToaZN5kikqdVyokGs4059V0h/Qj3maoHL6r6qSE1IMLZe4M3deUqJxQ1RzRhQ6u
         1iTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
        fh=ws3SOt19otaijQeAiyzMVy5EbuRtycfOQ4r+c7MPMZI=;
        b=boY4k8R05HfqKU70CuYWgGQNYdfx+UHxEIstdcOolxreA2ZxyHimXiydPe3qFt4k+e
         OuFrwKh1j9D1Gi9N7DpnUqARkQbafKmLOAYQXG84kB/GMwMN5G5QlFX5o4qFGcfwUpvi
         njNTOS1FTk4tvFUVuKq4yvF810sgYHUnQkkykHLZPTjPdjl7NjrQN/6gY4hkeO2tWbIj
         rJWdLEgPE+qnfIoDFodALoD5ZO8UuPLTC2OEFmFpGQIXNabx0oMdD4zz2jSL0pCv91n3
         4S/wAXNagybCglZy8h7nfJe0KhfEToAjE26h+O10eG4xffXYqCRsdKOu7SaZZ3YSDjJd
         2e3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1771428338; x=1772033138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
        b=UByg3JOncN4vzeQMFO1j1yOIxh4yHc3qG3asJTnzKwvjjdmVa91MIVNNzLoO2O/CRl
         Y/vqx9UuAYKOKojQqGNkPLehVQ8T2Qy5H6KiM4Q9FbBTjMNBwjB7SM3lIYt7GvyP0Czt
         grdE+KhPRz6JkPn3W5vXfalLzRHCbhe6+H/wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771428338; x=1772033138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFPFn3SZBslOxwb8r5xSulp6vIdXorTPEwXeNy0683I=;
        b=KG5pKebyuW8H96YTewPL7T3WwgpBFnnI91FyXBrT+gvkLs8iM9gSQaxNe4h1VhtYle
         Al1hew1GbgC/mqIjd7Msy+kcTynHoiM+btMMnhEw5pOskFxlsJNxcz9XlBIoA4bPG1KX
         S/3/NXtpFEkUDVFKSxgJpp9GMOLOTI8krIzICmi608akSIVzeftSA+06Y+n9yaz6jXFe
         TJkeBbX5mZMnZKk7oDE4IsZTP+iTKxXi2WzEu/kvOd71G+iSIOOsZpNVqzUxN872SqHP
         TrozxEXUtqC1HvCPqtGYfCsS5/FHZCtrXhDTV88qqTwt/Sy1qVxn3jlrJLIOLFbFvIFM
         Zb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSoswLbhGig71uwJuSDBMiXNzlEwe3NZmZFPGnkYoFhR05NAkuJ8GCkdU3Re8+TDXR86Zjh4sRzHog93hM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqe5PfTiSI5ft3DXRKtkWQezTMgqbM6ytVfxRTVcuy0KgNGcm6
	lVKnGutP+jzRodxksVkYuiTZzDFSOxmbtzcyshSG43UBDwBpYBypWE/3LpKltDu9vvgzXl8mKp1
	NK/stH81Sz5KuZ22uySLt8mt29N85jDBKFM+K9YCrEQ==
X-Gm-Gg: AZuq6aK42L5WYT2r3DkIoydw+k5J93ipR6vZv/+tuPe2033IVeSPxewloLkw/OLaLlX
	6prpd9zs6bMyk2OTA3aBqc6h/GgIHz7qJvVtoqesrQ/LZO6Gq331zgnKCVo3DWXmYBylFiH64Fi
	aAuPOi7Y0hs4XcOyGqYOKTxAAbGZwT95I/oAEgh6/sSAXMnSmivi1mYGXkKyaAl7Ai2s3Rd8B22
	vJTSD6TrUK2xkyGS8NaROTalCbuNrODj+G1VoxYJN0VKJcdeLfcLK3KDFqNI/hu3TuVh6dL62pl
	n8DmWN/C7WOo4PkDwz+lpQ8f/l0pl3YUSgAM8V4=
X-Received: by 2002:a05:6512:1c4:b0:59f:6db4:cc7d with SMTP id
 2adb3069b0e04-59f6db4ce68mr2897498e87.2.1771428337805; Wed, 18 Feb 2026
 07:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>
 <f86345b7aa2b69e15c67ca0d8344533d8f099931.camel@kernel.org> <a0eab8f07873e38fa4c5d958de6b75761d690874.camel@kernel.org>
In-Reply-To: <a0eab8f07873e38fa4c5d958de6b75761d690874.camel@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Feb 2026 16:25:26 +0100
X-Gm-Features: AaiRm52zGbtwxlGHuQu9FxwAdg_LoDR_vQ4qlk2ibuzCpbAXqseYdsruSBSLfhw
Message-ID: <CAJqdLroQZPUmNS2Z2TuR5qcmzwOHw-Q9rxp5pqPz8PnrH3j-Tg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	aleksandr.mikhalitsyn@futurfusion.io, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stgraber@stgraber.org, brauner@kernel.org, 
	ksugihara@preferred.jp, utam0k@preferred.jp, anna@kernel.org, 
	chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz, 
	amir73il@gmail.com, trapexit@spawn.link
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77585-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,preferred.jp,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,futurfusion.io:url]
X-Rspamd-Queue-Id: 374B615760E
X-Rspamd-Action: no action

Am Mi., 18. Feb. 2026 um 16:08 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> On Wed, 2026-02-18 at 09:37 -0500, Trond Myklebust wrote:
> > On Wed, 2026-02-18 at 08:49 -0500, Jeff Layton wrote:
> > > On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > > > Dear friends,
> > > >
> > > > I would like to propose "VFS idmappings support in NFS" as a topic
> > > > for discussion at the LSF/MM/BPF Summit.
> > > >
> > > > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and
> > > > cephfs [1] with support/guidance
> > > > from Christian.
> > > >
> > > > This experience with Cephfs & FUSE has shown that VFS idmap
> > > > semantics, while being very elegant and
> > > > intuitive for local filesystems, can be quite challenging to
> > > > combine with network/network-like (e.g. FUSE)
> > > > FSes. In case of Cephfs we had to modify its protocol (!) (see [2])
> > > > as a part of our agreement with
> > > > ceph folks about the right way to support idmaps.
> > > >
> > > > One obstacle here was that cephfs has some features that are not
> > > > very Linux-wayish, I would say.
> > > > In particular, system administrator can configure path-based
> > > > UID/GID restrictions on a *server*-side (Ceph MDS).
> > > > Basically, you can say "I expect UID 1000 and GID 2000 for all
> > > > files under /stuff directory".
> > > > The problem here is that these UID/GIDs are taken from a syscall-
> > > > caller's creds (not from (struct file *)->f_cred)
> > > > which makes cephfs FDs not very transferable through unix sockets.
> > > > [3]
> > > >
> > > > These path-based UID/GID restrictions mean that server expects
> > > > client to send UID/GID with every single request,
> > > > not only for those OPs where UID/GID needs to be written to the
> > > > disk (mknod, mkdir, symlink, etc).
> > > > VFS idmaps API is designed to prevent filesystems developers from
> > > > making a mistakes when supporting FS_ALLOW_IDMAP.
> > > > For example, (struct mnt_idmap *) is not passed to every single
> > > > i_op, but instead to only those where it can be
> > > > used legitimately. Particularly, readlink/listxattr or rmdir are
> > > > not expected to use idmapping information anyhow.
> > > >
> > > > We've seen very similar challenges with FUSE. Not a long time ago
> > > > on Linux Containers project forum, there
> > > > was a discussion about mergerfs (a popular FUSE-based filesystem) &
> > > > VFS idmaps [5]. And I see that this problem
> > > > of "caller UID/GID are needed everywhere" still blocks VFS idmaps
> > > > adoption in some usecases.
> > > > Antonio Musumeci (mergerfs maintainer) claimed that in many cases
> > > > filesystems behind mergerfs may not be fully
> > > > POSIX and basically, when mergerfs does IO on the underlying FSes
> > > > it needs to do UID/GID switch to caller's UID/GID
> > > > (taken from FUSE request header).
> > > >
> > > > We don't expect NFS to be any simpler :-) I would say that
> > > > supporting NFS is a final boss. It would be great
> > > > to have a deep technical discussion with VFS/FSes maintainers and
> > > > developers about all these challenges and
> > > > make some conclusions and identify a right direction/approach to
> > > > these problems. From my side, I'm going
> > > > to get more familiar with high-level part of NFS (or even make PoC
> > > > if time permits), identify challenges,
> > > > summarize everything and prepare some slides to navigate/plan
> > > > discussion.
> > > >
> > > > [1] cephfs
> > > > https://lore.kernel.org/linux-fsdevel/20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com
> > > > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > > > [3] cephfs & f_cred
> > > > https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > > > [4] fuse/virtiofs
> > > > https://lore.kernel.org/linux-fsdevel/20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > > > [5]
> > > > mergerfs
> > > > https://discuss.linuxcontainers.org/t/is-it-the-case-that-you-
> > > > cannot-use-shift-true-for-disk-devices-where-the-source-is-a-
> > > > mergerfs-mount-is-there-a-workaround/25336/11?u=amikhalitsyn
> > > >
> > > > Kind regards,
> > > > Alexander Mikhalitsyn @ futurfusion.io
> > >
> > >
> > > IIUC, people mostly use vfs-layer idmappings because they want to
> > > remap
> > > the uid/gid values of files that get stored on the backing store
> > > (disk,
> > > ceph MDS, or whatever).
> > >
> > > I've never used idmappings myself much in practice. Could you lay out
> > > an example of how you would use them with NFS in a real environment
> > > so
> > > I understand the problem better? I'd start by assuming a simple setup
> > > with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> > > be fairly straightforward.
> > >
> > > Mixing in AUTH_GSS and real idmapping will be where things get
> > > harder,
> > > so let's not worry about those cases for now.
> >
> > I think you do need to worry about those cases. As the NFS and RPC
> > protocols stand today, strong authentication will defeat any client
> > side idmapping scheme, because the server can't know what uids or gids
> > the client is using on its end; it just knows about the account that
> > was used to authenticate.
> >
>
> Oh, we absolutely need to worry about them, but this is a difficult
> topic to get our arms around. We can potentially have several layers
> that are doing idmapping, so I want to understand a simple use-case
> first. Once that's clear I plan to start throwing in monkey wrenches.
>
> > I think if you do want to implement something generic, you're going to
> > have to consider how the client and server can exchange (and store) the
> > information needed to allow the client to perform the mapping of file
> > owners/group owners on its end. The client would presumably also need
> > to be in charge of enforcing permissions for such mappings.
> > It would be a very different security model than the one used by NFS
> > today, and almost certainly require protocol extensions.
>
> That may be, but I still don't fully understand the use-case here.

Please, let me know if my earlier reply doesn't clarify LXC/Incus use case.
I can prepare a more detailed explanation with command line/configuration
examples with pleasure.

> Maybe they'd be content with just shifting UIDs at a higher level
> without changing the protocol? Without understanding how they intend to
> use this, it's hard to know what's needed.

If you ask me, I have no problem or I would say more, I look positively
on the way "keep it high level & don't touch NFS protocol" ;-)
But I remember a very tight discussion (good context [1]) about Cephfs and
this way wasn't considered as acceptable back then (and we had to make
a protocol extension).
We can always go iteratively, and first version can be simple and then on-demand
we can support more tricky cases if this is acceptable for you guys.
You set the rules. ;-)

[1] https://lore.kernel.org/lkml/f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com/

Kind regards,
Alex

>
> --
> Jeff Layton <jlayton@kernel.org>

