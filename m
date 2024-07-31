Return-Path: <linux-fsdevel+bounces-24682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B2942EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB8DB23C40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E031AED40;
	Wed, 31 Jul 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEX04/Ya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4D1AE856;
	Wed, 31 Jul 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429645; cv=none; b=qqIkDCekkuv29ujay6gAfrXrVnsi0mSW1hzuqcu0V4ZOBH/XdQrmtGp862IMZIWRi33gjeN5JgFA8pwplc+bEYmktmoTGA+9eh3iUcpe9i4ZWC2t0pyZ4mW7jUvHh6evSPQpXrW/OnEr1utaRVH742VvWLKyPw4ri8YGKueMNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429645; c=relaxed/simple;
	bh=ZQYwapvvRoc98cBxhpTni3rNawYyHkaeqj2A0yuc5ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KrOW4PcAEcpEcxlXIKYBhxA10wabN4Y1HapHxD/jZkeKvLpFina14kpRV3VIUmFrjeD4J0Mk8TBBqw9mltjz4Vps0RuTD9MFyWxASzLTP3ZhbmWfDCJWLxhuEy6NB66PpEzNfXO6GpWa3Hi3GasknXeZDyOaVbC99fJzY9Z3cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEX04/Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D476C116B1;
	Wed, 31 Jul 2024 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722429645;
	bh=ZQYwapvvRoc98cBxhpTni3rNawYyHkaeqj2A0yuc5ro=;
	h=From:To:Cc:Subject:Date:From;
	b=qEX04/YarwqlcTUNA6W0V8ogVa9vHU+1WusjX1p5G5CAtz0J8ohZajuxd1LN/vZdJ
	 CFHdoHdeN17YhQVVwelNhxsau/H+GfgvAoUh54BNVstRpSKHdZsHSFiw5n1E5VPHWq
	 g291geEK/IFE9yY4ftbVYnYs/0K9OOG7JuuojaUj1ziWOWl3VFi/+P7TXvGgGlgTTz
	 R3VzHhYkwk7uwd4XV4kstW/lNkAB27U0EWk0zEeGdB/ducdhU4N9mRwn0HcLOjEyxp
	 qtEppqqn8Z35fezc1fbR8g76944VDNUCogdPahN0d3aY7lybpibXZv3Mm7eNmK+B5c
	 CLtyYH5kRL0SA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,lkp@intel.com,nichen@iscas.ac.cn,sandeen@redhat.com,sunjunchao2870@gmail.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 7bf888fa26e8
Date: Wed, 31 Jul 2024 18:09:55 +0530
Message-ID: <87o76divjq.fsf@debian-BULLSEYE-live-builder-AMD64>
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

7bf888fa26e8 xfs: convert comma to semicolon

6 new commits:

Chen Ni (2):
      [8c2263b92317] xfs: convert comma to semicolon
      [7bf888fa26e8] xfs: convert comma to semicolon

Darrick J. Wong (2):
      [80d3d33cdf4b] xfs: fix a memory leak
      [19ebc8f84ea1] xfs: fix file_path handling in tracepoints

Eric Sandeen (1):
      [39c1ddb064fd] xfs: allow SECURE namespace xattrs to use reserved block pool

Julian Sun (1):
      [af5d92f2fad8] xfs: remove unused parameter in macro XFS_DQUOT_LOGRES

Code Diffstat:

 fs/xfs/libxfs/xfs_quota_defs.h |  2 +-
 fs/xfs/libxfs/xfs_trans_resv.c | 28 ++++++++++++++--------------
 fs/xfs/scrub/agheader_repair.c |  2 +-
 fs/xfs/scrub/parent.c          |  2 +-
 fs/xfs/scrub/trace.h           | 10 ++++------
 fs/xfs/xfs_attr_list.c         |  2 +-
 fs/xfs/xfs_trace.h             | 10 ++++------
 fs/xfs/xfs_xattr.c             | 19 ++++++++++++++++++-
 8 files changed, 44 insertions(+), 31 deletions(-)

-- 
Chandan

