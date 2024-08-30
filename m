Return-Path: <linux-fsdevel+bounces-28025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C6966288
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142E228814B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445F51B1D6E;
	Fri, 30 Aug 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnfLm4+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E71A4AAF
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023144; cv=none; b=sRtC7YJ7uXBRLF9pWLYtUBTRRxI4oWQTTAxWQLGd0PUCQTg8wk3C862ibaLeAbfbDGLGIwRKxTDZCxSlyLgrRME4yaP34RfYN52189Aktm/oSUFm2A2X02BI9Mw2zsiWhhZf1xMw5xI4HYuM9y0E/EOBF4rdisfMV56fLq48bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023144; c=relaxed/simple;
	bh=B+0ZLA0i60D7ZBtX17/wNvaeIn0U40DUrbuGI8hezxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCwG+xXA52nt7FURH0ZWezEeSbNzrQXfULdYnlxIzWptnfzLqJXu6e16cO+TTYzM3ZM99664a9KGcTsfluZ0RhRhyVSR8rifUEvRqVP3wN0qitRCdpaYpCnzI7j4nKFdNKS1Yv/cKM5KxGmenhYC/JFcVtdgdcZh0G4QYihZ7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnfLm4+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3E8C4CEC5;
	Fri, 30 Aug 2024 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023144;
	bh=B+0ZLA0i60D7ZBtX17/wNvaeIn0U40DUrbuGI8hezxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KnfLm4+IOS83tNnm04CSmbpxOqtpjd7BFaSVtg0JgeMMuK996fq6V3DeDeaEzf9l7
	 cfB11HseEI+DPIJuMvH8h3c6nuZZSKkcGPPrTQzDlm/20eFFytlchfwIhJ/RFMEK86
	 GWKmgFxTfAjGCWDoQjM5H5/m21OworgmNcHNGeq/ysFcZchxwldQVHtCNbw950Ghsu
	 nbhitPyFSMvBQFcVz3Rfvz3rpxymODDCqzYViIB9xz4wVJS8ifZwpO+R8wBW6UBexN
	 2+UaCQMuFSDmlsPOT0/SgQo6LUoQhbFoYtF5lIWaZS+0bKmb548Zd8y6scCK1tWEen
	 tqj0Qtz4er7Pw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:44 +0200
Subject: [PATCH RFC 03/20] ceph: remove unused f_version
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-3-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=573; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B+0ZLA0i60D7ZBtX17/wNvaeIn0U40DUrbuGI8hezxI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDzbsubZvNc5Vz6ILysKWC1QuNfzJldZaP/0XZEd2
 +V25SgLdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkOh/DX3Fr0QPOJp3piwrr
 XD9sYuyWse3YefqQTKRBd43OzN51Fgx/5etjnSf9k1yrLD/p8IY8vuCvdg8/nX7GKRg5RaCP61Q
 oJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's not used for ceph so don't bother with it at all.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ceph/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 18c72b305858..ddec8c9244ee 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -707,7 +707,6 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
-			file->f_version = 0;
 			dfi->file_info.flags &= ~CEPH_F_ATEND;
 		}
 		retval = offset;

-- 
2.45.2


