Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DB507EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358974AbiDTCix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358977AbiDTCir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3853E37A92
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422162; x=1681958162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JaOPQxjAv37YreF1OUOcoAOV+XEVwZrUj/Hl9dyAVq8=;
  b=CCp4G6m54xGchopIKzneEe5GX4Y7Y4vhqyFHizWv+6EKfrurtu/OwRyh
   w95YkE25V3CYSSqKCwyFlqrTv8U2vnVSQZfjrjtSd0gbC3fHvfb4Uq61o
   kMBGya5oObDrGWqxrdeD9R+bgxiLOJIL77i9eVteHIRYBZBqoBX8q6P9q
   M2BbYNBb0BVrNlInu5UWyDWbNCFKSXwmYEAizs5gCYPjjHJ8A5Zudl2JC
   yRTVDsXgphsjAxRfp888/M+uUU1BehyN5Udq2v/pnkcFu0dbSklH8Cw5Z
   dpQnyxs/mpgR7FUe2TMt36gdG3F5QknZ4nXI5bKn/GyocY7d0aRoISjQY
   A==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="310291664"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:51 +0800
IronPort-SDR: fGdQ2C1dFgzsjhHIs2bjzEHF73btWvbwXZ3n88GUDqGw480kqVoQY1msW1UEp4wxGawMILQY0B
 iaG1Zv4/0LedU/6sceT3i9N7XymPKzCc2dLiNQQC4n3O6tW4V+NiMWcaTuOVLP/3OsXj/faToo
 3e2VBrqbXGCoZ+6ql8PzO85tCT2XoDWWHyikRc0ax4LrN+8S9EXVzk7H9V/LzoJD/90sInza5A
 YqQLm1ElJMLCXJhcHdqOC7UqtGSXcj8egSID4ElkmT+VFlfc0C2oFMwyUWgvCnLGi9Kx4xyB8c
 mvmDdMAP45rDaowevhvfH2c+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:10 -0700
IronPort-SDR: 0lwpr//NU55ykO3QQA3afS5z9NpGTQaEeWzaVundhqM/Yn7iDuES+xOYpPFK7zhs65KQFpef33
 0NtWxmQ9iBSTdlMJPfPFtQu5eOeq+AFP4RZHgZhTpAYo1qKzQiwOZ085En3psJvXvYPzY53B9T
 7nauFHV1jJKFO0DP35enot45DRxX+ryNvIWUGAy1jp5r+A/TwetM0s14uGELLu99ypk+JX3DPh
 t9wlJG7YkR4bRtDJN2Ec3J5MO8W/YoFkbO4neqyL1Fz09/NucuRcgtCVtgMI3DJxEwhe0k1PoA
 Ipk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCW2mHXz1SVnx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422150; x=1653014151; bh=JaOPQxjAv37YreF1OU
        OcoAOV+XEVwZrUj/Hl9dyAVq8=; b=aAFzGEPtuMlmj23Ij4goqgTPf4bAlEnsnO
        PWDsBKpc5HuKiRy4lppqjW2KsvIQAcFSIFAb7vo0Hc1NHcltMQQ1AA0Tz5HNB6pb
        vEG69st3MfFf8Xl4vR5YXwvtMWAVNlk83o63qUrM4lTtN+M4Gg3HogyQcMg1mAeW
        l05Y+MHGS2C205SxZ0+kmnv5TeHTxZ9clskvdeinYjg0PyPgk5PVDL/I8E9nayFS
        Faz1k6Nh4N78cyoO3chEO6CBS/iX+q47TKf4WmmDTkOqKU2sBAYJGQQ650gmXUpR
        XUo5pUtfvfYdA4U8NiqgNJQPw8+lQiq1Fzqc7C9PGYG0nydNOWyA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gdhU50yPHAlr for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:50 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCV2tkbz1Rvlx;
        Tue, 19 Apr 2022 19:35:50 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/8] zonefs: Export open zone resource information through sysfs
Date:   Wed, 20 Apr 2022 11:35:42 +0900
Message-Id: <20220420023545.3814998-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To allow applications to easily check the current usage status of the
open zone resources of the mounted device, export through sysfs the
counter of write open sequential files s_wro_seq_files field of
struct zonefs_sb_info. The attribute is named nr_wro_seq_files and is
read only.

The maximum number of write open sequential files (zones) indicated by
the s_max_wro_seq_files field of struct zonefs_sb_info is also exported
as the read only attribute max_wro_seq_files.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/Makefile |   2 +-
 fs/zonefs/super.c  |  24 +++++++--
 fs/zonefs/sysfs.c  | 125 +++++++++++++++++++++++++++++++++++++++++++++
 fs/zonefs/zonefs.h |  10 ++++
 4 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100644 fs/zonefs/sysfs.c

diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile
index 33c1a4f1132e..9fe54f5319f2 100644
--- a/fs/zonefs/Makefile
+++ b/fs/zonefs/Makefile
@@ -3,4 +3,4 @@ ccflags-y				+=3D -I$(src)
=20
 obj-$(CONFIG_ZONEFS_FS) +=3D zonefs.o
=20
-zonefs-y	:=3D super.o
+zonefs-y	:=3D super.o sysfs.o
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 02dbdec32b2f..aa359f27102e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1725,6 +1725,10 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)
 	if (ret)
 		goto cleanup;
=20
+	ret =3D zonefs_sysfs_register(sb);
+	if (ret)
+		goto cleanup;
+
 	zonefs_info(sb, "Mounting %u zones",
 		    blkdev_nr_zones(sb->s_bdev->bd_disk));
=20
@@ -1770,6 +1774,8 @@ static void zonefs_kill_super(struct super_block *s=
b)
=20
 	if (sb->s_root)
 		d_genocide(sb->s_root);
+
+	zonefs_sysfs_unregister(sb);
 	kill_block_super(sb);
 	kfree(sbi);
 }
@@ -1817,16 +1823,26 @@ static int __init zonefs_init(void)
 		return ret;
=20
 	ret =3D register_filesystem(&zonefs_type);
-	if (ret) {
-		zonefs_destroy_inodecache();
-		return ret;
-	}
+	if (ret)
+		goto destroy_inodecache;
+
+	ret =3D zonefs_sysfs_init();
+	if (ret)
+		goto unregister_fs;
=20
 	return 0;
+
+unregister_fs:
+	unregister_filesystem(&zonefs_type);
+destroy_inodecache:
+	zonefs_destroy_inodecache();
+
+	return ret;
 }
=20
 static void __exit zonefs_exit(void)
 {
+	zonefs_sysfs_exit();
 	zonefs_destroy_inodecache();
 	unregister_filesystem(&zonefs_type);
 }
diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
new file mode 100644
index 000000000000..eaeaf983ed87
--- /dev/null
+++ b/fs/zonefs/sysfs.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Simple file system for zoned block devices exposing zones as files.
+ *
+ * Copyright (C) 2022 Western Digital Corporation or its affiliates.
+ */
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/blkdev.h>
+
+#include "zonefs.h"
+
+struct zonefs_sysfs_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct zonefs_sb_info *sbi, char *buf);
+};
+
+static inline struct zonefs_sysfs_attr *to_attr(struct attribute *attr)
+{
+	return container_of(attr, struct zonefs_sysfs_attr, attr);
+}
+
+#define ZONEFS_SYSFS_ATTR_RO(name) \
+static struct zonefs_sysfs_attr zonefs_sysfs_attr_##name =3D __ATTR_RO(n=
ame)
+
+#define ATTR_LIST(name) &zonefs_sysfs_attr_##name.attr
+
+static ssize_t zonefs_sysfs_attr_show(struct kobject *kobj,
+				      struct attribute *attr, char *buf)
+{
+	struct zonefs_sb_info *sbi =3D
+		container_of(kobj, struct zonefs_sb_info, s_kobj);
+	struct zonefs_sysfs_attr *zonefs_attr =3D
+		container_of(attr, struct zonefs_sysfs_attr, attr);
+
+	if (!zonefs_attr->show)
+		return 0;
+
+	return zonefs_attr->show(sbi, buf);
+}
+
+static ssize_t max_wro_seq_files_show(struct zonefs_sb_info *sbi, char *=
buf)
+{
+	return sysfs_emit(buf, "%u\n", sbi->s_max_wro_seq_files);
+}
+ZONEFS_SYSFS_ATTR_RO(max_wro_seq_files);
+
+static ssize_t nr_wro_seq_files_show(struct zonefs_sb_info *sbi, char *b=
uf)
+{
+	return sysfs_emit(buf, "%d\n", atomic_read(&sbi->s_wro_seq_files));
+}
+ZONEFS_SYSFS_ATTR_RO(nr_wro_seq_files);
+
+static struct attribute *zonefs_sysfs_attrs[] =3D {
+	ATTR_LIST(max_wro_seq_files),
+	ATTR_LIST(nr_wro_seq_files),
+	NULL,
+};
+ATTRIBUTE_GROUPS(zonefs_sysfs);
+
+static void zonefs_sysfs_sb_release(struct kobject *kobj)
+{
+	struct zonefs_sb_info *sbi =3D
+		container_of(kobj, struct zonefs_sb_info, s_kobj);
+
+	complete(&sbi->s_kobj_unregister);
+}
+
+static const struct sysfs_ops zonefs_sysfs_attr_ops =3D {
+	.show	=3D zonefs_sysfs_attr_show,
+};
+
+static struct kobj_type zonefs_sb_ktype =3D {
+	.default_groups =3D zonefs_sysfs_groups,
+	.sysfs_ops	=3D &zonefs_sysfs_attr_ops,
+	.release	=3D zonefs_sysfs_sb_release,
+};
+
+static struct kobject *zonefs_sysfs_root;
+
+int zonefs_sysfs_register(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+	int ret;
+
+	init_completion(&sbi->s_kobj_unregister);
+	ret =3D kobject_init_and_add(&sbi->s_kobj, &zonefs_sb_ktype,
+				   zonefs_sysfs_root, "%s", sb->s_id);
+	if (ret) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+		return ret;
+	}
+
+	sbi->s_sysfs_registered =3D true;
+
+	return 0;
+}
+
+void zonefs_sysfs_unregister(struct super_block *sb)
+{
+	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);
+
+	if (!sbi || !sbi->s_sysfs_registered)
+		return;
+
+	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+}
+
+int __init zonefs_sysfs_init(void)
+{
+	zonefs_sysfs_root =3D kobject_create_and_add("zonefs", fs_kobj);
+	if (!zonefs_sysfs_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void zonefs_sysfs_exit(void)
+{
+	kobject_put(zonefs_sysfs_root);
+	zonefs_sysfs_root =3D NULL;
+}
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 67fd00ab173f..77d2d153c59d 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -12,6 +12,7 @@
 #include <linux/uuid.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
+#include <linux/kobject.h>
=20
 /*
  * Maximum length of file names: this only needs to be large enough to f=
it
@@ -184,6 +185,10 @@ struct zonefs_sb_info {
=20
 	unsigned int		s_max_wro_seq_files;
 	atomic_t		s_wro_seq_files;
+
+	bool			s_sysfs_registered;
+	struct kobject		s_kobj;
+	struct completion	s_kobj_unregister;
 };
=20
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
@@ -198,4 +203,9 @@ static inline struct zonefs_sb_info *ZONEFS_SB(struct=
 super_block *sb)
 #define zonefs_warn(sb, format, args...)	\
 	pr_warn("zonefs (%s) WARNING: " format, sb->s_id, ## args)
=20
+int zonefs_sysfs_register(struct super_block *sb);
+void zonefs_sysfs_unregister(struct super_block *sb);
+int zonefs_sysfs_init(void);
+void zonefs_sysfs_exit(void);
+
 #endif
--=20
2.35.1

