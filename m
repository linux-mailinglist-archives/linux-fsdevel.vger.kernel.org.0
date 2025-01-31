Return-Path: <linux-fsdevel+bounces-40476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0AA23A8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737C718887AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D515C15F;
	Fri, 31 Jan 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N15vyaVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19158632;
	Fri, 31 Jan 2025 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738311882; cv=none; b=oQwlrhz6ylAkwWf0RrfNovrQ94Ef3oNREkJWz7N38IPyLywyL/nefSYSpwMpuqUo4RN1SADivAste3GXs2oJYyNeINUt6k86pILzmI04fSGNEYHVp4faZPqaeD/8nwJSYKJKzOv6gV8uFMMCcNTESQWVardIOKv32rjVMI5tP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738311882; c=relaxed/simple;
	bh=0jINTffwp3wlAAmtPei/UpSuvbGNllu4KSmk9I8rEso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XiTvY3zDy1YHsogo5B1VlDqB0l5e6NwjLBlHVln5h0Bx40eRPVI4t9cV/xFbQlVWxYUQYzZOf+BjNvHHj7Zn2jJDUW5Vfc8tQ1Ie/uU8yDHgCMOmd5GU4/QLvGW2yZPnjTv/qvRNAVYT/Sp2SP4mQ7JahUB9QE0XxU3Jsz2AgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N15vyaVE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PghRV3G2nYG3tltp0NImxhGt1QpkqEf7Rsmzl10Sh1w=; b=N15vyaVEYAZg+XXMp1kQkgdguF
	TpPpkVA5ex5aFQbLkBPf0w/M2uhPvnkIPtmxrxn51YWJiTcMwqrDQ2tD/VvUazmCJCXbQJyvI7QKE
	FSOv4yF/Ys8f872UGThwDH0PB1G/0PW2dDj4AKmyAZPu26Nrjj/M/KGyO3t6nzu2o61GAqeiFaM7z
	Pnap+fuNP73lWvAhDefnQUHADFzThIL137/kpZBVsg2ZBv+ukp++DZJuHNUYYBD+y7JeYGC1DcTPU
	iemXsADNSDrvDyINpANQKZl60cdA3LM1raD7zcZ1MRPiaXwr8Jf1cEI+Jj+rJsBrlEH9CXNSTy8K0
	pHyRvPBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmKL-0000000Gloi-32BI;
	Fri, 31 Jan 2025 08:24:37 +0000
Date: Fri, 31 Jan 2025 08:24:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] hostfs fix
Message-ID: <20250131082437.GW1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 60a6002432448bb3f291d80768ae98d62efc9c77:

  hostfs: fix string handling in __dentry_name() (2025-01-11 01:37:44 -0500)

----------------------------------------------------------------
hostfs __dentry_name() fix

use of strcpy() with overlapping source and destination is a UB;
original loop hadn't been.  More to the point, the whole thing
is much easier done with memcpy() + memmove().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      hostfs: fix string handling in __dentry_name()

 fs/hostfs/hostfs_kern.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

