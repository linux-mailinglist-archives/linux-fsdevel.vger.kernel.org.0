Return-Path: <linux-fsdevel+bounces-9579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A666842F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5776285C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5412836C;
	Tue, 30 Jan 2024 21:49:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B87B3E5;
	Tue, 30 Jan 2024 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651397; cv=none; b=XwcavVvxajx/AfTMWTSepCQSsrnFSq6sbMNJaReOnAH1KhCQpngELr8ZYC0Y6ZaxeO6P2IYMsoJ4W3RowIR/XqvfTuSchRItEJdCkofGPGma5pvXHdZ6rpLc3JKaXQKp9Avz9aUFmkzsM733w/atlpMgyxKYcK9LBRpBPAJt1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651397; c=relaxed/simple;
	bh=NRWB0MH4m/IUovEopQ6ElDI+3dhyj7AyAQBKuqacQ04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoicAk2ynAjFqk6Cmj1Tcf94+OFTFlZfXL3v8LZttf8ROJmgZA9lyQuz3SFSA6jQwIZI3cNeWF/jF6qDbxOBIvbrZRFGVVywyCJzYBAom0kbudz2NfUX0HvSWKPTdSH7QDy4bmalJsCaBtkIcGDg0UqAkUZM4T78n4J9aVwQyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d835c7956bso2561113a12.2;
        Tue, 30 Jan 2024 13:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651395; x=1707256195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgB1skCz3ID5eK3mNkQJNqQ8QM1ptCB2xTyXRT8/Kho=;
        b=ezmaF14nhRkR4CcIeuIsUD4Rhic7n6eJhNWZ8J2N33cU4Fh4463NLwfyXR3nZizd42
         jvfgEIExJ0h+i7P+d2a0ycn7ozjGY5SE8mZsdu7GcSUyx3TRtDVplFCIwCtjtuh+md1D
         cp/eyUJIo4txwMUnKQa2Gy0ZvXy+V8MHKtDAikDBJ0c3y0Q/tv5ax1BDaEzM+6TtzRqS
         xFdWzgXnT1i6o16YcSA768H48tJiIIV+c4NxxNV0ECSrcEF3Yv6x+8Vkdt5jYBmQLYoA
         /8RXXG9tbggGOHi80Yef7yXlkVdxktokX3sTsiAzx2dtcm8QT+9yZBxV+WmbJbQSWBIJ
         MBog==
X-Gm-Message-State: AOJu0YwsDQvhF3rrhScaPICq54295w6SQef489L+sYDKKNmCqXYT7ms7
	bKkBsfCNdSbuCAbO7lf4Cp81H4z3GkSX+ezLlvP/1ne3mhGcN5bU
X-Google-Smtp-Source: AGHT+IGeauOVxVXYO+il1ZbWcSIWer7+4CWnTPKuEDf6+kD7Z3DoHEZd7aeTM1Q8f8EmyaiXQST+2Q==
X-Received: by 2002:a05:6a20:6114:b0:19c:922b:13e5 with SMTP id m20-20020a056a20611400b0019c922b13e5mr4604107pzb.59.1706651395252;
        Tue, 30 Jan 2024 13:49:55 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:54 -0800 (PST)
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
	Avri Altman <avri.altman@wdc.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v9 12/19] scsi: scsi_debug: Reduce code duplication
Date: Tue, 30 Jan 2024 13:48:38 -0800
Message-ID: <20240130214911.1863909-13-bvanassche@acm.org>
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

All VPD pages have the page code in byte one. Reduce code duplication by
storing the VPD page code once.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d03d66f11493..994a2b829b94 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1903,7 +1903,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		u32 len;
 		char lu_id_str[6];
 		int host_no = devip->sdbg_host->shost->host_no;
-		
+
+		arr[1] = cmd[2];
 		port_group_id = (((host_no + 1) & 0x7f) << 8) +
 		    (devip->channel & 0x7f);
 		if (sdebug_vpd_use_hostno == 0)
@@ -1914,7 +1915,6 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				 (devip->target * 1000) - 3;
 		len = scnprintf(lu_id_str, 6, "%d", lu_id_num);
 		if (0 == cmd[2]) { /* supported vital product data pages */
-			arr[1] = cmd[2];	/*sanity */
 			n = 4;
 			arr[n++] = 0x0;   /* this page */
 			arr[n++] = 0x80;  /* unit serial number */
@@ -1935,23 +1935,18 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = len;
 			memcpy(&arr[4], lu_id_str, len);
 		} else if (0x83 == cmd[2]) { /* device identification */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_83(&arr[4], port_group_id,
 						target_dev_id, lu_id_num,
 						lu_id_str, len,
 						&devip->lu_name);
 		} else if (0x84 == cmd[2]) { /* Software interface ident. */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_84(&arr[4]);
 		} else if (0x85 == cmd[2]) { /* Management network addresses */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_85(&arr[4]);
 		} else if (0x86 == cmd[2]) { /* extended inquiry */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = 0x3c;	/* number of following entries */
 			if (sdebug_dif == T10_PI_TYPE3_PROTECTION)
 				arr[4] = 0x4;	/* SPT: GRD_CHK:1 */
@@ -1961,30 +1956,23 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				arr[4] = 0x0;   /* no protection stuff */
 			arr[5] = 0x7;   /* head of q, ordered + simple q's */
 		} else if (0x87 == cmd[2]) { /* mode page policy */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = 0x8;	/* number of following entries */
 			arr[4] = 0x2;	/* disconnect-reconnect mp */
 			arr[6] = 0x80;	/* mlus, shared */
 			arr[8] = 0x18;	 /* protocol specific lu */
 			arr[10] = 0x82;	 /* mlus, per initiator port */
 		} else if (0x88 == cmd[2]) { /* SCSI Ports */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_88(&arr[4], target_dev_id);
 		} else if (is_disk_zbc && 0x89 == cmd[2]) { /* ATA info */
-			arr[1] = cmd[2];        /*sanity */
 			n = inquiry_vpd_89(&arr[4]);
 			put_unaligned_be16(n, arr + 2);
 		} else if (is_disk_zbc && 0xb0 == cmd[2]) { /* Block limits */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b0(&arr[4]);
 		} else if (is_disk_zbc && 0xb1 == cmd[2]) { /* Block char. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b1(devip, &arr[4]);
 		} else if (is_disk && 0xb2 == cmd[2]) { /* LB Prov. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);

