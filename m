Return-Path: <linux-fsdevel+bounces-72685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0ACFFAC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC83A300348A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5013346B6;
	Wed,  7 Jan 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEs5GvaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC6333739;
	Wed,  7 Jan 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813323; cv=none; b=YGuS77sIso2//F26hlVox2OQecnt7iqBn/SYWQs2qgnt9fV/hbt4CTVCe3miKc4wALtbxiP6NFfQr5y3d6bjn7CjI0L8R020iWWqJX63EJj4Rja0cQfCNJfrAatsczGPXZ+mnO3FGag6odJMjEBcWEG6gHaXu0xd1hC5hl1UCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813323; c=relaxed/simple;
	bh=ro/sHUYBJM1i3qOo2/9jGtrlvTjEiOY7KJf7BqWu+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsagimnyyxNfTDE8zzPky4Jhh3aQYloEhIU8YnvRivXtghUqZibLbTwCMdLluz6KbvOLi5GuJyIVoNp4QeqaLdcvvYT5ikprT03qt83J+LRKew0BliMVORrwOdhEMDEILBHa36ConyWhl69qZQ/mmKbmKzq8ChagBEHttHsGEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEs5GvaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73EDC4CEF1;
	Wed,  7 Jan 2026 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767813323;
	bh=ro/sHUYBJM1i3qOo2/9jGtrlvTjEiOY7KJf7BqWu+ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEs5GvaYTuDDMmqsJzkJ8IwX1uAt+hDUNlchmchjtxw++78BlH5XEeypv+XNubKaU
	 zcBeER7L045UCpU7TZoblb9Rh0sWpwc5TAYiFSqEATcJmmZ2ehwbQ9ODiyfynETcEH
	 8qptve8StyEF/VxIe4O6KW+1IwVZswZJRp+Dw+Em4VdQo2GuRHwOIAbXBsJjMCzQpR
	 uXxRo7s6EK8Zx/I3aVkShQ/OoMcHLtAQD5Dbsk8QNEBv2yuFbRAoDauWPgVnTGkPxq
	 s+DDFhT93grRz3Jt+R+Ju/F24p0pL2H7V/qRvD8rCVVkP3h/1cdOekrRdD40MdwxiV
	 ZFqpoKl1uxyXQ==
Date: Wed, 7 Jan 2026 11:15:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/11] docs: discuss autonomous self healing in the xfs
 online repair design doc
Message-ID: <20260107191522.GG15551@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
 <176766637268.774337.4525804382445415752.stgit@frogsfrogsfrogs>
 <20260107090844.GA22838@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107090844.GA22838@lst.de>

On Wed, Jan 07, 2026 at 10:08:44AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 05, 2026 at 11:10:52PM -0800, Darrick J. Wong wrote:
> > +The filesystem must therefore create event objects in response to stimuli
> > +(metadata corruption, file I/O errors, etc.) and dispatch these events to
> > +downstream consumers.
> > +Downstream consumers that are in the kernel itself are easy to implement with
> > +the ``xfs_hooks`` infrastructure created for other parts of online repair; these
> > +are basically indirect function calls.
> 
> These hooks mostly went away, didn't they?

They completely went away now that there's only one possible healer
instance per mount and direct function calls.  I'll delete the sentence.

> > +Being private gives the kernel and ``xfs_healer`` the flexibility to change
> > +or update the event format in the future without worrying about backwards
> > +compatibility.
> 
> I think that ship has sailed once the ABI is out in the wild.

Yeah.  Once that's happened, the strongest argument is that we can
define our own formats without being subject to any of fsnotify's event
size constraints, and (more importantly) not needing to clutter up
fanotify's UABI with xfs-specific structures.  How about:

"Using a pseudofile gives the kernel and xfs_healer the flexibility to
expose xfs-specific filesystem details without cluttering up fanotify's
userspace ABI.
Normal userspace programs are not expected to subscribe to these events."

> This whole why not use XYZ discussion seems vaguely interesting for a
> commit log, but does it belong into the main documentation?

That's an interesting philosophical question that Allison brought up
during review of this same document years ago.  I chose to leave these
Q&A's about the road not travelled in the doc because people keep
bringing then up, and I think it's useful to present that.

I left them as a separate Q&A sidebar to make it a little more obvious
that it's a sidebar.

> > +*Answer*: Yes.
> > +fanotify is much more careful about filtering out events to processes that
> > +aren't running with privileges.
> > +These processes should have a means to receive simple notifications about
> > +file errors.
> > +However, this will require coordination between fanotify, ext4, and XFS, and
> > +is (for now) outside the scope of this project.
> 
> Didn't this already get merged by Christian, and thus this information
> is stale already?

I'm not sure.  brauner said he merged it, but I haven't seen it show up
in vfs.all or anywhere else in vfs.git.  I asked him about the status
yesterday:

https://lore.kernel.org/linux-fsdevel/176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs/T/#mb00d485a7a146529c1bb022217d56ead50811162

but have not yet received a reply.

> > +When a filesystem mounts, the Linux kernel initiates a uevent describing the
> > +mount and the path to the data device.
> 
> This also isn't true anymore, is it?

Oh yes very much not true anymore.

"When a filesystem is mounted, the kernel initiates a fsnotify event
describing the mount point and path to the data device.
A separate systemd service will listen for these mount events via
fanotify, and can start a mount-specific xfs_healer service instance."

--D

