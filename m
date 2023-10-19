Return-Path: <linux-fsdevel+bounces-777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251647CFFE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA47BB21374
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB729D0F;
	Thu, 19 Oct 2023 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFsDd4HB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5A225B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9676C433C7;
	Thu, 19 Oct 2023 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697734039;
	bh=7ByxCLNpPBhFylp0Z+BxtRMtfo0a5R8DkVaCrjthb44=;
	h=Date:From:To:Cc:Subject:From;
	b=GFsDd4HBzKgwuQuwB3p7TSQg5ObvwXUEx3ADE+UqTB1sBlwlhoLWuUJEF42eXnrqU
	 8peMKRyS6v11rP1caqwmr+fju7Bhko38+MZOQkObvL9jQG6ReJ1QjfsxJKPhiXkZys
	 qBhGXTitR1K/vgznczP1J4UZIgRPDORmOcSxR7pjWzYUopYygmLv3tootB6eIyjC4S
	 yF2f8+0mVOFy1C8CsoMbL2Ov+EuKhGlInDrDPMBPMQ9ooxD8wOAAPuZy1uUXK2xy2S
	 jw9wQZTt+1vdL173nVeqo3hbv43Qfdls98IFMWcyTXWWtDSF+/LiH3YOdWo4ozRZ9j
	 okPOTw5jS18GA==
Date: Thu, 19 Oct 2023 09:47:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: hch@lst.de, jstancek@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 3ac974796e5d
Message-ID: <169773388032.253238.1731507472177515983.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.  One last bug fix for 6.6.  I hope.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-for-next branch is commit:

3ac974796e5d iomap: fix short copy in iomap_write_iter()

1 new commit:

Jan Stancek (1):
[3ac974796e5d] iomap: fix short copy in iomap_write_iter()

Code Diffstat:

fs/iomap/buffered-io.c | 10 +++++++---
1 file changed, 7 insertions(+), 3 deletions(-)

