Return-Path: <linux-fsdevel+bounces-53581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBEFAF0426
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7481B4A24F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC12820C6;
	Tue,  1 Jul 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo/YxcRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD13279785;
	Tue,  1 Jul 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399647; cv=none; b=Ca81HKuwI/LKByimTV47rwnEzJs3BJyyZYAIgDdYxIuUAQDHSbye6uycS5IVSP5iI3ERtpe0q3S3I7zjmFxKhv2AZPvSeJ3hlCgOZXPAzAgRBDlPNx2rfF1kyW6qEEvyXSXXIbMjq/O6VP7c6gRxINsO6TE2vhmHAAC5U72S/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399647; c=relaxed/simple;
	bh=Yd/r5g9u2NZIWZkYoik90fsPSnjEUF3dw7edlX++I9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE54+FqtmqLoxq+Cmq1K02gpDMvcwamSelzYmrFGwXxcacWWUJJEmpaMuwbX/MTR5C44FlzUCP7xdH6JZT+F8AZKuw91VxEd1sOImfU3FQRyJZ3AGf+2GONV5htfw2n6O+P1Q3TobTOzxfxtgh8MWwzaoKXFyFjO3lYN9gHFOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo/YxcRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D23C4CEEE;
	Tue,  1 Jul 2025 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399647;
	bh=Yd/r5g9u2NZIWZkYoik90fsPSnjEUF3dw7edlX++I9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fo/YxcRzlenSelFr/HeCpGRrtCh4Zt6Lfd7LXrBJ22cPEXJfPzuxG7ag0WmRhXySO
	 uhiZkXZMKOvat1Rql6K5NuO11XbWbNrlHvm/F7mzL9ai0j8dcLvD86WCDDtlQFbB4+
	 wQiSu3ov2gQMfgZEHW54DAQFxqfMyPwI8en1GTFXGk2rraSoRheueiF4OnndjL4C8r
	 bgr5SLw8ZTQL/LlkXSINOes6L+kdz3uPuZWwYss3tePpBy+RBdGdeIqjo/mOyvTYI8
	 /sFJiG/X8nwyqHNhKeindoBxO4STpx1k+jroNUfAN3PmCzfA1kQqPV+PE6ZfnktV5Q
	 hYqDcA+hRpA5Q==
Received: by pali.im (Postfix)
	id 631775D6; Tue,  1 Jul 2025 21:54:05 +0200 (CEST)
Date: Tue, 1 Jul 2025 21:54:05 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Message-ID: <20250701195405.xf27mjknu5bnunue@pali>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
 <20250701183105.GP10009@frogsfrogsfrogs>
 <CAOQ4uxiCpGcZ7V8OqssP2xKsN0ZiAO7mQ_1Qt705BrcHeSPmBg@mail.gmail.com>
 <20250701194002.GS10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701194002.GS10009@frogsfrogsfrogs>
User-Agent: NeoMutt/20180716

On Tuesday 01 July 2025 12:40:02 Darrick J. Wong wrote:
> On Tue, Jul 01, 2025 at 09:27:38PM +0200, Amir Goldstein wrote:
> > On Tue, Jul 1, 2025 at 8:31 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Mon, Jun 30, 2025 at 06:20:15PM +0200, Andrey Albershteyn wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > We intend to add support for more xflags to selective filesystems and
> > > > We cannot rely on copy_struct_from_user() to detect this extension.
> > > >
> > > > In preparation of extending the API, do not allow setting xflags unknown
> > > > by this kernel version.
> > > >
> > > > Also do not pass the read-only flags and read-only field fsx_nextents to
> > > > filesystem.
> > > >
> > > > These changes should not affect existing chattr programs that use the
> > > > ioctl to get fsxattr before setting the new values.
> > > >
> > > > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> > > > Cc: Pali Rohár <pali@kernel.org>
> > > > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > ---
> > > >  fs/file_attr.c           |  8 +++++++-
> > > >  include/linux/fileattr.h | 20 ++++++++++++++++++++
> > > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > > > index 4e85fa00c092..62f08872d4ad 100644
> > > > --- a/fs/file_attr.c
> > > > +++ b/fs/file_attr.c
> > > > @@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> > > >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
> > > >  {
> > > >       struct fsxattr xfa;
> > > > +     __u32 mask = FS_XFLAGS_MASK;
> > > >
> > > >       memset(&xfa, 0, sizeof(xfa));
> > > > -     xfa.fsx_xflags = fa->fsx_xflags;
> > > > +     xfa.fsx_xflags = fa->fsx_xflags & mask;
> > >
> > > I wonder, should it be an error if a filesystem sets an fsx_xflags bit
> > > outside of FS_XFLAGS_MASK?  I guess that's one way to prevent
> > > filesystems from overriding the VFS bits. ;)
> > 
> > I think Pali has a plan on how to ensure that later
> > when the mask is provided via the API.
> > 
> > >
> > > Though couldn't that be:
> > >
> > >         xfa.fsx_xflags = fa->fsx_xflags & FS_XFLAGS_MASK;
> > >
> > > instead?  And same below?
> > >
> > 
> > Indeed. There is a reason for the var, because the next series
> > by Pali will use a user provided mask, which defaults to FS_XFLAGS_MASK,
> > so I left it this way.
> > 
> > I don't see a problem with it keeping as is, but if it bothers you
> > I guess we can re-add the var later.
> 
> Nah, it doesn't bother me that much.
> 
> > > >       xfa.fsx_extsize = fa->fsx_extsize;
> > > >       xfa.fsx_nextents = fa->fsx_nextents;
> > > >       xfa.fsx_projid = fa->fsx_projid;
> > > > @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
> > > >                                 struct fsxattr __user *ufa)
> > > >  {
> > > >       struct fsxattr xfa;
> > > > +     __u32 mask = FS_XFLAGS_MASK;
> > > >
> > > >       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> > > >               return -EFAULT;
> > > >
> > > > +     if (xfa.fsx_xflags & ~mask)
> > > > +             return -EINVAL;
> > >
> > > I wonder if you want EOPNOTSUPP here?  We don't know how to support
> > > unknown xflags.  OTOH if you all have beaten this to death while I was
> > > out then don't start another round just for me. :P
> > 
> > We have beaten this API almost to death for sure ;)
> > I don't remember if we discussed this specific aspect,
> > but I am personally in favor of
> > EOPNOTSUPP := the fs does not support the set/get operation
> > EINVAL := some flags provided as value is invalid
> > 
> > For example, if the get API provides you with a mask of the
> > valid flags that you can set, if you try to set flags outside of
> > that mask you get EINVAL.
> > 
> > That's my interpretation, but I agree that EOPNOTSUPP can also
> > make sense in this situation.
> 
> <nod> I think I'd rather EOPNOTSUPP for "bits are set that the kernel
> doesn't recognize" and EINVAL (or maybe something else like
> EPROTONOSUPPORT) for "fs driver will not let you change this bit".
> At least for the syscall interface; we probably have to flatten that to
> EOPNOTSUPP for both legacy ioctls.

... and this starting to be complicated if the "fs driver" is network
based (as fs driver can support, but remote server not). See also:
https://lore.kernel.org/linux-fsdevel/20241224160535.pi6nazpugqkhvfns@pali/t/#u

For backup/restore application it would be very useful to distinguish between:
- "kernel does not support flag X"
- "target filesystem does not support flag X"
- "wrong structure was passed / syscall incorrectly called"

third option is bug in application - fatal error. second option is just
a warning for user (sorry, we cannot set NEW FEATURE on FAT32, but if
you would do restore to other fs, it is supported). and first option
happens when you run new application on older kernel version, it is an
recoverable error (or warning to user, but with more important level
then second option as switching to different FS would not help).

Could we return different errnos for these 3 situations?

> --D
> 
> > Thanks,
> > Amir.
> > 

