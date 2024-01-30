Return-Path: <linux-fsdevel+bounces-9569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D4842EEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D159E1C24425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F77869C;
	Tue, 30 Jan 2024 21:49:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2678662;
	Tue, 30 Jan 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651362; cv=none; b=UCUeMw4Wjyw6yeaF6J1aORiJfrcwertY7Mul/+/srraeynn4vwpLLEx9a+0ZQYSxr4hD22eDgPY2gQ/mH2f5dp/j/Db2kZbUynsqJzdbH5x7VWwfEnHT3qbsvHPYH5Ns0tVd1KeBB70toQ1Q64EUZ8H1/SsSBLht+DKxxXm+xQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651362; c=relaxed/simple;
	bh=PeigcjR0fJHqnWYzUNDhF0SumumPwInd9lmx/bLcwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfoHQKhpXaFXRKPOaz0Um9CmpuQdZ3bdXcea12dxjplIpHPbqchijoQNPm/kYyynQ9ltU6jqbUv66mVI8Bq1y8dUgKhtceNt9DX/IKoXzF9Ra3xuztWbBolpdC6ee0qgUmUpmslT3W/3Vtiqs+qCemWuOKyAb2/MMYpFE2bATtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1486189a12.0;
        Tue, 30 Jan 2024 13:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651361; x=1707256161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkb7BdFD0GARRMQmHbkGbl9/+4lufBLaMcZRoVBPKBQ=;
        b=skYJmoRPNgdN0DDlg0ojPY/DWRVRgtXF32lGCfua0m9wLS/B+WmXm6BOEz5Mz67miU
         qpt11UZAm5fJ1sLbCDn2aitZQXwLMX6RtME/Dd4+aKezXDeHRhZ2YdSGV5gpRVHqf9Rp
         rZ25A7vT5EUBR19F7KrdHhTcvl9F0IaZyhG26uGwTk5wZZTVR9zuxtLFFYzXu8ezNfYU
         OYqLcDhRp/LK740lN0DGGwBODgXxa+CO9aU/MN1CSHIz27d1gfLlrG/9s9cSckCZGHtw
         Sl8Oliswy7qZfw3w7iFkyEbcQSeUcj1aX+JYsabgKBkNu0mS80/Q/nu2Rfdz75VYY5gy
         7wdw==
X-Gm-Message-State: AOJu0YyXc0OvHhnazQ9uSX7/LqG5ebK5cReOu77y2MeLWNdEtf2P+vjy
	3Ga9gTau8nknLyiwWkp7xgmRfYBnFBZULWGOI/Z5UCORS5Pkl2WZ
X-Google-Smtp-Source: AGHT+IFGJdPd0t5zlQ0YPJ3GufvyPWdwb7WSxOKQohz5uBYtP+v1RtCHEt1mbunZrs8HGqewPVZH0g==
X-Received: by 2002:a05:6a21:9214:b0:19c:a48b:6a4c with SMTP id tl20-20020a056a21921400b0019ca48b6a4cmr7179986pzb.38.1706651360787;
        Tue, 30 Jan 2024 13:49:20 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:20 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 02/19] fs: Verify write lifetime constants at compile time
Date: Tue, 30 Jan 2024 13:48:28 -0800
Message-ID: <20240130214911.1863909-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
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

