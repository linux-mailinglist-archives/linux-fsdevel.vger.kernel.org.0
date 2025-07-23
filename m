Return-Path: <linux-fsdevel+bounces-55881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD1B0F76A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A81D164A4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E48158545;
	Wed, 23 Jul 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fG/bHtzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E42C2E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285714; cv=none; b=D4KeXyGBAgjiZzQ/wcR0JU1FUEhlAYhwGFHKbtQ+3R8xQRXNdt1W3slUU2e9gBoXhmRppKo/gCyuqTc48uY7i17AIMLzyLoGi1fbm/ces9414TficcvvUxPoc/MrQvXTopp+Lu090W6gLDH1IONE6J6MWqQrDqf/vQd+gpPsG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285714; c=relaxed/simple;
	bh=xvDnohRst9jTxcxtqBZAWtO6IMstmsvV1SLzegp73U8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=el6m8H1G3wrCF3ohNTsqSjoVHN3fxMYRuOkuU7EBXvClHTX7nRvuG7hgBhB4RyNUQU9GjVpxZAsoxDdcERQxt3CsxPbw+j5Rm1DMcV6Qz+75Kj+lP/yzfeg1x20P8cRV6gJtU1ne8f4MbPeHPl1lO5A8PEjk5np9xma+KOgCj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fG/bHtzv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Lc8Wk30j4AzzgduQRuWFImVnXGtnZNR1+AMC1anWRAo=; b=fG/bHtzv2YzqdOssR7mY+qRp5L
	N7G3RXPJZnK24XktsAPqzBQYNIcMFZj6/HomkRw6+lgc/+ASicuhHmUs1OZl0pl50L421VHm3pvbE
	T2nPZSd1leUrPWEuOHCkdEBfOuR46Br5HdxEATRDVU+d7G+R2yjHcDvbIEtdQSXc4IdmGRmJeFKpb
	LrGWUt1ZghInjCunTOSxPVZKg6COVFUXbOWFvQOMCn8cjXwtqXZPkcFaS0aiEukKrl2Grym3uSAeA
	fVx5zA9hohpLRjEP559YzIY4P1jzaSomYq1wuUJp6fFLYK6iuwNeN16SBNqZjFv9QUmSReMtnDEP8
	nRWo9f2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uebhl-0000000Bo5G-1B8f;
	Wed, 23 Jul 2025 15:48:29 +0000
Date: Wed, 23 Jul 2025 16:48:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] ufs regression fix
Message-ID: <20250723154829.GP2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs-fix

for you to fetch changes up to e09a335a819133c0a9d6799adcf6d51837a7da2d:

  fix the regression in ufs options parsing (2025-07-23 11:45:04 -0400)

----------------------------------------------------------------
regression in ufs options parsing

----------------------------------------------------------------
Al Viro (1):
      fix the regression in ufs options parsing

 fs/ufs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

