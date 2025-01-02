Return-Path: <linux-fsdevel+bounces-38337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466A9FFD4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 18:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791671883392
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5607D183CD1;
	Thu,  2 Jan 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTfBONFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61688F66;
	Thu,  2 Jan 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735840778; cv=none; b=fglAjzZRt/ZIzJihfsgmIcq0SmcVgMw1tc0LkDdo51d93jlNVdS/bgoFKIPOoe7S8YNFZWskZ2vK5i411DozenQrwh3uSU+IiA9+qulBvAa0F0aSGMH4gcQ6dF1OkYQb24cVFoor7YMWTF5EFTro0WMNmBwceVy7841tvjT9cKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735840778; c=relaxed/simple;
	bh=h+T4Y9bqtjZsq4hUXidgCVAFPZ1PSJDm737jiIOcCBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV964lFHx/T+dyKk11HdB2p3SCsmWeJhblu5XsYFPZ/zmMUAmhoWm1MLyi3tRSiJ+AoPZJXn7uvPBK4VbYL4Eg1pJ/DsPSfQfD0ucXAVmrOZhi0rE3WsjBIbjLi+JLZd4mcM4XO3lfq54uG0i7GRQnonmKZBTZ8nDpXpplP0ino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTfBONFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE0CC4CED0;
	Thu,  2 Jan 2025 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735840778;
	bh=h+T4Y9bqtjZsq4hUXidgCVAFPZ1PSJDm737jiIOcCBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTfBONFSseTV9D3Gov5WUmkMuhds21kAg1XLxeIjAXiVj4WLa92fC1V2eOlMNyk+v
	 LuW99P+tMj8hjfRwgfHA5pYdsy86XehZgy4kzE4z9rq5k5EtFiNk1tT2keADwcuDZh
	 tBMFONyCxtJG87zqMiSgqYWs71+Xuy6nwuezw9E1htJMUSGMaZ9U2UfBfztJgvCDRj
	 Y0MKOaySvlTulRxl5sw9TqOBXU6jndWLJ1vS018X6Om2NnsIY/uLpnA9XGXpIG+4o5
	 Q/PamP9QGczFOz4Ql7Xjs6D8k1TeZDjeDZQlhVgFHKVOPIn1sc+X9I+VqhGugMK7yu
	 KD6UaT1fEJ4ww==
Received: by pali.im (Postfix)
	id 317F8812; Thu,  2 Jan 2025 18:59:27 +0100 (CET)
Date: Thu, 2 Jan 2025 18:59:27 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250102175927.seescpqw3htsziz2@pali>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
User-Agent: NeoMutt/20180716

On Thursday 02 January 2025 15:37:50 Jan Kara wrote:
> Hello!
> 
> On Fri 27-12-24 13:15:08, Pali Rohár wrote:
> > Few months ago I discussed with Steve that Linux SMB client has some
> > problems during removal of directory which has read-only attribute set.
> > 
> > I was looking what exactly the read-only windows attribute means, how it
> > is interpreted by Linux and in my opinion it is wrongly used in Linux at
> > all.
> > 
> > Windows filesystems NTFS and ReFS, and also exported over SMB supports
> > two ways how to present some file or directory as read-only. First
> > option is by setting ACL permissions (for particular or all users) to
> > GENERIC_READ-only. Second option is by setting the read-only attribute.
> > Second option is available also for (ex)FAT filesystems (first option via
> > ACL is not possible on (ex)FAT as it does not have ACLs).
> > 
> > First option (ACL) is basically same as clearing all "w" bits in mode
> > and ACL (if present) on Linux. It enforces security permission behavior.
> > Note that if the parent directory grants for user delete child
> > permission then the file can be deleted. This behavior is same for Linux
> > and Windows (on Windows there is separate ACL for delete child, on Linux
> > it is part of directory's write permission).
> > 
> > Second option (Windows read-only attribute) means that the file/dir
> > cannot be opened in write mode, its metadata attribute cannot be changed
> > and the file/dir cannot be deleted at all. But anybody who has
> > WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
> > wants.
> 
> I guess someone with more experience how to fuse together Windows & Linux
> permission semantics should chime in here but here are my thoughts.

It is important to know that read-only attribute is not a permission
(like UNIX mode or POSIX ACL or Windows ACL) and neither it is not a
security mechanism. It is just an attribute which affects execution of
modification operations.

> > Linux filesystems has similar thing to Windows read-only attribute
> > (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
> > which can be set by the "chattr" tool. Seems that the only difference
> > between Windows read-only and Linux immutable is that on Linux only
> > process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
> > it can be anybody who has write ACL.
> > 
> > Now I'm thinking, how should be Windows read-only bit interpreted by
> > Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
> > 
> > 0) Simply ignored. Disadvantage is that over network fs, user would not
> >    be able to do modify or delete such file, even as root.
> > 
> > 1) Smartly ignored. Meaning that for local fs, it is ignored and for
> >    network fs it has to be cleared before any write/modify/delete
> >    operation.
> > 
> > 2) Translated to Linux mode/ACL. So the user has some ability to see it
> >    or change it via chmod. Disadvantage is that it mix ACL/mode.
> 
> So this option looks sensible to me. We clear all write permissions in
> file's mode / ACL. For reading that is fully compatible, for mode
> modifications it gets a bit messy (probably I'd suggest to just clear
> FILE_ATTRIBUTE_READONLY on modification) but kind of close.

This this option, there are lot of open questions regarding the
behavior. For example:

How the change mode or change ACL operation executed on Linux should
behave? Should it always clear or set read-only attribute when calling
chmod or setfacl? And what if the user does not have capability or
permission to change mode? Then the user would not be able to clear
read-only attribute (IIRC this attribute can be set/clear by having
just write permission).

And when reading, to which mode / ACL part should be read-only attribute
propagated? Only to user, to all 3 parts (user, group, others), or also
into all ACL entries? For example SMB protocol has extension support for
POSIX ACL, so how it should be handled?

Also how to handle unlink operation? With this option, the user first
would have to call chmod +w and after that would be able to call rm -f.
It it quite non-Linux way that it is needed to have write permission on
the file itself for deleting it. Normally it is needed just write
permission on the parent directory.

I do not have answers for these questions, it seems to be really messy
and not intuitive behavior.

> > 3) Translated to Linux FS_IMMUTABLE_FL. So the user can use lsattr /
> >    chattr to see or change it. Disadvantage is that this bit can be
> >    changed only by root or by CAP_LINUX_IMMUTABLE process.
> > 
> > 4) Exported via some new xattr. User can see or change it. But for
> >    example recursive removal via rm -rf would be failing as rm would not
> >    know about this special new xattr.
> > 
> > In any case, in my opinion, all Linux fs drivers for these filesystems
> > (FAT, exFAT, NTFS, SMB, are there some others?) should handle this
> > windows read-only bit in the same way.
> > 
> > What do you think, what should be the best option?
> > 
> > I have another idea. What about introducing a new FS_IMMUTABLE_USER_FL
> > bit which have same behavior as FS_IMMUTABLE_FL, just it would be
> > possible to set it for any user who has granted "write" permission?
> 
> Uh, in unix, write permission is for accessing file data. Modifying access
> permissions etc. is always limited to inode owner (or user with special
> capabilities). So this would be very confusing in Unix permission model.

(Windows) read-only attribute is not a permission, it is an attribute,
that is probably confusing. Similarly FS_IMMUTABLE_FL is not a
permission if I understand it correctly.

And about attributes, Now I have tested that on Linux it is possible to
change time attributes (utimensat) also for files which are not owned by
calling user/process, it is just enough for caller to have write
permission.

Read-only is similar to those time attributes.

> > Instead of requiring CAP_LINUX_IMMUTABLE. I see a nice usecase that even
> > ordinary user could be able to mark file as protected against removal or
> > modification (for example some backup data).
> 
> So I don't see us introducing another immutable bit in VFS. Special
> "protected file" bit modifiable by whoever can modify file permissions is
> not really different from clearing write permission bits in mode.

It differs for unlink operations. Immutable does not allow to to remove
the file. File without write permission can be removed.

I see benefit in FS_IMMUTABLE_FL for that purpose of backup file, but
FS_IMMUTABLE_FL cannot be used by normal user.

> So that
> doesn't seem as a terribly useful feature to me. That being said nothing
> really stops individual filesystems from introducing their own inode flags,
> get / set them via ioctl and implement whatever permission checking needed
> with them. After all this is how the flags like IMMUTABLE or APPEND started
> and only later on when they propagated into many filesystems we've lifted
> them into VFS.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Ok, fair enough.

As there are more filesystems which supports this read-only attribute
feature, it make sense to have same API for all of them. So what is the
better option for exporting it to userspace. Via ioctl or via new xattr?
Or is there any other option?

