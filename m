Return-Path: <linux-fsdevel+bounces-1681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F387DD95C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 00:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28C31C20D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD0225CD;
	Tue, 31 Oct 2023 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K93eT1A0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DF1D525
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B0C433C7;
	Tue, 31 Oct 2023 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698796100;
	bh=3V9euhU0MLx0KKIk13/slsDg2pnOZt8KziSPT2oAkL8=;
	h=Date:From:To:Cc:Subject:From;
	b=K93eT1A0GkeYMJ21vsiApY/qNGoKPkEzgWOLaiiCTLoOlmAQyL9JQq64i822pD0LJ
	 MOFh54uZDLI0BZQj67+n3ahMberRt2sXxXUHcR9q9OGu2pZM+65bJquCUx9we99Xre
	 J1mGH6MX4ByGkZLjF6P7EgQ47hkGQL7pwpOT0vnp1cBu7FRg9vOaWf3afcIEyRuS1M
	 75VgP54ePp2QIG6e6hb9lV/QHjqxTa25ojhXqEV/tikZ6t2FfSthlqXka+c6b2EJbB
	 OCIVGeR5k4w5c5avjg4Juxb6Xv7rgwvNzJbCTaLz7RfM/58PJN+rgFKnmtA+BswxA2
	 KNBIdZACJcQuQ==
Date: Tue, 31 Oct 2023 16:48:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH] iomap: rotate maintainers
Message-ID: <20231031234820.GB1205221@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

Per a discussion last week, let's improve coordination between fs/iomap/
and the rest of the VFS by shifting Christian into the role of git tree
maintainer.  I'll stay on as reviewer and main developer, which will
free up some more time to clean up the code base a bit and help
filesystem maintainers port off of bufferheads and onto iomap.

Link: https://lore.kernel.org/linux-fsdevel/20231026-gehofft-vorfreude-a5079bff7373@brauner/
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..b26f145614ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10951,7 +10951,8 @@ S:	Maintained
 F:	drivers/net/ethernet/sgi/ioc3-eth.c
 
 IOMAP FILESYSTEM LIBRARY
-M:	Darrick J. Wong <djwong@kernel.org>
+M:	Christian Brauner <brauner@kernel.org>
+R:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported

