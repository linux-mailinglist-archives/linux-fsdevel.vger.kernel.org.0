Return-Path: <linux-fsdevel+bounces-28026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A4966289
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8D31F20EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41B1AF4C8;
	Fri, 30 Aug 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvLkQt0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D91A7AC6
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023147; cv=none; b=Lcge3JEO70587t/tt4aMqli6PSuzQ3Nulqpk7ykkh8DBV0F+A5CUj/CG9s/Q7jq7cho6EdClkf5BRZOfZnZYT2JAaXT1PUqB04ztrOF892xygNbnEsh24JtBuG7TD6G20tG/iIii0iGW/0GsAJI/kHid91JJvYk3J+V7ErxDcdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023147; c=relaxed/simple;
	bh=GCB9+S862ME+HCXFAL4isX9ZuNjSsK5z1qW2TPkA7g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXfS3ePNSLovwt3Lbps/vyrjDY8WDnjaF/KyXnQPZJOurUthg/ZCUhE113KPFjM5S9mR4ijfA7Kkji5efCeL2QbhR+y/W5kcwHJIJJHCRwErnywdrtjDR4YAgQHunG5G+zrGX2vgckn5PV3vYxRQT1I2HKpfX3zDCPm28fx6Ugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvLkQt0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F93C4CEC5;
	Fri, 30 Aug 2024 13:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023147;
	bh=GCB9+S862ME+HCXFAL4isX9ZuNjSsK5z1qW2TPkA7g0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nvLkQt0CvSU13CzkMO2uh86xTBtgAFTzGYingKua0eAi9b1rZX5XecAUyjRLQzqrB
	 JYDZvh5KgNOKJDKujvfdP7ZBI5+KzYk+AoK5rskm/+DCvmaFRXF/q9prs1mI9g9FP9
	 ICivmqsOEX12a7ZZ9+uHnRpJWrr8va33THPPxdbd6fV6psmSYA0G+v/VjWIodJd4Ri
	 7mkxkoNo/88AqrVqqOGV4Yn4w9/egdckZ/rQ7VKjkrZaGRIHDL74+IDr97SZOfZOW+
	 SrgWgO+yBJ3wjpX5BXTa2ELQfUI40UkMebodPWwvyxM2+CQuw5ihVlQebYF9FZJfZl
	 AAyUj6PvVczVA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:45 +0200
Subject: [PATCH RFC 04/20] s390: remove unused f_version
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-4-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=614; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GCB9+S862ME+HCXFAL4isX9ZuNjSsK5z1qW2TPkA7g0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDz7n3C33jytnbfs7LYIt53e+pJB3K977d/ks1Zi0
 54u2Bkh3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRjCaG/1V/7Z/luhw+lGNa
 xyKWFLH6cLJJ8PLORaar3b4u4L7F2s3w30lhb1V1atjdY89nSoXcCOyqeaSeozu98a/dylvHdfS
 V2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's not used so don't bother with it at all.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/s390/char/hmcdrv_dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 8d50c894711f..e069dd685899 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -186,9 +186,6 @@ static loff_t hmcdrv_dev_seek(struct file *fp, loff_t pos, int whence)
 	if (pos < 0)
 		return -EINVAL;
 
-	if (fp->f_pos != pos)
-		++fp->f_version;
-
 	fp->f_pos = pos;
 	return pos;
 }

-- 
2.45.2


