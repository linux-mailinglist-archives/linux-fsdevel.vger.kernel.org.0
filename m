Return-Path: <linux-fsdevel+bounces-4874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15E8054F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ED01F215F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F735C8F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqmWoEP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E26979C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 11:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7118DC433C8;
	Tue,  5 Dec 2023 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701776652;
	bh=XF9AEYRA2oCSGTdGqb3Kv0jV2g0mXLqniiG/+bTllDg=;
	h=From:To:Cc:Subject:Date:From;
	b=VqmWoEP1PSfsfzj94grjRyvZbndCZTnbGL5Pl6QoNk/ztdMYhUy57GbBzHnUiArhp
	 +QzlKS7b154T1laRMQ99TjOEobAOjFSxXGNA1SEJQl8k7muQqs8jONnuY7uLxIM5Oc
	 0zIb8ylHdkYlP3oykyp6RUAm0AnvlIbLq8OrToczDE91qEBQKyipFMwTvQOqDZgVXP
	 BYIwZkkRXWsj1ZKz2Mn+A+DUdpPaMeDvZ9ef3V56r/D8P7id7e1v9wTU3nw52OkMt1
	 xytM/rJPcToVFo9KXTVrFwrI+D4dQ3Vt+hrqJNPvdaUniPp2NMEZn9cWQVIcR7IO7d
	 yqEiVwiAXuR7A==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: add Jan Kara as reviewer
Date: Tue,  5 Dec 2023 12:43:37 +0100
Message-ID: <20231205-aufkam-neukunden-d14970a0a6cc@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=brauner@kernel.org; h=from:subject:message-id; bh=mTpLOdyB5VKfBHflVMEWr13S6D5CwrrYfcJnEFOKaec=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTm87x4/kWf88OMRz4K+f48U/sWiSktivFZt2v/hmLZJ Md1r+dod5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkiiIjw6mCF+e2GP6aWeJt x6Nbedni5e6Yg78P6SxN/blXfat/fg7D/7w+CbHVe+pPxlp+EdXXEnr8w/PpDcbGRyafOQLspwY Z8gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Jan's been really essential in help deal with reviews in a bunch of
areas and we should really make him an official reviewer. This is long
overdue imho.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Uhm, I have to confess that I had this in the tree for a while and
simply forgot to send it out. This was really an accident. I'm sorry
about this.

I'm quite happy because Jan has really helped out a lot and I don't
think this should be controversial.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0a7b6f357ce..d60c4888e6df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8157,6 +8157,7 @@ F:	include/trace/events/fs_dax.h
 FILESYSTEMS (VFS and infrastructure)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 M:	Christian Brauner <brauner@kernel.org>
+R:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/*
-- 
2.42.0


