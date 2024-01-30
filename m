Return-Path: <linux-fsdevel+bounces-9580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32031842F0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C5C1F24BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F09156985;
	Tue, 30 Jan 2024 21:49:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431412BF02;
	Tue, 30 Jan 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651399; cv=none; b=Dl8jMG9HfeGTa3D2e2wLnSKKUyE4ONS3zAqeTbeyquQ00Z0V2H7M1C9kT6CN1szA5YCLUcuH6vIgt/5d2vA2dMIXgIEpYqIObi/6iL0z7FlyE+4hpRpwHXwLcfiCnvNQ55GrC7F0+YlDXuf9wDXaVt4PUpALVsI38TihWMEwQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651399; c=relaxed/simple;
	bh=9j1OIZejLefmmKyhnYsUFGpVmUAOqH5O/Vj6lACD6GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLej8D6NsKGaGy6P6pDpQ58F20qvlxNRm+eEQYlzTEsHCF0YeLfENvjENTDH9AGzMvbdxY19+OMW7Yeg8olHo0inZF3gcFfHYJj3QS7DvKGXUqnS+9AvIUD5hFTgXkFRFfDRbExsLheAhC4VbftB8SH79Un21tp9c9WnRcn2rIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3be3753e002so1383157b6e.1;
        Tue, 30 Jan 2024 13:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651397; x=1707256197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5N8iE07qnVQFaiEZk1v63nlXY8tM38tqiHwS7uEhgk=;
        b=CLDkxBvniIe5ln7H62bcasmkRPFWIVfRUVaDfKiVRg8ssMRi21J1Ae88dXwiuMKsVu
         ipDfBcyIIe0sQvLsQwTVgUKequtA1u2B7mPjaeu5W4XbnUrpJldtmQtheEmyFp2hf914
         hHnwdqeQ8zPGYcUylrWWV9Ih5r03/oc5QEwkDZIPZkPZ2fuEULCds0Wch9zyEjvXt0hL
         k4XB/IDc3sTv72nsArcI1EbuswsHECaWXNOXEJD5sHgLvnvmFmCsVDHsKnq2N9e/eqAw
         pfB0s5CU2yuIwTEWrmBlKlcMOn9gZ/TV38pOccDo3tGYzD1mxIDxBSL9UW4znEwGUBrR
         kGLA==
X-Gm-Message-State: AOJu0YxBOZ7q9Qsm0Q8OjbvhZh5FEWBE+JaWIs72CQPBMejZSLtW6UcH
	QJl7HvGFvb0cgIaqwsHtTGKugWPSXRpOkVPtHRKf5IhqCeKGVXyXJ3f/eNgM
X-Google-Smtp-Source: AGHT+IFE3BIOzwvLSsV+kvt7BtyyloFOHaDK1gQ4rlFxi1Bhg2GzDq+SIbHnnzonrCQ21RxHju4DZQ==
X-Received: by 2002:a05:6358:2c83:b0:178:70ac:5a4f with SMTP id l3-20020a0563582c8300b0017870ac5a4fmr5826413rwm.27.1706651396766;
        Tue, 30 Jan 2024 13:49:56 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:56 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v9 13/19] scsi: scsi_debug: Support the block limits extension VPD page
Date: Tue, 30 Jan 2024 13:48:39 -0800
Message-ID: <20240130214911.1863909-14-bvanassche@acm.org>
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

From SBC-5 r05:

"Reduced stream control:
a) reduces the maximum number of streams that the device server supports;
   and
b) increases the number of write commands that are able to specify a stream
   to be written in any write command that contains the GROUP NUMBER field
   in its CDB.

If the RSCS bit (see 6.6.5) is set to one, then the device server shall:
a) support per group stream identifier usage as described in 4.32.2;
b) support the IO Advice Hints Grouping mode page (see 6.5.7); and
c) set the MAXIMUM NUMBER OF STREAMS field (see 6.6.5) to a value that is
   less than 64.

Device servers that set the RSCS bit to one may support other features
(e.g., permanent streams (see 4.32.4)).

4.32.4 Permanent streams

A permanent stream is a stream for which the device server does not allow
closing or otherwise modifying the configuration of that stream. The PERM
bit (see 5.9.2.3) indicates whether a stream is a permanent stream. If a
STREAM CONTROL command (see 5.32) specifies the closing of a permanent
stream, the device server terminates that command with CHECK CONDITION
status instead of closing the specified stream. A permanent stream is always
an open stream. Device severs should assign the lowest numbered stream
identifiers to permanent streams."

Report that reduced stream control is supported.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 994a2b829b94..8dba838ef983 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1867,6 +1867,19 @@ static int inquiry_vpd_b6(struct sdebug_dev_info *devip, unsigned char *arr)
 	return 0x3c;
 }
 
+#define SDEBUG_BLE_LEN_AFTER_B4 28	/* thus vpage 32 bytes long */
+
+enum { MAXIMUM_NUMBER_OF_STREAMS = 6, PERMANENT_STREAM_COUNT = 5 };
+
+/* Block limits extension VPD page (SBC-4) */
+static int inquiry_vpd_b7(unsigned char *arrb4)
+{
+	memset(arrb4, 0, SDEBUG_BLE_LEN_AFTER_B4);
+	arrb4[1] = 1; /* Reduced stream control support (RSCS) */
+	put_unaligned_be16(MAXIMUM_NUMBER_OF_STREAMS, &arrb4[2]);
+	return SDEBUG_BLE_LEN_AFTER_B4;
+}
+
 #define SDEBUG_LONG_INQ_SZ 96
 #define SDEBUG_MAX_INQ_ARR_SZ 584
 
@@ -1932,6 +1945,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 					arr[n++] = 0xb2;  /* LB Provisioning */
 				if (is_zbc)
 					arr[n++] = 0xb6;  /* ZB dev. char. */
+				arr[n++] = 0xb7;  /* Block limits extension */
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
@@ -1974,6 +1988,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
+		} else if (cmd[2] == 0xb7) { /* block limits extension page */
+			arr[3] = inquiry_vpd_b7(&arr[4]);
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
 			kfree(arr);

