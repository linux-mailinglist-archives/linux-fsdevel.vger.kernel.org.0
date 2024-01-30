Return-Path: <linux-fsdevel+bounces-9576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B3842F00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2100C28483B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CCB7AE71;
	Tue, 30 Jan 2024 21:49:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD978667;
	Tue, 30 Jan 2024 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651387; cv=none; b=fpE4kURi8K1XJF8YcxPvzL9rCCJrI8P1JhXgku+YFCf2hbaMG9MqmYAsx+UzqM5twFZ5ok+2+SKbEW+c96X/xNXKctvtQWXbn07pU1fsNGPbjq+hfjcgM0I8DmN4lhH3GrGSKYBJTadBK7uICHmIQKNYal8gS/FOGx5qajmM+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651387; c=relaxed/simple;
	bh=D5eS+8sUdMu96G4S4r6zJGm9swC5GaAyWtY6saZ5xp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvY0N+A9cXAKUP6Iy0EEOOkva75TZqlaCqCr9V25GYXYYZdMCGaI2ZZ/B095Rk/VQ77DfcqbVkWpv2WwFpAbNlqNSLv+Zi8mTfER/XoZonM0YUbxCO2JWoWNgsad+x2er5vtS6zB53ku6+xa8o83WZyeduR/bQf30HmmF7iM+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59927972125so2603765eaf.3;
        Tue, 30 Jan 2024 13:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651385; x=1707256185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA1ddFZJk14FiW69Kd5w4wFf8ei2zMcA76pCnpHDGCQ=;
        b=wGPFbZtX221yDHa1G+8uWeKl5JIj0tgQR9BHhxA+8fPBtO0ONx+oY976UDka1Nwug5
         7/qtoU+8kDEDSsJaUzaIjxvycFZQN2iBbMgWkmPu4TYDNxvfQRvOvUkXHAiXmXcehv6W
         DeCWb35hvl/AgTJKvSTy65EnnZtWQsr7qbbcvAcasQxioLR16cVf+gBzv0kcg+cpaLGA
         fwFUpDEXRjRgjUxg0SSJux9khp4ECwTEfjuaeLnq9FE+rkB6Q9SoaEFDkFZayxB8QY/F
         OnNnRJvN/Xa+YRo6yZONolE+iZzOw3Q9b6h1rRpoIEkDJSSdm1OZRQJR0eApSSv5uY9K
         hDUQ==
X-Gm-Message-State: AOJu0Yzu6+47BGCh5gHIhJamqVBE7SPNTmElN983dZ4AW38dEZrBQOBA
	fIZeaPdDYrHlKjuZFCtjalvcH+57VW8pKufOEVWIIL/vSsLA87Es
X-Google-Smtp-Source: AGHT+IFroVwhS91ke0M4F+VvFCNmJYwlEBSmdGtBTKW3ebOu2yj0BEvy9KPEi2FujwMtZs6ai2O/1A==
X-Received: by 2002:a05:6359:4c1d:b0:176:8248:a219 with SMTP id kj29-20020a0563594c1d00b001768248a219mr7865722rwc.8.1706651385299;
        Tue, 30 Jan 2024 13:49:45 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:44 -0800 (PST)
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
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v9 09/19] scsi: core: Query the Block Limits Extension VPD page
Date: Tue, 30 Jan 2024 13:48:35 -0800
Message-ID: <20240130214911.1863909-10-bvanassche@acm.org>
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

Parse the Reduced Stream Control Supported (RSCS) bit from the block
limits extension VPD page. The RSCS bit is defined in SBC-5 r05
(https://www.t10.org/cgi-bin/ac.pl?t=f&f=sbc5r05.pdf).

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Daejun Park <daejun7.park@samsung.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c        |  2 ++
 drivers/scsi/scsi_sysfs.c  | 10 ++++++++++
 drivers/scsi/sd.c          | 13 +++++++++++++
 drivers/scsi/sd.h          |  1 +
 include/scsi/scsi_device.h |  1 +
 5 files changed, 27 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 76d369343c7a..74cc3369dd8d 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -499,6 +499,8 @@ void scsi_attach_vpd(struct scsi_device *sdev)
 			scsi_update_vpd_page(sdev, 0xb1, &sdev->vpd_pgb1);
 		if (vpd_buf->data[i] == 0xb2)
 			scsi_update_vpd_page(sdev, 0xb2, &sdev->vpd_pgb2);
+		if (vpd_buf->data[i] == 0xb7)
+			scsi_update_vpd_page(sdev, 0xb7, &sdev->vpd_pgb7);
 	}
 	kfree(vpd_buf);
 }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..93652a786a46 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -449,6 +449,7 @@ static void scsi_device_dev_release(struct device *dev)
 	struct scsi_vpd *vpd_pg80 = NULL, *vpd_pg83 = NULL;
 	struct scsi_vpd *vpd_pg0 = NULL, *vpd_pg89 = NULL;
 	struct scsi_vpd *vpd_pgb0 = NULL, *vpd_pgb1 = NULL, *vpd_pgb2 = NULL;
+	struct scsi_vpd *vpd_pgb7 = NULL;
 	unsigned long flags;
 
 	might_sleep();
@@ -494,6 +495,8 @@ static void scsi_device_dev_release(struct device *dev)
 				       lockdep_is_held(&sdev->inquiry_mutex));
 	vpd_pgb2 = rcu_replace_pointer(sdev->vpd_pgb2, vpd_pgb2,
 				       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pgb7 = rcu_replace_pointer(sdev->vpd_pgb7, vpd_pgb7,
+				       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg0)
@@ -510,6 +513,8 @@ static void scsi_device_dev_release(struct device *dev)
 		kfree_rcu(vpd_pgb1, rcu);
 	if (vpd_pgb2)
 		kfree_rcu(vpd_pgb2, rcu);
+	if (vpd_pgb7)
+		kfree_rcu(vpd_pgb7, rcu);
 	kfree(sdev->inquiry);
 	kfree(sdev);
 
@@ -921,6 +926,7 @@ sdev_vpd_pg_attr(pg89);
 sdev_vpd_pg_attr(pgb0);
 sdev_vpd_pg_attr(pgb1);
 sdev_vpd_pg_attr(pgb2);
+sdev_vpd_pg_attr(pgb7);
 sdev_vpd_pg_attr(pg0);
 
 static ssize_t show_inquiry(struct file *filep, struct kobject *kobj,
@@ -1295,6 +1301,9 @@ static umode_t scsi_sdev_bin_attr_is_visible(struct kobject *kobj,
 	if (attr == &dev_attr_vpd_pgb2 && !sdev->vpd_pgb2)
 		return 0;
 
+	if (attr == &dev_attr_vpd_pgb7 && !sdev->vpd_pgb7)
+		return 0;
+
 	return S_IRUGO;
 }
 
@@ -1347,6 +1356,7 @@ static struct bin_attribute *scsi_sdev_bin_attrs[] = {
 	&dev_attr_vpd_pgb0,
 	&dev_attr_vpd_pgb1,
 	&dev_attr_vpd_pgb2,
+	&dev_attr_vpd_pgb7,
 	&dev_attr_inquiry,
 	NULL
 };
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a54cd1864a92..463b201a3109 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3166,6 +3166,18 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	rcu_read_unlock();
 }
 
+/* Parse the Block Limits Extension VPD page (0xb7) */
+static void sd_read_block_limits_ext(struct scsi_disk *sdkp)
+{
+	struct scsi_vpd *vpd;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdkp->device->vpd_pgb7);
+	if (vpd && vpd->len >= 2)
+		sdkp->rscs = vpd->data[5] & 1;
+	rcu_read_unlock();
+}
+
 /**
  * sd_read_block_characteristics - Query block dev. characteristics
  * @sdkp: disk to query
@@ -3517,6 +3529,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);
+			sd_read_block_limits_ext(sdkp);
 			sd_read_block_characteristics(sdkp);
 			sd_zbc_read_zones(sdkp, buffer);
 			sd_read_cpr(sdkp);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..e4539122f2a2 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -151,6 +151,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
+	bool		rscs : 1; /* reduced stream control support */
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 4dceabb9dbe1..ea494a0114e8 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -153,6 +153,7 @@ struct scsi_device {
 	struct scsi_vpd __rcu *vpd_pgb0;
 	struct scsi_vpd __rcu *vpd_pgb1;
 	struct scsi_vpd __rcu *vpd_pgb2;
+	struct scsi_vpd __rcu *vpd_pgb7;
 
 	struct scsi_target      *sdev_target;
 

