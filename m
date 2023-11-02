Return-Path: <linux-fsdevel+bounces-1879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF577DFAFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5541C20F91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BF921378;
	Thu,  2 Nov 2023 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7lSWYtN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8921349
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 19:37:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160ADC;
	Thu,  2 Nov 2023 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=aNFzAHye6B1qO1kppIXioMOdbIXWQ22j7LwyQZ+5w4w=; b=K7lSWYtNqQzPDI7UrE8Nzcw5fJ
	ktWXy1sbrGrkYHrQyFH16m9+97VICrxW9EBI+Q0Q+AekvCJ+JpspqLFrKGgJfSFKczIE9NaImq9J+
	gCkjEelnYR18cGPF47uCpgQDmZAVcJsyzV39Qy+MqbWNy0hLkKgnK93o2bO0SkSiszV2hWe94ycwi
	cZlwoYFkuZCR7E7VIdS72Vc99xr7sCi+0BV2eg+Yegpbpf+MfvMMU5hL0fn/9Shda307j6UMCcnPv
	So7VxfEXuTPtAbSX6mcB0NB6lzixjynM3dHgPNt+HiNPWYFqLeV7kjFtUXVdYkF2fRKoH1O9ejN5t
	8y+HOf3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qydVf-00AB2q-17;
	Thu, 02 Nov 2023 19:37:43 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: keescook@chromium.org,
	yzaikin@google.com
Cc: j.granados@samsung.com,
	patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: remove Iurii Zaikin from proc sysctl
Date: Thu,  2 Nov 2023 12:37:42 -0700
Message-Id: <20231102193742.2425730-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Iurii Zaikin has moved on to other projects and has had no time to
help with proc sysctl maintenance.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..66c2e2814867 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17224,7 +17224,6 @@ F:	tools/testing/selftests/proc/
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
-M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-- 
2.42.0


