Return-Path: <linux-fsdevel+bounces-34948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B449CF053
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BE11F21779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC61D63E4;
	Fri, 15 Nov 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CStJzX+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999122F29;
	Fri, 15 Nov 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684828; cv=none; b=TgR5k2GpHmvI3M9j7v7NZJV/nPq46h7gv1Ebw8XbYfxm10hgHBcKwkiXvnXVcxdcRLefWepHR9BUwxeYsO4kccXHDch+u5n/OoezK5VgghbSFNsjNmY2W+Zxa+yYifggJq1HnYeNSOkAfOUS2SVp0/JjfPviZRhoAJHduxLHTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684828; c=relaxed/simple;
	bh=d3uiVFYx3m8r0B6flSHG29OsMvg0vLoafh9S9+Y73Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmJ6/UV4I4YMQmmib399n/1fKqZRke0yxIV1BkSbjrnk5bq5RhEXzDnNr98YyVhoJvgWwCSdhoS2Lr8O1YKql4VVyK5hQOsp4Z+2He8AeOip/2s5jK9h7k9ZoYVqDJDMS8IeH2ipdw2IjUrOozJ4NzcvWA/ywxRAD3v+1Q4Bq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CStJzX+V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B1p5JL43cnPVBV+ok8aJV0hVLCiRMNflrQ15q9XZ8Ls=; b=CStJzX+V7lWhyn1/i7InSqPDvl
	hmzAOs7SEcw3kS6ZleOS95VI91URTV6mCVe12fj1MEfZG7ztIbc2ztB5z1hzbACgYdybRuxX+CFXj
	6jndPcml3/gwpS+gzHElVOF22MfCadlsV9WD8klug9iZlvbiONbgZzxuYvf4E2TeEwQOnwGeyo3X4
	4TDUs6oaagTP4stJTORZBKzMe49qmW9gNvWqTFDeh7xj688iDxzgu/qxPUswZFRcbY/6rmckiqrFj
	lnnA9FTzfAqVY+bOfFfLm4WifMS2Z8ViozJbWARwxJiN7zDZ6BWxaH+RahwyuW8CmL7UqDWOdytzK
	/o4dQxHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tByKO-0000000FTzI-2TNx;
	Fri, 15 Nov 2024 15:33:44 +0000
Date: Fri, 15 Nov 2024 15:33:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] xattr stuff
Message-ID: <20241115153344.GW3387508@ZenIV>
References: <20241115150806.GU3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115150806.GU3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 15, 2024 at 03:08:06PM +0000, Al Viro wrote:

[snip]

> Al Viro (9):
>       teach filename_lookup() to treat NULL filename as ""
>       getname_maybe_null() - the third variant of pathname copy-in

PS: there's one more pile in -next (statx stuff), but it shares the
first two commits with this branch, so I'll probably send a pull request
once this one gets merged, if that's OK by you.

