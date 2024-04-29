Return-Path: <linux-fsdevel+bounces-18094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0878B570D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3271C21A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31234E1DC;
	Mon, 29 Apr 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj6P5rkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB745019;
	Mon, 29 Apr 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391196; cv=none; b=axxvgSQJ8IRN8lSJ8L1LGjMqwiSFC4uMtZxtspcWVRimLIUk/9zO1rR5pZ+YDaXgja5kQHsi5KP46G5EBnzcNRto/05YtMrPlItjbPMURw04Xfk9WuviKRIAulB9z++v5sLyDPb+BLRwQbdLicRsm4N5IZPl14AbCcG5LwLrckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391196; c=relaxed/simple;
	bh=IV+ygMs7PiO/TTkU9zkJBAHn6CUSMGd5cDU2VnC6I3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pOvLmaBKSrVzePYlRpATtYf3OyPH1chavCJpMbepAZGSpBnOCAMZmR53VQHywoj/gYPwhwM0GTMl1CfDHet7IbP1p2PEb3+UIeS0Z+zSUsjDJBKCq/t1AmXh+T2Kzonolr7TfUN9fOmokIDDeF3t+W/g6Njm6nXODPHGlfhMUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj6P5rkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A73DC4AF19;
	Mon, 29 Apr 2024 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714391195;
	bh=IV+ygMs7PiO/TTkU9zkJBAHn6CUSMGd5cDU2VnC6I3A=;
	h=From:To:Cc:Subject:Date:From;
	b=Pj6P5rkr8Q7knSG+3gnF32/ImkEdUQsu0uATCnsR5khCIAiHD71nhxWcC4yheOFHt
	 YjOOfm3FHCx8BMNh9PtAZ36LCYlNWtNDpsIWY1DjLE/B6l63BE/HP2EBYGElNt5p3b
	 qXHgoIhe3DrtFyiQ3Cvr3Qq82rBl65LsEyqW/QI2S4apUWO24zwZ3Duy0Qsx2r+w53
	 uoTYwsFzRCX24hjwfi4PJ0w/upuDlKefvsg1K/LpYn2PfhO0NEoWUGKJBPpHgAtnQ2
	 S0z5KuDRuQI3O/zuT28VcU/XvVKYUBo1mgvTi71qYudfcvy3xQV9EtS7YprPTKxrGM
	 cJqCrbE6LJBAA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to e58ac1770ded
Date: Mon, 29 Apr 2024 17:15:18 +0530
Message-ID: <87wmogpf1k.fsf@debian-BULLSEYE-live-builder-AMD64>
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

e58ac1770ded xfs: refactor dir format helpers

5 new commits:

Christoph Hellwig (5):
      [14ee22fef420] xfs: factor out a xfs_dir_lookup_args helper
      [4d893a40514e] xfs: factor out a xfs_dir_createname_args helper
      [3866e6e669e2] xfs: factor out a xfs_dir_removename_args helper
      [dfe5febe2b6a] xfs: factor out a xfs_dir_replace_args helper
      [e58ac1770ded] xfs: refactor dir format helpers

Code Diffstat:

 fs/xfs/libxfs/xfs_dir2.c     | 276 +++++++++++++---------------
 fs/xfs/libxfs/xfs_dir2.h     |  17 +-
 fs/xfs/libxfs/xfs_exchmaps.c |   9 +-
 fs/xfs/scrub/dir.c           |   3 +-
 fs/xfs/scrub/dir_repair.c    |  58 +-----
 fs/xfs/scrub/readdir.c       |  59 +-----
 fs/xfs/xfs_dir2_readdir.c    |  19 +-
 7 files changed, 169 insertions(+), 272 deletions(-)

