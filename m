Return-Path: <linux-fsdevel+bounces-4928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACE806643
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 05:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DE6282316
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10237107A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bA2bge7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451D1AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 18:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kmw1anBAj/R1c0g0lkxt8u3pxhdTjbm4NNSqf7OVhGY=; b=bA2bge7LQ6fYSkqdSYTUKD8Fxa
	p43s3D7PZJw99YoDDKDaiUHvOzZAp14c2XfvZb36X5u4Bi3uQaEMoSYePyjWXV0f5JGyIC2gl1fce
	VuDqHCzjqd5Uq+hyqZsRwp37tcIt/v0c1jWqdPladxxcDJ25b+TJWi3QTOO8y0HByox3c16ssRUdU
	/sbBl2QQhrQfDOcL/+EEs08xg24PFmPenkgL/AXPrpincHYahpkNUWs1IDmIKmpfyPy0zlAZjj8l4
	VL7vmLufiMDoQf4kLjYaiMlyWQllr6sGQ0YCYLE96ODuX5Cm5W+vEiIhkOjyUq1Npco+Qp1kW2KQI
	bm/AsPng==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAi2t-008uzP-3C;
	Wed, 06 Dec 2023 02:53:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] fs: vboxsf: fix a kernel-doc warning
Date: Tue,  5 Dec 2023 18:53:55 -0800
Message-ID: <20231206025355.31814-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix function parameters to prevent kernel-doc warnings.

vboxsf_wrappers.c:132: warning: Function parameter or member 'create_parms' not described in 'vboxsf_create'
vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
---
 fs/vboxsf/vboxsf_wrappers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
--- a/fs/vboxsf/vboxsf_wrappers.c
+++ b/fs/vboxsf/vboxsf_wrappers.c
@@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
  * vboxsf_create - Create a new file or folder
  * @root:         Root of the shared folder in which to create the file
  * @parsed_path:  The path of the file or folder relative to the shared folder
- * @param:        create_parms Parameters for file/folder creation.
+ * @create_parms: Parameters for file/folder creation.
  *
  * Create a new file or folder or open an existing one in a shared folder.
  * Note this function always returns 0 / success unless an exceptional condition

