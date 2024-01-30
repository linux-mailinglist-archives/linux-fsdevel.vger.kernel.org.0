Return-Path: <linux-fsdevel+bounces-9583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEED3842F16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB51F21FA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBA7C582;
	Tue, 30 Jan 2024 21:50:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE157C571;
	Tue, 30 Jan 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651403; cv=none; b=NIFEfFMInpqXaRfkDwSwXtpkFP6FiFvIShmFj99Tk61LvG6l+9n8KRy61suy8GiK+lgS3RcL+oECQq8vE65Jf+dQmmGPGbNrZu3RmJSTBiD3uMc9JnNZn2lMAppKIDK//PozSgQw+NRFHSzKZVdVNVwCIbk7Q1wXhB1WiQXwooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651403; c=relaxed/simple;
	bh=1me+1Iv1gWQ+ySDhaIkrWsKCsTYqu1di4VIRAFR4faQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jle3uPeE6HS7GeGmvlBlU8/VWMO7Vj3gkE14PTffqs45ncUhiOJVIr9duNIDgLH/pQPKLuMAAJKIYX5jLO78IjR1RwBYPs5VaMi98g9L+O/juR0YD6oii1F70RdcuUq5v99iztOER0vAumxHn/VPZF/S5Ii2/z6FSUkN6ldMNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd72353d9fso3299962b6e.3;
        Tue, 30 Jan 2024 13:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651401; x=1707256201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3J+SA4hd8ZssMKvGLhLa01/X8dHvroLM2Zuh1UtpU4=;
        b=qNc4OV2E+5xxIf/+ZVrC4//96rel3DGZPgmm22d5bhPG67Za2K1JK/EFzP+MKgRbyt
         Y4nrFk/uFA7fHpRg9i8STo4CCyeL0Qv60Xl9vox/NX/A31KYOCm6fUyOyMIDPjY/c6dx
         oKF05fK1U8RVDtYiQbI8bUlmEfkYGvMJ7an5cU0sV/c8XKESbc1eyURtxTfhwHklfGc5
         YxMbrnZu/RWSvyJ3UFiIhQV+0i+uNVnS+LuH6bC2b27pGo+qXxdEp4uG2qFqg0KbFh47
         xtxn9TzZE3dsm3HF0sbA7l2vBVZOUd0NNg8XZROMys0QR6YpI5FttRT9syeVfMtHJ5/3
         P3lg==
X-Gm-Message-State: AOJu0YwqPKjbKKLnryeYmCYh516cqYSqfl7ba5oLzPNQb2qdE0YX3rZe
	QDjdUp3Fqmt6RvZk+eKdh1TDLiaUD4YJZCQ/Dab+Hlm/V/EOTEq/
X-Google-Smtp-Source: AGHT+IHl1vj4lNZ9Pq2BDgQ4qcbWSc+UtZ3IWo3it+19tM8fb1lzBn87904Djl94pq6GpNMjOWMilw==
X-Received: by 2002:a05:6808:114d:b0:3bd:bba6:9b14 with SMTP id u13-20020a056808114d00b003bdbba69b14mr14402325oiu.27.1706651401143;
        Tue, 30 Jan 2024 13:50:01 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:50:00 -0800 (PST)
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
Subject: [PATCH v9 16/19] scsi: scsi_debug: Allocate the MODE SENSE response from the heap
Date: Tue, 30 Jan 2024 13:48:42 -0800
Message-ID: <20240130214911.1863909-17-bvanassche@acm.org>
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

Make the MODE SENSE response buffer larger and allocate it from the heap.
This patch prepares for adding support for the IO Advice Hints Grouping
mode page.

Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 67a8e6243e5e..b544498324f6 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -43,6 +43,7 @@
 #include <linux/prefetch.h>
 #include <linux/debugfs.h>
 #include <linux/async.h>
+#include <linux/cleanup.h>
 
 #include <net/checksum.h>
 
@@ -2631,7 +2632,8 @@ static int resp_sas_sha_m_spg(unsigned char *p, int pcontrol)
 	return sizeof(sas_sha_m_pg);
 }
 
-#define SDEBUG_MAX_MSENSE_SZ 256
+/* PAGE_SIZE is more than necessary but provides room for future expansion. */
+#define SDEBUG_MAX_MSENSE_SZ PAGE_SIZE
 
 static int resp_mode_sense(struct scsi_cmnd *scp,
 			   struct sdebug_dev_info *devip)
@@ -2642,10 +2644,13 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	int target_dev_id;
 	int target = scp->device->id;
 	unsigned char *ap;
-	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
+	unsigned char *arr __free(kfree);
 	unsigned char *cmd = scp->cmnd;
 	bool dbd, llbaa, msense_6, is_disk, is_zbc;
 
+	arr = kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
+	if (!arr)
+		return -ENOMEM;
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */
 	pcontrol = (cmd[2] & 0xc0) >> 6;
 	pcode = cmd[2] & 0x3f;

