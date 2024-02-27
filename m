Return-Path: <linux-fsdevel+bounces-13002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79686A028
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0662904A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1C51C47;
	Tue, 27 Feb 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7X2+NGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A5EEDD
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062011; cv=none; b=qilmdNUBPRDlHurpCkb77Q60lny8bJHJEfJ5qcsv75Svvib8ggmTzewqOQicR0lGOWtRjTZSJoRXjAIeiszgpCdt0xj3D4D2YhHV/1ZVnGYMg3pcwX0n8QK1ySxNnyN3awU3ndzpzKObxan0mKf65qcKpgDHNCh5UCNkbWF+YyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062011; c=relaxed/simple;
	bh=2sIIUWvrAA2FokwRivP4G5Hk/ZClBdrBalfpm1v2iHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMWk73LJXUM9TieFOYwh/vEzuotTdEP2Q/yFihgWqNmbMkZCItPGwm97rDcpaMPYKnKuRatvixYQerfKzeWrD5p0H8u7nZ9Bjo74Z99Wy6rOWuTFPSjZ6jCJCMdT7RwNii1CeGsh6TjpVmndTkKjZDKrMuORwvlMA4HrcLxyZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7X2+NGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B546C433C7;
	Tue, 27 Feb 2024 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709062010;
	bh=2sIIUWvrAA2FokwRivP4G5Hk/ZClBdrBalfpm1v2iHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7X2+NGMEz6U3VH4eZ7MAy94xI3cCPw8UvWPIfZzXQwBFSjlMTeIybRMzkPvPItVY
	 mT8yuCKdsVe9fFg+xH/gfvT48wBwn+eUXDbHhmRLEITVs9j/nx9AOMeoYZwZiXro4z
	 H2GI+ygIIIkOLQdAjzEQ21vKr/hJ5+8ikcEBLipjiR02wcNb/rGXCLKnEtTFN7diuj
	 Krc+yIGidaKzboPfNj13XdO4Mn+7XCqMsGOraNP/o0SDfM/kTeUEx6EiihKl5SQYaq
	 QYVf5qG5sll1Qm3IsFT6R4aDMTzMnWK5HXDkkueq3tey8NrHAOFmkO2YGoR7hlBRDm
	 SWf16fhyeicoA==
Date: Tue, 27 Feb 2024 12:26:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240227192648.GA2621994@dev-arch.thelio-3990X>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
 <20240224-westseite-haftzeit-721640a8700b@brauner>
 <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
 <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>

Hi Christian,

On Sat, Feb 24, 2024 at 08:15:53PM +0100, Christian Brauner wrote:
> On Sat, Feb 24, 2024 at 10:48:11AM -0800, Linus Torvalds wrote:
> > On Fri, 23 Feb 2024 at 21:52, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > This is selinux. So I think this is a misunderstanding. This isn't
> > > something we can fix in the kernel.
> > 
> > Sure it is. SELinux just goes by what the kernel tells it anyway.
> > 
> > Presumably this is purely about the fact that the inode in question
> > *used* to be that magical 'anon_inode_inode' that is shared when you
> > don't want or need a separate inode allocation. I assume it doesn't
> > even look at that, it just looks at the 'anon_inode_fs_type' thing (or
> > maybe at the anon_inode_mnt->mnt_sb that is created by kern_mount in
> > anon_inode_init?)
> > 
> > IOW, isn't the *only* difference that selinux can actually see just
> > the inode allocation? It used to be that
> > 
> >        inode = anon_inode_getfile();
> > 
> > now it is
> > 
> >         inode = new_inode_pseudo(pidfdfs_sb);
> > 
> > and instead of sharing one single inode (like anon_inode_getfile()
> > does unless you ask for separate inodes), it now shares the dentry
> > instead (for the same pid).
> > 
> > Would selinux be happy if the inode allocation just used the
> > anon_inode superblock instead of pidfdfs_sb?
> 
> No, unfortunately not. The core issue is that anon_inode_getfile() isn't
> subject to any LSM hooks which is what pidfds used. But dentry_open() is
> via security_file_open(). LSMs wanted to have a say in pidfd mediation
> which is now possible. So the switch to dentry_open() is what is causing
> the issue.
> 
> But here's a straightforward fix appended. We let pidfs.c use that fix
> as and then we introduce a new LSM hook for pidfds that allows mediation
> of pidfds and selinux can implement it when they're ready. This is
> regression free and future proof. I actually tested this already today.
> 
> How does that sounds?

I see a patch similar to this change in your vfs.pidfs branch as
commit 47a1fbce74c3 ("pidfs: convert to path_from_stashed() helper"),
which also appears to be in next-20240227. However, I still seem to be
having similar issues (although I cannot reproduce them every single
boot like I used to). I do see some SELinux denials for pidfs, although
it seems like it is only write that is being denied, rather than open,
read, and write?

  # uname -r
  6.8.0-rc6-next-20240227

  # systemctl --failed --no-legend --plain
  fwupd-refresh.service loaded failed failed Refresh fwupd metadata and update motd
  mcelog.service        loaded failed failed Machine Check Exception Logging Daemon
  polkit.service        loaded failed failed Authorization Manager

  # journalctl -b 0 -g denied -t audit | head -3
  Feb 27 10:49:20 qemu audit[1]: AVC avc:  denied  { write } for  pid=1 comm="systemd" path="pidfd:[1547]" dev="pidfs" ino=1547 scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
  Feb 27 10:49:21 qemu audit[1]: AVC avc:  denied  { write } for  pid=1 comm="systemd" path="pidfd:[1564]" dev="pidfs" ino=1564 scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
  Feb 27 10:50:50 qemu audit[1]: AVC avc:  denied  { write } for  pid=1 comm="systemd" path="pidfd:[1547]" dev="pidfs" ino=1547 scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0

Cheers,
Nathan

