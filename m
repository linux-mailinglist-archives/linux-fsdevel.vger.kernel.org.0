Return-Path: <linux-fsdevel+bounces-53571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1643AF033B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C99C446608
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14D280331;
	Tue,  1 Jul 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKc2G48m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC323AB87;
	Tue,  1 Jul 2025 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396101; cv=none; b=a4AAWxYqaCisv4jw/LstB+f8xOTqUC6Gk9Z7mdSneqSDnoFSrWkwbCqXuby9sK5vH5/JY6mkvDjwLmifOSUT418kH5JPpCTV5n4h6QMaUfg1jgboXU885zWjk43cVoGIUayUGyOOgWgj4ZwMmwFHIlZV4reaEGhVrqKcrhdtTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396101; c=relaxed/simple;
	bh=3+LOkK7yAmYcFvOKVchdX4D20Wx83qWmNEjojDTk/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liVOR/qj+mmN/rogCs/AZxcXBm4uoUSI60lmEtzYNdP1iaBS0fM8JU+ztAntpV2HxOukdLCqyUHTBpR50QPCRke6HgCmWCiY7otMYtKhwC7fZPiCiXJBbRGPyDr1jjUfsD6HenWINlgzI9B1dCzP4Swd5nfTeK41ZJU3Exq4rd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKc2G48m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1176AC4CEEB;
	Tue,  1 Jul 2025 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751396100;
	bh=3+LOkK7yAmYcFvOKVchdX4D20Wx83qWmNEjojDTk/VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKc2G48mS21Kpe0iKnEQYljIa2CEQz2BOO+Ufl7FEMSRo9Y2SbiRlQdoQjApKDgTz
	 Ayc5ye0NVomKu+7pIdiLy06V+WQ23nJL32pfhvg4CvGOKNGaRVLP3jSbQiVezdqmiu
	 TTp3VT+YrXP1c8/Jjd1inXIYscX/Y1r3iKm2OVGZ7XnwHK3FtQivSdMd2zyzPHVVss
	 hq8prZgyR3KeWOKalhwGrQiiwQz61Pn8l25II3zmeOkmBKaefE9jnimbfzYYqXQSwu
	 L+sTJl3nEHHQ7edwxM4Fdd4SQLAgUujG5YdbHFKTQskCOdTzIGIND1MRRHYlR5iJsD
	 oKbKvgolToCPw==
Received: by pali.im (Postfix)
	id DD3A85D6; Tue,  1 Jul 2025 20:54:57 +0200 (CEST)
Date: Tue, 1 Jul 2025 20:54:57 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250701185457.jvbwhiiihdauymrg@pali>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701184317.GQ10009@frogsfrogsfrogs>
User-Agent: NeoMutt/20180716

On Tuesday 01 July 2025 11:43:17 Darrick J. Wong wrote:
> On Mon, Jun 30, 2025 at 06:20:16PM +0200, Andrey Albershteyn wrote:
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 0098b0ce8ccb..0784f2033ba4 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -148,6 +148,24 @@ struct fsxattr {
> >  	unsigned char	fsx_pad[8];
> >  };
> >  
> > +/*
> > + * Variable size structure for file_[sg]et_attr().
> > + *
> > + * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
> > + * As this structure is passed to/from userspace with its size, this can
> > + * be versioned based on the size.
> > + */
> > +struct fsx_fileattr {
> > +	__u32	fsx_xflags;	/* xflags field value (get/set) */
> 
> Should this to be __u64 from the start?  Seeing as (a) this struct is
> not already a multiple of 8 bytes and (b) it's likely that we'll have to
> add a u64 field at some point.  That would also address brauner's
> comment about padding.

Hello!

As I have already mentioned, after this syscall API/ABI is finished, I'm
planning to prepare patches for changing just selected fields / flags by
introducing a new mask field, and support for additional flags used by
existing filesystems (like windows flags).

My idea is extending this structure for a new "u32 fsx_xflags_mask"
and new "u32 fsx_xflags2" + "u32 fsx_xflags2_mask". (field names are
just examples).

So in case you are extending the structure now, please consider if it
makes sense to add all members, so we do not have to define 2 or 3
structure versions in near feature.

Your idea of __u64 for fsx_xflags means that it will already cover the
"u32 fsx_xflags2" field.

> --D
> 
> > +	__u32	fsx_extsize;	/* extsize field value (get/set)*/
> > +	__u32	fsx_nextents;	/* nextents field value (get)   */
> > +	__u32	fsx_projid;	/* project identifier (get/set) */
> > +	__u32	fsx_cowextsize;	/* CoW extsize field value (get/set) */
> > +};
> > +
> > +#define FSX_FILEATTR_SIZE_VER0 20
> > +#define FSX_FILEATTR_SIZE_LATEST FSX_FILEATTR_SIZE_VER0
> > +
> >  /*
> >   * Flags for the fsx_xflags field
> >   */
> > diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> > index 580b4e246aec..d1ae5e92c615 100644
> > --- a/scripts/syscall.tbl
> > +++ b/scripts/syscall.tbl
> > @@ -408,3 +408,5 @@
> >  465	common	listxattrat			sys_listxattrat
> >  466	common	removexattrat			sys_removexattrat
> >  467	common	open_tree_attr			sys_open_tree_attr
> > +468	common	file_getattr			sys_file_getattr
> > +469	common	file_setattr			sys_file_setattr
> > 
> > -- 
> > 2.47.2
> > 
> > 

