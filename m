Return-Path: <linux-fsdevel+bounces-56066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2737B129B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265D0174777
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C2F202F87;
	Sat, 26 Jul 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Iz4gBcMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123E78F4C
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517065; cv=none; b=HbHTTV85gJlmHHx20VMgLPDB055j5aLiw/69yln35HzxHFFAxECNLGpka85m4YRamxENcFSohJNo6Pc/4zrKseEaCCtpyt1/6xDk8nYlZ3VWysbA2wQLwJhHaBHt7PCvF538OCCJzhJ7xfW+rNiRpB7goiS+B527Is7VaJuYyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517065; c=relaxed/simple;
	bh=/Q9+bFP/TYlwai/GkAxTF6FKJaNs4+mIFtj5n9k1YlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbJ5lCT/EPsuzh1aiBUpqTgoh8mur9pXRYxU1EJPrY3xqUKE9zK8Kz7+3g7hElG2K2CADNZrpibzwOrQ1R56Xu08YUQ5apNk1344gMQ1DfgoTxmp5TpIBTfSnGsYDodPxssxBKDz4yPpjs7AoV7lghDt9OBdRBjWLtBXs2PR7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Iz4gBcMs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xhr4Sbp30tWXfWbSyJ28YRaOoD8CuIC9WBI9Ww1OUZw=; b=Iz4gBcMs/u2T6Xy2w7ldGpEmBe
	HGP2wuc/NLS3rg1p7uopIgMX5wIG1tGWrr/O6lkApCbjH2I7jOYA8DNDuN+Zh9sTzQGM915rJP8D7
	T5UpqvUFDW5HiestKmyR5yXg4TSDkaSEQt5fUlSJZrDsFCb6IiPKV0oQVKAGdhggNKi6q98CPQG87
	a0vLCCTOPWQqe9S8yMZdj2gvuQbXSMK9A+sQk4CibCRx/SR65yaLPvZ5IGzaam5IdPXolKrhh6nHD
	Pcngn2/qoW5CIf7AB4DEpTtDVdwAWwMIgzQoE997b3HNbL/mRWhN6EjFKeKI2uOn9KdHNBKa4qv8p
	hjzAjOdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZtG-0000000688h-0dm8;
	Sat, 26 Jul 2025 08:04:22 +0000
Date: Sat, 26 Jul 2025 09:04:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 4/9: asm/param.h pile
Message-ID: <20250726080422.GC1456602@ZenIV>
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

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-headers_param

for you to fetch changes up to 2560014ec150fd41b969ea6bcf8a985ae910eea5:

  loongarch, um, xtensa: get rid of generated arch/$ARCH/include/asm/param.h (2025-06-24 22:02:05 -0400)

----------------------------------------------------------------
This series massages asm/param.h to simpler and more uniform shape.
By the end of it,
	* all arch/*/include/uapi/asm/param.h are either generated includes
of <asm-generic/param.h> or a #define or two followed by such include.
	* no arch/*/include/asm/param.h anywhere, generated or not.
	* include <asm/param.h> resolves to arch/*/include/uapi/asm/param.h
of the architecture in question (or that of host in case of uml).
	* include/asm-generic/param.h pulls uapi/asm-generic/param.h and
deals with USER_HZ, CLOCKS_PER_SEC and with HZ redefinition after that.

----------------------------------------------------------------
Al Viro (3):
      xtensa: get rid uapi/asm/param.h
      alpha: regularize the situation with asm/param.h
      loongarch, um, xtensa: get rid of generated arch/$ARCH/include/asm/param.h

 arch/alpha/include/asm/param.h       | 12 ------------
 arch/alpha/include/uapi/asm/param.h  |  9 ++-------
 arch/loongarch/include/asm/Kbuild    |  1 -
 arch/um/include/asm/Kbuild           |  1 -
 arch/xtensa/include/asm/Kbuild       |  1 -
 arch/xtensa/include/uapi/asm/param.h | 31 -------------------------------
 include/asm-generic/param.h          |  2 +-
 include/uapi/asm-generic/param.h     |  6 +++++-
 8 files changed, 8 insertions(+), 55 deletions(-)
 delete mode 100644 arch/alpha/include/asm/param.h
 delete mode 100644 arch/xtensa/include/uapi/asm/param.h

