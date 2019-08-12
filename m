Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17B38A396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfHLQnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:43:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41817 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHLQnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:43:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so2894881wrr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJzEMk4rMJkgBHZ/eT2zzOiZNWGN61BgNyzA7UZINCM=;
        b=VpRx8jWs0joHfgCVVJZ1T056UJ40OQmRjtIbzbpYgnBvEWJC0Iu//0xApNNlHMaZHJ
         pnV6y3YXR+JJilrtd8/LogeVuUEOdJeiuajU54fLvMinfYTwapQEKfyh0itKKggNEayD
         yviy0rxD6ddbxu8Bm05Q97V8vlX7F4ofESdv/1cmz+uOO+9NFTP5hPpEpMI9AJKi31Tn
         JsBT+RRcN2weYopvPPYlHr9LHcYM0wYkQ0US5qo5lKEXI73FRSC3w0OXHTCMAxn0rxCe
         OT+d8XCD9Eh1GyJr7papHfVVMmrZnA+owcpbtePUEkpKPDD1D8U21D7tM76xnJuaEP3B
         GKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJzEMk4rMJkgBHZ/eT2zzOiZNWGN61BgNyzA7UZINCM=;
        b=Pwwi+xrgukIjt59Q2C+pKFmKG3NZnAn77zAoTJPSb+Ms35higRFYblpqJ4uBKL4f/W
         4owvCa6ac3hvmNRNkhOaoLCfxacCpRSXNBq3R24IBj8H/gSNHAb9Y5WT1PkHpzYbRqtq
         j16obemm5ek7O6nLr4kYWrQw1Ha9Zvv9J08gKOGOslMYYAGD/i3XEdst9/QABostQhzA
         RhqmM5ImCv4kjHuWxAT7RL6DPOnp+M1xTG/l5RSNZIjWQVTP4DQ//NEtuILI/McdtP0L
         SqEbQN+uU6o7bA4suoYFR4g9FkuOXjxP9X4fOgb9NLY2w05K4aY6gYnhtqR8CeXtwQLa
         UJSw==
X-Gm-Message-State: APjAAAU4MCJZ0WM2DXyOQyr83SQvc1aWRkIY4GdP11HJL/zYCrLsNWW4
        f8EYgniKT24vIIUskVBH2lGTCQ==
X-Google-Smtp-Source: APXvYqwmu4ABt4jTRBty3nVkJMuKSHnMmTg5Q0KPJ90IkBiDv6kNk/qmNrCy/86iZ4KChGeZv2oNYw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr41351028wru.280.1565628180955;
        Mon, 12 Aug 2019 09:43:00 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id 4sm142393wmd.26.2019.08.12.09.42.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:43:00 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 06/16] zuf: Multy Devices
Date:   Mon, 12 Aug 2019 19:42:34 +0300
Message-Id: <20190812164244.15580-7-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZUFS supports Multiple block devices per super_block.
This here is the devices handling code. At the output
a single multi_devices (md.h) object is associated with the
mounting super_block.

There are three mode of operations:
* mount with out a device (mount -t FOO none /somepath)

* A single device - The FS stated register_fs_info->dt_offset==-1
  No checks are made by Kernel, the single bdev is registered with
  Kernel's mount_bdev. It is up to the zusFS to check validity

* Multy devices - The FS stated register_fs_info->dt_offset==X

  This mode is the main of this patch.
  A single device is given on the mount command line. At
  register_fs_info->dt_offset of this device we look for a
  zufs_dev_table structure. After all the checks we look there
  at the device list and open all devices. Any one of the devices may
  be given on command line. But they will always be opened in
  DT(Device Table) order. The Device table has the notion of two types
  of bdevs:
  T1 devices - are pmem devices capable of direct_access
  T2 devices - are none direct_access devices

  All t1 devices are presented as one linear array. in DT order
  In t1.c we mmap this space for the server to directly access
  pmem. (In the proper persistent way)

  [We do not support any direct_access device, we only support
   pmem(s) where the all device can be addressed by a single
   physical/virtual address. This is checked before mount]

   The T2 devices are also grabbed and owned by the super_block
   A later API will enable the Server to write or transfer buffers
   from T1 to T2 in a very efficient manner. Also presented as a
   single linear array in DT order.

   Both kind of devices are NUMA aware and the NUMA info is presented
   to the zusFS for optimal allocation and access.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   3 +
 fs/zuf/_extern.h  |   6 +
 fs/zuf/md.c       | 742 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/md.h       | 332 +++++++++++++++++++++
 fs/zuf/md_def.h   | 145 +++++++++
 fs/zuf/super.c    |   6 +
 fs/zuf/t1.c       | 135 +++++++++
 fs/zuf/t2.c       | 356 ++++++++++++++++++++++
 fs/zuf/t2.h       |  68 +++++
 fs/zuf/zuf-core.c |  76 +++++
 fs/zuf/zuf.h      |  54 ++++
 fs/zuf/zus_api.h  |  15 +
 12 files changed, 1938 insertions(+)
 create mode 100644 fs/zuf/md.c
 create mode 100644 fs/zuf/md.h
 create mode 100644 fs/zuf/md_def.h
 create mode 100644 fs/zuf/t1.c
 create mode 100644 fs/zuf/t2.c
 create mode 100644 fs/zuf/t2.h

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index b08c08e73faa..a247bd85d9aa 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -10,6 +10,9 @@
 
 obj-$(CONFIG_ZUFS_FS) += zuf.o
 
+# Infrastructure
+zuf-y += md.o t1.o t2.o
+
 # ZUF core
 zuf-y += zuf-core.o zuf-root.o
 
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 1f786fc24b85..a5929d3d165c 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -54,4 +54,10 @@ void zuf_destroy_inodecache(void);
 struct dentry *zuf_mount(struct file_system_type *fs_type, int flags,
 			 const char *dev_name, void *data);
 
+struct super_block *zuf_sb_from_id(struct zuf_root_info *zri, __u64 sb_id,
+				   struct zus_sb_info *zus_sbi);
+
+/* t1.c */
+int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
+
 #endif	/*ndef __ZUF_EXTERN_H__*/
diff --git a/fs/zuf/md.c b/fs/zuf/md.c
new file mode 100644
index 000000000000..c4778b4fdff8
--- /dev/null
+++ b/fs/zuf/md.c
@@ -0,0 +1,742 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Multi-Device operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#include <linux/blkdev.h>
+#include <linux/pfn_t.h>
+#include <linux/crc16.h>
+#include <linux/uuid.h>
+
+#include <linux/gcd.h>
+
+#include "_pr.h"
+#include "md.h"
+#include "t2.h"
+
+const fmode_t _g_mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
+
+static int _bdev_get_by_path(const char *path, struct block_device **bdev,
+			     void *holder)
+{
+	*bdev = blkdev_get_by_path(path, _g_mode, holder);
+	if (IS_ERR(*bdev)) {
+		int err = PTR_ERR(*bdev);
+		*bdev = NULL;
+		return err;
+	}
+	return 0;
+}
+
+static void _bdev_put(struct block_device **bdev)
+{
+	if (*bdev) {
+		blkdev_put(*bdev, _g_mode);
+		*bdev = NULL;
+	}
+}
+
+/* convert uuid to a /dev/ path */
+static char *_uuid_path(uuid_le *uuid, char path[PATH_UUID])
+{
+	sprintf(path, "/dev/disk/by-uuid/%pUb", uuid);
+	return path;
+}
+
+static int _bdev_get_by_uuid(struct block_device **bdev, uuid_le *uuid,
+			       void *holder, bool silent)
+{
+	char path[PATH_UUID];
+	int err;
+
+	_uuid_path(uuid, path);
+	err = _bdev_get_by_path(path, bdev, holder);
+	if (unlikely(err))
+		md_err_cnd(silent, "failed to get device path=%s =>%d\n",
+			   path, err);
+
+	return err;
+}
+
+short md_calc_csum(struct md_dev_table *mdt)
+{
+	uint n = MDT_STATIC_SIZE(mdt) - sizeof(mdt->s_sum);
+
+	return crc16(~0, (__u8 *)&mdt->s_version, n);
+}
+
+/* ~~~~~~~ mdt related functions ~~~~~~~ */
+
+int md_t2_mdt_read(struct multi_devices *md, int index,
+		   struct md_dev_table *mdt)
+{
+	int err = t2_readpage(md, index, virt_to_page(mdt));
+
+	if (err)
+		md_dbg_verbose("!!! t2_readpage err=%d\n", err);
+
+	return err;
+}
+
+static int _t2_mdt_read(struct block_device *bdev, struct md_dev_table *mdt)
+{
+	int err;
+	/* t2 interface works for all block devices */
+	struct multi_devices *md;
+	struct md_dev_info *mdi;
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (unlikely(!md))
+		return -ENOMEM;
+
+	md->t2_count = 1;
+	md->devs[0].bdev = bdev;
+	mdi = &md->devs[0];
+	md->t2a.map = &mdi;
+	md->t2a.bn_gcd = 1; /*Does not matter only must not be zero */
+
+	err = md_t2_mdt_read(md, 0, mdt);
+
+	kfree(md);
+	return err;
+}
+
+int md_t2_mdt_write(struct multi_devices *md, struct md_dev_table *mdt)
+{
+	int i, err = 0;
+
+	for (i = 0; i < md->t2_count; ++i) {
+		ulong bn = md_o2p(md_t2_dev(md, i)->offset);
+
+		mdt->s_dev_list.id_index = mdt->s_dev_list.t1_count + i;
+		mdt->s_sum = cpu_to_le16(md_calc_csum(mdt));
+
+		err = t2_writepage(md, bn, virt_to_page(mdt));
+		if (err)
+			md_dbg_verbose("!!! t2_writepage err=%d\n", err);
+	}
+
+	return err;
+}
+
+static bool _csum_mismatch(struct md_dev_table *mdt, int silent)
+{
+	ushort crc = md_calc_csum(mdt);
+
+	if (mdt->s_sum == cpu_to_le16(crc))
+		return false;
+
+	md_warn_cnd(silent, "expected(0x%x) != s_sum(0x%x)\n",
+		      cpu_to_le16(crc), mdt->s_sum);
+	return true;
+}
+
+static bool _uuid_le_equal(uuid_le *uuid1, uuid_le *uuid2)
+{
+	return (memcmp(uuid1, uuid2, sizeof(uuid_le)) == 0);
+}
+
+static bool _mdt_compare_uuids(struct md_dev_table *mdt,
+			       struct md_dev_table *main_mdt, int silent)
+{
+	int i, dev_count;
+
+	if (!_uuid_le_equal(&mdt->s_uuid, &main_mdt->s_uuid)) {
+		md_warn_cnd(silent, "mdt uuid (%pUb != %pUb) mismatch\n",
+			      &mdt->s_uuid, &main_mdt->s_uuid);
+		return false;
+	}
+
+	dev_count = mdt->s_dev_list.t1_count + mdt->s_dev_list.t2_count +
+		    mdt->s_dev_list.rmem_count;
+	for (i = 0; i < dev_count; ++i) {
+		struct md_dev_id *dev_id1 = &mdt->s_dev_list.dev_ids[i];
+		struct md_dev_id *dev_id2 = &main_mdt->s_dev_list.dev_ids[i];
+
+		if (!_uuid_le_equal(&dev_id1->uuid, &dev_id2->uuid)) {
+			md_warn_cnd(silent,
+				    "mdt dev %d uuid (%pUb != %pUb) mismatch\n",
+				    i, &dev_id1->uuid, &dev_id2->uuid);
+			return false;
+		}
+
+		if (dev_id1->blocks != dev_id2->blocks) {
+			md_warn_cnd(silent,
+				    "mdt dev %d blocks (0x%llx != 0x%llx) mismatch\n",
+				    i, le64_to_cpu(dev_id1->blocks),
+				    le64_to_cpu(dev_id2->blocks));
+			return false;
+		}
+	}
+
+	return true;
+}
+
+bool md_mdt_check(struct md_dev_table *mdt,
+		  struct md_dev_table *main_mdt, struct block_device *bdev,
+		  struct mdt_check *mc)
+{
+	struct md_dev_id *dev_id;
+	ulong bdev_size, super_size;
+
+	BUILD_BUG_ON(MDT_STATIC_SIZE(mdt) & (SMP_CACHE_BYTES - 1));
+
+	/* Do sanity checks on the superblock */
+	if (le32_to_cpu(mdt->s_magic) != mc->magic) {
+		md_warn_cnd(mc->silent,
+			     "Magic error in super block: please run fsck\n");
+		return false;
+	}
+
+	if ((mc->major_ver != mdt_major_version(mdt)) ||
+	    (mc->minor_ver < mdt_minor_version(mdt))) {
+		md_warn_cnd(mc->silent,
+			     "mkfs-mount versions mismatch! %d.%d != %d.%d\n",
+			     mdt_major_version(mdt), mdt_minor_version(mdt),
+			     mc->major_ver, mc->minor_ver);
+		return false;
+	}
+
+	if (_csum_mismatch(mdt, mc->silent)) {
+		md_warn_cnd(mc->silent,
+			    "crc16 error in super block: please run fsck\n");
+		return false;
+	}
+
+	if (main_mdt) {
+		if (mdt->s_dev_list.t1_count != main_mdt->s_dev_list.t1_count) {
+			md_warn_cnd(mc->silent, "mdt t1 count mismatch\n");
+			return false;
+		}
+
+		if (mdt->s_dev_list.t2_count != main_mdt->s_dev_list.t2_count) {
+			md_warn_cnd(mc->silent, "mdt t2 count mismatch\n");
+			return false;
+		}
+
+		if (mdt->s_dev_list.rmem_count !=
+		    main_mdt->s_dev_list.rmem_count) {
+			md_warn_cnd(mc->silent,
+				    "mdt rmem dev count mismatch\n");
+			return false;
+		}
+
+		if (!_mdt_compare_uuids(mdt, main_mdt, mc->silent))
+			return false;
+	}
+
+	/* check alignment */
+	dev_id = &mdt->s_dev_list.dev_ids[mdt->s_dev_list.id_index];
+	super_size = md_p2o(__dev_id_blocks(dev_id));
+	if (unlikely(!super_size || super_size & mc->alloc_mask)) {
+		md_warn_cnd(mc->silent, "super_size(0x%lx) ! 2_M aligned\n",
+			      super_size);
+		return false;
+	}
+
+	if (!bdev)
+		return true;
+
+	/* check t1 device size */
+	bdev_size = i_size_read(bdev->bd_inode);
+	if (unlikely(super_size > bdev_size)) {
+		md_warn_cnd(mc->silent,
+			    "bdev_size(0x%lx) too small expected 0x%lx\n",
+			    bdev_size, super_size);
+		return false;
+	} else if (unlikely(super_size < bdev_size)) {
+		md_dbg_err("Note mdt->size=(0x%lx) < bdev_size(0x%lx)\n",
+			      super_size, bdev_size);
+	}
+
+	return true;
+}
+
+int md_set_sb(struct multi_devices *md, struct block_device *s_bdev,
+	      void *sb, int silent)
+{
+	struct md_dev_info *main_mdi = md_dev_info(md, md->dev_index);
+	int i;
+
+	main_mdi->bdev = s_bdev;
+
+	for (i = 0; i < md->t1_count + md->t2_count; ++i) {
+		struct md_dev_info *mdi;
+
+		if (i == md->dev_index)
+			continue;
+
+		mdi = md_dev_info(md, i);
+		if (mdi->bdev->bd_super && (mdi->bdev->bd_super != sb)) {
+			md_warn_cnd(silent,
+				"!!! %s already mounted on a different FS => -EBUSY\n",
+				_bdev_name(mdi->bdev));
+			return -EBUSY;
+		}
+
+		mdi->bdev->bd_super = sb;
+	}
+
+	return 0;
+}
+
+void md_fini(struct multi_devices *md, bool put_all)
+{
+	struct md_dev_info *main_mdi;
+	int i;
+
+	if (unlikely(!md))
+		return;
+
+	main_mdi = md_dev_info(md, md->dev_index);
+	kfree(md->t2a.map);
+	kfree(md->t1a.map);
+
+	for (i = 0; i < md->t1_count + md->t2_count; ++i) {
+		struct md_dev_info *mdi = md_dev_info(md, i);
+
+		if (i < md->t1_count)
+			md_t1_info_fini(mdi);
+		if (!mdi->bdev || i == md->dev_index)
+			continue;
+		mdi->bdev->bd_super = NULL;
+		_bdev_put(&mdi->bdev);
+	}
+
+	if (put_all)
+		_bdev_put(&main_mdi->bdev);
+	else
+		/* Main dev is GET && PUT by VFS. Only stop pointing to it */
+		main_mdi->bdev = NULL;
+
+	kfree(md);
+}
+
+
+/* ~~~~~~~ Pre-mount operations ~~~~~~~ */
+
+static int _get_device(struct block_device **bdev, const char *dev_name,
+		       uuid_le *uuid, void *holder, int silent,
+		       bool *bind_mount)
+{
+	int err;
+
+	if (dev_name)
+		err = _bdev_get_by_path(dev_name, bdev, holder);
+	else
+		err = _bdev_get_by_uuid(bdev, uuid, holder, silent);
+
+	if (unlikely(err)) {
+		md_err_cnd(silent,
+			"failed to get device dev_name=%s uuid=%pUb err=%d\n",
+			dev_name, uuid, err);
+		return err;
+	}
+
+	if (bind_mount &&  (*bdev)->bd_super &&
+			   (*bdev)->bd_super->s_bdev == *bdev)
+		*bind_mount = true;
+
+	return 0;
+}
+
+static int _init_dev_info(struct md_dev_info *mdi, struct md_dev_id *id,
+			  int index, u64 offset,
+			  struct md_dev_table *main_mdt,
+			  struct mdt_check *mc, bool t1_dev,
+			  int silent)
+{
+	struct md_dev_table *mdt = NULL;
+	bool mdt_alloc = false;
+	int err = 0;
+
+	if (mdi->bdev == NULL) {
+		err = _get_device(&mdi->bdev, NULL, &id->uuid, mc->holder,
+				  silent, NULL);
+		if (unlikely(err))
+			return err;
+	}
+
+	mdi->offset = offset;
+	mdi->size = md_p2o(__dev_id_blocks(id));
+	mdi->index = index;
+
+	if (t1_dev) {
+		struct page *dev_page;
+		int end_of_dev_nid;
+
+		err = md_t1_info_init(mdi, silent);
+		if (unlikely(err))
+			return err;
+
+		if ((ulong)mdi->t1i.virt_addr & mc->alloc_mask) {
+			md_warn_cnd(silent, "!!! unaligned device %s\n",
+				      _bdev_name(mdi->bdev));
+			return -EINVAL;
+		}
+
+		if (!__pfn_to_section(mdi->t1i.phys_pfn)) {
+			md_err_cnd(silent, "Intel does not like pages...\n");
+			return -EINVAL;
+		}
+
+		mdt = mdi->t1i.virt_addr;
+
+		mdi->t1i.pgmap = virt_to_page(mdt)->pgmap;
+		dev_page = pfn_to_page(mdi->t1i.phys_pfn);
+		mdi->nid = page_to_nid(dev_page);
+		end_of_dev_nid = page_to_nid(dev_page + md_o2p(mdi->size - 1));
+
+		if (mdi->nid != end_of_dev_nid)
+			md_warn("pmem crosses NUMA boundaries");
+	} else {
+		mdt = (void *)__get_free_page(GFP_KERNEL);
+		if (unlikely(!mdt)) {
+			md_dbg_err("!!! failed to alloc page\n");
+			return -ENOMEM;
+		}
+
+		mdt_alloc = true;
+		err = _t2_mdt_read(mdi->bdev, mdt);
+		if (unlikely(err)) {
+			md_err_cnd(silent, "failed to read mdt from t2 => %d\n",
+				   err);
+			goto out;
+		}
+		mdi->nid = __dev_id_nid(id);
+	}
+
+	if (!md_mdt_check(mdt, main_mdt, mdi->bdev, mc)) {
+		md_err_cnd(silent, "device %s failed integrity check\n",
+			     _bdev_name(mdi->bdev));
+		err = -EINVAL;
+		goto out;
+	}
+
+	return 0;
+
+out:
+	if (mdt_alloc)
+		free_page((ulong)mdt);
+	return err;
+}
+
+static int _map_setup(struct multi_devices *md, ulong blocks, int dev_start,
+		      struct md_dev_larray *larray)
+{
+	ulong map_size, bn_end;
+	int i, dev_index = dev_start;
+
+	map_size = blocks / larray->bn_gcd;
+	larray->map = kcalloc(map_size, sizeof(*larray->map), GFP_KERNEL);
+	if (!larray->map) {
+		md_dbg_err("failed to allocate dev map\n");
+		return -ENOMEM;
+	}
+
+	bn_end = md_o2p(md->devs[dev_index].size);
+	for (i = 0; i < map_size; ++i) {
+		if ((i * larray->bn_gcd) >= bn_end)
+			bn_end += md_o2p(md->devs[++dev_index].size);
+		larray->map[i] = &md->devs[dev_index];
+	}
+
+	return 0;
+}
+
+static int _md_init(struct multi_devices *md, struct mdt_check *mc,
+		    struct md_dev_list *dev_list, int silent)
+{
+	struct md_dev_table *main_mdt = NULL;
+	u64 total_size = 0;
+	int i, err;
+
+	for (i = 0; i < md->t1_count; ++i) {
+		struct md_dev_info *mdi = md_t1_dev(md, i);
+		struct md_dev_table *dev_mdt;
+
+		err = _init_dev_info(mdi, &dev_list->dev_ids[i], i, total_size,
+				     main_mdt, mc, true, silent);
+		if (unlikely(err))
+			return err;
+
+		/* apparently gcd(0,X)=X which is nice */
+		md->t1a.bn_gcd = gcd(md->t1a.bn_gcd, md_o2p(mdi->size));
+		total_size += mdi->size;
+
+		dev_mdt = md_t1_addr(md, i);
+		if (!main_mdt)
+			main_mdt = dev_mdt;
+
+		if (mdt_test_option(dev_mdt, MDT_F_SHADOW))
+			memcpy(mdi->t1i.virt_addr,
+			       mdi->t1i.virt_addr + mdi->size, mdi->size);
+
+		md_dbg_verbose("dev=%d %pUb %s v=%p pfn=%lu off=%lu size=%lu\n",
+				 i, &dev_list->dev_ids[i].uuid,
+				 _bdev_name(mdi->bdev), dev_mdt,
+				 mdi->t1i.phys_pfn, mdi->offset, mdi->size);
+	}
+
+	md->t1_blocks = le64_to_cpu(main_mdt->s_t1_blocks);
+	if (unlikely(md->t1_blocks != md_o2p(total_size))) {
+		md_err_cnd(silent,
+			"FS corrupted md->t1_blocks(0x%lx) != total_size(0x%llx)\n",
+			md->t1_blocks, total_size);
+		return -EIO;
+	}
+
+	err = _map_setup(md, le64_to_cpu(main_mdt->s_t1_blocks), 0, &md->t1a);
+	if (unlikely(err))
+		return err;
+
+	md_dbg_verbose("t1 devices=%d total_size=0x%llx segment_map=0x%lx\n",
+			 md->t1_count, total_size,
+			 md_o2p(total_size) / md->t1a.bn_gcd);
+
+	if (md->t2_count == 0)
+		return 0;
+
+	/* Done with t1. Counting t2s */
+	total_size = 0;
+	for (i = 0; i < md->t2_count; ++i) {
+		struct md_dev_info *mdi = md_t2_dev(md, i);
+
+		err = _init_dev_info(mdi, &dev_list->dev_ids[md->t1_count + i],
+				     md->t1_count + i, total_size, main_mdt,
+				     mc, false, silent);
+		if (unlikely(err))
+			return err;
+
+		/* apparently gcd(0,X)=X which is nice */
+		md->t2a.bn_gcd = gcd(md->t2a.bn_gcd, md_o2p(mdi->size));
+		total_size += mdi->size;
+
+		md_dbg_verbose("dev=%d %s off=%lu size=%lu\n", i,
+				 _bdev_name(mdi->bdev), mdi->offset, mdi->size);
+	}
+
+	md->t2_blocks = le64_to_cpu(main_mdt->s_t2_blocks);
+	if (unlikely(md->t2_blocks != md_o2p(total_size))) {
+		md_err_cnd(silent,
+			"FS corrupted md->t2_blocks(0x%lx) != total_size(0x%llx)\n",
+			md->t2_blocks, total_size);
+		return -EIO;
+	}
+
+	err = _map_setup(md, le64_to_cpu(main_mdt->s_t2_blocks), md->t1_count,
+			 &md->t2a);
+	if (unlikely(err))
+		return err;
+
+	md_dbg_verbose("t2 devices=%d total_size=%llu segment_map=%lu\n",
+			 md->t2_count, total_size,
+			 md_o2p(total_size) / md->t2a.bn_gcd);
+
+	return 0;
+}
+
+static int _load_dev_list(struct md_dev_list *dev_list, struct mdt_check *mc,
+			  struct block_device *bdev, const char *dev_name,
+			  int silent)
+{
+	struct md_dev_table *mdt;
+	int err;
+
+	mdt = (void *)__get_free_page(GFP_KERNEL);
+	if (unlikely(!mdt)) {
+		md_dbg_err("!!! failed to alloc page\n");
+		return -ENOMEM;
+	}
+
+	err = _t2_mdt_read(bdev, mdt);
+	if (unlikely(err)) {
+		md_err_cnd(silent, "failed to read super block from %s => %d\n",
+			     dev_name, err);
+		goto out;
+	}
+
+	if (!md_mdt_check(mdt, NULL, bdev, mc)) {
+		md_err_cnd(silent, "bad mdt in %s\n", dev_name);
+		err = -EINVAL;
+		goto out;
+	}
+
+	*dev_list = mdt->s_dev_list;
+
+out:
+	free_page((ulong)mdt);
+	return err;
+}
+
+/* md_init - allocates and initializes ready to go multi_devices object
+ *
+ * The rule is that if md_init returns error caller must call md_fini always
+ */
+int md_init(struct multi_devices **ret_md, const char *dev_name,
+	    struct mdt_check *mc, char path[PATH_UUID],	const char **dev_path)
+{
+	struct md_dev_list *dev_list;
+	struct block_device *bdev;
+	struct multi_devices *md;
+	short id_index;
+	bool bind_mount = false;
+	int err;
+
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	*ret_md = md;
+	if (unlikely(!md))
+		return -ENOMEM;
+
+	dev_list = kmalloc(sizeof(*dev_list), GFP_KERNEL);
+	if (unlikely(!dev_list))
+		return -ENOMEM;
+
+	err = _get_device(&bdev, dev_name, NULL, mc->holder, mc->silent,
+			  &bind_mount);
+	if (unlikely(err))
+		goto out2;
+
+	err = _load_dev_list(dev_list, mc, bdev, dev_name, mc->silent);
+	if (unlikely(err)) {
+		_bdev_put(&bdev);
+		goto out2;
+	}
+
+	id_index = le16_to_cpu(dev_list->id_index);
+	if (bind_mount) {
+		_bdev_put(&bdev);
+		md->dev_index = id_index;
+		goto out;
+	}
+
+	md->t1_count = le16_to_cpu(dev_list->t1_count);
+	md->t2_count = le16_to_cpu(dev_list->t2_count);
+	md->devs[id_index].bdev = bdev;
+
+	if ((id_index != 0)) {
+		err = _get_device(&md_t1_dev(md, 0)->bdev, NULL,
+				  &dev_list->dev_ids[0].uuid, mc->holder,
+				  mc->silent, &bind_mount);
+		if (unlikely(err))
+			goto out2;
+
+		if (bind_mount)
+			goto out;
+	}
+
+	if (md->t2_count) {
+		int t2_index = md->t1_count;
+
+		/* t2 is the primary device if given in mount, or the first
+		 * mount specified it as primary device
+		 */
+		if (id_index != md->t1_count) {
+			err = _get_device(&md_t2_dev(md, 0)->bdev, NULL,
+					  &dev_list->dev_ids[t2_index].uuid,
+					  mc->holder, mc->silent, &bind_mount);
+			if (unlikely(err))
+				goto out2;
+
+			if (bind_mount)
+				md->dev_index = t2_index;
+		}
+
+		if (t2_index <= id_index)
+			md->dev_index = t2_index;
+	}
+
+out:
+	if (md->dev_index != id_index)
+		*dev_path = _uuid_path(&dev_list->dev_ids[md->dev_index].uuid,
+				       path);
+	else
+		*dev_path = dev_name;
+
+	if (!bind_mount) {
+		err = _md_init(md, mc, dev_list, mc->silent);
+		if (unlikely(err))
+			goto out2;
+		if (!(mc->private_mnt))
+			_bdev_put(&md_dev_info(md, md->dev_index)->bdev);
+	} else {
+		md_fini(md, true);
+	}
+
+out2:
+	kfree(dev_list);
+
+	return err;
+}
+
+/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * PORTING SECTION:
+ * Below are members that are done differently in different Linux versions.
+ * So keep separate from code
+ */
+static int _check_da_ret(struct md_dev_info *mdi, long avail, bool silent)
+{
+	if (unlikely(avail < (long)mdi->size)) {
+		if (0 < avail) {
+			md_warn_cnd(silent,
+				"Unsupported DAX device %s (range mismatch) => 0x%lx < 0x%lx\n",
+				_bdev_name(mdi->bdev), avail, mdi->size);
+			return -ERANGE;
+		}
+		md_warn_cnd(silent, "!!! %s direct_access return => %ld\n",
+			    _bdev_name(mdi->bdev), avail);
+		return avail;
+	}
+	return 0;
+}
+
+#include <linux/dax.h>
+
+int md_t1_info_init(struct md_dev_info *mdi, bool silent)
+{
+	pfn_t a_pfn_t;
+	void *addr;
+	long nrpages, avail, pgoff;
+	int id;
+
+	mdi->t1i.dax_dev = fs_dax_get_by_bdev(mdi->bdev);
+	if (unlikely(!mdi->t1i.dax_dev))
+		return -EOPNOTSUPP;
+
+	id = dax_read_lock();
+
+	bdev_dax_pgoff(mdi->bdev, 0, PAGE_SIZE, &pgoff);
+	nrpages = dax_direct_access(mdi->t1i.dax_dev, pgoff, md_o2p(mdi->size),
+				    &addr, &a_pfn_t);
+	dax_read_unlock(id);
+	if (unlikely(nrpages <= 0)) {
+		if (!nrpages)
+			nrpages = -ERANGE;
+		avail = nrpages;
+	} else {
+		avail = md_p2o(nrpages);
+	}
+
+	mdi->t1i.virt_addr = addr;
+	mdi->t1i.phys_pfn = pfn_t_to_pfn(a_pfn_t);
+
+	md_dbg_verbose("0x%lx 0x%lx pgoff=0x%lx\n",
+			 (ulong)mdi->t1i.virt_addr, mdi->t1i.phys_pfn, pgoff);
+
+	return _check_da_ret(mdi, avail, silent);
+}
+
+void md_t1_info_fini(struct md_dev_info *mdi)
+{
+	fs_put_dax(mdi->t1i.dax_dev);
+	mdi->t1i.dax_dev = NULL;
+	mdi->t1i.virt_addr = NULL;
+}
diff --git a/fs/zuf/md.h b/fs/zuf/md.h
new file mode 100644
index 000000000000..15ba7d646544
--- /dev/null
+++ b/fs/zuf/md.h
@@ -0,0 +1,332 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Multi-Device operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#ifndef __MD_H__
+#define __MD_H__
+
+#include <linux/types.h>
+
+#include "md_def.h"
+
+#ifndef __KERNEL__
+struct page;
+struct block_device;
+#else
+#	include <linux/blkdev.h>
+#endif /* ndef __KERNEL__ */
+
+struct md_t1_info {
+	void *virt_addr;
+#ifdef __KERNEL__
+	ulong phys_pfn;
+	struct dax_device *dax_dev;
+	struct dev_pagemap *pgmap;
+#endif /*def __KERNEL__*/
+};
+
+struct md_t2_info {
+#ifndef __KERNEL__
+	bool err_read_reported;
+	bool err_write_reported;
+#endif
+};
+
+struct md_dev_info {
+	struct block_device *bdev;
+	ulong size;
+	ulong offset;
+	union {
+		struct md_t1_info	t1i;
+		struct md_t2_info	t2i;
+	};
+	int index;
+	int nid;
+};
+
+struct md_dev_larray {
+	ulong bn_gcd;
+	struct md_dev_info **map;
+};
+
+#ifndef __KERNEL__
+struct fba {
+	int fd; void *ptr;
+	size_t size;
+	void *orig_ptr;
+};
+#endif /*! __KERNEL__*/
+
+struct zus_sb_info;
+struct multi_devices {
+	int dev_index;
+	int t1_count;
+	int t2_count;
+	struct md_dev_info devs[MD_DEV_MAX];
+	struct md_dev_larray t1a;
+	struct md_dev_larray t2a;
+#ifndef __KERNEL__
+	struct zufs_ioc_pmem pmem_info; /* As received from Kernel */
+
+	void *p_pmem_addr;
+	int fd;
+	uint user_page_size;
+	struct fba pages;
+	struct zus_sb_info *sbi;
+#else
+	ulong t1_blocks;
+	ulong t2_blocks;
+#endif /*! __KERNEL__*/
+};
+
+enum md_init_flags {
+	MD_I_F_PRIVATE		= (1UL << 0),
+};
+
+static inline __u64 md_p2o(ulong bn)
+{
+	return (__u64)bn << PAGE_SHIFT;
+}
+
+static inline ulong md_o2p(__u64 offset)
+{
+	return offset >> PAGE_SHIFT;
+}
+
+static inline ulong md_o2p_up(__u64 offset)
+{
+	return md_o2p(offset + PAGE_SIZE - 1);
+}
+
+static inline struct md_dev_info *md_t1_dev(struct multi_devices *md, int i)
+{
+	return &md->devs[i];
+}
+
+static inline struct md_dev_info *md_t2_dev(struct multi_devices *md, int i)
+{
+	return &md->devs[md->t1_count + i];
+}
+
+static inline struct md_dev_info *md_dev_info(struct multi_devices *md, int i)
+{
+	return &md->devs[i];
+}
+
+static inline void *md_t1_addr(struct multi_devices *md, int i)
+{
+	struct md_dev_info *mdi = md_t1_dev(md, i);
+
+	return mdi->t1i.virt_addr;
+}
+
+static inline ulong md_t1_blocks(struct multi_devices *md)
+{
+#ifdef __KERNEL__
+	return md->t1_blocks;
+#else
+	return md->pmem_info.mdt.s_t1_blocks;
+#endif
+}
+
+static inline ulong md_t2_blocks(struct multi_devices *md)
+{
+#ifdef __KERNEL__
+	return md->t2_blocks;
+#else
+	return md->pmem_info.mdt.s_t2_blocks;
+#endif
+}
+
+static inline struct md_dev_table *md_zdt(struct multi_devices *md)
+{
+	return md_t1_addr(md, 0);
+}
+
+static inline struct md_dev_info *md_bn_t1_dev(struct multi_devices *md,
+						 ulong bn)
+{
+	return md->t1a.map[bn / md->t1a.bn_gcd];
+}
+
+static inline uuid_le *md_main_uuid(struct multi_devices *md)
+{
+	return &md_zdt(md)->s_dev_list.dev_ids[md->dev_index].uuid;
+}
+
+#ifdef __KERNEL__
+static inline ulong md_pfn(struct multi_devices *md, ulong block)
+{
+	struct md_dev_info *mdi;
+	bool add_pfn = false;
+	ulong base_pfn;
+
+	if (unlikely(md_t1_blocks(md) <= block)) {
+		if (WARN_ON(!mdt_test_option(md_zdt(md), MDT_F_SHADOW)))
+			return 0;
+		block -= md_t1_blocks(md);
+		add_pfn = true;
+	}
+
+	mdi = md_bn_t1_dev(md, block);
+	if (add_pfn)
+		base_pfn = mdi->t1i.phys_pfn + md_o2p(mdi->size);
+	else
+		base_pfn = mdi->t1i.phys_pfn;
+	return base_pfn + (block - md_o2p(mdi->offset));
+}
+#endif /* def __KERNEL__ */
+
+static inline void *md_addr(struct multi_devices *md, ulong offset)
+{
+#ifdef __KERNEL__
+	struct md_dev_info *mdi = md_bn_t1_dev(md, md_o2p(offset));
+
+	return offset ? mdi->t1i.virt_addr + (offset - mdi->offset) : NULL;
+#else
+	return offset ? md->p_pmem_addr + offset : NULL;
+#endif
+}
+
+static inline void *md_baddr(struct multi_devices *md, ulong bn)
+{
+	return md_addr(md, md_p2o(bn));
+}
+
+static inline struct md_dev_info *md_bn_t2_dev(struct multi_devices *md,
+					       ulong bn)
+{
+	return md->t2a.map[bn / md->t2a.bn_gcd];
+}
+
+static inline int md_t2_bn_nid(struct multi_devices *md, ulong bn)
+{
+	struct md_dev_info *mdi = md_bn_t2_dev(md, bn);
+
+	return mdi->nid;
+}
+
+static inline ulong md_t2_local_bn(struct multi_devices *md, ulong bn)
+{
+#ifdef __KERNEL__
+	struct md_dev_info *mdi = md_bn_t2_dev(md, bn);
+
+	return bn - md_o2p(mdi->offset);
+#else
+	return bn; /* In zus we just let Kernel worry about it */
+#endif
+}
+
+static inline ulong md_t2_gcd(struct multi_devices *md)
+{
+	return md->t2a.bn_gcd;
+}
+
+static inline void *md_addr_verify(struct multi_devices *md, ulong offset)
+{
+	if (unlikely(offset > md_p2o(md_t1_blocks(md)))) {
+		md_dbg_err("offset=0x%lx > max=0x%llx\n",
+			    offset, md_p2o(md_t1_blocks(md)));
+		return NULL;
+	}
+
+	return md_addr(md, offset);
+}
+
+static inline struct page *md_bn_to_page(struct multi_devices *md, ulong bn)
+{
+#ifdef __KERNEL__
+	return pfn_to_page(md_pfn(md, bn));
+#else
+	return md->pages.ptr + bn * md->user_page_size;
+#endif
+}
+
+static inline ulong md_addr_to_offset(struct multi_devices *md, void *addr)
+{
+#ifdef __KERNEL__
+	/* TODO: Keep the device index in page-flags we need to fix the
+	 * page-ref right? for now with pages untouched we need this loop
+	 */
+	int dev_index;
+
+	for (dev_index = 0; dev_index < md->t1_count; ++dev_index) {
+		struct md_dev_info *mdi = md_t1_dev(md, dev_index);
+
+		if ((mdi->t1i.virt_addr <= addr) &&
+		    (addr < (mdi->t1i.virt_addr + mdi->size)))
+			return mdi->offset + (addr - mdi->t1i.virt_addr);
+	}
+
+	return 0;
+#else /* !__KERNEL__ */
+	return addr - md->p_pmem_addr;
+#endif
+}
+
+static inline ulong md_addr_to_bn(struct multi_devices *md, void *addr)
+{
+	return md_o2p(md_addr_to_offset(md, addr));
+}
+
+static inline ulong md_page_to_bn(struct multi_devices *md, struct page *page)
+{
+#ifdef __KERNEL__
+	return md_addr_to_bn(md, page_address(page));
+#else
+	ulong bytes = (void *)page - md->pages.ptr;
+
+	return bytes / md->user_page_size;
+#endif
+}
+
+#ifdef __KERNEL__
+/* TODO: Change API to take mdi and also support in um */
+static inline const char *_bdev_name(struct block_device *bdev)
+{
+	return dev_name(&bdev->bd_part->__dev);
+}
+#endif /*def __KERNEL__*/
+
+struct mdt_check {
+	ulong alloc_mask;
+	uint major_ver;
+	uint minor_ver;
+	__u32  magic;
+
+	void *holder;
+	bool silent;
+	bool private_mnt;
+};
+
+/* md.c */
+bool md_mdt_check(struct md_dev_table *mdt, struct md_dev_table *main_mdt,
+		  struct block_device *bdev, struct mdt_check *mc);
+int md_t2_mdt_read(struct multi_devices *md, int dev_index,
+		   struct md_dev_table *mdt);
+int md_t2_mdt_write(struct multi_devices *md, struct md_dev_table *mdt);
+short md_calc_csum(struct md_dev_table *mdt);
+void md_fini(struct multi_devices *md, bool put_all);
+
+#ifdef __KERNEL__
+/* length of uuid dev path /dev/disk/by-uuid/<uuid> */
+#define PATH_UUID	64
+int md_init(struct multi_devices **md, const char *dev_name,
+	    struct mdt_check *mc, char path[PATH_UUID], const char **dp);
+int md_set_sb(struct multi_devices *md, struct block_device *s_bdev, void *sb,
+	      int silent);
+int md_t1_info_init(struct md_dev_info *mdi, bool silent);
+void md_t1_info_fini(struct md_dev_info *mdi);
+
+#else /* libzus */
+int md_init_from_pmem_info(struct multi_devices *md);
+#endif
+
+#endif
diff --git a/fs/zuf/md_def.h b/fs/zuf/md_def.h
new file mode 100644
index 000000000000..7163e46b14ec
--- /dev/null
+++ b/fs/zuf/md_def.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note or BSD-3-Clause */
+/*
+ * Multi-Device operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+#ifndef _LINUX_MD_DEF_H
+#define _LINUX_MD_DEF_H
+
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#ifndef __KERNEL__
+
+#include <stdint.h>
+#include <endian.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+#ifndef le16_to_cpu
+
+#define le16_to_cpu(x)	((__u16)le16toh(x))
+#define le32_to_cpu(x)	((__u32)le32toh(x))
+#define le64_to_cpu(x)	((__u64)le64toh(x))
+#define cpu_to_le16(x)	((__le16)htole16(x))
+#define cpu_to_le32(x)	((__le32)htole32(x))
+#define cpu_to_le64(x)	((__le64)htole64(x))
+
+#endif
+
+#ifndef __aligned
+#define	__aligned(x)			__attribute__((aligned(x)))
+#endif
+
+#ifndef __packed
+#	define __packed __attribute__((packed))
+#endif
+
+#endif /*  ndef __KERNEL__ */
+
+#define MDT_SIZE 4096
+
+#define MD_DEV_NUMA_SHIFT		60
+#define MD_DEV_BLOCKS_MASK		0x0FFFFFFFFFFFFFFF
+
+struct md_dev_id {
+	uuid_le	uuid;
+	__le64	blocks;
+} __packed;
+
+static inline __u64 __dev_id_blocks(struct md_dev_id *dev)
+{
+	return le64_to_cpu(dev->blocks) & MD_DEV_BLOCKS_MASK;
+}
+
+static inline void __dev_id_blocks_set(struct md_dev_id *dev, __u64 blocks)
+{
+	dev->blocks &= ~MD_DEV_BLOCKS_MASK;
+	dev->blocks |= blocks;
+}
+
+static inline int __dev_id_nid(struct md_dev_id *dev)
+{
+	return (int)(le64_to_cpu(dev->blocks) >> MD_DEV_NUMA_SHIFT);
+}
+
+static inline void __dev_id_nid_set(struct md_dev_id *dev, int nid)
+{
+	dev->blocks &= MD_DEV_BLOCKS_MASK;
+	dev->blocks |= (__le64)nid << MD_DEV_NUMA_SHIFT;
+}
+
+/* 64 is the nicest number to still fit when the ZDT is 2048 and 6 bits can
+ * fit in page struct for address to block translation.
+ */
+#define MD_DEV_MAX   64
+
+struct md_dev_list {
+	__le16		   id_index;	/* index of current dev in list */
+	__le16		   t1_count;	/* # of t1 devs */
+	__le16		   t2_count;	/* # of t2 devs (after t1_count) */
+	__le16		   rmem_count;	/* align to 64 bit */
+	struct md_dev_id dev_ids[MD_DEV_MAX];
+} __aligned(64);
+
+/*
+ * Structure of the on disk multy device table
+ * NOTE: md_dev_table is always of size MDT_SIZE. These below are the
+ *   currently defined/used members in this version.
+ *   TODO: remove the s_ from all the fields
+ */
+struct md_dev_table {
+	/* static fields. they never change after file system creation.
+	 * checksum only validates up to s_start_dynamic field below
+	 */
+	__le16		s_sum;              /* checksum of this sb */
+	__le16		s_version;          /* zdt-version */
+	__le32		s_magic;            /* magic signature */
+	uuid_le		s_uuid;		    /* 128-bit uuid */
+	__le64		s_flags;
+	__le64		s_t1_blocks;
+	__le64		s_t2_blocks;
+
+	struct md_dev_list s_dev_list;
+
+	char		s_start_dynamic[0];
+
+	/* all the dynamic fields should go here */
+	__le64		s_mtime;		/* mount time */
+	__le64		s_wtime;		/* write time */
+};
+
+/* device table s_flags */
+enum enum_mdt_flags {
+	MDT_F_SHADOW		= (1UL << 0),	/* simulate cpu cache */
+	MDT_F_POSIXACL		= (1UL << 1),	/* enable acls */
+
+	MDT_F_USER_START	= 8,	/* first 8 bit reserved for mdt */
+};
+
+static inline bool mdt_test_option(struct md_dev_table *mdt,
+				   enum enum_mdt_flags flag)
+{
+	return (mdt->s_flags & flag) != 0;
+}
+
+#define MD_MINORS_PER_MAJOR	1024
+
+static inline int mdt_major_version(struct md_dev_table *mdt)
+{
+	return le16_to_cpu(mdt->s_version) / MD_MINORS_PER_MAJOR;
+}
+
+static inline int mdt_minor_version(struct md_dev_table *mdt)
+{
+	return le16_to_cpu(mdt->s_version) % MD_MINORS_PER_MAJOR;
+}
+
+#define MDT_STATIC_SIZE(mdt) ((__u64)&mdt->s_start_dynamic - (__u64)mdt)
+
+#endif /* _LINUX_MD_DEF_H */
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
index f7f7798425a9..2248ee74e4c2 100644
--- a/fs/zuf/super.c
+++ b/fs/zuf/super.c
@@ -20,6 +20,12 @@
 
 static struct kmem_cache *zuf_inode_cachep;
 
+struct super_block *zuf_sb_from_id(struct zuf_root_info *zri, __u64 sb_id,
+				   struct zus_sb_info *zus_sbi)
+{
+	return NULL;
+}
+
 static void _init_once(void *foo)
 {
 	struct zuf_inode_info *zii = foo;
diff --git a/fs/zuf/t1.c b/fs/zuf/t1.c
new file mode 100644
index 000000000000..e8d92bb57c2e
--- /dev/null
+++ b/fs/zuf/t1.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Just the special mmap of the all t1 array to the ZUS Server
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/pfn_t.h>
+#include <asm/pgtable.h>
+
+#include "_pr.h"
+#include "zuf.h"
+
+/* ~~~ Functions for mmap a t1-array and page faults ~~~ */
+static struct zuf_pmem_file *_pmem_from_f_private(struct file *file)
+{
+	struct zuf_special_file *zsf = file->private_data;
+
+	WARN_ON(zsf->type != zlfs_e_pmem);
+	return container_of(zsf, struct zuf_pmem_file, hdr);
+}
+
+static vm_fault_t t1_fault(struct vm_fault *vmf, enum page_entry_size pe_size)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = vma->vm_file->f_mapping->host;
+	ulong addr = vmf->address;
+	struct zuf_pmem_file *z_pmem;
+	pgoff_t size;
+	ulong bn;
+	pfn_t pfnt;
+	ulong pfn = 0;
+	vm_fault_t flt;
+
+	zuf_dbg_t1("[%ld] vm_start=0x%lx vm_end=0x%lx VA=0x%lx "
+		    "pgoff=0x%lx vmf_flags=0x%x cow_page=%p page=%p pe_size=%d\n",
+		    inode->i_ino, vma->vm_start, vma->vm_end, addr, vmf->pgoff,
+		    vmf->flags, vmf->cow_page, vmf->page, pe_size);
+
+	if (unlikely(vmf->page)) {
+		zuf_err("[%ld] vm_start=0x%lx vm_end=0x%lx VA=0x%lx "
+			"pgoff=0x%lx vmf_flags=0x%x page=%p cow_page=%p\n",
+			inode->i_ino, vma->vm_start, vma->vm_end, addr,
+			vmf->pgoff, vmf->flags, vmf->page, vmf->cow_page);
+		return VM_FAULT_SIGBUS;
+	}
+
+	size = md_o2p_up(i_size_read(inode));
+	if (unlikely(vmf->pgoff >= size)) {
+		ulong pgoff = vma->vm_pgoff + md_o2p(addr - vma->vm_start);
+
+		zuf_err("[%ld] pgoff(0x%lx)(0x%lx) >= size(0x%lx) => SIGBUS\n",
+			 inode->i_ino, vmf->pgoff, pgoff, size);
+
+		return VM_FAULT_SIGBUS;
+	}
+
+	if (vmf->cow_page)
+		/* HOWTO: prevent private mmaps */
+		return VM_FAULT_SIGBUS;
+
+	z_pmem = _pmem_from_f_private(vma->vm_file);
+
+	switch (pe_size) {
+	case PE_SIZE_PTE:
+		zuf_err("[%ld] PTE fault not expected pgoff=0x%lx addr=0x%lx\n",
+			inode->i_ino, vmf->pgoff, addr);
+		/* fall through do PMD insert anyway */
+	case PE_SIZE_PMD:
+		bn = linear_page_index(vma, addr & PMD_MASK);
+		pfn = md_pfn(z_pmem->md, bn);
+		pfnt = phys_to_pfn_t(PFN_PHYS(pfn), PFN_MAP | PFN_DEV);
+		flt = vmf_insert_pfn_pmd(vmf, pfnt, true);
+		zuf_dbg_t1("[%ld] PMD pfn-0x%lx addr=0x%lx bn=0x%lx pgoff=0x%lx => %d\n",
+			inode->i_ino, pfn, addr, bn, vmf->pgoff, flt);
+		break;
+	default:
+		/* FIXME: Easily support PE_SIZE_PUD Just needs to align to
+		 * PUD_MASK at zufr_get_unmapped_area(). But this is hard today
+		 * because of the 2M nvdimm lib takes for its page flag
+		 * information with NFIT. (That need not be there in any which
+		 * case.)
+		 * Which means zufr_get_unmapped_area needs to return
+		 * a align1G+2M address start. and first 1G is map PMD size.
+		 * Very ugly, sigh.
+		 * One thing I do not understand why when the vma->vm_start is
+		 * not PUD aligned and faults requests index zero. Then system
+		 * asks for PE_SIZE_PUD anyway. say my 0 index is 1G aligned
+		 * vmf_insert_pfn_pud() will always fail because the aligned
+		 * vm_addr is outside the vma.
+		 */
+		flt = VM_FAULT_FALLBACK;
+		zuf_dbg_t1("[%ld] default? pgoff=0x%lx addr=0x%lx pe_size=0x%x => %d\n",
+			   inode->i_ino, vmf->pgoff, addr, pe_size, flt);
+	}
+
+	return flt;
+}
+
+static vm_fault_t t1_fault_pte(struct vm_fault *vmf)
+{
+	return t1_fault(vmf, PE_SIZE_PTE);
+}
+
+static const struct vm_operations_struct t1_vm_ops = {
+	.huge_fault	= t1_fault,
+	.fault		= t1_fault_pte,
+};
+
+int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct zuf_special_file *zsf = file->private_data;
+
+	if (!zsf || zsf->type != zlfs_e_pmem)
+		return -EPERM;
+
+	vma->vm_flags |= VM_HUGEPAGE;
+	vma->vm_ops = &t1_vm_ops;
+
+	zuf_dbg_vfs("[%ld] start=0x%lx end=0x%lx flags=0x%lx page_prot=0x%lx\n",
+		     file->f_mapping->host->i_ino, vma->vm_start, vma->vm_end,
+		     vma->vm_flags, pgprot_val(vma->vm_page_prot));
+
+	return 0;
+}
+
diff --git a/fs/zuf/t2.c b/fs/zuf/t2.c
new file mode 100644
index 000000000000..d293ce0ac249
--- /dev/null
+++ b/fs/zuf/t2.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tier-2 operations.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+
+#include <linux/bitops.h>
+#include <linux/bio.h>
+
+#include "zuf.h"
+
+#define t2_warn zuf_warn
+
+static const char *_pr_rw(int rw)
+{
+	return (rw & WRITE) ? "WRITE" : "READ";
+}
+#define t2_tis_dbg(tis, fmt, args ...) \
+	zuf_dbg_t2("%s: r=%d f=0x%lx " fmt, _pr_rw(tis->rw_flags),	       \
+		    atomic_read(&tis->refcount), tis->rw_flags, ##args)
+
+#define t2_tis_dbg_rw(tis, fmt, args ...) \
+	zuf_dbg_t2_rw("%s<%p>: r=%d f=0x%lx " fmt, _pr_rw(tis->rw_flags),     \
+		    tis->priv, atomic_read(&tis->refcount), tis->rw_flags,\
+		    ##args)
+
+/* ~~~~~~~~~~~~ Async read/write ~~~~~~~~~~ */
+void t2_io_begin(struct multi_devices *md, int rw, t2_io_done_fn done,
+		 void *priv, uint n_vects, struct t2_io_state *tis)
+{
+	atomic_set(&tis->refcount, 1);
+	tis->md = md;
+	tis->done = done;
+	tis->priv = priv;
+	tis->n_vects = min(n_vects ? n_vects : 1, (uint)BIO_MAX_PAGES);
+	tis->rw_flags = rw;
+	tis->last_t2 = -1;
+	tis->cur_bio = NULL;
+	tis->index = ~0;
+	bio_list_init(&tis->delayed_bios);
+	tis->err = 0;
+	blk_start_plug(&tis->plug);
+	t2_tis_dbg_rw(tis, "done=%pS n_vects=%d\n", done, n_vects);
+}
+
+static void _tis_put(struct t2_io_state *tis)
+{
+	t2_tis_dbg_rw(tis, "done=%pS\n", tis->done);
+
+	if (test_bit(B_TIS_FREE_AFTER_WAIT, &tis->rw_flags))
+		wake_up_var(&tis->refcount);
+	else if (tis->done)
+		/* last - done may free the tis */
+		tis->done(tis, NULL, true);
+}
+
+static inline void tis_get(struct t2_io_state *tis)
+{
+	atomic_inc(&tis->refcount);
+}
+
+static inline int tis_put(struct t2_io_state *tis)
+{
+	if (atomic_dec_and_test(&tis->refcount)) {
+		_tis_put(tis);
+		return 1;
+	}
+	return 0;
+}
+
+static int _status_to_errno(blk_status_t status)
+{
+	return blk_status_to_errno(status);
+}
+
+void t2_io_done(struct t2_io_state *tis, struct bio *bio, bool last)
+{
+	struct bio_vec *bv;
+	struct bvec_iter_all i;
+
+	if (!bio)
+		return;
+
+	bio_for_each_segment_all(bv, bio, i)
+		put_page(bv->bv_page);
+}
+
+static void _tis_bio_done(struct bio *bio)
+{
+	struct t2_io_state *tis = bio->bi_private;
+
+	t2_tis_dbg(tis, "done=%pS err=%d\n", tis->done, bio->bi_status);
+
+	if (unlikely(bio->bi_status)) {
+		zuf_dbg_err("%s: err=%d last-err=%d\n",
+			     _pr_rw(tis->rw_flags), bio->bi_status, tis->err);
+		/* Store the last one */
+		tis->err = _status_to_errno(bio->bi_status);
+	}
+
+	if (tis->done)
+		tis->done(tis, bio, false);
+	else
+		t2_io_done(tis, bio, false);
+
+	bio_put(bio);
+	tis_put(tis);
+}
+
+static bool _tis_delay(struct t2_io_state *tis)
+{
+	return 0 != (tis->rw_flags & TIS_DELAY_SUBMIT);
+}
+
+#define bio_list_for_each_safe(bio, btmp, bl)				\
+	for (bio = (bl)->head,	btmp = bio ? bio->bi_next : NULL;	\
+	     bio; bio = btmp,	btmp = bio ? bio->bi_next : NULL)
+
+static void _tis_submit_bio(struct t2_io_state *tis, bool flush, bool done)
+{
+	if (flush || done) {
+		if (_tis_delay(tis)) {
+			struct bio *btmp, *bio;
+
+			bio_list_for_each_safe(bio, btmp, &tis->delayed_bios) {
+				bio->bi_next = NULL;
+				if (bio->bi_iter.bi_sector == -1) {
+					t2_warn("!!!!!!!!!!!!!\n");
+					bio_put(bio);
+					continue;
+				}
+				t2_tis_dbg(tis, "submit bio[%d] max_v=%d\n",
+					    bio->bi_vcnt, tis->n_vects);
+				submit_bio(bio);
+			}
+			bio_list_init(&tis->delayed_bios);
+		}
+
+		if (!tis->cur_bio)
+			return;
+
+		if (tis->cur_bio->bi_iter.bi_sector != -1) {
+			t2_tis_dbg(tis, "submit bio[%d] max_v=%d\n",
+				    tis->cur_bio->bi_vcnt, tis->n_vects);
+			submit_bio(tis->cur_bio);
+			tis->cur_bio = NULL;
+			tis->index = ~0;
+		} else if (done) {
+			t2_tis_dbg(tis, "put cur_bio=%p\n", tis->cur_bio);
+			bio_put(tis->cur_bio);
+			WARN_ON(tis_put(tis));
+		}
+	} else if (tis->cur_bio && (tis->cur_bio->bi_iter.bi_sector != -1)) {
+		/* Not flushing regular progress */
+		if (_tis_delay(tis)) {
+			t2_tis_dbg(tis, "list_add cur_bio=%p\n", tis->cur_bio);
+			bio_list_add(&tis->delayed_bios, tis->cur_bio);
+		} else {
+			t2_tis_dbg(tis, "submit bio[%d] max_v=%d\n",
+				    tis->cur_bio->bi_vcnt, tis->n_vects);
+			submit_bio(tis->cur_bio);
+		}
+		tis->cur_bio = NULL;
+		tis->index = ~0;
+	}
+}
+
+/* tis->cur_bio MUST be NULL, checked by caller */
+static void _tis_alloc(struct t2_io_state *tis, struct md_dev_info *mdi,
+		       gfp_t gfp)
+{
+	struct bio *bio = bio_alloc(gfp, tis->n_vects);
+	int bio_op;
+
+	if (unlikely(!bio)) {
+		if (!_tis_delay(tis))
+			t2_warn("!!! failed to alloc bio");
+		tis->err = -ENOMEM;
+		return;
+	}
+
+	if (WARN_ON(!tis || !tis->md)) {
+		tis->err = -ENOMEM;
+		return;
+	}
+
+	/* FIXME: bio_set_op_attrs macro has a BUG which does not allow this
+	 * question inline.
+	 */
+	bio_op = (tis->rw_flags & WRITE) ? REQ_OP_WRITE : REQ_OP_READ;
+	bio_set_op_attrs(bio, bio_op, 0);
+
+	bio->bi_iter.bi_sector = -1;
+	bio->bi_end_io = _tis_bio_done;
+	bio->bi_private = tis;
+
+	if (mdi) {
+		bio_set_dev(bio, mdi->bdev);
+		tis->index = mdi->index;
+	} else {
+		tis->index = ~0;
+	}
+	tis->last_t2 = -1;
+	tis->cur_bio = bio;
+	tis_get(tis);
+	t2_tis_dbg(tis, "New bio n_vects=%d\n", tis->n_vects);
+}
+
+int t2_io_prealloc(struct t2_io_state *tis, uint n_vects)
+{
+	tis->err = 0; /* reset any -ENOMEM from a previous t2_io_add */
+
+	_tis_submit_bio(tis, true, false);
+	tis->n_vects = min(n_vects ? n_vects : 1, (uint)BIO_MAX_PAGES);
+
+	t2_tis_dbg(tis, "n_vects=%d cur_bio=%p\n", tis->n_vects, tis->cur_bio);
+
+	if (!tis->cur_bio)
+		_tis_alloc(tis, NULL, GFP_NOFS);
+	return tis->err;
+}
+
+int t2_io_add(struct t2_io_state *tis, ulong t2, struct page *page)
+{
+	struct md_dev_info *mdi;
+	ulong local_t2;
+	int ret;
+
+	if (t2 > md_t2_blocks(tis->md)) {
+		zuf_err("bad t2 (0x%lx) offset\n", t2);
+		return -EFAULT;
+	}
+	get_page(page);
+
+	mdi = md_bn_t2_dev(tis->md, t2);
+	WARN_ON(!mdi);
+
+	if (unlikely(!mdi->bdev)) {
+		zuf_err("mdi->bdev == NULL!! t2=0x%lx\n", t2);
+		return -EFAULT;
+	}
+
+	local_t2 = md_t2_local_bn(tis->md, t2);
+	if (((local_t2 != (tis->last_t2 + 1)) && (tis->last_t2 != -1)) ||
+	   ((0 < tis->index) && (tis->index != mdi->index)))
+		_tis_submit_bio(tis, false, false);
+
+start:
+	if (!tis->cur_bio) {
+		_tis_alloc(tis, mdi, _tis_delay(tis) ? GFP_ATOMIC : GFP_NOFS);
+		if (unlikely(tis->err)) {
+			put_page(page);
+			return tis->err;
+		}
+	} else if (tis->index == ~0) {
+		/* the bio was allocated during t2_io_prealloc */
+		tis->index = mdi->index;
+		bio_set_dev(tis->cur_bio, mdi->bdev);
+	}
+
+	if (tis->last_t2 == -1)
+		tis->cur_bio->bi_iter.bi_sector =
+						local_t2 * T2_SECTORS_PER_PAGE;
+
+	ret = bio_add_page(tis->cur_bio, page, PAGE_SIZE, 0);
+	if (unlikely(ret != PAGE_SIZE)) {
+		t2_tis_dbg(tis, "bio_add_page=>%d bi_vcnt=%d n_vects=%d\n",
+			   ret, tis->cur_bio->bi_vcnt, tis->n_vects);
+		_tis_submit_bio(tis, false, false);
+		goto start; /* device does not support tis->n_vects */
+	}
+
+	if ((tis->cur_bio->bi_vcnt == tis->n_vects) && (tis->n_vects != 1))
+		_tis_submit_bio(tis, false, false);
+
+	t2_tis_dbg(tis, "t2=0x%lx last_t2=0x%lx local_t2=0x%lx t1=0x%lx\n",
+		   t2, tis->last_t2, local_t2, md_page_to_bn(tis->md, page));
+
+	tis->last_t2 = local_t2;
+	return 0;
+}
+
+int t2_io_end(struct t2_io_state *tis, bool wait)
+{
+	if (unlikely(!tis || !tis->md))
+		return 0; /* never initialized nothing to do */
+
+	t2_tis_dbg_rw(tis, "wait=%d\n", wait);
+
+	_tis_submit_bio(tis, true, true);
+	blk_finish_plug(&tis->plug);
+
+	if (wait)
+		set_bit(B_TIS_FREE_AFTER_WAIT, &tis->rw_flags);
+	tis_put(tis);
+
+	if (wait) {
+		wait_var_event(&tis->refcount, !atomic_read(&tis->refcount));
+		if (tis->done)
+			tis->done(tis, NULL, true);
+	}
+
+	return tis->err;
+}
+
+/* ~~~~~~~ Sync read/write ~~~~~~~ TODO: Remove soon */
+static int _sync_io_page(struct multi_devices *md, int rw, ulong bn,
+			 struct page *page)
+{
+	struct t2_io_state tis;
+	int err;
+
+	t2_io_begin(md, rw, NULL, NULL, 1, &tis);
+
+	t2_tis_dbg((&tis), "bn=0x%lx p-i=0x%lx\n", bn, page->index);
+
+	err = t2_io_add(&tis, bn, page);
+	if (unlikely(err))
+		return err;
+
+	err = submit_bio_wait(tis.cur_bio);
+	if (unlikely(err)) {
+		SetPageError(page);
+		/*
+		 * We failed to write the page out to tier-2.
+		 * Print a dire warning that things will go BAD (tm)
+		 * very quickly.
+		 */
+		zuf_err("io-error bn=0x%lx => %d\n", bn, err);
+	}
+
+	/* Same as t2_io_end+_tis_bio_done but without the kref stuff */
+	blk_finish_plug(&tis.plug);
+	put_page(page);
+	if (likely(tis.cur_bio))
+		bio_put(tis.cur_bio);
+
+	return err;
+}
+
+int t2_writepage(struct multi_devices *md, ulong bn, struct page *page)
+{
+	return _sync_io_page(md, WRITE, bn, page);
+}
+
+int t2_readpage(struct multi_devices *md, ulong bn, struct page *page)
+{
+	return _sync_io_page(md, READ, bn, page);
+}
diff --git a/fs/zuf/t2.h b/fs/zuf/t2.h
new file mode 100644
index 000000000000..cbd23dd409eb
--- /dev/null
+++ b/fs/zuf/t2.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Tier-2 Header file.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#ifndef __T2_H__
+#define __T2_H__
+
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/kref.h>
+#include "md.h"
+
+#define T2_SECTORS_PER_PAGE	(PAGE_SIZE / 512)
+
+/* t2.c */
+
+/* Sync read/write */
+int t2_writepage(struct multi_devices *md, ulong bn, struct page *page);
+int t2_readpage(struct multi_devices *md, ulong bn, struct page *page);
+
+/* Async read/write */
+struct t2_io_state;
+typedef void (*t2_io_done_fn)(struct t2_io_state *tis, struct bio *bio,
+			      bool last);
+
+struct t2_io_state {
+	atomic_t refcount; /* counts in-flight bios */
+	struct blk_plug plug;
+
+	struct multi_devices	*md;
+	int		index;
+	t2_io_done_fn	done;
+	void		*priv;
+
+	uint		n_vects;
+	ulong		rw_flags;
+	ulong		last_t2;
+	struct bio	*cur_bio;
+	struct bio_list	delayed_bios;
+	int		err;
+};
+
+/* For rw_flags above */
+/* From Kernel: WRITE		(1U << 0) */
+#define TIS_DELAY_SUBMIT	(1U << 2)
+enum {B_TIS_FREE_AFTER_WAIT = 3};
+#define TIS_FREE_AFTER_WAIT	(1U << B_TIS_FREE_AFTER_WAIT)
+#define TIS_USER_DEF_FIRST	(1U << 8)
+
+void t2_io_begin(struct multi_devices *md, int rw, t2_io_done_fn done,
+		 void *priv, uint n_vects, struct t2_io_state *tis);
+int t2_io_prealloc(struct t2_io_state *tis, uint n_vects);
+int t2_io_add(struct t2_io_state *tis, ulong t2, struct page *page);
+int t2_io_end(struct t2_io_state *tis, bool wait);
+
+/* This is done by default if t2_io_done_fn above is NULL
+ * Can also be chain-called by users.
+ */
+void t2_io_done(struct t2_io_state *tis, struct bio *bio, bool last);
+
+#endif /*def __T2_H__*/
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 64cc91684eb6..8b5329632f28 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -358,6 +358,78 @@ static int _zu_numa_map(struct file *file, void *parg)
 	return err;
 }
 
+/* ~~~~ PMEM GRAB ~~~~ */
+/*FIXME: At pmem the struct md_dev_list for t1(s) is not properly set
+ * For now we do not fix it and re-write the mdt. So just fix the one
+ * we are about to send to Server
+ */
+static void _fix_numa_ids(struct multi_devices *md, struct md_dev_list *mdl)
+{
+	int i;
+
+	for (i = 0; i < md->t1_count; ++i)
+		if (md->devs[i].nid != __dev_id_nid(&mdl->dev_ids[i]))
+			__dev_id_nid_set(&mdl->dev_ids[i], md->devs[i].nid);
+}
+
+static int _zu_grab_pmem(struct file *file, void *parg)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	struct zufs_ioc_pmem __user *arg_pmem = parg;
+	struct zufs_ioc_pmem *zi_pmem = kzalloc(sizeof(*zi_pmem), GFP_KERNEL);
+	struct super_block *sb;
+	struct zuf_sb_info *sbi;
+	size_t pmem_size;
+	int err;
+
+	if (unlikely(!zi_pmem))
+		return -ENOMEM;
+
+	err = get_user(zi_pmem->sb_id, &arg_pmem->sb_id);
+	if (err) {
+		zuf_err("\n");
+		goto out;
+	}
+
+	sb = zuf_sb_from_id(zri, zi_pmem->sb_id, NULL);
+	if (unlikely(!sb)) {
+		err = -ENODEV;
+		zuf_err("!!! pmem_kern_id=%llu not found\n", zi_pmem->sb_id);
+		goto out;
+	}
+	sbi = SBI(sb);
+
+	if (sbi->pmem.hdr.file) {
+		zuf_err("[%llu] pmem already taken\n", zi_pmem->sb_id);
+		err = -EIO;
+		goto out;
+	}
+
+	memcpy(&zi_pmem->mdt, md_zdt(sbi->md), sizeof(zi_pmem->mdt));
+	zi_pmem->dev_index = sbi->md->dev_index;
+	_fix_numa_ids(sbi->md, &zi_pmem->mdt.s_dev_list);
+
+	pmem_size = md_p2o(md_t1_blocks(sbi->md));
+	if (mdt_test_option(md_zdt(sbi->md), MDT_F_SHADOW))
+		pmem_size += pmem_size;
+	i_size_write(file->f_inode, pmem_size);
+	sbi->pmem.hdr.type = zlfs_e_pmem;
+	sbi->pmem.hdr.file = file;
+	sbi->pmem.md = sbi->md; /* FIXME: Use container_of in t1.c */
+	file->private_data = &sbi->pmem.hdr;
+	zuf_dbg_core("pmem %llu i_size=0x%llx GRABED %s\n",
+		     zi_pmem->sb_id, i_size_read(file->f_inode),
+		     _bdev_name(md_t1_dev(sbi->md, 0)->bdev));
+
+out:
+	zi_pmem->hdr.err = err;
+	err = copy_to_user(parg, zi_pmem, sizeof(*zi_pmem));
+	if (err)
+		zuf_err("=>%d\n", err);
+	kfree(zi_pmem);
+	return err;
+}
+
 static void _prep_header_size_op(struct zufs_ioc_hdr *hdr,
 				 enum e_zufs_operation op, int err)
 {
@@ -879,6 +951,8 @@ long zufc_ioctl(struct file *file, unsigned int cmd, ulong arg)
 		return _zu_mount(file, parg);
 	case ZU_IOC_NUMA_MAP:
 		return _zu_numa_map(file, parg);
+	case ZU_IOC_GRAB_PMEM:
+		return _zu_grab_pmem(file, parg);
 	case ZU_IOC_INIT_THREAD:
 		return _zu_init(file, parg);
 	case ZU_IOC_WAIT_OPT:
@@ -1122,6 +1196,8 @@ int zufc_mmap(struct file *file, struct vm_area_struct *vma)
 	switch (zsf->type) {
 	case zlfs_e_zt:
 		return zufc_zt_mmap(file, vma);
+	case zlfs_e_pmem:
+		return zuf_pmem_mmap(file, vma);
 	case zlfs_e_dpp_buff:
 		return zufc_ebuff_mmap(file, vma);
 	default:
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index 07a70c2ba25a..321f31124252 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -28,6 +28,8 @@
 #include "zus_api.h"
 
 #include "_pr.h"
+#include "md.h"
+#include "t2.h"
 
 enum zlfs_e_special_file {
 	zlfs_e_zt = 1,
@@ -97,6 +99,13 @@ static inline void zuf_add_fs_type(struct zuf_root_info *zri,
 	list_add(&zft->list, &zri->fst_list);
 }
 
+/* t1.c special file to mmap our pmem */
+struct zuf_pmem_file {
+	struct zuf_special_file hdr;
+	struct multi_devices *md;
+};
+
+
 /*
  * ZUF per-inode data in memory
  */
@@ -109,6 +118,51 @@ static inline struct zuf_inode_info *ZUII(struct inode *inode)
 	return container_of(inode, struct zuf_inode_info, vfs_inode);
 }
 
+/*
+ * ZUF super-block data in memory
+ */
+struct zuf_sb_info {
+	struct super_block *sb;
+	struct multi_devices *md;
+	struct zuf_pmem_file pmem;
+
+	/* zus cookie*/
+	struct zus_sb_info *zus_sbi;
+
+	/* Mount options */
+	unsigned long	s_mount_opt;
+	ulong		fs_caps;
+	char		*pmount_dev; /* for private mount */
+
+	spinlock_t		s_mmap_dirty_lock;
+	struct list_head	s_mmap_dirty;
+};
+
+static inline struct zuf_sb_info *SBI(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline struct zuf_fs_type *ZUF_FST(struct file_system_type *fs_type)
+{
+	return container_of(fs_type, struct zuf_fs_type, vfs_fst);
+}
+
+static inline struct zuf_fs_type *zuf_fst(struct super_block *sb)
+{
+	return ZUF_FST(sb->s_type);
+}
+
+static inline struct zuf_root_info *ZUF_ROOT(struct zuf_sb_info *sbi)
+{
+	return zuf_fst(sbi->sb)->zri;
+}
+
+static inline bool zuf_rdonly(struct super_block *sb)
+{
+	return sb_rdonly(sb);
+}
+
 struct zuf_dispatch_op;
 typedef int (*overflow_handler)(struct zuf_dispatch_op *zdo, void *parg,
 				ulong zt_max_bytes);
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index c3a2f7c0e0cd..653ca24c9c92 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -22,6 +22,8 @@
 #include <linux/fiemap.h>
 #include <stddef.h>
 
+#include "md_def.h"
+
 #ifdef __cplusplus
 #define NAMELESS(X) X
 #else
@@ -359,6 +361,19 @@ struct zufs_ioc_numa_map {
 };
 #define ZU_IOC_NUMA_MAP	_IOWR('Z', 13, struct zufs_ioc_numa_map)
 
+struct zufs_ioc_pmem {
+	/* Set by zus */
+	struct zufs_ioc_hdr hdr;
+	__u64 sb_id;
+
+	/* Returned to zus */
+	struct md_dev_table mdt;
+	__u32 dev_index;
+	__u32 ___pad;
+};
+/* GRAB is never ungrabed umount or file close cleans it all */
+#define ZU_IOC_GRAB_PMEM	_IOWR('Z', 14, struct zufs_ioc_pmem)
+
 /* ZT init */
 enum { ZUFS_MAX_ZT_CHANNELS = 4 };
 
-- 
2.20.1

