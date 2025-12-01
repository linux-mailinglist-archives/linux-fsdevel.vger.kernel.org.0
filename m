Return-Path: <linux-fsdevel+bounces-70344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD259C97CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1704F3A3F4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B0316918;
	Mon,  1 Dec 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="M40g/Cxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E83148B7;
	Mon,  1 Dec 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598547; cv=none; b=eFb+89Q6tY/OmV8Xp3Ddso5FkzHx0pmwr+a2MSf7TUQZURyhyv91k8mAMM4TlgFd9pvEaHoufiNlLY+9T77gwQpRtIWJfeL9rEBS27xM/xVPtBPAILQg8j7YSREBbJCwBReG89G1guAoiEQ22NMqEhUPx3PhElL9+Ih70D0/Jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598547; c=relaxed/simple;
	bh=5bkqED2iZm3oJVgdRYjWC52NM7LifEr+EgJDSqRuNSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2m4ffi7dYLvlsLPdKIziKmTmMeSG5sYHb+oI1OZWa6dk4PTlbv9Yh30P75yx9r8YkKWJC7cAiYODqZ476l2aTOSwCbiHnsfmaO+aPhJJ5pvjPL2PTCOLTbGx2gXIhJ+mqcD0EYFAQeLzzYVBVD+aod4Rlb2AmE3NY9RF4OK/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=M40g/Cxi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UKkMEEeq5wIHxFMoFZmC9r6K7bOvDszE+ByY4M6utnA=; b=M40g/CxiklgRVk7n6W54nQs7Bt
	SW74nXcHjMOOge/GfQj53dTGuj3xaomeAPFVB9OVTzqbgobYn4TDYVmy60Q3ONzWgTbiTNJVMXBRj
	o5OOpX2sK4nAEZA8+YxNMNvjTX5mtpsTAHPaGpI6ws0FCheXZYS8Cf7mVOiWDjHq+37YirabF7Bg4
	ceYFE1LUosE/FtaWRwfxB9+O1RM2jVVjni3zxCsXOoAgf7pfhUR0CFMLmCS4HvkeFc2Mt513fsaGZ
	EP5e+NxY7kQ5GU4dZ5z6y0N8W08D0hga1etud1C5KkuJJW5Yi/ASMMe7onNkXxXgEVMQjlM9r2EMI
	RUOj8LLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vQ4h2-00000000Tpe-1siX;
	Mon, 01 Dec 2025 14:15:56 +0000
Date: Mon, 1 Dec 2025 14:15:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 16/17 for v6.19] vfs fd prepare
Message-ID: <20251201141556.GG3538@ZenIV>
References: <20251128-vfs-v619-77cd88166806@brauner>
 <20251128-vfs-fd-prepare-v619-e23be0b7a0c5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-vfs-fd-prepare-v619-e23be0b7a0c5@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 28, 2025 at 05:48:27PM +0100, Christian Brauner wrote:
> Hey Linus,
> 
> /* Summary */
> Note: This work came late in the cycle but the series is quite nice and
> worth doing. It removes roughly double the code that it adds and
> eliminates a lot of convoluted cleanup logic across the kernel.
> 
> An alternative pull request (vfs-6.19-rc1.fd_prepare.fs) is available
> that contains only the more simple filesystem-focused conversions in
> case you'd like to pull something more conservative.
> 
> Note this branch also contains two reverts for the KVM FD_PREPARE()
> conversions as the KVM maintainers have indicated they would like to
> take those changes through the KVM tree in the next cycle. Also gets rid
> of a merge conflict. I chose a revert to not rebase the branch
> unnecessarily so close to the merge window.

Frankly, that hadn't gotten anywhere near enough exposure in -next and
it's far too large and invasive.  The same lack of exposure goes for
the alternative branch.

