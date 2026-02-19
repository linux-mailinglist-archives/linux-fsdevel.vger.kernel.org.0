Return-Path: <linux-fsdevel+bounces-77690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAMqH3rHlmkGmwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:19:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C960D15D022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E39F3031E9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455133507D;
	Thu, 19 Feb 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quhL+pIY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960022222B2;
	Thu, 19 Feb 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488574; cv=none; b=CAxzBP0tz+pGvN2w6GgN0HjsV4bYIvc65hrIVd71jN57xcS/tBCTb0OBIoWXUDSMuP6drSxTh0TOoH4YUJCExAFVuksq46zagKUf1udmvNj0GfpslklTVclji0n2Fn4ejzXbE0O66EwqYHq7rlnJW/xkpi82lFBDOLRhbhUPk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488574; c=relaxed/simple;
	bh=yhMVar4nIHmgs69JaNMjCmYfk4vX3AzkEmoK1e7RXS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTy+YH1MrDDeS+XQqPyX1JcY1hPYhjNfh19miPUVh2QOAuQRJjyY5cH0gXIEdUmY4o/LpazFStgr1y9XFxtCirXE3tUSbxCNOE5xuXkvlFmQ/oA1fw03EQx0hyV8kWSE8ZPvaGo+o50S03H9WKQ6SIus11unTTXPWVKjLhvP+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quhL+pIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DAAC4CEF7;
	Thu, 19 Feb 2026 08:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771488574;
	bh=yhMVar4nIHmgs69JaNMjCmYfk4vX3AzkEmoK1e7RXS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quhL+pIYCUh71eAYtIMpqgZ6kQMAglJuy7bKKYNGr3EcY0bwqbVJm57D0wIZ3lcPc
	 lF3LRRnT1nuNcu7snE+R4beR78PmcKGsXc+wpW3VPFy4D33E/QfutLPw2qEorYo9xm
	 xVnUG21xHdrvdHwGe6TSg1VpQrRHbkQScDLNBlAOAYF1KnA1I+yskDF4DL9NA4dH/l
	 w6X+8Lw1yYwumB/GRuzv4Zf0h0jvZXqa/6n0LweHYl/Yyroyh38RdKxs+pEjlMf8Ks
	 6720Yc20il+QIZljVjdUhhSDPbVUBsPgRZZ1e+pTfyHZ9okakTWdCkKPg0vE30UPcA
	 +8+dID4384Gbg==
Date: Thu, 19 Feb 2026 09:09:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: syzbot <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
Message-ID: <20260219-kitzeln-vielmehr-22b6ce51bf5a@brauner>
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com>
 <>
 <20260217-fanshop-akteur-af571819f78b@brauner>
 <177131956603.8396.12634282713089317@noble.neil.brown.name>
 <177136673378.8396.7219915415554001211@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177136673378.8396.7219915415554001211@noble.neil.brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77690-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,0ea5108a1f5fb4fcc2d8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C960D15D022
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:18:53AM +1100, NeilBrown wrote:
> On Tue, 17 Feb 2026, NeilBrown wrote:
> > On Tue, 17 Feb 2026, Christian Brauner wrote:
> > > On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://git.k..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15331c02580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0ea5108a1f5fb4fcc2d8
> > > > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146b295a580000
> > > > 
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71e9c/vmlinux-0f2acd31.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/b18643058ceb/bzImage-0f2acd31.xz
> > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/bbfed09077d3/mount_1.gz
> > > >   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=106b295a580000)
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
> > > 
> > > Neil, is this something you have time to look into?
> > 
> > The reproducer appears to mount a gfs2 filesystem and mkdir 3
> > directories:
> >   ./file1
> >   ./file1/file4
> >   ./file1/file4/file7
> > 
> > and somewhere in there it crashes because vfs_mkdir() returns a
> > non-error dentry for which ->d_parent->d_inode is not locked and
> > end_creating_path() tries to up_write().
> > 
> > Presumably either ->d_parent has changed or the inode was unlocked?
> > 
> > gfs2_mkdir() never returns a dentry, so it must be returning NULL.
> > 
> > It's weird - but that is no surprise.
> > 
> > I'll try building a kernel myself and see if the reproducer still fires.
> > if so some printk tracing my reveal something.
> 
> Unfortunately that didn't work out.
> Using the provided vmlinux and root image and repro, and a syzkaller I
> compiled from current git, I cannot trigger the crash.
> 
> I'll have another look at the code but I don't hold out a lot of hope.

There's at least a proper C repro now.

