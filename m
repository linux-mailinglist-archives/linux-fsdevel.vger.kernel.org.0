Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A41753C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBG1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:27:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22711 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBG0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:21 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200302062617epoutp0204ac2ef798b1fd6c028d046ce44977f0~4aLDXUs7F0078300783epoutp021
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200302062617epoutp0204ac2ef798b1fd6c028d046ce44977f0~4aLDXUs7F0078300783epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130377;
        bh=0axqXzxJ8aNRFVJrVllWJd0DDbTJ2KK6v3RVBBXNtwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvBOnTHMliO75irH0LzHy9jCT6yKLeSqM11tpE5JpuDnKUxpVlu3t3WOakVAJg0pZ
         AI79wUaiD6CcIXhxvuL0RfOEGUzgkPGSRE1InqSIM4jpg+p74A5gLBE0vgOgfv4NGf
         nxQkmRhukxw7BW7eUOcA/B6q141W2BtYHcBVj4rM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200302062616epcas1p38cbf730e895a334e15751db6f75b5779~4aLCqAqFQ0652906529epcas1p3G;
        Mon,  2 Mar 2020 06:26:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48W9Bw0BB6zMqYkk; Mon,  2 Mar
        2020 06:26:16 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.D0.48019.707AC5E5; Mon,  2 Mar 2020 15:26:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200302062615epcas1p4fb5ead2437c08acc985a4bb0fe475d62~4aLA55gPa1248112481epcas1p49;
        Mon,  2 Mar 2020 06:26:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302062615epsmtrp10d61602cb35e90b838326de1045e1f34~4aLA47n6o1398513985epsmtrp1p;
        Mon,  2 Mar 2020 06:26:15 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-9a-5e5ca7073f57
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.39.10238.607AC5E5; Mon,  2 Mar 2020 15:26:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062614epsmtip2db61582f4b93a9d0394dc71de9365051~4aLAoq7rk2450224502epsmtip2V;
        Mon,  2 Mar 2020 06:26:14 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 01/14] exfat: add in-memory and on-disk structures and
 headers
Date:   Mon,  2 Mar 2020 15:21:32 +0900
Message-Id: <20200302062145.1719-2-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Td0wTURzHeXdt7xBrzqLyC0StF/kDFWgtxUOpI6Je4giJxsQR8ISzJXal
        V9yGRqJgFXBEjRVcRBzUgIgyhIDFhRpHjRpUnDiDigMlIsSWq8p/3/f7fX7zvUfiijpZOJlh
        tvM2M2ekZQMk55uiYqKJ40tTVJsOAdOz6wrBZBeXyZiTpZcx5mHrI5ypq2+WMPdqC2VM174s
        ZueNboyp7L0kZbyfOyTM7Z6r0qkhbPevXYitcbUSbEORm2AvtDhkbH7lKcR+qxjBeqraZWxF
        20csmVxsTDTwXDpvU/LmNEt6hlmvo2fPT52eqo1XqaPVCcwEWmnmTLyOTpqTHD0zw+hrlFau
        4oyZPlMyJwh07OREmyXTzisNFsGuo3lrutGqVlljBM4kZJr1MWkW00S1SjVe6yOXGQ0522sx
        65EatOalM0/iQJ79yImCSaDi4Pb1KsKJBpAKqhpBffNdXDx8RdB+8VXA8wPBpbce4m9ISZ4D
        iY56BF3FDcS/kIOH2jAnIkkZNRZ+Vw71BwyhIuBmgRfzMzjlwCC7cRPhZ0KpBVB13OhnJFQk
        3N17pq8nOTUJSloqAv2NhNLyRtyvg6lEeFJ7J8AMhub9bRK/xn1M9rkDfW0DlUNAz7bNyJ8f
        qCQofb5czBMKH65WBgYIh/cFWwgRWQ9fGnDRnIvg3U+dqDXQUlYu9SM4FQVltbGieRTUdBch
        seog+NS5XSpmkUPuFoWIREK+twkTdQQ4czoCRVkozGmSiYsqQPD56WvJDqR09RvG1W8Y1//K
        hxF+Cg3jrYJJzwtqa1z/G65AfS93DFON6m7N8SCKRPRAefXbJSkKKbdKWGvyICBxeoh8brDP
        JE/n1q7jbZZUW6aRFzxI69v7Tjx8aJrF9w/M9lS1drxGo2Hi4ifEazV0mPzFoqgUBaXn7PxK
        nrfytr9xGBkc7kAby989c86byAVNUUbuibJsPa9n7k/72HJ09ejO31RIwgxvb1bIrLOUS8mX
        KDbmu3uWPDB0PA6rGUdrnjA3R7nX9GZP88Y9uHZBCFK1BpGvjrUfPJP0PvR0cRM3o/HF7scr
        iqZ+z8idKSyOVv9KTnjztfFZw47Y4SdPjBict9Bd+CZsAy0RDJx6DG4TuD+F9usVzwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXpdteUycwZHjVhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJXR
        3rOLqWDhTsaKR129LA2Mh2YydjFyckgImEgs620Asrk4hAR2M0q8nzedGSIhLXHsxBkgmwPI
        FpY4fLgYJCwk8IFR4uW1LJAwm4C2xJ8toiBhEaDqM/2XmEDGMAv0MEl8nrKYCSQhLBAkMffj
        WzYQm0VAVeLitI1ge3kFrCWW3dwEdYO8xOoNB8DWcgrYSNzZdYERYpe1xNMXd5kh6gUlTs58
        wgKyl1lAXWL9PCGQMDNQa/PW2cwTGAVnIamahVA1C0nVAkbmVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwXGkpbmD8fKS+EOMAhyMSjy8O59HxwmxJpYVV+YeYpTgYFYS4fXlBArx
        piRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXA2BpoMNU3bvm2
        XMUNQtFabaG39PTvnSvoZJz8fqNj6JqGqWfvVHyduUv67Zwg1tkf/OTe6ZaL3eF+tW7X+lmz
        L4XNCNSsU/3wpGLyr82Fr7de8M1lmu525SmX8nGls1eXcKeGz71f/7/yv0DQ88XeOXUHbjaJ
        bjhTqbZftf221R7nJ2lnV2Ql5SmxFGckGmoxFxUnAgDgmnvSnwIAAA==
X-CMS-MailID: 20200302062615epcas1p4fb5ead2437c08acc985a4bb0fe475d62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062615epcas1p4fb5ead2437c08acc985a4bb0fe475d62
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062615epcas1p4fb5ead2437c08acc985a4bb0fe475d62@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds in-memory and on-disk structures and headers.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Roh�r <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/exfat/exfat_fs.h  | 519 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_raw.h | 184 +++++++++++++++
 2 files changed, 703 insertions(+)
 create mode 100644 fs/exfat/exfat_fs.h
 create mode 100644 fs/exfat/exfat_raw.h

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
new file mode 100644
index 000000000000..67d4e46fb810
--- /dev/null
+++ b/fs/exfat/exfat_fs.h
@@ -0,0 +1,519 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _EXFAT_FS_H
+#define _EXFAT_FS_H
+
+#include <linux/fs.h>
+#include <linux/ratelimit.h>
+#include <linux/nls.h>
+
+#define EXFAT_SUPER_MAGIC       0x2011BAB0UL
+#define EXFAT_ROOT_INO		1
+
+#define EXFAT_SB_DIRTY		0
+
+#define EXFAT_CLUSTERS_UNTRACKED (~0u)
+
+/*
+ * exfat error flags
+ */
+enum exfat_error_mode {
+	EXFAT_ERRORS_CONT,	/* ignore error and continue */
+	EXFAT_ERRORS_PANIC,	/* panic on error */
+	EXFAT_ERRORS_RO,	/* remount r/o on error */
+};
+
+/*
+ * exfat nls lossy flag
+ */
+enum {
+	NLS_NAME_NO_LOSSY,	/* no lossy */
+	NLS_NAME_LOSSY,		/* just detected incorrect filename(s) */
+	NLS_NAME_OVERLEN,	/* the length is over than its limit */
+};
+
+#define EXFAT_HASH_BITS		8
+#define EXFAT_HASH_SIZE		(1UL << EXFAT_HASH_BITS)
+
+/*
+ * Type Definitions
+ */
+#define ES_2_ENTRIES		2
+#define ES_ALL_ENTRIES		0
+
+#define DIR_DELETED		0xFFFF0321
+
+/* type values */
+#define TYPE_UNUSED		0x0000
+#define TYPE_DELETED		0x0001
+#define TYPE_INVALID		0x0002
+#define TYPE_CRITICAL_PRI	0x0100
+#define TYPE_BITMAP		0x0101
+#define TYPE_UPCASE		0x0102
+#define TYPE_VOLUME		0x0103
+#define TYPE_DIR		0x0104
+#define TYPE_FILE		0x011F
+#define TYPE_CRITICAL_SEC	0x0200
+#define TYPE_STREAM		0x0201
+#define TYPE_EXTEND		0x0202
+#define TYPE_ACL		0x0203
+#define TYPE_BENIGN_PRI		0x0400
+#define TYPE_GUID		0x0401
+#define TYPE_PADDING		0x0402
+#define TYPE_ACLTAB		0x0403
+#define TYPE_BENIGN_SEC		0x0800
+#define TYPE_ALL		0x0FFF
+
+#define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
+#define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
+#define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
+
+#define FAT_CACHE_SIZE		128
+#define FAT_CACHE_HASH_SIZE	64
+#define BUF_CACHE_SIZE		256
+#define BUF_CACHE_HASH_SIZE	64
+
+#define EXFAT_HINT_NONE		-1
+#define EXFAT_MIN_SUBDIR	2
+
+/*
+ * helpers for cluster size to byte conversion.
+ */
+#define EXFAT_CLU_TO_B(b, sbi)		((b) << (sbi)->cluster_size_bits)
+#define EXFAT_B_TO_CLU(b, sbi)		((b) >> (sbi)->cluster_size_bits)
+#define EXFAT_B_TO_CLU_ROUND_UP(b, sbi)	\
+	(((b - 1) >> (sbi)->cluster_size_bits) + 1)
+#define EXFAT_CLU_OFFSET(off, sbi)	((off) & ((sbi)->cluster_size - 1))
+
+/*
+ * helpers for block size to byte conversion.
+ */
+#define EXFAT_BLK_TO_B(b, sb)		((b) << (sb)->s_blocksize_bits)
+#define EXFAT_B_TO_BLK(b, sb)		((b) >> (sb)->s_blocksize_bits)
+#define EXFAT_B_TO_BLK_ROUND_UP(b, sb)	\
+	(((b - 1) >> (sb)->s_blocksize_bits) + 1)
+#define EXFAT_BLK_OFFSET(off, sb)	((off) & ((sb)->s_blocksize - 1))
+
+/*
+ * helpers for block size to dentry size conversion.
+ */
+#define EXFAT_B_TO_DEN_IDX(b, sbi)	\
+	((b) << ((sbi)->cluster_size_bits - DENTRY_SIZE_BITS))
+#define EXFAT_B_TO_DEN(b)		((b) >> DENTRY_SIZE_BITS)
+#define EXFAT_DEN_TO_B(b)		((b) << DENTRY_SIZE_BITS)
+
+/*
+ * helpers for fat entry.
+ */
+#define FAT_ENT_SIZE (4)
+#define FAT_ENT_SIZE_BITS (2)
+#define FAT_ENT_OFFSET_SECTOR(sb, loc) (EXFAT_SB(sb)->FAT1_start_sector + \
+	(((u64)loc << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
+#define FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc)	\
+	((loc << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
+
+/*
+ * helpers for bitmap.
+ */
+#define CLUSTER_TO_BITMAP_ENT(clu) ((clu) - EXFAT_RESERVED_CLUSTERS)
+#define BITMAP_ENT_TO_CLUSTER(ent) ((ent) + EXFAT_RESERVED_CLUSTERS)
+#define BITS_PER_SECTOR(sb) ((sb)->s_blocksize * BITS_PER_BYTE)
+#define BITS_PER_SECTOR_MASK(sb) (BITS_PER_SECTOR(sb) - 1)
+#define BITMAP_OFFSET_SECTOR_INDEX(sb, ent) \
+	((ent / BITS_PER_BYTE) >> (sb)->s_blocksize_bits)
+#define BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent) (ent & BITS_PER_SECTOR_MASK(sb))
+#define BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent) \
+	((ent / BITS_PER_BYTE) & ((sb)->s_blocksize - 1))
+#define BITS_PER_BYTE_MASK	0x7
+#define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base))) - 1)
+
+struct exfat_dentry_namebuf {
+	char *lfn;
+	int lfnbuf_len; /* usally MAX_UNINAME_BUF_SIZE */
+};
+
+/* unicode name structure */
+struct exfat_uni_name {
+	/* +3 for null and for converting */
+	unsigned short name[MAX_NAME_LENGTH + 3];
+	unsigned short name_hash;
+	unsigned char name_len;
+};
+
+/* directory structure */
+struct exfat_chain {
+	unsigned int dir;
+	unsigned int size;
+	unsigned char flags;
+};
+
+/* first empty entry hint information */
+struct exfat_hint_femp {
+	/* entry index of a directory */
+	int eidx;
+	/* count of continuous empty entry */
+	int count;
+	/* the cluster that first empty slot exists in */
+	struct exfat_chain cur;
+};
+
+/* hint structure */
+struct exfat_hint {
+	unsigned int clu;
+	union {
+		unsigned int off; /* cluster offset */
+		int eidx; /* entry index */
+	};
+};
+
+struct exfat_entry_set_cache {
+	/* sector number that contains file_entry */
+	sector_t sector;
+	/* byte offset in the sector */
+	unsigned int offset;
+	/* flag in stream entry. 01 for cluster chain, 03 for contig. */
+	int alloc_flag;
+	unsigned int num_entries;
+	struct exfat_dentry entries[];
+};
+
+struct exfat_dir_entry {
+	struct exfat_chain dir;
+	int entry;
+	unsigned int type;
+	unsigned int start_clu;
+	unsigned char flags;
+	unsigned short attr;
+	loff_t size;
+	unsigned int num_subdirs;
+	struct timespec64 atime;
+	struct timespec64 mtime;
+	struct timespec64 crtime;
+	struct exfat_dentry_namebuf namebuf;
+};
+
+/*
+ * exfat mount in-memory data
+ */
+struct exfat_mount_options {
+	kuid_t fs_uid;
+	kgid_t fs_gid;
+	unsigned short fs_fmask;
+	unsigned short fs_dmask;
+	/* permission for setting the [am]time */
+	unsigned short allow_utime;
+	/* charset for filename input/display */
+	char *iocharset;
+	/* on error: continue, panic, remount-ro */
+	enum exfat_error_mode errors;
+	unsigned utf8:1, /* Use of UTF-8 character set */
+		 discard:1; /* Issue discard requests on deletions */
+	int time_offset; /* Offset of timestamps from UTC (in minutes) */
+};
+
+/*
+ * EXFAT file system superblock in-memory data
+ */
+struct exfat_sb_info {
+	unsigned long long num_sectors; /* num of sectors in volume */
+	unsigned int num_clusters; /* num of clusters in volume */
+	unsigned int cluster_size; /* cluster size in bytes */
+	unsigned int cluster_size_bits;
+	unsigned int sect_per_clus; /* cluster size in sectors */
+	unsigned int sect_per_clus_bits;
+	unsigned long long FAT1_start_sector; /* FAT1 start sector */
+	unsigned long long FAT2_start_sector; /* FAT2 start sector */
+	unsigned long long data_start_sector; /* data area start sector */
+	unsigned int num_FAT_sectors; /* num of FAT sectors */
+	unsigned int root_dir; /* root dir cluster */
+	unsigned int dentries_per_clu; /* num of dentries per cluster */
+	unsigned int vol_flag; /* volume dirty flag */
+	struct buffer_head *pbr_bh; /* buffer_head of PBR sector */
+
+	unsigned int map_clu; /* allocation bitmap start cluster */
+	unsigned int map_sectors; /* num of allocation bitmap sectors */
+	struct buffer_head **vol_amap; /* allocation bitmap */
+
+	unsigned short *vol_utbl; /* upcase table */
+
+	unsigned int clu_srch_ptr; /* cluster search pointer */
+	unsigned int used_clusters; /* number of used clusters */
+
+	unsigned long s_state;
+	struct mutex s_lock; /* superblock lock */
+	struct exfat_mount_options options;
+	struct nls_table *nls_io; /* Charset used for input and display */
+	struct ratelimit_state ratelimit;
+
+	spinlock_t inode_hash_lock;
+	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
+
+	struct rcu_head rcu;
+};
+
+/*
+ * EXFAT file system inode in-memory data
+ */
+struct exfat_inode_info {
+	struct exfat_chain dir;
+	int entry;
+	unsigned int type;
+	unsigned short attr;
+	unsigned int start_clu;
+	unsigned char flags;
+	/*
+	 * the copy of low 32bit of i_version to check
+	 * the validation of hint_stat.
+	 */
+	unsigned int version;
+	/* file offset or dentry index for readdir */
+	loff_t rwoffset;
+
+	/* hint for cluster last accessed */
+	struct exfat_hint hint_bmap;
+	/* hint for entry index we try to lookup next time */
+	struct exfat_hint hint_stat;
+	/* hint for first empty entry */
+	struct exfat_hint_femp hint_femp;
+
+	spinlock_t cache_lru_lock;
+	struct list_head cache_lru;
+	int nr_caches;
+	/* for avoiding the race between alloc and free */
+	unsigned int cache_valid_id;
+
+	/*
+	 * NOTE: i_size_ondisk is 64bits, so must hold ->inode_lock to access.
+	 * physically allocated size.
+	 */
+	loff_t i_size_ondisk;
+	/* block-aligned i_size (used in cont_write_begin) */
+	loff_t i_size_aligned;
+	/* on-disk position of directory entry or 0 */
+	loff_t i_pos;
+	/* hash by i_location */
+	struct hlist_node i_hash_fat;
+	/* protect bmap against truncate */
+	struct rw_semaphore truncate_lock;
+	struct inode vfs_inode;
+	/* File creation time */
+	struct timespec64 i_crtime;
+};
+
+static inline struct exfat_sb_info *EXFAT_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline struct exfat_inode_info *EXFAT_I(struct inode *inode)
+{
+	return container_of(inode, struct exfat_inode_info, vfs_inode);
+}
+
+/*
+ * If ->i_mode can't hold 0222 (i.e. ATTR_RO), we use ->i_attrs to
+ * save ATTR_RO instead of ->i_mode.
+ *
+ * If it's directory and !sbi->options.rodir, ATTR_RO isn't read-only
+ * bit, it's just used as flag for app.
+ */
+static inline int exfat_mode_can_hold_ro(struct inode *inode)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+
+	if (S_ISDIR(inode->i_mode))
+		return 0;
+
+	if ((~sbi->options.fs_fmask) & 0222)
+		return 1;
+	return 0;
+}
+
+/* Convert attribute bits and a mask to the UNIX mode. */
+static inline mode_t exfat_make_mode(struct exfat_sb_info *sbi,
+		unsigned short attr, mode_t mode)
+{
+	if ((attr & ATTR_READONLY) && !(attr & ATTR_SUBDIR))
+		mode &= ~0222;
+
+	if (attr & ATTR_SUBDIR)
+		return (mode & ~sbi->options.fs_dmask) | S_IFDIR;
+
+	return (mode & ~sbi->options.fs_fmask) | S_IFREG;
+}
+
+/* Return the FAT attribute byte for this inode */
+static inline unsigned short exfat_make_attr(struct inode *inode)
+{
+	unsigned short attr = EXFAT_I(inode)->attr;
+
+	if (S_ISDIR(inode->i_mode))
+		attr |= ATTR_SUBDIR;
+	if (exfat_mode_can_hold_ro(inode) && !(inode->i_mode & 0222))
+		attr |= ATTR_READONLY;
+	return attr;
+}
+
+static inline void exfat_save_attr(struct inode *inode, unsigned short attr)
+{
+	if (exfat_mode_can_hold_ro(inode))
+		EXFAT_I(inode)->attr = attr & (ATTR_RWMASK | ATTR_READONLY);
+	else
+		EXFAT_I(inode)->attr = attr & ATTR_RWMASK;
+}
+
+static inline bool exfat_is_last_sector_in_cluster(struct exfat_sb_info *sbi,
+		sector_t sec)
+{
+	return ((sec - sbi->data_start_sector + 1) &
+		((1 << sbi->sect_per_clus_bits) - 1)) == 0;
+}
+
+static inline sector_t exfat_cluster_to_sector(struct exfat_sb_info *sbi,
+		unsigned int clus)
+{
+	return ((clus - EXFAT_RESERVED_CLUSTERS) << sbi->sect_per_clus_bits) +
+		sbi->data_start_sector;
+}
+
+static inline int exfat_sector_to_cluster(struct exfat_sb_info *sbi,
+		sector_t sec)
+{
+	return ((sec - sbi->data_start_sector) >> sbi->sect_per_clus_bits) +
+		EXFAT_RESERVED_CLUSTERS;
+}
+
+/* super.c */
+int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
+
+/* fatent.c */
+#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
+
+int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
+		struct exfat_chain *p_chain);
+int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain);
+int exfat_ent_get(struct super_block *sb, unsigned int loc,
+		unsigned int *content);
+int exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content);
+int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, struct exfat_dentry *p_entry);
+int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
+		unsigned int len);
+int exfat_zeroed_cluster(struct inode *dir, unsigned int clu);
+int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
+		unsigned int *ret_clu);
+int exfat_count_num_clusters(struct super_block *sb,
+		struct exfat_chain *p_chain, unsigned int *ret_count);
+
+/* balloc.c */
+int exfat_load_bitmap(struct super_block *sb);
+void exfat_free_bitmap(struct exfat_sb_info *sbi);
+int exfat_set_bitmap(struct inode *inode, unsigned int clu);
+void exfat_clear_bitmap(struct inode *inode, unsigned int clu);
+unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
+int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
+
+/* file.c */
+extern const struct file_operations exfat_file_operations;
+int __exfat_truncate(struct inode *inode, loff_t new_size);
+void exfat_truncate(struct inode *inode, loff_t size);
+int exfat_setattr(struct dentry *dentry, struct iattr *attr);
+int exfat_getattr(const struct path *path, struct kstat *stat,
+		unsigned int request_mask, unsigned int query_flags);
+
+/* namei.c */
+extern const struct dentry_operations exfat_dentry_ops;
+extern const struct dentry_operations exfat_utf8_dentry_ops;
+
+/* cache.c */
+int exfat_cache_init(void);
+void exfat_cache_shutdown(void);
+void exfat_cache_init_inode(struct inode *inode);
+void exfat_cache_inval_inode(struct inode *inode);
+int exfat_get_cluster(struct inode *inode, unsigned int cluster,
+		unsigned int *fclus, unsigned int *dclus,
+		unsigned int *last_dclus, int allow_eof);
+
+/* dir.c */
+extern const struct inode_operations exfat_dir_inode_operations;
+extern const struct file_operations exfat_dir_operations;
+unsigned int exfat_get_entry_type(struct exfat_dentry *p_entry);
+int exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, unsigned int type, unsigned int start_clu,
+		unsigned long long size);
+int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, int num_entries, struct exfat_uni_name *p_uniname);
+int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,
+		int entry, int order, int num_entries);
+int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
+		int entry);
+int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
+		struct exfat_entry_set_cache *es, int sync);
+int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
+int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
+		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
+		int num_entries, unsigned int type);
+int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
+int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, sector_t *sector, int *offset);
+struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
+		sector_t *sector);
+struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
+		struct exfat_chain *p_dir, int entry, unsigned int type,
+		struct exfat_dentry **file_ep);
+int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
+
+/* inode.c */
+extern const struct inode_operations exfat_file_inode_operations;
+void exfat_sync_inode(struct inode *inode);
+struct inode *exfat_build_inode(struct super_block *sb,
+		struct exfat_dir_entry *info, loff_t i_pos);
+void exfat_hash_inode(struct inode *inode, loff_t i_pos);
+void exfat_unhash_inode(struct inode *inode);
+struct inode *exfat_iget(struct super_block *sb, loff_t i_pos);
+int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
+void exfat_evict_inode(struct inode *inode);
+int exfat_block_truncate_page(struct inode *inode, loff_t from);
+
+/* exfat/nls.c */
+unsigned short exfat_toupper(struct super_block *sb, unsigned short a);
+int exfat_uniname_ncmp(struct super_block *sb, unsigned short *a,
+		unsigned short *b, unsigned int len);
+int exfat_utf16_to_nls(struct super_block *sb,
+		struct exfat_uni_name *uniname, unsigned char *p_cstring,
+		int len);
+int exfat_nls_to_utf16(struct super_block *sb,
+		const unsigned char *p_cstring, const int len,
+		struct exfat_uni_name *uniname, int *p_lossy);
+int exfat_create_upcase_table(struct super_block *sb);
+void exfat_free_upcase_table(struct exfat_sb_info *sbi);
+unsigned short exfat_high_surrogate(unicode_t u);
+unsigned short exfat_low_surrogate(unicode_t u);
+
+/* exfat/misc.c */
+void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
+		__printf(3, 4) __cold;
+#define exfat_fs_error(sb, fmt, args...)          \
+		__exfat_fs_error(sb, 1, fmt, ## args)
+#define exfat_fs_error_ratelimit(sb, fmt, args...) \
+		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
+		fmt, ## args)
+void exfat_msg(struct super_block *sb, const char *lv, const char *fmt, ...)
+		__printf(3, 4) __cold;
+void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		u8 tz, __le16 time, __le16 date, u8 time_ms);
+void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms);
+unsigned short exfat_calc_chksum_2byte(void *data, int len,
+		unsigned short chksum, int type);
+void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
+void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
+		unsigned int size, unsigned char flags);
+void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
+
+#endif /* !_EXFAT_FS_H */
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
new file mode 100644
index 000000000000..2a841010e649
--- /dev/null
+++ b/fs/exfat/exfat_raw.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _EXFAT_RAW_H
+#define _EXFAT_RAW_H
+
+#include <linux/types.h>
+
+#define PBR_SIGNATURE		0xAA55
+
+#define EXFAT_MAX_FILE_LEN	255
+
+#define VOL_CLEAN		0x0000
+#define VOL_DIRTY		0x0002
+
+#define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
+#define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
+#define EXFAT_FREE_CLUSTER	0
+/* Cluster 0, 1 are reserved, the first cluster is 2 in the cluster heap. */
+#define EXFAT_RESERVED_CLUSTERS	2
+#define EXFAT_FIRST_CLUSTER	2
+#define EXFAT_DATA_CLUSTER_COUNT(sbi)	\
+	((sbi)->num_clusters - EXFAT_RESERVED_CLUSTERS)
+
+/* AllocationPossible and NoFatChain field in GeneralSecondaryFlags Field */
+#define ALLOC_FAT_CHAIN		0x01
+#define ALLOC_NO_FAT_CHAIN	0x03
+
+#define DENTRY_SIZE		32 /* directory entry size */
+#define DENTRY_SIZE_BITS	5
+/* exFAT allows 8388608(256MB) directory entries */
+#define MAX_EXFAT_DENTRIES	8388608
+
+/* dentry types */
+#define EXFAT_UNUSED		0x00	/* end of directory */
+#define EXFAT_DELETE		(~0x80)
+#define IS_EXFAT_DELETED(x)	((x) < 0x80) /* deleted file (0x01~0x7F) */
+#define EXFAT_INVAL		0x80	/* invalid value */
+#define EXFAT_BITMAP		0x81	/* allocation bitmap */
+#define EXFAT_UPCASE		0x82	/* upcase table */
+#define EXFAT_VOLUME		0x83	/* volume label */
+#define EXFAT_FILE		0x85	/* file or dir */
+#define EXFAT_GUID		0xA0
+#define EXFAT_PADDING		0xA1
+#define EXFAT_ACLTAB		0xA2
+#define EXFAT_STREAM		0xC0	/* stream entry */
+#define EXFAT_NAME		0xC1	/* file name entry */
+#define EXFAT_ACL		0xC2	/* stream entry */
+
+#define IS_EXFAT_CRITICAL_PRI(x)	(x < 0xA0)
+#define IS_EXFAT_BENIGN_PRI(x)		(x < 0xC0)
+#define IS_EXFAT_CRITICAL_SEC(x)	(x < 0xE0)
+
+/* checksum types */
+#define CS_DIR_ENTRY		0
+#define CS_PBR_SECTOR		1
+#define CS_DEFAULT		2
+
+/* file attributes */
+#define ATTR_READONLY		0x0001
+#define ATTR_HIDDEN		0x0002
+#define ATTR_SYSTEM		0x0004
+#define ATTR_VOLUME		0x0008
+#define ATTR_SUBDIR		0x0010
+#define ATTR_ARCHIVE		0x0020
+
+#define ATTR_RWMASK		(ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME | \
+				 ATTR_SUBDIR | ATTR_ARCHIVE)
+
+#define PBR64_JUMP_BOOT_LEN		3
+#define PBR64_OEM_NAME_LEN		8
+#define PBR64_RESERVED_LEN		53
+
+#define EXFAT_FILE_NAME_LEN		15
+
+/* EXFAT BIOS parameter block (64 bytes) */
+struct bpb64 {
+	__u8 jmp_boot[PBR64_JUMP_BOOT_LEN];
+	__u8 oem_name[PBR64_OEM_NAME_LEN];
+	__u8 res_zero[PBR64_RESERVED_LEN];
+} __packed;
+
+/* EXFAT EXTEND BIOS parameter block (56 bytes) */
+struct bsx64 {
+	__le64 vol_offset;
+	__le64 vol_length;
+	__le32 fat_offset;
+	__le32 fat_length;
+	__le32 clu_offset;
+	__le32 clu_count;
+	__le32 root_cluster;
+	__le32 vol_serial;
+	__u8 fs_version[2];
+	__le16 vol_flags;
+	__u8 sect_size_bits;
+	__u8 sect_per_clus_bits;
+	__u8 num_fats;
+	__u8 phy_drv_no;
+	__u8 perc_in_use;
+	__u8 reserved2[7];
+} __packed;
+
+/* EXFAT PBR[BPB+BSX] (120 bytes) */
+struct pbr64 {
+	struct bpb64 bpb;
+	struct bsx64 bsx;
+} __packed;
+
+/* Common PBR[Partition Boot Record] (512 bytes) */
+struct pbr {
+	union {
+		__u8 raw[64];
+		struct bpb64 f64;
+	} bpb;
+	union {
+		__u8 raw[56];
+		struct bsx64 f64;
+	} bsx;
+	__u8 boot_code[390];
+	__le16 signature;
+} __packed;
+
+struct exfat_dentry {
+	__u8 type;
+	union {
+		struct {
+			__u8 num_ext;
+			__le16 checksum;
+			__le16 attr;
+			__le16 reserved1;
+			__le16 create_time;
+			__le16 create_date;
+			__le16 modify_time;
+			__le16 modify_date;
+			__le16 access_time;
+			__le16 access_date;
+			__u8 create_time_ms;
+			__u8 modify_time_ms;
+			__u8 create_tz;
+			__u8 modify_tz;
+			__u8 access_tz;
+			__u8 reserved2[7];
+		} __packed file; /* file directory entry */
+		struct {
+			__u8 flags;
+			__u8 reserved1;
+			__u8 name_len;
+			__le16 name_hash;
+			__le16 reserved2;
+			__le64 valid_size;
+			__le32 reserved3;
+			__le32 start_clu;
+			__le64 size;
+		} __packed stream; /* stream extension directory entry */
+		struct {
+			__u8 flags;
+			__le16 unicode_0_14[EXFAT_FILE_NAME_LEN];
+		} __packed name; /* file name directory entry */
+		struct {
+			__u8 flags;
+			__u8 reserved[18];
+			__le32 start_clu;
+			__le64 size;
+		} __packed bitmap; /* allocation bitmap directory entry */
+		struct {
+			__u8 reserved1[3];
+			__le32 checksum;
+			__u8 reserved2[12];
+			__le32 start_clu;
+			__le64 size;
+		} __packed upcase; /* up-case table directory entry */
+	} __packed dentry;
+} __packed;
+
+#define EXFAT_TZ_VALID		(1 << 7)
+
+/* Jan 1 GMT 00:00:00 1980 */
+#define EXFAT_MIN_TIMESTAMP_SECS    315532800LL
+/* Dec 31 GMT 23:59:59 2107 */
+#define EXFAT_MAX_TIMESTAMP_SECS    4354819199LL
+
+#endif /* !_EXFAT_RAW_H */
-- 
2.17.1

