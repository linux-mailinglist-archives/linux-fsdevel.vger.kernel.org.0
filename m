Return-Path: <linux-fsdevel+bounces-9584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A0842F19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F6928688B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C27866B;
	Tue, 30 Jan 2024 21:50:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12207C577;
	Tue, 30 Jan 2024 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651405; cv=none; b=PcyG95DtN6l58EgOsnuC9P+RcAu1T8o59Wd3+he2OXOW8ssU9Jv/TilvM7R+oSwgrDLBBz12j4K7ktSvEs5j9a4NDnI8ekdob6zALQhmAfC9AT9Ea3jE8iY0HhHcbUeASQOr8hVgk9jBgs0+mTAx2IyqqGvT0UCLcJY1ffhvj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651405; c=relaxed/simple;
	bh=Zf0R25Rg1mXeSROfgZKxHfIZKaY0FWVp6rdNT8OKDps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9/Em5L8aoma9Axjaa1NYomwoTJ4aFD92nC1my+/Jhs65QoKIcz1YAwW1QDV70aIlMbQeISxhZhhU36FF9v8osq7Z+gM5nnujv4aFk+0BcryTmnppmVUGs/FRIGy23as/13qQr15pSXd5fkp3UP41WKXFTL+vpdlbLRbFoPsNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bb9d54575cso3304795b6e.2;
        Tue, 30 Jan 2024 13:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651403; x=1707256203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+HWSlaiIpcKUI/XYMTeimlVB+yEtY/A7WgNkX4Hy3o=;
        b=bowHmSakdUHW+261KgiMKiyqMLFNBlfVul6MsSLHOQzL1JOiMjGiUq+Z5Uv+2oy0Hu
         7XYCgsLR/Eg41myo8KlbKgMRI8ftcFMG8fKKl8/6BymVjRQFteEeotnDGIIt/Bra9KzU
         9CCOw9lqDaIq8zGORkzvx/tFJQC24NiGYmTnrdGS2yC0ZRVp7Wwl3iekmi8PKGsn1ZgD
         jlj82tp+jce5UBRtn+/eOyYX17dR0Gq3Zow3MSBnJInA7Qt7N/83nI4TJK+NtJtL5WFa
         4KKFTZaIcWy1RQSoTmsM4qPm0fyfFcMIJhve9W7g0VqkmQCPo3B5u4qlJta1X2DAlcOW
         HSGw==
X-Gm-Message-State: AOJu0YzCEMRb4Nb+htiWC1O9qETIqKpyFoPUDIQSXLdXP7uf2g2hbbit
	E4jTg1ojzVtpKzFfuenQHD6T1fTeXLeg7LWzsnEHs77ziL50wxwZ
X-Google-Smtp-Source: AGHT+IHnuo9WrmQxK+oJpvRhZPRiDYlys4FL53FMKnnMZ/J2hwhIrfHpMBLtil4nzpi/aPh05b88tQ==
X-Received: by 2002:a05:6358:72a2:b0:178:65a3:8599 with SMTP id w34-20020a05635872a200b0017865a38599mr8229186rwf.51.1706651402654;
        Tue, 30 Jan 2024 13:50:02 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:50:02 -0800 (PST)
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
Subject: [PATCH v9 17/19] scsi: scsi_debug: Implement the IO Advice Hints Grouping mode page
Date: Tue, 30 Jan 2024 13:48:43 -0800
Message-ID: <20240130214911.1863909-18-bvanassche@acm.org>
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

Implement an IO Advice Hints Grouping mode page with three permanent
streams. A permanent stream is a stream for which the device server does
not allow closing or otherwise modifying the configuration of that
stream. The stream identifier enable (ST_ENBLE) bit specifies whether
the stream identifier may be used in the GROUP NUMBER field of SCSI
WRITE commands.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 61 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b544498324f6..ccf59b3e7602 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1969,7 +1969,11 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				arr[4] = 0x5;   /* SPT: GRD_CHK:1, REF_CHK:1 */
 			else
 				arr[4] = 0x0;   /* no protection stuff */
-			arr[5] = 0x7;   /* head of q, ordered + simple q's */
+			/*
+			 * GROUP_SUP=1; HEADSUP=1 (HEAD OF QUEUE); ORDSUP=1
+			 * (ORDERED queuing); SIMPSUP=1 (SIMPLE queuing).
+			 */
+			arr[5] = 0x17;
 		} else if (0x87 == cmd[2]) { /* mode page policy */
 			arr[3] = 0x8;	/* number of following entries */
 			arr[4] = 0x2;	/* disconnect-reconnect mp */
@@ -2559,6 +2563,40 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
+/* IO Advice Hints Grouping mode page */
+static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
+{
+	/* IO Advice Hints Grouping mode page */
+	struct grouping_m_pg {
+		u8 page_code;	/* OR 0x40 when subpage_code > 0 */
+		u8 subpage_code;
+		__be16 page_length;
+		u8 reserved[12];
+		struct scsi_io_group_descriptor descr[MAXIMUM_NUMBER_OF_STREAMS];
+	};
+	static const struct grouping_m_pg gr_m_pg = {
+		.page_code = 0xa | 0x40,
+		.subpage_code = 5,
+		.page_length = cpu_to_be16(sizeof(gr_m_pg) - 4),
+		.descr = {
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 0 },
+		}
+	};
+
+	BUILD_BUG_ON(sizeof(struct grouping_m_pg) !=
+		     16 + MAXIMUM_NUMBER_OF_STREAMS * 16);
+	memcpy(p, &gr_m_pg, sizeof(gr_m_pg));
+	if (1 == pcontrol) {
+		/* There are no changeable values so clear from byte 4 on. */
+		memset(p + 4, 0, sizeof(gr_m_pg) - 4);
+	}
+	return sizeof(gr_m_pg);
+}
 
 static int resp_iec_m_pg(unsigned char *p, int pcontrol, int target)
 {	/* Informational Exceptions control mode page for mode_sense */
@@ -2708,6 +2746,10 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		ap = arr + offset;
 	}
 
+	/*
+	 * N.B. If len>0 before resp_*_pg() call, then form of that call should be:
+	 *        len += resp_*_pg(ap + len, pcontrol, target);
+	 */
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
 		if (subpcode > 0x0 && subpcode < 0xff)
@@ -2742,9 +2784,20 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
-		if (subpcode > 0x0 && subpcode < 0xff)
+		switch (subpcode) {
+		case 0:
+			len = resp_ctrl_m_pg(ap, pcontrol, target);
+			break;
+		case 0x05:
+			len = resp_grouping_m_pg(ap, pcontrol, target);
+			break;
+		case 0xff:
+			len = resp_ctrl_m_pg(ap, pcontrol, target);
+			len += resp_grouping_m_pg(ap + len, pcontrol, target);
+			break;
+		default:
 			goto bad_subpcode;
-		len = resp_ctrl_m_pg(ap, pcontrol, target);
+		}
 		offset += len;
 		break;
 	case 0x19:	/* if spc==1 then sas phy, control+discover */
@@ -2778,6 +2831,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 			len += resp_caching_pg(ap + len, pcontrol, target);
 		}
 		len += resp_ctrl_m_pg(ap + len, pcontrol, target);
+		if (0xff == subpcode)
+			len += resp_grouping_m_pg(ap + len, pcontrol, target);
 		len += resp_sas_sf_m_pg(ap + len, pcontrol, target);
 		if (0xff == subpcode) {
 			len += resp_sas_pcd_m_spg(ap + len, pcontrol, target,

