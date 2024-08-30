Return-Path: <linux-fsdevel+bounces-28023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39974966286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F31C20BA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58C1A2869;
	Fri, 30 Aug 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhMZbavw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF421A4B9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023139; cv=none; b=SwBIDgxvbgmLZcaDMVT/PQuN8NiAx9nT6tg1xRje7Hq2ZaZ8FUeiqxtawIuSflt2Nz6yWBRkQrrR0bTxc+eCIE+1CDkRfVNqSXAKUsUFnVQLojaKTR6Xp7/Zix8PvMz7K+3APlo/34yLQ2/NoRRSVsnTsfMpvlesPtRJe9cUagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023139; c=relaxed/simple;
	bh=6+/BQjTYLKgRaWf4QkVYNhAQgcALSUgSaI+CKTgvLJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeJ8OLfr1LdAxOI5THJzWTBqXipaRWQVAkXcSqizSTBITFbfxaiwLUv/ueNCnbq0cBFiemFQQOawF9sUpTnKn2x4iQWxKpQZ99bQJsx36IkgBg48HB/7XzyNAvRVhtzs/lyOthv0AZuuXFoALYIoboKXxNIgEmT17YW1PCFFpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhMZbavw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8250C4CEC2;
	Fri, 30 Aug 2024 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023138;
	bh=6+/BQjTYLKgRaWf4QkVYNhAQgcALSUgSaI+CKTgvLJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bhMZbavwdkC60DHJbSsTs5KU3aTNwYfnSYQnyQQ9/gs5BbnFrRxb6P2oDlEwT/0Y8
	 cR/wj/ZqxREQBvIVnLu9oOvRf9KitIO0i1BXHyKab+sfFSw2ccJeLkvQzxLJ6B5qxQ
	 OOF+ilS8KEbCPX2yMX5tS5piUdRZRQteYIRFrwtKwrLyLQd62oBmBNsj8TtCOvaz3Z
	 sMXL7+bpU5QyFhN426Bgq2yngYIpFh9LNOI4lVjvdtLT6vEF3MYFnHBWL6ONvaax6m
	 dOgwgPBZ4JyI1Nr4E6/Wk2wU/6IJh+SHixjEKsPYVskIjll83zM9TnWWXjjnsT0uU/
	 KwUBfZKF7uYyA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:42 +0200
Subject: [PATCH RFC 01/20] file: remove pointless comment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-1-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=599; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6+/BQjTYLKgRaWf4QkVYNhAQgcALSUgSaI+CKTgvLJg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDz7cqJl0oYJto83fRQTezg5ec42/9ULTc7c1b8a/
 +GmrkpIfkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE/l1mZPi+SUCvuvlhwIPN
 X/LF//7JF26YpjnpJU+SS2HMfdvoPQ8YGVZZcP+5p+q06pFrn/NtwdaVW7/tCf1kvebjkW+eVge
 DPvICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's really no need to mention f_version.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 3ef558f27a1c..bf1cbe47c93d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -159,7 +159,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	mutex_init(&f->f_pos_lock);
 	f->f_flags = flags;
 	f->f_mode = OPEN_FMODE(flags);
-	/* f->f_version: 0 */
 
 	/*
 	 * We're SLAB_TYPESAFE_BY_RCU so initialize f_count last. While

-- 
2.45.2


