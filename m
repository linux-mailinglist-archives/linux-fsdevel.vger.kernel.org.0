Return-Path: <linux-fsdevel+bounces-72357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B8CCF0B8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5628D301585A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CC2EBB8D;
	Sun,  4 Jan 2026 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XjoiHcCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899282C324E
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767511598; cv=none; b=icqfJOwe41xWLhL9e3gUQyjHVJhlz+1yfFZz9KEpbA0SXILcJeavU+yuAcE1heb7v2aUtaljXlViNmDrnpjRXJk8PCwVub5URrQ+NBLvjW39eAptWab6iHpsp77bFHmTasf+TV4yuycVfxlFyVI9RVXo2efrycbgqNhLqjM5YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767511598; c=relaxed/simple;
	bh=797pTPzFk1t2Gv04Y+BzHfCUzEyt4TMA29+yJRF1E9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg4+E1Ux0w2jsGMwSjD4+G7Ja9B61UC+7fb3Voa4xNWLl0135Kg11mTl4QeJQOx+hIfEVNsYFrw0Ddq7Hbl8LSYdJb51jqWBca9jDI9cvq5xrxrqRz9rd8kGVudrXdWOrvebaef4HM56zNzldelfsRZb++c6Rz1u+Hgo02fSGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XjoiHcCj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1WGKsRjnjJIxmU15OdEy7I0waZHIklv2O6BiIKzoX6k=; b=XjoiHcCjgSJKh+ztywqf5Pwvoq
	usdXTJffppBWHCpGWhciCP50Ub+ITUrzGmPfnskhkk99vdx0yXurKRgGO43Tqo1XaMEdM12kbwCKL
	QYNEva+75FbS2RY+IfzWSPjViR9U4b72+wv4oRHlTohxITV/Eedg3AYfhvIGhPHBxyIctcDWNwxOm
	SEhT6rGCb1FnYrOTi5i9uDREB0H710XP+TCzkMmz8rzHqsh3PZtymmXfEVqtdgd1gl3MUmIN3pa/N
	diumzJUk8qX+7ixhOxYPpyuYErHon1oFUDHDexrdx1/2LhC1PZQLlskRKLAoOa17qrTOZ6dLni6sC
	K7xT9JSQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vcIWd-0000000Cw8W-10SF;
	Sun, 04 Jan 2026 07:27:43 +0000
Date: Sun, 4 Jan 2026 07:27:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260104072743.GI1712166@ZenIV>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 02, 2026 at 03:36:24PM +0100, Christian Brauner wrote:

> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> +#include <linux/fs/super_types.h>
> +#include <linux/fs_context.h>
> +#include <linux/magic.h>

[snip]

What does it give you compared to an empty ramfs?  Or tmpfs, for that
matter...

Why bother with a separate fs type?

