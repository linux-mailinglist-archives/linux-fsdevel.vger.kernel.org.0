Return-Path: <linux-fsdevel+bounces-38851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A7A08D11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8B13A4643
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB71885A1;
	Fri, 10 Jan 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4jWIXJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780A209F59;
	Fri, 10 Jan 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502691; cv=none; b=Ux/uyKKqKYzt/QUm3CkIz6iphmwruuPfoCBHoy+kvNQw1Ico+8db/3VKdHEijmFzMqmJeOBhU5ioh0vdDiFnectzOrIx1VjrssLOXFsVfhvffJ57sJ1yPvaDxW1pgKWjJV4oKkLykRG80g0AnSdCLOpsp34xE5i58lQ14RUDMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502691; c=relaxed/simple;
	bh=Zw+MxsoiL++TXNxcJzmcSY6magNVOQw/LmrQIkGhoXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pL9/Rkz/ZY1+ZrAolkYG6aL+FYDDFg2ewHwtEnYyf5zT6F45PSjtscLnkNNkScYc+t2LCgLsabsQ5iyJPKQrDT1a4WvuHM1tXH4geByJUOfT1QNGBWZzBVQJkF7E2xemYMxvy/wa1lbyhkD+ll4DNi91SRU+m15dsP9Y4djJyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4jWIXJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43704C4CED6;
	Fri, 10 Jan 2025 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736502691;
	bh=Zw+MxsoiL++TXNxcJzmcSY6magNVOQw/LmrQIkGhoXk=;
	h=Date:From:To:Cc:Subject:From;
	b=o4jWIXJI0KCIzFIRsMdO2C6sWgTblpQ43/aP9CZVKGnFTQy+GzHZ5ho34nTWWcgzy
	 gFkaHW8Awh2m5OyNv/OL6HGlKO0K8sxeE6ylB4mzHoWcTN0xq6jhHyO+zhZcYUt0m3
	 pYCeLsoTJ+SOnQ1+VGok+pgSbCyteBGSPItfe1V6TqF1qDlG6p5M1LJ1nX9C805ArB
	 fuCoUfIOdPfNmWdE2iDVSv3Whq7V/iviVzBZ8uwgnfi1lPbIwtzsT/NQVgv9L489sM
	 IVaGwSlQbuppLnE4R3Ywhy7MP8dhZt6MVU34nHrcyYjgVwW12QXw0d+z2w6QMeV6tk
	 /cVlzhY0pPHSQ==
Date: Fri, 10 Jan 2025 10:51:27 +0100
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] XFS fixes for 6.13-rc7
Message-ID: <fsn2arw4xjoozcqqrf7l56fmxn5r54ytkcv3rqjrwr74arrm7e@2a67uibjsdm4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

could you please pull the two patches in the request below?

I'm assuming you'll be releasing a 6.13-rc7, and if that's the case we'd like
to have the fixes below in 6.13 yet.

Notice though, the top most patch:
(xfs: lock dquot buffer before detaching dquot from b_li_list)

Is a last-minute one, so it didn't go to linux-next. Giving this is an important
fix, I believe it's ok to bypass linux-next so that we get this into 6.13 yet,
if possible.

I just attempted a merge against your TOT and no conflicts have been found.

Thanks,
Carlos


The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-fixes-6.13-rc7

for you to fetch changes up to 111d36d6278756128b7d7fab787fdcbf8221cd98:

  xfs: lock dquot buffer before detaching dquot from b_li_list (2025-01-10 10:12:48 +0100)

----------------------------------------------------------------
Bug fixes for 6.13-rc7

* Fix a missing lock while detaching a dquot buffer
* Fix failure on xfs_update_last_rtgroup_size for !XFS_RT

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
      xfs: don't return an error from xfs_update_last_rtgroup_size for !XFS_RT

Darrick J. Wong (1):
      xfs: lock dquot buffer before detaching dquot from b_li_list

 fs/xfs/libxfs/xfs_rtgroup.h | 2 +-
 fs/xfs/xfs_dquot.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

