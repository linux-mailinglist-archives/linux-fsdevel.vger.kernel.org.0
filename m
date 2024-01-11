Return-Path: <linux-fsdevel+bounces-7785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29C82ABBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35761F21D40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227B14283;
	Thu, 11 Jan 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pO5cxANf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFE114267
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gI7bJxgh/he6YNaO7FlM05wn9SHwZsQeLa6sYvlBEVc=; b=pO5cxANfUMK7I7cP80Wk6sZ6eP
	6mZfriknvCXEMtLvgjDjplgZW6wJS3dzLxdcgYEN32Bt/n4EQq63Zg3wYUsInzExmGlyxXlUCh2pG
	N7Cw8n4zPF3xDk1rGmVL9yf8TbXYG2TpkbK/tq97uuhKXzJhombll9l1t+Bn+6mi3zE75OrFj0kdz
	ytfWZToOQEBPkOgvuD/YH1YZNQhPzI1C+oR0imryYWEhwO7XKIGlQ0wJkWvI4MGkiZzTSOGugGGN1
	K+b+fkA6KWP4Vps5rA4QPp7VhV+AiWCJHUSOmDQJb2TqAHz7U9Vu7aLmef4w+HVn7eZN2bwLWddyM
	nC4kq8pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNs70-00CA1u-2U;
	Thu, 11 Jan 2024 10:16:35 +0000
Date: Thu, 11 Jan 2024 10:16:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git minixfs series
Message-ID: <20240111101634.GV1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-minix

for you to fetch changes up to 41e9a7faff514fcb2d4396b0ffde30386a153c7f:

  minixfs: switch to kmap_local_page() (2023-12-18 21:07:29 -0500)

----------------------------------------------------------------
minixfs kmap_local_page() switchover and related fixes - very similar to sysv series.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (4):
      minixfs: use offset_in_page()
      minixfs: change the signature of dir_get_page()
      minixfs: Use dir_put_page() in minix_unlink() and minix_rename()
      minixfs: switch to kmap_local_page()

 fs/minix/dir.c   | 83 +++++++++++++++++++++++---------------------------------
 fs/minix/namei.c | 12 +++-----
 2 files changed, 38 insertions(+), 57 deletions(-)

