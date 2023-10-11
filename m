Return-Path: <linux-fsdevel+bounces-33-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757617C4936
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 07:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E499E28193E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 05:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF005D505;
	Wed, 11 Oct 2023 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEsrpCIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73F354F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D2CC433C7;
	Wed, 11 Oct 2023 05:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697002272;
	bh=3YgUee4qoUE987bbe4BEyyfo+AAodauqgS9+MdtpCVE=;
	h=From:To:Cc:Subject:Date:From;
	b=rEsrpCIXU9uzJyv9tTcQCYOWmcL2+4ApP6SD+dgefe6oKAVto3yq11RU/eLxy9v5C
	 Q7XATQ/7jjzt0Jx6YHoYYZIAE/oUJx6QvMr7dSeIfF3gR7Y5Vrg/ErEPUcOtLDk2Bt
	 lZuHt/2FouLR7pSYAX/PVoXJ/q56odgJOsZd0J5cDK/Y1kCpUsF9jrDmKZgGfhe60Y
	 9qTWhrzHAYFBSj+iFBg47AGcM+eWBZ1OuUgqZZ7Pgaik5hFlvVwh5GgKAlvQE3jVCu
	 WQB1QyNc/o2OoGz6VNvRPWC7Dm7Rckn2q79fzxb+bKkW03Mf1YYZWqwfkQeJQi2OaU
	 oB4mpDuonQ5QA==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: abaci@linux.alibaba.com,djwong@kernel.org,jiapeng.chong@linux.alibaba.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,ruansy.fnst@fujitsu.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to f809c3aae7b0
Date: Wed, 11 Oct 2023 11:00:02 +0530
Message-ID: <875y3div38.fsf@debian-BULLSEYE-live-builder-AMD64>
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

f809c3aae7b0 xfs: Remove duplicate include

2 new commits:

Jiapeng Chong (1):
      [f809c3aae7b0] xfs: Remove duplicate include

Shiyang Ruan (1):
      [cbeacafaac88] xfs: correct calculation for agend and blockcount

Code Diffstat:

 fs/xfs/scrub/xfile.c        | 1 -
 fs/xfs/xfs_notify_failure.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

