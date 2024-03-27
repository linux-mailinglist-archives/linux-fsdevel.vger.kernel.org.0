Return-Path: <linux-fsdevel+bounces-15390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05088DB49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 11:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D789929ACBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8E2AD2C;
	Wed, 27 Mar 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXm571xa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCE125DB;
	Wed, 27 Mar 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535627; cv=none; b=SSJC6UHsNU05nTcYWbeg4MsoNOVsFgIge9IBjIZrKWP4JnIjiwoTET1Czfw1FRvIaxEeNMqa4bTXZYl1Rhh8wipn59fIhXJVoCVcTWVphRd4gcSpkVr9cVsQKp4mffcSGoJ80pG461yOgW87x5sACYmUw5VDOFD7jxKfyTBjI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535627; c=relaxed/simple;
	bh=X4s13pQiIMlSxWNycUMvGwb++iXPjn4geNOGBsGcK/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c/I0Gqv5G85CKDbnImi5mzJ41ecalm1cDvOiklA5hjD3C6NQUnJInR5w5WzadtaH6ACC5IEQovCgmRd6AbdvWwiWQ98wp7wWtTIuUXnl14+PqQ8wHS73a/T3ScoxHrxZmyBCnHLc3cLhaj5Ud90eolEz9WCvg5jFdVfF+enPH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXm571xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A00C433F1;
	Wed, 27 Mar 2024 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711535627;
	bh=X4s13pQiIMlSxWNycUMvGwb++iXPjn4geNOGBsGcK/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RXm571xaFkDpoQNyMD2OrM6Ff4PbI5oyxwIrSn6rh6oTAuAVcMCggPEuRb2mgCuIv
	 bhNqVRdfaSUyuJvby8XWBnNTa24NpwoV4BQ7Kl1htTkkG04CA5T6Sh48JonEsQiZAV
	 RigkbGK1bm1IIn1DB6W7IR7SQvCU7ZAPGxvk6/snkBoZpw7bDCYNWSftJOtqL4kvAO
	 uY5qQehIIb8W9lLjLISE6w78aPCS+aa71c3stOnGl5bPsAnhmCgdSQXaUB9gTy4Aht
	 jUbAIeeoLZE88ztSmt7l2W/jANxPOnvJ/HtGEEMcM4bJV5bO7930qOpcKvwrFsfqsU
	 DOfbLOTRqk+Ow==
Date: Wed, 27 Mar 2024 11:33:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: tjackson9431@gmail.com, "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	kernel test robot <oliver.sang@intel.com>, Dave Chinner <david@fromorbit.com>, 
	Taylor Jackson <taylor.a.jackson@me.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] vfs/idmapped_mounts.c: Change mount_setattr expected
 output
Message-ID: <20240327-baubeginn-wahljahr-f4ee7484ec48@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326-mount-setattr-test-v1-2-c061b040d0f7@gmail.com>
 <20240326152228.GC6379@frogsfrogsfrogs>

On Tue, Mar 26, 2024 at 08:33:52PM +0000, Taylor Jackson via B4 Relay wrote:
> From: Taylor Jackson <tjackson9431@gmail.com>
> 
> In kernel commit dacfd001eaf2 (“fs/mnt_idmapping.c: Return -EINVAL
> when no map is written”), the behavior of mount_setattr changed to
> return EINVAL when attempting to create an idmapped mount when using
> a user namespace with no mappings. The following commit updates the test
> to expect no mount to be created in that case. And since no mount is created,
> this commit also removes the check for overflow IDs because it does not make
> sense to check for overflow IDs for a mount that was not created.
> 
> Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
> ---

Thanks for fixing this!
Reviewed-by: Christian Brauner <brauner@kernel.org>

>  src/vfs/idmapped-mounts.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index 34052ca3..f4dfc3f3 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -6667,7 +6667,7 @@ static int nested_userns(const struct vfstest_info *info)
>  	}
>  
>  	if (sys_mount_setattr(fd_open_tree_level4, "", AT_EMPTY_PATH,
> -			      &attr_level4, sizeof(attr_level4))) {
> +			      &attr_level4, sizeof(attr_level4)) != -1 || errno != EINVAL) {
>  		log_stderr("failure: sys_mount_setattr");
>  		goto out;
>  	}
> @@ -6706,11 +6706,6 @@ static int nested_userns(const struct vfstest_info *info)
>  			log_stderr("failure: check ownership %s", file);
>  			goto out;
>  		}
> -
> -		if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid)) {
> -			log_stderr("failure: check ownership %s", file);
> -			goto out;
> -		}
>  	}
>  
>  	/* Verify that ownership looks correct for callers in the first userns. */
> 
> -- 
> 2.34.1
> 
> 

On Tue, Mar 26, 2024 at 08:22:28AM -0700, Darrick J. Wong wrote:
> On Tue, Mar 26, 2024 at 12:43:27PM +0100, Christian Brauner wrote:
> > On Mon, Mar 25, 2024 at 09:58:09AM -0700, Darrick J. Wong wrote:
> > > On Tue, Feb 20, 2024 at 09:57:30AM +0100, Christian Brauner wrote:
> > > > On Mon, Feb 19, 2024 at 02:55:42PM +0800, kernel test robot wrote:
> > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > kernel test robot noticed "xfstests.generic.645.fail" on:
> > > > > 
> > > > > commit: b4291c7fd9e550b91b10c3d7787b9bf5be38de67 ("fs/mnt_idmapping.c: Return -EINVAL when no map is written")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > 
> > > > The test needs to be updated. We now explicitly fail when no map is
> > > > written.
> > > 
> > > Has there been any progress on updating generic/645?  6.9-rc1 is out,
> > > and Dave and I have both noticed this regressing.
> > 
> > Iirc, Taylor wanted to fix this but it seems that hasn't happened yet.
> > I'll ping again and if nothing's happened until tomorrow I'll send a
> > patch.
> 
> Ok, glad to hear that this is still on your radar.  Thank you for
> following up!

@Darrick, Taylor sent fixes for this now (I've took the liberty to
respond to both mails combined.).

