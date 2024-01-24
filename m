Return-Path: <linux-fsdevel+bounces-8679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFB83A1B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 07:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866591F2BCF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51448101C8;
	Wed, 24 Jan 2024 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2QxZBmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10EFBE4;
	Wed, 24 Jan 2024 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076173; cv=none; b=XiXH4ryNDpoz4Xko2XE9Mv0vuw5VfcnGWVgVjUWnhrE8bWA7kbjcPfL7gUbA6MM9ywfzlZ3y4ZEo6i0MOpYJhGrMliI8i9PIdAUIfHvlA20Lq9nZjyUZ1Fm66x9ywq5P4cMqS5gFeIWPGUfLLiCKJvS7vmYEh3k7R0BTypAKrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076173; c=relaxed/simple;
	bh=bJdSvkTGtcaSm836IDAy26STpzKRlzB0X5Rn8pTMH08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZcwXCynCjvuchmjHo5jEE3uCD2v1X5H0WLJjE/9GJxOPnrMJI7L94as9k+bAt3HcY6cxWDwLo2g2HdWIb9EdSlW1y8dMKA2Z5E+bSbr+7MCsiwdo0HBI3FIMITZCrgpF3RR2jCRJUsvPdjrknPVZ86SbpBfypsd7a3/KQ4egvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2QxZBmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD101C433A6;
	Wed, 24 Jan 2024 06:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706076173;
	bh=bJdSvkTGtcaSm836IDAy26STpzKRlzB0X5Rn8pTMH08=;
	h=From:To:Cc:Subject:Date:From;
	b=X2QxZBmfmZ+Ag5wMBMZwfvXSvRTgna9mC4l/TKX20KkHH4/iHsOU2PP/sCKWa9Z3Z
	 78wky/0C3TMJpyJP6SDZ0Rn257AXUVS6nZ+gPHHV9iAt7qmcpii0w4AEZTDcH5f/3Z
	 fN+oQQbKnOkAcYENNjOVH3fp3I/+xz2LYe56ejkO/NdSMtu9IxcMr2NZ1fOAWckBHL
	 AZ5Vs21IHCWQNQiC3hqgQjdIQNCWB6/gvvSd279udxKcuIrnjiBeTJm0EWtVUG3npB
	 wLizDS3rUQ+GESDRwVO0wz4QM7WEUEHWjsMjHgGvhWs1Y62pUSjW1rJIbz2lbHKSJN
	 Zzz9V3OQyM6aA==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to d8d222e09dab
Date: Wed, 24 Jan 2024 11:31:01 +0530
Message-ID: <87sf2nclpz.fsf@debian-BULLSEYE-live-builder-AMD64>
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

d8d222e09dab xfs: read only mounts with fsopen mount API are busted

1 new commit:

Dave Chinner (1):
      [d8d222e09dab] xfs: read only mounts with fsopen mount API are busted

Code Diffstat:

 fs/xfs/xfs_super.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

-- 
Chandan

