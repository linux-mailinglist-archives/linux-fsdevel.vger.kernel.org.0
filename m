Return-Path: <linux-fsdevel+bounces-56069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83CAB129BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40BB4E3321
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148121322F;
	Sat, 26 Jul 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XDo5EKIL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AF78F4C;
	Sat, 26 Jul 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517288; cv=none; b=STORqDKw02q85BrHB0NTO4Shm3T8NLDi1UOrgUdPp84fqkFw57gblDAzl4eUDRf87DGYe/o79Z5oKaLpG563vXy/8AVH//IYqQ5YoBqxBZ5e6353t8Cxuzq5cH4vHKcOxRY6Dt+taJw4vyZuyATb7zH+n1CjBovAtW7Nv/5IGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517288; c=relaxed/simple;
	bh=PIME5krYw/4wF0yEsLfgsRKVMgxPXM9zQyhJIyzEHdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpl7PkjBdVR8lWUHJXg+N2UcJCD9FeunMTj2/WKdy72igjssH7AAuFkYrM9m9wSV+pBQVBaxGBH73KBVgylcrBOpOhSBes/K9PQyPpQHt38ba32aQPAtkz6BVDZTl7iQLwkOmxOB6yS9zr6fLnPm422/Yo5MdGKDfqK22bLQJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XDo5EKIL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kLbJ+qa/ClK46vQiE5cu2nwPz1qsNq4U7we8ArGeAjM=; b=XDo5EKILGiL+1hmeK+0GezWRs3
	M5t/gYXHhiGpJnOkOvb/yl/JUtW3+PG2w/KwY8Z4HPwXTbS2Ty33t90SoN6BAYTiqm4pwMCCesU9+
	0OXT5ydX1Zx2im3CikS5VFBZqkqtlzE7akMZ1M9aa4qMGhxkDVfyyBa7HDgnOzgr1oWZNDEtGMtrd
	JwoFVrOjuISMPxLwkbdAcFleS/n1D/QdWdj5c8oQGHIRsupykh6yjHDcRJ8mFxCACNxrIv3OAI5WK
	5eVLEu+GpyStqkipqN/PNIYX58t1BfIeVrUUnrS8LhaAMGG66K1Vpje9WgMadxRrNO24ZAvjTA4pU
	5LtAOenA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZwr-000000069lg-1Eak;
	Sat, 26 Jul 2025 08:08:05 +0000
Date: Sat, 26 Jul 2025 09:08:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	ceph-devel@vger.kernel.org
Subject: [git pull][6.17] vfs.git 7/9: ceph d_name fixes
Message-ID: <20250726080805.GF1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726080119.GA222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

stuff that had fallen through the cracks back in February; ceph folks tested
that pile and said they prefer to have it go through my tree...

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ceph-d_name-fixes

for you to fetch changes up to 0d2da2561bdeb459b6c540c2417a15c1f8732e6a:

  ceph: fix a race with rename() in ceph_mdsc_build_path() (2025-06-17 17:58:14 -0400)

----------------------------------------------------------------
ceph ->d_name race fixes

----------------------------------------------------------------
Al Viro (3):
      [ceph] parse_longname(): strrchr() expects NUL-terminated string
      prep for ceph_encode_encrypted_fname() fixes
      ceph: fix a race with rename() in ceph_mdsc_build_path()

 fs/ceph/caps.c       | 18 +++++-------
 fs/ceph/crypto.c     | 82 +++++++++++++++++-----------------------------------
 fs/ceph/crypto.h     | 18 +++---------
 fs/ceph/dir.c        |  7 ++---
 fs/ceph/mds_client.c |  4 +--
 5 files changed, 43 insertions(+), 86 deletions(-)

