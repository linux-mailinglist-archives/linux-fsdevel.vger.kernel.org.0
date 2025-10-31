Return-Path: <linux-fsdevel+bounces-66599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07BC25D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 962B94F8B87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F4B2C326F;
	Fri, 31 Oct 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlQkJv9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C62C17B6;
	Fri, 31 Oct 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924333; cv=none; b=F7LzHsziAVezy1Pti3uIrZjq90QBqe97gg+T2w/lBPluT1N0XyLOhwszdFDFk4s5xo3XOenZoCiHlzLrvStDjwv7xHD2oPpWyIrrSgF4uIjCGEUfn1kdUqVDWzkSKjeo3GWNIYn3FsXaSWAseiufRU1FLq14ZLxFEM7SSF5/9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924333; c=relaxed/simple;
	bh=VeGPIDKJHY0kcgnWGdqHeyRl+7/k7kmy4YUStIV66x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlLwAkEn8fA2gI1l6u41aQqtI7SEuZ/lDj0T5Y2LdOvrScJ5XDgHrnAwsXHiMX4LncWh5PJc22yyzn4TwHxd0dnOXIKSNvNjk0a3GCqyN+RvK+Oyms84vXZI1JIa9gUJP97D2ABbFg5joPN6YTLhwZo6NJLykkovHj9mDTVcxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlQkJv9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C945EC4CEE7;
	Fri, 31 Oct 2025 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761924332;
	bh=VeGPIDKJHY0kcgnWGdqHeyRl+7/k7kmy4YUStIV66x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlQkJv9ho8+T+TKLFiuelle/XtpAfUKmJ95JZlfaetUwvGKLdsdAYYa3vECRFKDtL
	 Wb1sQ/osNylO2ypvQnZWf3wK78raaKWMVv/SSIQMy/DTb1Dh3djhITrAdgwI5vBHVr
	 SY9pELBwWw8Cgr1iIs+4rjm1Sv4UVmy21o5wp1XIorDSzgRhgppI+/HNuJP8YNadd5
	 zZiNLhvAaubcbHvPV5w4Q8CB6ByafPGFc0ml/ulDCnwunN2Y9z6S6sQTPs7j76Slfw
	 f7G4XmqEYNeWLJed7Is45cqHczYI1qzKSTzTeJgctAjjEk5G5pUBDNs0saj4FkX3UC
	 FmJYlToWVfcnQ==
Date: Fri, 31 Oct 2025 08:25:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <branden@debian.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <20251031152531.GP6174@frogsfrogsfrogs>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>

On Fri, Oct 31, 2025 at 11:44:14AM +0100, Alejandro Colomar wrote:
> Suggested-by: Pali Rohár <pali@kernel.org>
> Co-authored-by: Pali Rohár <pali@kernel.org>
> Co-authored-by: Jan Kara <jack@suse.cz>
> Cc: "G. Branden Robinson" <branden@debian.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi Jan,
> 
> I've put your suggestions into the patch.  I've also removed the
> sentence about POSIX, as Pali discussed with Branden.
> 
> At the bottom of the email is the range-diff against the previous
> version.
> 
> 
> Have a lovely day!
> Alex
> 
>  man/man3/readdir.3      | 19 ++++++++++++++++++-
>  man/man3type/stat.3type | 20 +++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
> index e1c7d2a6a..220643795 100644
> --- a/man/man3/readdir.3
> +++ b/man/man3/readdir.3
> @@ -58,7 +58,24 @@ .SH DESCRIPTION
>  structure are as follows:
>  .TP
>  .I .d_ino
> -This is the inode number of the file.
> +This is the inode number of the file
> +in the filesystem containing
> +the directory on which
> +.BR readdir ()
> +was called.
> +If the directory entry is the mount point,

nitpicking english:

"...is a mount point," ?

--D

> +then
> +.I .d_ino
> +differs from
> +.I .st_ino
> +returned by
> +.BR stat (2)
> +on this file:
> +.I .d_ino
> +is the inode number of the mount point,
> +while
> +.I .st_ino
> +is the inode number of the root directory of the mounted filesystem.
>  .TP
>  .I .d_off
>  The value returned in
> diff --git a/man/man3type/stat.3type b/man/man3type/stat.3type
> index 76ee3765d..ea9acc5ec 100644
> --- a/man/man3type/stat.3type
> +++ b/man/man3type/stat.3type
> @@ -66,7 +66,25 @@ .SH DESCRIPTION
>  macros may be useful to decompose the device ID in this field.)
>  .TP
>  .I .st_ino
> -This field contains the file's inode number.
> +This field contains the file's inode number
> +in the filesystem on
> +.IR .st_dev .
> +If
> +.BR stat (2)
> +was called on the mount point,
> +then
> +.I .st_ino
> +differs from
> +.I .d_ino
> +returned by
> +.BR readdir (3)
> +for the corresponding directory entry in the parent directory.
> +In this case,
> +.I .st_ino
> +is the inode number of the root directory of the mounted filesystem,
> +while
> +.I .d_ino
> +is the inode number of the mount point in the parent filesystem.
>  .TP
>  .I .st_mode
>  This field contains the file type and mode.
> 
> Range-diff against v2:
> 1:  d3eeebe81 ! 1:  bfa7e72ea man/man3/readdir.3, man/man3type/stat.3type: Improve documentation about .d_ino and .st_ino
>     @@ Commit message
>      
>          Suggested-by: Pali Rohár <pali@kernel.org>
>          Co-authored-by: Pali Rohár <pali@kernel.org>
>     +    Co-authored-by: Jan Kara <jack@suse.cz>
>          Cc: "G. Branden Robinson" <branden@debian.org>
>          Cc: <linux-fsdevel@vger.kernel.org>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     @@ man/man3/readdir.3: .SH DESCRIPTION
>       .TP
>       .I .d_ino
>      -This is the inode number of the file.
>     -+This is the inode number of the file,
>     -+which belongs to the filesystem
>     -+.I .st_dev
>     -+(see
>     -+.BR stat (3type))
>     -+of the directory on which
>     ++This is the inode number of the file
>     ++in the filesystem containing
>     ++the directory on which
>      +.BR readdir ()
>      +was called.
>      +If the directory entry is the mount point,
>      +then
>      +.I .d_ino
>      +differs from
>     -+.IR .st_ino :
>     ++.I .st_ino
>     ++returned by
>     ++.BR stat (2)
>     ++on this file:
>      +.I .d_ino
>     -+is the inode number of the underlying mount point,
>     ++is the inode number of the mount point,
>      +while
>      +.I .st_ino
>     -+is the inode number of the mounted file system.
>     -+According to POSIX,
>     -+this Linux behavior is considered to be a bug,
>     -+but is nevertheless conforming.
>     ++is the inode number of the root directory of the mounted filesystem.
>       .TP
>       .I .d_off
>       The value returned in
>     @@ man/man3type/stat.3type: .SH DESCRIPTION
>       .TP
>       .I .st_ino
>      -This field contains the file's inode number.
>     -+This field contains the file's inode number,
>     -+which belongs to the
>     ++This field contains the file's inode number
>     ++in the filesystem on
>      +.IR .st_dev .
>      +If
>      +.BR stat (2)
>      +was called on the mount point,
>      +then
>     -+.I .d_ino
>     -+differs from
>     -+.IR .st_ino :
>     -+.I .d_ino
>     -+is the inode number of the underlying mount point,
>     -+while
>      +.I .st_ino
>     -+is the inode number of the mounted file system.
>     ++differs from
>     ++.I .d_ino
>     ++returned by
>     ++.BR readdir (3)
>     ++for the corresponding directory entry in the parent directory.
>     ++In this case,
>     ++.I .st_ino
>     ++is the inode number of the root directory of the mounted filesystem,
>     ++while
>     ++.I .d_ino
>     ++is the inode number of the mount point in the parent filesystem.
>       .TP
>       .I .st_mode
>       This field contains the file type and mode.
> 
> base-commit: f305f7647d5cf62e7e764fb7a25c4926160c594f
> -- 
> 2.51.0
> 
> 

