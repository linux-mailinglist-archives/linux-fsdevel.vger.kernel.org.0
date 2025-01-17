Return-Path: <linux-fsdevel+bounces-39511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB2A1561D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C17E1687E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3671A2C27;
	Fri, 17 Jan 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2aHCO6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467281A256B;
	Fri, 17 Jan 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136688; cv=none; b=NK2EzxnSUMYL9fDWqoiQnxnO+m0/JeFWwqYZ1n6DyONAgbWag5StFanVdqWTUyR2i0eEIm7nW2Gd2L2WDVzykIHl9IGst2JCaOLWOaK/7FCyEfypkS6RlBT8SK4IpF4j4jxjLev1dfNEein0KZj2dOfVzC12RPlw28yQ+GtVxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136688; c=relaxed/simple;
	bh=D69buqgF5oOQb5jbgGY82DkO1/lf34KohHgxJVdVMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0h2ZhIlXHI/jV2BClrte88O0lZwHaDT2wPr1g+20+dduPA6xJyGYOterbsp4cyj/Z+Rkt2r4cIKU/aDdl/IBXqj8WSAI2/HL3N9wbIb8m6BSNnVv8G7HsTGpwW5nhyxmy9XpTJKHOZ6qQhF2YHA6L7F2F6ugD/QltyByN/5hhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2aHCO6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6047AC4CEDD;
	Fri, 17 Jan 2025 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136686;
	bh=D69buqgF5oOQb5jbgGY82DkO1/lf34KohHgxJVdVMr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2aHCO6FQEbvrxLiIzE+2oxYMK1RiCO77jdTx9Ujvo93F6liHyq7D+QK6qf35nZPS
	 j9XIUi6i4fZ/8vv6KtGwREVB9wDdT8D6RbzbSd5GL991egImuliMohwDgyavn3EOvR
	 MI9PPxc5MtDOp5+lYgqM7GmXMHdvebwePmSSCfdX5RPdIsHO1VZBV2rijEeXJzb1g3
	 k4x4sJDmH75gkMe2vExjxWBNPUIWnCueQ1iLbD6f64PZqcnsx2IkHmVSK/pX34qO6D
	 9xT8BPu4DOvzlWvhexTDo1qzciCm8n4X8S2ymHjPwpDXRpbkuL9qR/VCM28CmIbgu6
	 CEIMWyUFcqW6Q==
Received: by pali.im (Postfix)
	id 768587A1; Fri, 17 Jan 2025 18:57:55 +0100 (CET)
Date: Fri, 17 Jan 2025 18:57:55 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250117175755.lctf5ezhhtdznt6m@pali>
References: <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali>
 <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAH2r5mvCJ=fPt5BgwFubJ+HWo+a0EHOTNoXxTt0NOhMC=V+GcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mvCJ=fPt5BgwFubJ+HWo+a0EHOTNoXxTt0NOhMC=V+GcQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Friday 17 January 2025 11:51:54 Steve French wrote:
> On Fri, Jan 17, 2025 at 11:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jan 17, 2025 at 05:53:34PM +0100, Amir Goldstein wrote:
> > > On Wed, Jan 15, 2025 at 12:59 AM Darrick J. Wong <djwong@kernel.org> wrote:
> <...>
> > > Looking at the FILE_ATTRIBUTE_* flags defined in SMB protocol
> > >  (fs/smb/common/smb2pdu.h) I wonder how many of them will be
> > > needed for applications beyond the obvious ones that were listed.
> >
> > Well they only asked for seven of them. ;)
> >
> > I chatted with Ted about this yesterday, and ... some of the attributes
> > (like read only) imply that you'd want the linux server to enforce no
> > writing to the file; some like archive seem a little superfluous since
> > on linux you can compare cmtime from the backup against what's in the
> > file now; and still others (like hidden/system) might just be some dorky
> > thing that could be hidden in some xattr because a unix filesystem won't
> > care.
> >
> > And then there are other attrs like "integrity stream" where someone
> > with more experience with windows would have to tell me if fsverity
> > provides sufficient behaviors or not.
> >
> > But maybe we should start by plumbing one of those bits in?  I guess the
> > gross part is that implies an ondisk inode format change or (gross)
> > xattr lookups in the open path.
> >
> 
> We have talked about some of these missing flags in the past, but the
> obvious ones that would be helpful i (e.g. is used in other operating
> systems when view directories in the equivalent of the "Files" GUI is
> checking FILE_ATTRIBUTE_OFFLINE to determine whether to query icons,
> and additional metadata for files).  In the past Unix used to have
> various ways to determine this, but it is fairly common for files to
> be tiered (where the data is in very slow storage offline - so should
> only be opened and read by apps that really need to - not things like
> GUIs browsing lists of files) so that attribute could be helpful.
> 
> The other two obvious ones (missing in Linux but that some other OS
> have filesystems which support) discussed before were
> FILE_ATTRIBUTE_INTEGRITY_STREAM which could be set for files that need
> stronger data integrity guarantees (if a filesystem allows files to be
> marked for stronger data integrity guarantees) , and
> FILE_ATTRIBUTE_NO_SCRUB_DATA that indicates integrity checks can be
> skipped for this particular file.
> -- 
> Thanks,
> 
> Steve

Thank you for information about integrity stream and these new things
around. I have not included them into my initial list because I have not
used them yet. That it why I listed only seven. But as I wrote in the
other email, whatever API is chosen, it should be prepared for extending
and integrity stream sounds like something could be included there.

