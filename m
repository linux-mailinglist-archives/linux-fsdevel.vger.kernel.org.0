Return-Path: <linux-fsdevel+bounces-56070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 260ABB129BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418FC1C2183C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A420E033;
	Sat, 26 Jul 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Syahuuzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B04194C96
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517337; cv=none; b=YOLHczMHa23dRiT3VwQnLfpDKQ1WPpYWLTuDOSE8MKs9cKs9GKeTCldXfzeJzcVJELXhKRZvuEwVnmdagc7/HUeUs7BI7mUyG6xKFCqGd6mVMdeWA1XPV7GrJISu/OsGy2wSCy/GsvUPjKSVqWtBa1lIaJcA6lvyw4cq/kiABaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517337; c=relaxed/simple;
	bh=PiQSTWRGlhwhuXCHmkxNs48Re4eANRKcA7GWwzaiSBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI+TzBXjaVrHPASKd24Njiz/7kTy5jgSsup7XKCSVmOsVEV3j3tIhHtKizSj0zPxgaBO0meS+qcpk8IlhHzP7kiwfcCTBx9OzCJCr/jfgWR/tGQpJ0jasJSEkbV1xIS5Ml1B7cTpy0w2F0FmPG4n4z1zffjOwj0YFKG9IG0aAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Syahuuzq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EkiC2HBYHvlLz6qLkTUsVksijib7tBhQybqA9Uz3qrU=; b=Syahuuzqli3XiEN+SfstwG5Jzn
	zzWuqyHt5svhLXdq3o2+yPUFM8Lv2Eyjw8SSWnS7VbFEZ79B1CJKMfN2ApOFKVlNcVp75u0TnsyeI
	43PM6qoQi164+5Zw8+PK2iMnR64jiScaPMIf+TTOeYGgtjSVthRkc6cTGX0y7AHe6DdbTcp+3Wh+c
	ziE7z81qFRdqx/fEeqyt8ah4iiiVMwYPH1SQXNo6gkEmrCcrEJSKxLJ9jAgySu51cwpj+FP1zsg11
	K2I4N/hvoaR+IE5wOD/iZoWTkkCtWo6YE4wvtoMvbSDATlyYwLTWurpjpNwbzSrl4GsiDCFBeldwB
	NM87wHBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZxd-00000006A5x-1oLb;
	Sat, 26 Jul 2025 08:08:53 +0000
Date: Sat, 26 Jul 2025 09:08:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 8/9: CLASS(fd) followup
Message-ID: <20250726080853.GG1456602@ZenIV>
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

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd

for you to fetch changes up to ce23f29e7dfb5320c9e32edb5f4737ad4b732abb:

  mshv_eventfd: convert to CLASS(fd) (2025-07-16 01:45:06 -0400)

----------------------------------------------------------------
A missing bit of 66635b077624 ("assorted variants of irqfd setup:
convert to CLASS(fd)") a year ago - mshv_eventfd would've been
covered by that, but it had forked slightly before that series
and got merged into mainline later.

----------------------------------------------------------------
Al Viro (1):
      mshv_eventfd: convert to CLASS(fd)

 drivers/hv/mshv_eventfd.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

