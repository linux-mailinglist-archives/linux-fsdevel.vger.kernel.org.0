Return-Path: <linux-fsdevel+bounces-9715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82C84492F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59C928D93F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453238FAD;
	Wed, 31 Jan 2024 20:53:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6531A61
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734389; cv=none; b=lXqvYLfnDE3ZLheiM/qmxpVWOEorGkO0ulVNlxN4rQB3Dy1Nz/HlYwz1RHAlwv6BBrauLpzaR2yPWo5GgHAYETtiNlN58rQN2DvRFLBAehT3eQiavScbJ1DIxiWWeEI1+FVzt2ByE+yjYsh05jYZZX6DAJjNZ5kRJPq4y2GeP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734389; c=relaxed/simple;
	bh=PeigcjR0fJHqnWYzUNDhF0SumumPwInd9lmx/bLcwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8WOktnvQt0kFfofQejlUkjFmQDxzKVBU6NLMNRkwagfFRl5X8GyH4j7JQouQyv64/tu1wveWQbeU/eTjRdQPyH0chWMCc3AJ2wsJ6VD2WoOQXSiRtk5uWZUo1vS5XdK3a/DRU2wCIkrTO+beE5mTgcAlTIfN9jbafQb1YC0nKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1127469a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734388; x=1707339188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkb7BdFD0GARRMQmHbkGbl9/+4lufBLaMcZRoVBPKBQ=;
        b=CKSfIooTbLCfMaJ4UZ68msNTDZ0BSaKNRblBCl0xlHZIPqzhtZWAn6D18Fz4MYQA2E
         YH6IU8xsmgv1A48VG2euFPLEQXUppsaSMukozJPF4m1y4DRP7GTz/QBt78KULQaODhNp
         /VYeRb/hCpFQQeNx5vJ40DQ+UiGGv3GzOUWZXiRMHlLRtYre6b4QkQ9wcAAufOaQd6w0
         nfMShWGcVFMEuig5hVzZ7mXERFkr9SOonj1zdkA5nCKjDIsCQUl8HrvHW6m8Wd+DijEB
         Sih7mMeqlFnnq5aN1RUDUCBsx9nxr/9ILdfhxGTMNMOo3TE43UQ7CfoG/kUuzEETCpQZ
         888w==
X-Gm-Message-State: AOJu0YzIMY2Db+MSq6/nCOUdjjZyxJ647+ksPiy7IhBY1AVmq8YGjBu7
	CiN1BC0VLR2UhrEJjxUQuOFPZKS9akzFuVoWtlxY4+ML/1vyhjQX6/+a12hF
X-Google-Smtp-Source: AGHT+IEvycIMxFLgh2e0qulchHE4MjIi5PO0cDi8Mc+9BawiFu34LyfBkXPu69gthpcOgksw+YQegQ==
X-Received: by 2002:a17:90a:c208:b0:296:67b:1894 with SMTP id e8-20020a17090ac20800b00296067b1894mr791729pjt.0.1706734387653;
        Wed, 31 Jan 2024 12:53:07 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:06 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/6] fs: Verify write lifetime constants at compile time
Date: Wed, 31 Jan 2024 12:52:33 -0800
Message-ID: <20240131205237.3540210-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131205237.3540210-1-bvanassche@acm.org>
References: <20240131205237.3540210-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code in fs/fcntl.c converts RWH_* constants to and from WRITE_LIFE_*
constants using casts. Verify at compile time that these casts will yield
the intended effect.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3ff707bf2743..f3bc4662455f 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -270,6 +270,13 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 
 static bool rw_hint_valid(u64 hint)
 {
+	BUILD_BUG_ON(WRITE_LIFE_NOT_SET != RWH_WRITE_LIFE_NOT_SET);
+	BUILD_BUG_ON(WRITE_LIFE_NONE != RWH_WRITE_LIFE_NONE);
+	BUILD_BUG_ON(WRITE_LIFE_SHORT != RWH_WRITE_LIFE_SHORT);
+	BUILD_BUG_ON(WRITE_LIFE_MEDIUM != RWH_WRITE_LIFE_MEDIUM);
+	BUILD_BUG_ON(WRITE_LIFE_LONG != RWH_WRITE_LIFE_LONG);
+	BUILD_BUG_ON(WRITE_LIFE_EXTREME != RWH_WRITE_LIFE_EXTREME);
+
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
 	case RWH_WRITE_LIFE_NONE:

