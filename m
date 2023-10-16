Return-Path: <linux-fsdevel+bounces-495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038B7CB49F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D448281884
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37642381AE;
	Mon, 16 Oct 2023 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unixzen.com header.i=@unixzen.com header.b="FRCqpyrj";
	dkim=pass (1024-bit key) header.d=unixzen.com header.i=@unixzen.com header.b="R4XAeWm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2CC374FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:30:12 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 13:30:10 PDT
Received: from mx.dal1.terarocket.io (mx.dal1.terarocket.io [108.61.222.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1541EB4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 13:30:09 -0700 (PDT)
Received: by mx.dal1.terarocket.io (Postfix, from userid 1001)
	id 371DA5DCC6; Mon, 16 Oct 2023 20:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.dal1.terarocket.io 371DA5DCC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixzen.com;
	s=default; t=1697487811;
	bh=lfW60dpJDHXNBDMWdFh36M38+5dpQJwqfoU7mcAxuiE=;
	h=From:To:Cc:Subject:Date:From;
	b=FRCqpyrjAcg2MXbi16iB8s8IUcXBrhV4KQW/6Uugqz7+yB5tXe5VOMd7DEs+m8r2H
	 9gi8sYrLva+zMnXdEamGtDZ89AtuUElMbI03B4qaob9ov2jaHO9xDEysarxwvwZ2VN
	 fe08Hlv5d4UVeZ1bH5W+71cV5gYTLxU6Mo7FvBoQ=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from eris.discord.local (unknown [129.222.76.12])
	by mx.dal1.terarocket.io (Postfix) with ESMTPSA id 18BB65DC48;
	Mon, 16 Oct 2023 20:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.dal1.terarocket.io 18BB65DC48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixzen.com;
	s=default; t=1697487809;
	bh=lfW60dpJDHXNBDMWdFh36M38+5dpQJwqfoU7mcAxuiE=;
	h=From:To:Cc:Subject:Date:From;
	b=R4XAeWm66YhmdLdtWeO7uhg4pjRtF/4EuffBjE6VL69q2uekLHXMKgT8efKscv2gk
	 0wQhYj6/pVF7rFyRyw276bCdy+BZBQToMZjjKK32LcgvbAGR5K0DOldQbTh1DJJpfb
	 yPjO0SjT/JYf0vez28SlKmwXIfE0BxiHrePjDbmY=
From: Alexander von Gluck IV <kallisti5@unixzen.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander von Gluck IV <kallisti5@unixzen.com>
Subject: [PATCH] befs: Cleanup description and reduce BeOS language; no functional change
Date: Mon, 16 Oct 2023 15:23:18 -0500
Message-ID: <20231016202318.6872-1-kallisti5@unixzen.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* The likelyhood of folks running BeOS to repair a BeFS is
  pretty much nil. Haiku fully supports BeFS and runs on
  modern hardware.
---
 fs/befs/Kconfig | 11 ++++++-----
 fs/befs/super.c |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/befs/Kconfig b/fs/befs/Kconfig
index 5fcfc4024ffe..e562bfb90f03 100644
--- a/fs/befs/Kconfig
+++ b/fs/befs/Kconfig
@@ -6,11 +6,12 @@ config BEFS_FS
 	select NLS
 	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
-	  BeOS. Notable features include support for arbitrary attributes
-	  on files and directories, and database-like indices on selected
-	  attributes. (Also note that this driver doesn't make those features
-	  available at this time). It is a 64 bit filesystem, so it supports
-	  extremely large volumes and files.
+	  defunct BeOS, as well as the Haiku operating system. Notable features
+	  include support for arbitrary attributes on files and directories, and
+	  database-like indices on selected attributes. (Also note that this
+	  driver doesn't make those features available at this time).
+	  It is a 64 bit filesystem, so it supports extremely large volumes
+	  and files.
 
 	  If you use this filesystem, you should also say Y to at least one
 	  of the NLS (native language support) options below.
diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..9153b6839019 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -109,7 +109,7 @@ befs_check_sb(struct super_block *sb)
 	if (befs_sb->log_start != befs_sb->log_end ||
 	    befs_sb->flags == BEFS_DIRTY) {
 		befs_error(sb, "Filesystem not clean! There are blocks in the "
-			   "journal. You must boot into BeOS and mount this "
+			   "journal. You must boot into Haiku and mount this "
 			   "volume to make it clean.");
 		return BEFS_ERR;
 	}
-- 
2.42.0


