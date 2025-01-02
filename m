Return-Path: <linux-fsdevel+bounces-38339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7319FFDE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 19:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1097A160E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923781B6D0D;
	Thu,  2 Jan 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqgNnfD6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06A1922E1;
	Thu,  2 Jan 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841945; cv=none; b=G4/BhDPyUeo7oyuNNnIWDHsCxQlfxInZbrn1boBdnoqGwq0hhK0hGtSsD2pOmcL927rENVjWrkQEeiBpmQOwu6EpGKAay0QgEVg4TVATk4Tr5ikit4Y4JBEqoIbMfkib4rrrBP+GYE2Jth6ECd5BA2fbreX33IQuZpKh4h5KhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841945; c=relaxed/simple;
	bh=Fb/paBAcrHpzPIF4vJdz91IniJJtVJEMK4QGu/SeVH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqiNGU+LgfQ+ofW3y17jAOf/pynoCQ1X5dr9rO/NpH4NSmLueLJfd4siPkPi38QAFLosoFxQOyik5/4aID0TLLXk0f4oJ+bFIZAfmneFI1/kbwlwjJ1v7h6DrbWmn9FMLz/OIxp7MsYcdpyB3c4DZ/dnKAUgV6SfwfVCsPqtDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqgNnfD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB948C4CED0;
	Thu,  2 Jan 2025 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735841945;
	bh=Fb/paBAcrHpzPIF4vJdz91IniJJtVJEMK4QGu/SeVH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqgNnfD6bBzGBEyVEm0lA4R6pe1JoHfro3BVL/RG1/YypeHEWUsokYyKu8zNe/TX0
	 i1eov9n4zghsCAk+0CC33jEC3zkNiaBWb8aeL8GSQR5PdxALgup9S4X61DDkwsBXux
	 S/yg4hUv3BANfepioN40NRvYKy9EXO/9vTcGfHvQYWV3F990f9PcqEViwnDmrqdlw5
	 powSIotsXK9iI0T4T1pOHWHJgUlxRo1gZiqpizmwSD+PMKG5OahWyWdFPTEkQb2sfX
	 Fioj2y94n1U4FwFG0nt6wCzQPw76MPIShIXb+2MnlzcOXAbnlbRxXy9f2l9oHo6wD9
	 YGWCfyGURqsVA==
Received: by pali.im (Postfix)
	id 8720F812; Thu,  2 Jan 2025 19:18:54 +0100 (CET)
Date: Thu, 2 Jan 2025 19:18:54 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Errno codes from symlink() syscall
Message-ID: <20250102181854.jzmzdz3j4ekrpa7z@pali>
References: <20241224160535.pi6nazpugqkhvfns@pali>
 <20241227130139.dplqu5jlli57hhhm@pali>
 <u7omfwq7othzaol24tio5tmmhc5kmpjhrqoxrzwtkhus65koa6@4bccjy7zza4w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u7omfwq7othzaol24tio5tmmhc5kmpjhrqoxrzwtkhus65koa6@4bccjy7zza4w>
User-Agent: NeoMutt/20180716

On Thursday 02 January 2025 16:06:56 Jan Kara wrote:
> On Fri 27-12-24 14:01:39, Pali Rohár wrote:
> > On Tuesday 24 December 2024 17:05:35 Pali Rohár wrote:
> > > TL;DR;
> > > Which errno code should network fs driver returns on create symlink
> > > failure to userspace application for these cases?
> > > * creating new symlink is not supported by fs driver mount options
> > > * creating new symlink is not supported by remote server software
> > > * creating new symlink is not supported by remote server storage
> > > * creating new symlink is not permitted for user due to missing
> > >   privilege/capability (indicated by remote server)
> > > * access to the directory was denied due to ACL/mode (on remote)
> > > 
> > > 
> > > Hello,
> > > 
> > > I discussed with Steve that current error codes from symlink() syscall
> > > propagated to userspace on mounted SMB share are in most cases
> > > misleading for end user who is trying to create a new symlink via ln -s
> > > command.
> > > 
> > > Linux SMB client (cifs.ko) can see different kind of errors when it is
> > > trying to create a symlink on SMB server. I know at least about these
> > > errors which can happen:
> > > 
> > > 1 For the current mount parameters, the Linux SMB client does not
> > >   implement creating a new symlink yet and server supports symlinks.
> > >   This applies for example for SMB1 dialect against Windows server, when
> > >   Linux SMB client is already able to query existing symlinks via
> > >   readlink() syscall (just not able to create new one).
> > > 
> > > 2 For the current mount parameters, the SMB server does not support
> > >   symlink operations at all. But it can support it when using other
> > >   mount parameters. This applies for example for older Samba server with
> > >   SMB2+ dialect (when older version supported symlinks only over SMB1).
> > > 
> > > 3 The SMB server for the mounted share does not support symlink
> > >   operations at all. For example server supports symlinks, but mounted
> > >   share is on FAT32 on which symlinks cannot be stored.
> > > 
> > > 4 The user who is logged to SMB server does not have a privilege to
> > >   create a new symlink at all. But server and also share supports
> > >   symlinks without any problem. Just this user is less privileged,
> > >   and no ACL/mode can help.
> > > 
> > > 5 The user does not have access right to create a new object (file,
> > >   directory, symlink, etc...) in the specified directory. For example
> > >   "chmod -w" can cause this.
> > > 
> > > Linux SMB client should have all information via different SMB error
> > > codes to distinguish between all these 5 situations.
> > > 
> > > On Windows servers for creating a new symlink is required that user has
> > > SeCreateSymbolicLinkPrivilege. This privilege is by default enabled only
> > > for Administrators, so by default ordinary users cannot create symlinks
> > > due to security restrictions. On the other hand, querying symlink path
> > > is allowed for any user (who has access to that symlink fs object).
> > > 
> > > Therefore it is important for user who is calling 'ln -s' command on SMB
> > > share mounted on Linux to distinguish between 4 and 5 on failure. If
> > > user needs to just add "write-directory" permission (chmod +w) or asking
> > > AD admin for adding SeCreateSymbolicLinkPrivilege into Group Policy.
> > > 
> > > 
> > > I would like to open a discussion on fsdevel list, what errno codes from
> > > symlink() syscall should be reported to userspace for particular
> > > situations 1 - 5?
> > > 
> > > Situation 5 should be classic EACCES. I think this should be clear.
> > > 
> > > Situation 4 start to be complicated. Windows "privilege" is basically
> > > same as Linux "capability", it is bound to the process and in normal
> > > situation it is set by login manager. Just Linux does not have
> > > equivalent capability for allowing creating new symlink. But generally
> > > Linux for missing permission which is granted by capability (e.g. for
> > > ioperm() via CAP_SYS_RAWIO) is in lot of cases returned errno EPERM.
> > > 
> > > So I thought that EPERM is a good errno candidate for situation 4, until
> > > I figured out that "symlink(2)" manapage has documented that EPERM has
> > > completely different meaning:
> > > 
> > >   EPERM  The filesystem containing linkpath does not support the
> > >          creation of symbolic links.
> > > 
> > > And I do not understand why. I have tried to call 'ln -s' on FAT32 and
> > > it really showed me: "Operation not permitted" even under root. For user
> > > this error message sounds like it needs to be admin / root. It is very
> > > misleading.
> > > 
> > > At least it looks like that EPERM cannot be used for this situation.
> > > And so it is not so easy to figure out what error codes should be
> > > correctly returned to userspace.
> > > 
> > > 
> > > Pali
> > 
> > I was thinking more about it and the reasonable solution could be to use
> > following errno codes for these situations:
> > 
> >  EOPNOTSUPP - server or client does not support symlink operation
> >  EPERM - user does not have privilege / capability to create new symlink
> >  EACCES - user does not have (ACL) permission to create new symlink
> 
> Yes, this looks sensible to me.
> 
> > But in this case it would be needed to extend symlink(2) manpage. It is
> > feasible? Or the meaning of EPERM is written in the stone, it means that
> > operation is not supported, and it cannot be changed?
> > 
> > For me it sounds a bug if EPERM means "not supported", and also "ln -s"
> > tool does not understand this EPERM error as it shows human readable
> > message "Operation not permitted" instead of "Operation not supported"
> > (which is the correct one in this situation).
> 
> What manpage says can certainly be changed, just write to the manpage
> maintainer. After all it is just documenting how the code behaves. I didn't
> find anything in the standards that would forbid this behavior and we don't
> even take standards too seriously ;). What matters is application behavior.
> I would be a bit reluctant to change EPERM return code to EOPNOTSUPP for
> all the filesystems (as much as I agree it would be more sensible error) as
> I don't see a strong enough reason for risking that it might break some
> application somewhere. But making Samba behave as above and documenting in
> the manpage that EPERM means that particular problem for it sounds
> certainly fine to me.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Ok, if it makes sense to use EOPNOTSUPP / EPERM / EACCES like
I described above, then I can prepare changes for cifs.ko driver and
also for Linux symlink manpage.

