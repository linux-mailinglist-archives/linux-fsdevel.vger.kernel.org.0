Return-Path: <linux-fsdevel+bounces-21878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32E90CBC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90A6282370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311A1386D1;
	Tue, 18 Jun 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez2X5qHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50982139B2;
	Tue, 18 Jun 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714164; cv=none; b=YkoiAdquNutrlT6UXdwpUc1ZpwgUGJzdbtIMJJzdWH4acjaf/3s0y8O+lRSSCFSsV+qsg6LWxq1cTDkH3WFYOplG0Zl3HHMr9VZjizqPEtYgQrjZ2B1BYusVAXYHXeRcPSBZFKz8KzJm0MlkGu97DSPFsHEpS5fkVRPtSHhlO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714164; c=relaxed/simple;
	bh=F+bFk9dickmFOawd5Pn7aBTqChq06jSCg6S6Xw6BLzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/sskjqEBdbKlyh16pzVhAR6H3Kmf8AHzIglzoEdL1rEAn/GgSYqRRIsW6d0T1GlgQW7R7EvqbCPN1EukcuJHhN+mvnnJ8UJSRHw4wvoA6POZNFqnFU7sbaVac358/o/AVIvHsmTvTKcv+IRgvJlj5t4Enx2GUS85K+MM3qHbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez2X5qHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF68FC3277B;
	Tue, 18 Jun 2024 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714163;
	bh=F+bFk9dickmFOawd5Pn7aBTqChq06jSCg6S6Xw6BLzU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ez2X5qHQvWPom/GaSXuluAG/BWijvnGN4XC00rRLYwlz7nLe1P/JIm3alxmcbNfz7
	 nJjFErJ9/2LvD6FIGgmRaEgn6C2fA+wpc7s2HDiMg12biWVQ1+RMRo6S/GgK+IFH5e
	 ecj3A+ajNheHkPbVYBHrB4Taaf0N4U2iWI8XC77tNiLenRJbWOV0isiOsRVYk7tGxD
	 GH2VbqfS0gWi3ez0HnTpjdOzlh0ZlzjTf62k87FiSmuqefr5FTkBdrVaFc/QGCENA2
	 zUQJ7MlocpAnHBsREwXaMD/i+nIN1g2mvUFFE/vAY3Epxj/oCL5dEY3O6dPdxHZd0N
	 dRf/g/H0F2oIw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,mcgrof@kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 348a1983cf4c
Date: Tue, 18 Jun 2024 18:04:30 +0530
Message-ID: <87sexaqvgv.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

348a1983cf4c xfs: fix unlink vs cluster buffer instantiation race

1 new commit:

Dave Chinner (1):
      [348a1983cf4c] xfs: fix unlink vs cluster buffer instantiation race

Code Diffstat:

 fs/xfs/xfs_inode.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

