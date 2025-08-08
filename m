Return-Path: <linux-fsdevel+bounces-57073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03830B1E8A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230B85847D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF72927A462;
	Fri,  8 Aug 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZJA+da/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85D2741D1;
	Fri,  8 Aug 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657633; cv=none; b=N0AeJToqZptO6TDD50VQqHCI+azN6moP/uUiH9+HvJd715ANvv+8s4rkpquBq7D93ESfuKlSsrhlJ8/O1dHaMU+zwW/Lwbos+UzUp4c9QMBC8sbpvnuV7NvdtRacCLHHWfyX5OV36/8qFdD1J7RB3RRPdoAu0iWp4gMe5dB9q/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657633; c=relaxed/simple;
	bh=WO0FlIg08o2IBcu84U1zzhJzmGWtJMLC/tfR01CGWgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqdRF1IL4zIqWmgv9RPWk/nioQ7unfq8p3jSLqQAaqhX2B1Zt9AW4FvvwxCrO7HP/0yS03W8W9/CGW+G+avOVukyt7O2INIsSTXJHSO7r0gD2LHl3osQtepVPbhcG96s0tKdvXBQKJn59q6lGR6DlAlHFHkDSJIdTcIVPB1mVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZJA+da/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED05DC4CEED;
	Fri,  8 Aug 2025 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754657632;
	bh=WO0FlIg08o2IBcu84U1zzhJzmGWtJMLC/tfR01CGWgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZJA+da/or8+8WnNHkh/ZuV8Wbvk9tMOD5fjr7paCaCgKZb/SYhmxJ/LcHV7vepod
	 nwP27zcd91Kgc2A0MdBrdemHxihCfA1qY2hgJlW0gV2uvOSK98MBOKDsaxREK/rzoO
	 guUrcoWMbK8P6kXFcISRCFl3Mc7bEnxC1kk+D96PL8IuInGL3m21d02a98450HmJBm
	 VYq8haJW2qKylZAQXVErITKRAgr6D/eYgYJKBZcNaEZnTs+8p1C32iPzNZv/QdAaMu
	 J3iM9vZ5SpBuQu3ogFym1Af1NtHiB7Hjxtuy36avQHsQGPj1jcUiu7gxtvsP0cL+om
	 4Jt5hrgY/lvOQ==
Date: Fri, 8 Aug 2025 14:53:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 00/11] man2: add man pages for 'new' mount API
Message-ID: <20250808-funkanstalt-erdrutsch-64a05ea8a737@brauner>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>

On Thu, Aug 07, 2025 at 03:44:34AM +1000, Aleksa Sarai wrote:
> Back in 2019, the new mount API was merged into mainline[1]. David Howells
> then set about writing man pages for these new APIs, and sent some
> patches back in 2020[2]. Unfortunately, these patches were never merged,
> which meant that these APIs were practically undocumented for many
> years -- arguably this may have been a contributing factor to the
> relatively slow adoption of these new (far better) APIs. I have often
> discovered that many folks are unaware of the read(2)-based message
> retrieval interface provided by filesystem context file descriptors.
> 
> In 2024, Christian Brauner set aside some time to provide some
> documentation of these new APIs and so adapted David Howell's original
> man pages into the easier-to-edit Markdown format and published them on
> GitHub[3]. These have been maintained since, including updated
> information on new features added since David Howells's 2020 draft pages
> (such as MOVE_MOUNT_BENEATH).
> 
> While this was a welcome improvement to the previous status quo (that
> had lasted over 6 years), speaking personally my experience is that not
> having access to these man pages from the terminal has been a fairly
> common painpoint.
> 
> So, this is a modern version of the man pages for these APIs, in the hopes
> that we can finally (7 years later) get proper documentation for these
> APIs in the man-pages project.
> 
> One important thing to note is that most of these were re-written by me,
> with very minimal copying from the versions available from Christian[2].
> The reasons for this are two-fold:
> 
>  * Both Howells's original version and Christian's maintained versions
>    contain crucial mistakes that I have been bitten by in the past (the

"Lies, damned lies, and statistics."

>    most obvious being that all of these APIs were merged in Linux 5.2,
>    but the man pages all claim they were merged in different versions.)
> 
>  * As the man pages appear to have been written from Howells's
>    perspective while implementing them, some of the wording is a little
>    too tied to the implementation (or appears to describe features that
>    don't really exist in the merged versions of these APIs).
> 
> I decided that the best way to resolve these issues is to rewrite them
> from the perspective of an actual user of these APIs (me), and check
> that we do not repeat the mistakes I found in the originals.
> 
> I have also done my best to resolve the issues raised by Michael Kerrisk
> on the original patchset sent by Howells[1].
> 
> In addition, I have also included a man page for open_tree_attr(2) (as a
> subsection of the new open_tree(2) man page), which was merged in Linux
> 6.15.
> 
> [1]: https://lore.kernel.org/all/20190507204921.GL23075@ZenIV.linux.org.uk/
> [2]: https://lore.kernel.org/linux-man/159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk/
> [3]: https://github.com/brauner/man-pages-md
> 
> Co-developed-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---

Thanks for doing this! Just a point of order. If you add CdB you also
need to add SoB for all of them.

