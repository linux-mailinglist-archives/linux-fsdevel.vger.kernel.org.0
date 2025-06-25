Return-Path: <linux-fsdevel+bounces-52849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F337AE790F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1443D1BC4E70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75447209F38;
	Wed, 25 Jun 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJibZHwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0B22083;
	Wed, 25 Jun 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837937; cv=none; b=atV+Zscos/BEMPdxdV1Ts2pRiU2BWh68E0wm9YqGlWxQSqhwV77HSrNGoz+gvXOmg3Lww2oPIrrawpNrQEoR2loylsA1wrpNstZjkYeRUcOnB7mfqMHe6QJzsWFVii6At9ZY9J7s+eyQkAWraYbdL+AKmeQv1uckP/SGGX0boSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837937; c=relaxed/simple;
	bh=4REwJ0qTYWr/emujGc6w8gWG9fvUVadsnMPID2MW69k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oko/5lilUddGzzJqPMJKe6XoTuRQKXys9wWi1tEMM7jTbWhV8Z5w1uwnFuYpUrDvDYKTh4zcp3c2NVajHpdBGgjTQWjk7JD5oK7TPvZzksUvAYzTyi8KmRa9OgcZgSVXvLWXsZe2oZEg7qVpiIxQ1H86MgbVgdZfVlv3GF7swdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJibZHwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765C0C4CEF1;
	Wed, 25 Jun 2025 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837936;
	bh=4REwJ0qTYWr/emujGc6w8gWG9fvUVadsnMPID2MW69k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJibZHwXM0lqSv/BhZ1sVZNCUgNANwiY4kbtUtBGwuM/V8DzGIrd42YPklC1dX9G9
	 1Q21dboRtPjtG1PhwefbRYn+fTn1itmD0AiaN6nkK+pdN+PD+HfltlrNC8dbWu6c20
	 i4aW2LUo8VqsDm+0g59WkWxoMXy8WbEOQyu9mQ7wcchtJvwJI4ECSGuEaJ8fDiMwln
	 HvbnDwL1Zh2F1n1yYRHXi+g9j2C9nV/hUVo8w2OT5qRAaYbz++90QSNO7gLJBKpyyI
	 w/NY3WUqB/iD1osTpHVOa1AkstpzgXKIEW35jxQ+TUCSkHXR+H2d5Yn7VeYpv1bOWN
	 1cRegohsr5peg==
Date: Wed, 25 Jun 2025 09:52:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <20250625-undifferenziert-mitnahm-fb5e9550acdd@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <20250624230745.GO1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624230745.GO1880847@ZenIV>

On Wed, Jun 25, 2025 at 12:07:45AM +0100, Al Viro wrote:
> On Tue, Jun 24, 2025 at 10:29:13AM +0200, Christian Brauner wrote:
> > Various filesystems such as pidfs (and likely drm in the future) have a
> > use-case to support opening files purely based on the handle without
> > having to require a file descriptor to another object. That's especially
> > the case for filesystems that don't do any lookup whatsoever and there's
> > zero relationship between the objects. Such filesystems are also
> > singletons that stay around for the lifetime of the system meaning that
> > they can be uniquely identified and accessed purely based on the file
> > handle type. Enable that so that userspace doesn't have to allocate an
> > object needlessly especially if they can't do that for whatever reason.
> 
> Whoa...  Two notes:
> 	1) you really want to make sure that no _directories_ on those
> filesystems are decodable.

No directories exist on any of the obvious candidates (certainly not
pidfs) and it's easy to add an assertion there. It's obvioulsy only
going to work for specific filesystems.

> 	2) do you want to get the damn things bound somewhere?

For the obvious cases either bind-mounts aren't supported or having a
bind-mount would not constitute a problem. For starter pidfds can be
created purely based on pidfd_open() which means you can always open a
pidfd for process even if the bind-mount in question would not be
accessible to you.

Are there other concerns about bind-mounts that I'm missing?

