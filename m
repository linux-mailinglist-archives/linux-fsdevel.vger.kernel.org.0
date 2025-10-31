Return-Path: <linux-fsdevel+bounces-66612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134BEC264ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 18:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718AE3B1EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5285301707;
	Fri, 31 Oct 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7bJCxaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304392FBDE7;
	Fri, 31 Oct 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930633; cv=none; b=lHg3yNElAufslVUxpgyztHqd5pcQuv5QOlLs5I2VXtEN6LqyGA3vGOrnnyJkgU/p6QjtvRn0Fud9tQuBA2xBxfiJqrm14vUfSZwDb4tQ3kwhQLcSHUcPksVxFJXx9AJC19kmuR5BtKddcyQbIWHA5CpGAu8bJ2OebehBoPx4USI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930633; c=relaxed/simple;
	bh=kuhuOItW6uCdq+fz4WAGlCR/9/yrgL18hnM08e2tvT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtEqqw5E8tDpHP4jiXbRz4zceXCxw5UBGTiggViwJRzZof25BADHsMbPIoyELBdHz5ejjAMvj5TAa8HeNANuYe+NkVN79c+eF4DFPHAeaOOSdTf9uOlOMsIj7nH6CAhogchlJiFK2Ykj6yDsoCyY+g2J1+TLTspfHGlzv3XNvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7bJCxaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E087C4CEE7;
	Fri, 31 Oct 2025 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761930632;
	bh=kuhuOItW6uCdq+fz4WAGlCR/9/yrgL18hnM08e2tvT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7bJCxafB8yPUn2jVPwgovpqDrVyVDoHd1YNY1T80hnSeh8dB9VqjFtr3DrJsOMJU
	 iJsOygh3GjzMbnxoVGB5JHsZsmehUrmuvZ205PFnK/yMZs1A305ZYYeZbTU5jAUmf4
	 PKqc783tCN/gsomjhIpBF9hPdwuGlM1e7QgFQHERkU0SaQlluZ4StXkPX9aWXYw2E+
	 cCzBHIVooqg1urkmH5S7bCyXJamyHb61jQ4RpJNuY/3QooEsgi75BNsCSUljrTx76S
	 UIyEyoFu9S+Tz41de0e9ICA2Eu1b2z7obn7gy/Kzk14eu3lpQkgVh+99fUY+MluoCr
	 vZx88QEfFlFcA==
Received: by pali.im (Postfix)
	id 2FF9677A; Fri, 31 Oct 2025 18:10:27 +0100 (CET)
Date: Fri, 31 Oct 2025 18:10:27 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org,
	"G. Branden Robinson" <branden@debian.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <20251031171027.nhpwrm7ih4fdkfns@pali>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <75ug4vsltx6tiwmt7m4rquh7uxsbpqqgopxjj7ethfkkdsmt7v@ycgd272ybqto>
 <grzxwjrxlneaus735jhwh2buo2nvmj2c4iospzmh7rcfs5czel@qjlb5czusc52>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <grzxwjrxlneaus735jhwh2buo2nvmj2c4iospzmh7rcfs5czel@qjlb5czusc52>
User-Agent: NeoMutt/20180716

On Friday 31 October 2025 12:31:41 Alejandro Colomar wrote:
> Hi Jan, Pali,
> 
> On Fri, Oct 31, 2025 at 11:56:19AM +0100, Jan Kara wrote:
> > On Fri 31-10-25 11:44:14, Alejandro Colomar wrote:
> > > Suggested-by: Pali Rohár <pali@kernel.org>
> > > Co-authored-by: Pali Rohár <pali@kernel.org>
> > > Co-authored-by: Jan Kara <jack@suse.cz>
> > > Cc: "G. Branden Robinson" <branden@debian.org>
> > > Cc: <linux-fsdevel@vger.kernel.org>
> > > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > > ---
> > > 
> > > Hi Jan,
> > > 
> > > I've put your suggestions into the patch.  I've also removed the
> > > sentence about POSIX, as Pali discussed with Branden.
> > > 
> > > At the bottom of the email is the range-diff against the previous
> > > version.
> > 
> > Thanks! The patch looks good. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Thanks!
> 
> Pali, would you mind signing the patch?  One you do, I'll merge.

Hello, yes, that this fine.

Reviewed-by: Pali Rohár <pali@kernel.org>


For future improvements, it would be nice to adjust also other manpages
which refers to inode numbers:

  git grep -E '\<st_ino\>|\<stx_ino\>|\<d_ino\>'

> 
> Cheers,
> Alex
> 
> > 
> > 								Honza
> > 
> > > 
> > > 
> > > Have a lovely day!
> > > Alex
> > > 
> > >  man/man3/readdir.3      | 19 ++++++++++++++++++-
> > >  man/man3type/stat.3type | 20 +++++++++++++++++++-
> > >  2 files changed, 37 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
> > > index e1c7d2a6a..220643795 100644
> > > --- a/man/man3/readdir.3
> > > +++ b/man/man3/readdir.3
> > > @@ -58,7 +58,24 @@ .SH DESCRIPTION
> > >  structure are as follows:
> > >  .TP
> > >  .I .d_ino
> > > -This is the inode number of the file.
> > > +This is the inode number of the file
> > > +in the filesystem containing
> > > +the directory on which
> > > +.BR readdir ()
> > > +was called.
> > > +If the directory entry is the mount point,
> > > +then
> > > +.I .d_ino
> > > +differs from
> > > +.I .st_ino
> > > +returned by
> > > +.BR stat (2)
> > > +on this file:
> > > +.I .d_ino
> > > +is the inode number of the mount point,
> > > +while
> > > +.I .st_ino
> > > +is the inode number of the root directory of the mounted filesystem.
> > >  .TP
> > >  .I .d_off
> > >  The value returned in
> > > diff --git a/man/man3type/stat.3type b/man/man3type/stat.3type
> > > index 76ee3765d..ea9acc5ec 100644
> > > --- a/man/man3type/stat.3type
> > > +++ b/man/man3type/stat.3type
> > > @@ -66,7 +66,25 @@ .SH DESCRIPTION
> > >  macros may be useful to decompose the device ID in this field.)
> > >  .TP
> > >  .I .st_ino
> > > -This field contains the file's inode number.
> > > +This field contains the file's inode number
> > > +in the filesystem on
> > > +.IR .st_dev .
> > > +If
> > > +.BR stat (2)
> > > +was called on the mount point,
> > > +then
> > > +.I .st_ino
> > > +differs from
> > > +.I .d_ino
> > > +returned by
> > > +.BR readdir (3)
> > > +for the corresponding directory entry in the parent directory.
> > > +In this case,
> > > +.I .st_ino
> > > +is the inode number of the root directory of the mounted filesystem,
> > > +while
> > > +.I .d_ino
> > > +is the inode number of the mount point in the parent filesystem.
> > >  .TP
> > >  .I .st_mode
> > >  This field contains the file type and mode.
> > > 
> > > Range-diff against v2:
> > > 1:  d3eeebe81 ! 1:  bfa7e72ea man/man3/readdir.3, man/man3type/stat.3type: Improve documentation about .d_ino and .st_ino
> > >     @@ Commit message
> > >      
> > >          Suggested-by: Pali Rohár <pali@kernel.org>
> > >          Co-authored-by: Pali Rohár <pali@kernel.org>
> > >     +    Co-authored-by: Jan Kara <jack@suse.cz>
> > >          Cc: "G. Branden Robinson" <branden@debian.org>
> > >          Cc: <linux-fsdevel@vger.kernel.org>
> > >          Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > >     @@ man/man3/readdir.3: .SH DESCRIPTION
> > >       .TP
> > >       .I .d_ino
> > >      -This is the inode number of the file.
> > >     -+This is the inode number of the file,
> > >     -+which belongs to the filesystem
> > >     -+.I .st_dev
> > >     -+(see
> > >     -+.BR stat (3type))
> > >     -+of the directory on which
> > >     ++This is the inode number of the file
> > >     ++in the filesystem containing
> > >     ++the directory on which
> > >      +.BR readdir ()
> > >      +was called.
> > >      +If the directory entry is the mount point,
> > >      +then
> > >      +.I .d_ino
> > >      +differs from
> > >     -+.IR .st_ino :
> > >     ++.I .st_ino
> > >     ++returned by
> > >     ++.BR stat (2)
> > >     ++on this file:
> > >      +.I .d_ino
> > >     -+is the inode number of the underlying mount point,
> > >     ++is the inode number of the mount point,
> > >      +while
> > >      +.I .st_ino
> > >     -+is the inode number of the mounted file system.
> > >     -+According to POSIX,
> > >     -+this Linux behavior is considered to be a bug,
> > >     -+but is nevertheless conforming.
> > >     ++is the inode number of the root directory of the mounted filesystem.
> > >       .TP
> > >       .I .d_off
> > >       The value returned in
> > >     @@ man/man3type/stat.3type: .SH DESCRIPTION
> > >       .TP
> > >       .I .st_ino
> > >      -This field contains the file's inode number.
> > >     -+This field contains the file's inode number,
> > >     -+which belongs to the
> > >     ++This field contains the file's inode number
> > >     ++in the filesystem on
> > >      +.IR .st_dev .
> > >      +If
> > >      +.BR stat (2)
> > >      +was called on the mount point,
> > >      +then
> > >     -+.I .d_ino
> > >     -+differs from
> > >     -+.IR .st_ino :
> > >     -+.I .d_ino
> > >     -+is the inode number of the underlying mount point,
> > >     -+while
> > >      +.I .st_ino
> > >     -+is the inode number of the mounted file system.
> > >     ++differs from
> > >     ++.I .d_ino
> > >     ++returned by
> > >     ++.BR readdir (3)
> > >     ++for the corresponding directory entry in the parent directory.
> > >     ++In this case,
> > >     ++.I .st_ino
> > >     ++is the inode number of the root directory of the mounted filesystem,
> > >     ++while
> > >     ++.I .d_ino
> > >     ++is the inode number of the mount point in the parent filesystem.
> > >       .TP
> > >       .I .st_mode
> > >       This field contains the file type and mode.
> > > 
> > > base-commit: f305f7647d5cf62e7e764fb7a25c4926160c594f
> > > -- 
> > > 2.51.0
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> -- 
> <https://www.alejandro-colomar.es>
> Use port 80 (that is, <...:80/>).

