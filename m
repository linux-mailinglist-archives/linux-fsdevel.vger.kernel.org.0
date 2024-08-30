Return-Path: <linux-fsdevel+bounces-28024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84082966287
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2F91F20EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855551A4B9C;
	Fri, 30 Aug 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnE5ip4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C2199952
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023142; cv=none; b=TafNj/aB0kvr+MQ/KipN2zLmLNP0nj7fJ+XQOXWPMoOZqOK0Kl/1z5uXMr3DMRE5spcwtnZ8XCj3dOLeHosbgu11WvunWIueE9H0RK7kXNWS6mtz0iM4jpE+01Bhd4Cl1RVQvNcSxPAtH0ioBMEDm/O7YCxpwig+Mx8Yp9viy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023142; c=relaxed/simple;
	bh=m0MK5x14xYeWUlpHuGJRO2AE5ttSGHy3ztVlwwlYFLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mshIzNeiWVlcFOeUy6UpBzudtZWNeNhFuoESrMns/2bT4UTGmAByh6FJHPdDXIDJCGhUS1d6sO0x5XHcg7wtvuHTUwLFjGN9DPq5HrM7OSO6V5lS8nr1uuzEqJMo33fsFyjjKGKbsVL5ReMbIlgCe30xD9/l4vJy2WvrYZtf2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnE5ip4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75530C4CEC7;
	Fri, 30 Aug 2024 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023141;
	bh=m0MK5x14xYeWUlpHuGJRO2AE5ttSGHy3ztVlwwlYFLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nnE5ip4/tOYUufqD+D8B27ljwwqUnk2gQkuuqsRQTcOcb34ogB4FxYoUvQrh2Pz/u
	 /p+fpzCnob31DjZequ2dCPcw3cLTjpAo0KzROrOS9EyYlzMJAfujq2YxYOOZX+UVLQ
	 qG9PDvu4frtOvh0+uCsHspOC6XTh+EKRHHUsPU3b9qZQlbCFwAFaNkmxLFgYg8u1O5
	 2doI0g/LHrERfELyK1LYPbWZL591+c/LNcwT27mM0+M8E4e9fTQrLlDxhAxokVEtWo
	 uglADzqinqz0Mr5H0J+IoO69HkyNCCMKlBmRzikqhtD1LemG9gksmt0GMkdl/+ILwz
	 dR3lTdY7eOYKQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:43 +0200
Subject: [PATCH RFC 02/20] adi: remove unused f_version
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-2-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=544; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m0MK5x14xYeWUlpHuGJRO2AE5ttSGHy3ztVlwwlYFLU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDxbdEP+xNZpSYslyl2WeM9dorryzErXEKb1yjPuV
 bP3sVVt7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1e0M/1OfX2nSnmWywehZ
 Vt67R78l9gY7HnEsuBsgEKXJwJzmvobhvwufn1PFmoPm/zZqSCut7K3LaW5euWNN298djD0RO99
 ksQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's not used for adi so don't bother with it at all.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/char/adi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/adi.c b/drivers/char/adi.c
index 751d7cc0da1b..c091a0282ad0 100644
--- a/drivers/char/adi.c
+++ b/drivers/char/adi.c
@@ -196,7 +196,6 @@ static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
 
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
-		file->f_version = 0;
 		ret = offset;
 	}
 

-- 
2.45.2


