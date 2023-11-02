Return-Path: <linux-fsdevel+bounces-1882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C068A7DFB92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD69B21394
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A8622319;
	Thu,  2 Nov 2023 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrFzCw2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EB22310
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 20:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87041138;
	Thu,  2 Nov 2023 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KgLnpwY8xc2H1YfXXJvpwZu7+Y0INuXs3yqtkGE0lBo=; b=jrFzCw2huxP0A+qMzS4GI5Dmqp
	DYjPJtYAoucNoaN9Bo7nJTZjPBUTfArCm5uZYUnCBhHk2Kdt5zw+XxhY1HF+biqZYhsneox33o3Jr
	fXTwxPtNwP2EkgTfMSv/bMlpZsVRiU4/cL1DWyPStRhLdzsehPtun/iS0ixMeO+D7xy54QQ0c7wsF
	Eaqw0Szqno3Vccw5xtAtHOwVL4yuyffCBxYdGOLmL8JjGlbpuBKEGnbwzGC6O6zU83Ke7xys+9h+6
	h49z/e8h00nRp36u7rKYEDbammQhXezilIXLfxqeqverGkygw9paCUw7GgSQEaJFXxNHlZwtg2FsM
	fl5Mtn1w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyeME-00AFax-1m;
	Thu, 02 Nov 2023 20:32:02 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: keescook@chromium.org
Cc: j.granados@samsung.com,
	patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: Add Joel Granados as co-maintainer for proc sysctl
Date: Thu,  2 Nov 2023 13:31:58 -0700
Message-Id: <20231102203158.2443176-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Joel Granados has been doing quite a bit of the work to help us move
forward with the proc sysctl cleanups, and is keen on helping and
so has agreed to help with maintenance of proc sysctl. Add him as
a maintainer.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66c2e2814867..c9b077e779d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17224,6 +17224,7 @@ F:	tools/testing/selftests/proc/
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Joel Granados <j.granados@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-- 
2.42.0


