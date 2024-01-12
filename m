Return-Path: <linux-fsdevel+bounces-7856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BBF82BBBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 08:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE311F267DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCF5C90F;
	Fri, 12 Jan 2024 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HEm7rViX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9C381B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BDmGBhvOF3dh6Ktxs2Djsw69tw84FrCD5zr2+b2cR8I=; b=HEm7rViXlcYWCqCH2y1bOKfv+S
	ohBMiNlVa5jYXFSbR3/0WdkEXaAv43+JICYRm1txljNDlMBbS1rhHnuti3DJYkAzFAM1HDVSSFtJA
	YEoC38TQmlDe00S2GwDX9VNlY/tW8XDIX0ZWqCfrP9NJDCMX6PO3FDoTAvAPY8sOYnhXu4E8j2IfC
	owVtZSdYc0H85a+M0jcSRaf8EItiTnyWq/Jb1aMV8nNkXv0dGgm8ix9b/6D1UHUckepA+L9plMQiN
	FmeJ2BbpXKpGYPiWXPjoXIcQx9dqxLXHOmszMQOvOCU5VE+8puNT2xz2C5+xzURxMKxi6J8phsQs2
	OU6uyw1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rOBv7-00E6ly-2W;
	Fri, 12 Jan 2024 07:25:37 +0000
Date: Fri, 12 Jan 2024 07:25:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] more simple_recursive_removal() conversions
Message-ID: <20240112072537.GB1674809@ZenIV>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-simple_recursive_removal

for you to fetch changes up to 88388cb0c9b0c4cc337e4241fe6f905c89bd7acf:

  nfsctl: switch to simple_recursive_removal() (2023-12-20 20:45:57 -0500)

----------------------------------------------------------------
more simple_recursive_removal() conversions

nfsctl this time...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      nfsctl: switch to simple_recursive_removal()

 fs/nfsd/nfsctl.c | 70 ++++++++++++--------------------------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

