Return-Path: <linux-fsdevel+bounces-53574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E066BAF037F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44193BBF00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E213281531;
	Tue,  1 Jul 2025 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCASdAs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7331245029;
	Tue,  1 Jul 2025 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397470; cv=none; b=OzJql1cztdAOkLApNvuL3TmgUenJRaKQiknPuQMoXKB/xzdJBD8rlLntoJJUOTM1/UoEAzJ+z46a2+1fd/kxUFZcwaEjfdpgTXn8vFLoWSXPAKsdKeE29qQ5Cmz5iEhmY7phFfTioLMXS7FFwLzzaYsWL3HsEBhPnHIdBx5D60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397470; c=relaxed/simple;
	bh=zwjUMwmbU0XuNCcjMMGtYZ9p614+0YJV+3FSL46Cf/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0MkVnbCrKwXvSO7s/uv2U9lENsOb0KZvc0ShkNfrFew8qSUEWcMrvBHfdcDc0z6CcOmEZ94TozhGUMPddxFiQ4lof8kUHmmUY5ekzCBxjb9Nu8E/9t0DXBee0N+LyHrDh8nfw9qbSbB06M6QJBHy2f+rewwMYa5VILNbYWJWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCASdAs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF409C4CEEB;
	Tue,  1 Jul 2025 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751397469;
	bh=zwjUMwmbU0XuNCcjMMGtYZ9p614+0YJV+3FSL46Cf/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCASdAs5zbT8BAc4F3QlNKAGzdX00hGEDNLN88KkxNqL2OJwfzXx2FPaLWp1M8Nhb
	 20aPKa5aCdxDXdG0yQp6qTBEtVMrU7i1NhJCRw4heO9hiZ2K5Ltq8eamSKrGrkBr+7
	 OdrGd8VZBkW+U/UsAVrAy86ewyJwysEXA3IpqMipc4EmStraLdbqM37T/BI9bMGXgQ
	 UqyDM1nvjaAHNe1kA7a2/9FzTYNGZ5F8E60c452ajGahWmLucpY625aB6tLdA6Be1l
	 ZA5aU/FdTdrCgrXucehKKpKM8M3aNhe+oEg8v4x+KRNak1RcothtATe5gYJ/tTP+Nt
	 B2GUnMhxONgJw==
Received: by pali.im (Postfix)
	id 00B145D6; Tue,  1 Jul 2025 21:17:46 +0200 (CEST)
Date: Tue, 1 Jul 2025 21:17:46 +0200
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
Message-ID: <20250701191746.cekhigo4e6xespjj@pali>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
 <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250701185457.jvbwhiiihdauymrg@pali>
 <20250701190857.GR10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701190857.GR10009@frogsfrogsfrogs>
User-Agent: NeoMutt/20180716

On Tuesday 01 July 2025 12:08:57 Darrick J. Wong wrote:
> On Tue, Jul 01, 2025 at 08:54:57PM +0200, Pali Rohár wrote:
> > On Tuesday 01 July 2025 11:43:17 Darrick J. Wong wrote:
> > > On Mon, Jun 30, 2025 at 06:20:16PM +0200, Andrey Albershteyn wrote:
> > > > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > > > index 0098b0ce8ccb..0784f2033ba4 100644
> > > > --- a/include/uapi/linux/fs.h
> > > > +++ b/include/uapi/linux/fs.h
> > > > @@ -148,6 +148,24 @@ struct fsxattr {
> > > >  	unsigned char	fsx_pad[8];
> > > >  };
> > > >  
> > > > +/*
> > > > + * Variable size structure for file_[sg]et_attr().
> > > > + *
> > > > + * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
> > > > + * As this structure is passed to/from userspace with its size, this can
> > > > + * be versioned based on the size.
> > > > + */
> > > > +struct fsx_fileattr {
> > > > +	__u32	fsx_xflags;	/* xflags field value (get/set) */
> > > 
> > > Should this to be __u64 from the start?  Seeing as (a) this struct is
> > > not already a multiple of 8 bytes and (b) it's likely that we'll have to
> > > add a u64 field at some point.  That would also address brauner's
> > > comment about padding.
> > 
> > Hello!
> > 
> > As I have already mentioned, after this syscall API/ABI is finished, I'm
> > planning to prepare patches for changing just selected fields / flags by
> > introducing a new mask field, and support for additional flags used by
> > existing filesystems (like windows flags).
> > 
> > My idea is extending this structure for a new "u32 fsx_xflags_mask"
> > and new "u32 fsx_xflags2" + "u32 fsx_xflags2_mask". (field names are
> > just examples).
> > 
> > So in case you are extending the structure now, please consider if it
> > makes sense to add all members, so we do not have to define 2 or 3
> > structure versions in near feature.
> > 
> > Your idea of __u64 for fsx_xflags means that it will already cover the
> > "u32 fsx_xflags2" field.
> 
> Ah, ok, so that work *is* still coming. :)

Yes. I'm just waiting until this patch series is accepted.

In past I have already sent RFC patches to the list which modifies the
existing ioctl interface. So you can look at it if you want :-)

> Are you still planning to add masks for xflags bits that are clearable
> and settable?  i.e.
> 
> 	__u64	fa_xflags;		/* state */
> 	...
> 	<end of V0 structure>
> 
> 	__u64	fa_xflags_mask;		/* bits for setattr to examine */
> 	__u64	fa_xflags_clearable;	/* clearable bits */
> 	__u64	fa_xflags_settable;	/* settable bits */
> 
> I think it's easier just to define u64 in the V0 structure and then add
> the three new fields in V1.  What do you think?

I wanted the interface which would allow to atomically change specified
bit/flag without the need for get-modify-set. And I think that this
would not work as the fa_xflags requires the state.

My idea is following:

  __u64 fa_xflags;
  ...
  <end of V0 structure>
  __u64 fa_xflags_mask;

The fa_xflags_mask will specify which bits from the fa_xflags and from
other fa_* fields in V0 struct are going to be changed.

> --D
> 
> > > --D
> > > 
> > > > +	__u32	fsx_extsize;	/* extsize field value (get/set)*/
> > > > +	__u32	fsx_nextents;	/* nextents field value (get)   */
> > > > +	__u32	fsx_projid;	/* project identifier (get/set) */
> > > > +	__u32	fsx_cowextsize;	/* CoW extsize field value (get/set) */
> > > > +};
> > > > +
> > > > +#define FSX_FILEATTR_SIZE_VER0 20
> > > > +#define FSX_FILEATTR_SIZE_LATEST FSX_FILEATTR_SIZE_VER0
> > > > +
> > > >  /*
> > > >   * Flags for the fsx_xflags field
> > > >   */
> > > > diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> > > > index 580b4e246aec..d1ae5e92c615 100644
> > > > --- a/scripts/syscall.tbl
> > > > +++ b/scripts/syscall.tbl
> > > > @@ -408,3 +408,5 @@
> > > >  465	common	listxattrat			sys_listxattrat
> > > >  466	common	removexattrat			sys_removexattrat
> > > >  467	common	open_tree_attr			sys_open_tree_attr
> > > > +468	common	file_getattr			sys_file_getattr
> > > > +469	common	file_setattr			sys_file_setattr
> > > > 
> > > > -- 
> > > > 2.47.2
> > > > 
> > > > 
> > 

