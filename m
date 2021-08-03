Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263B13DED3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhHCL5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhHCL5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:57:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B332C061757;
        Tue,  3 Aug 2021 04:57:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h2so39299973lfu.4;
        Tue, 03 Aug 2021 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7m2QeRXUesY1+XwzhK8rdZuJSuRay3FEG7M5hVgxgfE=;
        b=u5epg6nZlZgNUPAycwX9zMPEuy//QWx3ylhMsHPbLahPq5hYthADjTmJLC0rws9mSZ
         gkoy2mB/rBFfOY7wCzPbnt+EaZfcORAb7chvUW1pSbPascc2bSD5SaKuozqghNhm6iNE
         HupuQzPAGVmn2vUrMgTja4lFHfj7JgHzOfQohjH8orrK38zMs/YhPIHpgP9ulblBDhDa
         dhoPF7CnzsZNggpv5LXHZcZgus3xQ7nXVkGMmjdGYTJ3D3dTLZkvAv2oHtpivAITJPwF
         wVEzR5GtVCq3/B/LPF4WYgbMk52QdxUJmNhe/qQrTTIPgOvPP6TaUieNnwmnKTu5QLjI
         l0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7m2QeRXUesY1+XwzhK8rdZuJSuRay3FEG7M5hVgxgfE=;
        b=ZixWYBXHigXrFb+9orK9se7cRR/RxVqF3Q/nfjsBTpbvukL98EusngkicNsMGCYNSO
         nmZrDw+sa6hPwQcSRZ2g0NYTYyZjz6MXiCjFlcb83CHrOcLq29aqciu+glkutMfcAUHt
         dg7HNh4iE3SRjiPDg7cqIUqBye4iLQB9P5cFxjB8wT/0N28ltnyRgOheH/FC3CbC+2dq
         VJdWPjWZkQcg3mDFirRyhG41MwQZBBoLctxf+qeg3LPL6QW58yakFdHejVzZ1rd+XNIr
         mtvxdXfenvz6ms9Hwfpr7UR31Q1MMzgB6mZ36M9VtdEr80y5P5tVbNMjfmii/2sF05D4
         Rp3A==
X-Gm-Message-State: AOAM532ZiSZoTg9xW9vGB4n24cbvjYQDifuas7duYgoBwmKNMDVXQ70n
        JPe8CeepXa8FFVH4Wt1Li28=
X-Google-Smtp-Source: ABdhPJyi+UDPN9ENz3A64pBsD5HVs1q8U3Ht/xaEo6NrGec1Jpbx5SsEypxjBIwcj/OtummQdjbdEQ==
X-Received: by 2002:a05:6512:15a7:: with SMTP id bp39mr6325729lfb.218.1627991834216;
        Tue, 03 Aug 2021 04:57:14 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id y4sm1041698ljc.109.2021.08.03.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:57:13 -0700 (PDT)
Date:   Tue, 3 Aug 2021 14:57:09 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: [PATCH] Restyle comments to better align with kernel-doc
Message-ID: <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Capitalize comments and end with period for better reading.

Also function comments are now little more kernel-doc style. This way we
can easily convert them to kernel-doc style if we want. Note that these
are not yet complete with this style. Example function comments start
with /* and in kernel-doc style they start /**.

Use imperative mood in function descriptions.

Change words like ntfs -> NTFS, linux -> Linux.

Use "we" not "I" when commenting code.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Yes I know that this patch is quite monster. That's why I try to send this
now before patch series get merged. After that this patch probebly needs to
be splitted more and sended in patch series.

If someone thinks this should not be added now it is ok. I have try to read
what is kernel philosophy in case "patch to patch" but haven't found any
good information about it. It is no big deal to add later. In my own mind I
do not want to touch so much comments after code is in.

I also don't know how easy this kind of patch is apply top of the patch
series.
---
 fs/ntfs3/attrib.c   | 232 +++++++-------
 fs/ntfs3/attrlist.c |  64 ++--
 fs/ntfs3/bitfunc.c  |   7 +-
 fs/ntfs3/bitmap.c   | 203 ++++++------
 fs/ntfs3/debug.h    |   5 +-
 fs/ntfs3/dir.c      |  61 ++--
 fs/ntfs3/file.c     |  98 +++---
 fs/ntfs3/frecord.c  | 413 ++++++++++++-------------
 fs/ntfs3/fslog.c    | 728 +++++++++++++++++++++++---------------------
 fs/ntfs3/fsntfs.c   | 244 +++++++--------
 fs/ntfs3/index.c    | 400 ++++++++++++------------
 fs/ntfs3/inode.c    | 243 ++++++++-------
 fs/ntfs3/lznt.c     |  86 +++---
 fs/ntfs3/namei.c    |  72 ++---
 fs/ntfs3/ntfs.h     | 517 +++++++++++++++----------------
 fs/ntfs3/ntfs_fs.h  | 198 ++++++------
 fs/ntfs3/record.c   |  60 ++--
 fs/ntfs3/run.c      | 187 ++++++------
 fs/ntfs3/super.c    | 160 +++++-----
 fs/ntfs3/upcase.c   |   9 +-
 fs/ntfs3/xattr.c    | 107 +++----
 21 files changed, 2008 insertions(+), 2086 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index bca85e7b6eaf..4dc630b28817 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
- * TODO: merge attr_set_size/attr_data_get_block/attr_allocate_frame?
+ * TODO: Merge attr_set_size/attr_data_get_block/attr_allocate_frame?
  */

 #include <linux/blkdev.h>
@@ -20,7 +20,7 @@

 /*
  * You can set external NTFS_MIN_LOG2_OF_CLUMP/NTFS_MAX_LOG2_OF_CLUMP to manage
- * preallocate algorithm
+ * preallocate algorithm.
  */
 #ifndef NTFS_MIN_LOG2_OF_CLUMP
 #define NTFS_MIN_LOG2_OF_CLUMP 16
@@ -35,10 +35,6 @@
 // 16G
 #define NTFS_CLUMP_MAX (1ull << (NTFS_MAX_LOG2_OF_CLUMP + 8))

-/*
- * get_pre_allocated
- *
- */
 static inline u64 get_pre_allocated(u64 size)
 {
 	u32 clump;
@@ -65,7 +61,7 @@ static inline u64 get_pre_allocated(u64 size)
 /*
  * attr_must_be_resident
  *
- * returns true if attribute must be resident
+ * Return: True if attribute must be resident.
  */
 static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
 					 enum ATTR_TYPE type)
@@ -90,9 +86,7 @@ static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
 }

 /*
- * attr_load_runs
- *
- * load all runs stored in 'attr'
+ * attr_load_runs - Load all runs stored in @attr.
  */
 int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
 		   struct runs_tree *run, const CLST *vcn)
@@ -121,9 +115,7 @@ int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
 }

 /*
- * int run_deallocate_ex
- *
- * Deallocate clusters
+ * run_deallocate_ex - Deallocate clusters.
  */
 static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			     CLST vcn, CLST len, CLST *done, bool trim)
@@ -163,7 +155,7 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		vcn_next = vcn + clen;
 		if (!run_get_entry(run, ++idx, &vcn, &lcn, &clen) ||
 		    vcn != vcn_next) {
-			// save memory - don't load entire run
+			/* Save memory - don't load entire run. */
 			goto failed;
 		}
 	}
@@ -176,9 +168,7 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 }

 /*
- * attr_allocate_clusters
- *
- * find free space, mark it as used and store in 'run'
+ * attr_allocate_clusters - Find free space, mark it as used and store in @run.
  */
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
@@ -207,7 +197,7 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		if (new_lcn && vcn == vcn0)
 			*new_lcn = lcn;

-		/* Add new fragment into run storage */
+		/* Add new fragment into run storage. */
 		if (!run_add_entry(run, vcn, lcn, flen, opt == ALLOCATE_MFT)) {
 			down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 			wnd_set_free(wnd, lcn, flen);
@@ -228,7 +218,7 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 	}

 out:
-	/* undo */
+	/* Undo. */
 	run_deallocate_ex(sbi, run, vcn0, vcn - vcn0, NULL, false);
 	run_truncate(run, vcn0);

@@ -236,8 +226,10 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 }

 /*
- * if page is not NULL - it is already contains resident data
- * and locked (called from ni_write_frame)
+ * attr_make_nonresident
+ *
+ * If page is not NULL - it is already contains resident data
+ * and locked (called from ni_write_frame()).
  */
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
@@ -275,7 +267,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,

 	run_init(run);

-	/* make a copy of original attribute */
+	/* Make a copy of original attribute. */
 	attr_s = ntfs_memdup(attr, asize);
 	if (!attr_s) {
 		err = -ENOMEM;
@@ -283,7 +275,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	}

 	if (!len) {
-		/* empty resident -> empty nonresident */
+		/* Empty resident -> Empty nonresident. */
 		alen = 0;
 	} else {
 		const char *data = resident_data(attr);
@@ -294,7 +286,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			goto out1;

 		if (!rsize) {
-			/* empty resident -> non empty nonresident */
+			/* Empty resident -> Non empty nonresident. */
 		} else if (!is_data) {
 			err = ntfs_sb_write_run(sbi, run, 0, data, rsize);
 			if (err)
@@ -319,7 +311,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 		}
 	}

-	/* remove original attribute */
+	/* Remove original attribute. */
 	used -= asize;
 	memmove(attr, Add2Ptr(attr, asize), used - aoff);
 	rec->used = cpu_to_le32(used);
@@ -342,7 +334,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	if (is_data)
 		ni->ni_flags &= ~NI_FLAG_RESIDENT;

-	/* Resident attribute becomes non resident */
+	/* Resident attribute becomes non resident. */
 	return 0;

 out3:
@@ -352,20 +344,18 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	rec->used = cpu_to_le32(used + asize);
 	mi->dirty = true;
 out2:
-	/* undo: do not trim new allocated clusters */
+	/* Undo: Do not trim new allocated clusters. */
 	run_deallocate(sbi, run, false);
 	run_close(run);
 out1:
 	ntfs_free(attr_s);
-	/*reinsert le*/
+	/* Reinsert le. */
 out:
 	return err;
 }

 /*
- * attr_set_size_res
- *
- * helper for attr_set_size
+ * attr_set_size_res - Helper for attr_set_size().
  */
 static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
 			     struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
@@ -407,14 +397,13 @@ static int attr_set_size_res(struct ntfs_inode *ni, struct ATTRIB *attr,
 }

 /*
- * attr_set_size
+ * attr_set_size - Change the size of attribute.
  *
- * change the size of attribute
  * Extend:
- *   - sparse/compressed: no allocated clusters
- *   - normal: append allocated and preallocated new clusters
+ *   - Sparse/compressed: No allocated clusters.
+ *   - Normal: Append allocated and preallocated new clusters.
  * Shrink:
- *   - no deallocate if keep_prealloc is set
+ *   - No deallocate if @keep_prealloc is set.
  */
 int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		  const __le16 *name, u8 name_len, struct runs_tree *run,
@@ -451,7 +440,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		if (err || !attr_b->non_res)
 			goto out;

-		/* layout of records may be changed, so do a full search */
+		/* Layout of records may be changed, so do a full search. */
 		goto again;
 	}

@@ -530,10 +519,10 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 add_alloc_in_same_attr_seg:
 		lcn = 0;
 		if (is_mft) {
-			/* mft allocates clusters from mftzone */
+			/* MFT allocates clusters from MFT zone. */
 			pre_alloc = 0;
 		} else if (is_ext) {
-			/* no preallocate for sparse/compress */
+			/* No preallocate for sparse/compress. */
 			pre_alloc = 0;
 		} else if (pre_alloc == -1) {
 			pre_alloc = 0;
@@ -544,7 +533,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 				pre_alloc = new_alen2 - new_alen;
 			}

-			/* Get the last lcn to allocate from */
+			/* Get the last LCN to allocate from. */
 			if (old_alen &&
 			    !run_lookup_entry(run, vcn, &lcn, NULL, NULL)) {
 				lcn = SPARSE_LCN;
@@ -575,7 +564,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			}
 			alen = to_allocate;
 		} else {
-			/* ~3 bytes per fragment */
+			/* ~3 bytes per fragment. */
 			err = attr_allocate_clusters(
 				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
 				is_mft ? ALLOCATE_MFT : 0, &alen,
@@ -607,12 +596,12 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		mi_b->dirty = true;

 		if (next_svcn >= vcn && !to_allocate) {
-			/* Normal way. update attribute and exit */
+			/* Normal way. Update attribute and exit. */
 			attr_b->nres.data_size = cpu_to_le64(new_size);
 			goto ok;
 		}

-		/* at least two mft to avoid recursive loop*/
+		/* At least two MFT to avoid recursive loop. */
 		if (is_mft && next_svcn == vcn &&
 		    ((u64)done << sbi->cluster_bits) >= 2 * sbi->record_size) {
 			new_size = new_alloc_tmp;
@@ -637,7 +626,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			if (next_svcn < vcn)
 				goto pack_runs;

-			/* layout of records is changed */
+			/* Layout of records is changed. */
 			goto again;
 		}

@@ -645,15 +634,15 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			err = ni_create_attr_list(ni);
 			if (err)
 				goto out;
-			/* layout of records is changed */
+			/* Layout of records is changed. */
 		}

 		if (next_svcn >= vcn) {
-			/* this is mft data, repeat */
+			/* This is MFT data, repeat. */
 			goto again;
 		}

-		/* insert new attribute segment */
+		/* Insert new attribute segment. */
 		err = ni_insert_nonresident(ni, type, name, name_len, run,
 					    next_svcn, vcn - next_svcn,
 					    attr_b->flags, &attr, &mi);
@@ -667,8 +656,10 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		evcn = le64_to_cpu(attr->nres.evcn);

 		le_b = NULL;
-		/* layout of records maybe changed */
-		/* find base attribute to update*/
+		/*
+		 * Layout of records maybe changed.
+		 * Find base attribute to update.
+		 */
 		attr_b = ni_find_attr(ni, NULL, &le_b, type, name, name_len,
 				      NULL, &mi_b);
 		if (!attr_b) {
@@ -704,11 +695,11 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			u16 le_sz = le16_to_cpu(le->size);

 			/*
-			 * NOTE: list entries for one attribute are always
+			 * NOTE: List entries for one attribute are always
 			 * the same size. We deal with last entry (vcn==0)
 			 * and it is not first in entries array
-			 * (list entry for std attribute always first)
-			 * So it is safe to step back
+			 * (list entry for std attribute always first).
+			 * So it is safe to step back.
 			 */
 			mi_remove_attr(mi, attr);

@@ -793,7 +784,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (!err && attr_b && ret)
 		*ret = attr_b;

-	/* update inode_set_bytes*/
+	/* Update inode_set_bytes. */
 	if (!err && ((type == ATTR_DATA && !name_len) ||
 		     (type == ATTR_ALLOC && name == I30_NAME))) {
 		bool dirty = false;
@@ -843,7 +834,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	up_read(&ni->file.run_lock);

 	if (ok && (*lcn != SPARSE_LCN || !new)) {
-		/* normal way */
+		/* Normal way. */
 		return 0;
 	}

@@ -909,7 +900,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	if (!ok) {
 		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
 		if (ok && (*lcn != SPARSE_LCN || !new)) {
-			/* normal way */
+			/* Normal way. */
 			err = 0;
 			goto ok;
 		}
@@ -932,7 +923,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		goto out;
 	}

-	/* Get the last lcn to allocate from */
+	/* Get the last LCN to allocate from. */
 	hint = 0;

 	if (vcn > evcn1) {
@@ -970,20 +961,20 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	mi_b->dirty = true;
 	mark_inode_dirty(&ni->vfs_inode);

-	/* stored [vcn : next_svcn) from [vcn : end) */
+	/* Stored [vcn : next_svcn) from [vcn : end). */
 	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;

 	if (end <= evcn1) {
 		if (next_svcn == evcn1) {
-			/* Normal way. update attribute and exit */
+			/* Normal way. Update attribute and exit. */
 			goto ok;
 		}
-		/* add new segment [next_svcn : evcn1 - next_svcn )*/
+		/* Add new segment [next_svcn : evcn1 - next_svcn). */
 		if (!ni->attr_list.size) {
 			err = ni_create_attr_list(ni);
 			if (err)
 				goto out;
-			/* layout of records is changed */
+			/* Layout of records is changed. */
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
@@ -1001,7 +992,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,

 	svcn = evcn1;

-	/* Estimate next attribute */
+	/* Estimate next attribute. */
 	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &svcn, &mi);

 	if (attr) {
@@ -1012,7 +1003,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		if (end < next_svcn)
 			end = next_svcn;
 		while (end > evcn) {
-			/* remove segment [svcn : evcn)*/
+			/* Remove segment [svcn : evcn). */
 			mi_remove_attr(mi, attr);

 			if (!al_remove_le(ni, le)) {
@@ -1021,7 +1012,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			}

 			if (evcn + 1 >= alloc) {
-				/* last attribute segment */
+				/* Last attribute segment. */
 				evcn1 = evcn + 1;
 				goto ins_ext;
 			}
@@ -1125,7 +1116,7 @@ int attr_data_write_resident(struct ntfs_inode *ni, struct page *page)
 		return -EINVAL;

 	if (attr->non_res) {
-		/*return special error code to check this case*/
+		/* Return special error code to check this case. */
 		return E_NTFS_NONRESIDENT;
 	}

@@ -1148,9 +1139,7 @@ int attr_data_write_resident(struct ntfs_inode *ni, struct page *page)
 }

 /*
- * attr_load_runs_vcn
- *
- * load runs with vcn
+ * attr_load_runs_vcn - Load runs with VCN.
  */
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		       const __le16 *name, u8 name_len, struct runs_tree *run,
@@ -1180,7 +1169,7 @@ int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
 }

 /*
- * load runs for given range [from to)
+ * attr_wof_load_runs_range - Load runs for given range [from to).
  */
 int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			 const __le16 *name, u8 name_len, struct runs_tree *run,
@@ -1199,7 +1188,7 @@ int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
 						 vcn);
 			if (err)
 				return err;
-			clen = 0; /*next run_lookup_entry(vcn) must be success*/
+			clen = 0; /* Next run_lookup_entry(vcn) must be success. */
 		}
 	}

@@ -1210,7 +1199,7 @@ int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
 /*
  * attr_wof_frame_info
  *
- * read header of xpress/lzx file to get info about frame
+ * Read header of Xpress/LZX file to get info about frame.
  */
 int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 			struct runs_tree *run, u64 frame, u64 frames,
@@ -1227,20 +1216,20 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	__le64 *off64;

 	if (ni->vfs_inode.i_size < 0x100000000ull) {
-		/* file starts with array of 32 bit offsets */
+		/* File starts with array of 32 bit offsets. */
 		bytes_per_off = sizeof(__le32);
 		vbo[1] = frame << 2;
 		*vbo_data = frames << 2;
 	} else {
-		/* file starts with array of 64 bit offsets */
+		/* File starts with array of 64 bit offsets. */
 		bytes_per_off = sizeof(__le64);
 		vbo[1] = frame << 3;
 		*vbo_data = frames << 3;
 	}

 	/*
-	 * read 4/8 bytes at [vbo - 4(8)] == offset where compressed frame starts
-	 * read 4/8 bytes at [vbo] == offset where compressed frame ends
+	 * Read 4/8 bytes at [vbo - 4(8)] == offset where compressed frame starts.
+	 * Read 4/8 bytes at [vbo] == offset where compressed frame ends.
 	 */
 	if (!attr->non_res) {
 		if (vbo[1] + bytes_per_off > le32_to_cpu(attr->res.data_size)) {
@@ -1329,7 +1318,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 				off[0] = le64_to_cpu(*off64);
 			}
 		} else {
-			/* two values in one page*/
+			/* Two values in one page. */
 			if (bytes_per_off == sizeof(__le32)) {
 				off32 = Add2Ptr(addr, voff);
 				off[0] = le32_to_cpu(off32[-1]);
@@ -1355,9 +1344,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 #endif

 /*
- * attr_is_frame_compressed
- *
- * This function is used to detect compressed frame
+ * attr_is_frame_compressed - Used to detect compressed frame.
  */
 int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 			     CLST frame, CLST *clst_data)
@@ -1391,14 +1378,14 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 	}

 	if (lcn == SPARSE_LCN) {
-		/* sparsed frame */
+		/* Sparsed frame. */
 		return 0;
 	}

 	if (clen >= clst_frame) {
 		/*
 		 * The frame is not compressed 'cause
-		 * it does not contain any sparse clusters
+		 * it does not contain any sparse clusters.
 		 */
 		*clst_data = clst_frame;
 		return 0;
@@ -1409,8 +1396,8 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 	*clst_data = clen;

 	/*
-	 * The frame is compressed if *clst_data + slen >= clst_frame
-	 * Check next fragments
+	 * The frame is compressed if *clst_data + slen >= clst_frame.
+	 * Check next fragments.
 	 */
 	while ((vcn += clen) < alen) {
 		vcn_next = vcn;
@@ -1433,8 +1420,8 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 		} else {
 			if (slen) {
 				/*
-				 * data_clusters + sparse_clusters =
-				 * not enough for frame
+				 * Data_clusters + sparse_clusters =
+				 * not enough for frame.
 				 */
 				return -EINVAL;
 			}
@@ -1445,11 +1432,11 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 			if (!slen) {
 				/*
 				 * There is no sparsed clusters in this frame
-				 * So it is not compressed
+				 * so it is not compressed.
 				 */
 				*clst_data = clst_frame;
 			} else {
-				/*frame is compressed*/
+				/* Frame is compressed. */
 			}
 			break;
 		}
@@ -1459,10 +1446,9 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 }

 /*
- * attr_allocate_frame
+ * attr_allocate_frame - Allocate/free clusters for @frame.
  *
- * allocate/free clusters for 'frame'
- * assumed: down_write(&ni->file.run_lock);
+ * Assumed: down_write(&ni->file.run_lock);
  */
 int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			u64 new_valid)
@@ -1538,10 +1524,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			goto out;
 		}
 		end = vcn + clst_data;
-		/* run contains updated range [vcn + len : end) */
+		/* Run contains updated range [vcn + len : end). */
 	} else {
 		CLST alen, hint = 0;
-		/* Get the last lcn to allocate from */
+		/* Get the last LCN to allocate from. */
 		if (vcn + clst_data &&
 		    !run_lookup_entry(run, vcn + clst_data - 1, &hint, NULL,
 				      NULL)) {
@@ -1555,7 +1541,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			goto out;

 		end = vcn + len;
-		/* run contains updated range [vcn + clst_data : end) */
+		/* Run contains updated range [vcn + clst_data : end). */
 	}

 	total_size += (u64)len << sbi->cluster_bits;
@@ -1571,20 +1557,20 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	mi_b->dirty = true;
 	mark_inode_dirty(&ni->vfs_inode);

-	/* stored [vcn : next_svcn) from [vcn : end) */
+	/* Stored [vcn : next_svcn) from [vcn : end). */
 	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;

 	if (end <= evcn1) {
 		if (next_svcn == evcn1) {
-			/* Normal way. update attribute and exit */
+			/* Normal way. Update attribute and exit. */
 			goto ok;
 		}
-		/* add new segment [next_svcn : evcn1 - next_svcn )*/
+		/* Add new segment [next_svcn : evcn1 - next_svcn). */
 		if (!ni->attr_list.size) {
 			err = ni_create_attr_list(ni);
 			if (err)
 				goto out;
-			/* layout of records is changed */
+			/* Layout of records is changed. */
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
@@ -1602,7 +1588,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,

 	svcn = evcn1;

-	/* Estimate next attribute */
+	/* Estimate next attribute. */
 	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &svcn, &mi);

 	if (attr) {
@@ -1613,7 +1599,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 		if (end < next_svcn)
 			end = next_svcn;
 		while (end > evcn) {
-			/* remove segment [svcn : evcn)*/
+			/* Remove segment [svcn : evcn). */
 			mi_remove_attr(mi, attr);

 			if (!al_remove_le(ni, le)) {
@@ -1622,7 +1608,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			}

 			if (evcn + 1 >= alloc) {
-				/* last attribute segment */
+				/* Last attribute segment. */
 				evcn1 = evcn + 1;
 				goto ins_ext;
 			}
@@ -1684,7 +1670,9 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	return err;
 }

-/* Collapse range in file */
+/*
+ * attr_collapse_range - Collapse range in file.
+ */
 int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 {
 	int err = 0;
@@ -1725,7 +1713,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	}

 	if ((vbo & mask) || (bytes & mask)) {
-		/* allow to collapse only cluster aligned ranges */
+		/* Allow to collapse only cluster aligned ranges. */
 		return -EINVAL;
 	}

@@ -1737,7 +1725,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	if (vbo + bytes >= data_size) {
 		u64 new_valid = min(ni->i_valid, vbo);

-		/* Simple truncate file at 'vbo' */
+		/* Simple truncate file at 'vbo'. */
 		truncate_setsize(&ni->vfs_inode, vbo);
 		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, vbo,
 				    &new_valid, true, NULL);
@@ -1749,7 +1737,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	}

 	/*
-	 * Enumerate all attribute segments and collapse
+	 * Enumerate all attribute segments and collapse.
 	 */
 	alen = alloc_size >> sbi->cluster_bits;
 	vcn = vbo >> sbi->cluster_bits;
@@ -1782,7 +1770,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)

 	for (;;) {
 		if (svcn >= end) {
-			/* shift vcn */
+			/* Shift VCN- */
 			attr->nres.svcn = cpu_to_le64(svcn - len);
 			attr->nres.evcn = cpu_to_le64(evcn1 - 1 - len);
 			if (le) {
@@ -1793,7 +1781,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		} else if (svcn < vcn || end < evcn1) {
 			CLST vcn1, eat, next_svcn;

-			/* collapse a part of this attribute segment */
+			/* Collapse a part of this attribute segment. */
 			err = attr_load_runs(attr, ni, run, &svcn);
 			if (err)
 				goto out;
@@ -1811,7 +1799,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			}

 			if (svcn >= vcn) {
-				/* shift vcn */
+				/* Shift VCN */
 				attr->nres.svcn = cpu_to_le64(vcn);
 				if (le) {
 					le->vcn = attr->nres.svcn;
@@ -1832,7 +1820,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				if (err)
 					goto out;

-				/* layout of records maybe changed */
+				/* Layout of records maybe changed. */
 				attr_b = NULL;
 				le = al_find_ex(ni, NULL, ATTR_DATA, NULL, 0,
 						&next_svcn);
@@ -1842,18 +1830,18 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				}
 			}

-			/* free all allocated memory */
+			/* Free all allocated memory. */
 			run_truncate(run, 0);
 		} else {
 			u16 le_sz;
 			u16 roff = le16_to_cpu(attr->nres.run_off);

-			/*run==1 means unpack and deallocate*/
+			/* run==1 means unpack and deallocate. */
 			run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn,
 				      evcn1 - 1, svcn, Add2Ptr(attr, roff),
 				      le32_to_cpu(attr->size) - roff);

-			/* delete this attribute segment */
+			/* Delete this attribute segment. */
 			mi_remove_attr(mi, attr);
 			if (!le)
 				break;
@@ -1868,13 +1856,13 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				break;

 			if (!svcn) {
-				/* Load next record that contains this attribute */
+				/* Load next record that contains this attribute. */
 				if (ni_load_mi(ni, le, &mi)) {
 					err = -EINVAL;
 					goto out;
 				}

-				/* Look for required attribute */
+				/* Look for required attribute. */
 				attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL,
 						    0, &le->id);
 				if (!attr) {
@@ -1925,7 +1913,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		attr_b->nres.total_size = cpu_to_le64(total_size);
 	mi_b->dirty = true;

-	/*update inode size*/
+	/* Update inode size. */
 	ni->i_valid = valid_size;
 	ni->vfs_inode.i_size = data_size;
 	inode_set_bytes(&ni->vfs_inode, total_size);
@@ -1940,7 +1928,11 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	return err;
 }

-/* not for normal files */
+/*
+ * attr_punch_hole
+ *
+  * Not for normal files.
+  */
 int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 {
 	int err = 0;
@@ -1973,7 +1965,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		return 0;
 	}

-	/* TODO: add support for normal files too */
+	/* TODO: Add support for normal files too. */
 	if (!is_attr_ext(attr_b))
 		return -EOPNOTSUPP;

@@ -1981,7 +1973,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	total_size = le64_to_cpu(attr_b->nres.total_size);

 	if (vbo >= alloc_size) {
-		// NOTE: it is allowed
+		// NOTE: It is allowed.
 		return 0;
 	}

@@ -1990,7 +1982,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)

 	down_write(&ni->file.run_lock);
 	/*
-	 * Enumerate all attribute segments and punch hole where necessary
+	 * Enumerate all attribute segments and punch hole where necessary.
 	 */
 	alen = alloc_size >> sbi->cluster_bits;
 	vcn = vbo >> sbi->cluster_bits;
@@ -2036,7 +2028,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			goto out;

 		if (dealloc2 == dealloc) {
-			/* looks like  the required range is already sparsed */
+			/* Looks like the required range is already sparsed. */
 		} else {
 			if (!run_add_entry(run, vcn1, SPARSE_LCN, zero,
 					   false)) {
@@ -2048,7 +2040,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			if (err)
 				goto out;
 		}
-		/* free all allocated memory */
+		/* Free all allocated memory. */
 		run_truncate(run, 0);

 		if (evcn1 >= alen)
@@ -2068,7 +2060,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	attr_b->nres.total_size = cpu_to_le64(total_size);
 	mi_b->dirty = true;

-	/*update inode size*/
+	/* Update inode size. */
 	inode_set_bytes(&ni->vfs_inode, total_size);
 	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 	mark_inode_dirty(&ni->vfs_inode);
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index ea561361b576..5babc7d2b1b2 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -14,7 +14,11 @@
 #include "ntfs.h"
 #include "ntfs_fs.h"

-/* Returns true if le is valid */
+/*
+ * al_is_valid_le
+ *
+ * Return: True if @le is valid.
+ */
 static inline bool al_is_valid_le(const struct ntfs_inode *ni,
 				  struct ATTR_LIST_ENTRY *le)
 {
@@ -101,8 +105,9 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 /*
  * al_enumerate
  *
- * Returns the next list 'le'
- * if 'le' is NULL then returns the first 'le'
+ * Return:
+ * * The next list le.
+ * * If @le is NULL then return the first le.
  */
 struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 				     struct ATTR_LIST_ENTRY *le)
@@ -115,22 +120,22 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 	} else {
 		sz = le16_to_cpu(le->size);
 		if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
-			/* Impossible 'cause we should not return such 'le' */
+			/* Impossible 'cause we should not return such le. */
 			return NULL;
 		}
 		le = Add2Ptr(le, sz);
 	}

-	/* Check boundary */
+	/* Check boundary. */
 	off = PtrOffset(ni->attr_list.le, le);
 	if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
-		// The regular end of list
+		/* The regular end of list. */
 		return NULL;
 	}

 	sz = le16_to_cpu(le->size);

-	/* Check 'le' for errors */
+	/* Check le for errors. */
 	if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
 	    off + sz > ni->attr_list.size ||
 	    sz < le->name_off + le->name_len * sizeof(short)) {
@@ -143,8 +148,9 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 /*
  * al_find_le
  *
- * finds the first 'le' in the list which matches type, name and vcn
- * Returns NULL if not found
+ * Find the first le in the list which matches type, name and VCN.
+ *
+ * Return: NULL if not found.
  */
 struct ATTR_LIST_ENTRY *al_find_le(struct ntfs_inode *ni,
 				   struct ATTR_LIST_ENTRY *le,
@@ -159,8 +165,9 @@ struct ATTR_LIST_ENTRY *al_find_le(struct ntfs_inode *ni,
 /*
  * al_find_ex
  *
- * finds the first 'le' in the list which matches type, name and vcn
- * Returns NULL if not found
+ * Find the first le in the list which matches type, name and VCN.
+ *
+ * Return: NULL if not found.
  */
 struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
 				   struct ATTR_LIST_ENTRY *le,
@@ -174,7 +181,7 @@ struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
 		u64 le_vcn;
 		int diff = le32_to_cpu(le->type) - type_in;

-		/* List entries are sorted by type, name and vcn */
+		/* List entries are sorted by type, name and VCN. */
 		if (diff < 0)
 			continue;

@@ -187,7 +194,7 @@ struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
 		le_vcn = le64_to_cpu(le->vcn);
 		if (!le_vcn) {
 			/*
-			 * compare entry names only for entry with vcn == 0
+			 * Compare entry names only for entry with vcn == 0.
 			 */
 			diff = ntfs_cmp_names(le_name(le), name_len, name,
 					      name_len, ni->mi.sbi->upcase,
@@ -215,9 +222,9 @@ struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
 }

 /*
- * al_find_le_to_insert
+ * al_find_le_to_insert
  *
- * finds the first list entry which matches type, name and vcn
+ * Find the first list entry which matches type, name and VCN.
  */
 static struct ATTR_LIST_ENTRY *al_find_le_to_insert(struct ntfs_inode *ni,
 						    enum ATTR_TYPE type,
@@ -227,7 +234,7 @@ static struct ATTR_LIST_ENTRY *al_find_le_to_insert(struct ntfs_inode *ni,
 	struct ATTR_LIST_ENTRY *le = NULL, *prev;
 	u32 type_in = le32_to_cpu(type);

-	/* List entries are sorted by type, name, vcn */
+	/* List entries are sorted by type, name and VCN. */
 	while ((le = al_enumerate(ni, prev = le))) {
 		int diff = le32_to_cpu(le->type) - type_in;

@@ -239,7 +246,7 @@ static struct ATTR_LIST_ENTRY *al_find_le_to_insert(struct ntfs_inode *ni,

 		if (!le->vcn) {
 			/*
-			 * compare entry names only for entry with vcn == 0
+			 * Compare entry names only for entry with vcn == 0.
 			 */
 			diff = ntfs_cmp_names(le_name(le), le->name_len, name,
 					      name_len, ni->mi.sbi->upcase,
@@ -261,7 +268,7 @@ static struct ATTR_LIST_ENTRY *al_find_le_to_insert(struct ntfs_inode *ni,
 /*
  * al_add_le
  *
- * adds an "attribute list entry" to the list.
+ * Add an "attribute list entry" to the list.
  */
 int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
 	      u8 name_len, CLST svcn, __le16 id, const struct MFT_REF *ref,
@@ -335,9 +342,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
 }

 /*
- * al_remove_le
- *
- * removes 'le' from attribute list
+ * al_remove_le - Remove @le from attribute list.
  */
 bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le)
 {
@@ -361,9 +366,7 @@ bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le)
 }

 /*
- * al_delete_le
- *
- * deletes from the list the first 'le' which matches its parameters.
+ * al_delete_le - Delete first le from the list which matches its parameters.
  */
 bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 		  const __le16 *name, size_t name_len,
@@ -374,7 +377,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 	size_t off;
 	typeof(ni->attr_list) *al = &ni->attr_list;

-	/* Scan forward to the first 'le' that matches the input */
+	/* Scan forward to the first le that matches the input. */
 	le = al_find_ex(ni, NULL, type, name, name_len, &vcn);
 	if (!le)
 		return false;
@@ -405,9 +408,9 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 		goto next;
 	}

-	/* Save on stack the size of 'le' */
+	/* Save on stack the size of 'le'. */
 	size = le16_to_cpu(le->size);
-	/* Delete 'le'. */
+	/* Delete the le. */
 	memmove(le, Add2Ptr(le, size), al->size - (off + size));

 	al->size -= size;
@@ -416,9 +419,6 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 	return true;
 }

-/*
- * al_update
- */
 int al_update(struct ntfs_inode *ni)
 {
 	int err;
@@ -429,8 +429,8 @@ int al_update(struct ntfs_inode *ni)
 		return 0;

 	/*
-	 * attribute list increased on demand in al_add_le
-	 * attribute list decreased here
+	 * Attribute list increased on demand in al_add_le.
+	 * Attribute list decreased here.
 	 */
 	err = attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, al->size, NULL,
 			    false, &attr);
diff --git a/fs/ntfs3/bitfunc.c b/fs/ntfs3/bitfunc.c
index 2de5faef2721..ce304d40b5e1 100644
--- a/fs/ntfs3/bitfunc.c
+++ b/fs/ntfs3/bitfunc.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
  */
+
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
@@ -32,7 +33,7 @@ static const u8 zero_mask[] = { 0xFF, 0xFE, 0xFC, 0xF8, 0xF0,
 /*
  * are_bits_clear
  *
- * Returns true if all bits [bit, bit+nbits) are zeros "0"
+ * Return: True if all bits [bit, bit+nbits) are zeros "0".
  */
 bool are_bits_clear(const ulong *lmap, size_t bit, size_t nbits)
 {
@@ -74,14 +75,13 @@ bool are_bits_clear(const ulong *lmap, size_t bit, size_t nbits)
 	if (pos && (*map & fill_mask[pos]))
 		return false;

-	// All bits are zero
 	return true;
 }

 /*
  * are_bits_set
  *
- * Returns true if all bits [bit, bit+nbits) are ones "1"
+ * Return: True if all bits [bit, bit+nbits) are ones "1".
  */
 bool are_bits_set(const ulong *lmap, size_t bit, size_t nbits)
 {
@@ -130,6 +130,5 @@ bool are_bits_set(const ulong *lmap, size_t bit, size_t nbits)
 			return false;
 	}

-	// All bits are ones
 	return true;
 }
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 32aab0031221..ff586798b62a 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -6,7 +6,7 @@
  * This code builds two trees of free clusters extents.
  * Trees are sorted by start of extent and by length of extent.
  * NTFS_MAX_WND_EXTENTS defines the maximum number of elements in trees.
- * In extreme case code reads on-disk bitmap to find free clusters
+ * In extreme case code reads on-disk bitmap to find free clusters.
  *
  */

@@ -29,12 +29,10 @@ struct rb_node_key {
 	size_t key;
 };

-/*
- * Tree is sorted by start (key)
- */
+/* Tree is sorted by start (key). */
 struct e_node {
-	struct rb_node_key start; /* Tree sorted by start */
-	struct rb_node_key count; /* Tree sorted by len*/
+	struct rb_node_key start; /* Tree sorted by start. */
+	struct rb_node_key count; /* Tree sorted by len. */
 };

 static int wnd_rescan(struct wnd_bitmap *wnd);
@@ -62,9 +60,12 @@ static inline u32 wnd_bits(const struct wnd_bitmap *wnd, size_t i)
 }

 /*
- * b_pos + b_len - biggest fragment
- * Scan range [wpos wbits) window 'buf'
- * Returns -1 if not found
+ * wnd_scan
+ *
+ * b_pos + b_len - biggest fragment.
+ * Scan range [wpos wbits) window @buf.
+ *
+ * Return: -1 if not found.
  */
 static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
 		       size_t to_alloc, size_t *prev_tail, size_t *b_pos,
@@ -96,7 +97,7 @@ static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
 		}

 		/*
-		 * Now we have a fragment [wpos, wend) staring with 0
+		 * Now we have a fragment [wpos, wend) staring with 0.
 		 */
 		end = wpos + to_alloc - *prev_tail;
 		free_bits = find_next_bit(buf, min(end, wend), wpos);
@@ -125,9 +126,7 @@ static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
 }

 /*
- * wnd_close
- *
- * Frees all resources
+ * wnd_close - Frees all resources.
  */
 void wnd_close(struct wnd_bitmap *wnd)
 {
@@ -170,9 +169,7 @@ static struct rb_node *rb_lookup(struct rb_root *root, size_t v)
 }

 /*
- * rb_insert_count
- *
- * Helper function to insert special kind of 'count' tree
+ * rb_insert_count - Helper function to insert special kind of 'count' tree.
  */
 static inline bool rb_insert_count(struct rb_root *root, struct e_node *e)
 {
@@ -205,9 +202,7 @@ static inline bool rb_insert_count(struct rb_root *root, struct e_node *e)
 }

 /*
- * inline bool rb_insert_start
- *
- * Helper function to insert special kind of 'start' tree
+ * rb_insert_start - Helper function to insert special kind of 'count' tree.
  */
 static inline bool rb_insert_start(struct rb_root *root, struct e_node *e)
 {
@@ -237,10 +232,8 @@ static inline bool rb_insert_start(struct rb_root *root, struct e_node *e)
 }

 /*
- * wnd_add_free_ext
- *
- * adds a new extent of free space
- * build = 1 when building tree
+ * wnd_add_free_ext - Adds a new extent of free space.
+ * @build:	1 when building tree.
  */
 static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 			     bool build)
@@ -250,14 +243,14 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 	struct rb_node *n;

 	if (build) {
-		/* Use extent_min to filter too short extents */
+		/* Use extent_min to filter too short extents. */
 		if (wnd->count >= NTFS_MAX_WND_EXTENTS &&
 		    len <= wnd->extent_min) {
 			wnd->uptodated = -1;
 			return;
 		}
 	} else {
-		/* Try to find extent before 'bit' */
+		/* Try to find extent before 'bit'. */
 		n = rb_lookup(&wnd->start_tree, bit);

 		if (!n) {
@@ -266,7 +259,7 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 			e = rb_entry(n, struct e_node, start.node);
 			n = rb_next(n);
 			if (e->start.key + e->count.key == bit) {
-				/* Remove left */
+				/* Remove left. */
 				bit = e->start.key;
 				len += e->count.key;
 				rb_erase(&e->start.node, &wnd->start_tree);
@@ -284,7 +277,7 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 			if (e->start.key > end_in)
 				break;

-			/* Remove right */
+			/* Remove right. */
 			n = rb_next(n);
 			len += next_end - end_in;
 			end_in = next_end;
@@ -299,7 +292,7 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 		}

 		if (wnd->uptodated != 1) {
-			/* Check bits before 'bit' */
+			/* Check bits before 'bit'. */
 			ib = wnd->zone_bit == wnd->zone_end ||
 					     bit < wnd->zone_end
 				     ? 0
@@ -310,7 +303,7 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 				len += 1;
 			}

-			/* Check bits after 'end_in' */
+			/* Check bits after 'end_in'. */
 			ib = wnd->zone_bit == wnd->zone_end ||
 					     end_in > wnd->zone_bit
 				     ? wnd->nbits
@@ -322,29 +315,29 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 			}
 		}
 	}
-	/* Insert new fragment */
+	/* Insert new fragment. */
 	if (wnd->count >= NTFS_MAX_WND_EXTENTS) {
 		if (e0)
 			kmem_cache_free(ntfs_enode_cachep, e0);

 		wnd->uptodated = -1;

-		/* Compare with smallest fragment */
+		/* Compare with smallest fragment. */
 		n = rb_last(&wnd->count_tree);
 		e = rb_entry(n, struct e_node, count.node);
 		if (len <= e->count.key)
-			goto out; /* Do not insert small fragments */
+			goto out; /* Do not insert small fragments. */

 		if (build) {
 			struct e_node *e2;

 			n = rb_prev(n);
 			e2 = rb_entry(n, struct e_node, count.node);
-			/* smallest fragment will be 'e2->count.key' */
+			/* Smallest fragment will be 'e2->count.key'. */
 			wnd->extent_min = e2->count.key;
 		}

-		/* Replace smallest fragment by new one */
+		/* Replace smallest fragment by new one. */
 		rb_erase(&e->start.node, &wnd->start_tree);
 		rb_erase(&e->count.node, &wnd->count_tree);
 		wnd->count -= 1;
@@ -371,9 +364,7 @@ out:;
 }

 /*
- * wnd_remove_free_ext
- *
- * removes a run from the cached free space
+ * wnd_remove_free_ext - Remove a run from the cached free space.
  */
 static void wnd_remove_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len)
 {
@@ -382,7 +373,7 @@ static void wnd_remove_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len)
 	size_t end_in = bit + len;
 	size_t end3, end, new_key, new_len, max_new_len;

-	/* Try to find extent before 'bit' */
+	/* Try to find extent before 'bit'. */
 	n = rb_lookup(&wnd->start_tree, bit);

 	if (!n)
@@ -394,11 +385,11 @@ static void wnd_remove_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len)
 	new_key = new_len = 0;
 	len = e->count.key;

-	/* Range [bit,end_in) must be inside 'e' or outside 'e' and 'n' */
+	/* Range [bit,end_in) must be inside 'e' or outside 'e' and 'n'. */
 	if (e->start.key > bit)
 		;
 	else if (end_in <= end) {
-		/* Range [bit,end_in) inside 'e' */
+		/* Range [bit,end_in) inside 'e'. */
 		new_key = end_in;
 		new_len = end - end_in;
 		len = bit - e->start.key;
@@ -478,13 +469,13 @@ static void wnd_remove_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len)
 	if (wnd->count >= NTFS_MAX_WND_EXTENTS) {
 		wnd->uptodated = -1;

-		/* Get minimal extent */
+		/* Get minimal extent. */
 		e = rb_entry(rb_last(&wnd->count_tree), struct e_node,
 			     count.node);
 		if (e->count.key > new_len)
 			goto out;

-		/* Replace minimum */
+		/* Replace minimum. */
 		rb_erase(&e->start.node, &wnd->start_tree);
 		rb_erase(&e->count.node, &wnd->count_tree);
 		wnd->count -= 1;
@@ -508,9 +499,7 @@ static void wnd_remove_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len)
 }

 /*
- * wnd_rescan
- *
- * Scan all bitmap. used while initialization.
+ * wnd_rescan - Scan all bitmap. Used while initialization.
  */
 static int wnd_rescan(struct wnd_bitmap *wnd)
 {
@@ -541,7 +530,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)

 		if (wnd->inited) {
 			if (!wnd->free_bits[iw]) {
-				/* all ones */
+				/* All ones. */
 				if (prev_tail) {
 					wnd_add_free_ext(wnd,
 							 vbo * 8 - prev_tail,
@@ -551,7 +540,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 				goto next_wnd;
 			}
 			if (wbits == wnd->free_bits[iw]) {
-				/* all zeroes */
+				/* All zeroes. */
 				prev_tail += wbits;
 				wnd->total_zeroes += wbits;
 				goto next_wnd;
@@ -604,14 +593,14 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 			wpos = used;

 			if (wpos >= wbits) {
-				/* No free blocks */
+				/* No free blocks. */
 				prev_tail = 0;
 				break;
 			}

 			frb = find_next_bit(buf, wbits, wpos);
 			if (frb >= wbits) {
-				/* keep last free block */
+				/* Keep last free block. */
 				prev_tail += frb - wpos;
 				break;
 			}
@@ -619,9 +608,9 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 			wnd_add_free_ext(wnd, wbit + wpos - prev_tail,
 					 frb + prev_tail - wpos, true);

-			/* Skip free block and first '1' */
+			/* Skip free block and first '1'. */
 			wpos = frb + 1;
-			/* Reset previous tail */
+			/* Reset previous tail. */
 			prev_tail = 0;
 		} while (wpos < wbits);

@@ -638,15 +627,15 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 		}
 	}

-	/* Add last block */
+	/* Add last block. */
 	if (prev_tail)
 		wnd_add_free_ext(wnd, wnd->nbits - prev_tail, prev_tail, true);

 	/*
-	 * Before init cycle wnd->uptodated was 0
+	 * Before init cycle wnd->uptodated was 0.
 	 * If any errors or limits occurs while initialization then
-	 * wnd->uptodated will be -1
-	 * If 'uptodated' is still 0 then Tree is really updated
+	 * wnd->uptodated will be -1.
+	 * If 'uptodated' is still 0 then Tree is really updated.
 	 */
 	if (!wnd->uptodated)
 		wnd->uptodated = 1;
@@ -662,9 +651,6 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
 	return err;
 }

-/*
- * wnd_init
- */
 int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 {
 	int err;
@@ -697,9 +683,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 }

 /*
- * wnd_map
- *
- * call sb_bread for requested window
+ * wnd_map - Call sb_bread for requested window.
  */
 static struct buffer_head *wnd_map(struct wnd_bitmap *wnd, size_t iw)
 {
@@ -728,9 +712,7 @@ static struct buffer_head *wnd_map(struct wnd_bitmap *wnd, size_t iw)
 }

 /*
- * wnd_set_free
- *
- * Marks the bits range from bit to bit + bits as free
+ * wnd_set_free - Mark the bits range from bit to bit + bits as free.
  */
 int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
@@ -783,9 +765,7 @@ int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 }

 /*
- * wnd_set_used
- *
- * Marks the bits range from bit to bit + bits as used
+ * wnd_set_used - Mark the bits range from bit to bit + bits as used.
  */
 int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
@@ -839,7 +819,7 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 /*
  * wnd_is_free_hlp
  *
- * Returns true if all clusters [bit, bit+bits) are free (bitmap only)
+ * Return: True if all clusters [bit, bit+bits) are free (bitmap only).
  */
 static bool wnd_is_free_hlp(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
@@ -882,7 +862,7 @@ static bool wnd_is_free_hlp(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 /*
  * wnd_is_free
  *
- * Returns true if all clusters [bit, bit+bits) are free
+ * Return: True if all clusters [bit, bit+bits) are free.
  */
 bool wnd_is_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
@@ -914,7 +894,7 @@ bool wnd_is_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 /*
  * wnd_is_used
  *
- * Returns true if all clusters [bit, bit+bits) are used
+ * Return: True if all clusters [bit, bit+bits) are used.
  */
 bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
@@ -973,11 +953,11 @@ bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 }

 /*
- * wnd_find
- * - flags - BITMAP_FIND_XXX flags
+ * wnd_find - Look for free space.
  *
- * looks for free space
- * Returns 0 if not found
+ * - flags - BITMAP_FIND_XXX flags
+ *
+ * Return: 0 if not found.
  */
 size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 		size_t flags, size_t *allocated)
@@ -994,7 +974,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	bool fbits_valid;
 	struct buffer_head *bh;

-	/* fast checking for available free space */
+	/* Fast checking for available free space. */
 	if (flags & BITMAP_FIND_FULL) {
 		size_t zeroes = wnd_zeroes(wnd);

@@ -1020,7 +1000,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,

 	if (RB_EMPTY_ROOT(&wnd->start_tree)) {
 		if (wnd->uptodated == 1) {
-			/* extents tree is updated -> no free space */
+			/* Extents tree is updated -> No free space. */
 			goto no_space;
 		}
 		goto scan_bitmap;
@@ -1030,7 +1010,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	if (!hint)
 		goto allocate_biggest;

-	/* Use hint: enumerate extents by start >= hint */
+	/* Use hint: Enumerate extents by start >= hint. */
 	pr = NULL;
 	cr = wnd->start_tree.rb_node;

@@ -1059,7 +1039,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 		goto allocate_biggest;

 	if (e->start.key + e->count.key > hint) {
-		/* We have found extension with 'hint' inside */
+		/* We have found extension with 'hint' inside. */
 		size_t len = e->start.key + e->count.key - hint;

 		if (len >= to_alloc && hint + to_alloc <= max_alloc) {
@@ -1080,7 +1060,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	}

 allocate_biggest:
-	/* Allocate from biggest free extent */
+	/* Allocate from biggest free extent. */
 	e = rb_entry(rb_first(&wnd->count_tree), struct e_node, count.node);
 	if (e->count.key != wnd->extent_max)
 		wnd->extent_max = e->count.key;
@@ -1090,14 +1070,14 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 			;
 		} else if (flags & BITMAP_FIND_FULL) {
 			if (e->count.key < to_alloc0) {
-				/* Biggest free block is less then requested */
+				/* Biggest free block is less then requested. */
 				goto no_space;
 			}
 			to_alloc = e->count.key;
 		} else if (-1 != wnd->uptodated) {
 			to_alloc = e->count.key;
 		} else {
-			/* Check if we can use more bits */
+			/* Check if we can use more bits. */
 			size_t op, max_check;
 			struct rb_root start_tree;

@@ -1118,7 +1098,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 			to_alloc = op - e->start.key;
 		}

-		/* Prepare to return */
+		/* Prepare to return. */
 		fnd = e->start.key;
 		if (e->start.key + to_alloc > max_alloc)
 			to_alloc = max_alloc - e->start.key;
@@ -1126,7 +1106,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	}

 	if (wnd->uptodated == 1) {
-		/* extents tree is updated -> no free space */
+		/* Extents tree is updated -> no free space. */
 		goto no_space;
 	}

@@ -1140,7 +1120,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	/* At most two ranges [hint, max_alloc) + [0, hint) */
 Again:

-	/* TODO: optimize request for case nbits > wbits */
+	/* TODO: Optimize request for case nbits > wbits. */
 	iw = hint >> log2_bits;
 	wbits = sb->s_blocksize * 8;
 	wpos = hint & (wbits - 1);
@@ -1155,7 +1135,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 		nwnd = likely(t > max_alloc) ? (t >> log2_bits) : wnd->nwnd;
 	}

-	/* Enumerate all windows */
+	/* Enumerate all windows. */
 	for (; iw < nwnd; iw++) {
 		wbit = iw << log2_bits;

@@ -1165,7 +1145,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 				b_len = prev_tail;
 			}

-			/* Skip full used window */
+			/* Skip full used window. */
 			prev_tail = 0;
 			wpos = 0;
 			continue;
@@ -1189,25 +1169,25 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 			zbit = max(wnd->zone_bit, wbit);
 			zend = min(wnd->zone_end, ebit);

-			/* Here we have a window [wbit, ebit) and zone [zbit, zend) */
+			/* Here we have a window [wbit, ebit) and zone [zbit, zend). */
 			if (zend <= zbit) {
-				/* Zone does not overlap window */
+				/* Zone does not overlap window. */
 			} else {
 				wzbit = zbit - wbit;
 				wzend = zend - wbit;

-				/* Zone overlaps window */
+				/* Zone overlaps window. */
 				if (wnd->free_bits[iw] == wzend - wzbit) {
 					prev_tail = 0;
 					wpos = 0;
 					continue;
 				}

-				/* Scan two ranges window: [wbit, zbit) and [zend, ebit) */
+				/* Scan two ranges window: [wbit, zbit) and [zend, ebit). */
 				bh = wnd_map(wnd, iw);

 				if (IS_ERR(bh)) {
-					/* TODO: error */
+					/* TODO: Error */
 					prev_tail = 0;
 					wpos = 0;
 					continue;
@@ -1215,9 +1195,9 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,

 				buf = (ulong *)bh->b_data;

-				/* Scan range [wbit, zbit) */
+				/* Scan range [wbit, zbit). */
 				if (wpos < wzbit) {
-					/* Scan range [wpos, zbit) */
+					/* Scan range [wpos, zbit). */
 					fnd = wnd_scan(buf, wbit, wpos, wzbit,
 						       to_alloc, &prev_tail,
 						       &b_pos, &b_len);
@@ -1229,7 +1209,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,

 				prev_tail = 0;

-				/* Scan range [zend, ebit) */
+				/* Scan range [zend, ebit). */
 				if (wzend < wbits) {
 					fnd = wnd_scan(buf, wbit,
 						       max(wzend, wpos), wbits,
@@ -1247,24 +1227,24 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 			}
 		}

-		/* Current window does not overlap zone */
+		/* Current window does not overlap zone. */
 		if (!wpos && fbits_valid && wnd->free_bits[iw] == wbits) {
-			/* window is empty */
+			/* Window is empty. */
 			if (prev_tail + wbits >= to_alloc) {
 				fnd = wbit + wpos - prev_tail;
 				goto found;
 			}

-			/* Increase 'prev_tail' and process next window */
+			/* Increase 'prev_tail' and process next window. */
 			prev_tail += wbits;
 			wpos = 0;
 			continue;
 		}

-		/* read window */
+		/* Read window */
 		bh = wnd_map(wnd, iw);
 		if (IS_ERR(bh)) {
-			// TODO: error
+			// TODO: Error.
 			prev_tail = 0;
 			wpos = 0;
 			continue;
@@ -1272,7 +1252,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,

 		buf = (ulong *)bh->b_data;

-		/* Scan range [wpos, eBits) */
+		/* Scan range [wpos, eBits). */
 		fnd = wnd_scan(buf, wbit, wpos, wbits, to_alloc, &prev_tail,
 			       &b_pos, &b_len);
 		put_bh(bh);
@@ -1281,15 +1261,15 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	}

 	if (b_len < prev_tail) {
-		/* The last fragment */
+		/* The last fragment. */
 		b_len = prev_tail;
 		b_pos = max_alloc - prev_tail;
 	}

 	if (hint) {
 		/*
-		 * We have scanned range [hint max_alloc)
-		 * Prepare to scan range [0 hint + to_alloc)
+		 * We have scanned range [hint max_alloc).
+		 * Prepare to scan range [0 hint + to_alloc).
 		 */
 		size_t nextmax = hint + to_alloc;

@@ -1312,7 +1292,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,

 found:
 	if (flags & BITMAP_FIND_MARK_AS_USED) {
-		/* TODO optimize remove extent (pass 'e'?) */
+		/* TODO: Optimize remove extent (pass 'e'?). */
 		if (wnd_set_used(wnd, fnd, to_alloc))
 			goto no_space;
 	} else if (wnd->extent_max != MINUS_ONE_T &&
@@ -1328,9 +1308,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 }

 /*
- * wnd_extend
- *
- * Extend bitmap ($MFT bitmap)
+ * wnd_extend - Extend bitmap ($MFT bitmap).
  */
 int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 {
@@ -1347,7 +1325,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 	if (new_bits <= old_bits)
 		return -EINVAL;

-	/* align to 8 byte boundary */
+	/* Align to 8 byte boundary. */
 	new_wnd = bytes_to_block(sb, bitmap_size(new_bits));
 	new_last = new_bits & (wbits - 1);
 	if (!new_last)
@@ -1367,7 +1345,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		wnd->free_bits = new_free;
 	}

-	/* Zero bits [old_bits,new_bits) */
+	/* Zero bits [old_bits,new_bits). */
 	bits = new_bits - old_bits;
 	b0 = old_bits & (wbits - 1);

@@ -1403,7 +1381,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
-		/*err = sync_dirty_buffer(bh);*/
+		/* err = sync_dirty_buffer(bh); */

 		b0 = 0;
 		bits -= op;
@@ -1418,9 +1396,6 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 	return 0;
 }

-/*
- * wnd_zone_set
- */
 void wnd_zone_set(struct wnd_bitmap *wnd, size_t lcn, size_t len)
 {
 	size_t zlen;
@@ -1502,7 +1477,7 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
 		put_bh(bh);
 	}

-	/* Process the last fragment */
+	/* Process the last fragment. */
 	if (len >= minlen) {
 		err = ntfs_discard(sbi, lcn, len);
 		if (err)
diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index dfaa4c79dc6d..93ed80f902b3 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
- * useful functions for debuging
+ *  Useful functions for debuging.
+ *
  */

 // clang-format off
@@ -41,7 +42,7 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 #endif

 /*
- * Logging macros ( thanks Joe Perches <joe@perches.com> for implementation )
+ * Logging macros. Thanks Joe Perches <joe@perches.com> for implementation.
  */

 #define ntfs_err(sb, fmt, ...)  ntfs_printk(sb, KERN_ERR fmt, ##__VA_ARGS__)
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 9ec6012c405b..adde2bb0deb4 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -3,9 +3,10 @@
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
- *  directory handling functions for ntfs-based filesystems
+ *  Directory handling functions for NTFS-based filesystems.
  *
  */
+
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
@@ -16,9 +17,7 @@
 #include "ntfs.h"
 #include "ntfs_fs.h"

-/*
- * Convert little endian utf16 to nls string
- */
+/* Convert little endian UTF-16 to NLS string. */
 int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 		      u8 *buf, int buf_len)
 {
@@ -30,7 +29,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 	static_assert(sizeof(wchar_t) == sizeof(__le16));

 	if (!nls) {
-		/* utf16 -> utf8 */
+		/* UTF-16 -> UTF-8 */
 		ret = utf16s_to_utf8s((wchar_t *)uni->name, uni->len,
 				      UTF16_LITTLE_ENDIAN, buf, buf_len);
 		buf[ret] = '\0';
@@ -89,8 +88,9 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 // clang-format on

 /*
- * modified version of put_utf16 from fs/nls/nls_base.c
- * is sparse warnings free
+ * put_utf16 - Modified version of put_utf16 from fs/nls/nls_base.c
+ *
+ * Function is sparse warnings free.
  */
 static inline void put_utf16(wchar_t *s, unsigned int c,
 			     enum utf16_endian endian)
@@ -112,8 +112,10 @@ static inline void put_utf16(wchar_t *s, unsigned int c,
 }

 /*
- * modified version of 'utf8s_to_utf16s' allows to
- * detect -ENAMETOOLONG without writing out of expected maximum
+ * _utf8s_to_utf16s
+ *
+ * Modified version of 'utf8s_to_utf16s' allows to
+ * detect -ENAMETOOLONG without writing out of expected maximum.
  */
 static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
 			    wchar_t *pwcs, int maxout)
@@ -165,17 +167,18 @@ static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
 }

 /*
- * Convert input string to utf16
- *
- * name, name_len - input name
- * uni, max_ulen - destination memory
- * endian - endian of target utf16 string
+ * ntfs_nls_to_utf16 - Convert input string to UTF-16.
+ * @name:	Input name.
+ * @name_len:	Input name length.
+ * @uni:	Destination memory.
+ * @max_ulen:	Destination memory.
+ * @endian:	Endian of target UTF-16 string.
  *
  * This function is called:
- * - to create ntfs name
+ * - to create NTFS name
  * - to create symlink
  *
- * returns utf16 string length or error (if negative)
+ * Return: UTF-16 string length or error (if negative).
  */
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 		      struct cpu_str *uni, u32 max_ulen,
@@ -230,7 +233,9 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 	return ret;
 }

-/* helper function */
+/*
+ * dir_search_u - Helper function.
+ */
 struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 			   struct ntfs_fnd *fnd)
 {
@@ -295,7 +300,7 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	if (ino == MFT_REC_ROOT)
 		return 0;

-	/* Skip meta files ( unless option to show metafiles is set ) */
+	/* Skip meta files. Unless option to show metafiles is set. */
 	if (!sbi->options.showmeta && ntfs_is_meta_file(sbi, ino))
 		return 0;

@@ -316,9 +321,7 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 }

 /*
- * ntfs_read_hdr
- *
- * helper function 'ntfs_readdir'
+ * ntfs_read_hdr - Helper function for ntfs_readdir().
  */
 static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			 const struct INDEX_HDR *hdr, u64 vbo, u64 pos,
@@ -342,7 +345,7 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		if (de_is_last(e))
 			return 0;

-		/* Skip already enumerated*/
+		/* Skip already enumerated. */
 		if (vbo + off < pos)
 			continue;

@@ -359,11 +362,11 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 }

 /*
- * file_operations::iterate_shared
+ * ntfs_readdir - file_operations::iterate_shared
  *
  * Use non sorted enumeration.
  * We have an example of broken volume where sorted enumeration
- * counts each name twice
+ * counts each name twice.
  */
 static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 {
@@ -382,7 +385,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	struct indx_node *node = NULL;
 	u8 index_bits = ni->dir.index_bits;

-	/* name is a buffer of PATH_MAX length */
+	/* Name is a buffer of PATH_MAX length. */
 	static_assert(NTFS_NAME_LEN * 4 < PATH_MAX);

 	eod = i_size + sbi->record_size;
@@ -393,16 +396,16 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;

-	/* allocate PATH_MAX bytes */
+	/* Allocate PATH_MAX bytes. */
 	name = __getname();
 	if (!name)
 		return -ENOMEM;

 	if (!ni->mi_loaded && ni->attr_list.size) {
 		/*
-		 * directory inode is locked for read
-		 * load all subrecords to avoid 'write' access to 'ni' during
-		 * directory reading
+		 * Directory inode is locked for read.
+		 * Load all subrecords to avoid 'write' access to 'ni' during
+		 * directory reading.
 		 */
 		ni_lock(ni);
 		if (!ni->mi_loaded && ni->attr_list.size) {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b4369c61a81b..7d29b50019f8 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -3,8 +3,10 @@
  *
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
- *  regular file handling primitives for ntfs-based filesystems
+ *  Regular file handling primitives for NTFS-based filesystems.
+ *
  */
+
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 #include <linux/compat.h>
@@ -62,7 +64,7 @@ static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 	case FITRIM:
 		return ntfs_ioctl_fitrim(sbi, arg);
 	}
-	return -ENOTTY; /* Inappropriate ioctl for device */
+	return -ENOTTY; /* Inappropriate ioctl for device. */
 }

 #ifdef CONFIG_COMPAT
@@ -74,7 +76,7 @@ static long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 #endif

 /*
- * inode_operations::getattr
+ * ntfs_getattr - inode_operations::getattr
  */
 int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags)
@@ -169,7 +171,7 @@ static int ntfs_extend_initialized_size(struct file *file,

 		zero_user_segment(page, zerofrom, PAGE_SIZE);

-		/* this function in any case puts page*/
+		/* This function in any case puts page. */
 		err = pagecache_write_end(file, mapping, pos, len, len, page,
 					  fsdata);
 		if (err < 0)
@@ -196,9 +198,7 @@ static int ntfs_extend_initialized_size(struct file *file,
 }

 /*
- * ntfs_sparse_cluster
- *
- * Helper function to zero a new allocated clusters
+ * ntfs_sparse_cluster - Helper function to zero a new allocated clusters.
  */
 void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
 			 CLST len)
@@ -237,7 +237,7 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
 				ntfs_inode_err(
 					inode,
 					"failed to allocate page buffers.");
-				/*err = -ENOMEM;*/
+				/* err = -ENOMEM; */
 				goto unlock_page;
 			}
 		}
@@ -279,7 +279,7 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
 }

 /*
- * file_operations::mmap
+ * ntfs_file_mmap - file_operations::mmap
  */
 static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
@@ -312,7 +312,7 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		   from + vma->vm_end - vma->vm_start);

 	if (is_sparsed(ni)) {
-		/* allocate clusters for rw map */
+		/* Allocate clusters for rw map. */
 		struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
 		CLST vcn, lcn, len;
 		CLST end = bytes_to_cluster(sbi, to);
@@ -354,7 +354,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	if (end <= inode->i_size && !extend_init)
 		return 0;

-	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	/* Mark rw ntfs as dirty. It will be cleared at umount. */
 	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);

 	if (end > inode->i_size) {
@@ -448,6 +448,8 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 }

 /*
+ * ntfs_fallocate
+ *
  * Preallocate space for a file. This implements ntfs's fallocate file
  * operation, which gets called from sys_fallocate system call. User
  * space requests 'len' bytes at 'vbo'. If FALLOC_FL_KEEP_SIZE is set
@@ -465,11 +467,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 	loff_t i_size;
 	int err;

-	/* No support for dir */
+	/* No support for dir. */
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;

-	/* Return error if mode is not supported */
+	/* Return error if mode is not supported. */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_COLLAPSE_RANGE))
 		return -EOPNOTSUPP;
@@ -480,7 +482,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 	i_size = inode->i_size;

 	if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
-		/* should never be here, see ntfs_file_open*/
+		/* Should never be here, see ntfs_file_open. */
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -531,7 +533,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)

 		/*
 		 * Write data that will be shifted to preserve them
-		 * when discarding page cache below
+		 * when discarding page cache below.
 		 */
 		err = filemap_write_and_wait_range(inode->i_mapping, end,
 						   LLONG_MAX);
@@ -545,7 +547,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_unlock(ni);
 	} else {
 		/*
-		 * normal file: allocate clusters, do not change 'valid' size
+		 * Normal file: Allocate clusters, do not change 'valid' size.
 		 */
 		err = ntfs_set_size(inode, max(end, i_size));
 		if (err)
@@ -559,10 +561,10 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			bool new;

 			/*
-			 * allocate but not zero new clusters (see below comments)
-			 * this breaks security (one can read unused on-disk areas)
-			 * zeroing these clusters may be too long
-			 * may be we should check here for root rights?
+			 * Allocate but do not zero new clusters. (see below comments)
+			 * This breaks security: One can read unused on-disk areas.
+			 * Zeroing these clusters may be too long.
+			 * Maybe we should check here for root rights?
 			 */
 			for (; vcn < cend; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend - vcn,
@@ -573,15 +575,15 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 					continue;

 				/*
-				 * Unwritten area
-				 * NTFS is not able to store several unwritten areas
-				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters
+				 * Unwritten area.
+				 * NTFS is not able to store several unwritten areas.
+				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters.
 				 *
 				 * Dangerous in case:
 				 * 1G of sparsed clusters + 1 cluster of data =>
 				 * valid_size == 1G + 1 cluster
 				 * fallocate(1G) will zero 1G and this can be very long
-				 * xfstest 016/086 will fail without 'ntfs_sparse_cluster'
+				 * xfstest 016/086 will fail without 'ntfs_sparse_cluster'.
 				 */
 				/*ntfs_sparse_cluster(inode, NULL, vcn,
 				 *		    min(vcn_v - vcn, clen));
@@ -591,7 +593,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)

 		if (mode & FALLOC_FL_KEEP_SIZE) {
 			ni_lock(ni);
-			/*true - keep preallocated*/
+			/* True - Keep preallocated. */
 			err = attr_set_size(ni, ATTR_DATA, NULL, 0,
 					    &ni->file.run, i_size, &ni->i_valid,
 					    true, NULL);
@@ -612,7 +614,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 }

 /*
- * inode_operations::setattr
+ * ntfs3_setattr - inode_operations::setattr
  */
 int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct iattr *attr)
@@ -626,9 +628,9 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	int err;

 	if (sbi->options.no_acs_rules) {
-		/* "no access rules" - force any changes of time etc. */
+		/* "No access rules" - Force any changes of time etc. */
 		attr->ia_valid |= ATTR_FORCE;
-		/* and disable for editing some attributes */
+		/* and disable for editing some attributes. */
 		attr->ia_valid &= ~(ATTR_UID | ATTR_GID | ATTR_MODE);
 		ia_valid = attr->ia_valid;
 	}
@@ -641,7 +643,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		loff_t oldsize = inode->i_size;

 		if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
-			/* should never be here, see ntfs_file_open*/
+			/* Should never be here, see ntfs_file_open(). */
 			err = -EOPNOTSUPP;
 			goto out;
 		}
@@ -665,7 +667,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (err)
 			goto out;

-		/* linux 'w' -> windows 'ro' */
+		/* Linux 'w' -> Windows 'ro'. */
 		if (0222 & inode->i_mode)
 			ni->std_fa &= ~FILE_ATTRIBUTE_READONLY;
 		else
@@ -714,7 +716,11 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return err;
 }

-/* returns array of locked pages */
+/*
+ * ntfs_get_frame_pages
+ *
+ * Return: Array of locked pages.
+ */
 static int ntfs_get_frame_pages(struct address_space *mapping, pgoff_t index,
 				struct page **pages, u32 pages_per_frame,
 				bool *frame_uptodate)
@@ -747,7 +753,9 @@ static int ntfs_get_frame_pages(struct address_space *mapping, pgoff_t index,
 	return 0;
 }

-/*helper for ntfs_file_write_iter (compressed files)*/
+/*
+ * ntfs_compress_write - Helper for ntfs_file_write_iter() (compressed files).
+ */
 static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int err;
@@ -793,7 +801,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;

-	/* zero range [valid : pos) */
+	/* Zero range [valid : pos). */
 	while (valid < pos) {
 		CLST lcn, clen;

@@ -812,7 +820,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 			continue;
 		}

-		/* Load full frame */
+		/* Load full frame. */
 		err = ntfs_get_frame_pages(mapping, frame_vbo >> PAGE_SHIFT,
 					   pages, pages_per_frame,
 					   &frame_uptodate);
@@ -858,7 +866,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		ni->i_valid = valid = frame_vbo + frame_size;
 	}

-	/* copy user data [pos : pos + count) */
+	/* Copy user data [pos : pos + count). */
 	while (count) {
 		size_t copied, bytes;

@@ -876,7 +884,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}

-		/* Load full frame */
+		/* Load full frame. */
 		err = ntfs_get_frame_pages(mapping, index, pages,
 					   pages_per_frame, &frame_uptodate);
 		if (err)
@@ -905,7 +913,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		ip = off >> PAGE_SHIFT;
 		off = offset_in_page(pos);

-		/* copy user data to pages */
+		/* Copy user data to pages. */
 		for (;;) {
 			size_t cp, tail = PAGE_SIZE - off;

@@ -971,7 +979,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 }

 /*
- * file_operations::write_iter
+ * ntfs_file_write_iter - file_operations::write_iter
  */
 static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -1007,7 +1015,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;

 	if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
-		/* should never be here, see ntfs_file_open*/
+		/* Should never be here, see ntfs_file_open() */
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -1029,7 +1037,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 }

 /*
- * file_operations::open
+ * ntfs_file_open - file_operations::open
  */
 int ntfs_file_open(struct inode *inode, struct file *file)
 {
@@ -1040,7 +1048,7 @@ int ntfs_file_open(struct inode *inode, struct file *file)
 		return -EOPNOTSUPP;
 	}

-	/* Decompress "external compressed" file if opened for rw */
+	/* Decompress "external compressed" file if opened for rw. */
 	if ((ni->ni_flags & NI_FLAG_COMPRESSED_MASK) &&
 	    (file->f_flags & (O_WRONLY | O_RDWR | O_TRUNC))) {
 #ifdef CONFIG_NTFS3_LZX_XPRESS
@@ -1060,7 +1068,7 @@ int ntfs_file_open(struct inode *inode, struct file *file)
 }

 /*
- * file_operations::release
+ * ntfs_file_release - file_operations::release
  */
 static int ntfs_file_release(struct inode *inode, struct file *file)
 {
@@ -1068,7 +1076,7 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	int err = 0;

-	/* if we are the last writer on the inode, drop the block reservation */
+	/* If we are last writer on the inode, drop the block reservation. */
 	if (sbi->options.prealloc && ((file->f_mode & FMODE_WRITE) &&
 				      atomic_read(&inode->i_writecount) == 1)) {
 		ni_lock(ni);
@@ -1083,7 +1091,9 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	return err;
 }

-/* file_operations::fiemap */
+/*
+ * ntfs_fiemap - file_operations::fiemap
+ */
 int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
 {
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 5fa737850673..0f268af9d343 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -47,9 +47,7 @@ static struct mft_inode *ni_ins_mi(struct ntfs_inode *ni, struct rb_root *tree,
 }

 /*
- * ni_find_mi
- *
- * finds mft_inode by record number
+ * ni_find_mi - Find mft_inode by record number.
  */
 static struct mft_inode *ni_find_mi(struct ntfs_inode *ni, CLST rno)
 {
@@ -57,29 +55,24 @@ static struct mft_inode *ni_find_mi(struct ntfs_inode *ni, CLST rno)
 }

 /*
- * ni_add_mi
- *
- * adds new mft_inode into ntfs_inode
- */
+ * ni_add_mi - Add new mft_inode into ntfs_inode.
+*/
 static void ni_add_mi(struct ntfs_inode *ni, struct mft_inode *mi)
 {
 	ni_ins_mi(ni, &ni->mi_tree, mi->rno, &mi->node);
 }

 /*
- * ni_remove_mi
- *
- * removes mft_inode from ntfs_inode
+ * ni_remove_mi - Remove mft_inode from ntfs_inode.
  */
 void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi)
 {
 	rb_erase(&mi->node, &ni->mi_tree);
 }

-/*
- * ni_std
+/* ni_std
  *
- * returns pointer into std_info from primary record
+ * Return: Pointer into std_info from primary record.
  */
 struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
 {
@@ -93,7 +86,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
 /*
  * ni_std5
  *
- * returns pointer into std_info from primary record
+ * Return: Pointer into std_info from primary record.
  */
 struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
@@ -106,9 +99,7 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 }

 /*
- * ni_clear
- *
- * clears resources allocated by ntfs_inode
+ * ni_clear - Clear resources allocated by ntfs_inode.
  */
 void ni_clear(struct ntfs_inode *ni)
 {
@@ -128,14 +119,14 @@ void ni_clear(struct ntfs_inode *ni)
 		node = next;
 	}

-	/* bad inode always has mode == S_IFREG */
+	/* Bad inode always has mode == S_IFREG. */
 	if (ni->ni_flags & NI_FLAG_DIR)
 		indx_clear(&ni->dir);
 	else {
 		run_close(&ni->file.run);
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 		if (ni->file.offs_page) {
-			/* on-demand allocated page for offsets */
+			/* On-demand allocated page for offsets. */
 			put_page(ni->file.offs_page);
 			ni->file.offs_page = NULL;
 		}
@@ -146,9 +137,7 @@ void ni_clear(struct ntfs_inode *ni)
 }

 /*
- * ni_load_mi_ex
- *
- * finds mft_inode by record number.
+ * ni_load_mi_ex - Find mft_inode by record number.
  */
 int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 {
@@ -172,9 +161,7 @@ int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 }

 /*
- * ni_load_mi
- *
- * load mft_inode corresponded list_entry
+ * ni_load_mi - Load mft_inode corresponded list_entry.
  */
 int ni_load_mi(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 	       struct mft_inode **mi)
@@ -197,7 +184,7 @@ int ni_load_mi(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 /*
  * ni_find_attr
  *
- * returns attribute and record this attribute belongs to
+ * Return: Attribute and record this attribute belongs to.
  */
 struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 			    struct ATTR_LIST_ENTRY **le_o, enum ATTR_TYPE type,
@@ -214,11 +201,11 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 		if (mi)
 			*mi = &ni->mi;

-		/* Look for required attribute in primary record */
+		/* Look for required attribute in primary record. */
 		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
 	}

-	/* first look for list entry of required type */
+	/* First look for list entry of required type. */
 	le = al_find_ex(ni, le_o ? *le_o : NULL, type, name, name_len, vcn);
 	if (!le)
 		return NULL;
@@ -226,11 +213,11 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 	if (le_o)
 		*le_o = le;

-	/* Load record that contains this attribute */
+	/* Load record that contains this attribute. */
 	if (ni_load_mi(ni, le, &m))
 		return NULL;

-	/* Look for required attribute */
+	/* Look for required attribute. */
 	attr = mi_find_attr(m, NULL, type, name, name_len, &le->id);

 	if (!attr)
@@ -257,9 +244,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 }

 /*
- * ni_enum_attr_ex
- *
- * enumerates attributes in ntfs_inode
+ * ni_enum_attr_ex - Enumerates attributes in ntfs_inode.
  */
 struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 			       struct ATTR_LIST_ENTRY **le,
@@ -273,30 +258,28 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		*le = NULL;
 		if (mi)
 			*mi = &ni->mi;
-		/* Enum attributes in primary record */
+		/* Enum attributes in primary record. */
 		return mi_enum_attr(&ni->mi, attr);
 	}

-	/* get next list entry */
+	/* Get next list entry. */
 	le2 = *le = al_enumerate(ni, attr ? *le : NULL);
 	if (!le2)
 		return NULL;

-	/* Load record that contains the required attribute */
+	/* Load record that contains the required attribute. */
 	if (ni_load_mi(ni, le2, &mi2))
 		return NULL;

 	if (mi)
 		*mi = mi2;

-	/* Find attribute in loaded record */
+	/* Find attribute in loaded record. */
 	return rec_find_attr_le(mi2, le2);
 }

 /*
- * ni_load_attr
- *
- * loads attribute that contains given vcn
+ * ni_load_attr - Load attribute that contains given VCN.
  */
 struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			    const __le16 *name, u8 name_len, CLST vcn,
@@ -318,9 +301,9 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		return NULL;

 	/*
-	 * Unfortunately ATTR_LIST_ENTRY contains only start vcn
+	 * Unfortunately ATTR_LIST_ENTRY contains only start VCN.
 	 * So to find the ATTRIB segment that contains 'vcn' we should
-	 * enumerate some entries
+	 * enumerate some entries.
 	 */
 	if (vcn) {
 		for (;; le = next) {
@@ -351,9 +334,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 }

 /*
- * ni_load_all_mi
- *
- * loads all subrecords
+ * ni_load_all_mi - Load all subrecords.
  */
 int ni_load_all_mi(struct ntfs_inode *ni)
 {
@@ -380,9 +361,7 @@ int ni_load_all_mi(struct ntfs_inode *ni)
 }

 /*
- * ni_add_subrecord
- *
- * allocate + format + attach a new subrecord
+ * ni_add_subrecord - Allocate + format + attach a new subrecord.
  */
 bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 {
@@ -405,10 +384,8 @@ bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 }

 /*
- * ni_remove_attr
- *
- * removes all attributes for the given type/name/id
- */
+ * ni_remove_attr - Remove all attributes for the given type/name/id.
+*/
 int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		   const __le16 *name, size_t name_len, bool base_only,
 		   const __le16 *id)
@@ -473,10 +450,9 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 }

 /*
- * ni_ins_new_attr
+ * ni_ins_new_attr - Insert the attribute into record.
  *
- * inserts the attribute into record
- * Returns not full constructed attribute or NULL if not possible to create
+ * Return: Not full constructed attribute or NULL if not possible to create.
  */
 static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
 				      struct mft_inode *mi,
@@ -496,7 +472,7 @@ static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
 		err = al_add_le(ni, type, name, name_len, svcn, cpu_to_le16(-1),
 				&ref, &le);
 		if (err) {
-			/* no memory or no space */
+			/* No memory or no space. */
 			return NULL;
 		}
 		le_added = true;
@@ -505,7 +481,7 @@ static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
 		 * al_add_le -> attr_set_size (list) -> ni_expand_list
 		 * which moves some attributes out of primary record
 		 * this means that name may point into moved memory
-		 * reinit 'name' from le
+		 * reinit 'name' from le.
 		 */
 		name = le->name;
 	}
@@ -518,14 +494,14 @@ static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
 	}

 	if (type == ATTR_LIST) {
-		/*attr list is not in list entry array*/
+		/* Attr list is not in list entry array. */
 		goto out;
 	}

 	if (!le)
 		goto out;

-	/* Update ATTRIB Id and record reference */
+	/* Update ATTRIB Id and record reference. */
 	le->id = attr->id;
 	ni->attr_list.dirty = true;
 	le->ref = ref;
@@ -535,9 +511,11 @@ static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
 }

 /*
- * random write access to sparsed or compressed file may result to
+ * ni_repack
+ *
+ * Random write access to sparsed or compressed file may result to
  * not optimized packed runs.
- * Here it is the place to optimize it
+ * Here is the place to optimize it.
  */
 static int ni_repack(struct ntfs_inode *ni)
 {
@@ -581,11 +559,11 @@ static int ni_repack(struct ntfs_inode *ni)
 		}

 		if (!mi_p) {
-			/* do not try if too little free space */
+			/* Do not try if not enogh free space. */
 			if (le32_to_cpu(mi->mrec->used) + 8 >= rs)
 				continue;

-			/* do not try if last attribute segment */
+			/* Do not try if last attribute segment. */
 			if (evcn + 1 == alloc)
 				continue;
 			run_close(&run);
@@ -609,8 +587,8 @@ static int ni_repack(struct ntfs_inode *ni)
 		}

 		/*
-		 * run contains data from two records: mi_p and mi
-		 * try to pack in one
+		 * Run contains data from two records: mi_p and mi
+		 * Try to pack in one.
 		 */
 		err = mi_pack_runs(mi_p, attr_p, &run, evcn + 1 - svcn_p);
 		if (err)
@@ -619,7 +597,7 @@ static int ni_repack(struct ntfs_inode *ni)
 		next_svcn = le64_to_cpu(attr_p->nres.evcn) + 1;

 		if (next_svcn >= evcn + 1) {
-			/* we can remove this attribute segment */
+			/* We can remove this attribute segment. */
 			al_remove_le(ni, le);
 			mi_remove_attr(mi, attr);
 			le = le_p;
@@ -650,7 +628,7 @@ static int ni_repack(struct ntfs_inode *ni)
 		ntfs_inode_warn(&ni->vfs_inode, "repack problem");
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);

-		/* Pack loaded but not packed runs */
+		/* Pack loaded but not packed runs. */
 		if (mi_p)
 			mi_pack_runs(mi_p, attr_p, &run, evcn_p + 1 - svcn_p);
 	}
@@ -663,7 +641,7 @@ static int ni_repack(struct ntfs_inode *ni)
  * ni_try_remove_attr_list
  *
  * Can we remove attribute list?
- * Check the case when primary record contains enough space for all attributes
+ * Check the case when primary record contains enough space for all attributes.
  */
 static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 {
@@ -689,7 +667,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)

 	asize = le32_to_cpu(attr_list->size);

-	/* free space in primary record without attribute list */
+	/* Free space in primary record without attribute list. */
 	free = sbi->record_size - le32_to_cpu(ni->mi.mrec->used) + asize;
 	mi_get_ref(&ni->mi, &ref);

@@ -717,7 +695,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		free -= asize;
 	}

-	/* Is seems that attribute list can be removed from primary record */
+	/* Is seems that attribute list can be removed from primary record. */
 	mi_remove_attr(&ni->mi, attr_list);

 	/*
@@ -735,17 +713,17 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 				    le->name_len, &le->id);
 		asize = le32_to_cpu(attr->size);

-		/* insert into primary record */
+		/* Insert into primary record. */
 		attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
 					  le->name_len, asize,
 					  le16_to_cpu(attr->name_off));
 		id = attr_ins->id;

-		/* copy all except id */
+		/* Copy all except id. */
 		memcpy(attr_ins, attr, asize);
 		attr_ins->id = id;

-		/* remove from original record */
+		/* Remove from original record. */
 		mi_remove_attr(mi, attr);
 	}

@@ -760,10 +738,8 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 }

 /*
- * ni_create_attr_list
- *
- * generates an attribute list for this primary record
- */
+ * ni_create_attr_list - Generates an attribute list for this primary record.
+*/
 int ni_create_attr_list(struct ntfs_inode *ni)
 {
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
@@ -784,8 +760,8 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	rs = sbi->record_size;

 	/*
-	 * Skip estimating exact memory requirement
-	 * Looks like one record_size is always enough
+	 * Skip estimating exact memory requirement.
+	 * Looks like one record_size is always enough.
 	 */
 	le = ntfs_malloc(al_aligned(rs));
 	if (!le) {
@@ -844,12 +820,12 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		}
 	}

-	/* Allocate child mft. */
+	/* Allocate child MFT. */
 	err = ntfs_look_free_mft(sbi, &rno, is_mft, ni, &mi);
 	if (err)
 		goto out1;

-	/* Call 'mi_remove_attr' in reverse order to keep pointers 'arr_move' valid */
+	/* Call mi_remove_attr() in reverse order to keep pointers 'arr_move' valid. */
 	while (to_free > 0) {
 		struct ATTRIB *b = arr_move[--nb];
 		u32 asize = le32_to_cpu(b->size);
@@ -862,7 +838,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		mi_get_ref(mi, &le_b[nb]->ref);
 		le_b[nb]->id = attr->id;

-		/* copy all except id */
+		/* Copy all except id. */
 		memcpy(attr, b, asize);
 		attr->id = le_b[nb]->id;

@@ -902,9 +878,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 }

 /*
- * ni_ins_attr_ext
- *
- * This method adds an external attribute to the ntfs_inode.
+ * ni_ins_attr_ext - Add an external attribute to the ntfs_inode.
  */
 static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 			   enum ATTR_TYPE type, const __le16 *name, u8 name_len,
@@ -929,8 +903,8 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 	}

 	/*
-	 * standard information and attr_list cannot be made external.
-	 * The Log File cannot have any external attributes
+	 * Standard information and attr_list cannot be made external.
+	 * The Log File cannot have any external attributes.
 	 */
 	if (type == ATTR_STD || type == ATTR_LIST ||
 	    ni->mi.rno == MFT_REC_LOG) {
@@ -938,7 +912,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		goto out;
 	}

-	/* Create attribute list if it is not already existed */
+	/* Create attribute list if it is not already existed. */
 	if (!ni->attr_list.size) {
 		err = ni_create_attr_list(ni);
 		if (err)
@@ -955,14 +929,14 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 	if (err)
 		goto out;

-	/* Check each of loaded subrecord */
+	/* Check each of loaded subrecord. */
 	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
 		mi = rb_entry(node, struct mft_inode, node);

 		if (is_mft_data &&
 		    (mi_enum_attr(mi, NULL) ||
 		     vbo <= ((u64)mi->rno << sbi->record_bits))) {
-			/* We can't accept this record 'case MFT's bootstrapping */
+			/* We can't accept this record 'case MFT's bootstrapping. */
 			continue;
 		}
 		if (is_mft &&
@@ -976,11 +950,11 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,

 		if ((type != ATTR_NAME || name_len) &&
 		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
-			/* Only indexed attributes can share same record */
+			/* Only indexed attributes can share same record. */
 			continue;
 		}

-		/* Try to insert attribute into this subrecord */
+		/* Try to insert attribute into this subrecord. */
 		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
 				       name_off, svcn);
 		if (!attr)
@@ -992,7 +966,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 	}

 insert_ext:
-	/* We have to allocate a new child subrecord*/
+	/* We have to allocate a new child subrecord. */
 	err = ntfs_look_free_mft(sbi, &rno, is_mft_data, ni, &mi);
 	if (err)
 		goto out;
@@ -1027,9 +1001,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 }

 /*
- * ni_insert_attr
- *
- * inserts an attribute into the file.
+ * ni_insert_attr - Insert an attribute into the file.
  *
  * If the primary record has room, it will just insert the attribute.
  * If not, it may make the attribute external.
@@ -1038,8 +1010,8 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
  *
  * NOTE:
  * The ATTR_LIST and ATTR_STD cannot be made external.
- * This function does not fill new attribute full
- * It only fills 'size'/'type'/'id'/'name_len' fields
+ * This function does not fill new attribute full.
+ * It only fills 'size'/'type'/'id'/'name_len' fields.
  */
 static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			  const __le16 *name, u8 name_len, u32 asize,
@@ -1064,7 +1036,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	free = sbi->record_size - used;

 	if (is_mft && type != ATTR_LIST) {
-		/* Reserve space for the ATTRIB List. */
+		/* Reserve space for the ATTRIB list. */
 		if (free < list_reserve)
 			free = 0;
 		else
@@ -1092,7 +1064,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	}

 	/*
-	 * Here we have: "is_mft && type == ATTR_DATA && !svcn
+	 * Here we have: "is_mft && type == ATTR_DATA && !svcn"
 	 *
 	 * The first chunk of the $MFT::Data ATTRIB must be the base record.
 	 * Evict as many other attributes as possible.
@@ -1111,7 +1083,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	}

 	if (max_free < asize + list_reserve) {
-		/* Impossible to insert this attribute into primary record */
+		/* Impossible to insert this attribute into primary record. */
 		err = -EINVAL;
 		goto out;
 	}
@@ -1122,12 +1094,12 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	for (;;) {
 		attr = mi_enum_attr(&ni->mi, attr);
 		if (!attr) {
-			/* We should never be here 'cause we have already check this case */
+			/* We should never be here 'cause we have already check this case. */
 			err = -EINVAL;
 			goto out;
 		}

-		/* Skip attributes that MUST be primary record */
+		/* Skip attributes that MUST be primary record. */
 		if (attr->type == ATTR_STD || attr->type == ATTR_LIST)
 			continue;

@@ -1135,7 +1107,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		if (ni->attr_list.size) {
 			le = al_find_le(ni, NULL, attr);
 			if (!le) {
-				/* Really this is a serious bug */
+				/* Really this is a serious bug. */
 				err = -EINVAL;
 				goto out;
 			}
@@ -1153,10 +1125,10 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		memcpy(eattr, attr, t32);
 		eattr->id = id;

-		/* remove attrib from primary record */
+		/* Remove attrib from primary record. */
 		mi_remove_attr(&ni->mi, attr);

-		/* attr now points to next attribute */
+		/* attr now points to next attribute. */
 		if (attr->type == ATTR_END)
 			goto out;
 	}
@@ -1179,11 +1151,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	return err;
 }

-/*
- * ni_expand_mft_list
- *
- * This method splits ATTR_DATA of $MFT
- */
+/* ni_expand_mft_list - Split ATTR_DATA of $MFT. */
 static int ni_expand_mft_list(struct ntfs_inode *ni)
 {
 	int err = 0;
@@ -1195,7 +1163,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	struct mft_inode *mi, *mi_min, *mi_new;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;

-	/* Find the nearest Mft */
+	/* Find the nearest MFT. */
 	mft_min = 0;
 	mft_new = 0;
 	mi_min = NULL;
@@ -1214,7 +1182,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)

 	if (ntfs_look_free_mft(sbi, &mft_new, true, ni, &mi_new)) {
 		mft_new = 0;
-		// really this is not critical
+		/* Really this is not critical. */
 	} else if (mft_min > mft_new) {
 		mft_min = mft_new;
 		mi_min = mi_new;
@@ -1240,9 +1208,9 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	}

 	/*
-	 * split primary attribute [0 evcn] in two parts [0 svcn) + [svcn evcn]
+	 * Split primary attribute [0 evcn] in two parts [0 svcn) + [svcn evcn].
 	 *
-	 * Update first part of ATTR_DATA in 'primary MFT
+	 * Update first part of ATTR_DATA in 'primary MFT.
 	 */
 	err = run_pack(run, 0, svcn, Add2Ptr(attr, SIZEOF_NONRESIDENT),
 		       asize - SIZEOF_NONRESIDENT, &plen);
@@ -1259,11 +1227,11 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)

 	attr->nres.evcn = cpu_to_le64(svcn - 1);
 	attr->size = cpu_to_le32(run_size + SIZEOF_NONRESIDENT);
-	/* 'done' - how many bytes of primary MFT becomes free */
+	/* 'done' - How many bytes of primary MFT becomes free. */
 	done = asize - run_size - SIZEOF_NONRESIDENT;
 	le32_sub_cpu(&ni->mi.mrec->used, done);

-	/* Estimate the size of second part: run_buf=NULL */
+	/* Estimate the size of second part: run_buf=NULL. */
 	err = run_pack(run, svcn, evcn + 1 - svcn, NULL, sbi->record_size,
 		       &plen);
 	if (err < 0)
@@ -1278,8 +1246,8 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	}

 	/*
-	 * This function may implicitly call expand attr_list
-	 * Insert second part of ATTR_DATA in 'mi_min'
+	 * This function may implicitly call expand attr_list.
+	 * Insert second part of ATTR_DATA in 'mi_min'.
 	 */
 	attr = ni_ins_new_attr(ni, mi_min, NULL, ATTR_DATA, NULL, 0,
 			       SIZEOF_NONRESIDENT + run_size,
@@ -1310,9 +1278,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 }

 /*
- * ni_expand_list
- *
- * This method moves all possible attributes out of primary record
+ * ni_expand_list - Move all possible attributes out of primary record.
  */
 int ni_expand_list(struct ntfs_inode *ni)
 {
@@ -1336,7 +1302,7 @@ int ni_expand_list(struct ntfs_inode *ni)
 		if (is_mft && le->type == ATTR_DATA)
 			continue;

-		/* Find attribute in primary record */
+		/* Find attribute in primary record. */
 		attr = rec_find_attr_le(&ni->mi, le);
 		if (!attr) {
 			err = -EINVAL;
@@ -1345,7 +1311,7 @@ int ni_expand_list(struct ntfs_inode *ni)

 		asize = le32_to_cpu(attr->size);

-		/* Always insert into new record to avoid collisions (deep recursive) */
+		/* Always insert into new record to avoid collisions (deep recursive). */
 		err = ni_ins_attr_ext(ni, le, attr->type, attr_name(attr),
 				      attr->name_len, asize, attr_svcn(attr),
 				      le16_to_cpu(attr->name_off), true,
@@ -1363,11 +1329,11 @@ int ni_expand_list(struct ntfs_inode *ni)
 	}

 	if (!is_mft) {
-		err = -EFBIG; /* attr list is too big(?) */
+		err = -EFBIG; /* Attr list is too big(?) */
 		goto out;
 	}

-	/* split mft data as much as possible */
+	/* Split MFT data as much as possible. */
 	err = ni_expand_mft_list(ni);
 	if (err)
 		goto out;
@@ -1377,9 +1343,7 @@ int ni_expand_list(struct ntfs_inode *ni)
 }

 /*
- * ni_insert_nonresident
- *
- * inserts new nonresident attribute
+ * ni_insert_nonresident - Insert new nonresident attribute.
  */
 int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			  const __le16 *name, u8 name_len,
@@ -1454,9 +1418,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 }

 /*
- * ni_insert_resident
- *
- * inserts new resident attribute
+ * ni_insert_resident - Inserts new resident attribute.
  */
 int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
 		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
@@ -1488,9 +1450,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
 }

 /*
- * ni_remove_attr_le
- *
- * removes attribute from record
+ * ni_remove_attr_le - Remove attribute from record.
  */
 int ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
 		      struct ATTR_LIST_ENTRY *le)
@@ -1511,10 +1471,9 @@ int ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
 }

 /*
- * ni_delete_all
+ * ni_delete_all - Remove all attributes and frees allocates space.
  *
- * removes all attributes and frees allocates space
- * ntfs_evict_inode->ntfs_clear_inode->ni_delete_all (if no links)
+ * ntfs_evict_inode->ntfs_clear_inode->ni_delete_all (if no links).
  */
 int ni_delete_all(struct ntfs_inode *ni)
 {
@@ -1553,7 +1512,7 @@ int ni_delete_all(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 		roff = le16_to_cpu(attr->nres.run_off);

-		/*run==1 means unpack and deallocate*/
+		/* run==1 means unpack and deallocate. */
 		run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn, evcn, svcn,
 			      Add2Ptr(attr, roff), asize - roff);
 	}
@@ -1563,7 +1522,7 @@ int ni_delete_all(struct ntfs_inode *ni)
 		al_destroy(ni);
 	}

-	/* Free all subrecords */
+	/* Free all subrecords. */
 	for (node = rb_first(&ni->mi_tree); node;) {
 		struct rb_node *next = rb_next(node);
 		struct mft_inode *mi = rb_entry(node, struct mft_inode, node);
@@ -1578,7 +1537,7 @@ int ni_delete_all(struct ntfs_inode *ni)
 		node = next;
 	}

-	// Free base record
+	/* Free base record */
 	clear_rec_inuse(ni->mi.mrec);
 	ni->mi.dirty = true;
 	err = mi_write(&ni->mi, 0);
@@ -1588,11 +1547,9 @@ int ni_delete_all(struct ntfs_inode *ni)
 	return err;
 }

-/*
- * ni_fname_name
+/* ni_fname_name
  *
- * returns file name attribute by its value
- */
+ *Return: File name attribute by its value. */
 struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
 				     const struct cpu_str *uni,
 				     const struct MFT_REF *home_dir,
@@ -1603,7 +1560,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,

 	*le = NULL;

-	/* Enumerate all names */
+	/* Enumerate all names. */
 next:
 	attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, NULL);
 	if (!attr)
@@ -1632,7 +1589,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
 /*
  * ni_fname_type
  *
- * returns file name attribute with given type
+ * Return: File name attribute with given type.
  */
 struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
 				     struct ATTR_LIST_ENTRY **le)
@@ -1642,7 +1599,7 @@ struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,

 	*le = NULL;

-	/* Enumerate all names */
+	/* Enumerate all names. */
 	for (;;) {
 		attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL,
 				    NULL);
@@ -1656,9 +1613,11 @@ struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
 }

 /*
- * Process compressed/sparsed in special way
- * NOTE: you need to set ni->std_fa = new_fa
- * after this function to keep internal structures in consistency
+ * ni_new_attr_flags
+ *
+ * Process compressed/sparsed in special way.
+ * NOTE: You need to set ni->std_fa = new_fa
+ * after this function to keep internal structures in consistency.
  */
 int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa)
 {
@@ -1703,7 +1662,7 @@ int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa)
 		return -EOPNOTSUPP;
 	}

-	/* resize nonresident empty attribute in-place only*/
+	/* Resize nonresident empty attribute in-place only. */
 	new_asize = (new_aflags & (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED))
 			    ? (SIZEOF_NONRESIDENT_EX + 8)
 			    : (SIZEOF_NONRESIDENT + 8);
@@ -1713,17 +1672,17 @@ int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa)

 	if (new_aflags & ATTR_FLAG_SPARSED) {
 		attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
-		/* windows uses 16 clusters per frame but supports one cluster per frame too*/
+		/* Windows uses 16 clusters per frame but supports one cluster per frame too. */
 		attr->nres.c_unit = 0;
 		ni->vfs_inode.i_mapping->a_ops = &ntfs_aops;
 	} else if (new_aflags & ATTR_FLAG_COMPRESSED) {
 		attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
-		/* the only allowed: 16 clusters per frame */
+		/* The only allowed: 16 clusters per frame. */
 		attr->nres.c_unit = NTFS_LZNT_CUNIT;
 		ni->vfs_inode.i_mapping->a_ops = &ntfs_aops_cmpr;
 	} else {
 		attr->name_off = SIZEOF_NONRESIDENT_LE;
-		/* normal files */
+		/* Normal files. */
 		attr->nres.c_unit = 0;
 		ni->vfs_inode.i_mapping->a_ops = &ntfs_aops;
 	}
@@ -1738,7 +1697,7 @@ int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa)
 /*
  * ni_parse_reparse
  *
- * buffer is at least 24 bytes
+ * Buffer is at least 24 bytes.
  */
 enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 				   void *buffer)
@@ -1750,7 +1709,7 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,

 	static_assert(sizeof(struct REPARSE_DATA_BUFFER) <= 24);

-	/* Try to estimate reparse point */
+	/* Try to estimate reparse point. */
 	if (!attr->non_res) {
 		rp = resident_data_ex(attr, sizeof(struct REPARSE_DATA_BUFFER));
 	} else if (le64_to_cpu(attr->nres.data_size) >=
@@ -1775,21 +1734,21 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	len = le16_to_cpu(rp->ReparseDataLength);
 	switch (rp->ReparseTag) {
 	case (IO_REPARSE_TAG_MICROSOFT | IO_REPARSE_TAG_SYMBOLIC_LINK):
-		break; /* Symbolic link */
+		break; /* Symbolic link. */
 	case IO_REPARSE_TAG_MOUNT_POINT:
-		break; /* Mount points and junctions */
+		break; /* Mount points and junctions. */
 	case IO_REPARSE_TAG_SYMLINK:
 		break;
 	case IO_REPARSE_TAG_COMPRESS:
 		/*
-		 * WOF - Windows Overlay Filter - used to compress files with lzx/xpress
+		 * WOF - Windows Overlay Filter - Used to compress files with LZX/Xpress.
 		 * Unlike native NTFS file compression, the Windows Overlay Filter supports
 		 * only read operations. This means that it doesn’t need to sector-align each
 		 * compressed chunk, so the compressed data can be packed more tightly together.
 		 * If you open the file for writing, the Windows Overlay Filter just decompresses
 		 * the entire file, turning it back into a plain file.
 		 *
-		 * ntfs3 driver decompresses the entire file only on write or change size requests
+		 * ntfs3 driver decompresses the entire file only on write or change size requests.
 		 */

 		cmpr = &rp->CompressReparseBuffer;
@@ -1831,14 +1790,15 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 		return REPARSE_NONE;
 	}

-	/* Looks like normal symlink */
+	/* Looks like normal symlink. */
 	return REPARSE_LINK;
 }

 /*
- * helper for file_fiemap
- * assumed ni_lock
- * TODO: less aggressive locks
+ * ni_fiemap - Helper for file_fiemap().
+ *
+ * Assumed ni_lock.
+ * TODO: Less aggressive locks.
  */
 int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
@@ -1872,7 +1832,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			goto out;
 		}
 		if (is_attr_compressed(attr)) {
-			/*unfortunately cp -r incorrectly treats compressed clusters*/
+			/* Unfortunately cp -r incorrectly treats compressed clusters. */
 			err = -EOPNOTSUPP;
 			ntfs_inode_warn(
 				&ni->vfs_inode,
@@ -2014,6 +1974,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 }

 /*
+ * ni_readpage_cmpr
+ *
  * When decompressing, we typically obtain more than one page per reference.
  * We inject the additional pages into the page cache.
  */
@@ -2024,7 +1986,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	struct address_space *mapping = page->mapping;
 	pgoff_t index = page->index;
 	u64 frame_vbo, vbo = (u64)index << PAGE_SHIFT;
-	struct page **pages = NULL; /*array of at most 16 pages. stack?*/
+	struct page **pages = NULL; /* Array of at most 16 pages. stack? */
 	u8 frame_bits;
 	CLST frame;
 	u32 i, idx, frame_size, pages_per_frame;
@@ -2038,10 +2000,10 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	}

 	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
-		/* xpress or lzx */
+		/* Xpress or LZX. */
 		frame_bits = ni_ext_compress_bits(ni);
 	} else {
-		/* lznt compression*/
+		/* LZNT compression. */
 		frame_bits = NTFS_LZNT_CUNIT + sbi->cluster_bits;
 	}
 	frame_size = 1u << frame_bits;
@@ -2087,7 +2049,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	}

 out:
-	/* At this point, err contains 0 or -EIO depending on the "critical" page */
+	/* At this point, err contains 0 or -EIO depending on the "critical" page. */
 	ntfs_free(pages);
 	unlock_page(page);

@@ -2096,9 +2058,10 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)

 #ifdef CONFIG_NTFS3_LZX_XPRESS
 /*
- * decompress lzx/xpress compressed file
- * remove ATTR_DATA::WofCompressedData
- * remove ATTR_REPARSE
+ * ni_decompress_file - Decompress LZX/Xpress compressed file.
+ *
+ * Remove ATTR_DATA::WofCompressedData.
+ * Remove ATTR_REPARSE.
  */
 int ni_decompress_file(struct ntfs_inode *ni)
 {
@@ -2118,13 +2081,13 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	struct mft_inode *mi;
 	int err;

-	/* clusters for decompressed data*/
+	/* Clusters for decompressed data. */
 	cend = bytes_to_cluster(sbi, i_size);

 	if (!i_size)
 		goto remove_wof;

-	/* check in advance */
+	/* Check in advance. */
 	if (cend > wnd_zeroes(&sbi->used.bitmap)) {
 		err = -ENOSPC;
 		goto out;
@@ -2140,7 +2103,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	}

 	/*
-	 * Step 1: decompress data and copy to new allocated clusters
+	 * Step 1: Decompress data and copy to new allocated clusters.
 	 */
 	index = 0;
 	for (vbo = 0; vbo < i_size; vbo += bytes) {
@@ -2202,7 +2165,8 @@ int ni_decompress_file(struct ntfs_inode *ni)

 remove_wof:
 	/*
-	 * Step 2: deallocate attributes ATTR_DATA::WofCompressedData and ATTR_REPARSE
+	 * Step 2: Deallocate attributes ATTR_DATA::WofCompressedData
+	 * and ATTR_REPARSE.
 	 */
 	attr = NULL;
 	le = NULL;
@@ -2235,13 +2199,13 @@ int ni_decompress_file(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 		roff = le16_to_cpu(attr->nres.run_off);

-		/*run==1 means unpack and deallocate*/
+		/*run==1  Means unpack and deallocate. */
 		run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn, evcn, svcn,
 			      Add2Ptr(attr, roff), asize - roff);
 	}

 	/*
-	 * Step 3: remove attribute ATTR_DATA::WofCompressedData
+	 * Step 3: Remove attribute ATTR_DATA::WofCompressedData.
 	 */
 	err = ni_remove_attr(ni, ATTR_DATA, WOF_NAME, ARRAY_SIZE(WOF_NAME),
 			     false, NULL);
@@ -2249,14 +2213,14 @@ int ni_decompress_file(struct ntfs_inode *ni)
 		goto out;

 	/*
-	 * Step 4: remove ATTR_REPARSE
+	 * Step 4: Remove ATTR_REPARSE.
 	 */
 	err = ni_remove_attr(ni, ATTR_REPARSE, NULL, 0, false, NULL);
 	if (err)
 		goto out;

 	/*
-	 * Step 5: remove sparse flag from data attribute
+	 * Step 5: Remove sparse flag from data attribute.
 	 */
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL, &mi);
 	if (!attr) {
@@ -2265,7 +2229,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	}

 	if (attr->non_res && is_attr_sparsed(attr)) {
-		/* sparsed attribute header is 8 bytes bigger than normal*/
+		/* Sarsed attribute header is 8 bytes bigger than normal. */
 		struct MFT_REC *rec = mi->mrec;
 		u32 used = le32_to_cpu(rec->used);
 		u32 asize = le32_to_cpu(attr->size);
@@ -2285,7 +2249,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 		mark_inode_dirty(inode);
 	}

-	/* clear cached flag */
+	/* Clear cached flag. */
 	ni->ni_flags &= ~NI_FLAG_COMPRESSED_MASK;
 	if (ni->file.offs_page) {
 		put_page(ni->file.offs_page);
@@ -2303,7 +2267,9 @@ int ni_decompress_file(struct ntfs_inode *ni)
 	return err;
 }

-/* external compression lzx/xpress */
+/*
+ * decompress_lzx_xpress - External compression LZX/Xpress.
+ */
 static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
 				 size_t cmpr_size, void *unc, size_t unc_size,
 				 u32 frame_size)
@@ -2312,7 +2278,7 @@ static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
 	void *ctx;

 	if (cmpr_size == unc_size) {
-		/* frame not compressed */
+		/* Frame not compressed. */
 		memcpy(unc, cmpr, unc_size);
 		return 0;
 	}
@@ -2320,10 +2286,10 @@ static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
 	err = 0;
 	if (frame_size == 0x8000) {
 		mutex_lock(&sbi->compress.mtx_lzx);
-		/* LZX: frame compressed */
+		/* LZX: Frame compressed. */
 		ctx = sbi->compress.lzx;
 		if (!ctx) {
-			/* Lazy initialize lzx decompress context */
+			/* Lazy initialize LZX decompress context. */
 			ctx = lzx_allocate_decompressor();
 			if (!ctx) {
 				err = -ENOMEM;
@@ -2334,17 +2300,17 @@ static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
 		}

 		if (lzx_decompress(ctx, cmpr, cmpr_size, unc, unc_size)) {
-			/* treat all errors as "invalid argument" */
+			/* Treat all errors as "invalid argument". */
 			err = -EINVAL;
 		}
 out1:
 		mutex_unlock(&sbi->compress.mtx_lzx);
 	} else {
-		/* XPRESS: frame compressed */
+		/* XPRESS: Frame compressed. */
 		mutex_lock(&sbi->compress.mtx_xpress);
 		ctx = sbi->compress.xpress;
 		if (!ctx) {
-			/* Lazy initialize xpress decompress context */
+			/* Lazy initialize Xpress decompress context */
 			ctx = xpress_allocate_decompressor();
 			if (!ctx) {
 				err = -ENOMEM;
@@ -2355,7 +2321,7 @@ static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
 		}

 		if (xpress_decompress(ctx, cmpr, cmpr_size, unc, unc_size)) {
-			/* treat all errors as "invalid argument" */
+			/* Treat all errors as "invalid argument". */
 			err = -EINVAL;
 		}
 out2:
@@ -2368,7 +2334,7 @@ static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
 /*
  * ni_read_frame
  *
- * pages - array of locked pages
+ * Pages - array of locked pages.
  */
 int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		  u32 pages_per_frame)
@@ -2390,7 +2356,8 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	CLST frame, clst_data;

 	/*
-	 * To simplify decompress algorithm do vmap for source and target pages
+	 * To simplify decompress algorithm do vmap for source
+	 * and target pages.
 	 */
 	for (i = 0; i < pages_per_frame; i++)
 		kmap(pages[i]);
@@ -2447,7 +2414,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		case 0x8000:
 			break;
 		default:
-			/* unknown compression */
+			/* Unknown compression. */
 			err = -EOPNOTSUPP;
 			goto out1;
 		}
@@ -2505,7 +2472,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 			goto out1;
 		}
 		vbo_disk = vbo_data;
-		/* load all runs to read [vbo_disk-vbo_to) */
+		/* Load all runs to read [vbo_disk-vbo_to). */
 		err = attr_load_runs_range(ni, ATTR_DATA, WOF_NAME,
 					   ARRAY_SIZE(WOF_NAME), run, vbo_disk,
 					   vbo_data + ondisk_size);
@@ -2516,7 +2483,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 			      PAGE_SHIFT;
 #endif
 	} else if (is_attr_compressed(attr)) {
-		/* lznt compression*/
+		/* LZNT compression. */
 		if (sbi->cluster_size > NTFS_LZNT_MAX_CLUSTER) {
 			err = -EOPNOTSUPP;
 			goto out1;
@@ -2544,7 +2511,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		ondisk_size = clst_data << cluster_bits;

 		if (clst_data >= NTFS_LZNT_CLUSTERS) {
-			/* frame is not compressed */
+			/* Frame is not compressed. */
 			down_read(&ni->file.run_lock);
 			err = ntfs_bio_pages(sbi, run, pages, pages_per_frame,
 					     frame_vbo, ondisk_size,
@@ -2577,7 +2544,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		kmap(pg);
 	}

-	/* read 'ondisk_size' bytes from disk */
+	/* Read 'ondisk_size' bytes from disk. */
 	down_read(&ni->file.run_lock);
 	err = ntfs_bio_pages(sbi, run, pages_disk, npages_disk, vbo_disk,
 			     ondisk_size, REQ_OP_READ);
@@ -2586,7 +2553,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		goto out3;

 	/*
-	 * To simplify decompress algorithm do vmap for source and target pages
+	 * To simplify decompress algorithm do vmap for source and target pages.
 	 */
 	frame_ondisk = vmap(pages_disk, npages_disk, VM_MAP, PAGE_KERNEL_RO);
 	if (!frame_ondisk) {
@@ -2594,7 +2561,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		goto out3;
 	}

-	/* decompress: frame_ondisk -> frame_mem */
+	/* Decompress: Frame_ondisk -> frame_mem. */
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 	if (run != &ni->file.run) {
 		/* LZX or XPRESS */
@@ -2604,7 +2571,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	} else
 #endif
 	{
-		/* LZNT - native ntfs compression */
+		/* LZNT - Native NTFS compression. */
 		unc_size = decompress_lznt(frame_ondisk, ondisk_size, frame_mem,
 					   frame_size);
 		if ((ssize_t)unc_size < 0)
@@ -2652,7 +2619,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 /*
  * ni_write_frame
  *
- * pages - array of locked pages
+ * Pages - Array of locked pages.
  */
 int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		   u32 pages_per_frame)
@@ -2722,9 +2689,7 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		kmap(pg);
 	}

-	/*
-	 * To simplify compress algorithm do vmap for source and target pages
-	 */
+	/* To simplify compress algorithm do vmap for source and target pages. */
 	frame_ondisk = vmap(pages_disk, pages_per_frame, VM_MAP, PAGE_KERNEL);
 	if (!frame_ondisk) {
 		err = -ENOMEM;
@@ -2734,7 +2699,7 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 	for (i = 0; i < pages_per_frame; i++)
 		kmap(pages[i]);

-	/* map in-memory frame for read-only */
+	/* Map in-memory frame for read-only. */
 	frame_mem = vmap(pages, pages_per_frame, VM_MAP, PAGE_KERNEL_RO);
 	if (!frame_mem) {
 		err = -ENOMEM;
@@ -2745,9 +2710,9 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 	lznt = NULL;
 	if (!sbi->compress.lznt) {
 		/*
-		 * lznt implements two levels of compression:
-		 * 0 - standard compression
-		 * 1 - best compression, requires a lot of cpu
+		 * LZNT implements two levels of compression:
+		 * 0 - Standard compression
+		 * 1 - Best compression, requires a lot of cpu
 		 * use mount option?
 		 */
 		lznt = get_lznt_ctx(0);
@@ -2761,22 +2726,22 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		lznt = NULL;
 	}

-	/* compress: frame_mem -> frame_ondisk */
+	/* Compress: frame_mem -> frame_ondisk. */
 	compr_size = compress_lznt(frame_mem, frame_size, frame_ondisk,
 				   frame_size, sbi->compress.lznt);
 	mutex_unlock(&sbi->compress.mtx_lznt);
 	ntfs_free(lznt);

 	if (compr_size + sbi->cluster_size > frame_size) {
-		/* frame is not compressed */
+		/* Frame is not compressed. */
 		compr_size = frame_size;
 		ondisk_size = frame_size;
 	} else if (compr_size) {
-		/* frame is compressed */
+		/* Frame is compressed. */
 		ondisk_size = ntfs_up_cluster(sbi, compr_size);
 		memset(frame_ondisk + compr_size, 0, ondisk_size - compr_size);
 	} else {
-		/* frame is sparsed */
+		/* Frame is sparsed. */
 		ondisk_size = 0;
 	}

@@ -2820,7 +2785,9 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 }

 /*
- * update duplicate info of ATTR_FILE_NAME in MFT and in parent directories
+ * ni_update_parent
+ *
+ * Update duplicate info of ATTR_FILE_NAME in MFT and in parent directories.
  */
 static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 			     int sync)
@@ -2872,7 +2839,7 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		}
 	}

-	/* TODO: fill reparse info */
+	/* TODO: Fill reparse info. */
 	dup->reparse = 0;
 	dup->ea_size = 0;

@@ -2907,9 +2874,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		}

 		if (!active)
-			continue; /*avoid __wait_on_freeing_inode(inode); */
+			continue; /* Avoid __wait_on_freeing_inode(inode); */

-		/*ntfs_iget5 may sleep*/
+		/* ntfs_iget5 may sleep. */
 		dir = ntfs_iget5(sb, &fname->home, NULL);
 		if (IS_ERR(dir)) {
 			ntfs_inode_warn(
@@ -2936,9 +2903,7 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 }

 /*
- * ni_write_inode
- *
- * write mft base record and all subrecords to disk
+ * ni_write_inode - Write MFT base record and all subrecords to disk.
  */
 int ni_write_inode(struct inode *inode, int sync, const char *hint)
 {
@@ -2955,7 +2920,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		return 0;

 	if (!ni_trylock(ni)) {
-		/* 'ni' is under modification, skip for now */
+		/* 'ni' is under modification, skip for now. */
 		mark_inode_dirty_sync(inode);
 		return 0;
 	}
@@ -2964,7 +2929,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
 		bool modified = false;

-		/* update times in standard attribute */
+		/* Update times in standard attribute. */
 		std = ni_std(ni);
 		if (!std) {
 			err = -EINVAL;
@@ -3002,7 +2967,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (!ntfs_is_meta_file(sbi, inode->i_ino) &&
 		    (modified || (ni->ni_flags & NI_FLAG_UPDATE_PARENT))) {
 			dup.cr_time = std->cr_time;
-			/* Not critical if this function fail */
+			/* Not critical if this function fail. */
 			re_dirty = ni_update_parent(ni, &dup, sync);

 			if (re_dirty)
@@ -3011,7 +2976,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 				ni->ni_flags &= ~NI_FLAG_UPDATE_PARENT;
 		}

-		/* update attribute list */
+		/* Update attribute list. */
 		if (ni->attr_list.size && ni->attr_list.dirty) {
 			if (inode->i_ino != MFT_REC_MFT || sync) {
 				err = ni_try_remove_attr_list(ni);
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 53da12252408..12e4eafd83f6 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -30,8 +30,8 @@

 struct RESTART_HDR {
 	struct NTFS_RECORD_HEADER rhdr; // 'RSTR'
-	__le32 sys_page_size; // 0x10: Page size of the system which initialized the log
-	__le32 page_size;     // 0x14: Log page size used for this log file
+	__le32 sys_page_size; // 0x10: Page size of the system which initialized the log.
+	__le32 page_size;     // 0x14: Log page size used for this log file.
 	__le16 ra_off;        // 0x18:
 	__le16 minor_ver;     // 0x1A:
 	__le16 major_ver;     // 0x1C:
@@ -47,26 +47,26 @@ struct CLIENT_REC {
 	__le16 prev_client; // 0x10:
 	__le16 next_client; // 0x12:
 	__le16 seq_num;     // 0x14:
-	u8 align[6];        // 0x16
-	__le32 name_bytes;  // 0x1C: in bytes
-	__le16 name[32];    // 0x20: name of client
+	u8 align[6];        // 0x16:
+	__le32 name_bytes;  // 0x1C: In bytes.
+	__le16 name[32];    // 0x20: Name of client.
 };

 static_assert(sizeof(struct CLIENT_REC) == 0x60);

 /* Two copies of these will exist at the beginning of the log file */
 struct RESTART_AREA {
-	__le64 current_lsn;    // 0x00: Current logical end of log file
-	__le16 log_clients;    // 0x08: Maximum number of clients
-	__le16 client_idx[2];  // 0x0A: free/use index into the client record arrays
-	__le16 flags;          // 0x0E: See RESTART_SINGLE_PAGE_IO
-	__le32 seq_num_bits;   // 0x10: the number of bits in sequence number.
+	__le64 current_lsn;    // 0x00: Current logical end of log file.
+	__le16 log_clients;    // 0x08: Maximum number of clients.
+	__le16 client_idx[2];  // 0x0A: Free/use index into the client record arrays.
+	__le16 flags;          // 0x0E: See RESTART_SINGLE_PAGE_IO.
+	__le32 seq_num_bits;   // 0x10: The number of bits in sequence number.
 	__le16 ra_len;         // 0x14:
 	__le16 client_off;     // 0x16:
 	__le64 l_size;         // 0x18: Usable log file size.
 	__le32 last_lsn_data_len; // 0x20:
-	__le16 rec_hdr_len;    // 0x24: log page data offset
-	__le16 data_off;       // 0x26: log page data length
+	__le16 rec_hdr_len;    // 0x24: Log page data offset.
+	__le16 data_off;       // 0x26: Log page data length.
 	__le32 open_log_count; // 0x28:
 	__le32 align[5];       // 0x2C:
 	struct CLIENT_REC clients[]; // 0x40:
@@ -75,10 +75,10 @@ struct RESTART_AREA {
 struct LOG_REC_HDR {
 	__le16 redo_op;      // 0x00:  NTFS_LOG_OPERATION
 	__le16 undo_op;      // 0x02:  NTFS_LOG_OPERATION
-	__le16 redo_off;     // 0x04:  Offset to Redo record
-	__le16 redo_len;     // 0x06:  Redo length
-	__le16 undo_off;     // 0x08:  Offset to Undo record
-	__le16 undo_len;     // 0x0A:  Undo length
+	__le16 redo_off;     // 0x04:  Offset to Redo record.
+	__le16 redo_len;     // 0x06:  Redo length.
+	__le16 undo_off;     // 0x08:  Offset to Undo record.
+	__le16 undo_len;     // 0x0A:  Undo length.
 	__le16 target_attr;  // 0x0C:
 	__le16 lcns_follow;  // 0x0E:
 	__le16 record_off;   // 0x10:
@@ -95,20 +95,20 @@ static_assert(sizeof(struct LOG_REC_HDR) == 0x20);
 #define RESTART_ENTRY_ALLOCATED_LE cpu_to_le32(0xFFFFFFFF)

 struct RESTART_TABLE {
-	__le16 size;       // 0x00:  In bytes
-	__le16 used;       // 0x02: entries
-	__le16 total;      // 0x04: entries
+	__le16 size;       // 0x00: In bytes
+	__le16 used;       // 0x02: Entries
+	__le16 total;      // 0x04: Entries
 	__le16 res[3];     // 0x06:
 	__le32 free_goal;  // 0x0C:
-	__le32 first_free; // 0x10
-	__le32 last_free;  // 0x14
+	__le32 first_free; // 0x10:
+	__le32 last_free;  // 0x14:

 };

 static_assert(sizeof(struct RESTART_TABLE) == 0x18);

 struct ATTR_NAME_ENTRY {
-	__le16 off; // offset in the Open attribute Table
+	__le16 off; // Offset in the Open attribute Table.
 	__le16 name_bytes;
 	__le16 name[];
 };
@@ -121,7 +121,7 @@ struct OPEN_ATTR_ENRTY {
 	u8 is_attr_name;        // 0x0B: Faked field to manage 'ptr'
 	u8 name_len;            // 0x0C: Faked field to manage 'ptr'
 	u8 res;
-	struct MFT_REF ref; // 0x10: File Reference of file containing attribute
+	struct MFT_REF ref;     // 0x10: File Reference of file containing attribute
 	__le64 open_record_lsn; // 0x18:
 	void *ptr;              // 0x20:
 };
@@ -133,10 +133,10 @@ struct OPEN_ATTR_ENRTY_32 {
 	struct MFT_REF ref;     // 0x08:
 	__le64 open_record_lsn; // 0x10:
 	u8 is_dirty_pages;      // 0x18:
-	u8 is_attr_name;        // 0x19
+	u8 is_attr_name;        // 0x19:
 	u8 res1[2];
 	enum ATTR_TYPE type;    // 0x1C:
-	u8 name_len;            // 0x20:  in wchar
+	u8 name_len;            // 0x20: In wchar
 	u8 res2[3];
 	__le32 AttributeName;   // 0x24:
 	__le32 bytes_per_index; // 0x28:
@@ -147,15 +147,15 @@ struct OPEN_ATTR_ENRTY_32 {
 static_assert(sizeof(struct OPEN_ATTR_ENRTY) < SIZEOF_OPENATTRIBUTEENTRY0);

 /*
- * One entry exists in the Dirty Pages Table for each page which is dirty at the
- * time the Restart Area is written
+ * One entry exists in the Dirty Pages Table for each page which is dirty at
+ * the time the Restart Area is written.
  */
 struct DIR_PAGE_ENTRY {
-	__le32 next;         // 0x00:  RESTART_ENTRY_ALLOCATED if allocated
-	__le32 target_attr;  // 0x04:  Index into the Open attribute Table
+	__le32 next;         // 0x00: RESTART_ENTRY_ALLOCATED if allocated
+	__le32 target_attr;  // 0x04: Index into the Open attribute Table
 	__le32 transfer_len; // 0x08:
 	__le32 lcns_follow;  // 0x0C:
-	__le64 vcn;          // 0x10:  Vcn of dirty page
+	__le64 vcn;          // 0x10: Vcn of dirty page
 	__le64 oldest_lsn;   // 0x18:
 	__le64 page_lcns[];  // 0x20:
 };
@@ -164,17 +164,17 @@ static_assert(sizeof(struct DIR_PAGE_ENTRY) == 0x20);

 /* 32 bit version of 'struct DIR_PAGE_ENTRY' */
 struct DIR_PAGE_ENTRY_32 {
-	__le32 next;         // 0x00:  RESTART_ENTRY_ALLOCATED if allocated
-	__le32 target_attr;  // 0x04:  Index into the Open attribute Table
-	__le32 transfer_len; // 0x08:
-	__le32 lcns_follow;  // 0x0C:
-	__le32 reserved;     // 0x10:
-	__le32 vcn_low;      // 0x14:  Vcn of dirty page
-	__le32 vcn_hi;       // 0x18:  Vcn of dirty page
-	__le32 oldest_lsn_low; // 0x1C:
-	__le32 oldest_lsn_hi; // 0x1C:
-	__le32 page_lcns_low; // 0x24:
-	__le32 page_lcns_hi; // 0x24:
+	__le32 next;		// 0x00: RESTART_ENTRY_ALLOCATED if allocated
+	__le32 target_attr;	// 0x04: Index into the Open attribute Table
+	__le32 transfer_len;	// 0x08:
+	__le32 lcns_follow;	// 0x0C:
+	__le32 reserved;	// 0x10:
+	__le32 vcn_low;		// 0x14: Vcn of dirty page
+	__le32 vcn_hi;		// 0x18: Vcn of dirty page
+	__le32 oldest_lsn_low;	// 0x1C:
+	__le32 oldest_lsn_hi;	// 0x1C:
+	__le32 page_lcns_low;	// 0x24:
+	__le32 page_lcns_hi;	// 0x24:
 };

 static_assert(offsetof(struct DIR_PAGE_ENTRY_32, vcn_low) == 0x14);
@@ -233,27 +233,27 @@ struct LCN_RANGE {
 	__le64 len;
 };

-/* The following type defines the different log record types */
+/* The following type defines the different log record types. */
 #define LfsClientRecord  cpu_to_le32(1)
 #define LfsClientRestart cpu_to_le32(2)

-/* This is used to uniquely identify a client for a particular log file */
+/* This is used to uniquely identify a client for a particular log file. */
 struct CLIENT_ID {
 	__le16 seq_num;
 	__le16 client_idx;
 };

-/* This is the header that begins every Log Record in the log file */
+/* This is the header that begins every Log Record in the log file. */
 struct LFS_RECORD_HDR {
-	__le64 this_lsn;    // 0x00:
-	__le64 client_prev_lsn;  // 0x08:
-	__le64 client_undo_next_lsn; // 0x10:
-	__le32 client_data_len;  // 0x18:
-	struct CLIENT_ID client; // 0x1C: Owner of this log record
-	__le32 record_type; // 0x20: LfsClientRecord or LfsClientRestart
-	__le32 transact_id; // 0x24:
-	__le16 flags;       // 0x28:	LOG_RECORD_MULTI_PAGE
-	u8 align[6];        // 0x2A:
+	__le64 this_lsn;		// 0x00:
+	__le64 client_prev_lsn;		// 0x08:
+	__le64 client_undo_next_lsn;	// 0x10:
+	__le32 client_data_len;		// 0x18:
+	struct CLIENT_ID client;	// 0x1C: Owner of this log record.
+	__le32 record_type;		// 0x20: LfsClientRecord or LfsClientRestart.
+	__le32 transact_id;		// 0x24:
+	__le16 flags;			// 0x28: LOG_RECORD_MULTI_PAGE
+	u8 align[6];			// 0x2A:
 };

 #define LOG_RECORD_MULTI_PAGE cpu_to_le16(1)
@@ -261,26 +261,26 @@ struct LFS_RECORD_HDR {
 static_assert(sizeof(struct LFS_RECORD_HDR) == 0x30);

 struct LFS_RECORD {
-	__le16 next_record_off; // 0x00: Offset of the free space in the page
-	u8 align[6];         // 0x02:
-	__le64 last_end_lsn; // 0x08: lsn for the last log record which ends on the page
+	__le16 next_record_off;	// 0x00: Offset of the free space in the page,
+	u8 align[6];		// 0x02:
+	__le64 last_end_lsn;	// 0x08: lsn for the last log record which ends on the page,
 };

 static_assert(sizeof(struct LFS_RECORD) == 0x10);

 struct RECORD_PAGE_HDR {
-	struct NTFS_RECORD_HEADER rhdr; // 'RCRD'
-	__le32 rflags;     // 0x10:  See LOG_PAGE_LOG_RECORD_END
-	__le16 page_count; // 0x14:
-	__le16 page_pos;   // 0x16:
-	struct LFS_RECORD record_hdr; // 0x18
-	__le16 fixups[10]; // 0x28
-	__le32 file_off;   // 0x3c: used when major version >= 2
+	struct NTFS_RECORD_HEADER rhdr;	// 'RCRD'
+	__le32 rflags;			// 0x10: See LOG_PAGE_LOG_RECORD_END
+	__le16 page_count;		// 0x14:
+	__le16 page_pos;		// 0x16:
+	struct LFS_RECORD record_hdr;	// 0x18:
+	__le16 fixups[10];		// 0x28:
+	__le32 file_off;		// 0x3c: Used when major version >= 2
 };

 // clang-format on

-// Page contains the end of a log record
+// Page contains the end of a log record.
 #define LOG_PAGE_LOG_RECORD_END cpu_to_le32(0x00000001)

 static inline bool is_log_record_end(const struct RECORD_PAGE_HDR *hdr)
@@ -294,7 +294,7 @@ static_assert(offsetof(struct RECORD_PAGE_HDR, file_off) == 0x3c);
  * END of NTFS LOG structures
  */

-/* Define some tuning parameters to keep the restart tables a reasonable size */
+/* Define some tuning parameters to keep the restart tables a reasonable size. */
 #define INITIAL_NUMBER_TRANSACTIONS 5

 enum NTFS_LOG_OPERATION {
@@ -342,8 +342,9 @@ enum NTFS_LOG_OPERATION {
 };

 /*
- * Array for log records which require a target attribute
- * A true indicates that the corresponding restart operation requires a target attribute
+ * Array for log records which require a target attribute.
+ * A true indicates that the corresponding restart operation
+ * requires a target attribute.
  */
 static const u8 AttributeRequired[] = {
 	0xFC, 0xFB, 0xFF, 0x10, 0x06,
@@ -380,14 +381,14 @@ static inline bool can_skip_action(enum NTFS_LOG_OPERATION op)

 enum { lcb_ctx_undo_next, lcb_ctx_prev, lcb_ctx_next };

-/* bytes per restart table */
+/* Bytes per restart table. */
 static inline u32 bytes_per_rt(const struct RESTART_TABLE *rt)
 {
 	return le16_to_cpu(rt->used) * le16_to_cpu(rt->size) +
 	       sizeof(struct RESTART_TABLE);
 }

-/* log record length */
+/* Log record length. */
 static inline u32 lrh_length(const struct LOG_REC_HDR *lr)
 {
 	u16 t16 = le16_to_cpu(lr->lcns_follow);
@@ -396,11 +397,11 @@ static inline u32 lrh_length(const struct LOG_REC_HDR *lr)
 }

 struct lcb {
-	struct LFS_RECORD_HDR *lrh; // Log record header of the current lsn
+	struct LFS_RECORD_HDR *lrh; // Log record header of the current lsn.
 	struct LOG_REC_HDR *log_rec;
 	u32 ctx_mode; // lcb_ctx_undo_next/lcb_ctx_prev/lcb_ctx_next
 	struct CLIENT_ID client;
-	bool alloc; // if true the we should deallocate 'log_rec'
+	bool alloc; // If true the we should deallocate 'log_rec'.
 };

 static void lcb_put(struct lcb *lcb)
@@ -411,11 +412,7 @@ static void lcb_put(struct lcb *lcb)
 	ntfs_free(lcb);
 }

-/*
- * oldest_client_lsn
- *
- * find the oldest lsn from active clients.
- */
+/* Find the oldest lsn from active clients. */
 static inline void oldest_client_lsn(const struct CLIENT_REC *ca,
 				     __le16 next_client, u64 *oldest_lsn)
 {
@@ -423,7 +420,7 @@ static inline void oldest_client_lsn(const struct CLIENT_REC *ca,
 		const struct CLIENT_REC *cr = ca + le16_to_cpu(next_client);
 		u64 lsn = le64_to_cpu(cr->oldest_lsn);

-		/* ignore this block if it's oldest lsn is 0 */
+		/* Ignore this block if it's oldest lsn is 0. */
 		if (lsn && lsn < *oldest_lsn)
 			*oldest_lsn = lsn;

@@ -444,11 +441,11 @@ static inline bool is_rst_page_hdr_valid(u32 file_off,
 		return false;
 	}

-	/* Check that if the file offset isn't 0, it is the system page size */
+	/* Check that if the file offset isn't 0, it is the system page size. */
 	if (file_off && file_off != sys_page)
 		return false;

-	/* Check support version 1.1+ */
+	/* Check support version 1.1+. */
 	if (le16_to_cpu(rhdr->major_ver) <= 1 && !rhdr->minor_ver)
 		return false;

@@ -498,7 +495,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)

 	/*
 	 * Check the restart length field and whether the entire
-	 * restart area is contained that length
+	 * restart area is contained that length.
 	 */
 	if (le16_to_cpu(rhdr->ra_off) + le16_to_cpu(ra->ra_len) > sys_page ||
 	    off > le16_to_cpu(ra->ra_len)) {
@@ -507,7 +504,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)

 	/*
 	 * As a final check make sure that the use list and the free list
-	 * are either empty or point to a valid client
+	 * are either empty or point to a valid client.
 	 */
 	fl = le16_to_cpu(ra->client_idx[0]);
 	ul = le16_to_cpu(ra->client_idx[1]);
@@ -515,7 +512,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 	    (ul != LFS_NO_CLIENT && ul >= cl))
 		return false;

-	/* Make sure the sequence number bits match the log file size */
+	/* Make sure the sequence number bits match the log file size. */
 	l_size = le64_to_cpu(ra->l_size);

 	file_dat_bits = sizeof(u64) * 8 - le32_to_cpu(ra->seq_num_bits);
@@ -525,7 +522,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 		return false;
 	}

-	/* The log page data offset and record header length must be quad-aligned */
+	/* The log page data offset and record header length must be quad-aligned. */
 	if (!IsQuadAligned(le16_to_cpu(ra->data_off)) ||
 	    !IsQuadAligned(le16_to_cpu(ra->rec_hdr_len)))
 		return false;
@@ -545,13 +542,13 @@ static inline bool is_client_area_valid(const struct RESTART_HDR *rhdr,
 	if (usa_error && ra_len + ro > SECTOR_SIZE - sizeof(short))
 		return false;

-	/* Find the start of the client array */
+	/* Find the start of the client array. */
 	ca = Add2Ptr(ra, le16_to_cpu(ra->client_off));

 	/*
-	 * Start with the free list
-	 * Check that all the clients are valid and that there isn't a cycle
-	 * Do the in-use list on the second pass
+	 * Start with the free list.
+	 * Check that all the clients are valid and that there isn't a cycle.
+	 * Do the in-use list on the second pass.
 	 */
 	for (i = 0; i < 2; i++) {
 		u16 client_idx = le16_to_cpu(ra->client_idx[i]);
@@ -584,7 +581,7 @@ static inline bool is_client_area_valid(const struct RESTART_HDR *rhdr,
 /*
  * remove_client
  *
- * remove a client record from a client record list an restart area
+ * Remove a client record from a client record list an restart area.
  */
 static inline void remove_client(struct CLIENT_REC *ca,
 				 const struct CLIENT_REC *cr, __le16 *head)
@@ -599,9 +596,7 @@ static inline void remove_client(struct CLIENT_REC *ca,
 }

 /*
- * add_client
- *
- * add a client record to the start of a list
+ * add_client - Add a client record to the start of a list.
  */
 static inline void add_client(struct CLIENT_REC *ca, u16 index, __le16 *head)
 {
@@ -616,10 +611,6 @@ static inline void add_client(struct CLIENT_REC *ca, u16 index, __le16 *head)
 	*head = cpu_to_le16(index);
 }

-/*
- * enum_rstbl
- *
- */
 static inline void *enum_rstbl(struct RESTART_TABLE *t, void *c)
 {
 	__le32 *e;
@@ -634,7 +625,7 @@ static inline void *enum_rstbl(struct RESTART_TABLE *t, void *c)
 		e = Add2Ptr(c, rsize);
 	}

-	/* Loop until we hit the first one allocated, or the end of the list */
+	/* Loop until we hit the first one allocated, or the end of the list. */
 	for (bprt = bytes_per_rt(t); PtrOffset(t, e) < bprt;
 	     e = Add2Ptr(e, rsize)) {
 		if (*e == RESTART_ENTRY_ALLOCATED_LE)
@@ -644,9 +635,7 @@ static inline void *enum_rstbl(struct RESTART_TABLE *t, void *c)
 }

 /*
- * find_dp
- *
- * searches for a 'vcn' in Dirty Page Table,
+ * find_dp - Search for a @vcn in Dirty Page Table.
  */
 static inline struct DIR_PAGE_ENTRY *find_dp(struct RESTART_TABLE *dptbl,
 					     u32 target_attr, u64 vcn)
@@ -670,10 +659,10 @@ static inline u32 norm_file_page(u32 page_size, u32 *l_size, bool use_default)
 	if (use_default)
 		page_size = DefaultLogPageSize;

-	/* Round the file size down to a system page boundary */
+	/* Round the file size down to a system page boundary. */
 	*l_size &= ~(page_size - 1);

-	/* File should contain at least 2 restart pages and MinLogRecordPages pages */
+	/* File should contain at least 2 restart pages and MinLogRecordPages pages. */
 	if (*l_size < (MinLogRecordPages + 2) * page_size)
 		return 0;

@@ -743,8 +732,9 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 		return false;
 	}

-	/* Verify each entry is either allocated or points
-	 * to a valid offset the table
+	/*
+	 * Verify each entry is either allocated or points
+	 * to a valid offset the table.
 	 */
 	for (i = 0; i < ne; i++) {
 		off = le32_to_cpu(*(__le32 *)Add2Ptr(
@@ -757,8 +747,9 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 		}
 	}

-	/* Walk through the list headed by the first entry to make
-	 * sure none of the entries are currently being used
+	/*
+	 * Walk through the list headed by the first entry to make
+	 * sure none of the entries are currently being used.
 	 */
 	for (off = ff; off;) {
 		if (off == RESTART_ENTRY_ALLOCATED)
@@ -771,9 +762,7 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 }

 /*
- * free_rsttbl_idx
- *
- * frees a previously allocated index a Restart Table.
+ * free_rsttbl_idx - Free a previously allocated index a Restart Table.
  */
 static inline void free_rsttbl_idx(struct RESTART_TABLE *rt, u32 off)
 {
@@ -856,7 +845,7 @@ static inline struct RESTART_TABLE *extend_rsttbl(struct RESTART_TABLE *tbl,
 /*
  * alloc_rsttbl_idx
  *
- * allocates an index from within a previously initialized Restart Table
+ * Allocate an index from within a previously initialized Restart Table.
  */
 static inline void *alloc_rsttbl_idx(struct RESTART_TABLE **tbl)
 {
@@ -890,7 +879,7 @@ static inline void *alloc_rsttbl_idx(struct RESTART_TABLE **tbl)
 /*
  * alloc_rsttbl_from_idx
  *
- * allocates a specific index from within a previously initialized Restart Table
+ * Allocate a specific index from within a previously initialized Restart Table.
  */
 static inline void *alloc_rsttbl_from_idx(struct RESTART_TABLE **tbl, u32 vbo)
 {
@@ -900,23 +889,24 @@ static inline void *alloc_rsttbl_from_idx(struct RESTART_TABLE **tbl, u32 vbo)
 	u32 bytes = bytes_per_rt(rt);
 	u16 esize = le16_to_cpu(rt->size);

-	/* If the entry is not the table, we will have to extend the table */
+	/* If the entry is not the table, we will have to extend the table. */
 	if (vbo >= bytes) {
 		/*
-		 * extend the size by computing the number of entries between
-		 * the existing size and the desired index and adding
-		 * 1 to that
+		 * Extend the size by computing the number of entries between
+		 * the existing size and the desired index and adding 1 to that.
 		 */
 		u32 bytes2idx = vbo - bytes;

-		/* There should always be an integral number of entries being added */
-		/* Now extend the table */
+		/*
+		 * There should always be an integral number of entries
+		 * being added. Now extend the table.
+		 */
 		*tbl = rt = extend_rsttbl(rt, bytes2idx / esize + 1, bytes);
 		if (!rt)
 			return NULL;
 	}

-	/* see if the entry is already allocated, and just return if it is. */
+	/* See if the entry is already allocated, and just return if it is. */
 	e = Add2Ptr(rt, vbo);

 	if (*e == RESTART_ENTRY_ALLOCATED_LE)
@@ -924,7 +914,7 @@ static inline void *alloc_rsttbl_from_idx(struct RESTART_TABLE **tbl, u32 vbo)

 	/*
 	 * Walk through the table, looking for the entry we're
-	 * interested and the previous entry
+	 * interested and the previous entry.
 	 */
 	off = le32_to_cpu(rt->first_free);
 	e = Add2Ptr(rt, off);
@@ -936,24 +926,28 @@ static inline void *alloc_rsttbl_from_idx(struct RESTART_TABLE **tbl, u32 vbo)
 	}

 	/*
-	 * need to walk through the list looking for the predecessor of our entry
+	 * Need to walk through the list looking for the predecessor
+	 * of our entry.
 	 */
 	for (;;) {
 		/* Remember the entry just found */
 		u32 last_off = off;
 		__le32 *last_e = e;

-		/* should never run of entries. */
+		/* Should never run of entries. */

-		/* Lookup up the next entry the list */
+		/* Lookup up the next entry the list. */
 		off = le32_to_cpu(*last_e);
 		e = Add2Ptr(rt, off);

-		/* If this is our match we are done */
+		/* If this is our match we are done. */
 		if (off == vbo) {
 			*last_e = *e;

-			/* If this was the last entry, we update that the table as well */
+			/*
+			 * If this was the last entry, we update that
+			 * table as well.
+			 */
 			if (le32_to_cpu(rt->last_free) == off)
 				rt->last_free = cpu_to_le32(last_off);
 			break;
@@ -961,11 +955,11 @@ static inline void *alloc_rsttbl_from_idx(struct RESTART_TABLE **tbl, u32 vbo)
 	}

 skip_looking:
-	/* If the list is now empty, we fix the last_free as well */
+	/* If the list is now empty, we fix the last_free as well. */
 	if (!rt->first_free)
 		rt->last_free = 0;

-	/* Zero this entry */
+	/* Zero this entry. */
 	memset(e, 0, esize);
 	*e = RESTART_ENTRY_ALLOCATED_LE;

@@ -982,9 +976,7 @@ static inline void *alloc_rsttbl_from_idx(struct RESTART_TABLE **tbl, u32 vbo)
 #define NTFSLOG_REUSE_TAIL 0x00000010
 #define NTFSLOG_NO_OLDEST_LSN 0x00000020

-/*
- * Helper struct to work with NTFS LogFile
- */
+/* Helper struct to work with NTFS $LogFile. */
 struct ntfs_log {
 	struct ntfs_inode *ni;

@@ -1012,15 +1004,15 @@ struct ntfs_log {
 	u32 file_data_bits;
 	u32 seq_num_mask; /* (1 << file_data_bits) - 1 */

-	struct RESTART_AREA *ra; /* in-memory image of the next restart area */
-	u32 ra_size; /* the usable size of the restart area */
+	struct RESTART_AREA *ra; /* In-memory image of the next restart area. */
+	u32 ra_size; /* The usable size of the restart area. */

 	/*
 	 * If true, then the in-memory restart area is to be written
-	 * to the first position on the disk
+	 * to the first position on the disk.
 	 */
 	bool init_ra;
-	bool set_dirty; /* true if we need to set dirty flag */
+	bool set_dirty; /* True if we need to set dirty flag. */

 	u64 oldest_lsn;

@@ -1038,7 +1030,7 @@ struct ntfs_log {
 	short minor_ver;

 	u32 l_flags; /* See NTFSLOG_XXX */
-	u32 current_openlog_count; /* On-disk value for open_log_count */
+	u32 current_openlog_count; /* On-disk value for open_log_count. */

 	struct CLIENT_ID client_id;
 	u32 client_undo_commit;
@@ -1051,7 +1043,7 @@ static inline u32 lsn_to_vbo(struct ntfs_log *log, const u64 lsn)
 	return vbo;
 }

-/* compute the offset in the log file of the next log page */
+/* Compute the offset in the log file of the next log page. */
 static inline u32 next_page_off(struct ntfs_log *log, u32 off)
 {
 	off = (off & ~log->sys_page_mask) + log->page_size;
@@ -1174,8 +1166,9 @@ static int read_log_page(struct ntfs_log *log, u32 vbo,
 /*
  * log_read_rst
  *
- * it walks through 512 blocks of the file looking for a valid restart page header
- * It will stop the first time we find a valid page header
+ * It walks through 512 blocks of the file looking for a valid
+ * restart page header. It will stop the first time we find a
+ * valid page header.
  */
 static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			struct restart_info *info)
@@ -1188,7 +1181,7 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,

 	memset(info, 0, sizeof(struct restart_info));

-	/* Determine which restart area we are looking for */
+	/* Determine which restart area we are looking for. */
 	if (first) {
 		vbo = 0;
 		skip = 512;
@@ -1197,21 +1190,21 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 		skip = 0;
 	}

-	/* loop continuously until we succeed */
+	/* Loop continuously until we succeed. */
 	for (; vbo < l_size; vbo = 2 * vbo + skip, skip = 0) {
 		bool usa_error;
 		u32 sys_page_size;
 		bool brst, bchk;
 		struct RESTART_AREA *ra;

-		/* Read a page header at the current offset */
+		/* Read a page header at the current offset. */
 		if (read_log_page(log, vbo, (struct RECORD_PAGE_HDR **)&r_page,
 				  &usa_error)) {
-			/* ignore any errors */
+			/* Ignore any errors. */
 			continue;
 		}

-		/* exit if the signature is a log record page */
+		/* Exit if the signature is a log record page. */
 		if (r_page->rhdr.sign == NTFS_RCRD_SIGNATURE) {
 			info->initialized = true;
 			break;
@@ -1224,7 +1217,7 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			if (r_page->rhdr.sign != NTFS_FFFF_SIGNATURE) {
 				/*
 				 * Remember if the signature does not
-				 * indicate uninitialized file
+				 * indicate uninitialized file.
 				 */
 				info->initialized = true;
 			}
@@ -1236,7 +1229,7 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 		info->initialized = true;
 		info->vbo = vbo;

-		/* Let's check the restart area if this is a valid page */
+		/* Let's check the restart area if this is a valid page. */
 		if (!is_rst_page_hdr_valid(vbo, r_page))
 			goto check_result;
 		ra = Add2Ptr(r_page, le16_to_cpu(r_page->ra_off));
@@ -1247,14 +1240,14 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 		/*
 		 * We have a valid restart page header and restart area.
 		 * If chkdsk was run or we have no clients then we have
-		 * no more checking to do
+		 * no more checking to do.
 		 */
 		if (bchk || ra->client_idx[1] == LFS_NO_CLIENT_LE) {
 			info->valid_page = true;
 			goto check_result;
 		}

-		/* Read the entire restart area */
+		/* Read the entire restart area. */
 		sys_page_size = le32_to_cpu(r_page->sys_page_size);
 		if (DefaultLogPageSize != sys_page_size) {
 			ntfs_free(r_page);
@@ -1265,7 +1258,7 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			if (read_log_page(log, vbo,
 					  (struct RECORD_PAGE_HDR **)&r_page,
 					  &usa_error)) {
-				/* ignore any errors */
+				/* Ignore any errors. */
 				ntfs_free(r_page);
 				r_page = NULL;
 				continue;
@@ -1278,7 +1271,10 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 		}

 check_result:
-		/* If chkdsk was run then update the caller's values and return */
+		/*
+		 * If chkdsk was run then update the caller's
+		 * values and return.
+		 */
 		if (r_page->rhdr.sign == NTFS_CHKD_SIGNATURE) {
 			info->chkdsk_was_run = true;
 			info->last_lsn = le64_to_cpu(r_page->rhdr.lsn);
@@ -1287,7 +1283,10 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			return 0;
 		}

-		/* If we have a valid page then copy the values we need from it */
+		/*
+		 * If we have a valid page then copy the values
+		 * we need from it.
+		 */
 		if (info->valid_page) {
 			info->last_lsn = le64_to_cpu(ra->current_lsn);
 			info->restart = true;
@@ -1302,9 +1301,7 @@ static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 }

 /*
- * log_init_pg_hdr
- *
- * init "log' from restart page header
+ * Ilog_init_pg_hdr - Init @log from restart page header.
  */
 static void log_init_pg_hdr(struct ntfs_log *log, u32 sys_page_size,
 			    u32 page_size, u16 major_ver, u16 minor_ver)
@@ -1327,15 +1324,13 @@ static void log_init_pg_hdr(struct ntfs_log *log, u32 sys_page_size,
 }

 /*
- * log_create
- *
- * init "log" in cases when we don't have a restart area to use
+ * log_create - Init @log in cases when we don't have a restart area to use.
  */
 static void log_create(struct ntfs_log *log, u32 l_size, const u64 last_lsn,
 		       u32 open_log_count, bool wrapped, bool use_multi_page)
 {
 	log->l_size = l_size;
-	/* All file offsets must be quadword aligned */
+	/* All file offsets must be quadword aligned. */
 	log->file_data_bits = blksize_bits(l_size) - 3;
 	log->seq_num_mask = (8 << log->file_data_bits) - 1;
 	log->seq_num_bits = sizeof(u64) * 8 - log->file_data_bits;
@@ -1347,21 +1342,21 @@ static void log_create(struct ntfs_log *log, u32 l_size, const u64 last_lsn,

 	log->l_flags |= NTFSLOG_NO_LAST_LSN | NTFSLOG_NO_OLDEST_LSN;

-	/* Set the correct flags for the I/O and indicate if we have wrapped */
+	/* Set the correct flags for the I/O and indicate if we have wrapped. */
 	if (wrapped)
 		log->l_flags |= NTFSLOG_WRAPPED;

 	if (use_multi_page)
 		log->l_flags |= NTFSLOG_MULTIPLE_PAGE_IO;

-	/* Compute the log page values */
+	/* Compute the log page values. */
 	log->data_off = QuadAlign(
 		offsetof(struct RECORD_PAGE_HDR, fixups) +
 		sizeof(short) * ((log->page_size >> SECTOR_SHIFT) + 1));
 	log->data_size = log->page_size - log->data_off;
 	log->record_header_len = sizeof(struct LFS_RECORD_HDR);

-	/* Remember the different page sizes for reservation */
+	/* Remember the different page sizes for reservation. */
 	log->reserved = log->data_size - log->record_header_len;

 	/* Compute the restart page values. */
@@ -1374,15 +1369,15 @@ static void log_create(struct ntfs_log *log, u32 l_size, const u64 last_lsn,

 	/*
 	 * The total available log file space is the number of
-	 * log file pages times the space available on each page
+	 * log file pages times the space available on each page.
 	 */
 	log->total_avail_pages = log->l_size - log->first_page;
 	log->total_avail = log->total_avail_pages >> log->page_bits;

 	/*
 	 * We assume that we can't use the end of the page less than
-	 * the file record size
-	 * Then we won't need to reserve more than the caller asks for
+	 * the file record size.
+	 * Then we won't need to reserve more than the caller asks for.
 	 */
 	log->max_current_avail = log->total_avail * log->reserved;
 	log->total_avail = log->total_avail * log->data_size;
@@ -1390,9 +1385,7 @@ static void log_create(struct ntfs_log *log, u32 l_size, const u64 last_lsn,
 }

 /*
- * log_create_ra
- *
- * This routine is called to fill a restart area from the values stored in 'log'
+ * log_create_ra - Fill a restart area from the values stored in @log.
  */
 static struct RESTART_AREA *log_create_ra(struct ntfs_log *log)
 {
@@ -1432,12 +1425,12 @@ static u32 final_log_off(struct ntfs_log *log, u64 lsn, u32 data_len)

 	page_off -= 1;

-	/* Add the length of the header */
+	/* Add the length of the header. */
 	data_len += log->record_header_len;

 	/*
-	 * If this lsn is contained this log page we are done
-	 * Otherwise we need to walk through several log pages
+	 * If this lsn is contained this log page we are done.
+	 * Otherwise we need to walk through several log pages.
 	 */
 	if (data_len > tail) {
 		data_len -= tail;
@@ -1447,7 +1440,10 @@ static u32 final_log_off(struct ntfs_log *log, u64 lsn, u32 data_len)
 		for (;;) {
 			final_log_off = next_page_off(log, final_log_off);

-			/* We are done if the remaining bytes fit on this page */
+			/*
+			 * We are done if the remaining bytes
+			 * fit on this page.
+			 */
 			if (data_len <= tail)
 				break;
 			data_len -= tail;
@@ -1456,7 +1452,7 @@ static u32 final_log_off(struct ntfs_log *log, u64 lsn, u32 data_len)

 	/*
 	 * We add the remaining bytes to our starting position on this page
-	 * and then add that value to the file offset of this log page
+	 * and then add that value to the file offset of this log page.
 	 */
 	return final_log_off + data_len + page_off;
 }
@@ -1473,11 +1469,11 @@ static int next_log_lsn(struct ntfs_log *log, const struct LFS_RECORD_HDR *rh,
 	u64 seq = this_lsn >> log->file_data_bits;
 	struct RECORD_PAGE_HDR *page = NULL;

-	/* Remember if we wrapped */
+	/* Remember if we wrapped. */
 	if (end <= vbo)
 		seq += 1;

-	/* log page header for this page */
+	/* Log page header for this page. */
 	err = read_log_page(log, hdr_off, &page, NULL);
 	if (err)
 		return err;
@@ -1485,11 +1481,11 @@ static int next_log_lsn(struct ntfs_log *log, const struct LFS_RECORD_HDR *rh,
 	/*
 	 * If the lsn we were given was not the last lsn on this page,
 	 * then the starting offset for the next lsn is on a quad word
-	 * boundary following the last file offset for the current lsn
-	 * Otherwise the file offset is the start of the data on the next page
+	 * boundary following the last file offset for the current lsn.
+	 * Otherwise the file offset is the start of the data on the next page.
 	 */
 	if (this_lsn == le64_to_cpu(page->rhdr.lsn)) {
-		/* If we wrapped, we need to increment the sequence number */
+		/* If we wrapped, we need to increment the sequence number. */
 		hdr_off = next_page_off(log, hdr_off);
 		if (hdr_off == log->first_page)
 			seq += 1;
@@ -1499,12 +1495,12 @@ static int next_log_lsn(struct ntfs_log *log, const struct LFS_RECORD_HDR *rh,
 		vbo = QuadAlign(end);
 	}

-	/* Compute the lsn based on the file offset and the sequence count */
+	/* Compute the lsn based on the file offset and the sequence count. */
 	*lsn = vbo_to_lsn(log, vbo, seq);

 	/*
-	 * If this lsn is within the legal range for the file, we return true
-	 * Otherwise false indicates that there are no more lsn's
+	 * If this lsn is within the legal range for the file, we return true.
+	 * Otherwise false indicates that there are no more lsn's.
 	 */
 	if (!is_lsn_in_file(log, *lsn))
 		*lsn = 0;
@@ -1515,44 +1511,42 @@ static int next_log_lsn(struct ntfs_log *log, const struct LFS_RECORD_HDR *rh,
 }

 /*
- * current_log_avail
- *
- * calculate the number of bytes available for log records
+ * current_log_avail - Calculate the number of bytes available for log records.
  */
 static u32 current_log_avail(struct ntfs_log *log)
 {
 	u32 oldest_off, next_free_off, free_bytes;

 	if (log->l_flags & NTFSLOG_NO_LAST_LSN) {
-		/* The entire file is available */
+		/* The entire file is available. */
 		return log->max_current_avail;
 	}

 	/*
 	 * If there is a last lsn the restart area then we know that we will
-	 * have to compute the free range
-	 * If there is no oldest lsn then start at the first page of the file
+	 * have to compute the free range.
+	 * If there is no oldest lsn then start at the first page of the file.
 	 */
 	oldest_off = (log->l_flags & NTFSLOG_NO_OLDEST_LSN)
 			     ? log->first_page
 			     : (log->oldest_lsn_off & ~log->sys_page_mask);

 	/*
-	 * We will use the next log page offset to compute the next free page\
-	 * If we are going to reuse this page go to the next page
-	 * If we are at the first page then use the end of the file
+	 * We will use the next log page offset to compute the next free page.
+	 * If we are going to reuse this page go to the next page.
+	 * If we are at the first page then use the end of the file.
 	 */
 	next_free_off = (log->l_flags & NTFSLOG_REUSE_TAIL)
 				? log->next_page + log->page_size
 			: log->next_page == log->first_page ? log->l_size
 							    : log->next_page;

-	/* If the two offsets are the same then there is no available space */
+	/* If the two offsets are the same then there is no available space. */
 	if (oldest_off == next_free_off)
 		return 0;
 	/*
 	 * If the free offset follows the oldest offset then subtract
-	 * this range from the total available pages
+	 * this range from the total available pages.
 	 */
 	free_bytes =
 		oldest_off < next_free_off
@@ -1576,13 +1570,13 @@ static bool check_subseq_log_page(struct ntfs_log *log,

 	/*
 	 * If the last lsn on the page occurs was written after the page
-	 * that caused the original error then we have a fatal error
+	 * that caused the original error then we have a fatal error.
 	 */
 	lsn_seq = lsn >> log->file_data_bits;

 	/*
 	 * If the sequence number for the lsn the page is equal or greater
-	 * than lsn we expect, then this is a subsequent write
+	 * than lsn we expect, then this is a subsequent write.
 	 */
 	return lsn_seq >= seq ||
 	       (lsn_seq == seq - 1 && log->first_page == vbo &&
@@ -1592,8 +1586,8 @@ static bool check_subseq_log_page(struct ntfs_log *log,
 /*
  * last_log_lsn
  *
- * This routine walks through the log pages for a file, searching for the
- * last log page written to the file
+ * Walks through the log pages for a file, searching for the
+ * last log page written to the file.
  */
 static int last_log_lsn(struct ntfs_log *log)
 {
@@ -1642,7 +1636,7 @@ static int last_log_lsn(struct ntfs_log *log)
 	}

 next_tail:
-	/* Read second tail page (at pos 3/0x12000) */
+	/* Read second tail page (at pos 3/0x12000). */
 	if (read_log_page(log, second_off, &second_tail, &usa_error) ||
 	    usa_error || second_tail->rhdr.sign != NTFS_RCRD_SIGNATURE) {
 		ntfs_free(second_tail);
@@ -1654,7 +1648,7 @@ static int last_log_lsn(struct ntfs_log *log)
 		lsn2 = le64_to_cpu(second_tail->record_hdr.last_end_lsn);
 	}

-	/* Read first tail page (at pos 2/0x2000 ) */
+	/* Read first tail page (at pos 2/0x2000). */
 	if (read_log_page(log, final_off, &first_tail, &usa_error) ||
 	    usa_error || first_tail->rhdr.sign != NTFS_RCRD_SIGNATURE) {
 		ntfs_free(first_tail);
@@ -1800,10 +1794,10 @@ static int last_log_lsn(struct ntfs_log *log)

 next_page:
 	tail_page = NULL;
-	/* Read the next log page */
+	/* Read the next log page. */
 	err = read_log_page(log, curpage_off, &page, &usa_error);

-	/* Compute the next log page offset the file */
+	/* Compute the next log page offset the file. */
 	nextpage_off = next_page_off(log, curpage_off);
 	wrapped = nextpage_off == log->first_page;

@@ -1882,14 +1876,14 @@ static int last_log_lsn(struct ntfs_log *log)

 	/*
 	 * If we are at the expected first page of a transfer check to see
-	 * if either tail copy is at this offset
+	 * if either tail copy is at this offset.
 	 * If this page is the last page of a transfer, check if we wrote
-	 * a subsequent tail copy
+	 * a subsequent tail copy.
 	 */
 	if (page_cnt == page_pos || page_cnt == page_pos + 1) {
 		/*
 		 * Check if the offset matches either the first or second
-		 * tail copy. It is possible it will match both
+		 * tail copy. It is possible it will match both.
 		 */
 		if (curpage_off == final_off)
 			tail_page = first_tail;
@@ -1911,32 +1905,35 @@ static int last_log_lsn(struct ntfs_log *log)

 use_tail_page:
 	if (tail_page) {
-		/* we have a candidate for a tail copy */
+		/* We have a candidate for a tail copy. */
 		lsn_cur = le64_to_cpu(tail_page->record_hdr.last_end_lsn);

 		if (last_ok_lsn < lsn_cur) {
 			/*
 			 * If the sequence number is not expected,
-			 * then don't use the tail copy
+			 * then don't use the tail copy.
 			 */
 			if (expected_seq != (lsn_cur >> log->file_data_bits))
 				tail_page = NULL;
 		} else if (last_ok_lsn > lsn_cur) {
 			/*
 			 * If the last lsn is greater than the one on
-			 * this page then forget this tail
+			 * this page then forget this tail.
 			 */
 			tail_page = NULL;
 		}
 	}

-	/* If we have an error on the current page, we will break of this loop */
+	/*
+	 *If we have an error on the current page,
+	 * we will break of this loop.
+	 */
 	if (err || usa_error)
 		goto check_tail;

 	/*
 	 * Done if the last lsn on this page doesn't match the previous known
-	 * last lsn or the sequence number is not expected
+	 * last lsn or the sequence number is not expected.
 	 */
 	lsn_cur = le64_to_cpu(page->rhdr.lsn);
 	if (last_ok_lsn != lsn_cur &&
@@ -1945,9 +1942,9 @@ static int last_log_lsn(struct ntfs_log *log)
 	}

 	/*
-	 * Check that the page position and page count values are correct
+	 * Check that the page position and page count values are correct.
 	 * If this is the first page of a transfer the position must be 1
-	 * and the count will be unknown
+	 * and the count will be unknown.
 	 */
 	if (page_cnt == page_pos) {
 		if (page->page_pos != cpu_to_le16(1) &&
@@ -1964,20 +1961,20 @@ static int last_log_lsn(struct ntfs_log *log)
 		   le16_to_cpu(page->page_pos) != page_pos + 1) {
 		/*
 		 * The page position better be 1 more than the last page
-		 * position and the page count better match
+		 * position and the page count better match.
 		 */
 		goto check_tail;
 	}

 	/*
 	 * We have a valid page the file and may have a valid page
-	 * the tail copy area
+	 * the tail copy area.
 	 * If the tail page was written after the page the file then
-	 * break of the loop
+	 * break of the loop.
 	 */
 	if (tail_page &&
 	    le64_to_cpu(tail_page->record_hdr.last_end_lsn) > lsn_cur) {
-		/* Remember if we will replace the page */
+		/* Remember if we will replace the page. */
 		replace_page = true;
 		goto check_tail;
 	}
@@ -1987,7 +1984,7 @@ static int last_log_lsn(struct ntfs_log *log)
 	if (is_log_record_end(page)) {
 		/*
 		 * Since we have read this page we know the sequence number
-		 * is the same as our expected value
+		 * is the same as our expected value.
 		 */
 		log->seq_num = expected_seq;
 		log->last_lsn = le64_to_cpu(page->record_hdr.last_end_lsn);
@@ -1996,7 +1993,7 @@ static int last_log_lsn(struct ntfs_log *log)

 		/*
 		 * If there is room on this page for another header then
-		 * remember we want to reuse the page
+		 * remember we want to reuse the page.
 		 */
 		if (log->record_header_len <=
 		    log->page_size -
@@ -2008,14 +2005,14 @@ static int last_log_lsn(struct ntfs_log *log)
 			log->next_page = nextpage_off;
 		}

-		/* Remember if we wrapped the log file */
+		/* Remember if we wrapped the log file. */
 		if (wrapped_file)
 			log->l_flags |= NTFSLOG_WRAPPED;
 	}

 	/*
 	 * Remember the last page count and position.
-	 * Also remember the last known lsn
+	 * Also remember the last known lsn.
 	 */
 	page_cnt = le16_to_cpu(page->page_count);
 	page_pos = le16_to_cpu(page->page_pos);
@@ -2056,19 +2053,19 @@ static int last_log_lsn(struct ntfs_log *log)
 			log->l_flags |= NTFSLOG_WRAPPED;
 	}

-	/* Remember that the partial IO will start at the next page */
+	/* Remember that the partial IO will start at the next page. */
 	second_off = nextpage_off;

 	/*
 	 * If the next page is the first page of the file then update
-	 * the sequence number for log records which begon the next page
+	 * the sequence number for log records which begon the next page.
 	 */
 	if (wrapped)
 		expected_seq += 1;

 	/*
 	 * If we have a tail copy or are performing single page I/O we can
-	 * immediately look at the next page
+	 * immediately look at the next page.
 	 */
 	if (replace_page || (log->ra->flags & RESTART_SINGLE_PAGE_IO)) {
 		page_cnt = 2;
@@ -2094,19 +2091,19 @@ static int last_log_lsn(struct ntfs_log *log)
 	ntfs_free(tst_page);
 	tst_page = NULL;

-	/* Walk through the file, reading log pages */
+	/* Walk through the file, reading log pages. */
 	err = read_log_page(log, nextpage_off, &tst_page, &usa_error);

 	/*
 	 * If we get a USA error then assume that we correctly found
-	 * the end of the original transfer
+	 * the end of the original transfer.
 	 */
 	if (usa_error)
 		goto file_is_valid;

 	/*
 	 * If we were able to read the page, we examine it to see if it
-	 * is the same or different Io block
+	 * is the same or different Io block.
 	 */
 	if (err)
 		goto next_test_page_1;
@@ -2137,7 +2134,7 @@ static int last_log_lsn(struct ntfs_log *log)
 		goto next_test_page;

 check_valid:
-	/* Skip over the remaining pages this transfer */
+	/* Skip over the remaining pages this transfer. */
 	remain_pages = page_cnt - page_pos - 1;
 	part_io_count += remain_pages;

@@ -2149,7 +2146,7 @@ static int last_log_lsn(struct ntfs_log *log)
 			expected_seq += 1;
 	}

-	/* Call our routine to check this log page */
+	/* Call our routine to check this log page. */
 	ntfs_free(tst_page);
 	tst_page = NULL;

@@ -2162,7 +2159,7 @@ static int last_log_lsn(struct ntfs_log *log)

 file_is_valid:

-	/* We have a valid file */
+	/* We have a valid file. */
 	if (page_off1 || tail_page) {
 		struct RECORD_PAGE_HDR *tmp_page;

@@ -2192,11 +2189,11 @@ static int last_log_lsn(struct ntfs_log *log)

 			/*
 			 * Correct page and copy the data from this page
-			 * into it and flush it to disk
+			 * into it and flush it to disk.
 			 */
 			memcpy(page, tmp_page, log->page_size);

-			/* Fill last flushed lsn value flush the page */
+			/* Fill last flushed lsn value flush the page. */
 			if (log->major_ver < 2)
 				page->rhdr.lsn = page->record_hdr.last_end_lsn;
 			else
@@ -2240,10 +2237,9 @@ static int last_log_lsn(struct ntfs_log *log)
 }

 /*
- * read_log_rec_buf
+ * read_log_rec_buf - Copy a log record from the file to a buffer.
  *
- * copies a log record from the file to a buffer
- * The log record may span several log pages and may even wrap the file
+ * The log record may span several log pages and may even wrap the file.
  */
 static int read_log_rec_buf(struct ntfs_log *log,
 			    const struct LFS_RECORD_HDR *rh, void *buffer)
@@ -2257,7 +2253,7 @@ static int read_log_rec_buf(struct ntfs_log *log,

 	/*
 	 * While there are more bytes to transfer,
-	 * we continue to attempt to perform the read
+	 * we continue to attempt to perform the read.
 	 */
 	for (;;) {
 		bool usa_error;
@@ -2274,7 +2270,7 @@ static int read_log_rec_buf(struct ntfs_log *log,

 		/*
 		 * The last lsn on this page better be greater or equal
-		 * to the lsn we are copying
+		 * to the lsn we are copying.
 		 */
 		if (lsn > le64_to_cpu(ph->rhdr.lsn)) {
 			err = -EINVAL;
@@ -2283,7 +2279,7 @@ static int read_log_rec_buf(struct ntfs_log *log,

 		memcpy(buffer, Add2Ptr(ph, off), tail);

-		/* If there are no more bytes to transfer, we exit the loop */
+		/* If there are no more bytes to transfer, we exit the loop. */
 		if (!data_len) {
 			if (!is_log_record_end(ph) ||
 			    lsn > le64_to_cpu(ph->record_hdr.last_end_lsn)) {
@@ -2303,8 +2299,8 @@ static int read_log_rec_buf(struct ntfs_log *log,
 		off = log->data_off;

 		/*
-		 * adjust our pointer the user's buffer to transfer
-		 * the next block to
+		 * Adjust our pointer the user's buffer to transfer
+		 * the next block to.
 		 */
 		buffer = Add2Ptr(buffer, tail);
 	}
@@ -2328,7 +2324,7 @@ static int read_rst_area(struct ntfs_log *log, struct NTFS_RESTART **rst_,
 	*lsn = 0;
 	*rst_ = NULL;

-	/* If the client doesn't have a restart area, go ahead and exit now */
+	/* If the client doesn't have a restart area, go ahead and exit now. */
 	if (!lsnc)
 		return 0;

@@ -2341,7 +2337,7 @@ static int read_rst_area(struct ntfs_log *log, struct NTFS_RESTART **rst_,
 	lsnr = le64_to_cpu(rh->this_lsn);

 	if (lsnc != lsnr) {
-		/* If the lsn values don't match, then the disk is corrupt */
+		/* If the lsn values don't match, then the disk is corrupt. */
 		err = -EINVAL;
 		goto out;
 	}
@@ -2365,7 +2361,7 @@ static int read_rst_area(struct ntfs_log *log, struct NTFS_RESTART **rst_,
 		goto out;
 	}

-	/* Copy the data into the 'rst' buffer */
+	/* Copy the data into the 'rst' buffer. */
 	err = read_log_rec_buf(log, rh, rst);
 	if (err)
 		goto out;
@@ -2386,7 +2382,7 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)
 	struct LFS_RECORD_HDR *rh = lcb->lrh;
 	u32 rec_len, len;

-	/* Read the record header for this lsn */
+	/* Read the record header for this lsn. */
 	if (!rh) {
 		err = read_log_page(log, lsn_to_vbo(log, lsn),
 				    (struct RECORD_PAGE_HDR **)&rh, NULL);
@@ -2398,7 +2394,7 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)

 	/*
 	 * If the lsn the log record doesn't match the desired
-	 * lsn then the disk is corrupt
+	 * lsn then the disk is corrupt.
 	 */
 	if (lsn != le64_to_cpu(rh->this_lsn))
 		return -EINVAL;
@@ -2406,8 +2402,8 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)
 	len = le32_to_cpu(rh->client_data_len);

 	/*
-	 * check that the length field isn't greater than the total
-	 * available space the log file
+	 * Check that the length field isn't greater than the total
+	 * available space the log file.
 	 */
 	rec_len = len + log->record_header_len;
 	if (rec_len >= log->total_avail)
@@ -2415,7 +2411,7 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)

 	/*
 	 * If the entire log record is on this log page,
-	 * put a pointer to the log record the context block
+	 * put a pointer to the log record the context block.
 	 */
 	if (rh->flags & LOG_RECORD_MULTI_PAGE) {
 		void *lr = ntfs_malloc(len);
@@ -2426,12 +2422,12 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)
 		lcb->log_rec = lr;
 		lcb->alloc = true;

-		/* Copy the data into the buffer returned */
+		/* Copy the data into the buffer returned. */
 		err = read_log_rec_buf(log, rh, lr);
 		if (err)
 			return err;
 	} else {
-		/* If beyond the end of the current page -> an error */
+		/* If beyond the end of the current page -> an error. */
 		u32 page_off = lsn_to_page_off(log, lsn);

 		if (page_off + len + log->record_header_len > log->page_size)
@@ -2445,9 +2441,7 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)
 }

 /*
- * read_log_rec_lcb
- *
- * initiates the query operation.
+ * read_log_rec_lcb - Init the query operation.
  */
 static int read_log_rec_lcb(struct ntfs_log *log, u64 lsn, u32 ctx_mode,
 			    struct lcb **lcb_)
@@ -2465,7 +2459,7 @@ static int read_log_rec_lcb(struct ntfs_log *log, u64 lsn, u32 ctx_mode,
 		return -EINVAL;
 	}

-	/* check that the given lsn is the legal range for this client */
+	/* Check that the given lsn is the legal range for this client. */
 	cr = Add2Ptr(log->ra, le16_to_cpu(log->ra->client_off));

 	if (!verify_client_lsn(log, cr, lsn))
@@ -2477,7 +2471,7 @@ static int read_log_rec_lcb(struct ntfs_log *log, u64 lsn, u32 ctx_mode,
 	lcb->client = log->client_id;
 	lcb->ctx_mode = ctx_mode;

-	/* Find the log record indicated by the given lsn */
+	/* Find the log record indicated by the given lsn. */
 	err = find_log_rec(log, lsn, lcb);
 	if (err)
 		goto out;
@@ -2494,7 +2488,7 @@ static int read_log_rec_lcb(struct ntfs_log *log, u64 lsn, u32 ctx_mode,
 /*
  * find_client_next_lsn
  *
- * attempt to find the next lsn to return to a client based on the context mode.
+ * Attempt to find the next lsn to return to a client based on the context mode.
  */
 static int find_client_next_lsn(struct ntfs_log *log, struct lcb *lcb, u64 *lsn)
 {
@@ -2508,7 +2502,7 @@ static int find_client_next_lsn(struct ntfs_log *log, struct lcb *lcb, u64 *lsn)
 	if (lcb_ctx_next != lcb->ctx_mode)
 		goto check_undo_next;

-	/* Loop as long as another lsn can be found */
+	/* Loop as long as another lsn can be found. */
 	for (;;) {
 		u64 current_lsn;

@@ -2694,7 +2688,7 @@ static inline bool check_attr(const struct MFT_REC *rec,
 	u64 dsize, svcn, evcn;
 	u16 run_off;

-	/* Check the fixed part of the attribute record header */
+	/* Check the fixed part of the attribute record header. */
 	if (asize >= sbi->record_size ||
 	    asize + PtrOffset(rec, attr) >= sbi->record_size ||
 	    (attr->name_len &&
@@ -2703,7 +2697,7 @@ static inline bool check_attr(const struct MFT_REC *rec,
 		return false;
 	}

-	/* Check the attribute fields */
+	/* Check the attribute fields. */
 	switch (attr->non_res) {
 	case 0:
 		rsize = le32_to_cpu(attr->res.data_size);
@@ -2786,7 +2780,7 @@ static inline bool check_file_record(const struct MFT_REC *rec,
 	u16 ao = le16_to_cpu(rec->attr_off);
 	u32 rs = sbi->record_size;

-	/* check the file record header for consistency */
+	/* Check the file record header for consistency. */
 	if (rec->rhdr.sign != NTFS_FILE_SIGNATURE ||
 	    fo > (SECTOR_SIZE - ((rs >> SECTOR_SHIFT) + 1) * sizeof(short)) ||
 	    (fn - 1) * SECTOR_SIZE != rs || ao < MFTRECORD_FIXUP_OFFSET_1 ||
@@ -2795,7 +2789,7 @@ static inline bool check_file_record(const struct MFT_REC *rec,
 		return false;
 	}

-	/* Loop to check all of the attributes */
+	/* Loop to check all of the attributes. */
 	for (attr = Add2Ptr(rec, ao); attr->type != ATTR_END;
 	     attr = Add2Ptr(attr, le32_to_cpu(attr->size))) {
 		if (check_attr(rec, attr, sbi))
@@ -2948,7 +2942,11 @@ struct OpenAttr {
 	// CLST rno;
 };

-/* Returns 0 if 'attr' has the same type and name */
+/*
+ * cmp_type_and_name
+ *
+ * Return: 0 if 'attr' has the same type and name.
+ */
 static inline int cmp_type_and_name(const struct ATTRIB *a1,
 				    const struct ATTRIB *a2)
 {
@@ -3021,10 +3019,8 @@ static struct ATTRIB *attr_create_nonres_log(struct ntfs_sb_info *sbi,
 }

 /*
- * do_action
- *
- * common routine for the Redo and Undo Passes
- * If rlsn is NULL then undo
+ * do_action - Common routine for the Redo and Undo Passes.
+ * @rlsn: If it is NULL then undo.
  */
 static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		     const struct LOG_REC_HDR *lrh, u32 op, void *data,
@@ -3061,10 +3057,10 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,

 	oa = oe->ptr;

-	/* Big switch to prepare */
+	/* Big switch to prepare. */
 	switch (op) {
 	/* ============================================================
-	 * Process MFT records, as described by the current log record
+	 * Process MFT records, as described by the current log record.
 	 * ============================================================
 	 */
 	case InitializeFileRecordSegment:
@@ -3093,7 +3089,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			if (err)
 				goto out;
 		} else {
-			/* read from disk */
+			/* Read from disk. */
 			err = mi_get(sbi, rno, &mi);
 			if (err)
 				return err;
@@ -3150,9 +3146,8 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		inode_parent = NULL;
 		break;

-	/* ============================================================
-	 * Process attributes, as described by the current log record
-	 * ============================================================
+	/*
+	 * Process attributes, as described by the current log record.
 	 */
 	case UpdateNonresidentValue:
 	case AddIndexEntryAllocation:
@@ -3197,7 +3192,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		WARN_ON(1);
 	}

-	/* Big switch to do operation */
+	/* Big switch to do operation. */
 	switch (op) {
 	case InitializeFileRecordSegment:
 		if (roff + dlen > record_size)
@@ -3300,7 +3295,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,

 		if (nsize < asize) {
 			memmove(Add2Ptr(attr, aoff), data, dlen);
-			data = NULL; // To skip below memmove
+			data = NULL; // To skip below memmove().
 		}

 		memmove(Add2Ptr(attr, nsize), Add2Ptr(attr, asize),
@@ -3723,11 +3718,11 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 }

 /*
- * log_replay
+ * log_replay - Replays log and empties it.
  *
- * this function is called during mount operation
- * it replays log and empties it
- * initialized is set false if logfile contains '-1'
+ * This function is called during mount operation.
+ * It replays log and empties it.
+ * Initialized is set false if logfile contains '-1'.
  */
 int log_replay(struct ntfs_inode *ni, bool *initialized)
 {
@@ -3773,7 +3768,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	u16 t16;
 	u32 t32;

-	/* Get the size of page. NOTE: To replay we can use default page */
+	/* Get the size of page. NOTE: To replay we can use default page. */
 #if PAGE_SIZE >= DefaultLogPageSize && PAGE_SIZE <= DefaultLogPageSize * 2
 	page_size = norm_file_page(PAGE_SIZE, &l_size, true);
 #else
@@ -3799,7 +3794,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	log->page_mask = page_size - 1;
 	log->page_bits = blksize_bits(page_size);

-	/* Look for a restart area on the disk */
+	/* Look for a restart area on the disk. */
 	err = log_read_rst(log, l_size, true, &rst_info);
 	if (err)
 		goto out;
@@ -3809,7 +3804,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	if (!rst_info.restart) {
 		if (rst_info.initialized) {
-			/* no restart area but the file is not initialized */
+			/* No restart area but the file is not initialized. */
 			err = -EINVAL;
 			goto out;
 		}
@@ -3832,14 +3827,14 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	/*
 	 * If the restart offset above wasn't zero then we won't
-	 * look for a second restart
+	 * look for a second restart.
 	 */
 	if (rst_info.vbo)
 		goto check_restart_area;

 	err = log_read_rst(log, l_size, false, &rst_info2);

-	/* Determine which restart area to use */
+	/* Determine which restart area to use. */
 	if (!rst_info2.restart || rst_info2.last_lsn <= rst_info.last_lsn)
 		goto use_first_page;

@@ -3866,10 +3861,13 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	ntfs_free(rst_info2.r_page);

 check_restart_area:
-	/* If the restart area is at offset 0, we want to write the second restart area first */
+	/*
+	 * If the restart area is at offset 0, we want
+	 * to write the second restart area first.
+	 */
 	log->init_ra = !!rst_info.vbo;

-	/* If we have a valid page then grab a pointer to the restart area */
+	/* If we have a valid page then grab a pointer to the restart area. */
 	ra2 = rst_info.valid_page
 		      ? Add2Ptr(rst_info.r_page,
 				le16_to_cpu(rst_info.r_page->ra_off))
@@ -3881,7 +3879,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		bool use_multi_page = false;
 		u32 open_log_count;

-		/* Do some checks based on whether we have a valid log page */
+		/* Do some checks based on whether we have a valid log page. */
 		if (!rst_info.valid_page) {
 			open_log_count = get_random_int();
 			goto init_log_instance;
@@ -3890,7 +3888,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 		/*
 		 * If the restart page size isn't changing then we want to
-		 * check how much work we need to do
+		 * check how much work we need to do.
 		 */
 		if (page_size != le32_to_cpu(rst_info.r_page->sys_page_size))
 			goto init_log_instance;
@@ -3908,7 +3906,9 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		}
 		log->ra = ra;

-		/* Put the restart areas and initialize the log file as required */
+		/* Put the restart areas and initialize
+		 * the log file as required.
+		 */
 		goto process_log;
 	}

@@ -3918,9 +3918,9 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	}

 	/*
-	 * If the log page or the system page sizes have changed, we can't use the log file
-	 * We must use the system page size instead of the default size
-	 * if there is not a clean shutdown
+	 * If the log page or the system page sizes have changed, we can't
+	 * use the log file. We must use the system page size instead of the
+	 * default size if there is not a clean shutdown.
 	 */
 	t32 = le32_to_cpu(rst_info.r_page->sys_page_size);
 	if (page_size != t32) {
@@ -3935,7 +3935,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}

-	/* If the file size has shrunk then we won't mount it */
+	/* If the file size has shrunk then we won't mount it. */
 	if (l_size < le64_to_cpu(ra2->l_size)) {
 		err = -EINVAL;
 		goto out;
@@ -3962,27 +3962,30 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	vbo = lsn_to_vbo(log, log->last_lsn);

 	if (vbo < log->first_page) {
-		/* This is a pseudo lsn */
+		/* This is a pseudo lsn. */
 		log->l_flags |= NTFSLOG_NO_LAST_LSN;
 		log->next_page = log->first_page;
 		goto find_oldest;
 	}

-	/* Find the end of this log record */
+	/* Find the end of this log record. */
 	off = final_log_off(log, log->last_lsn,
 			    le32_to_cpu(ra2->last_lsn_data_len));

-	/* If we wrapped the file then increment the sequence number */
+	/* If we wrapped the file then increment the sequence number. */
 	if (off <= vbo) {
 		log->seq_num += 1;
 		log->l_flags |= NTFSLOG_WRAPPED;
 	}

-	/* Now compute the next log page to use */
+	/* Now compute the next log page to use. */
 	vbo &= ~log->sys_page_mask;
 	tail = log->page_size - (off & log->page_mask) - 1;

-	/* If we can fit another log record on the page, move back a page the log file */
+	/*
+	 *If we can fit another log record on the page,
+	 * move back a page the log file.
+	 */
 	if (tail >= log->record_header_len) {
 		log->l_flags |= NTFSLOG_REUSE_TAIL;
 		log->next_page = vbo;
@@ -3991,7 +3994,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	}

 find_oldest:
-	/* Find the oldest client lsn. Use the last flushed lsn as a starting point */
+	/*
+	 * Find the oldest client lsn. Use the last
+	 * flushed lsn as a starting point.
+	 */
 	log->oldest_lsn = log->last_lsn;
 	oldest_client_lsn(Add2Ptr(ra2, le16_to_cpu(ra2->client_off)),
 			  ra2->client_idx[1], &log->oldest_lsn);
@@ -4037,18 +4043,18 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	le32_add_cpu(&ra->open_log_count, 1);

-	/* Now we need to walk through looking for the last lsn */
+	/* Now we need to walk through looking for the last lsn. */
 	err = last_log_lsn(log);
 	if (err)
 		goto out;

 	log->current_avail = current_log_avail(log);

-	/* Remember which restart area to write first */
+	/* Remember which restart area to write first. */
 	log->init_ra = rst_info.vbo;

 process_log:
-	/* 1.0, 1.1, 2.0 log->major_ver/minor_ver - short values */
+	/* 1.0, 1.1, 2.0 log->major_ver/minor_ver - short values. */
 	switch ((log->major_ver << 16) + log->minor_ver) {
 	case 0x10000:
 	case 0x10001:
@@ -4062,12 +4068,12 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}

-	/* One client "NTFS" per logfile */
+	/* One client "NTFS" per logfile. */
 	ca = Add2Ptr(ra, le16_to_cpu(ra->client_off));

 	for (client = ra->client_idx[1];; client = cr->next_client) {
 		if (client == LFS_NO_CLIENT_LE) {
-			/* Insert "NTFS" client LogFile */
+			/* Insert "NTFS" client LogFile. */
 			client = ra->client_idx[0];
 			if (client == LFS_NO_CLIENT_LE)
 				return -EINVAL;
@@ -4099,7 +4105,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 			break;
 	}

-	/* Update the client handle with the client block information */
+	/* Update the client handle with the client block information. */
 	log->client_id.seq_num = cr->seq_num;
 	log->client_id.client_idx = client;

@@ -4116,7 +4122,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (!checkpt_lsn)
 		checkpt_lsn = ra_lsn;

-	/* Allocate and Read the Transaction Table */
+	/* Allocate and Read the Transaction Table. */
 	if (!rst->transact_table_len)
 		goto check_dirty_page_table;

@@ -4140,7 +4146,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	rt = Add2Ptr(lrh, t16);
 	t32 = rec_len - t16;

-	/* Now check that this is a valid restart table */
+	/* Now check that this is a valid restart table. */
 	if (!check_rstbl(rt, t32)) {
 		err = -EINVAL;
 		goto out;
@@ -4156,7 +4162,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	lcb = NULL;

 check_dirty_page_table:
-	/* The next record back should be the Dirty Pages Table */
+	/* The next record back should be the Dirty Pages Table. */
 	if (!rst->dirty_pages_len)
 		goto check_attribute_names;

@@ -4180,7 +4186,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	rt = Add2Ptr(lrh, t16);
 	t32 = rec_len - t16;

-	/* Now check that this is a valid restart table */
+	/* Now check that this is a valid restart table. */
 	if (!check_rstbl(rt, t32)) {
 		err = -EINVAL;
 		goto out;
@@ -4192,14 +4198,14 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}

-	/* Convert Ra version '0' into version '1' */
+	/* Convert Ra version '0' into version '1'. */
 	if (rst->major_ver)
 		goto end_conv_1;

 	dp = NULL;
 	while ((dp = enum_rstbl(dptbl, dp))) {
 		struct DIR_PAGE_ENTRY_32 *dp0 = (struct DIR_PAGE_ENTRY_32 *)dp;
-		// NOTE: Danger. Check for of boundary
+		// NOTE: Danger. Check for of boundary.
 		memmove(&dp->vcn, &dp0->vcn_low,
 			2 * sizeof(u64) +
 				le32_to_cpu(dp->lcns_follow) * sizeof(u64));
@@ -4209,7 +4215,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	lcb_put(lcb);
 	lcb = NULL;

-	/* Go through the table and remove the duplicates, remembering the oldest lsn values */
+	/*
+	 * Go through the table and remove the duplicates,
+	 * remembering the oldest lsn values.
+	 */
 	if (sbi->cluster_size <= log->page_size)
 		goto trace_dp_table;

@@ -4231,7 +4240,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	}
 trace_dp_table:
 check_attribute_names:
-	/* The next record should be the Attribute Names */
+	/* The next record should be the Attribute Names. */
 	if (!rst->attr_names_len)
 		goto check_attr_table;

@@ -4259,7 +4268,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	lcb = NULL;

 check_attr_table:
-	/* The next record should be the attribute Table */
+	/* The next record should be the attribute Table. */
 	if (!rst->open_attr_len)
 		goto check_attribute_names2;

@@ -4296,13 +4305,13 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	log->open_attr_tbl = oatbl;

-	/* Clear all of the Attr pointers */
+	/* Clear all of the Attr pointers. */
 	oe = NULL;
 	while ((oe = enum_rstbl(oatbl, oe))) {
 		if (!rst->major_ver) {
 			struct OPEN_ATTR_ENRTY_32 oe0;

-			/* Really 'oe' points to OPEN_ATTR_ENRTY_32 */
+			/* Really 'oe' points to OPEN_ATTR_ENRTY_32. */
 			memcpy(&oe0, oe, SIZEOF_OPENATTRIBUTEENTRY0);

 			oe->bytes_per_index = oe0.bytes_per_index;
@@ -4340,7 +4349,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 trace_attribute_table:
 	/*
 	 * If the checkpt_lsn is zero, then this is a freshly
-	 * formatted disk and we have no work to do
+	 * formatted disk and we have no work to do.
 	 */
 	if (!checkpt_lsn) {
 		err = 0;
@@ -4360,12 +4369,12 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	/* Start the analysis pass from the Checkpoint lsn. */
 	rec_lsn = checkpt_lsn;

-	/* Read the first lsn */
+	/* Read the first lsn. */
 	err = read_log_rec_lcb(log, checkpt_lsn, lcb_ctx_next, &lcb);
 	if (err)
 		goto out;

-	/* Loop to read all subsequent records to the end of the log file */
+	/* Loop to read all subsequent records to the end of the log file. */
 next_log_record_analyze:
 	err = read_next_log_rec(log, lcb, &rec_lsn);
 	if (err)
@@ -4386,7 +4395,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	/*
 	 * The first lsn after the previous lsn remembered
-	 * the checkpoint is the first candidate for the rlsn
+	 * the checkpoint is the first candidate for the rlsn.
 	 */
 	if (!rlsn)
 		rlsn = rec_lsn;
@@ -4395,8 +4404,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto next_log_record_analyze;

 	/*
-	 * Now update the Transaction Table for this transaction
-	 * If there is no entry present or it is unallocated we allocate the entry
+	 * Now update the Transaction Table for this transaction. If there
+	 * is no entry present or it is unallocated we allocate the entry.
 	 */
 	if (!trtbl) {
 		trtbl = init_rsttbl(sizeof(struct TRANSACTION_ENTRY),
@@ -4424,12 +4433,12 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	/*
 	 * If this is a compensation log record, then change
-	 * the undo_next_lsn to be the undo_next_lsn of this record
+	 * the undo_next_lsn to be the undo_next_lsn of this record.
 	 */
 	if (lrh->undo_op == cpu_to_le16(CompensationLogRecord))
 		tr->undo_next_lsn = frh->client_undo_next_lsn;

-	/* Dispatch to handle log record depending on type */
+	/* Dispatch to handle log record depending on type. */
 	switch (le16_to_cpu(lrh->redo_op)) {
 	case InitializeFileRecordSegment:
 	case DeallocateFileRecordSegment:
@@ -4463,7 +4472,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 		/*
 		 * Calculate the number of clusters per page the system
-		 * which wrote the checkpoint, possibly creating the table
+		 * which wrote the checkpoint, possibly creating the table.
 		 */
 		if (dptbl) {
 			t32 = (le16_to_cpu(dptbl->size) -
@@ -4489,9 +4498,9 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 copy_lcns:
 		/*
-		 * Copy the Lcns from the log record into the Dirty Page Entry
-		 * TODO: for different page size support, must somehow make
-		 * whole routine a loop, case Lcns do not fit below
+		 * Copy the Lcns from the log record into the Dirty Page Entry.
+		 * TODO: For different page size support, must somehow make
+		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
 		for (i = 0; i < t16; i++) {
@@ -4508,7 +4517,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		const struct LCN_RANGE *r =
 			Add2Ptr(lrh, le16_to_cpu(lrh->redo_off));

-		/* Loop through all of the Lcn ranges this log record */
+		/* Loop through all of the Lcn ranges this log record. */
 		for (i = 0; i < range_count; i++, r++) {
 			u64 lcn0 = le64_to_cpu(r->lcn);
 			u64 lcn_e = lcn0 + le64_to_cpu(r->len) - 1;
@@ -4534,7 +4543,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		if (t16 >= bytes_per_rt(oatbl)) {
 			/*
 			 * Compute how big the table needs to be.
-			 * Add 10 extra entries for some cushion
+			 * Add 10 extra entries for some cushion.
 			 */
 			u32 new_e = t16 / le16_to_cpu(oatbl->size);

@@ -4548,7 +4557,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 			}
 		}

-		/* Point to the entry being opened */
+		/* Point to the entry being opened. */
 		oe = alloc_rsttbl_from_idx(&oatbl, t16);
 		log->open_attr_tbl = oatbl;
 		if (!oe) {
@@ -4556,10 +4565,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 			goto out;
 		}

-		/* Initialize this entry from the log record */
+		/* Initialize this entry from the log record. */
 		t16 = le16_to_cpu(lrh->redo_off);
 		if (!rst->major_ver) {
-			/* Convert version '0' into version '1' */
+			/* Convert version '0' into version '1'. */
 			struct OPEN_ATTR_ENRTY_32 *oe0 = Add2Ptr(lrh, t16);

 			oe->bytes_per_index = oe0->bytes_per_index;
@@ -4627,13 +4636,13 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	case AttributeNamesDump:
 	case DirtyPageTableDump:
 	case TransactionTableDump:
-		/* The following cases require no action the Analysis Pass */
+		/* The following cases require no action the Analysis Pass. */
 		goto next_log_record_analyze;

 	default:
 		/*
 		 * All codes will be explicitly handled.
-		 * If we see a code we do not expect, then we are trouble
+		 * If we see a code we do not expect, then we are trouble.
 		 */
 		goto next_log_record_analyze;
 	}
@@ -4644,7 +4653,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	/*
 	 * Scan the Dirty Page Table and Transaction Table for
-	 * the lowest lsn, and return it as the Redo lsn
+	 * the lowest lsn, and return it as the Redo lsn.
 	 */
 	dp = NULL;
 	while ((dp = enum_rstbl(dptbl, dp))) {
@@ -4660,7 +4669,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 			rlsn = t64;
 	}

-	/* Only proceed if the Dirty Page Table or Transaction table are not empty */
+	/*
+	 * Only proceed if the Dirty Page Table or Transaction
+	 * table are not empty.
+	 */
 	if ((!dptbl || !dptbl->total) && (!trtbl || !trtbl->total))
 		goto end_reply;

@@ -4668,7 +4680,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (is_ro)
 		goto out;

-	/* Reopen all of the attributes with dirty pages */
+	/* Reopen all of the attributes with dirty pages. */
 	oe = NULL;
 next_open_attribute:

@@ -4764,8 +4776,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	goto next_open_attribute;

 	/*
-	 * Now loop through the dirty page table to extract all of the Vcn/Lcn
-	 * Mapping that we have, and insert it into the appropriate run
+	 * Now loop through the dirty page table to extract all of the Vcn/Lcn.
+	 * Mapping that we have, and insert it into the appropriate run.
 	 */
 next_dirty_page:
 	dp = enum_rstbl(dptbl, dp);
@@ -4819,8 +4831,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 do_redo_1:
 	/*
 	 * Perform the Redo Pass, to restore all of the dirty pages to the same
-	 * contents that they had immediately before the crash
-	 * If the dirty page table is empty, then we can skip the entire Redo Pass
+	 * contents that they had immediately before the crash. If the dirty
+	 * page table is empty, then we can skip the entire Redo Pass.
 	 */
 	if (!dptbl || !dptbl->total)
 		goto do_undo_action;
@@ -4829,15 +4841,15 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	/*
 	 * Read the record at the Redo lsn, before falling
-	 * into common code to handle each record
+	 * into common code to handle each record.
 	 */
 	err = read_log_rec_lcb(log, rlsn, lcb_ctx_next, &lcb);
 	if (err)
 		goto out;

 	/*
-	 * Now loop to read all of our log records forwards,
-	 * until we hit the end of the file, cleaning up at the end
+	 * Now loop to read all of our log records forwards, until
+	 * we hit the end of the file, cleaning up at the end.
 	 */
 do_action_next:
 	frh = lcb->lrh;
@@ -4854,7 +4866,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}

-	/* Ignore log records that do not update pages */
+	/* Ignore log records that do not update pages. */
 	if (lrh->lcns_follow)
 		goto find_dirty_page;

@@ -4899,11 +4911,11 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto read_next_log_do_action;
 	}

-	/* Point to the Redo data and get its length */
+	/* Point to the Redo data and get its length. */
 	data = Add2Ptr(lrh, le16_to_cpu(lrh->redo_off));
 	dlen = le16_to_cpu(lrh->redo_len);

-	/* Shorten length by any Lcns which were deleted */
+	/* Shorten length by any Lcns which were deleted. */
 	saved_len = dlen;

 	for (i = le16_to_cpu(lrh->lcns_follow); i; i--) {
@@ -4914,7 +4926,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		       le16_to_cpu(lrh->attr_off);
 		voff += le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;

-		/* If the Vcn question is allocated, we can just get out.*/
+		/* If the Vcn question is allocated, we can just get out. */
 		j = le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn);
 		if (dp->page_lcns[j + i - 1])
 			break;
@@ -4924,13 +4936,13 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 		/*
 		 * Calculate the allocated space left relative to the
-		 * log record Vcn, after removing this unallocated Vcn
+		 * log record Vcn, after removing this unallocated Vcn.
 		 */
 		alen = (i - 1) << sbi->cluster_bits;

 		/*
 		 * If the update described this log record goes beyond
-		 * the allocated space, then we will have to reduce the length
+		 * the allocated space, then we will have to reduce the length.
 		 */
 		if (voff >= alen)
 			dlen = 0;
@@ -4938,7 +4950,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 			dlen = alen - voff;
 	}

-	/* If the resulting dlen from above is now zero, we can skip this log record */
+	/*
+	 * If the resulting dlen from above is now zero,
+	 * we can skip this log record.
+	 */
 	if (!dlen && saved_len)
 		goto read_next_log_do_action;

@@ -4946,12 +4961,12 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (can_skip_action(t16))
 		goto read_next_log_do_action;

-	/* Apply the Redo operation a common routine */
+	/* Apply the Redo operation a common routine. */
 	err = do_action(log, oe, lrh, t16, data, dlen, rec_len, &rec_lsn);
 	if (err)
 		goto out;

-	/* Keep reading and looping back until end of file */
+	/* Keep reading and looping back until end of file. */
 read_next_log_do_action:
 	err = read_next_log_rec(log, lcb, &rec_lsn);
 	if (!err && rec_lsn)
@@ -4961,7 +4976,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	lcb = NULL;

 do_undo_action:
-	/* Scan Transaction Table */
+	/* Scan Transaction Table. */
 	tr = NULL;
 transaction_table_next:
 	tr = enum_rstbl(trtbl, tr);
@@ -4978,19 +4993,19 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)

 	/*
 	 * We only have to do anything if the transaction has
-	 * something its undo_next_lsn field
+	 * something its undo_next_lsn field.
 	 */
 	if (!undo_next_lsn)
 		goto commit_undo;

-	/* Read the first record to be undone by this transaction */
+	/* Read the first record to be undone by this transaction. */
 	err = read_log_rec_lcb(log, undo_next_lsn, lcb_ctx_undo_next, &lcb);
 	if (err)
 		goto out;

 	/*
 	 * Now loop to read all of our log records forwards,
-	 * until we hit the end of the file, cleaning up at the end
+	 * until we hit the end of the file, cleaning up at the end.
 	 */
 undo_action_next:

@@ -5020,7 +5035,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	/*
 	 * If the mapping isn't already the table or the  mapping
 	 * corresponds to a hole the mapping, we need to make sure
-	 * there is no partial page already memory
+	 * there is no partial page already memory.
 	 */
 	if (is_mapped && lcn != SPARSE_LCN && clen >= t16)
 		goto add_allocated_vcns;
@@ -5048,17 +5063,17 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (can_skip_action(t16))
 		goto read_next_log_undo_action;

-	/* Point to the Redo data and get its length */
+	/* Point to the Redo data and get its length. */
 	data = Add2Ptr(lrh, le16_to_cpu(lrh->undo_off));
 	dlen = le16_to_cpu(lrh->undo_len);

-	/* it is time to apply the undo action */
+	/* It is time to apply the undo action. */
 	err = do_action(log, oe, lrh, t16, data, dlen, rec_len, NULL);

 read_next_log_undo_action:
 	/*
 	 * Keep reading and looping back until we have read the
-	 * last record for this transaction
+	 * last record for this transaction.
 	 */
 	err = read_next_log_rec(log, lcb, &rec_lsn);
 	if (err)
@@ -5133,7 +5148,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	if (lcb)
 		lcb_put(lcb);

-	/* Scan the Open Attribute Table to close all of the open attributes */
+	/*
+	 * Scan the Open Attribute Table to close all of
+	 * the open attributes.
+	 */
 	oe = NULL;
 	while ((oe = enum_rstbl(oatbl, oe))) {
 		rno = ino_get(&oe->ref);
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 327356b08187..689bb4ff602b 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -101,9 +101,7 @@ const __le16 WOF_NAME[17] = {
 // clang-format on

 /*
- * ntfs_fix_pre_write
- *
- * inserts fixups into 'rhdr' before writing to disk
+ * ntfs_fix_pre_write - Insert fixups into @rhdr before writing to disk.
  */
 bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes)
 {
@@ -117,7 +115,7 @@ bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes)
 		return false;
 	}

-	/* Get fixup pointer */
+	/* Get fixup pointer. */
 	fixup = Add2Ptr(rhdr, fo);

 	if (*fixup >= 0x7FFF)
@@ -138,10 +136,9 @@ bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes)
 }

 /*
- * ntfs_fix_post_read
+ * ntfs_fix_post_read - Remove fixups after reading from disk.
  *
- * remove fixups after reading from disk
- * Returns < 0 if error, 0 if ok, 1 if need to update fixups
+ * Return: < 0 if error, 0 if ok, 1 if need to update fixups.
  */
 int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 		       bool simple)
@@ -154,26 +151,26 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 	fn = simple ? ((bytes >> SECTOR_SHIFT) + 1)
 		    : le16_to_cpu(rhdr->fix_num);

-	/* Check errors */
+	/* Check errors. */
 	if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
 	    fn * SECTOR_SIZE > bytes) {
-		return -EINVAL; /* native chkntfs returns ok! */
+		return -EINVAL; /* Native chkntfs returns ok! */
 	}

-	/* Get fixup pointer */
+	/* Get fixup pointer. */
 	fixup = Add2Ptr(rhdr, fo);
 	sample = *fixup;
 	ptr = Add2Ptr(rhdr, SECTOR_SIZE - sizeof(short));
 	ret = 0;

 	while (fn--) {
-		/* Test current word */
+		/* Test current word. */
 		if (*ptr != sample) {
 			/* Fixup does not match! Is it serious error? */
 			ret = -E_NTFS_FIXUP;
 		}

-		/* Replace fixup */
+		/* Replace fixup. */
 		*ptr = *++fixup;
 		ptr += SECTOR_SIZE / sizeof(short);
 	}
@@ -182,9 +179,7 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 }

 /*
- * ntfs_extend_init
- *
- * loads $Extend file
+ * ntfs_extend_init - Load $Extend file.
  */
 int ntfs_extend_init(struct ntfs_sb_info *sbi)
 {
@@ -209,7 +204,7 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
 		goto out;
 	}

-	/* if ntfs_iget5 reads from disk it never returns bad inode */
+	/* If ntfs_iget5() reads from disk it never returns bad inode. */
 	if (!S_ISDIR(inode->i_mode)) {
 		err = -EINVAL;
 		goto out;
@@ -261,7 +256,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 	struct MFT_REF ref;
 	struct inode *inode;

-	/* Check for 4GB */
+	/* Check for 4GB. */
 	if (ni->vfs_inode.i_size >= 0x100000000ull) {
 		ntfs_err(sb, "\x24LogFile is too big");
 		err = -EINVAL;
@@ -280,7 +275,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 		inode = NULL;

 	if (!inode) {
-		/* Try to use mft copy */
+		/* Try to use MFT copy. */
 		u64 t64 = sbi->mft.lbo;

 		sbi->mft.lbo = sbi->mft.lbo2;
@@ -298,7 +293,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)

 	sbi->mft.ni = ntfs_i(inode);

-	/* LogFile should not contains attribute list */
+	/* LogFile should not contains attribute list. */
 	err = ni_load_all_mi(sbi->mft.ni);
 	if (!err)
 		err = log_replay(ni, &initialized);
@@ -317,7 +312,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 	if (sb_rdonly(sb) || !initialized)
 		goto out;

-	/* fill LogFile by '-1' if it is initialized */
+	/* Fill LogFile by '-1' if it is initialized.ssss */
 	err = ntfs_bio_fill_1(sbi, &ni->file.run);

 out:
@@ -329,7 +324,7 @@ int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi)
 /*
  * ntfs_query_def
  *
- * returns current ATTR_DEF_ENTRY for given attribute type
+ * Return: Current ATTR_DEF_ENTRY for given attribute type.
  */
 const struct ATTR_DEF_ENTRY *ntfs_query_def(struct ntfs_sb_info *sbi,
 					    enum ATTR_TYPE type)
@@ -356,9 +351,7 @@ const struct ATTR_DEF_ENTRY *ntfs_query_def(struct ntfs_sb_info *sbi,
 }

 /*
- * ntfs_look_for_free_space
- *
- * looks for a free space in bitmap
+ * ntfs_look_for_free_space - Look for a free space in bitmap.
  */
 int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 			     CLST *new_lcn, CLST *new_len,
@@ -406,7 +399,7 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,

 	/*
 	 * 'Cause cluster 0 is always used this value means that we should use
-	 * cached value of 'next_free_lcn' to improve performance
+	 * cached value of 'next_free_lcn' to improve performance.
 	 */
 	if (!lcn)
 		lcn = sbi->used.next_free_lcn;
@@ -420,18 +413,18 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 		goto ok;
 	}

-	/* Try to use clusters from MftZone */
+	/* Try to use clusters from MftZone. */
 	zlen = wnd_zone_len(wnd);
 	zeroes = wnd_zeroes(wnd);

-	/* Check too big request */
+	/* Check too big request. */
 	if (len > zeroes + zlen)
 		goto no_space;

 	if (zlen <= NTFS_MIN_MFT_ZONE)
 		goto no_space;

-	/* How many clusters to cat from zone */
+	/* How many clusters to cat from zone. */
 	zlcn = wnd_zone_bit(wnd);
 	zlen2 = zlen >> 1;
 	ztrim = len > zlen ? zlen : (len > zlen2 ? len : zlen2);
@@ -445,7 +438,7 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,

 	wnd_zone_set(wnd, zlcn, new_zlen);

-	/* allocate continues clusters */
+	/* Allocate continues clusters. */
 	*new_len =
 		wnd_find(wnd, len, 0,
 			 BITMAP_FIND_MARK_AS_USED | BITMAP_FIND_FULL, &a_lcn);
@@ -467,7 +460,7 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 	if (opt & ALLOCATE_MFT)
 		goto out;

-	/* Set hint for next requests */
+	/* Set hint for next requests. */
 	sbi->used.next_free_lcn = *new_lcn + *new_len;

 out:
@@ -476,10 +469,9 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
 }

 /*
- * ntfs_extend_mft
+ * ntfs_extend_mft - Allocate additional MFT records.
  *
- * allocates additional MFT records
- * sbi->mft.bitmap is locked for write
+ * sbi->mft.bitmap is locked for write.
  *
  * NOTE: recursive:
  *	ntfs_look_free_mft ->
@@ -490,8 +482,9 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
  *	ni_ins_attr_ext ->
  *	ntfs_look_free_mft ->
  *	ntfs_extend_mft
- * To avoid recursive always allocate space for two new mft records
- * see attrib.c: "at least two mft to avoid recursive loop"
+ *
+ * To avoid recursive always allocate space for two new MFT records
+ * see attrib.c: "at least two MFT to avoid recursive loop".
  */
 static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 {
@@ -505,7 +498,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 	new_mft_total = (wnd->nbits + MFT_INCREASE_CHUNK + 127) & (CLST)~127;
 	new_mft_bytes = (u64)new_mft_total << sbi->record_bits;

-	/* Step 1: Resize $MFT::DATA */
+	/* Step 1: Resize $MFT::DATA. */
 	down_write(&ni->file.run_lock);
 	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
 			    new_mft_bytes, NULL, false, &attr);
@@ -519,13 +512,13 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 	new_mft_total = le64_to_cpu(attr->nres.alloc_size) >> sbi->record_bits;
 	ni->mi.dirty = true;

-	/* Step 2: Resize $MFT::BITMAP */
+	/* Step 2: Resize $MFT::BITMAP. */
 	new_bitmap_bytes = bitmap_size(new_mft_total);

 	err = attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
 			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);

-	/* Refresh Mft Zone if necessary */
+	/* Refresh MFT Zone if necessary. */
 	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);

 	ntfs_refresh_zone(sbi);
@@ -549,9 +542,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 }

 /*
- * ntfs_look_free_mft
- *
- * looks for a free MFT record
+ * ntfs_look_free_mft - Look for a free MFT record.
  */
 int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		       struct ntfs_inode *ni, struct mft_inode **mi)
@@ -572,7 +563,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,

 	zlen = wnd_zone_len(wnd);

-	/* Always reserve space for MFT */
+	/* Always reserve space for MFT. */
 	if (zlen) {
 		if (mft) {
 			zbit = wnd_zone_bit(wnd);
@@ -582,7 +573,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		goto found;
 	}

-	/* No MFT zone. find the nearest to '0' free MFT */
+	/* No MFT zone. Find the nearest to '0' free MFT. */
 	if (!wnd_find(wnd, 1, MFT_REC_FREE, 0, &zbit)) {
 		/* Resize MFT */
 		mft_total = wnd->nbits;
@@ -601,10 +592,10 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		/*
 		 * Look for free record reserved area [11-16) ==
 		 * [MFT_REC_RESERVED, MFT_REC_FREE ) MFT bitmap always
-		 * marks it as used
+		 * marks it as used.
 		 */
 		if (!sbi->mft.reserved_bitmap) {
-			/* Once per session create internal bitmap for 5 bits */
+			/* Once per session create internal bitmap for 5 bits. */
 			sbi->mft.reserved_bitmap = 0xFF;

 			ref.high = 0;
@@ -671,7 +662,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		while (zlen > 1 && !wnd_is_free(wnd, zbit, zlen))
 			zlen -= 1;

-		/* [zbit, zbit + zlen) will be used for Mft itself */
+		/* [zbit, zbit + zlen) will be used for MFT itself. */
 		from = sbi->mft.used;
 		if (from < zbit)
 			from = zbit;
@@ -692,7 +683,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,

 found:
 	if (!mft) {
-		/* The request to get record for general purpose */
+		/* The request to get record for general purpose. */
 		if (sbi->mft.next_free < MFT_REC_USER)
 			sbi->mft.next_free = MFT_REC_USER;

@@ -717,7 +708,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		goto out;
 	}

-	/* We have found a record that are not reserved for next MFT */
+	/* We have found a record that are not reserved for next MFT. */
 	if (*rno >= MFT_REC_FREE)
 		wnd_set_used(wnd, *rno, 1);
 	else if (*rno >= MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited)
@@ -731,9 +722,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 }

 /*
- * ntfs_mark_rec_free
- *
- * marks record as free
+ * ntfs_mark_rec_free - Mark record as free.
  */
 void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno)
 {
@@ -762,10 +751,9 @@ void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno)
 }

 /*
- * ntfs_clear_mft_tail
+ * ntfs_clear_mft_tail - Format empty records [from, to).
  *
- * formats empty records [from, to)
- * sbi->mft.bitmap is locked for write
+ * sbi->mft.bitmap is locked for write.
  */
 int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to)
 {
@@ -804,12 +792,11 @@ int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to)
 }

 /*
- * ntfs_refresh_zone
+ * ntfs_refresh_zone - Refresh MFT zone.
  *
- * refreshes Mft zone
- * sbi->used.bitmap is locked for rw
- * sbi->mft.bitmap is locked for write
- * sbi->mft.ni->file.run_lock for write
+ * sbi->used.bitmap is locked for rw.
+ * sbi->mft.bitmap is locked for write.
+ * sbi->mft.ni->file.run_lock for write.
  */
 int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
 {
@@ -818,14 +805,14 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
 	struct wnd_bitmap *wnd = &sbi->used.bitmap;
 	struct ntfs_inode *ni = sbi->mft.ni;

-	/* Do not change anything unless we have non empty Mft zone */
+	/* Do not change anything unless we have non empty MFT zone. */
 	if (wnd_zone_len(wnd))
 		return 0;

 	/*
-	 * Compute the mft zone at two steps
-	 * It would be nice if we are able to allocate
-	 * 1/8 of total clusters for MFT but not more then 512 MB
+	 * Compute the MFT zone at two steps.
+	 * It would be nice if we are able to allocate 1/8 of
+	 * total clusters for MFT but not more then 512 MB.
 	 */
 	zone_limit = (512 * 1024 * 1024) >> sbi->cluster_bits;
 	zone_max = wnd->nbits >> 3;
@@ -838,29 +825,27 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
 	if (!run_lookup_entry(&ni->file.run, vcn - 1, &lcn, &len, NULL))
 		lcn = SPARSE_LCN;

-	/* We should always find Last Lcn for MFT */
+	/* We should always find Last Lcn for MFT. */
 	if (lcn == SPARSE_LCN)
 		return -EINVAL;

 	lcn_s = lcn + 1;

-	/* Try to allocate clusters after last MFT run */
+	/* Try to allocate clusters after last MFT run. */
 	zlen = wnd_find(wnd, zone_max, lcn_s, 0, &lcn_s);
 	if (!zlen) {
 		ntfs_notice(sbi->sb, "MftZone: unavailable");
 		return 0;
 	}

-	/* Truncate too large zone */
+	/* Truncate too large zone. */
 	wnd_zone_set(wnd, lcn_s, zlen);

 	return 0;
 }

 /*
- * ntfs_update_mftmirr
- *
- * updates $MFTMirr data
+ * ntfs_update_mftmirr - Update $MFTMirr data.
  */
 int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 {
@@ -923,9 +908,9 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 /*
  * ntfs_set_state
  *
- * mount: ntfs_set_state(NTFS_DIRTY_DIRTY)
- * umount: ntfs_set_state(NTFS_DIRTY_CLEAR)
- * ntfs error: ntfs_set_state(NTFS_DIRTY_ERROR)
+ * Mount: ntfs_set_state(NTFS_DIRTY_DIRTY)
+ * Umount: ntfs_set_state(NTFS_DIRTY_CLEAR)
+ * NTFS error: ntfs_set_state(NTFS_DIRTY_ERROR)
  */
 int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 {
@@ -936,14 +921,14 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 	struct ntfs_inode *ni;

 	/*
-	 * do not change state if fs was real_dirty
-	 * do not change state if fs already dirty(clear)
-	 * do not change any thing if mounted read only
+	 * Do not change state if fs was real_dirty.
+	 * Do not change state if fs already dirty(clear).
+	 * Do not change any thing if mounted read only.
 	 */
 	if (sbi->volume.real_dirty || sb_rdonly(sbi->sb))
 		return 0;

-	/* Check cached value */
+	/* Check cached value. */
 	if ((dirty == NTFS_DIRTY_CLEAR ? 0 : VOLUME_FLAG_DIRTY) ==
 	    (sbi->volume.flags & VOLUME_FLAG_DIRTY))
 		return 0;
@@ -978,7 +963,7 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 		info->flags &= ~VOLUME_FLAG_DIRTY;
 		break;
 	}
-	/* cache current volume flags*/
+	/* Cache current volume flags. */
 	sbi->volume.flags = info->flags;
 	mi->dirty = true;
 	err = 0;
@@ -989,16 +974,14 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
 		return err;

 	mark_inode_dirty(&ni->vfs_inode);
-	/*verify(!ntfs_update_mftmirr()); */
+	/* verify(!ntfs_update_mftmirr()); */
 	err = sync_inode_metadata(&ni->vfs_inode, 1);

 	return err;
 }

 /*
- * security_hash
- *
- * calculates a hash of security descriptor
+ * security_hash - Calculate a hash of security descriptor.
  */
 static inline __le32 security_hash(const void *sd, size_t bytes)
 {
@@ -1184,13 +1167,13 @@ int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 	struct buffer_head *bh;

 	if (!run) {
-		/* first reading of $Volume + $MFTMirr + LogFile goes here*/
+		/* First reading of $Volume + $MFTMirr + $LogFile goes here. */
 		if (vbo > MFT_REC_VOL * sbi->record_size) {
 			err = -ENOENT;
 			goto out;
 		}

-		/* use absolute boot's 'MFTCluster' to read record */
+		/* Use absolute boot's 'MFTCluster' to read record. */
 		lbo = vbo + sbi->mft.lbo;
 		len = sbi->record_size;
 	} else if (!run_lookup_entry(run, vcn, &lcn, &clen, &idx)) {
@@ -1281,7 +1264,11 @@ int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 	return err;
 }

-/* Returns < 0 if error, 0 if ok, '-E_NTFS_FIXUP' if need to update fixups */
+/*
+ * ntfs_read_bh
+ *
+ * Return: < 0 if error, 0 if ok, -E_NTFS_FIXUP if need to update fixups.
+ */
 int ntfs_read_bh(struct ntfs_sb_info *sbi, const struct runs_tree *run, u64 vbo,
 		 struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
 		 struct ntfs_buffers *nb)
@@ -1478,7 +1465,9 @@ static inline struct bio *ntfs_alloc_bio(u32 nr_vecs)
 	return bio;
 }

-/* read/write pages from/to disk*/
+/*
+ * ntfs_bio_pages - Read/write pages from/to disk.
+ */
 int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		   struct page **pages, u32 nr_pages, u64 vbo, u32 bytes,
 		   u32 op)
@@ -1500,7 +1489,7 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,

 	blk_start_plug(&plug);

-	/* align vbo and bytes to be 512 bytes aligned */
+	/* Align vbo and bytes to be 512 bytes aligned. */
 	lbo = (vbo + bytes + 511) & ~511ull;
 	vbo = vbo & ~511ull;
 	bytes = lbo - vbo;
@@ -1579,9 +1568,10 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 }

 /*
- * Helper for ntfs_loadlog_and_replay
- * fill on-disk logfile range by (-1)
- * this means empty logfile
+ * ntfs_bio_fill_1 - Helper for ntfs_loadlog_and_replay().
+ *
+ * Fill on-disk logfile range by (-1)
+ * this means empty logfile.
  */
 int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 {
@@ -1613,7 +1603,7 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 	}

 	/*
-	 * TODO: try blkdev_issue_write_same
+	 * TODO: Try blkdev_issue_write_same.
 	 */
 	blk_start_plug(&plug);
 	do {
@@ -1710,8 +1700,8 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)

 /*
  * O:BAG:BAD:(A;OICI;FA;;;WD)
- * owner S-1-5-32-544 (Administrators)
- * group S-1-5-32-544 (Administrators)
+ * Owner S-1-5-32-544 (Administrators)
+ * Group S-1-5-32-544 (Administrators)
  * ACE: allow S-1-1-0 (Everyone) with FILE_ALL_ACCESS
  */
 const u8 s_default_security[] __aligned(8) = {
@@ -1732,7 +1722,9 @@ static inline u32 sid_length(const struct SID *sid)
 }

 /*
- * Thanks Mark Harmstone for idea
+ * is_acl_valid
+ *
+ * Thanks Mark Harmstone for idea.
  */
 static bool is_acl_valid(const struct ACL *acl, u32 len)
 {
@@ -1848,9 +1840,7 @@ bool is_sd_valid(const struct SECURITY_DESCRIPTOR_RELATIVE *sd, u32 len)
 }

 /*
- * ntfs_security_init
- *
- * loads and parse $Secure
+ * ntfs_security_init - Load and parse $Secure.
  */
 int ntfs_security_init(struct ntfs_sb_info *sbi)
 {
@@ -1931,9 +1921,9 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)

 	sds_size = inode->i_size;

-	/* Find the last valid Id */
+	/* Find the last valid Id. */
 	sbi->security.next_id = SECURITY_ID_FIRST;
-	/* Always write new security at the end of bucket */
+	/* Always write new security at the end of bucket. */
 	sbi->security.next_off =
 		Quad2Align(sds_size - SecurityDescriptorsBlockSize);

@@ -1969,9 +1959,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 }

 /*
- * ntfs_get_security_by_id
- *
- * reads security descriptor by id
+ * ntfs_get_security_by_id - Read security descriptor by id.
  */
 int ntfs_get_security_by_id(struct ntfs_sb_info *sbi, __le32 security_id,
 			    struct SECURITY_DESCRIPTOR_RELATIVE **sd,
@@ -2004,7 +1992,7 @@ int ntfs_get_security_by_id(struct ntfs_sb_info *sbi, __le32 security_id,
 		goto out;
 	}

-	/* Try to find this SECURITY descriptor in SII indexes */
+	/* Try to find this SECURITY descriptor in SII indexes. */
 	err = indx_find(indx, ni, root_sii, &security_id, sizeof(security_id),
 			NULL, &diff, (struct NTFS_DE **)&sii_e, fnd_sii);
 	if (err)
@@ -2020,9 +2008,7 @@ int ntfs_get_security_by_id(struct ntfs_sb_info *sbi, __le32 security_id,
 	}

 	if (t32 > SIZEOF_SECURITY_HDR + 0x10000) {
-		/*
-		 * looks like too big security. 0x10000 - is arbitrary big number
-		 */
+		/* Looks like too big security. 0x10000 - is arbitrary big number. */
 		err = -EFBIG;
 		goto out;
 	}
@@ -2065,9 +2051,7 @@ int ntfs_get_security_by_id(struct ntfs_sb_info *sbi, __le32 security_id,
 }

 /*
- * ntfs_insert_security
- *
- * inserts security descriptor into $Secure::SDS
+ * ntfs_insert_security - Insert security descriptor into $Secure::SDS.
  *
  * SECURITY Descriptor Stream data is organized into chunks of 256K bytes
  * and it contains a mirror copy of each security descriptor.  When writing
@@ -2108,7 +2092,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 		*inserted = false;
 	*security_id = SECURITY_ID_INVALID;

-	/* Allocate a temporal buffer*/
+	/* Allocate a temporal buffer. */
 	d_security = ntfs_zalloc(aligned_sec_size);
 	if (!d_security)
 		return -ENOMEM;
@@ -2134,8 +2118,8 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 	}

 	/*
-	 * Check if such security already exists
-	 * use "SDH" and hash -> to get the offset in "SDS"
+	 * Check if such security already exists.
+	 * Use "SDH" and hash -> to get the offset in "SDS".
 	 */
 	err = indx_find(indx_sdh, ni, root_sdh, &hash_key, sizeof(hash_key),
 			&d_security->key.sec_id, &diff, (struct NTFS_DE **)&e,
@@ -2155,7 +2139,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 			    d_security->key.hash == hash_key.hash &&
 			    !memcmp(d_security + 1, sd, size_sd)) {
 				*security_id = d_security->key.sec_id;
-				/*such security already exists*/
+				/* Such security already exists. */
 				err = 0;
 				goto out;
 			}
@@ -2170,17 +2154,17 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 			break;
 	}

-	/* Zero unused space */
+	/* Zero unused space. */
 	next = sbi->security.next_off & (SecurityDescriptorsBlockSize - 1);
 	left = SecurityDescriptorsBlockSize - next;

-	/* Zero gap until SecurityDescriptorsBlockSize */
+	/* Zero gap until SecurityDescriptorsBlockSize. */
 	if (left < new_sec_size) {
-		/* zero "left" bytes from sbi->security.next_off */
+		/* Zero "left" bytes from sbi->security.next_off. */
 		sbi->security.next_off += SecurityDescriptorsBlockSize + left;
 	}

-	/* Zero tail of previous security */
+	/* Zero tail of previous security. */
 	//used = ni->vfs_inode.i_size & (SecurityDescriptorsBlockSize - 1);

 	/*
@@ -2193,14 +2177,14 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 	 *  zero "tozero" bytes from sbi->security.next_off - tozero
 	 */

-	/* format new security descriptor */
+	/* Format new security descriptor. */
 	d_security->key.hash = hash_key.hash;
 	d_security->key.sec_id = cpu_to_le32(sbi->security.next_id);
 	d_security->off = cpu_to_le64(sbi->security.next_off);
 	d_security->size = cpu_to_le32(new_sec_size);
 	memcpy(d_security + 1, sd, size_sd);

-	/* Write main SDS bucket */
+	/* Write main SDS bucket. */
 	err = ntfs_sb_write_run(sbi, &ni->file.run, sbi->security.next_off,
 				d_security, aligned_sec_size);

@@ -2218,13 +2202,13 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 			goto out;
 	}

-	/* Write copy SDS bucket */
+	/* Write copy SDS bucket. */
 	err = ntfs_sb_write_run(sbi, &ni->file.run, mirr_off, d_security,
 				aligned_sec_size);
 	if (err)
 		goto out;

-	/* Fill SII entry */
+	/* Fill SII entry. */
 	sii_e.de.view.data_off =
 		cpu_to_le16(offsetof(struct NTFS_DE_SII, sec_hdr));
 	sii_e.de.view.data_size = cpu_to_le16(SIZEOF_SECURITY_HDR);
@@ -2240,7 +2224,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 	if (err)
 		goto out;

-	/* Fill SDH entry */
+	/* Fill SDH entry. */
 	sdh_e.de.view.data_off =
 		cpu_to_le16(offsetof(struct NTFS_DE_SDH, sec_hdr));
 	sdh_e.de.view.data_size = cpu_to_le16(SIZEOF_SECURITY_HDR);
@@ -2265,7 +2249,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 	if (inserted)
 		*inserted = true;

-	/* Update Id and offset for next descriptor */
+	/* Update Id and offset for next descriptor. */
 	sbi->security.next_id += 1;
 	sbi->security.next_off += aligned_sec_size;

@@ -2279,9 +2263,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
 }

 /*
- * ntfs_reparse_init
- *
- * loads and parse $Extend/$Reparse
+ * ntfs_reparse_init - Load and parse $Extend/$Reparse.
  */
 int ntfs_reparse_init(struct ntfs_sb_info *sbi)
 {
@@ -2319,9 +2301,7 @@ int ntfs_reparse_init(struct ntfs_sb_info *sbi)
 }

 /*
- * ntfs_objid_init
- *
- * loads and parse $Extend/$ObjId
+ * ntfs_objid_init - Load and parse $Extend/$ObjId.
  */
 int ntfs_objid_init(struct ntfs_sb_info *sbi)
 {
@@ -2443,14 +2423,14 @@ int ntfs_remove_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
 		goto out;
 	}

-	/* 1 - forces to ignore rkey.ReparseTag when comparing keys */
+	/* 1 - forces to ignore rkey.ReparseTag when comparing keys. */
 	err = indx_find(indx, ni, root_r, &rkey, sizeof(rkey), (void *)1, &diff,
 			(struct NTFS_DE **)&re, fnd);
 	if (err)
 		goto out;

 	if (memcmp(&re->key.ref, ref, sizeof(*ref))) {
-		/* Impossible. Looks like volume corrupt?*/
+		/* Impossible. Looks like volume corrupt? */
 		goto out;
 	}

@@ -2522,9 +2502,7 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
 }

 /*
- * run_deallocate
- *
- * deallocate clusters
+ * run_deallocate - Deallocate clusters.
  */
 int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim)
 {
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 931a7241ef00..ed5b162abac4 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -24,9 +24,10 @@ static const struct INDEX_NAMES {
 };

 /*
- * compare two names in index
+ * cmp_fnames - Compare two names in index.
+ *
  * if l1 != 0
- *   both names are little endian on-disk ATTR_FILE_NAME structs
+ *   Both names are little endian on-disk ATTR_FILE_NAME structs.
  * else
  *   key1 - cpu_str, key2 - ATTR_FILE_NAME
  */
@@ -52,7 +53,7 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,

 		/*
 		 * If names are equal (case insensitive)
-		 * try to compare it case sensitive
+		 * try to compare it case sensitive.
 		 */
 		return ntfs_cmp_names_cpu(key1, s2, sbi->upcase, both_case);
 	}
@@ -62,7 +63,9 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
 			      sbi->upcase, both_case);
 }

-/* $SII of $Secure and $Q of Quota */
+/*
+ * cmp_uint - $SII of $Secure and $Q of Quota
+ */
 static int cmp_uint(const void *key1, size_t l1, const void *key2, size_t l2,
 		    const void *data)
 {
@@ -79,7 +82,9 @@ static int cmp_uint(const void *key1, size_t l1, const void *key2, size_t l2,
 	return 0;
 }

-/* $SDH of $Secure */
+/*
+ * cmp_sdh - $SDH of $Secure
+ */
 static int cmp_sdh(const void *key1, size_t l1, const void *key2, size_t l2,
 		   const void *data)
 {
@@ -93,13 +98,13 @@ static int cmp_sdh(const void *key1, size_t l1, const void *key2, size_t l2,
 	t1 = le32_to_cpu(k1->hash);
 	t2 = le32_to_cpu(k2->hash);

-	/* First value is a hash value itself */
+	/* First value is a hash value itself. */
 	if (t1 < t2)
 		return -1;
 	if (t1 > t2)
 		return 1;

-	/* Second value is security Id */
+	/* Second value is security Id. */
 	if (data) {
 		t1 = le32_to_cpu(k1->sec_id);
 		t2 = le32_to_cpu(k2->sec_id);
@@ -112,7 +117,9 @@ static int cmp_sdh(const void *key1, size_t l1, const void *key2, size_t l2,
 	return 0;
 }

-/* $O of ObjId and "$R" for Reparse */
+/*
+ * cmp_uints - $O of ObjId and "$R" for Reparse.
+ */
 static int cmp_uints(const void *key1, size_t l1, const void *key2, size_t l2,
 		     const void *data)
 {
@@ -122,12 +129,13 @@ static int cmp_uints(const void *key1, size_t l1, const void *key2, size_t l2,

 	if ((size_t)data == 1) {
 		/*
-		 * ni_delete_all -> ntfs_remove_reparse -> delete all with this reference
+		 * ni_delete_all -> ntfs_remove_reparse ->
+		 * delete all with this reference.
 		 * k1, k2 - pointers to REPARSE_KEY
 		 */

-		k1 += 1; // skip REPARSE_KEY.ReparseTag
-		k2 += 1; // skip REPARSE_KEY.ReparseTag
+		k1 += 1; // Skip REPARSE_KEY.ReparseTag
+		k2 += 1; // Skip REPARSE_KEY.ReparseTag
 		if (l2 <= sizeof(int))
 			return -1;
 		l2 -= sizeof(int);
@@ -228,7 +236,7 @@ static int bmp_buf_get(struct ntfs_index *indx, struct ntfs_inode *ni,

 	data_size = le64_to_cpu(b->nres.data_size);
 	if (WARN_ON(off >= data_size)) {
-		/* looks like filesystem error */
+		/* Looks like filesystem error. */
 		return -EINVAL;
 	}

@@ -302,9 +310,7 @@ static void bmp_buf_put(struct bmp_buf *bbuf, bool dirty)
 }

 /*
- * indx_mark_used
- *
- * marks the bit 'bit' as used
+ * indx_mark_used - Mark the bit @bit as used.
  */
 static int indx_mark_used(struct ntfs_index *indx, struct ntfs_inode *ni,
 			  size_t bit)
@@ -324,9 +330,7 @@ static int indx_mark_used(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * indx_mark_free
- *
- * the bit 'bit' as free
+ * indx_mark_free - Mark the bit @bit as free.
  */
 static int indx_mark_free(struct ntfs_index *indx, struct ntfs_inode *ni,
 			  size_t bit)
@@ -346,9 +350,11 @@ static int indx_mark_free(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * if ntfs_readdir calls this function (indx_used_bit -> scan_nres_bitmap),
- * inode is shared locked and no ni_lock
- * use rw_semaphore for read/write access to bitmap_run
+ * scan_nres_bitmap
+ *
+ * If ntfs_readdir calls this function (indx_used_bit -> scan_nres_bitmap),
+ * inode is shared locked and no ni_lock.
+ * Use rw_semaphore for read/write access to bitmap_run.
  */
 static int scan_nres_bitmap(struct ntfs_inode *ni, struct ATTRIB *bitmap,
 			    struct ntfs_index *indx, size_t from,
@@ -459,10 +465,9 @@ static bool scan_for_free(const ulong *buf, u32 bit, u32 bits, size_t *ret)
 }

 /*
- * indx_find_free
+ * indx_find_free - Look for free bit.
  *
- * looks for free bit
- * returns -1 if no free bits
+ * Return: -1 if no free bits.
  */
 static int indx_find_free(struct ntfs_index *indx, struct ntfs_inode *ni,
 			  size_t *bit, struct ATTRIB **bitmap)
@@ -508,10 +513,9 @@ static bool scan_for_used(const ulong *buf, u32 bit, u32 bits, size_t *ret)
 }

 /*
- * indx_used_bit
+ * indx_used_bit - Look for used bit.
  *
- * looks for used bit
- * returns MINUS_ONE_T if no used bits
+ * Return: MINUS_ONE_T if no used bits.
  */
 int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit)
 {
@@ -547,9 +551,8 @@ int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit)
 /*
  * hdr_find_split
  *
- * finds a point at which the index allocation buffer would like to
- * be split.
- * NOTE: This function should never return 'END' entry NULL returns on error
+ * Find a point at which the index allocation buffer would like to be split.
+ * NOTE: This function should never return 'END' entry NULL returns on error.
  */
 static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
 {
@@ -566,7 +569,7 @@ static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)

 		e = Add2Ptr(hdr, o);

-		/* We must not return END entry */
+		/* We must not return END entry. */
 		if (de_is_last(e))
 			return p;

@@ -577,9 +580,8 @@ static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
 }

 /*
- * hdr_insert_head
- *
- * inserts some entries at the beginning of the buffer.
+ * hdr_insert_head - Insert some entries at the beginning of the buffer.
+ *
  * It is used to insert entries into a newly-created buffer.
  */
 static const struct NTFS_DE *hdr_insert_head(struct INDEX_HDR *hdr,
@@ -654,14 +656,14 @@ static bool fnd_is_empty(struct ntfs_fnd *fnd)
 }

 /*
- * hdr_find_e
+ * hdr_find_e - Locate an entry the index buffer.
  *
- * locates an entry the index buffer.
  * If no matching entry is found, it returns the first entry which is greater
  * than the desired entry If the search key is greater than all the entries the
  * buffer, it returns the 'end' entry. This function does a binary search of the
- * current index buffer, for the first entry that is <= to the search value
- * Returns NULL if error
+ * current index buffer, for the first entry that is <= to the search value.
+ *
+ * Return: NULL if error.
  */
 static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 				  const struct INDEX_HDR *hdr, const void *key,
@@ -685,7 +687,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	if (!offs)
 		goto next;

-	/* use binary search algorithm */
+	/* Use binary search algorithm. */
 next1:
 	if (off + sizeof(struct NTFS_DE) > end) {
 		e = NULL;
@@ -713,7 +715,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 			goto next;
 	}

-	/* Store entry table */
+	/* Store entry table. */
 	offs[max_idx] = off;

 	if (!de_is_last(e)) {
@@ -723,8 +725,8 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	}

 	/*
-	 * Table of pointers is created
-	 * Use binary search to find entry that is <= to the search value
+	 * Table of pointers is created.
+	 * Use binary search to find entry that is <= to the search value.
 	 */
 	fnd = -1;
 	min_idx = 0;
@@ -770,8 +772,9 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,

 next:
 	/*
-	 * Entries index are sorted
-	 * Enumerate all entries until we find entry that is <= to the search value
+	 * Entries index are sorted.
+	 * Enumerate all entries until we find entry
+	 * that is <= to the search value.
 	 */
 	if (off + sizeof(struct NTFS_DE) > end)
 		return NULL;
@@ -801,10 +804,9 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 }

 /*
- * hdr_insert_de
+ * hdr_insert_de - Insert an index entry into the buffer.
  *
- * inserts an index entry into the buffer.
- * 'before' should be a pointer previously returned from hdr_find_e
+ * 'before' should be a pointer previously returned from hdr_find_e.
  */
 static struct NTFS_DE *hdr_insert_de(const struct ntfs_index *indx,
 				     struct INDEX_HDR *hdr,
@@ -817,20 +819,20 @@ static struct NTFS_DE *hdr_insert_de(const struct ntfs_index *indx,
 	u32 total = le32_to_cpu(hdr->total);
 	u16 de_size = le16_to_cpu(de->size);

-	/* First, check to see if there's enough room */
+	/* First, check to see if there's enough room. */
 	if (used + de_size > total)
 		return NULL;

 	/* We know there's enough space, so we know we'll succeed. */
 	if (before) {
-		/* Check that before is inside Index */
+		/* Check that before is inside Index. */
 		if (off >= used || off < le32_to_cpu(hdr->de_off) ||
 		    off + le16_to_cpu(before->size) > total) {
 			return NULL;
 		}
 		goto ok;
 	}
-	/* No insert point is applied. Get it manually */
+	/* No insert point is applied. Get it manually. */
 	before = hdr_find_e(indx, hdr, de + 1, le16_to_cpu(de->key_size), ctx,
 			    &diff);
 	if (!before)
@@ -848,9 +850,7 @@ static struct NTFS_DE *hdr_insert_de(const struct ntfs_index *indx,
 }

 /*
- * hdr_delete_de
- *
- * removes an entry from the index buffer
+ * hdr_delete_de - Remove an entry from the index buffer.
  */
 static inline struct NTFS_DE *hdr_delete_de(struct INDEX_HDR *hdr,
 					    struct NTFS_DE *re)
@@ -882,7 +882,7 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	u32 t32;
 	const struct INDEX_ROOT *root = resident_data(attr);

-	/* Check root fields */
+	/* Check root fields. */
 	if (!root->index_block_clst)
 		return -EINVAL;

@@ -892,13 +892,13 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	t32 = le32_to_cpu(root->index_block_size);
 	indx->index_bits = blksize_bits(t32);

-	/* Check index record size */
+	/* Check index record size. */
 	if (t32 < sbi->cluster_size) {
-		/* index record is smaller than a cluster, use 512 blocks */
+		/* Index record is smaller than a cluster, use 512 blocks. */
 		if (t32 != root->index_block_clst * SECTOR_SIZE)
 			return -EINVAL;

-		/* Check alignment to a cluster */
+		/* Check alignment to a cluster. */
 		if ((sbi->cluster_size >> SECTOR_SHIFT) &
 		    (root->index_block_clst - 1)) {
 			return -EINVAL;
@@ -906,7 +906,7 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,

 		indx->vbn2vbo_bits = SECTOR_SHIFT;
 	} else {
-		/* index record must be a multiple of cluster size */
+		/* Index record must be a multiple of cluster size. */
 		if (t32 != root->index_block_clst << sbi->cluster_bits)
 			return -EINVAL;

@@ -951,7 +951,7 @@ static struct indx_node *indx_new(struct ntfs_index *indx,
 		return ERR_PTR(err);
 	}

-	/* Create header */
+	/* Create header. */
 	index->rhdr.sign = NTFS_INDX_SIGNATURE;
 	index->rhdr.fix_off = cpu_to_le16(sizeof(struct INDEX_BUFFER)); // 0x28
 	fn = (bytes >> SECTOR_SHIFT) + 1; // 9
@@ -1009,9 +1009,11 @@ static int indx_write(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * if ntfs_readdir calls this function
- * inode is shared locked and no ni_lock
- * use rw_semaphore for read/write access to alloc_run
+ * indx_read
+ *
+ * If ntfs_readdir calls this function
+ * inode is shared locked and no ni_lock.
+ * Use rw_semaphore for read/write access to alloc_run.
  */
 int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	      struct indx_node **node)
@@ -1093,9 +1095,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 }

 /*
- * indx_find
- *
- * scans NTFS directory for given entry
+ * indx_find - Scan NTFS directory for given entry.
  */
 int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
 	      const struct INDEX_ROOT *root, const void *key, size_t key_len,
@@ -1117,7 +1117,7 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,

 	hdr = &root->ihdr;

-	/* Check cache */
+	/* Check cache. */
 	e = fnd->level ? fnd->de[fnd->level - 1] : fnd->root_de;
 	if (e && !de_is_last(e) &&
 	    !(*indx->cmp)(key, key_len, e + 1, le16_to_cpu(e->key_size), ctx)) {
@@ -1126,10 +1126,10 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return 0;
 	}

-	/* Soft finder reset */
+	/* Soft finder reset. */
 	fnd_clear(fnd);

-	/* Lookup entry that is <= to the search value */
+	/* Lookup entry that is <= to the search value. */
 	e = hdr_find_e(indx, hdr, key, key_len, ctx, diff);
 	if (!e)
 		return -EINVAL;
@@ -1151,7 +1151,7 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
 		if (err)
 			goto out;

-		/* Lookup entry that is <= to the search value */
+		/* Lookup entry that is <= to the search value. */
 		e = hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx,
 			       diff);
 		if (!e) {
@@ -1178,7 +1178,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 	int level = fnd->level;

 	if (!*entry) {
-		/* Start find */
+		/* Start find. */
 		e = hdr_first_de(&root->ihdr);
 		if (!e)
 			return 0;
@@ -1208,7 +1208,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 		fnd->de[level - 1] = e;
 	}

-	/* Just to avoid tree cycle */
+	/* Just to avoid tree cycle. */
 next_iter:
 	if (iter++ >= 1000)
 		return -EINVAL;
@@ -1223,12 +1223,12 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 			return -EINVAL;
 		}

-		/* Read next level */
+		/* Read next level. */
 		err = indx_read(indx, ni, de_get_vbn(e), &n);
 		if (err)
 			return err;

-		/* Try next level */
+		/* Try next level. */
 		e = hdr_first_de(&n->index->ihdr);
 		if (!e) {
 			ntfs_free(n);
@@ -1248,7 +1248,7 @@ int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
 		if (!de_is_last(e))
 			goto next_iter;

-		/* Pop one level */
+		/* Pop one level. */
 		if (n) {
 			fnd_pop(fnd);
 			ntfs_free(n);
@@ -1290,35 +1290,35 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
 	CLST next_vbn;
 	u32 record_size = ni->mi.sbi->record_size;

-	/* Use non sorted algorithm */
+	/* Use non sorted algorithm. */
 	if (!*entry) {
-		/* This is the first call */
+		/* This is the first call. */
 		e = hdr_first_de(&root->ihdr);
 		if (!e)
 			return 0;
 		fnd_clear(fnd);
 		fnd->root_de = e;

-		/* The first call with setup of initial element */
+		/* The first call with setup of initial element. */
 		if (*off >= record_size) {
 			next_vbn = (((*off - record_size) >> indx->index_bits))
 				   << indx->idx2vbn_bits;
-			/* jump inside cycle 'for'*/
+			/* Jump inside cycle 'for'. */
 			goto next;
 		}

-		/* Start enumeration from root */
+		/* Start enumeration from root. */
 		*off = 0;
 	} else if (!fnd->root_de)
 		return -EINVAL;

 	for (;;) {
-		/* Check if current entry can be used */
+		/* Check if current entry can be used. */
 		if (e && le16_to_cpu(e->size) > sizeof(struct NTFS_DE))
 			goto ok;

 		if (!fnd->level) {
-			/* Continue to enumerate root */
+			/* Continue to enumerate root. */
 			if (!de_is_last(fnd->root_de)) {
 				e = hdr_next_de(&root->ihdr, fnd->root_de);
 				if (!e)
@@ -1327,10 +1327,10 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
 				continue;
 			}

-			/* Start to enumerate indexes from 0 */
+			/* Start to enumerate indexes from 0. */
 			next_vbn = 0;
 		} else {
-			/* Continue to enumerate indexes */
+			/* Continue to enumerate indexes. */
 			e2 = fnd->de[fnd->level - 1];

 			n = fnd->nodes[fnd->level - 1];
@@ -1343,31 +1343,31 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
 				continue;
 			}

-			/* Continue with next index */
+			/* Continue with next index. */
 			next_vbn = le64_to_cpu(n->index->vbn) +
 				   root->index_block_clst;
 		}

 next:
-		/* Release current index */
+		/* Release current index. */
 		if (n) {
 			fnd_pop(fnd);
 			put_indx_node(n);
 			n = NULL;
 		}

-		/* Skip all free indexes */
+		/* Skip all free indexes. */
 		bit = next_vbn >> indx->idx2vbn_bits;
 		err = indx_used_bit(indx, ni, &bit);
 		if (err == -ENOENT || bit == MINUS_ONE_T) {
-			/* No used indexes */
+			/* No used indexes. */
 			*entry = NULL;
 			return 0;
 		}

 		next_used_vbn = bit << indx->idx2vbn_bits;

-		/* Read buffer into memory */
+		/* Read buffer into memory. */
 		err = indx_read(indx, ni, next_used_vbn, &n);
 		if (err)
 			return err;
@@ -1379,12 +1379,12 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}

 ok:
-	/* return offset to restore enumerator if necessary */
+	/* Return offset to restore enumerator if necessary. */
 	if (!n) {
-		/* 'e' points in root */
+		/* 'e' points in root, */
 		*off = PtrOffset(&root->ihdr, e);
 	} else {
-		/* 'e' points in index */
+		/* 'e' points in index, */
 		*off = (le64_to_cpu(n->index->vbn) << indx->vbn2vbo_bits) +
 		       record_size + PtrOffset(&n->index->ihdr, e);
 	}
@@ -1394,9 +1394,7 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * indx_create_allocate
- *
- * create "Allocation + Bitmap" attributes
+ * indx_create_allocate - Create "Allocation + Bitmap" attributes.
  */
 static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 				CLST *vbn)
@@ -1453,9 +1451,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * indx_add_allocate
- *
- * add clusters to index
+ * indx_add_allocate - Add clusters to index.
  */
 static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 			     CLST *vbn)
@@ -1488,7 +1484,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	data_size = (u64)(bit + 1) << indx->index_bits;

 	if (bmp) {
-		/* Increase bitmap */
+		/* Increase bitmap. */
 		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
 				    &indx->bitmap_run, bitmap_size(bit + 1),
 				    NULL, true, NULL);
@@ -1504,7 +1500,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out1;
 	}

-	/* Increase allocation */
+	/* Increase allocation. */
 	err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
 			    &indx->alloc_run, data_size, &data_size, true,
 			    NULL);
@@ -1519,7 +1515,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	return 0;

 out2:
-	/* Ops (no space?) */
+	/* Ops. No space? */
 	attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
 		      &indx->bitmap_run, bmp_size, &bmp_size_v, false, NULL);

@@ -1528,9 +1524,8 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * indx_insert_into_root
+ * indx_insert_into_root - Attempt to insert an entry into the index root.
  *
- * attempts to insert an entry into the index root
  * If necessary, it will twiddle the index b-tree.
  */
 static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
@@ -1554,14 +1549,15 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	int ds_root;
 	struct INDEX_ROOT *root, *a_root = NULL;

-	/* Get the record this root placed in */
+	/* Get the record this root placed in. */
 	root = indx_get_root(indx, ni, &attr, &mi);
 	if (!root)
 		goto out;

 	/*
 	 * Try easy case:
-	 * hdr_insert_de will succeed if there's room the root for the new entry.
+	 * hdr_insert_de will succeed if there's
+	 * room the root for the new entry.
 	 */
 	hdr = &root->ihdr;
 	sbi = ni->mi.sbi;
@@ -1576,7 +1572,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	ds_root = new_de_size + hdr_used - hdr_total;

 	if (used + ds_root < sbi->max_bytes_per_attr) {
-		/* make a room for new elements */
+		/* Make a room for new elements. */
 		mi_resize_attr(mi, attr, ds_root);
 		hdr->total = cpu_to_le32(hdr_total + ds_root);
 		e = hdr_insert_de(indx, hdr, new_de, root_de, ctx);
@@ -1587,18 +1583,21 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return 0;
 	}

-	/* Make a copy of root attribute to restore if error */
+	/* Make a copy of root attribute to restore if error. */
 	a_root = ntfs_memdup(attr, asize);
 	if (!a_root) {
 		err = -ENOMEM;
 		goto out;
 	}

-	/* copy all the non-end entries from the index root to the new buffer.*/
+	/*
+	 * Copy all the non-end entries from the
+	 * index root to the new buffer.
+	 */
 	to_move = 0;
 	e0 = hdr_first_de(hdr);

-	/* Calculate the size to copy */
+	/* Calculate the size to copy. */
 	for (e = e0;; e = hdr_next_de(hdr, e)) {
 		if (!e) {
 			err = -EINVAL;
@@ -1632,7 +1631,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	ds_root = new_root_size - root_size;

 	if (ds_root > 0 && used + ds_root > sbi->max_bytes_per_attr) {
-		/* make root external */
+		/* Make root external. */
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -1640,7 +1639,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (ds_root)
 		mi_resize_attr(mi, attr, ds_root);

-	/* Fill first entry (vcn will be set later) */
+	/* Fill first entry (vcn will be set later). */
 	e = (struct NTFS_DE *)(root + 1);
 	memset(e, 0, sizeof(struct NTFS_DE));
 	e->size = cpu_to_le16(sizeof(struct NTFS_DE) + sizeof(u64));
@@ -1653,26 +1652,26 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	fnd->root_de = hdr_first_de(hdr);
 	mi->dirty = true;

-	/* Create alloc and bitmap attributes (if not) */
+	/* Create alloc and bitmap attributes (if not). */
 	err = run_is_empty(&indx->alloc_run)
 		      ? indx_create_allocate(indx, ni, &new_vbn)
 		      : indx_add_allocate(indx, ni, &new_vbn);

-	/* layout of record may be changed, so rescan root */
+	/* Layout of record may be changed, so rescan root. */
 	root = indx_get_root(indx, ni, &attr, &mi);
 	if (!root) {
-		/* bug? */
+		/* Bug? */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		err = -EINVAL;
 		goto out1;
 	}

 	if (err) {
-		/* restore root */
+		/* Restore root. */
 		if (mi_resize_attr(mi, attr, -ds_root))
 			memcpy(attr, a_root, asize);
 		else {
-			/* bug? */
+			/* Bug? */
 			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		}
 		goto out1;
@@ -1682,7 +1681,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	*(__le64 *)(e + 1) = cpu_to_le64(new_vbn);
 	mi->dirty = true;

-	/* now we can create/format the new buffer and copy the entries into */
+	/* Now we can create/format the new buffer and copy the entries into. */
 	n = indx_new(indx, ni, new_vbn, sub_vbn);
 	if (IS_ERR(n)) {
 		err = PTR_ERR(n);
@@ -1693,19 +1692,19 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_used = le32_to_cpu(hdr->used);
 	hdr_total = le32_to_cpu(hdr->total);

-	/* Copy root entries into new buffer */
+	/* Copy root entries into new buffer. */
 	hdr_insert_head(hdr, re, to_move);

-	/* Update bitmap attribute */
+	/* Update bitmap attribute. */
 	indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);

-	/* Check if we can insert new entry new index buffer */
+	/* Check if we can insert new entry new index buffer. */
 	if (hdr_used + new_de_size > hdr_total) {
 		/*
-		 * This occurs if mft record is the same or bigger than index
+		 * This occurs if MFT record is the same or bigger than index
 		 * buffer. Move all root new index and have no space to add
-		 * new entry classic case when mft record is 1K and index
-		 * buffer 4K the problem should not occurs
+		 * new entry classic case when MFT record is 1K and index
+		 * buffer 4K the problem should not occurs.
 		 */
 		ntfs_free(re);
 		indx_write(indx, ni, n, 0);
@@ -1717,8 +1716,8 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}

 	/*
-	 * Now root is a parent for new index buffer
-	 * Insert NewEntry a new buffer
+	 * Now root is a parent for new index buffer.
+	 * Insert NewEntry a new buffer.
 	 */
 	e = hdr_insert_de(indx, hdr, new_de, NULL, ctx);
 	if (!e) {
@@ -1727,7 +1726,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 	fnd_push(fnd, n, e);

-	/* Just write updates index into disk */
+	/* Just write updates index into disk. */
 	indx_write(indx, ni, n, 0);

 	n = NULL;
@@ -1745,7 +1744,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 /*
  * indx_insert_into_buffer
  *
- * attempts to insert an entry into an Index Allocation Buffer.
+ * Attempt to insert an entry into an Index Allocation Buffer.
  * If necessary, it will split the buffer.
  */
 static int
@@ -1765,12 +1764,12 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	__le64 t_vbn, *sub_vbn;
 	u16 sp_size;

-	/* Try the most easy case */
+	/* Try the most easy case. */
 	e = fnd->level - 1 == level ? fnd->de[level] : NULL;
 	e = hdr_insert_de(indx, hdr1, new_de, e, ctx);
 	fnd->de[level] = e;
 	if (e) {
-		/* Just write updated index into disk */
+		/* Just write updated index into disk. */
 		indx_write(indx, ni, n1, 0);
 		return 0;
 	}
@@ -1810,7 +1809,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (err)
 		goto out;

-	/* Allocate and format memory a new index buffer */
+	/* Allocate and format memory a new index buffer. */
 	n2 = indx_new(indx, ni, new_vbn, sub_vbn);
 	if (IS_ERR(n2)) {
 		err = PTR_ERR(n2);
@@ -1819,20 +1818,23 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,

 	hdr2 = &n2->index->ihdr;

-	/* Make sp a parent for new buffer */
+	/* Make sp a parent for new buffer. */
 	de_set_vbn(up_e, new_vbn);

-	/* copy all the entries <= sp into the new buffer. */
+	/* Copy all the entries <= sp into the new buffer. */
 	de_t = hdr_first_de(hdr1);
 	to_copy = PtrOffset(de_t, sp);
 	hdr_insert_head(hdr2, de_t, to_copy);

-	/* remove all entries (sp including) from hdr1 */
+	/* Remove all entries (sp including) from hdr1. */
 	used = le32_to_cpu(hdr1->used) - to_copy - sp_size;
 	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
 	hdr1->used = cpu_to_le32(used);

-	/* Insert new entry into left or right buffer (depending on sp <=> new_de) */
+	/*
+	 * Insert new entry into left or right buffer
+	 * (depending on sp <=> new_de).
+	 */
 	hdr_insert_de(indx,
 		      (*indx->cmp)(new_de + 1, le16_to_cpu(new_de->key_size),
 				   up_e + 1, le16_to_cpu(up_e->key_size),
@@ -1849,18 +1851,18 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	put_indx_node(n2);

 	/*
-	 * we've finished splitting everybody, so we are ready to
+	 * We've finished splitting everybody, so we are ready to
 	 * insert the promoted entry into the parent.
 	 */
 	if (!level) {
-		/* Insert in root */
+		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd);
 		if (err)
 			goto out;
 	} else {
 		/*
-		 * The target buffer's parent is another index buffer
-		 * TODO: Remove recursion
+		 * The target buffer's parent is another index buffer.
+		 * TODO: Remove recursion.
 		 */
 		err = indx_insert_into_buffer(indx, ni, root, up_e, ctx,
 					      level - 1, fnd);
@@ -1875,9 +1877,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * indx_insert_entry
- *
- * inserts new entry into index
+ * indx_insert_entry - Insert new entry into index.
  */
 int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		      const struct NTFS_DE *new_de, const void *ctx,
@@ -1905,7 +1905,10 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}

 	if (fnd_is_empty(fnd)) {
-		/* Find the spot the tree where we want to insert the new entry. */
+		/*
+		 * Find the spot the tree where we want to
+		 * insert the new entry.
+		 */
 		err = indx_find(indx, ni, root, new_de + 1,
 				le16_to_cpu(new_de->key_size), ctx, &diff, &e,
 				fnd);
@@ -1919,13 +1922,18 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}

 	if (!fnd->level) {
-		/* The root is also a leaf, so we'll insert the new entry into it. */
+		/*
+		 * The root is also a leaf, so we'll insert the
+		 * new entry into it.
+		 */
 		err = indx_insert_into_root(indx, ni, new_de, fnd->root_de, ctx,
 					    fnd);
 		if (err)
 			goto out;
 	} else {
-		/* found a leaf buffer, so we'll insert the new entry into it.*/
+		/*
+		 * Found a leaf buffer, so we'll insert the new entry into it.
+		 */
 		err = indx_insert_into_buffer(indx, ni, root, new_de, ctx,
 					      fnd->level - 1, fnd);
 		if (err)
@@ -1939,9 +1947,7 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 }

 /*
- * indx_find_buffer
- *
- * locates a buffer the tree.
+ * indx_find_buffer - Locate a buffer from the tree.
  */
 static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 					  struct ntfs_inode *ni,
@@ -1953,7 +1959,7 @@ static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 	struct indx_node *r;
 	const struct INDEX_HDR *hdr = n ? &n->index->ihdr : &root->ihdr;

-	/* Step 1: Scan one level */
+	/* Step 1: Scan one level. */
 	for (e = hdr_first_de(hdr);; e = hdr_next_de(hdr, e)) {
 		if (!e)
 			return ERR_PTR(-EINVAL);
@@ -1965,7 +1971,7 @@ static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 			break;
 	}

-	/* Step2: Do recursion */
+	/* Step2: Do recursion. */
 	e = Add2Ptr(hdr, le32_to_cpu(hdr->de_off));
 	for (;;) {
 		if (de_has_vcn_ex(e)) {
@@ -1988,9 +1994,7 @@ static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 }

 /*
- * indx_shrink
- *
- * deallocates unused tail indexes
+ * indx_shrink - Deallocate unused tail indexes.
  */
 static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 		       size_t bit)
@@ -2067,7 +2071,7 @@ static int indx_free_children(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return err;

 	hdr = &n->index->ihdr;
-	/* First, recurse into the children, if any.*/
+	/* First, recurse into the children, if any. */
 	if (hdr_has_subnode(hdr)) {
 		for (e = hdr_first_de(hdr); e; e = hdr_next_de(hdr, e)) {
 			indx_free_children(indx, ni, e, false);
@@ -2079,7 +2083,9 @@ static int indx_free_children(struct ntfs_index *indx, struct ntfs_inode *ni,
 	put_indx_node(n);

 	i = vbn >> indx->idx2vbn_bits;
-	/* We've gotten rid of the children; add this buffer to the free list. */
+	/*
+	 * We've gotten rid of the children; add this buffer to the free list.
+	 */
 	indx_mark_free(indx, ni, i);

 	if (!trim)
@@ -2087,8 +2093,8 @@ static int indx_free_children(struct ntfs_index *indx, struct ntfs_inode *ni,

 	/*
 	 * If there are no used indexes after current free index
-	 * then we can truncate allocation and bitmap
-	 * Use bitmap to estimate the case
+	 * then we can truncate allocation and bitmap.
+	 * Use bitmap to estimate the case.
 	 */
 	indx_shrink(indx, ni, i + 1);
 	return 0;
@@ -2097,9 +2103,9 @@ static int indx_free_children(struct ntfs_index *indx, struct ntfs_inode *ni,
 /*
  * indx_get_entry_to_replace
  *
- * finds a replacement entry for a deleted entry
- * always returns a node entry:
- * NTFS_IE_HAS_SUBNODES is set the flags and the size includes the sub_vcn
+ * Find a replacement entry for a deleted entry.
+ * Always returns a node entry:
+ * NTFS_IE_HAS_SUBNODES is set the flags and the size includes the sub_vcn.
  */
 static int indx_get_entry_to_replace(struct ntfs_index *indx,
 				     struct ntfs_inode *ni,
@@ -2116,7 +2122,7 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,

 	*de_to_replace = NULL;

-	/* Find first leaf entry down from de_next */
+	/* Find first leaf entry down from de_next. */
 	vbn = de_get_vbn(de_next);
 	for (;;) {
 		n = NULL;
@@ -2129,8 +2135,8 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,

 		if (!de_is_last(e)) {
 			/*
-			 * This buffer is non-empty, so its first entry could be used as the
-			 * replacement entry.
+			 * This buffer is non-empty, so its first entry
+			 * could be used as the replacement entry.
 			 */
 			level = fnd->level - 1;
 		}
@@ -2138,7 +2144,7 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,
 		if (!de_has_vcn(e))
 			break;

-		/* This buffer is a node. Continue to go down */
+		/* This buffer is a node. Continue to go down. */
 		vbn = de_get_vbn(e);
 	}

@@ -2159,15 +2165,16 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,

 	if (!de_has_vcn(re)) {
 		/*
-		 * The replacement entry we found doesn't have a sub_vcn. increase its size
-		 * to hold one.
+		 * The replacement entry we found doesn't have a sub_vcn.
+		 * increase its size to hold one.
 		 */
 		le16_add_cpu(&re->size, sizeof(u64));
 		re->flags |= NTFS_IE_HAS_SUBNODES;
 	} else {
 		/*
-		 * The replacement entry we found was a node entry, which means that all
-		 * its child buffers are empty. Return them to the free pool.
+		 * The replacement entry we found was a node entry, which
+		 * means that all its child buffers are empty. Return them
+		 * to the free pool.
 		 */
 		indx_free_children(indx, ni, te, true);
 	}
@@ -2192,9 +2199,7 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,
 }

 /*
- * indx_delete_entry
- *
- * deletes an entry from the index.
+ * indx_delete_entry - Delete an entry from the index.
  */
 int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		      const void *key, u32 key_len, const void *ctx)
@@ -2258,13 +2263,13 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 	e_size = le16_to_cpu(e->size);

 	if (!de_has_vcn_ex(e)) {
-		/* The entry to delete is a leaf, so we can just rip it out */
+		/* The entry to delete is a leaf, so we can just rip it out. */
 		hdr_delete_de(hdr, e);

 		if (!level) {
 			hdr->total = hdr->used;

-			/* Shrink resident root attribute */
+			/* Shrink resident root attribute. */
 			mi_resize_attr(mi, attr, 0 - e_size);
 			goto out;
 		}
@@ -2307,9 +2312,10 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		} else {
 			/*
 			 * There is no replacement for the current entry.
-			 * This means that the subtree rooted at its node is empty,
-			 * and can be deleted, which turn means that the node can
-			 * just inherit the deleted entry sub_vcn
+			 * This means that the subtree rooted at its node
+			 * is empty, and can be deleted, which turn means
+			 * that the node can just inherit the deleted
+			 * entry sub_vcn.
 			 */
 			indx_free_children(indx, ni, next, true);

@@ -2320,17 +2326,17 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 			} else {
 				hdr->total = hdr->used;

-				/* Shrink resident root attribute */
+				/* Shrink resident root attribute. */
 				mi_resize_attr(mi, attr, 0 - e_size);
 			}
 		}
 	}

-	/* Delete a branch of tree */
+	/* Delete a branch of tree. */
 	if (!fnd2 || !fnd2->level)
 		goto out;

-	/* Reinit root 'cause it can be changed */
+	/* Reinit root 'cause it can be changed. */
 	root = indx_get_root(indx, ni, &attr, &mi);
 	if (!root) {
 		err = -EINVAL;
@@ -2344,7 +2350,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,

 	hdr = level ? &fnd->nodes[level - 1]->index->ihdr : &root->ihdr;

-	/* Scan current level */
+	/* Scan current level. */
 	for (e = hdr_first_de(hdr);; e = hdr_next_de(hdr, e)) {
 		if (!e) {
 			err = -EINVAL;
@@ -2361,7 +2367,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}

 	if (!e) {
-		/* Do slow search from root */
+		/* Do slow search from root. */
 		struct indx_node *in;

 		fnd_clear(fnd);
@@ -2376,7 +2382,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 			fnd_push(fnd, in, NULL);
 	}

-	/* Merge fnd2 -> fnd */
+	/* Merge fnd2 -> fnd. */
 	for (level = 0; level < fnd2->level; level++) {
 		fnd_push(fnd, fnd2->nodes[level], fnd2->de[level]);
 		fnd2->nodes[level] = NULL;
@@ -2422,8 +2428,8 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,

 		if (sub_vbn != de_get_vbn_le(e)) {
 			/*
-			 * Didn't find the parent entry, although this buffer is the parent trail.
-			 * Something is corrupt.
+			 * Didn't find the parent entry, although this buffer
+			 * is the parent trail. Something is corrupt.
 			 */
 			err = -EINVAL;
 			goto out;
@@ -2431,11 +2437,11 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,

 		if (de_is_last(e)) {
 			/*
-			 * Since we can't remove the end entry, we'll remove its
-			 * predecessor instead. This means we have to transfer the
-			 * predecessor's sub_vcn to the end entry.
-			 * Note: that this index block is not empty, so the
-			 * predecessor must exist
+			 * Since we can't remove the end entry, we'll remove
+			 * its predecessor instead. This means we have to
+			 * transfer the predecessor's sub_vcn to the end entry.
+			 * Note: This index block is not empty, so the
+			 * predecessor must exist.
 			 */
 			if (!prev) {
 				err = -EINVAL;
@@ -2453,9 +2459,9 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		}

 		/*
-		 * Copy the current entry into a temporary buffer (stripping off its
-		 * down-pointer, if any) and delete it from the current buffer or root,
-		 * as appropriate.
+		 * Copy the current entry into a temporary buffer (stripping
+		 * off its down-pointer, if any) and delete it from the current
+		 * buffer or root, as appropriate.
 		 */
 		e_size = le16_to_cpu(e->size);
 		me = ntfs_memdup(e, e_size);
@@ -2475,14 +2481,14 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 			level = 0;
 			hdr->total = hdr->used;

-			/* Shrink resident root attribute */
+			/* Shrink resident root attribute. */
 			mi_resize_attr(mi, attr, 0 - e_size);
 		} else {
 			indx_write(indx, ni, n2d, 0);
 			level = level2;
 		}

-		/* Mark unused buffers as free */
+		/* Mark unused buffers as free. */
 		trim_bit = -1;
 		for (; level < fnd->level; level++) {
 			ib = fnd->nodes[level]->index;
@@ -2513,8 +2519,8 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 	} else {
 		/*
 		 * This tree needs to be collapsed down to an empty root.
-		 * Recreate the index root as an empty leaf and free all the bits the
-		 * index allocation bitmap.
+		 * Recreate the index root as an empty leaf and free all
+		 * the bits the index allocation bitmap.
 		 */
 		fnd_clear(fnd);
 		fnd_clear(fnd2);
@@ -2549,7 +2555,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 			goto out;
 		}

-		/* Fill first entry */
+		/* Fill first entry. */
 		e = (struct NTFS_DE *)(root + 1);
 		e->ref.low = 0;
 		e->ref.high = 0;
@@ -2598,7 +2604,7 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
 		goto out;
 	}

-	/* Find entries tree and on disk */
+	/* Find entries tree and on disk. */
 	err = indx_find(indx, ni, root, fname, fname_full_size(fname), sbi,
 			&diff, &e, fnd);
 	if (err)
@@ -2617,7 +2623,7 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
 	e_fname = (struct ATTR_FILE_NAME *)(e + 1);

 	if (!memcmp(&e_fname->dup, dup, sizeof(*dup))) {
-		/* nothing to update in index! Try to avoid this call */
+		/* Nothing to update in index! Try to avoid this call. */
 		goto out;
 	}

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3e2056c95e84..fdea73b30f7f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -21,9 +21,7 @@
 #include "ntfs_fs.h"

 /*
- * ntfs_read_mft
- *
- * reads record and parses MFT
+ * ntfs_read_mft - Read record and parses MFT.
  */
 static struct inode *ntfs_read_mft(struct inode *inode,
 				   const struct cpu_str *name,
@@ -89,7 +87,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	}

 	if (le32_to_cpu(rec->total) != sbi->record_size) {
-		// bad inode?
+		// Bad inode?
 		err = -EINVAL;
 		goto out;
 	}
@@ -97,17 +95,17 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (!is_rec_base(rec))
 		goto Ok;

-	/* record should contain $I30 root */
+	/* Record should contain $I30 root. */
 	is_dir = rec->flags & RECORD_FLAG_DIR;

 	inode->i_generation = le16_to_cpu(rec->seq);

-	/* Enumerate all struct Attributes MFT */
+	/* Enumerate all struct Attributes MFT. */
 	le = NULL;
 	attr = NULL;

 	/*
-	 * to reduce tab pressure use goto instead of
+	 * To reduce tab pressure use goto instead of
 	 * while( (attr = ni_enum_attr_ex(ni, attr, &le, NULL) ))
 	 */
 next_attr:
@@ -118,7 +116,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto end_enum;

 	if (le && le->vcn) {
-		/* This is non primary attribute segment. Ignore if not MFT */
+		/* This is non primary attribute segment. Ignore if not MFT. */
 		if (ino != MFT_REC_MFT || attr->type != ATTR_DATA)
 			goto next_attr;

@@ -188,7 +186,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,

 	case ATTR_DATA:
 		if (is_dir) {
-			/* ignore data attribute in dir record */
+			/* Ignore data attribute in dir record. */
 			goto next_attr;
 		}

@@ -202,7 +200,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		     (ino != MFT_REC_SECURE || !attr->non_res ||
 		      attr->name_len != ARRAY_SIZE(SDS_NAME) ||
 		      memcmp(attr_name(attr), SDS_NAME, sizeof(SDS_NAME))))) {
-			/* file contains stream attribute. ignore it */
+			/* File contains stream attribute. Ignore it. */
 			goto next_attr;
 		}

@@ -325,10 +323,10 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 				t32 = le16_to_cpu(attr->nres.run_off);
 			}

-			/* Looks like normal symlink */
+			/* Looks like normal symlink. */
 			ni->i_valid = inode->i_size;

-			/* Clear directory bit */
+			/* Clear directory bit. */
 			if (ni->ni_flags & NI_FLAG_DIR) {
 				indx_clear(&ni->dir);
 				memset(&ni->dir, 0, sizeof(ni->dir));
@@ -340,7 +338,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			is_dir = false;
 			if (attr->non_res) {
 				run = &ni->file.run;
-				goto attr_unpack_run; // double break
+				goto attr_unpack_run; // Double break.
 			}
 			break;

@@ -379,7 +377,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;

 	if (!is_match && name) {
-		/* reuse rec as buffer for ascii name */
+		/* Reuse rec as buffer for ascii name. */
 		err = -ENOENT;
 		goto out;
 	}
@@ -387,7 +385,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (std5->fa & FILE_ATTRIBUTE_READONLY)
 		mode &= ~0222;

-	/* Setup 'uid' and 'gid' */
+	/* Setup 'uid' and 'gid'. */
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;

@@ -400,9 +398,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		ni->std_fa |= FILE_ATTRIBUTE_DIRECTORY;

 		/*
-		 * dot and dot-dot should be included in count but was not
+		 * Dot and dot-dot should be included in count but was not
 		 * included in enumeration.
-		 * Usually a hard links to directories are disabled
+		 * Usually a hard links to directories are disabled.
 		 */
 		set_nlink(inode, 1);
 		inode->i_op = &ntfs_dir_inode_operations;
@@ -428,7 +426,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			init_rwsem(&ni->file.run_lock);
 	} else if (fname && fname->home.low == cpu_to_le32(MFT_REC_EXTEND) &&
 		   fname->home.seq == cpu_to_le16(MFT_REC_EXTEND)) {
-		/* Records in $Extend are not a files or general directories */
+		/* Records in $Extend are not a files or general directories. */
 	} else {
 		err = -EINVAL;
 		goto out;
@@ -444,7 +442,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,

 	inode->i_mode = mode;
 	if (!(ni->ni_flags & NI_FLAG_EA)) {
-		/* if no xattr then no security (stored in xattr) */
+		/* If no xattr then no security (stored in xattr). */
 		inode->i_flags |= S_NOSEC;
 	}

@@ -464,7 +462,11 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	return ERR_PTR(err);
 }

-/* returns 1 if match */
+/*
+ * ntfs_test_inode
+ *
+ * Return: 1 if match.
+ */
 static int ntfs_test_inode(struct inode *inode, void *data)
 {
 	struct MFT_REF *ref = data;
@@ -494,7 +496,7 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* inode overlaps? */
+		/* Inode overlaps? */
 		make_bad_inode(inode);
 	}

@@ -525,18 +527,18 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	CLST vcn, lcn, len;
 	bool new;

-	/*clear previous state*/
+	/* Clear previous state. */
 	clear_buffer_new(bh);
 	clear_buffer_uptodate(bh);

-	/* direct write uses 'create=0'*/
+	/* Direct write uses 'create=0'. */
 	if (!create && vbo >= ni->i_valid) {
-		/* out of valid */
+		/* Out of valid. */
 		return 0;
 	}

 	if (vbo >= inode->i_size) {
-		/* out of size */
+		/* Out of size. */
 		return 0;
 	}

@@ -589,7 +591,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	valid = ni->i_valid;

 	if (ctx == GET_BLOCK_DIRECT_IO_W) {
-		/*ntfs_direct_IO will update ni->i_valid */
+		/* ntfs_direct_IO will update ni->i_valid. */
 		if (vbo >= valid)
 			set_buffer_new(bh);
 	} else if (create) {
@@ -602,20 +604,18 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 			mark_inode_dirty(inode);
 		}
 	} else if (valid >= inode->i_size) {
-		/* normal read of normal file*/
+		/* Normal read of normal file. */
 	} else if (vbo >= valid) {
-		/* read out of valid data*/
-		/* should never be here 'cause already checked */
+		/* Read out of valid data. */
+		/* Should never be here 'cause already checked. */
 		clear_buffer_mapped(bh);
 	} else if (vbo + bytes <= valid) {
-		/* normal read */
+		/* Normal read. */
 	} else if (vbo + block_size <= valid) {
-		/* normal short read */
+		/* Normal short read. */
 		bytes = block_size;
 	} else {
-		/*
-		 * read across valid size: vbo < valid && valid < vbo + block_size
-		 */
+		/* Read across valid size: vbo < valid && valid < vbo + block_size */
 		u32 voff = valid - vbo;

 		bh->b_size = bytes = block_size;
@@ -692,7 +692,7 @@ static int ntfs_readpage(struct file *file, struct page *page)
 		return err;
 	}

-	/* normal + sparse files */
+	/* Normal + sparse files. */
 	return mpage_readpage(page, ntfs_get_block);
 }

@@ -705,12 +705,12 @@ static void ntfs_readahead(struct readahead_control *rac)
 	loff_t pos;

 	if (is_resident(ni)) {
-		/* no readahead for resident */
+		/* No readahead for resident. */
 		return;
 	}

 	if (is_compressed(ni)) {
-		/* no readahead for compressed */
+		/* No readahead for compressed. */
 		return;
 	}

@@ -719,7 +719,7 @@ static void ntfs_readahead(struct readahead_control *rac)

 	if (valid < i_size_read(inode) && pos <= valid &&
 	    valid < pos + readahead_length(rac)) {
-		/* range cross 'valid'. read it page by page */
+		/* Range cross 'valid'. Read it page by page. */
 		return;
 	}

@@ -756,7 +756,7 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret;

 	if (is_resident(ni)) {
-		/*switch to buffered write*/
+		/* Switch to buffered write. */
 		ret = 0;
 		goto out;
 	}
@@ -775,14 +775,14 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			mark_inode_dirty(inode);
 		}
 	} else if (vbo < valid && valid < end) {
-		/* fix page */
+		/* Fix page. */
 		unsigned long uaddr = ~0ul;
 		struct page *page;
 		long i, npages;
 		size_t dvbo = valid - vbo;
 		size_t off = 0;

-		/*Find user address*/
+		/* Find user address. */
 		for (i = 0; i < nr_segs; i++) {
 			if (off <= dvbo && dvbo < off + iov[i].iov_len) {
 				uaddr = (unsigned long)iov[i].iov_base + dvbo -
@@ -818,7 +818,7 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	struct ntfs_inode *ni = ntfs_i(inode);
 	int err;

-	/* Check for maximum file size */
+	/* Check for maximum file size. */
 	if (is_sparsed(ni) || is_compressed(ni)) {
 		if (new_size > sbi->maxbytes_sparse) {
 			err = -EFBIG;
@@ -869,7 +869,7 @@ static int ntfs_writepages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
-	/* redirect call to 'ntfs_writepage' for resident files*/
+	/* Redirect call to 'ntfs_writepage' for resident files. */
 	get_block_t *get_block = is_resident(ni) ? NULL : &ntfs_get_block;

 	return mpage_writepages(mapping, wbc, get_block);
@@ -922,7 +922,9 @@ static int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	return err;
 }

-/* address_space_operations::write_end */
+/*
+ * ntfs_write_end - Address_space_operations::write_end.
+ */
 static int ntfs_write_end(struct file *file, struct address_space *mapping,
 			  loff_t pos, u32 len, u32 copied, struct page *page,
 			  void *fsdata)
@@ -940,7 +942,7 @@ static int ntfs_write_end(struct file *file, struct address_space *mapping,
 		ni_unlock(ni);
 		if (!err) {
 			dirty = true;
-			/* clear any buffers in page*/
+			/* Clear any buffers in page. */
 			if (page_has_buffers(page)) {
 				struct buffer_head *head, *bh;

@@ -969,7 +971,7 @@ static int ntfs_write_end(struct file *file, struct address_space *mapping,
 		}

 		if (valid != ni->i_valid) {
-			/* ni->i_valid is changed in ntfs_get_block_vbo */
+			/* ni->i_valid is changed in ntfs_get_block_vbo. */
 			dirty = true;
 		}

@@ -1030,10 +1032,11 @@ int ntfs_sync_inode(struct inode *inode)
 }

 /*
- * helper function for ntfs_flush_inodes.  This writes both the inode
- * and the file data blocks, waiting for in flight data blocks before
- * the start of the call.  It does not wait for any io started
- * during the call
+ * writeback_inode - Helper function for ntfs_flush_inodes().
+ *
+ * This writes both the inode and the file data blocks, waiting
+ * for in flight data blocks before the start of the call.  It
+ * does not wait for any io started during the call.
  */
 static int writeback_inode(struct inode *inode)
 {
@@ -1045,12 +1048,14 @@ static int writeback_inode(struct inode *inode)
 }

 /*
- * write data and metadata corresponding to i1 and i2.  The io is
+ * ntfs_flush_inodes
+ *
+ * Write data and metadata corresponding to i1 and i2.  The io is
  * started but we do not wait for any of it to finish.
  *
- * filemap_flush is used for the block device, so if there is a dirty
+ * filemap_flush() is used for the block device, so if there is a dirty
  * page for a block already in flight, we will not wait and start the
- * io over again
+ * io over again.
  */
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2)
@@ -1070,7 +1075,7 @@ int inode_write_data(struct inode *inode, const void *data, size_t bytes)
 {
 	pgoff_t idx;

-	/* Write non resident data */
+	/* Write non resident data. */
 	for (idx = 0; bytes; idx++) {
 		size_t op = bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
 		struct page *page = ntfs_map_page(inode->i_mapping, idx);
@@ -1097,12 +1102,14 @@ int inode_write_data(struct inode *inode, const void *data, size_t bytes)
 }

 /*
- * number of bytes to for REPARSE_DATA_BUFFER(IO_REPARSE_TAG_SYMLINK)
- * for unicode string of 'uni_len' length
+ * ntfs_reparse_bytes
+ *
+ * Number of bytes to for REPARSE_DATA_BUFFER(IO_REPARSE_TAG_SYMLINK)
+ * for unicode string of @uni_len length.
  */
 static inline u32 ntfs_reparse_bytes(u32 uni_len)
 {
-	/* header + unicode string + decorated unicode string */
+	/* Header + unicode string + decorated unicode string. */
 	return sizeof(short) * (2 * uni_len + 4) +
 	       offsetof(struct REPARSE_DATA_BUFFER,
 			SymbolicLinkReparseBuffer.PathBuffer);
@@ -1124,14 +1131,14 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	rs = &rp->SymbolicLinkReparseBuffer;
 	rp_name = rs->PathBuffer;

-	/* Convert link name to utf16 */
+	/* Convert link name to UTF-16. */
 	err = ntfs_nls_to_utf16(sbi, symname, size,
 				(struct cpu_str *)(rp_name - 1), 2 * size,
 				UTF16_LITTLE_ENDIAN);
 	if (err < 0)
 		goto out;

-	/* err = the length of unicode name of symlink */
+	/* err = the length of unicode name of symlink. */
 	*nsize = ntfs_reparse_bytes(err);

 	if (*nsize > sbi->reparse.max_size) {
@@ -1139,7 +1146,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 		goto out;
 	}

-	/* translate linux '/' into windows '\' */
+	/* Translate Linux '/' into Windows '\'. */
 	for (i = 0; i < err; i++) {
 		if (rp_name[i] == cpu_to_le16('/'))
 			rp_name[i] = cpu_to_le16('\\');
@@ -1150,20 +1157,21 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 		cpu_to_le16(*nsize - offsetof(struct REPARSE_DATA_BUFFER,
 					      SymbolicLinkReparseBuffer));

-	/* PrintName + SubstituteName */
+	/* PrintName + SubstituteName. */
 	rs->SubstituteNameOffset = cpu_to_le16(sizeof(short) * err);
 	rs->SubstituteNameLength = cpu_to_le16(sizeof(short) * err + 8);
 	rs->PrintNameLength = rs->SubstituteNameOffset;

 	/*
-	 * TODO: use relative path if possible to allow windows to parse this path
-	 * 0-absolute path 1- relative path (SYMLINK_FLAG_RELATIVE)
+	 * TODO: Use relative path if possible to allow Windows to
+	 * parse this path.
+	 * 0-absolute path 1- relative path (SYMLINK_FLAG_RELATIVE).
 	 */
 	rs->Flags = 0;

 	memmove(rp_name + err + 4, rp_name, sizeof(short) * err);

-	/* decorate SubstituteName */
+	/* Decorate SubstituteName. */
 	rp_name += err;
 	rp_name[0] = cpu_to_le16('\\');
 	rp_name[1] = cpu_to_le16('?');
@@ -1217,7 +1225,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		return ERR_PTR(-EINVAL);

 	if (is_dir) {
-		/* use parent's directory attributes */
+		/* Use parent's directory attributes. */
 		fa = dir_ni->std_fa | FILE_ATTRIBUTE_DIRECTORY |
 		     FILE_ATTRIBUTE_ARCHIVE;
 		/*
@@ -1228,17 +1236,20 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		if (dir->i_ino == MFT_REC_ROOT)
 			fa &= ~(FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_SYSTEM);
 	} else if (is_link) {
-		/* It is good idea that link should be the same type (file/dir) as target */
+		/*
+		 * It is good idea that link should be the same
+		 * type (file/dir) as target.
+		 */
 		fa = FILE_ATTRIBUTE_REPARSE_POINT;

 		/*
-		 * linux: there are dir/file/symlink and so on
-		 * NTFS: symlinks are "dir + reparse" or "file + reparse"
+		 * Linux: There are dir/file/symlink and so on.
+		 * NTFS: symlinks are "dir + reparse" or "file + reparse".
 		 * It is good idea to create:
 		 * dir + reparse if 'symname' points to directory
 		 * or
 		 * file + reparse if 'symname' points to file
-		 * Unfortunately kern_path hangs if symname contains 'dir'
+		 * Unfortunately kern_path hangs if symname contains 'dir'.
 		 */

 		/*
@@ -1256,30 +1267,30 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		 *	}
 		 */
 	} else if (sbi->options.sparse) {
-		/* sparsed regular file, cause option 'sparse' */
+		/* Sparsed regular file, cause option 'sparse'. */
 		fa = FILE_ATTRIBUTE_SPARSE_FILE | FILE_ATTRIBUTE_ARCHIVE;
 	} else if (dir_ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) {
-		/* compressed regular file, if parent is compressed */
+		/* Compressed regular file, if parent is compressed. */
 		fa = FILE_ATTRIBUTE_COMPRESSED | FILE_ATTRIBUTE_ARCHIVE;
 	} else {
-		/* regular file, default attributes */
+		/* Regular file, default attributes. */
 		fa = FILE_ATTRIBUTE_ARCHIVE;
 	}

 	if (!(mode & 0222))
 		fa |= FILE_ATTRIBUTE_READONLY;

-	/* allocate PATH_MAX bytes */
+	/* Allocate PATH_MAX bytes. */
 	new_de = __getname();
 	if (!new_de) {
 		err = -ENOMEM;
 		goto out1;
 	}

-	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	/* Mark rw ntfs as dirty. it will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);

-	/* Step 1: allocate and fill new mft record */
+	/* Step 1: Allocate and fill new MFT record. */
 	err = ntfs_look_free_mft(sbi, &ino, false, NULL, NULL);
 	if (err)
 		goto out2;
@@ -1299,7 +1310,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	rec->hard_links = cpu_to_le16(1);
 	attr = Add2Ptr(rec, le16_to_cpu(rec->attr_off));

-	/* Get default security id */
+	/* Get default security id. */
 	sd = s_default_security;
 	sd_size = sizeof(s_default_security);

@@ -1315,7 +1326,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		}
 	}

-	/* Insert standard info */
+	/* Insert standard info. */
 	std5 = Add2Ptr(attr, SIZEOF_RESIDENT);

 	if (security_id == SECURITY_ID_INVALID) {
@@ -1341,7 +1352,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,

 	attr = Add2Ptr(attr, asize);

-	/* Insert file name */
+	/* Insert file name. */
 	err = fill_name_de(sbi, new_de, name, uni);
 	if (err)
 		goto out4;
@@ -1370,7 +1381,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	attr = Add2Ptr(attr, asize);

 	if (security_id == SECURITY_ID_INVALID) {
-		/* Insert security attribute */
+		/* Insert security attribute. */
 		asize = SIZEOF_RESIDENT + QuadAlign(sd_size);

 		attr->type = ATTR_SECURE;
@@ -1385,8 +1396,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,

 	if (fa & FILE_ATTRIBUTE_DIRECTORY) {
 		/*
-		 * regular directory or symlink to directory
-		 * Create root attribute
+		 * Regular directory or symlink to directory.
+		 * Create root attribute.
 		 */
 		dsize = sizeof(struct INDEX_ROOT) + sizeof(struct NTFS_DE);
 		asize = sizeof(I30_NAME) + SIZEOF_RESIDENT + dsize;
@@ -1416,12 +1427,12 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		e->flags = NTFS_IE_LAST;
 	} else if (is_link) {
 		/*
-		 * symlink to file
-		 * Create empty resident data attribute
+		 * Symlink to file.
+		 * Create empty resident data attribute.
 		 */
 		asize = SIZEOF_RESIDENT;

-		/* insert empty ATTR_DATA */
+		/* Insert empty ATTR_DATA */
 		attr->type = ATTR_DATA;
 		attr->size = cpu_to_le32(SIZEOF_RESIDENT);
 		attr->id = cpu_to_le16(aid++);
@@ -1429,11 +1440,11 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		attr->res.data_off = SIZEOF_RESIDENT_LE;
 	} else {
 		/*
-		 * regular file
+		 * Regular file.
 		 */
 		attr->type = ATTR_DATA;
 		attr->id = cpu_to_le16(aid++);
-		/* Create empty non resident data attribute */
+		/* Create empty non resident data attribute. */
 		attr->non_res = 1;
 		attr->nres.evcn = cpu_to_le64(-1ll);
 		if (fa & FILE_ATTRIBUTE_SPARSE_FILE) {
@@ -1470,13 +1481,13 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		}

 		/*
-		 * Insert ATTR_REPARSE
+		 * Insert ATTR_REPARSE.
 		 */
 		attr = Add2Ptr(attr, asize);
 		attr->type = ATTR_REPARSE;
 		attr->id = cpu_to_le16(aid++);

-		/* resident or non resident? */
+		/* Resident or non resident? */
 		asize = QuadAlign(SIZEOF_RESIDENT + nsize);
 		t16 = PtrOffset(rec, attr);

@@ -1484,7 +1495,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 			CLST alen;
 			CLST clst = bytes_to_cluster(sbi, nsize);

-			/* bytes per runs */
+			/* Bytes per runs. */
 			t16 = sbi->record_size - t16 - SIZEOF_NONRESIDENT;

 			attr->non_res = 1;
@@ -1539,15 +1550,15 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	rec->used = cpu_to_le32(PtrOffset(rec, attr) + 8);
 	rec->next_attr_id = cpu_to_le16(aid);

-	/* Step 2: Add new name in index */
+	/* Step 2: Add new name in index. */
 	err = indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, fnd);
 	if (err)
 		goto out6;

-	/* Update current directory record */
+	/* Update current directory record. */
 	mark_inode_dirty(dir);

-	/* Fill vfs inode fields */
+	/* Fill vfs inode fields. */
 	inode->i_uid = sbi->options.uid ? sbi->options.fs_uid : current_fsuid();
 	inode->i_gid = sbi->options.gid		 ? sbi->options.fs_gid
 		       : (dir->i_mode & S_ISGID) ? dir->i_gid
@@ -1586,25 +1597,27 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		inode->i_flags |= S_NOSEC;
 	}

-	/* Write non resident data */
+	/* Write non resident data. */
 	if (nsize) {
 		err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize);
 		if (err)
 			goto out7;
 	}

-	/* call 'd_instantiate' after inode->i_op is set but before finish_open */
+	/*
+	 * Call 'd_instantiate' after inode->i_op is
+	 * set but before finish_open. */
 	d_instantiate(dentry, inode);

 	mark_inode_dirty(inode);
 	mark_inode_dirty(dir);

-	/* normal exit */
+	/* Normal exit. */
 	goto out2;

 out7:

-	/* undo 'indx_insert_entry' */
+	/* Undo 'indx_insert_entry'. */
 	indx_delete_entry(&dir_ni->dir, dir_ni, new_de + 1,
 			  le16_to_cpu(new_de->key_size), sbi);
 out6:
@@ -1657,15 +1670,15 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	if (!dir_root)
 		return -EINVAL;

-	/* allocate PATH_MAX bytes */
+	/* Allocate PATH_MAX bytes. */
 	new_de = __getname();
 	if (!new_de)
 		return -ENOMEM;

-	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	/* Mark rw ntfs as dirty.  It will be cleared at umount. */
 	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);

-	// Insert file name
+	/* Insert file name. */
 	err = fill_name_de(sbi, new_de, name, NULL);
 	if (err)
 		goto out;
@@ -1739,23 +1752,23 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 		goto out1;
 	}

-	/* allocate PATH_MAX bytes */
+	/* Allocate PATH_MAX bytes. */
 	uni = __getname();
 	if (!uni) {
 		err = -ENOMEM;
 		goto out1;
 	}

-	/* Convert input string to unicode */
+	/* Convert input string to unicode. */
 	err = ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
 				UTF16_HOST_ENDIAN);
 	if (err < 0)
 		goto out2;

-	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	/* Mark rw ntfs as dirty.  It will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);

-	/* find name in record */
+	/* Find name in record. */
 	mi_get_ref(&dir_ni->mi, &ref);

 	le = NULL;
@@ -1772,14 +1785,14 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 	if (err)
 		goto out3;

-	/* Then remove name from mft */
+	/* Then remove name from MFT. */
 	ni_remove_attr_le(ni, attr_from_name(fname), le);

 	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
 	ni->mi.dirty = true;

 	if (name_type != FILE_NAME_POSIX) {
-		/* Now we should delete name by type */
+		/* Now we should delete name by type. */
 		fname = ni_fname_type(ni, name_type, &le);
 		if (fname) {
 			err = indx_delete_entry(indx, dir_ni, fname,
@@ -1844,13 +1857,13 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 	struct le_str *uni;
 	struct ATTRIB *attr;

-	/* Reparse data present. Try to parse it */
+	/* Reparse data present. Try to parse it. */
 	static_assert(!offsetof(struct REPARSE_DATA_BUFFER, ReparseTag));
 	static_assert(sizeof(u32) == sizeof(rp->ReparseTag));

 	*buffer = 0;

-	/* Read into temporal buffer */
+	/* Read into temporal buffer. */
 	if (i_size > sbi->reparse.max_size || i_size <= sizeof(u32)) {
 		err = -EINVAL;
 		goto out;
@@ -1882,10 +1895,10 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,

 	err = -EINVAL;

-	/* Microsoft Tag */
+	/* Microsoft Tag. */
 	switch (rp->ReparseTag) {
 	case IO_REPARSE_TAG_MOUNT_POINT:
-		/* Mount points and junctions */
+		/* Mount points and junctions. */
 		/* Can we use 'Rp->MountPointReparseBuffer.PrintNameLength'? */
 		if (i_size <= offsetof(struct REPARSE_DATA_BUFFER,
 				       MountPointReparseBuffer.PathBuffer))
@@ -1947,20 +1960,20 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 			goto out;
 		}

-		/* Users tag */
+		/* Users tag. */
 		uni = Add2Ptr(rp, sizeof(struct REPARSE_POINT) - 2);
 		nlen = le16_to_cpu(rp->ReparseDataLength) -
 		       sizeof(struct REPARSE_POINT);
 	}

-	/* Convert nlen from bytes to UNICODE chars */
+	/* Convert nlen from bytes to UNICODE chars. */
 	nlen >>= 1;

-	/* Check that name is available */
+	/* Check that name is available. */
 	if (!nlen || &uni->name[nlen] > (__le16 *)Add2Ptr(rp, i_size))
 		goto out;

-	/* If name is already zero terminated then truncate it now */
+	/* If name is already zero terminated then truncate it now. */
 	if (!uni->name[nlen - 1])
 		nlen -= 1;
 	uni->len = nlen;
@@ -1970,13 +1983,13 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 	if (err < 0)
 		goto out;

-	/* translate windows '\' into linux '/' */
+	/* Translate Windows '\' into Linux '/'. */
 	for (i = 0; i < err; i++) {
 		if (buffer[i] == '\\')
 			buffer[i] = '/';
 	}

-	/* Always set last zero */
+	/* Always set last zero. */
 	buffer[err] = 0;
 out:
 	ntfs_free(to_free);
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index ead9ab7d69b3..601752109242 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
  */
+
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
@@ -14,7 +15,7 @@
 #include "ntfs_fs.h"

 // clang-format off
-/* src buffer is zero */
+/* Src buffer is zero. */
 #define LZNT_ERROR_ALL_ZEROS	1
 #define LZNT_CHUNK_SIZE		0x1000
 // clang-format on
@@ -72,7 +73,7 @@ static size_t longest_match_std(const u8 *src, struct lznt *ctx)
 					      hash[1] + 3, ctx->max_len - 3);
 	}

-	/* Compare two matches and select the best one */
+	/* Compare two matches and select the best one. */
 	if (len1 < len2) {
 		ctx->best_match = hash[1];
 		len1 = len2;
@@ -129,10 +130,10 @@ static inline size_t parse_pair(u16 pair, size_t *offset, size_t index)
 /*
  * compress_chunk
  *
- * returns one of the three values:
- * 0 - ok, 'cmpr' contains 'cmpr_chunk_size' bytes of compressed data
- * 1 - input buffer is full zero
- * -2 - the compressed buffer is too small to hold the compressed data
+ * Return:
+ * * 0	- Ok, @cmpr contains @cmpr_chunk_size bytes of compressed data.
+ * * 1	- Input buffer is full zero.
+ * * -2 - The compressed buffer is too small to hold the compressed data.
  */
 static inline int compress_chunk(size_t (*match)(const u8 *, struct lznt *),
 				 const u8 *unc, const u8 *unc_end, u8 *cmpr,
@@ -145,7 +146,7 @@ static inline int compress_chunk(size_t (*match)(const u8 *, struct lznt *),
 	u8 *cp = cmpr + 3;
 	u8 *cp2 = cmpr + 2;
 	u8 not_zero = 0;
-	/* Control byte of 8-bit values: ( 0 - means byte as is, 1 - short pair ) */
+	/* Control byte of 8-bit values: ( 0 - means byte as is, 1 - short pair ). */
 	u8 ohdr = 0;
 	u8 *last;
 	u16 t16;
@@ -165,7 +166,7 @@ static inline int compress_chunk(size_t (*match)(const u8 *, struct lznt *),
 		while (unc + s_max_off[idx] < up)
 			ctx->max_len = s_max_len[++idx];

-		// Find match
+		/* Find match. */
 		max_len = up + 3 <= unc_end ? (*match)(up, ctx) : 0;

 		if (!max_len) {
@@ -211,7 +212,7 @@ static inline int compress_chunk(size_t (*match)(const u8 *, struct lznt *),
 		return -2;

 	/*
-	 * Copy non cmpr data
+	 * Copy non cmpr data.
 	 * 0x3FFF == ((LZNT_CHUNK_SIZE + 2 - 3) | 0x3000)
 	 */
 	cmpr[0] = 0xff;
@@ -233,38 +234,38 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 	u16 pair;
 	size_t offset, length;

-	/* Do decompression until pointers are inside range */
+	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;

-		/* Check the current flag for zero */
+		/* Check the current flag for zero. */
 		if (!(ch & (1 << bit))) {
-			/* Just copy byte */
+			/* Just copy byte. */
 			*up++ = *cmpr++;
 			goto next;
 		}

-		/* Check for boundary */
+		/* Check for boundary. */
 		if (cmpr + 1 >= cmpr_end)
 			return -EINVAL;

-		/* Read a short from little endian stream */
+		/* Read a short from little endian stream. */
 		pair = cmpr[1];
 		pair <<= 8;
 		pair |= cmpr[0];

 		cmpr += 2;

-		/* Translate packed information into offset and length */
+		/* Translate packed information into offset and length. */
 		length = parse_pair(pair, &offset, index);

-		/* Check offset for boundary */
+		/* Check offset for boundary. */
 		if (unc + offset > up)
 			return -EINVAL;

-		/* Truncate the length if necessary */
+		/* Truncate the length if necessary. */
 		if (up + length >= unc_end)
 			length = unc_end - up;

@@ -273,7 +274,7 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 			*up = *(up - offset);

 next:
-		/* Advance flag bit value */
+		/* Advance flag bit value. */
 		bit = (bit + 1) & 7;

 		if (!bit) {
@@ -284,13 +285,14 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 		}
 	}

-	/* return the size of uncompressed data */
+	/* Return the size of uncompressed data. */
 	return up - unc;
 }

 /*
- * 0 - standard compression
- * !0 - best compression, requires a lot of cpu
+ * get_lznt_ctx
+ * @level: 0 - Standard compression.
+ * 	   !0 - Best compression, requires a lot of cpu.
  */
 struct lznt *get_lznt_ctx(int level)
 {
@@ -303,11 +305,11 @@ struct lznt *get_lznt_ctx(int level)
 }

 /*
- * compress_lznt
+ * compress_lznt - Compresses @unc into @cmpr
  *
- * Compresses "unc" into "cmpr"
- * +x - ok, 'cmpr' contains 'final_compressed_size' bytes of compressed data
- * 0 - input buffer is full zero
+ * Return:
+ * * +x - Ok, @cmpr contains 'final_compressed_size' bytes of compressed data.
+ * * 0 - Input buffer is full zero.
  */
 size_t compress_lznt(const void *unc, size_t unc_size, void *cmpr,
 		     size_t cmpr_size, struct lznt *ctx)
@@ -327,7 +329,7 @@ size_t compress_lznt(const void *unc, size_t unc_size, void *cmpr,
 		match = &longest_match_best;
 	}

-	/* compression cycle */
+	/* Compression cycle. */
 	for (; unc_chunk < unc_end; unc_chunk += LZNT_CHUNK_SIZE) {
 		cmpr_size = 0;
 		err = compress_chunk(match, unc_chunk, unc_end, p, end,
@@ -348,9 +350,7 @@ size_t compress_lznt(const void *unc, size_t unc_size, void *cmpr,
 }

 /*
- * decompress_lznt
- *
- * decompresses "cmpr" into "unc"
+ * decompress_lznt - Decompress @cmpr into @unc.
  */
 ssize_t decompress_lznt(const void *cmpr, size_t cmpr_size, void *unc,
 			size_t unc_size)
@@ -364,24 +364,24 @@ ssize_t decompress_lznt(const void *cmpr, size_t cmpr_size, void *unc,
 	if (cmpr_size < sizeof(short))
 		return -EINVAL;

-	/* read chunk header */
+	/* Read chunk header. */
 	chunk_hdr = cmpr_chunk[1];
 	chunk_hdr <<= 8;
 	chunk_hdr |= cmpr_chunk[0];

-	/* loop through decompressing chunks */
+	/* Loop through decompressing chunks. */
 	for (;;) {
 		size_t chunk_size_saved;
 		size_t unc_use;
 		size_t cmpr_use = 3 + (chunk_hdr & (LZNT_CHUNK_SIZE - 1));

-		/* Check that the chunk actually fits the supplied buffer */
+		/* Check that the chunk actually fits the supplied buffer. */
 		if (cmpr_chunk + cmpr_use > cmpr_end)
 			return -EINVAL;

-		/* First make sure the chunk contains compressed data */
+		/* First make sure the chunk contains compressed data. */
 		if (chunk_hdr & 0x8000) {
-			/* Decompress a chunk and return if we get an error */
+			/* Decompress a chunk and return if we get an error. */
 			ssize_t err =
 				decompress_chunk(unc_chunk, unc_end,
 						 cmpr_chunk + sizeof(chunk_hdr),
@@ -390,7 +390,7 @@ ssize_t decompress_lznt(const void *cmpr, size_t cmpr_size, void *unc,
 				return err;
 			unc_use = err;
 		} else {
-			/* This chunk does not contain compressed data */
+			/* This chunk does not contain compressed data. */
 			unc_use = unc_chunk + LZNT_CHUNK_SIZE > unc_end
 					  ? unc_end - unc_chunk
 					  : LZNT_CHUNK_SIZE;
@@ -404,21 +404,21 @@ ssize_t decompress_lznt(const void *cmpr, size_t cmpr_size, void *unc,
 			       unc_use);
 		}

-		/* Advance pointers */
+		/* Advance pointers. */
 		cmpr_chunk += cmpr_use;
 		unc_chunk += unc_use;

-		/* Check for the end of unc buffer */
+		/* Check for the end of unc buffer. */
 		if (unc_chunk >= unc_end)
 			break;

-		/* Proceed the next chunk */
+		/* Proceed the next chunk. */
 		if (cmpr_chunk > cmpr_end - 2)
 			break;

 		chunk_size_saved = LZNT_CHUNK_SIZE;

-		/* read chunk header */
+		/* Read chunk header. */
 		chunk_hdr = cmpr_chunk[1];
 		chunk_hdr <<= 8;
 		chunk_hdr |= cmpr_chunk[0];
@@ -426,12 +426,12 @@ ssize_t decompress_lznt(const void *cmpr, size_t cmpr_size, void *unc,
 		if (!chunk_hdr)
 			break;

-		/* Check the size of unc buffer */
+		/* Check the size of unc buffer. */
 		if (unc_use < chunk_size_saved) {
 			size_t t1 = chunk_size_saved - unc_use;
 			u8 *t2 = unc_chunk + t1;

-			/* 'Zero' memory */
+			/* 'Zero' memory. */
 			if (t2 >= unc_end)
 				break;

@@ -440,13 +440,13 @@ ssize_t decompress_lznt(const void *cmpr, size_t cmpr_size, void *unc,
 		}
 	}

-	/* Check compression boundary */
+	/* Check compression boundary. */
 	if (cmpr_chunk > cmpr_end)
 		return -EINVAL;

 	/*
 	 * The unc size is just a difference between current
-	 * pointer and original one
+	 * pointer and original one.
 	 */
 	return PtrOffset(unc, unc_chunk);
 }
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f5db12cd3b20..1ef1ef43dfb9 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -17,9 +17,7 @@
 #include "ntfs_fs.h"

 /*
- * fill_name_de
- *
- * formats NTFS_DE in 'buf'
+ * fill_name_de - Format NTFS_DE in @buf.
  */
 int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 		 const struct cpu_str *uni)
@@ -46,7 +44,7 @@ int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 		fname->name_len = uni->len;

 	} else {
-		/* Convert input string to unicode */
+		/* Convert input string to unicode. */
 		err = ntfs_nls_to_utf16(sbi, name->name, name->len,
 					(struct cpu_str *)&fname->name_len,
 					NTFS_NAME_LEN, UTF16_LITTLE_ENDIAN);
@@ -66,9 +64,7 @@ int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 }

 /*
- * ntfs_lookup
- *
- * inode_operations::lookup
+ * ntfs_lookup - inode_operations::lookup
  */
 static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 				  u32 flags)
@@ -98,9 +94,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 }

 /*
- * ntfs_create
- *
- * inode_operations::create
+ * ntfs_create - inode_operations::create
  */
 static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
@@ -119,9 +113,7 @@ static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 }

 /*
- * ntfs_link
- *
- * inode_operations::link
+ * ntfs_link - inode_operations::link
  */
 static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
 {
@@ -161,9 +153,7 @@ static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
 }

 /*
- * ntfs_unlink
- *
- * inode_operations::unlink
+ * ntfs_unlink - inode_operations::unlink
  */
 static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 {
@@ -180,9 +170,7 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 }

 /*
- * ntfs_symlink
- *
- * inode_operations::symlink
+ * ntfs_symlink - inode_operations::symlink
  */
 static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, const char *symname)
@@ -202,9 +190,7 @@ static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 }

 /*
- * ntfs_mkdir
- *
- * inode_operations::mkdir
+ * ntfs_mkdir- inode_operations::mkdir
  */
 static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
@@ -223,9 +209,7 @@ static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 }

 /*
- * ntfs_rmdir
- *
- * inode_operations::rm_dir
+ * ntfs_rmdir - inode_operations::rm_dir
  */
 static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
@@ -242,9 +226,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 }

 /*
- * ntfs_rename
- *
- * inode_operations::rename
+ * ntfs_rename - inode_operations::rename
  */
 static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
@@ -283,7 +265,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			  old_dentry->d_name.len);

 	if (is_same && old_dir == new_dir) {
-		/* Nothing to do */
+		/* Nothing to do. */
 		err = 0;
 		goto out;
 	}
@@ -294,7 +276,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	}

 	if (new_inode) {
-		/*target name exists. unlink it*/
+		/* Target name exists. Unlink it. */
 		dget(new_dentry);
 		ni_lock_dir(new_dir_ni);
 		err = ntfs_unlink_inode(new_dir, new_dentry);
@@ -304,7 +286,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			goto out;
 	}

-	/* allocate PATH_MAX bytes */
+	/* Allocate PATH_MAX bytes. */
 	old_de = __getname();
 	if (!old_de) {
 		err = -ENOMEM;
@@ -331,7 +313,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,

 	mi_get_ref(&old_dir_ni->mi, &old_name->home);

-	/*get pointer to file_name in mft*/
+	/* Get pointer to file_name in MFT. */
 	fname = ni_fname_name(old_ni, (struct cpu_str *)&old_name->name_len,
 			      &old_name->home, &le);
 	if (!fname) {
@@ -339,19 +321,19 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		goto out2;
 	}

-	/* Copy fname info from record into new fname */
+	/* Copy fname info from record into new fname. */
 	new_name = (struct ATTR_FILE_NAME *)(new_de + 1);
 	memcpy(&new_name->dup, &fname->dup, sizeof(fname->dup));

 	name_type = paired_name(fname->type);

-	/* remove first name from directory */
+	/* Remove first name from directory. */
 	err = indx_delete_entry(&old_dir_ni->dir, old_dir_ni, old_de + 1,
 				le16_to_cpu(old_de->key_size), sbi);
 	if (err)
 		goto out3;

-	/* remove first name from mft */
+	/* Remove first name from MFT. */
 	err = ni_remove_attr_le(old_ni, attr_from_name(fname), le);
 	if (err)
 		goto out4;
@@ -360,17 +342,17 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	old_ni->mi.dirty = true;

 	if (name_type != FILE_NAME_POSIX) {
-		/* get paired name */
+		/* Get paired name. */
 		fname = ni_fname_type(old_ni, name_type, &le);
 		if (fname) {
-			/* remove second name from directory */
+			/* Remove second name from directory. */
 			err = indx_delete_entry(&old_dir_ni->dir, old_dir_ni,
 						fname, fname_full_size(fname),
 						sbi);
 			if (err)
 				goto out5;

-			/* remove second name from mft */
+			/* Remove second name from MFT. */
 			err = ni_remove_attr_le(old_ni, attr_from_name(fname),
 						le);
 			if (err)
@@ -381,13 +363,13 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		}
 	}

-	/* Add new name */
+	/* Add new name. */
 	mi_get_ref(&old_ni->mi, &new_de->ref);
 	mi_get_ref(&ntfs_i(new_dir)->mi, &new_name->home);

 	new_de_key_size = le16_to_cpu(new_de->key_size);

-	/* insert new name in mft */
+	/* Insert new name in MFT. */
 	err = ni_insert_resident(old_ni, new_de_key_size, ATTR_NAME, NULL, 0,
 				 &attr, NULL);
 	if (err)
@@ -400,7 +382,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	le16_add_cpu(&old_ni->mi.mrec->hard_links, 1);
 	old_ni->mi.dirty = true;

-	/* insert new name in directory */
+	/* Insert new name in directory. */
 	err = indx_insert_entry(&new_dir_ni->dir, new_dir_ni, new_de, sbi,
 				NULL);
 	if (err)
@@ -428,7 +410,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	}

 	err = 0;
-	/* normal way */
+	/* Normal way* */
 	goto out2;

 out8:
@@ -467,9 +449,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 }

 /*
- * ntfs_atomic_open
- *
- * inode_operations::atomic_open
+ * ntfs_atomic_open - inode_operations::atomic_open
  */
 static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, u32 flags, umode_t mode)
@@ -518,7 +498,7 @@ static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,

 	file->f_mode |= FMODE_CREATED;

-	/*fnd contains tree's path to insert to*/
+	/* fnd contains tree's path to insert to. */
 	/* TODO: init_user_ns? */
 	inode = ntfs_create_inode(&init_user_ns, dir, dentry, uni, mode, 0,
 				  NULL, 0, excl, fnd);
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 40398e6c39c9..80bc23058d16 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -8,33 +8,24 @@

 // clang-format off

-/* TODO:
- * - Check 4K mft record and 512 bytes cluster
- */
+/* TODO: Check 4K MFT record and 512 bytes cluster. */

-/*
- * Activate this define to use binary search in indexes
- */
+/* Activate this define to use binary search in indexes. */
 #define NTFS3_INDEX_BINARY_SEARCH

-/*
- * Check each run for marked clusters
- */
+/* Check each run for marked clusters. */
 #define NTFS3_CHECK_FREE_CLST

 #define NTFS_NAME_LEN 255

-/*
- * ntfs.sys used 500 maximum links
- * on-disk struct allows up to 0xffff
- */
+/* ntfs.sys used 500 maximum links on-disk struct allows up to 0xffff. */
 #define NTFS_LINK_MAX 0x400
 //#define NTFS_LINK_MAX 0xffff

 /*
- * Activate to use 64 bit clusters instead of 32 bits in ntfs.sys
- * Logical and virtual cluster number
- * If needed, may be redefined to use 64 bit value
+ * Activate to use 64 bit clusters instead of 32 bits in ntfs.sys.
+ * Logical and virtual cluster number if needed, may be
+ * redefined to use 64 bit value.
  */
 //#define CONFIG_NTFS3_64BIT_CLUSTER

@@ -50,10 +41,10 @@ struct GUID {
 };

 /*
- * this struct repeats layout of ATTR_FILE_NAME
- * at offset 0x40
- * it used to store global constants NAME_MFT/NAME_MIRROR...
- * most constant names are shorter than 10
+ * This struct repeats layout of ATTR_FILE_NAME
+ * at offset 0x40.
+ * It used to store global constants NAME_MFT/NAME_MIRROR...
+ * most constant names are shorter than 10.
  */
 struct cpu_str {
 	u8 len;
@@ -176,11 +167,11 @@ extern const __le16 BAD_NAME[4];
 extern const __le16 SDS_NAME[4];
 extern const __le16 WOF_NAME[17];	/* WofCompressedData */

-/* MFT record number structure */
+/* MFT record number structure. */
 struct MFT_REF {
-	__le32 low;	// The low part of the number
-	__le16 high;	// The high part of the number
-	__le16 seq;	// The sequence number of MFT record
+	__le32 low;	// The low part of the number.
+	__le16 high;	// The high part of the number.
+	__le16 seq;	// The sequence number of MFT record.
 };

 static_assert(sizeof(__le64) == sizeof(struct MFT_REF));
@@ -195,36 +186,36 @@ static inline CLST ino_get(const struct MFT_REF *ref)
 }

 struct NTFS_BOOT {
-	u8 jump_code[3];	// 0x00: Jump to boot code
+	u8 jump_code[3];	// 0x00: Jump to boot code.
 	u8 system_id[8];	// 0x03: System ID, equals "NTFS    "

-	// NOTE: this member is not aligned(!)
-	// bytes_per_sector[0] must be 0
-	// bytes_per_sector[1] must be multiplied by 256
-	u8 bytes_per_sector[2];	// 0x0B: Bytes per sector
+	// NOTE: This member is not aligned(!)
+	// bytes_per_sector[0] must be 0.
+	// bytes_per_sector[1] must be multiplied by 256.
+	u8 bytes_per_sector[2];	// 0x0B: Bytes per sector.

-	u8 sectors_per_clusters;// 0x0D: Sectors per cluster
+	u8 sectors_per_clusters;// 0x0D: Sectors per cluster.
 	u8 unused1[7];
 	u8 media_type;		// 0x15: Media type (0xF8 - harddisk)
 	u8 unused2[2];
-	__le16 sct_per_track;	// 0x18: number of sectors per track
-	__le16 heads;		// 0x1A: number of heads per cylinder
-	__le32 hidden_sectors;	// 0x1C: number of 'hidden' sectors
+	__le16 sct_per_track;	// 0x18: number of sectors per track.
+	__le16 heads;		// 0x1A: number of heads per cylinder.
+	__le32 hidden_sectors;	// 0x1C: number of 'hidden' sectors.
 	u8 unused3[4];
-	u8 bios_drive_num;	// 0x24: BIOS drive number =0x80
+	u8 bios_drive_num;	// 0x24: BIOS drive number =0x80.
 	u8 unused4;
-	u8 signature_ex;	// 0x26: Extended BOOT signature =0x80
+	u8 signature_ex;	// 0x26: Extended BOOT signature =0x80.
 	u8 unused5;
-	__le64 sectors_per_volume;// 0x28: size of volume in sectors
-	__le64 mft_clst;	// 0x30: first cluster of $MFT
-	__le64 mft2_clst;	// 0x38: first cluster of $MFTMirr
-	s8 record_size;		// 0x40: size of MFT record in clusters(sectors)
+	__le64 sectors_per_volume;// 0x28: Size of volume in sectors.
+	__le64 mft_clst;	// 0x30: First cluster of $MFT
+	__le64 mft2_clst;	// 0x38: First cluster of $MFTMirr
+	s8 record_size;		// 0x40: Size of MFT record in clusters(sectors).
 	u8 unused6[3];
-	s8 index_size;		// 0x44: size of INDX record in clusters(sectors)
+	s8 index_size;		// 0x44: Size of INDX record in clusters(sectors).
 	u8 unused7[3];
 	__le64 serial_num;	// 0x48: Volume serial number
 	__le32 check_sum;	// 0x50: Simple additive checksum of all
-				// of the u32's which precede the 'check_sum'
+				// of the u32's which precede the 'check_sum'.

 	u8 boot_code[0x200 - 0x50 - 2 - 4]; // 0x54:
 	u8 boot_magic[2];	// 0x1FE: Boot signature =0x55 + 0xAA
@@ -245,13 +236,13 @@ enum NTFS_SIGNATURE {

 static_assert(sizeof(enum NTFS_SIGNATURE) == 4);

-/* MFT Record header structure */
+/* MFT Record header structure. */
 struct NTFS_RECORD_HEADER {
-	/* Record magic number, equals 'FILE'/'INDX'/'RSTR'/'RCRD' */
+	/* Record magic number, equals 'FILE'/'INDX'/'RSTR'/'RCRD'. */
 	enum NTFS_SIGNATURE sign; // 0x00:
 	__le16 fix_off;		// 0x04:
 	__le16 fix_num;		// 0x06:
-	__le64 lsn;		// 0x08: Log file sequence number
+	__le64 lsn;		// 0x08: Log file sequence number,
 };

 static_assert(sizeof(struct NTFS_RECORD_HEADER) == 0x10);
@@ -261,7 +252,7 @@ static inline int is_baad(const struct NTFS_RECORD_HEADER *hdr)
 	return hdr->sign == NTFS_BAAD_SIGNATURE;
 }

-/* Possible bits in struct MFT_REC.flags */
+/* Possible bits in struct MFT_REC.flags. */
 enum RECORD_FLAG {
 	RECORD_FLAG_IN_USE	= cpu_to_le16(0x0001),
 	RECORD_FLAG_DIR		= cpu_to_le16(0x0002),
@@ -269,22 +260,28 @@ enum RECORD_FLAG {
 	RECORD_FLAG_UNKNOWN	= cpu_to_le16(0x0008),
 };

-/* MFT Record structure */
+/* MFT Record structure, */
 struct MFT_REC {
 	struct NTFS_RECORD_HEADER rhdr; // 'FILE'

-	__le16 seq;		// 0x10: Sequence number for this record
-	__le16 hard_links;	// 0x12: The number of hard links to record
-	__le16 attr_off;	// 0x14: Offset to attributes
-	__le16 flags;		// 0x16: See RECORD_FLAG
-	__le32 used;		// 0x18: The size of used part
-	__le32 total;		// 0x1C: Total record size
+	__le16 seq;		// 0x10: Sequence number for this record.
+	__le16 hard_links;	// 0x12: The number of hard links to record.
+	__le16 attr_off;	// 0x14: Offset to attributes.
+	__le16 flags;		// 0x16: See RECORD_FLAG.
+	__le32 used;		// 0x18: The size of used part.
+	__le32 total;		// 0x1C: Total record size.
+
+	struct MFT_REF parent_ref; // 0x20: Parent MFT record.
+	__le16 next_attr_id;	// 0x28: The next attribute Id.

-	struct MFT_REF parent_ref; // 0x20: Parent MFT record
-	__le16 next_attr_id;	// 0x28: The next attribute Id
+	__le32 used;		// 0x18: The size of used part.
+	__le32 total;		// 0x1C: Total record size.

-	__le16 res;		// 0x2A: High part of mft record?
-	__le32 mft_record;	// 0x2C: Current mft record number
+	struct MFT_REF parent_ref; // 0x20: Parent MFT record.
+	__le16 next_attr_id;	// 0x28: The next attribute Id.
+
+	__le16 res;		// 0x2A: High part of MFT record?
+	__le32 mft_record;	// 0x2C: Current MFT record number.
 	__le16 fixups[];	// 0x30:
 };

@@ -321,16 +318,16 @@ static inline bool clear_rec_inuse(struct MFT_REC *rec)
 #define RESIDENT_FLAG_INDEXED 0x01

 struct ATTR_RESIDENT {
-	__le32 data_size;	// 0x10: The size of data
-	__le16 data_off;	// 0x14: Offset to data
-	u8 flags;		// 0x16: resident flags ( 1 - indexed )
+	__le32 data_size;	// 0x10: The size of data.
+	__le16 data_off;	// 0x14: Offset to data.
+	u8 flags;		// 0x16: Resident flags ( 1 - indexed ).
 	u8 res;			// 0x17:
 }; // sizeof() = 0x18

 struct ATTR_NONRESIDENT {
-	__le64 svcn;		// 0x10: Starting VCN of this segment
-	__le64 evcn;		// 0x18: End VCN of this segment
-	__le16 run_off;		// 0x20: Offset to packed runs
+	__le64 svcn;		// 0x10: Starting VCN of this segment.
+	__le64 evcn;		// 0x18: End VCN of this segment.
+	__le16 run_off;		// 0x20: Offset to packed runs.
 	//  Unit of Compression size for this stream, expressed
 	//  as a log of the cluster size.
 	//
@@ -343,13 +340,13 @@ struct ATTR_NONRESIDENT {
 	//	    reasonable range of legal values here (1-5?),
 	//	    even if the implementation only generates
 	//	    a smaller set of values itself.
-	u8 c_unit;		// 0x22
+	u8 c_unit;		// 0x22:
 	u8 res1[5];		// 0x23:
-	__le64 alloc_size;	// 0x28: The allocated size of attribute in bytes
+	__le64 alloc_size;	// 0x28: The allocated size of attribute in bytes.
 				// (multiple of cluster size)
-	__le64 data_size;	// 0x30: The size of attribute  in bytes <= alloc_size
-	__le64 valid_size;	// 0x38: The size of valid part in bytes <= data_size
-	__le64 total_size;	// 0x40: The sum of the allocated clusters for a file
+	__le64 data_size;	// 0x30: The size of attribute  in bytes <= alloc_size.
+	__le64 valid_size;	// 0x38: The size of valid part in bytes <= data_size.
+	__le64 total_size;	// 0x40: The sum of the allocated clusters for a file.
 				// (present only for the first segment (0 == vcn)
 				// of compressed attribute)

@@ -362,13 +359,13 @@ struct ATTR_NONRESIDENT {
 #define ATTR_FLAG_SPARSED	  cpu_to_le16(0x8000)

 struct ATTRIB {
-	enum ATTR_TYPE type;	// 0x00: The type of this attribute
-	__le32 size;		// 0x04: The size of this attribute
-	u8 non_res;		// 0x08: Is this attribute non-resident ?
-	u8 name_len;		// 0x09: This attribute name length
-	__le16 name_off;	// 0x0A: Offset to the attribute name
-	__le16 flags;		// 0x0C: See ATTR_FLAG_XXX
-	__le16 id;		// 0x0E: unique id (per record)
+	enum ATTR_TYPE type;	// 0x00: The type of this attribute.
+	__le32 size;		// 0x04: The size of this attribute.
+	u8 non_res;		// 0x08: Is this attribute non-resident?
+	u8 name_len;		// 0x09: This attribute name length.
+	__le16 name_off;	// 0x0A: Offset to the attribute name.
+	__le16 flags;		// 0x0C: See ATTR_FLAG_XXX.
+	__le16 id;		// 0x0E: Unique id (per record).

 	union {
 		struct ATTR_RESIDENT res;     // 0x10
@@ -376,7 +373,7 @@ struct ATTRIB {
 	};
 };

-/* Define attribute sizes */
+/* Define attribute sizes. */
 #define SIZEOF_RESIDENT			0x18
 #define SIZEOF_NONRESIDENT_EX		0x48
 #define SIZEOF_NONRESIDENT		0x40
@@ -435,7 +432,7 @@ static inline u64 attr_svcn(const struct ATTRIB *attr)
 	return attr->non_res ? le64_to_cpu(attr->nres.svcn) : 0;
 }

-/* the size of resident attribute by its resident size */
+/* The size of resident attribute by its resident size. */
 #define BYTES_PER_RESIDENT(b) (0x18 + (b))

 static_assert(sizeof(struct ATTRIB) == 0x48);
@@ -473,16 +470,16 @@ static inline void *attr_run(const struct ATTRIB *attr)
 	return Add2Ptr(attr, le16_to_cpu(attr->nres.run_off));
 }

-/* Standard information attribute (0x10) */
+/* Standard information attribute (0x10). */
 struct ATTR_STD_INFO {
-	__le64 cr_time;		// 0x00: File creation file
-	__le64 m_time;		// 0x08: File modification time
-	__le64 c_time;		// 0x10: Last time any attribute was modified
-	__le64 a_time;		// 0x18: File last access time
-	enum FILE_ATTRIBUTE fa; // 0x20: Standard DOS attributes & more
-	__le32 max_ver_num;	// 0x24: Maximum Number of Versions
-	__le32 ver_num;		// 0x28: Version Number
-	__le32 class_id;	// 0x2C: Class Id from bidirectional Class Id index
+	__le64 cr_time;		// 0x00: File creation file.
+	__le64 m_time;		// 0x08: File modification time.
+	__le64 c_time;		// 0x10: Last time any attribute was modified.
+	__le64 a_time;		// 0x18: File last access time.
+	enum FILE_ATTRIBUTE fa;	// 0x20: Standard DOS attributes & more.
+	__le32 max_ver_num;	// 0x24: Maximum Number of Versions.
+	__le32 ver_num;		// 0x28: Version Number.
+	__le32 class_id;	// 0x2C: Class Id from bidirectional Class Id index.
 };

 static_assert(sizeof(struct ATTR_STD_INFO) == 0x30);
@@ -491,17 +488,17 @@ static_assert(sizeof(struct ATTR_STD_INFO) == 0x30);
 #define SECURITY_ID_FIRST 0x00000100

 struct ATTR_STD_INFO5 {
-	__le64 cr_time;		// 0x00: File creation file
-	__le64 m_time;		// 0x08: File modification time
-	__le64 c_time;		// 0x10: Last time any attribute was modified
-	__le64 a_time;		// 0x18: File last access time
-	enum FILE_ATTRIBUTE fa; // 0x20: Standard DOS attributes & more
-	__le32 max_ver_num;	// 0x24: Maximum Number of Versions
-	__le32 ver_num;		// 0x28: Version Number
-	__le32 class_id;	// 0x2C: Class Id from bidirectional Class Id index
+	__le64 cr_time;		// 0x00: File creation file.
+	__le64 m_time;		// 0x08: File modification time.
+	__le64 c_time;		// 0x10: Last time any attribute was modified.
+	__le64 a_time;		// 0x18: File last access time.
+	enum FILE_ATTRIBUTE fa;	// 0x20: Standard DOS attributes & more.
+	__le32 max_ver_num;	// 0x24: Maximum Number of Versions.
+	__le32 ver_num;		// 0x28: Version Number.
+	__le32 class_id;	// 0x2C: Class Id from bidirectional Class Id index.

 	__le32 owner_id;	// 0x30: Owner Id of the user owning the file.
-	__le32 security_id;	// 0x34: The Security Id is a key in the $SII Index and $SDS
+	__le32 security_id;	// 0x34: The Security Id is a key in the $SII Index and $SDS.
 	__le64 quota_charge;	// 0x38:
 	__le64 usn;		// 0x40: Last Update Sequence Number of the file. This is a direct
 				// index into the file $UsnJrnl. If zero, the USN Journal is
@@ -510,16 +507,16 @@ struct ATTR_STD_INFO5 {

 static_assert(sizeof(struct ATTR_STD_INFO5) == 0x48);

-/* attribute list entry structure (0x20) */
+/* Attribute list entry structure (0x20) */
 struct ATTR_LIST_ENTRY {
-	enum ATTR_TYPE type;	// 0x00: The type of attribute
-	__le16 size;		// 0x04: The size of this record
-	u8 name_len;		// 0x06: The length of attribute name
-	u8 name_off;		// 0x07: The offset to attribute name
-	__le64 vcn;		// 0x08: Starting VCN of this attribute
-	struct MFT_REF ref;	// 0x10: MFT record number with attribute
-	__le16 id;		// 0x18: struct ATTRIB ID
-	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset
+	enum ATTR_TYPE type;	// 0x00: The type of attribute.
+	__le16 size;		// 0x04: The size of this record.
+	u8 name_len;		// 0x06: The length of attribute name.
+	u8 name_off;		// 0x07: The offset to attribute name.
+	__le64 vcn;		// 0x08: Starting VCN of this attribute.
+	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
+	__le16 id;		// 0x18: struct ATTRIB ID.
+	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset.

 }; // sizeof(0x20)

@@ -531,7 +528,7 @@ static inline u32 le_size(u8 name_len)
 			 name_len * sizeof(short));
 }

-/* returns 0 if 'attr' has the same type and name */
+/* Returns 0 if 'attr' has the same type and name. */
 static inline int le_cmp(const struct ATTR_LIST_ENTRY *le,
 			 const struct ATTRIB *attr)
 {
@@ -547,32 +544,32 @@ static inline __le16 const *le_name(const struct ATTR_LIST_ENTRY *le)
 	return Add2Ptr(le, le->name_off);
 }

-/* File name types (the field type in struct ATTR_FILE_NAME ) */
+/* File name types (the field type in struct ATTR_FILE_NAME). */
 #define FILE_NAME_POSIX   0
 #define FILE_NAME_UNICODE 1
 #define FILE_NAME_DOS	  2
 #define FILE_NAME_UNICODE_AND_DOS (FILE_NAME_DOS | FILE_NAME_UNICODE)

-/* Filename attribute structure (0x30) */
+/* Filename attribute structure (0x30). */
 struct NTFS_DUP_INFO {
-	__le64 cr_time;		// 0x00: File creation file
-	__le64 m_time;		// 0x08: File modification time
-	__le64 c_time;		// 0x10: Last time any attribute was modified
-	__le64 a_time;		// 0x18: File last access time
-	__le64 alloc_size;	// 0x20: Data attribute allocated size, multiple of cluster size
-	__le64 data_size;	// 0x28: Data attribute size <= Dataalloc_size
-	enum FILE_ATTRIBUTE fa;	// 0x30: Standard DOS attributes & more
-	__le16 ea_size;		// 0x34: Packed EAs
-	__le16 reparse;		// 0x36: Used by Reparse
+	__le64 cr_time;		// 0x00: File creation file.
+	__le64 m_time;		// 0x08: File modification time.
+	__le64 c_time;		// 0x10: Last time any attribute was modified.
+	__le64 a_time;		// 0x18: File last access time.
+	__le64 alloc_size;	// 0x20: Data attribute allocated size, multiple of cluster size.
+	__le64 data_size;	// 0x28: Data attribute size <= Dataalloc_size.
+	enum FILE_ATTRIBUTE fa;	// 0x30: Standard DOS attributes & more.
+	__le16 ea_size;		// 0x34: Packed EAs.
+	__le16 reparse;		// 0x36: Used by Reparse.

 }; // 0x38

 struct ATTR_FILE_NAME {
-	struct MFT_REF home;	// 0x00: MFT record for directory
-	struct NTFS_DUP_INFO dup;// 0x08
-	u8 name_len;		// 0x40: File name length in words
-	u8 type;		// 0x41: File name type
-	__le16 name[];		// 0x42: File name
+	struct MFT_REF home;	// 0x00: MFT record for directory.
+	struct NTFS_DUP_INFO dup;// 0x08:
+	u8 name_len;		// 0x40: File name length in words.
+	u8 type;		// 0x41: File name type.
+	__le16 name[];		// 0x42: File name.
 };

 static_assert(sizeof(((struct ATTR_FILE_NAME *)NULL)->dup) == 0x38);
@@ -587,7 +584,7 @@ static inline struct ATTRIB *attr_from_name(struct ATTR_FILE_NAME *fname)

 static inline u16 fname_full_size(const struct ATTR_FILE_NAME *fname)
 {
-	// don't return struct_size(fname, name, fname->name_len);
+	/* Don't return struct_size(fname, name, fname->name_len); */
 	return offsetof(struct ATTR_FILE_NAME, name) +
 	       fname->name_len * sizeof(short);
 }
@@ -601,32 +598,32 @@ static inline u8 paired_name(u8 type)
 	return FILE_NAME_POSIX;
 }

-/* Index entry defines ( the field flags in NtfsDirEntry ) */
+/* Index entry defines ( the field flags in NtfsDirEntry ). */
 #define NTFS_IE_HAS_SUBNODES	cpu_to_le16(1)
 #define NTFS_IE_LAST		cpu_to_le16(2)

-/* Directory entry structure */
+/* Directory entry structure. */
 struct NTFS_DE {
 	union {
-		struct MFT_REF ref; // 0x00: MFT record number with this file
+		struct MFT_REF ref; // 0x00: MFT record number with this file.
 		struct {
 			__le16 data_off;  // 0x00:
 			__le16 data_size; // 0x02:
-			__le32 res;	  // 0x04: must be 0
+			__le32 res;	  // 0x04: Must be 0.
 		} view;
 	};
-	__le16 size;		// 0x08: The size of this entry
-	__le16 key_size;	// 0x0A: The size of File name length in bytes + 0x42
-	__le16 flags;		// 0x0C: Entry flags: NTFS_IE_XXX
+	__le16 size;		// 0x08: The size of this entry.
+	__le16 key_size;	// 0x0A: The size of File name length in bytes + 0x42.
+	__le16 flags;		// 0x0C: Entry flags: NTFS_IE_XXX.
 	__le16 res;		// 0x0E:

-	// Here any indexed attribute can be placed
+	// Here any indexed attribute can be placed.
 	// One of them is:
 	// struct ATTR_FILE_NAME AttrFileName;
 	//

 	// The last 8 bytes of this structure contains
-	// the VBN of subnode
+	// the VBN of subnode.
 	// !!! Note !!!
 	// This field is presented only if (flags & NTFS_IE_HAS_SUBNODES)
 	// __le64 vbn;
@@ -696,11 +693,11 @@ static inline bool de_has_vcn_ex(const struct NTFS_DE *e)

 struct INDEX_HDR {
 	__le32 de_off;	// 0x00: The offset from the start of this structure
-			// to the first NTFS_DE
+			// to the first NTFS_DE.
 	__le32 used;	// 0x04: The size of this structure plus all
-			// entries (quad-word aligned)
-	__le32 total;	// 0x08: The allocated size of for this structure plus all entries
-	u8 flags;	// 0x0C: 0x00 = Small directory, 0x01 = Large directory
+			// entries (quad-word aligned).
+	__le32 total;	// 0x08: The allocated size of for this structure plus all entries.
+	u8 flags;	// 0x0C: 0x00 = Small directory, 0x01 = Large directory.
 	u8 res[3];

 	//
@@ -771,7 +768,7 @@ static inline bool ib_is_leaf(const struct INDEX_BUFFER *ib)
 	return !(ib->ihdr.flags & 1);
 }

-/* Index root structure ( 0x90 ) */
+/* Index root structure ( 0x90 ). */
 enum COLLATION_RULE {
 	NTFS_COLLATION_TYPE_BINARY	= cpu_to_le32(0),
 	// $I30
@@ -790,10 +787,10 @@ static_assert(sizeof(enum COLLATION_RULE) == 4);

 //
 struct INDEX_ROOT {
-	enum ATTR_TYPE type;	// 0x00: The type of attribute to index on
-	enum COLLATION_RULE rule; // 0x04: The rule
-	__le32 index_block_size;// 0x08: The size of index record
-	u8 index_block_clst;	// 0x0C: The number of clusters or sectors per index
+	enum ATTR_TYPE type;	// 0x00: The type of attribute to index on.
+	enum COLLATION_RULE rule; // 0x04: The rule.
+	__le32 index_block_size;// 0x08: The size of index record.
+	u8 index_block_clst;	// 0x0C: The number of clusters or sectors per index.
 	u8 res[3];
 	struct INDEX_HDR ihdr;	// 0x10:
 };
@@ -822,24 +819,24 @@ struct VOLUME_INFO {
 #define NTFS_ATTR_MUST_BE_RESIDENT	cpu_to_le32(0x00000040)
 #define NTFS_ATTR_LOG_ALWAYS		cpu_to_le32(0x00000080)

-/* $AttrDef file entry */
+/* $AttrDef file entry. */
 struct ATTR_DEF_ENTRY {
-	__le16 name[0x40];	// 0x00: Attr name
-	enum ATTR_TYPE type;	// 0x80: struct ATTRIB type
+	__le16 name[0x40];	// 0x00: Attr name.
+	enum ATTR_TYPE type;	// 0x80: struct ATTRIB type.
 	__le32 res;		// 0x84:
 	enum COLLATION_RULE rule; // 0x88:
-	__le32 flags;		// 0x8C: NTFS_ATTR_XXX (see above)
-	__le64 min_sz;		// 0x90: Minimum attribute data size
-	__le64 max_sz;		// 0x98: Maximum attribute data size
+	__le32 flags;		// 0x8C: NTFS_ATTR_XXX (see above).
+	__le64 min_sz;		// 0x90: Minimum attribute data size.
+	__le64 max_sz;		// 0x98: Maximum attribute data size.
 };

 static_assert(sizeof(struct ATTR_DEF_ENTRY) == 0xa0);

 /* Object ID (0x40) */
 struct OBJECT_ID {
-	struct GUID ObjId;	// 0x00: Unique Id assigned to file
-	struct GUID BirthVolumeId;// 0x10: Birth Volume Id is the Object Id of the Volume on
-				// which the Object Id was allocated. It never changes
+	struct GUID ObjId;	// 0x00: Unique Id assigned to file.
+	struct GUID BirthVolumeId; // 0x10: Birth Volume Id is the Object Id of the Volume on.
+				// which the Object Id was allocated. It never changes.
 	struct GUID BirthObjectId; // 0x20: Birth Object Id is the first Object Id that was
 				// ever assigned to this MFT Record. I.e. If the Object Id
 				// is changed for some reason, this field will reflect the
@@ -855,15 +852,15 @@ static_assert(sizeof(struct OBJECT_ID) == 0x40);
 /* O Directory entry structure ( rule = 0x13 ) */
 struct NTFS_DE_O {
 	struct NTFS_DE de;
-	struct GUID ObjId;	// 0x10: Unique Id assigned to file
-	struct MFT_REF ref;	// 0x20: MFT record number with this file
+	struct GUID ObjId;	// 0x10: Unique Id assigned to file.
+	struct MFT_REF ref;	// 0x20: MFT record number with this file.
 	struct GUID BirthVolumeId; // 0x28: Birth Volume Id is the Object Id of the Volume on
-				// which the Object Id was allocated. It never changes
+				// which the Object Id was allocated. It never changes.
 	struct GUID BirthObjectId; // 0x38: Birth Object Id is the first Object Id that was
 				// ever assigned to this MFT Record. I.e. If the Object Id
 				// is changed for some reason, this field will reflect the
 				// original value of the Object Id.
-				// This field is valid if data_size == 0x48
+				// This field is valid if data_size == 0x48.
 	struct GUID BirthDomainId; // 0x48: Domain Id is currently unused but it is intended
 				// to be used in a network environment where the local
 				// machine is part of a Windows 2000 Domain. This may be
@@ -905,13 +902,13 @@ struct SECURITY_KEY {

 /* Security descriptors (the content of $Secure::SDS data stream) */
 struct SECURITY_HDR {
-	struct SECURITY_KEY key;	// 0x00: Security Key
-	__le64 off;			// 0x08: Offset of this entry in the file
-	__le32 size;			// 0x10: Size of this entry, 8 byte aligned
-	//
-	// Security descriptor itself is placed here
-	// Total size is 16 byte aligned
-	//
+	struct SECURITY_KEY key;	// 0x00: Security Key.
+	__le64 off;			// 0x08: Offset of this entry in the file.
+	__le32 size;			// 0x10: Size of this entry, 8 byte aligned.
+	/*
+	 * Security descriptor itself is placed here.
+	 * Total size is 16 byte aligned.
+	 */
 } __packed;

 #define SIZEOF_SECURITY_HDR 0x14
@@ -946,8 +943,8 @@ static_assert(offsetof(struct REPARSE_KEY, ref) == 0x04);
 /* Reparse Directory entry structure */
 struct NTFS_DE_R {
 	struct NTFS_DE de;
-	struct REPARSE_KEY key;		// 0x10: Reparse Key
-	u32 zero;			// 0x1c
+	struct REPARSE_KEY key;		// 0x10: Reparse Key.
+	u32 zero;			// 0x1c:
 }; // sizeof() = 0x20

 static_assert(sizeof(struct NTFS_DE_R) == 0x20);
@@ -989,69 +986,63 @@ struct REPARSE_POINT {

 static_assert(sizeof(struct REPARSE_POINT) == 0x18);

-//
-// Maximum allowed size of the reparse data.
-//
+/* Maximum allowed size of the reparse data. */
 #define MAXIMUM_REPARSE_DATA_BUFFER_SIZE	(16 * 1024)

-//
-// The value of the following constant needs to satisfy the following
-// conditions:
-//  (1) Be at least as large as the largest of the reserved tags.
-//  (2) Be strictly smaller than all the tags in use.
-//
+/*
+ * The value of the following constant needs to satisfy the following
+ * conditions:
+ *  (1) Be at least as large as the largest of the reserved tags.
+ *  (2) Be strictly smaller than all the tags in use.
+ */
 #define IO_REPARSE_TAG_RESERVED_RANGE		1

-//
-// The reparse tags are a ULONG. The 32 bits are laid out as follows:
-//
-//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
-//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
-//  +-+-+-+-+-----------------------+-------------------------------+
-//  |M|R|N|R|	  Reserved bits     |	    Reparse Tag Value	    |
-//  +-+-+-+-+-----------------------+-------------------------------+
-//
-// M is the Microsoft bit. When set to 1, it denotes a tag owned by Microsoft.
-//   All ISVs must use a tag with a 0 in this position.
-//   Note: If a Microsoft tag is used by non-Microsoft software, the
-//   behavior is not defined.
-//
-// R is reserved.  Must be zero for non-Microsoft tags.
-//
-// N is name surrogate. When set to 1, the file represents another named
-//   entity in the system.
-//
-// The M and N bits are OR-able.
-// The following macros check for the M and N bit values:
-//
+/*
+ * The reparse tags are a ULONG. The 32 bits are laid out as follows:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-+-+-+-+-----------------------+-------------------------------+
+ *  |M|R|N|R|	  Reserved bits     |	    Reparse Tag Value	    |
+ *  +-+-+-+-+-----------------------+-------------------------------+
+ *
+ * M is the Microsoft bit. When set to 1, it denotes a tag owned by Microsoft.
+ *   All ISVs must use a tag with a 0 in this position.
+ *   Note: If a Microsoft tag is used by non-Microsoft software, the
+ *   behavior is not defined.
+ *
+ * R is reserved.  Must be zero for non-Microsoft tags.
+ *
+ * N is name surrogate. When set to 1, the file represents another named
+ *   entity in the system.
+ *
+ * The M and N bits are OR-able.
+ * The following macros check for the M and N bit values:
+ */

-//
-// Macro to determine whether a reparse point tag corresponds to a tag
-// owned by Microsoft.
-//
+/*
+ * Macro to determine whether a reparse point tag corresponds to a tag
+ * owned by Microsoft.
+ */
 #define IsReparseTagMicrosoft(_tag)	(((_tag)&IO_REPARSE_TAG_MICROSOFT))

-//
-// Macro to determine whether a reparse point tag is a name surrogate
-//
+/* Macro to determine whether a reparse point tag is a name surrogate. */
 #define IsReparseTagNameSurrogate(_tag)	(((_tag)&IO_REPARSE_TAG_NAME_SURROGATE))

-//
-// The following constant represents the bits that are valid to use in
-// reparse tags.
-//
+/*
+ * The following constant represents the bits that are valid to use in
+ * reparse tags.
+ */
 #define IO_REPARSE_TAG_VALID_VALUES	0xF000FFFF

-//
-// Macro to determine whether a reparse tag is a valid tag.
-//
+/*
+ * Macro to determine whether a reparse tag is a valid tag.
+ */
 #define IsReparseTagValid(_tag)						       \
 	(!((_tag) & ~IO_REPARSE_TAG_VALID_VALUES) &&			       \
 	 ((_tag) > IO_REPARSE_TAG_RESERVED_RANGE))

-//
-// Microsoft tags for reparse points.
-//
+/* Microsoft tags for reparse points. */

 enum IO_REPARSE_TAG {
 	IO_REPARSE_TAG_SYMBOLIC_LINK	= cpu_to_le32(0),
@@ -1064,62 +1055,48 @@ enum IO_REPARSE_TAG {
 	IO_REPARSE_TAG_DEDUP		= cpu_to_le32(0x80000013),
 	IO_REPARSE_TAG_COMPRESS		= cpu_to_le32(0x80000017),

-	//
-	// The reparse tag 0x80000008 is reserved for Microsoft internal use
-	// (may be published in the future)
-	//
+	/*
+	 * The reparse tag 0x80000008 is reserved for Microsoft internal use.
+	 * May be published in the future.
+	 */

-	//
-	// Microsoft reparse tag reserved for DFS
-	//
-	IO_REPARSE_TAG_DFS		= cpu_to_le32(0x8000000A),
+	/* Microsoft reparse tag reserved for DFS */
+	IO_REPARSE_TAG_DFS	= cpu_to_le32(0x8000000A),

-	//
-	// Microsoft reparse tag reserved for the file system filter manager
-	//
+	/* Microsoft reparse tag reserved for the file system filter manager. */
 	IO_REPARSE_TAG_FILTER_MANAGER	= cpu_to_le32(0x8000000B),

-	//
-	// Non-Microsoft tags for reparse points
-	//
+	/* Non-Microsoft tags for reparse points */

-	//
-	// Tag allocated to CONGRUENT, May 2000. Used by IFSTEST
-	//
+	/* Tag allocated to CONGRUENT, May 2000. Used by IFSTEST. */
 	IO_REPARSE_TAG_IFSTEST_CONGRUENT = cpu_to_le32(0x00000009),

-	//
-	// Tag allocated to ARKIVIO
-	//
-	IO_REPARSE_TAG_ARKIVIO		= cpu_to_le32(0x0000000C),
+	/* Tag allocated to ARKIVIO. */
+	IO_REPARSE_TAG_ARKIVIO	= cpu_to_le32(0x0000000C),

-	//
-	//  Tag allocated to SOLUTIONSOFT
-	//
+	/* Tag allocated to SOLUTIONSOFT. */
 	IO_REPARSE_TAG_SOLUTIONSOFT	= cpu_to_le32(0x2000000D),

-	//
-	//  Tag allocated to COMMVAULT
-	//
+	/* Tag allocated to COMMVAULT. */
 	IO_REPARSE_TAG_COMMVAULT	= cpu_to_le32(0x0000000E),

-	// OneDrive??
-	IO_REPARSE_TAG_CLOUD		= cpu_to_le32(0x9000001A),
-	IO_REPARSE_TAG_CLOUD_1		= cpu_to_le32(0x9000101A),
-	IO_REPARSE_TAG_CLOUD_2		= cpu_to_le32(0x9000201A),
-	IO_REPARSE_TAG_CLOUD_3		= cpu_to_le32(0x9000301A),
-	IO_REPARSE_TAG_CLOUD_4		= cpu_to_le32(0x9000401A),
-	IO_REPARSE_TAG_CLOUD_5		= cpu_to_le32(0x9000501A),
-	IO_REPARSE_TAG_CLOUD_6		= cpu_to_le32(0x9000601A),
-	IO_REPARSE_TAG_CLOUD_7		= cpu_to_le32(0x9000701A),
-	IO_REPARSE_TAG_CLOUD_8		= cpu_to_le32(0x9000801A),
-	IO_REPARSE_TAG_CLOUD_9		= cpu_to_le32(0x9000901A),
-	IO_REPARSE_TAG_CLOUD_A		= cpu_to_le32(0x9000A01A),
-	IO_REPARSE_TAG_CLOUD_B		= cpu_to_le32(0x9000B01A),
-	IO_REPARSE_TAG_CLOUD_C		= cpu_to_le32(0x9000C01A),
-	IO_REPARSE_TAG_CLOUD_D		= cpu_to_le32(0x9000D01A),
-	IO_REPARSE_TAG_CLOUD_E		= cpu_to_le32(0x9000E01A),
-	IO_REPARSE_TAG_CLOUD_F		= cpu_to_le32(0x9000F01A),
+	/* OneDrive?? */
+	IO_REPARSE_TAG_CLOUD	= cpu_to_le32(0x9000001A),
+	IO_REPARSE_TAG_CLOUD_1	= cpu_to_le32(0x9000101A),
+	IO_REPARSE_TAG_CLOUD_2	= cpu_to_le32(0x9000201A),
+	IO_REPARSE_TAG_CLOUD_3	= cpu_to_le32(0x9000301A),
+	IO_REPARSE_TAG_CLOUD_4	= cpu_to_le32(0x9000401A),
+	IO_REPARSE_TAG_CLOUD_5	= cpu_to_le32(0x9000501A),
+	IO_REPARSE_TAG_CLOUD_6	= cpu_to_le32(0x9000601A),
+	IO_REPARSE_TAG_CLOUD_7	= cpu_to_le32(0x9000701A),
+	IO_REPARSE_TAG_CLOUD_8	= cpu_to_le32(0x9000801A),
+	IO_REPARSE_TAG_CLOUD_9	= cpu_to_le32(0x9000901A),
+	IO_REPARSE_TAG_CLOUD_A	= cpu_to_le32(0x9000A01A),
+	IO_REPARSE_TAG_CLOUD_B	= cpu_to_le32(0x9000B01A),
+	IO_REPARSE_TAG_CLOUD_C	= cpu_to_le32(0x9000C01A),
+	IO_REPARSE_TAG_CLOUD_D	= cpu_to_le32(0x9000D01A),
+	IO_REPARSE_TAG_CLOUD_E	= cpu_to_le32(0x9000E01A),
+	IO_REPARSE_TAG_CLOUD_F	= cpu_to_le32(0x9000F01A),

 };

@@ -1132,7 +1109,7 @@ struct REPARSE_DATA_BUFFER {
 	__le16 Reserved;

 	union {
-		// If ReparseTag == 0xA0000003 (IO_REPARSE_TAG_MOUNT_POINT)
+		/* If ReparseTag == 0xA0000003 (IO_REPARSE_TAG_MOUNT_POINT) */
 		struct {
 			__le16 SubstituteNameOffset; // 0x08
 			__le16 SubstituteNameLength; // 0x0A
@@ -1141,8 +1118,10 @@ struct REPARSE_DATA_BUFFER {
 			__le16 PathBuffer[];	     // 0x10
 		} MountPointReparseBuffer;

-		// If ReparseTag == 0xA000000C (IO_REPARSE_TAG_SYMLINK)
-		// https://msdn.microsoft.com/en-us/library/cc232006.aspx
+		/*
+		 * If ReparseTag == 0xA000000C (IO_REPARSE_TAG_SYMLINK)
+		 * https://msdn.microsoft.com/en-us/library/cc232006.aspx
+		 */
 		struct {
 			__le16 SubstituteNameOffset; // 0x08
 			__le16 SubstituteNameLength; // 0x0A
@@ -1153,19 +1132,20 @@ struct REPARSE_DATA_BUFFER {
 			__le16 PathBuffer[];	     // 0x14
 		} SymbolicLinkReparseBuffer;

-		// If ReparseTag == 0x80000017U
+		/* If ReparseTag == 0x80000017U */
 		struct {
 			__le32 WofVersion;  // 0x08 == 1
-			/* 1 - WIM backing provider ("WIMBoot"),
+			/*
+			 * 1 - WIM backing provider ("WIMBoot"),
 			 * 2 - System compressed file provider
 			 */
-			__le32 WofProvider; // 0x0C
+			__le32 WofProvider; // 0x0C:
 			__le32 ProviderVer; // 0x10: == 1 WOF_FILE_PROVIDER_CURRENT_VERSION == 1
 			__le32 CompressionFormat; // 0x14: 0, 1, 2, 3. See WOF_COMPRESSION_XXX
 		} CompressReparseBuffer;

 		struct {
-			u8 DataBuffer[1];   // 0x08
+			u8 DataBuffer[1];   // 0x08:
 		} GenericReparseBuffer;
 	};
 };
@@ -1173,13 +1153,14 @@ struct REPARSE_DATA_BUFFER {
 /* ATTR_EA_INFO (0xD0) */

 #define FILE_NEED_EA 0x80 // See ntifs.h
-/* FILE_NEED_EA, indicates that the file to which the EA belongs cannot be
+/*
+ *FILE_NEED_EA, indicates that the file to which the EA belongs cannot be
  * interpreted without understanding the associated extended attributes.
  */
 struct EA_INFO {
-	__le16 size_pack;	// 0x00: Size of buffer to hold in packed form
-	__le16 count;		// 0x02: Count of EA's with FILE_NEED_EA bit set
-	__le32 size;		// 0x04: Size of buffer to hold in unpacked form
+	__le16 size_pack;	// 0x00: Size of buffer to hold in packed form.
+	__le16 count;		// 0x02: Count of EA's with FILE_NEED_EA bit set.
+	__le32 size;		// 0x04: Size of buffer to hold in unpacked form.
 };

 static_assert(sizeof(struct EA_INFO) == 8);
@@ -1187,10 +1168,10 @@ static_assert(sizeof(struct EA_INFO) == 8);
 /* ATTR_EA (0xE0) */
 struct EA_FULL {
 	__le32 size;		// 0x00: (not in packed)
-	u8 flags;		// 0x04
-	u8 name_len;		// 0x05
-	__le16 elength;		// 0x06
-	u8 name[];		// 0x08
+	u8 flags;		// 0x04:
+	u8 name_len;		// 0x05:
+	__le16 elength;		// 0x06:
+	u8 name[];		// 0x08:
 };

 static_assert(offsetof(struct EA_FULL, name) == 8);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 5e1dd628d3cc..9dd046b128e9 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -6,7 +6,7 @@
  */

 // clang-format off
-#define MINUS_ONE_T			((size_t)(-1))
+#define MINUS_ONE_T		((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
@@ -14,30 +14,30 @@
 #define MAXIMUM_BYTES_PER_INDEX		4096
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)

-/* ntfs specific error code when fixup failed*/
-#define E_NTFS_FIXUP			555
-/* ntfs specific error code about resident->nonresident*/
+/* NTFS specific error code when fixup failed. */
+#define E_NTFS_FIXUP		555
+/* NTFS specific error code about resident->nonresident. */
 #define E_NTFS_NONRESIDENT		556

 /* sbi->flags */
 #define NTFS_FLAGS_NODISCARD		0x00000001
-/* Set when LogFile is replaying */
+/* Set when LogFile is replaying. */
 #define NTFS_FLAGS_LOG_REPLAYING	0x00000008
-/* Set when we changed first MFT's which copy must be updated in $MftMirr */
+/* Set when we changed first MFT's which copy must be updated in $MftMirr. */
 #define NTFS_FLAGS_MFTMIRR		0x00001000
 #define NTFS_FLAGS_NEED_REPLAY		0x04000000


 /* ni->ni_flags */
 /*
- * Data attribute is external compressed (lzx/xpress)
+ * Data attribute is external compressed (LZX/Xpress)
  * 1 - WOF_COMPRESSION_XPRESS4K
  * 2 - WOF_COMPRESSION_XPRESS8K
  * 3 - WOF_COMPRESSION_XPRESS16K
  * 4 - WOF_COMPRESSION_LZX32K
  */
 #define NI_FLAG_COMPRESSED_MASK		0x0000000f
-/* Data attribute is deduplicated */
+/* Data attribute is deduplicated. */
 #define NI_FLAG_DEDUPLICATED		0x00000010
 #define NI_FLAG_EA			0x00000020
 #define NI_FLAG_DIR			0x00000040
@@ -53,29 +53,29 @@ struct ntfs_mount_options {
 	u16 fs_fmask_inv;
 	u16 fs_dmask_inv;

-	unsigned uid : 1, /* uid was set */
-		gid : 1, /* gid was set */
-		fmask : 1, /* fmask was set */
-		dmask : 1, /*dmask was set*/
-		sys_immutable : 1, /* immutable system files */
-		discard : 1, /* issue discard requests on deletions */
-		sparse : 1, /*create sparse files*/
-		showmeta : 1, /*show meta files*/
-		nohidden : 1, /*do not show hidden files*/
-		force : 1, /*rw mount dirty volume*/
-		no_acs_rules : 1, /*exclude acs rules*/
-		prealloc : 1 /*preallocate space when file is growing*/
+	unsigned uid : 1,	/* uid was set. */
+		gid : 1,	/* gid was set. */
+		fmask : 1,	/* fmask was set. */
+		dmask : 1,	/* dmask was set. */
+		sys_immutable : 1,/* Immutable system files. */
+		discard : 1,	/* Issue discard requests on deletions. */
+		sparse : 1,	/* Create sparse files. */
+		showmeta : 1,	/* Show meta files. */
+		nohidden : 1, 	/* Do not show hidden files. */
+		force : 1, 	/* Rw mount dirty volume. */
+		no_acs_rules : 1,/*Exclude acs rules. */
+		prealloc : 1	/* Preallocate space when file is growing. */
 		;
 };

-/* special value to unpack and deallocate*/
+/* Special value to unpack and deallocate. */
 #define RUN_DEALLOCATE ((struct runs_tree *)(size_t)1)

-/* TODO: use rb tree instead of array */
+/* TODO: Use rb tree instead of array. */
 struct runs_tree {
 	struct ntfs_run *runs;
-	size_t count; // Currently used size a ntfs_run storage.
-	size_t allocated; // Currently allocated ntfs_run storage size.
+	size_t count; /* Currently used size a ntfs_run storage. */
+	size_t allocated; /* Currently allocated ntfs_run storage size. */
 };

 struct ntfs_buffers {
@@ -88,8 +88,8 @@ struct ntfs_buffers {
 };

 enum ALLOCATE_OPT {
-	ALLOCATE_DEF = 0, // Allocate all clusters
-	ALLOCATE_MFT = 1, // Allocate for MFT
+	ALLOCATE_DEF = 0, // Allocate all clusters.
+	ALLOCATE_MFT = 1, // Allocate for MFT.
 };

 enum bitmap_mutex_classes {
@@ -104,29 +104,29 @@ struct wnd_bitmap {
 	struct runs_tree run;
 	size_t nbits;

-	size_t total_zeroes; // total number of free bits
-	u16 *free_bits; // free bits in each window
+	size_t total_zeroes; // Total number of free bits.
+	u16 *free_bits; // Free bits in each window.
 	size_t nwnd;
-	u32 bits_last; // bits in last window
+	u32 bits_last; // Bits in last window.

-	struct rb_root start_tree; // extents, sorted by 'start'
-	struct rb_root count_tree; // extents, sorted by 'count + start'
-	size_t count; // extents count
+	struct rb_root start_tree; // Extents, sorted by 'start'.
+	struct rb_root count_tree; // Extents, sorted by 'count + start'.
+	size_t count; // Extents count.

 	/*
-	 * -1 Tree is activated but not updated (too many fragments)
-	 * 0 - Tree is not activated
-	 * 1 - Tree is activated and updated
+	 * -1 Tree is activated but not updated (too many fragments).
+	 * 0 - Tree is not activated.
+	 * 1 - Tree is activated and updated.
 	 */
 	int uptodated;
-	size_t extent_min; // Minimal extent used while building
-	size_t extent_max; // Upper estimate of biggest free block
+	size_t extent_min; // Minimal extent used while building.
+	size_t extent_max; // Upper estimate of biggest free block.

 	/* Zone [bit, end) */
 	size_t zone_bit;
 	size_t zone_end;

-	bool set_tail; // not necessary in driver
+	bool set_tail; // Not necessary in driver.
 	bool inited;
 };

@@ -143,14 +143,14 @@ enum index_mutex_classed {
 	INDEX_MUTEX_TOTAL
 };

-/* ntfs_index - allocation unit inside directory */
+/* ntfs_index - Allocation unit inside directory. */
 struct ntfs_index {
 	struct runs_tree bitmap_run;
 	struct runs_tree alloc_run;
 	/* read/write access to 'bitmap_run'/'alloc_run' while ntfs_readdir */
 	struct rw_semaphore run_lock;

-	/*TODO: remove 'cmp'*/
+	/*TODO: Remove 'cmp'. */
 	NTFS_CMP_FUNC cmp;

 	u8 index_bits; // log2(root->index_block_size)
@@ -159,10 +159,10 @@ struct ntfs_index {
 	u8 type; // index_mutex_classed
 };

-/* Minimum mft zone */
+/* Minimum MFT zone. */
 #define NTFS_MIN_MFT_ZONE 100

-/* ntfs file system in-core superblock data */
+/* Ntfs file system in-core superblock data. */
 struct ntfs_sb_info {
 	struct super_block *sb;

@@ -183,23 +183,23 @@ struct ntfs_sb_info {
 	u8 cluster_bits;
 	u8 record_bits;

-	u64 maxbytes; // Maximum size for normal files
-	u64 maxbytes_sparse; // Maximum size for sparse file
+	u64 maxbytes; // Maximum size for normal files.
+	u64 maxbytes_sparse; // Maximum size for sparse file.

-	u32 flags; // See NTFS_FLAGS_XXX
+	u32 flags; // See NTFS_FLAGS_XXX.

-	CLST bad_clusters; // The count of marked bad clusters
+	CLST bad_clusters; // The count of marked bad clusters.

-	u16 max_bytes_per_attr; // maximum attribute size in record
-	u16 attr_size_tr; // attribute size threshold (320 bytes)
+	u16 max_bytes_per_attr; // Maximum attribute size in record.
+	u16 attr_size_tr; // Attribute size threshold (320 bytes).

-	/* Records in $Extend */
+	/* Records in $Extend. */
 	CLST objid_no;
 	CLST quota_no;
 	CLST reparse_no;
 	CLST usn_jrnl_no;

-	struct ATTR_DEF_ENTRY *def_table; // attribute definition table
+	struct ATTR_DEF_ENTRY *def_table; // Attribute definition table.
 	u32 def_entries;
 	u32 ea_max_size;

@@ -212,13 +212,13 @@ struct ntfs_sb_info {
 		struct ntfs_inode *ni;
 		struct wnd_bitmap bitmap; // $MFT::Bitmap
 		/*
-		 * MFT records [11-24) used to expand MFT itself
+		 * MFT records [11-24) used to expand MFT itself.
 		 * They always marked as used in $MFT::Bitmap
-		 * 'reserved_bitmap' contains real bitmap of these records
+		 * 'reserved_bitmap' contains real bitmap of these records.
 		 */
-		ulong reserved_bitmap; // bitmap of used records [11 - 24)
+		ulong reserved_bitmap; // Bitmap of used records [11 - 24)
 		size_t next_free; // The next record to allocate from
-		size_t used; // mft valid size in records
+		size_t used; // MFT valid size in records.
 		u32 recs_mirr; // Number of records in MFTMirr
 		u8 next_reserved;
 		u8 reserved_bitmap_inited;
@@ -230,15 +230,15 @@ struct ntfs_sb_info {
 	} used;

 	struct {
-		u64 size; // in bytes
-		u64 blocks; // in blocks
+		u64 size; // In bytes.
+		u64 blocks; // In blocks.
 		u64 ser_num;
 		struct ntfs_inode *ni;
-		__le16 flags; // cached current VOLUME_INFO::flags, VOLUME_FLAG_DIRTY
+		__le16 flags; // Cached current VOLUME_INFO::flags, VOLUME_FLAG_DIRTY.
 		u8 major_ver;
 		u8 minor_ver;
 		char label[65];
-		bool real_dirty; /* real fs state*/
+		bool real_dirty; // Real fs state.
 	} volume;

 	struct {
@@ -277,9 +277,7 @@ struct ntfs_sb_info {
 	struct ratelimit_state msg_ratelimit;
 };

-/*
- * one MFT record(usually 1024 bytes), consists of attributes
- */
+/* One MFT record(usually 1024 bytes), consists of attributes. */
 struct mft_inode {
 	struct rb_node node;
 	struct ntfs_sb_info *sbi;
@@ -291,7 +289,7 @@ struct mft_inode {
 	bool dirty;
 };

-/* nested class for ntfs_inode::ni_lock */
+/* Nested class for ntfs_inode::ni_lock. */
 enum ntfs_inode_mutex_lock_class {
 	NTFS_INODE_MUTEX_DIRTY,
 	NTFS_INODE_MUTEX_SECURITY,
@@ -302,29 +300,31 @@ enum ntfs_inode_mutex_lock_class {
 };

 /*
- * ntfs inode - extends linux inode. consists of one or more mft inodes
+ * sturct ntfs_inode
+ *
+ * Ntfs inode - extends linux inode. consists of one or more MFT inodes.
  */
 struct ntfs_inode {
 	struct mft_inode mi; // base record

 	/*
-	 * Valid size: [0 - i_valid) - these range in file contains valid data
-	 * Range [i_valid - inode->i_size) - contains 0
-	 * Usually i_valid <= inode->i_size
+	 * Valid size: [0 - i_valid) - these range in file contains valid data.
+	 * Range [i_valid - inode->i_size) - contains 0.
+	 * Usually i_valid <= inode->i_size.
 	 */
 	u64 i_valid;
 	struct timespec64 i_crtime;

 	struct mutex ni_lock;

-	/* file attributes from std */
+	/* File attributes from std. */
 	enum FILE_ATTRIBUTE std_fa;
 	__le32 std_security_id;

 	/*
-	 * tree of mft_inode
-	 * not empty when primary MFT record (usually 1024 bytes) can't save all attributes
-	 * e.g. file becomes too fragmented or contains a lot of names
+	 * Tree of mft_inode.
+	 * Not empty when primary MFT record (usually 1024 bytes) can't save all attributes
+	 * e.g. file becomes too fragmented or contains a lot of names.
 	 */
 	struct rb_root mi_tree;

@@ -346,7 +346,7 @@ struct ntfs_inode {

 	struct {
 		struct runs_tree run;
-		struct ATTR_LIST_ENTRY *le; // 1K aligned memory
+		struct ATTR_LIST_ENTRY *le; // 1K aligned memory.
 		size_t size;
 		bool dirty;
 	} attr_list;
@@ -375,7 +375,7 @@ enum REPARSE_SIGN {
 	REPARSE_LINK = 3
 };

-/* functions from attrib.c*/
+/* Functions from attrib.c */
 int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
 		   struct runs_tree *run, const CLST *vcn);
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
@@ -410,7 +410,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes);

-/* functions from attrlist.c*/
+/* Functions from attrlist.c */
 void al_destroy(struct ntfs_inode *ni);
 bool al_verify(struct ntfs_inode *ni);
 int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr);
@@ -436,12 +436,12 @@ static inline size_t al_aligned(size_t size)
 	return (size + 1023) & ~(size_t)1023;
 }

-/* globals from bitfunc.c */
+/* Globals from bitfunc.c */
 bool are_bits_clear(const ulong *map, size_t bit, size_t nbits);
 bool are_bits_set(const ulong *map, size_t bit, size_t nbits);
 size_t get_set_bits_ex(const ulong *map, size_t bit, size_t nbits);

-/* globals from dir.c */
+/* Globals from dir.c */
 int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 		      u8 *buf, int buf_len);
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
@@ -452,7 +452,7 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;

-/* globals from file.c*/
+/* Globals from file.c */
 int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
@@ -466,7 +466,7 @@ extern const struct inode_operations ntfs_special_inode_operations;
 extern const struct inode_operations ntfs_file_inode_operations;
 extern const struct file_operations ntfs_file_operations;

-/* globals from frecord.c */
+/* Globals from frecord.c */
 void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
 struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni);
 struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni);
@@ -523,10 +523,10 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
 		   u32 pages_per_frame);

-/* globals from fslog.c */
+/* Globals from fslog.c */
 int log_replay(struct ntfs_inode *ni, bool *initialized);

-/* globals from fsntfs.c */
+/* Globals from fsntfs.c */
 bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
 int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 		       bool simple);
@@ -592,7 +592,7 @@ int ntfs_remove_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
 void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim);
 int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim);

-/* globals from index.c */
+/* Globals from index.c */
 int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit);
 void fnd_clear(struct ntfs_fnd *fnd);
 static inline struct ntfs_fnd *fnd_get(void)
@@ -632,7 +632,7 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
 		    const struct ATTR_FILE_NAME *fname,
 		    const struct NTFS_DUP_INFO *dup, int sync);

-/* globals from inode.c */
+/* Globals from inode.c */
 struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 			 const struct cpu_str *name);
 int ntfs_set_size(struct inode *inode, u64 new_size);
@@ -656,14 +656,14 @@ extern const struct inode_operations ntfs_link_inode_operations;
 extern const struct address_space_operations ntfs_aops;
 extern const struct address_space_operations ntfs_aops_cmpr;

-/* globals from name_i.c*/
+/* Globals from name_i.c */
 int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 		 const struct cpu_str *uni);
 struct dentry *ntfs3_get_parent(struct dentry *child);

 extern const struct inode_operations ntfs_dir_inode_operations;

-/* globals from record.c */
+/* Globals from record.c */
 int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
 void mi_put(struct mft_inode *mi);
 int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
@@ -717,7 +717,7 @@ static inline void mi_get_ref(const struct mft_inode *mi, struct MFT_REF *ref)
 	ref->seq = mi->mrec->seq;
 }

-/* globals from run.c */
+/* Globals from run.c */
 bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
 		      CLST *len, size_t *index);
 void run_truncate(struct runs_tree *run, CLST vcn);
@@ -746,13 +746,13 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 #endif
 int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn);

-/* globals from super.c */
+/* Globals from super.c */
 void *ntfs_set_shared(void *ptr, u32 bytes);
 void *ntfs_put_shared(void *ptr);
 void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len);
 int ntfs_discard(struct ntfs_sb_info *sbi, CLST Lcn, CLST Len);

-/* globals from bitmap.c*/
+/* Globals from bitmap.c*/
 int __init ntfs3_init_bitmap(void);
 void ntfs3_exit_bitmap(void);
 void wnd_close(struct wnd_bitmap *wnd);
@@ -766,7 +766,7 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits);
 bool wnd_is_free(struct wnd_bitmap *wnd, size_t bit, size_t bits);
 bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits);

-/* Possible values for 'flags' 'wnd_find' */
+/* Possible values for 'flags' 'wnd_find'. */
 #define BITMAP_FIND_MARK_AS_USED 0x01
 #define BITMAP_FIND_FULL 0x02
 size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
@@ -775,7 +775,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits);
 void wnd_zone_set(struct wnd_bitmap *wnd, size_t Lcn, size_t Len);
 int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range);

-/* globals from upcase.c */
+/* Globals from upcase.c */
 int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
 		   const u16 *upcase, bool bothcase);
 int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
@@ -812,7 +812,7 @@ static inline bool is_ntfs3(struct ntfs_sb_info *sbi)
 	return sbi->volume.major_ver >= 3;
 }

-/*(sb->s_flags & SB_ACTIVE)*/
+/* (sb->s_flags & SB_ACTIVE) */
 static inline bool is_mounted(struct ntfs_sb_info *sbi)
 {
 	return !!sbi->sb->s_root;
@@ -887,7 +887,7 @@ static inline bool run_is_empty(struct runs_tree *run)
 	return !run->count;
 }

-/* NTFS uses quad aligned bitmaps */
+/* NTFS uses quad aligned bitmaps. */
 static inline size_t bitmap_size(size_t bits)
 {
 	return QuadAlign((bits + 7) >> 3);
@@ -899,9 +899,7 @@ static inline size_t bitmap_size(size_t bits)
 #define NTFS_TIME_GRAN 100

 /*
- * kernel2nt
- *
- * converts in-memory kernel timestamp into nt time
+ * kernel2nt - Converts in-memory kernel timestamp into nt time.
  */
 static inline __le64 kernel2nt(const struct timespec64 *ts)
 {
@@ -912,9 +910,7 @@ static inline __le64 kernel2nt(const struct timespec64 *ts)
 }

 /*
- * nt2kernel
- *
- * converts on-disk nt time into kernel timestamp
+ * nt2kernel - Converts on-disk nt time into kernel timestamp.
  */
 static inline void nt2kernel(const __le64 tm, struct timespec64 *ts)
 {
@@ -930,13 +926,17 @@ static inline struct ntfs_sb_info *ntfs_sb(struct super_block *sb)
 	return sb->s_fs_info;
 }

-/* Align up on cluster boundary */
+/*
+ * ntfs_up_cluster - Align up on cluster boundary.
+ */
 static inline u64 ntfs_up_cluster(const struct ntfs_sb_info *sbi, u64 size)
 {
 	return (size + sbi->cluster_mask) & sbi->cluster_mask_inv;
 }

-/* Align up on cluster boundary */
+/*
+ * ntfs_up_block - Align up on cluster boundary.
+ */
 static inline u64 ntfs_up_block(const struct super_block *sb, u64 size)
 {
 	return (size + sb->s_blocksize - 1) & ~(u64)(sb->s_blocksize - 1);
@@ -986,7 +986,7 @@ static inline int ni_ext_compress_bits(const struct ntfs_inode *ni)
 	return 0xb + (ni->ni_flags & NI_FLAG_COMPRESSED_MASK);
 }

-/* bits - 0xc, 0xd, 0xe, 0xf, 0x10 */
+/* Bits - 0xc, 0xd, 0xe, 0xf, 0x10 */
 static inline void ni_set_ext_compress_bits(struct ntfs_inode *ni, u8 bits)
 {
 	ni->ni_flags |= (bits - 0xb) & NI_FLAG_COMPRESSED_MASK;
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 0d4a6251bddc..64a9c4f05c7c 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -18,15 +18,13 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
 			       const __le16 *name, u8 name_len,
 			       const u16 *upcase)
 {
-	/* First, compare the type codes: */
+	/* First, compare the type codes. */
 	int diff = le32_to_cpu(left->type) - le32_to_cpu(type);

 	if (diff)
 		return diff;

-	/*
-	 * They have the same type code, so we have to compare the names.
-	 */
+	/* They have the same type code, so we have to compare the names. */
 	return ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
 			      upcase, true);
 }
@@ -34,7 +32,7 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
 /*
  * mi_new_attt_id
  *
- * returns unused attribute id that is less than mrec->next_attr_id
+ * Return: Unused attribute id that is less than mrec->next_attr_id.
  */
 static __le16 mi_new_attt_id(struct mft_inode *mi)
 {
@@ -50,7 +48,7 @@ static __le16 mi_new_attt_id(struct mft_inode *mi)
 		return id;
 	}

-	/* One record can store up to 1024/24 ~= 42 attributes */
+	/* One record can store up to 1024/24 ~= 42 attributes. */
 	free_id = 0;
 	max_id = 0;

@@ -115,9 +113,7 @@ int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno)
 }

 /*
- * mi_read
- *
- * reads MFT data
+ * mi_read - Read MFT data.
  */
 int mi_read(struct mft_inode *mi, bool is_mft)
 {
@@ -178,7 +174,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 		goto out;

 ok:
-	/* check field 'total' only here */
+	/* Check field 'total' only here. */
 	if (le32_to_cpu(rec->total) != bpr) {
 		err = -EINVAL;
 		goto out;
@@ -210,13 +206,13 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}

-		/* Skip non-resident records */
+		/* Skip non-resident records. */
 		if (!is_rec_inuse(rec))
 			return NULL;

 		attr = Add2Ptr(rec, off);
 	} else {
-		/* Check if input attr inside record */
+		/* Check if input attr inside record. */
 		off = PtrOffset(rec, attr);
 		if (off >= used)
 			return NULL;
@@ -233,27 +229,27 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)

 	asize = le32_to_cpu(attr->size);

-	/* Can we use the first field (attr->type) */
+	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(QuadAlign(sizeof(enum ATTR_TYPE)) == 8);
 		return NULL;
 	}

 	if (attr->type == ATTR_END) {
-		/* end of enumeration */
+		/* End of enumeration. */
 		return NULL;
 	}

-	/* 0x100 is last known attribute for now*/
+	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
 	if ((t32 & 0xf) || (t32 > 0x100))
 		return NULL;

-	/* Check boundary */
+	/* Check boundary. */
 	if (off + asize > used)
 		return NULL;

-	/* Check size of attribute */
+	/* Check size of attribute. */
 	if (!attr->non_res) {
 		if (asize < SIZEOF_RESIDENT)
 			return NULL;
@@ -270,7 +266,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return attr;
 	}

-	/* Check some nonresident fields */
+	/* Check some nonresident fields. */
 	if (attr->name_len &&
 	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
 		    le16_to_cpu(attr->nres.run_off)) {
@@ -290,9 +286,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 }

 /*
- * mi_find_attr
- *
- * finds the attribute by type and name and id
+ * mi_find_attr - Find the attribute by type and name and id.
  */
 struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
 			    enum ATTR_TYPE type, const __le16 *name,
@@ -372,7 +366,7 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 	} else if (mi_read(mi, is_mft)) {
 		;
 	} else if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
-		/* Record is reused. Update its sequence number */
+		/* Record is reused. Update its sequence number. */
 		seq = le16_to_cpu(rec->seq) + 1;
 		if (!seq)
 			seq = 1;
@@ -404,9 +398,7 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 }

 /*
- * mi_mark_free
- *
- * marks record as unused and marks it as free in bitmap
+ * mi_mark_free - Mark record as unused and marks it as free in bitmap.
  */
 void mi_mark_free(struct mft_inode *mi)
 {
@@ -428,10 +420,9 @@ void mi_mark_free(struct mft_inode *mi)
 }

 /*
- * mi_insert_attr
+ * mi_insert_attr - Reserve space for new attribute.
  *
- * reserves space for new attribute
- * returns not full constructed attribute or NULL if not possible to create
+ * Return: Not full constructed attribute or NULL if not possible to create.
  */
 struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 			      const __le16 *name, u8 name_len, u32 asize,
@@ -468,7 +459,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 	}

 	if (!attr) {
-		tail = 8; /* not used, just to suppress warning */
+		tail = 8; /* Not used, just to suppress warning. */
 		attr = Add2Ptr(rec, used - 8);
 	} else {
 		tail = used - PtrOffset(rec, attr);
@@ -494,10 +485,9 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 }

 /*
- * mi_remove_attr
+ * mi_remove_attr - Remove the attribute from record.
  *
- * removes the attribute from record
- * NOTE: The source attr will point to next attribute
+ * NOTE: The source attr will point to next attribute.
  */
 bool mi_remove_attr(struct mft_inode *mi, struct ATTRIB *attr)
 {
@@ -543,7 +533,7 @@ bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes)
 		if (used + dsize > total)
 			return false;
 		nsize = asize + dsize;
-		// move tail
+		/* Move tail */
 		memmove(next + dsize, next, tail);
 		memset(next, 0, dsize);
 		used += dsize;
@@ -585,10 +575,10 @@ int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
 	u32 tail = used - aoff - asize;
 	u32 dsize = sbi->record_size - used;

-	/* Make a maximum gap in current record */
+	/* Make a maximum gap in current record. */
 	memmove(next + dsize, next, tail);

-	/* Pack as much as possible */
+	/* Pack as much as possible. */
 	err = run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size + dsize,
 		       &plen);
 	if (err < 0) {
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 5cdf6efe67e0..fe9ee822a970 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -15,22 +15,21 @@
 #include "ntfs.h"
 #include "ntfs_fs.h"

-/* runs_tree is a continues memory. Try to avoid big size  */
+/* runs_tree is a continues memory. Try to avoid big size. */
 #define NTFS3_RUN_MAX_BYTES 0x10000

 struct ntfs_run {
-	CLST vcn; /* virtual cluster number */
-	CLST len; /* length in clusters */
-	CLST lcn; /* logical cluster number */
+	CLST vcn; /* Virtual cluster number. */
+	CLST len; /* Length in clusters. */
+	CLST lcn; /* Logical cluster number. */
 };

 /*
- * run_lookup
+ * run_lookup - Lookup the index of a MCB entry that is first <= vcn.
  *
- * Lookup the index of a MCB entry that is first <= vcn.
- * case of success it will return non-zero value and set
- * 'index' parameter to index of entry been found.
- * case of entry missing from list 'index' will be set to
+ * Case of success it will return non-zero value and set
+ * @index parameter to index of entry been found.
+ * Case of entry missing from list 'index' will be set to
  * point to insertion position for the entry question.
  */
 bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
@@ -46,7 +45,7 @@ bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
 	min_idx = 0;
 	max_idx = run->count - 1;

-	/* Check boundary cases specially, 'cause they cover the often requests */
+	/* Check boundary cases specially, 'cause they cover the often requests. */
 	r = run->runs;
 	if (vcn < r->vcn) {
 		*index = 0;
@@ -90,9 +89,7 @@ bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
 }

 /*
- * run_consolidate
- *
- * consolidate runs starting from a given one.
+ * run_consolidate - Consolidate runs starting from a given one.
  */
 static void run_consolidate(struct runs_tree *run, size_t index)
 {
@@ -163,7 +160,11 @@ static void run_consolidate(struct runs_tree *run, size_t index)
 	}
 }

-/* returns true if range [svcn - evcn] is mapped*/
+/*
+ * run_is_mapped_full
+ *
+ * Return: True if range [svcn - evcn] is mapped.
+ */
 bool run_is_mapped_full(const struct runs_tree *run, CLST svcn, CLST evcn)
 {
 	size_t i;
@@ -223,9 +224,7 @@ bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
 }

 /*
- * run_truncate_head
- *
- * decommit the range before vcn
+ * run_truncate_head - Decommit the range before vcn.
  */
 void run_truncate_head(struct runs_tree *run, CLST vcn)
 {
@@ -260,9 +259,7 @@ void run_truncate_head(struct runs_tree *run, CLST vcn)
 }

 /*
- * run_truncate
- *
- * decommit the range after vcn
+ * run_truncate - Decommit the range after vcn.
  */
 void run_truncate(struct runs_tree *run, CLST vcn)
 {
@@ -284,13 +281,13 @@ void run_truncate(struct runs_tree *run, CLST vcn)
 	}

 	/*
-	 * At this point 'index' is set to
-	 * position that should be thrown away (including index itself)
+	 * At this point 'index' is set to position that
+	 * should be thrown away (including index itself)
 	 * Simple one - just set the limit.
 	 */
 	run->count = index;

-	/* Do not reallocate array 'runs'. Only free if possible */
+	/* Do not reallocate array 'runs'. Only free if possible. */
 	if (!index) {
 		ntfs_vfree(run->runs);
 		run->runs = NULL;
@@ -298,7 +295,9 @@ void run_truncate(struct runs_tree *run, CLST vcn)
 	}
 }

-/* trim head and tail if necessary*/
+/*
+ * run_truncate_around - Trim head and tail if necessary.
+ */
 void run_truncate_around(struct runs_tree *run, CLST vcn)
 {
 	run_truncate_head(run, vcn);
@@ -310,9 +309,10 @@ void run_truncate_around(struct runs_tree *run, CLST vcn)
 /*
  * run_add_entry
  *
- * sets location to known state.
- * run to be added may overlap with existing location.
- * returns false if of memory
+ * Sets location to known state.
+ * Run to be added may overlap with existing location.
+ *
+ * Return: false if of memory.
  */
 bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 		   bool is_mft)
@@ -335,7 +335,7 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 	 * Shortcut here would be case of
 	 * range not been found but one been added
 	 * continues previous run.
-	 * this case I can directly make use of
+	 * This case I can directly make use of
 	 * existing range as my start point.
 	 */
 	if (!inrange && index > 0) {
@@ -366,13 +366,13 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 		/*
 		 * Check allocated space.
 		 * If one is not enough to get one more entry
-		 * then it will be reallocated
+		 * then it will be reallocated.
 		 */
 		if (run->allocated < used + sizeof(struct ntfs_run)) {
 			size_t bytes;
 			struct ntfs_run *new_ptr;

-			/* Use power of 2 for 'bytes'*/
+			/* Use power of 2 for 'bytes'. */
 			if (!used) {
 				bytes = 64;
 			} else if (used <= 16 * PAGE_SIZE) {
@@ -420,10 +420,10 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 		r = run->runs + index;

 		/*
-		 * If one of ranges was not allocated
-		 * then I have to split location I just matched.
-		 * and insert current one
-		 * a common case this requires tail to be reinserted
+		 * If one of ranges was not allocated then we
+		 * have to split location we just matched and
+		 * insert current one.
+		 * A common case this requires tail to be reinserted
 		 * a recursive call.
 		 */
 		if (((lcn == SPARSE_LCN) != (r->lcn == SPARSE_LCN)) ||
@@ -448,12 +448,12 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 				goto requires_new_range;
 			}

-			/* lcn should match one I'm going to add. */
+			/* lcn should match one were going to add. */
 			r->lcn = lcn;
 		}

 		/*
-		 * If existing range fits then I'm done.
+		 * If existing range fits then were done.
 		 * Otherwise extend found one and fall back to range jocode.
 		 */
 		if (r->vcn + r->len < vcn + len)
@@ -472,8 +472,8 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 	run_consolidate(run, index + 1);

 	/*
-	 * a special case
-	 * I have to add extra range a tail.
+	 * A special case.
+	 * We have to add extra range a tail.
 	 */
 	if (should_add_tail &&
 	    !run_add_entry(run, tail_vcn, tail_lcn, tail_len, is_mft))
@@ -482,7 +482,11 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 	return true;
 }

-/*helper for attr_collapse_range, which is helper for fallocate(collapse_range)*/
+/* run_collapse_range
+ *
+ * Helper for attr_collapse_range(),
+ * which is helper for fallocate(collapse_range).
+ */
 bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
 {
 	size_t index, eat;
@@ -490,7 +494,7 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
 	CLST end;

 	if (WARN_ON(!run_lookup(run, vcn, &index)))
-		return true; /* should never be here */
+		return true; /* Should never be here. */

 	e = run->runs + run->count;
 	r = run->runs + index;
@@ -498,13 +502,13 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)

 	if (vcn > r->vcn) {
 		if (r->vcn + r->len <= end) {
-			/* collapse tail of run */
+			/* Collapse tail of run .*/
 			r->len = vcn - r->vcn;
 		} else if (r->lcn == SPARSE_LCN) {
-			/* collapse a middle part of sparsed run */
+			/* Collapse a middle part of sparsed run. */
 			r->len -= len;
 		} else {
-			/* collapse a middle part of normal run, split */
+			/* Collapse a middle part of normal run, split. */
 			if (!run_add_entry(run, vcn, SPARSE_LCN, len, false))
 				return false;
 			return run_collapse_range(run, vcn, len);
@@ -525,7 +529,7 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
 		}

 		if (r->vcn + r->len <= end) {
-			/* eat this run */
+			/* Eat this run. */
 			eat_end = r + 1;
 			continue;
 		}
@@ -545,9 +549,7 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
 }

 /*
- * run_get_entry
- *
- * returns index-th mapped region
+ * run_get_entry - Return index-th mapped region.
  */
 bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
 		   CLST *lcn, CLST *len)
@@ -572,9 +574,7 @@ bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
 }

 /*
- * run_packed_size
- *
- * calculates the size of packed int64
+ * run_packed_size - Calculate the size of packed int64.
  */
 #ifdef __BIG_ENDIAN
 static inline int run_packed_size(const s64 n)
@@ -604,7 +604,7 @@ static inline int run_packed_size(const s64 n)
 	return (const u8 *)&n + sizeof(n) - p;
 }

-/* full trusted function. It does not check 'size' for errors */
+/* Full trusted function. It does not check 'size' for errors. */
 static inline void run_pack_s64(u8 *run_buf, u8 size, s64 v)
 {
 	const u8 *p = (u8 *)&v;
@@ -636,7 +636,7 @@ static inline void run_pack_s64(u8 *run_buf, u8 size, s64 v)
 	}
 }

-/* full trusted function. It does not check 'size' for errors */
+/* Full trusted function. It does not check 'size' for errors. */
 static inline s64 run_unpack_s64(const u8 *run_buf, u8 size, s64 v)
 {
 	u8 *p = (u8 *)&v;
@@ -699,12 +699,12 @@ static inline int run_packed_size(const s64 n)
 	return 1 + p - (const u8 *)&n;
 }

-/* full trusted function. It does not check 'size' for errors */
+/* Full trusted function. It does not check 'size' for errors. */
 static inline void run_pack_s64(u8 *run_buf, u8 size, s64 v)
 {
 	const u8 *p = (u8 *)&v;

-	/* memcpy( run_buf, &v, size); is it faster? */
+	/* memcpy( run_buf, &v, size); Is it faster? */
 	switch (size) {
 	case 8:
 		run_buf[7] = p[7];
@@ -737,7 +737,7 @@ static inline s64 run_unpack_s64(const u8 *run_buf, u8 size, s64 v)
 {
 	u8 *p = (u8 *)&v;

-	/* memcpy( &v, run_buf, size); is it faster? */
+	/* memcpy( &v, run_buf, size); Is it faster? */
 	switch (size) {
 	case 8:
 		p[7] = run_buf[7];
@@ -768,11 +768,10 @@ static inline s64 run_unpack_s64(const u8 *run_buf, u8 size, s64 v)
 #endif

 /*
- * run_pack
+ * run_pack - Pack runs into buffer.
  *
- * packs runs into buffer
- * packed_vcns - how much runs we have packed
- * packed_size - how much bytes we have used run_buf
+ * packed_vcns - How much runs we have packed.
+ * packed_size - How much bytes we have used run_buf.
  */
 int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 	     u32 run_buf_size, CLST *packed_vcns)
@@ -806,10 +805,10 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 		if (next_vcn > evcn1)
 			len = evcn1 - vcn;

-		/* how much bytes required to pack len */
+		/* How much bytes required to pack len. */
 		size_size = run_packed_size(len);

-		/* offset_size - how much bytes is packed dlcn */
+		/* offset_size - How much bytes is packed dlcn. */
 		if (lcn == SPARSE_LCN) {
 			offset_size = 0;
 			dlcn = 0;
@@ -824,20 +823,20 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 		if (tmp <= 0)
 			goto out;

-		/* can we store this entire run */
+		/* Can we store this entire run. */
 		if (tmp < size_size)
 			goto out;

 		if (run_buf) {
-			/* pack run header */
+			/* Pack run header. */
 			run_buf[0] = ((u8)(size_size | (offset_size << 4)));
 			run_buf += 1;

-			/* Pack the length of run */
+			/* Pack the length of run. */
 			run_pack_s64(run_buf, size_size, len);

 			run_buf += size_size;
-			/* Pack the offset from previous lcn */
+			/* Pack the offset from previous LCN. */
 			run_pack_s64(run_buf, offset_size, dlcn);
 			run_buf += offset_size;
 		}
@@ -857,7 +856,7 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 	}

 out:
-	/* Store last zero */
+	/* Store last zero. */
 	if (run_buf)
 		run_buf[0] = 0;

@@ -868,10 +867,9 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 }

 /*
- * run_unpack
+ * run_unpack - Unpack packed runs from @run_buf.
  *
- * unpacks packed runs from "run_buf"
- * returns error, if negative, or real used bytes
+ * Return: Error if negative, or real used bytes.
  */
 int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
@@ -881,7 +879,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	const u8 *run_last, *run_0;
 	bool is_mft = ino == MFT_REC_MFT;

-	/* Check for empty */
+	/* Check for empty. */
 	if (evcn + 1 == svcn)
 		return 0;

@@ -893,12 +891,12 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	prev_lcn = 0;
 	vcn64 = svcn;

-	/* Read all runs the chain */
-	/* size_size - how much bytes is packed len */
+	/* Read all runs the chain. */
+	/* size_size - How much bytes is packed len. */
 	while (run_buf < run_last) {
-		/* size_size - how much bytes is packed len */
+		/* size_size - How much bytes is packed len. */
 		u8 size_size = *run_buf & 0xF;
-		/* offset_size - how much bytes is packed dlcn */
+		/* offset_size - How much bytes is packed dlcn. */
 		u8 offset_size = *run_buf++ >> 4;
 		u64 len;

@@ -907,8 +905,8 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,

 		/*
 		 * Unpack runs.
-		 * NOTE: runs are stored little endian order
-		 * "len" is unsigned value, "dlcn" is signed
+		 * NOTE: Runs are stored little endian order
+		 * "len" is unsigned value, "dlcn" is signed.
 		 * Large positive number requires to store 5 bytes
 		 * e.g.: 05 FF 7E FF FF 00 00 00
 		 */
@@ -916,7 +914,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			return -EINVAL;

 		len = run_unpack_s64(run_buf, size_size, 0);
-		/* skip size_size */
+		/* Skip size_size. */
 		run_buf += size_size;

 		if (!len)
@@ -927,10 +925,10 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		else if (offset_size <= 8) {
 			s64 dlcn;

-			/* initial value of dlcn is -1 or 0 */
+			/* Initial value of dlcn is -1 or 0. */
 			dlcn = (run_buf[offset_size - 1] & 0x80) ? (s64)-1 : 0;
 			dlcn = run_unpack_s64(run_buf, offset_size, dlcn);
-			/* skip offset_size */
+			/* Skip offset_size. */
 			run_buf += offset_size;

 			if (!dlcn)
@@ -941,7 +939,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			return -EINVAL;

 		next_vcn = vcn64 + len;
-		/* check boundary */
+		/* Check boundary. */
 		if (next_vcn > evcn + 1)
 			return -EINVAL;

@@ -957,14 +955,17 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		}
 #endif
 		if (lcn != SPARSE_LCN64 && lcn + len > sbi->used.bitmap.nbits) {
-			/* lcn range is out of volume */
+			/* LCN range is out of volume. */
 			return -EINVAL;
 		}

 		if (!run)
-			; /* called from check_attr(fslog.c) to check run */
+			; /* Called from check_attr(fslog.c) to check run. */
 		else if (run == RUN_DEALLOCATE) {
-			/* called from ni_delete_all to free clusters without storing in run */
+			/*
+			 * Called from ni_delete_all to free clusters
+			 * without storing in run.
+			 */
 			if (lcn != SPARSE_LCN64)
 				mark_as_free_ex(sbi, lcn, len, true);
 		} else if (vcn64 >= vcn) {
@@ -982,7 +983,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	}

 	if (vcn64 != evcn + 1) {
-		/* not expected length of unpacked runs */
+		/* Not expected length of unpacked runs. */
 		return -EINVAL;
 	}

@@ -991,11 +992,11 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,

 #ifdef NTFS3_CHECK_FREE_CLST
 /*
- * run_unpack_ex
+ * run_unpack_ex - Unpack packed runs from "run_buf".
+ *
+ * Checks unpacked runs to be used in bitmap.
  *
- * unpacks packed runs from "run_buf"
- * checks unpacked runs to be used in bitmap
- * returns error, if negative, or real used bytes
+ * Return: Error if negative, or real used bytes.
  */
 int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
@@ -1035,17 +1036,17 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			continue;

 		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
-		/* Check for free blocks */
+		/* Check for free blocks. */
 		ok = wnd_is_used(wnd, lcn, len);
 		up_read(&wnd->rw_lock);
 		if (ok)
 			continue;

-		/* Looks like volume is corrupted */
+		/* Looks like volume is corrupted. */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);

 		if (down_write_trylock(&wnd->rw_lock)) {
-			/* mark all zero bits as used in range [lcn, lcn+len) */
+			/* Mark all zero bits as used in range [lcn, lcn+len). */
 			CLST i, lcn_f = 0, len_f = 0;

 			err = 0;
@@ -1078,8 +1079,8 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 /*
  * run_get_highest_vcn
  *
- * returns the highest vcn from a mapping pairs array
- * it used while replaying log file
+ * Return the highest vcn from a mapping pairs array
+ * it used while replaying log file.
  */
 int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
 {
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index c563431248bf..14a446e4ef37 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -7,15 +7,15 @@
  *                 terminology
  *
  * cluster - allocation unit     - 512,1K,2K,4K,...,2M
- * vcn - virtual cluster number  - offset inside the file in clusters
- * vbo - virtual byte offset     - offset inside the file in bytes
- * lcn - logical cluster number  - 0 based cluster in clusters heap
- * lbo - logical byte offset     - absolute position inside volume
- * run - maps vcn to lcn         - stored in attributes in packed form
- * attr - attribute segment      - std/name/data etc records inside MFT
- * mi  - mft inode               - one MFT record(usually 1024 bytes or 4K), consists of attributes
- * ni  - ntfs inode              - extends linux inode. consists of one or more mft inodes
- * index - unit inside directory - 2K, 4K, <=page size, does not depend on cluster size
+ * vcn - virtual cluster number  - Offset inside the file in clusters.
+ * vbo - virtual byte offset     - Offset inside the file in bytes.
+ * lcn - logical cluster number  - 0 based cluster in clusters heap.
+ * lbo - logical byte offset     - Absolute position inside volume.
+ * run - maps VCN to LCN         - Stored in attributes in packed form.
+ * attr - attribute segment      - std/name/data etc records inside MFT.
+ * mi  - MFT inode               - One MFT record(usually 1024 bytes or 4K), consists of attributes.
+ * ni  - NTFS inode              - Extends linux inode. consists of one or more mft inodes.
+ * index - unit inside directory - 2K, 4K, <=page size, does not depend on cluster size.
  *
  * TODO: Implement
  * https://docs.microsoft.com/en-us/windows/wsl/file-permissions
@@ -42,7 +42,8 @@

 #ifdef CONFIG_PRINTK
 /*
- * Trace warnings/notices/errors
+ * ntfs_printk - Trace warnings/notices/errors.
+ *
  * Thanks Joe Perches <joe@perches.com> for implementation
  */
 void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
@@ -52,7 +53,7 @@ void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
 	int level;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;

-	/*should we use different ratelimits for warnings/notices/errors? */
+	/* Should we use different ratelimits for warnings/notices/errors? */
 	if (!___ratelimit(&sbi->msg_ratelimit, "ntfs3"))
 		return;

@@ -67,9 +68,13 @@ void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
 }

 static char s_name_buf[512];
-static atomic_t s_name_buf_cnt = ATOMIC_INIT(1); // 1 means 'free s_name_buf'
+static atomic_t s_name_buf_cnt = ATOMIC_INIT(1); // 1 means 'free s_name_buf'.

-/* print warnings/notices/errors about inode using name or inode number */
+/*
+ * ntfs_inode_printk
+ *
+ * Print warnings/notices/errors about inode using name or inode number.
+ */
 void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 {
 	struct super_block *sb = inode->i_sb;
@@ -82,7 +87,7 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 	if (!___ratelimit(&sbi->msg_ratelimit, "ntfs3"))
 		return;

-	/* use static allocated buffer, if possible */
+	/* Use static allocated buffer, if possible. */
 	name = atomic_dec_and_test(&s_name_buf_cnt)
 		       ? s_name_buf
 		       : kmalloc(sizeof(s_name_buf), GFP_NOFS);
@@ -95,11 +100,11 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 			spin_lock(&de->d_lock);
 			snprintf(name, name_len, " \"%s\"", de->d_name.name);
 			spin_unlock(&de->d_lock);
-			name[name_len] = 0; /* to be sure*/
+			name[name_len] = 0; /* To be sure. */
 		} else {
 			name[0] = 0;
 		}
-		dput(de); /* cocci warns if placed in branch "if (de)" */
+		dput(de); /* Cocci warns if placed in branch "if (de)" */
 	}

 	va_start(args, fmt);
@@ -122,12 +127,12 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 /*
  * Shared memory struct.
  *
- * on-disk ntfs's upcase table is created by ntfs formater
- * 'upcase' table is 128K bytes of memory
- * we should read it into memory when mounting
- * Several ntfs volumes likely use the same 'upcase' table
- * It is good idea to share in-memory 'upcase' table between different volumes
- * Unfortunately winxp/vista/win7 use different upcase tables
+ * On-disk ntfs's upcase table is created by ntfs formater
+ * 'upcase' table is 128K bytes of memory.
+ * We should read it into memory when mounting.
+ * Several ntfs volumes likely use the same 'upcase' table.
+ * It is good idea to share in-memory 'upcase' table between different volumes.
+ * Unfortunately winxp/vista/win7 use different upcase tables.
  */
 static DEFINE_SPINLOCK(s_shared_lock);

@@ -140,8 +145,9 @@ static struct {
 /*
  * ntfs_set_shared
  *
- * Returns 'ptr' if pointer was saved in shared memory
- * Returns NULL if pointer was not shared
+ * Return:
+ * * @ptr - If pointer was saved in shared memory.
+ * * NULL - If pointer was not shared.
  */
 void *ntfs_set_shared(void *ptr, u32 bytes)
 {
@@ -174,8 +180,9 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 /*
  * ntfs_put_shared
  *
- * Returns 'ptr' if pointer is not shared anymore
- * Returns NULL if pointer is still shared
+ * Return:
+ * * @ptr - If pointer is not shared anymore.
+ * * NULL - If pointer is still shared.
  */
 void *ntfs_put_shared(void *ptr)
 {
@@ -350,7 +357,10 @@ static noinline int ntfs_parse_options(struct super_block *sb, char *options,

 out:
 	if (!strcmp(nls_name[0] ? nls_name : CONFIG_NLS_DEFAULT, "utf8")) {
-		/* For UTF-8 use utf16s_to_utf8s/utf8s_to_utf16s instead of nls */
+		/*
+		 * For UTF-8 use utf16s_to_utf8s()/utf8s_to_utf16s()
+		 * instead of NLS.
+		 */
 		nls = NULL;
 	} else if (nls_name[0]) {
 		nls = load_nls(nls_name);
@@ -380,7 +390,7 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 	if (data && !orig_data)
 		return -ENOMEM;

-	/* Store  original options */
+	/* Store  original options. */
 	memcpy(&old_opts, &sbi->options, sizeof(old_opts));
 	clear_mount_options(&sbi->options);
 	memset(&sbi->options, 0, sizeof(sbi->options));
@@ -462,7 +472,9 @@ static void init_once(void *foo)
 	inode_init_once(&ni->vfs_inode);
 }

-/* noinline to reduce binary size*/
+/*
+ * put_ntfs - Noinline to reduce binary size.
+ */
 static noinline void put_ntfs(struct ntfs_sb_info *sbi)
 {
 	ntfs_free(sbi->new_rec);
@@ -507,7 +519,7 @@ static void ntfs_put_super(struct super_block *sb)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;

-	/*mark rw ntfs as clear, if possible*/
+	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);

 	put_ntfs(sbi);
@@ -578,7 +590,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }

-/*super_operations::sync_fs*/
+/*
+ * ntfs_sync_fs - super_operations::sync_fs
+ */
 static int ntfs_sync_fs(struct super_block *sb, int wait)
 {
 	int err = 0, err2;
@@ -680,10 +694,12 @@ static const struct export_operations ntfs_export_ops = {
 	.commit_metadata = ntfs_nfs_commit_metadata,
 };

-/* Returns Gb,Mb to print with "%u.%02u Gb" */
+/*
+ * format_size_gb - Return Gb,Mb to print with "%u.%02u Gb".
+ */
 static u32 format_size_gb(const u64 bytes, u32 *mb)
 {
-	/* Do simple right 30 bit shift of 64 bit value */
+	/* Do simple right 30 bit shift of 64 bit value. */
 	u64 kbytes = bytes >> 10;
 	u32 kbytes32 = kbytes;

@@ -701,7 +717,9 @@ static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
 		       : (1u << (0 - boot->sectors_per_clusters));
 }

-/* inits internal info from on-disk boot sector*/
+/*
+ * ntfs_init_from_boot - Init internal info from on-disk boot sector.
+ */
 static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 			       u64 dev_size)
 {
@@ -752,14 +770,14 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (mlcn2 * sct_per_clst >= sectors)
 		goto out;

-	/* Check MFT record size */
+	/* Check MFT record size. */
 	if ((boot->record_size < 0 &&
 	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
 	    (boot->record_size >= 0 && !is_power_of2(boot->record_size))) {
 		goto out;
 	}

-	/* Check index record size */
+	/* Check index record size. */
 	if ((boot->index_size < 0 &&
 	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
 	    (boot->index_size >= 0 && !is_power_of2(boot->index_size))) {
@@ -773,9 +791,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	gb = format_size_gb(fs_size, &mb);

 	/*
-	 * - Volume formatted and mounted with the same sector size
-	 * - Volume formatted 4K and mounted as 512
-	 * - Volume formatted 512 and mounted as 4K
+	 * - Volume formatted and mounted with the same sector size.
+	 * - Volume formatted 4K and mounted as 512.
+	 * - Volume formatted 512 and mounted as 4K.
 	 */
 	if (sbi->sector_size != sector_size) {
 		ntfs_warn(sb,
@@ -817,7 +835,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
 	sbi->volume.size = sectors << sbi->sector_bits;

-	/* warning if RAW volume */
+	/* Warning if RAW volume. */
 	if (dev_size < fs_size) {
 		u32 mb0, gb0;

@@ -831,7 +849,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,

 	clusters = sbi->volume.size >> sbi->cluster_bits;
 #ifndef CONFIG_NTFS3_64BIT_CLUSTER
-	/* 32 bits per cluster */
+	/* 32 bits per cluster. */
 	if (clusters >> 32) {
 		ntfs_notice(
 			sb,
@@ -869,7 +887,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->blocks_per_cluster = sbi->cluster_size >> sb->s_blocksize_bits;
 	sbi->volume.blocks = sbi->volume.size >> sb->s_blocksize_bits;

-	/* Maximum size for normal files */
+	/* Maximum size for normal files. */
 	sbi->maxbytes = (clusters << sbi->cluster_bits) - 1;

 #ifdef CONFIG_NTFS3_64BIT_CLUSTER
@@ -877,7 +895,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		sbi->maxbytes = -1;
 	sbi->maxbytes_sparse = -1;
 #else
-	/* Maximum size for sparse file */
+	/* Maximum size for sparse file. */
 	sbi->maxbytes_sparse = (1ull << (sbi->cluster_bits + 32)) - 1;
 #endif

@@ -889,7 +907,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	return err;
 }

-/* try to mount*/
+/*
+ * ntfs_fill_super - Try to mount.
+ */
 static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int err;
@@ -942,7 +962,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)

 	sb_set_blocksize(sb, PAGE_SIZE);

-	/* parse boot */
+	/* Parse boot. */
 	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
 				  bd_inode->i_size);
 	if (err)
@@ -961,8 +981,8 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 #endif

 	/*
-	 * Load $Volume. This should be done before LogFile
-	 * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'
+	 * Load $Volume. This should be done before $LogFile
+	 * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'.
 	 */
 	ref.low = cpu_to_le32(MFT_REC_VOL);
 	ref.seq = cpu_to_le16(MFT_REC_VOL);
@@ -976,13 +996,13 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)

 	ni = ntfs_i(inode);

-	/* Load and save label (not necessary) */
+	/* Load and save label (not necessary). */
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_LABEL, NULL, 0, NULL, NULL);

 	if (!attr) {
 		/* It is ok if no ATTR_LABEL */
 	} else if (!attr->non_res && !is_attr_ext(attr)) {
-		/* $AttrDef allows labels to be up to 128 symbols */
+		/* $AttrDef allows labels to be up to 128 symbols. */
 		err = utf16s_to_utf8s(resident_data(attr),
 				      le32_to_cpu(attr->res.data_size) >> 1,
 				      UTF16_LITTLE_ENDIAN, sbi->volume.label,
@@ -990,7 +1010,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err < 0)
 			sbi->volume.label[0] = 0;
 	} else {
-		/* should we break mounting here? */
+		/* Should we break mounting here? */
 		//err = -EINVAL;
 		//goto out;
 	}
@@ -1014,7 +1034,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->volume.ni = ni;
 	inode = NULL;

-	/* Load $MFTMirr to estimate recs_mirr */
+	/* Load $MFTMirr to estimate recs_mirr. */
 	ref.low = cpu_to_le32(MFT_REC_MIRR);
 	ref.seq = cpu_to_le16(MFT_REC_MIRR);
 	inode = ntfs_iget5(sb, &ref, &NAME_MIRROR);
@@ -1030,7 +1050,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)

 	iput(inode);

-	/* Load LogFile to replay */
+	/* Load $LogFile to replay. */
 	ref.low = cpu_to_le32(MFT_REC_LOG);
 	ref.seq = cpu_to_le16(MFT_REC_LOG);
 	inode = ntfs_iget5(sb, &ref, &NAME_LOGFILE);
@@ -1069,7 +1089,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}

-	/* Load $MFT */
+	/* Load $MFT. */
 	ref.low = cpu_to_le32(MFT_REC_MFT);
 	ref.seq = cpu_to_le16(1);

@@ -1097,7 +1117,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)

 	sbi->mft.ni = ni;

-	/* Load $BadClus */
+	/* Load $BadClus. */
 	ref.low = cpu_to_le32(MFT_REC_BADCLUST);
 	ref.seq = cpu_to_le16(MFT_REC_BADCLUST);
 	inode = ntfs_iget5(sb, &ref, &NAME_BADCLUS);
@@ -1122,7 +1142,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)

 	iput(inode);

-	/* Load $Bitmap */
+	/* Load $Bitmap. */
 	ref.low = cpu_to_le32(MFT_REC_BITMAP);
 	ref.seq = cpu_to_le16(MFT_REC_BITMAP);
 	inode = ntfs_iget5(sb, &ref, &NAME_BITMAP);
@@ -1142,14 +1162,14 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 #endif

-	/* Check bitmap boundary */
+	/* Check bitmap boundary. */
 	tt = sbi->used.bitmap.nbits;
 	if (inode->i_size < bitmap_size(tt)) {
 		err = -EINVAL;
 		goto out;
 	}

-	/* Not necessary */
+	/* Not necessary. */
 	sbi->used.bitmap.set_tail = true;
 	err = wnd_init(&sbi->used.bitmap, sbi->sb, tt);
 	if (err)
@@ -1157,12 +1177,12 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)

 	iput(inode);

-	/* Compute the mft zone */
+	/* Compute the MFT zone. */
 	err = ntfs_refresh_zone(sbi);
 	if (err)
 		goto out;

-	/* Load $AttrDef */
+	/* Load $AttrDef. */
 	ref.low = cpu_to_le32(MFT_REC_ATTR);
 	ref.seq = cpu_to_le16(MFT_REC_ATTR);
 	inode = ntfs_iget5(sbi->sb, &ref, &NAME_ATTRDEF);
@@ -1226,7 +1246,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	iput(inode);

-	/* Load $UpCase */
+	/* Load $UpCase. */
 	ref.low = cpu_to_le32(MFT_REC_UPCASE);
 	ref.seq = cpu_to_le16(MFT_REC_UPCASE);
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
@@ -1281,29 +1301,29 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	inode = NULL;

 	if (is_ntfs3(sbi)) {
-		/* Load $Secure */
+		/* Load $Secure. */
 		err = ntfs_security_init(sbi);
 		if (err)
 			goto out;

-		/* Load $Extend */
+		/* Load $Extend. */
 		err = ntfs_extend_init(sbi);
 		if (err)
 			goto load_root;

-		/* Load $Extend\$Reparse */
+		/* Load $Extend\$Reparse. */
 		err = ntfs_reparse_init(sbi);
 		if (err)
 			goto load_root;

-		/* Load $Extend\$ObjId */
+		/* Load $Extend\$ObjId. */
 		err = ntfs_objid_init(sbi);
 		if (err)
 			goto load_root;
 	}

 load_root:
-	/* Load root */
+	/* Load root. */
 	ref.low = cpu_to_le32(MFT_REC_ROOT);
 	ref.seq = cpu_to_le16(MFT_REC_ROOT);
 	inode = ntfs_iget5(sb, &ref, &NAME_ROOT);
@@ -1366,9 +1386,7 @@ void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
 }

 /*
- * ntfs_discard
- *
- * issue a discard request (trim for SSD)
+ * ntfs_discard - Issue a discard request (trim for SSD).
  */
 int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 {
@@ -1388,10 +1406,10 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 	lbo = (u64)lcn << sbi->cluster_bits;
 	bytes = (u64)len << sbi->cluster_bits;

-	/* Align up 'start' on discard_granularity */
+	/* Align up 'start' on discard_granularity. */
 	start = (lbo + sbi->discard_granularity - 1) &
 		sbi->discard_granularity_mask_inv;
-	/* Align down 'end' on discard_granularity */
+	/* Align down 'end' on discard_granularity. */
 	end = (lbo + bytes) & sbi->discard_granularity_mask_inv;

 	sb = sbi->sb;
@@ -1438,7 +1456,7 @@ static int __init init_ntfs_fs(void)
 	pr_notice("ntfs3: Activated 32 bits per cluster\n");
 #endif
 #ifdef CONFIG_NTFS3_LZX_XPRESS
-	pr_notice("ntfs3: Read-only lzx/xpress compression included\n");
+	pr_notice("ntfs3: Read-only LZX/Xpress compression included\n");
 #endif

 	err = ntfs3_init_bitmap();
diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
index 9617382aca64..5047fa3404a6 100644
--- a/fs/ntfs3/upcase.c
+++ b/fs/ntfs3/upcase.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
  *
  */
+
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/module.h>
@@ -25,12 +26,14 @@ static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
 }

 /*
+ * ntfs_cmp_names
+ *
  * Thanks Kari Argillander <kari.argillander@gmail.com> for idea and implementation 'bothcase'
  *
  * Straigth way to compare names:
- * - case insensitive
- * - if name equals and 'bothcases' then
- * - case sensitive
+ * - Case insensitive
+ * - If name equals and 'bothcases' then
+ * - Case sensitive
  * 'Straigth way' code scans input names twice in worst case
  * Optimized code scans input names only once
  */
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 759df507c92c..a40f8d52b805 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -41,7 +41,7 @@ static inline size_t packed_ea_size(const struct EA_FULL *ea)
 /*
  * find_ea
  *
- * assume there is at least one xattr in the list
+ * Assume there is at least one xattr in the list.
  */
 static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 			   const char *name, u8 name_len, u32 *off)
@@ -69,11 +69,9 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 }

 /*
- * ntfs_read_ea
- *
- * reads all extended attributes
- * ea - new allocated memory
- * info - pointer into resident data
+ * ntfs_read_ea - Read all extended attributes.
+ * @ea:		New allocated memory.
+ * @info:	Pointer into resident data.
  */
 static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			size_t add_bytes, const struct EA_INFO **info)
@@ -101,7 +99,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 	if (!*info)
 		return -EINVAL;

-	/* Check Ea limit */
+	/* Check Ea limit. */
 	size = le32_to_cpu((*info)->size);
 	if (size > ni->mi.sbi->ea_max_size)
 		return -EFBIG;
@@ -109,7 +107,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 	if (attr_size(attr_ea) > ni->mi.sbi->ea_max_size)
 		return -EFBIG;

-	/* Allocate memory for packed Ea */
+	/* Allocate memory for packed Ea. */
 	ea_p = ntfs_malloc(size + add_bytes);
 	if (!ea_p)
 		return -ENOMEM;
@@ -150,11 +148,12 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 /*
  * ntfs_list_ea
  *
- * copy a list of xattrs names into the buffer
- * provided, or compute the buffer size required
+ * Copy a list of xattrs names into the buffer
+ * provided, or compute the buffer size required.
  *
- * Returns a negative error number on failure, or the number of bytes
- * used / required on success.
+ * Return:
+ * * Number of bytes used / required on
+ * * -ERRNO - on failure
  */
 static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 			    size_t bytes_per_buffer)
@@ -175,7 +174,7 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,

 	size = le32_to_cpu(info->size);

-	/* Enumerate all xattrs */
+	/* Enumerate all xattrs. */
 	for (ret = 0, off = 0; off < size; off += unpacked_ea_size(ea)) {
 		ea = Add2Ptr(ea_all, off);

@@ -227,7 +226,7 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
 	if (!info)
 		goto out;

-	/* Enumerate all xattrs */
+	/* Enumerate all xattrs. */
 	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off)) {
 		err = -ENODATA;
 		goto out;
@@ -314,7 +313,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 			goto out;
 		}

-		/* Remove current xattr */
+		/* Remove current xattr. */
 		ea = Add2Ptr(ea_all, off);
 		if (ea->flags & FILE_NEED_EA)
 			le16_add_cpu(&ea_info.count, -1);
@@ -347,7 +346,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		}
 	}

-	/* append new xattr */
+	/* Append new xattr. */
 	new_ea = Add2Ptr(ea_all, size);
 	new_ea->size = cpu_to_le32(add);
 	new_ea->flags = 0;
@@ -358,14 +357,14 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	memcpy(new_ea->name + name_len + 1, value, val_size);
 	new_pack = le16_to_cpu(ea_info.size_pack) + packed_ea_size(new_ea);

-	/* should fit into 16 bits */
+	/* Should fit into 16 bits. */
 	if (new_pack > 0xffff) {
 		err = -EFBIG; // -EINVAL?
 		goto out;
 	}
 	ea_info.size_pack = cpu_to_le16(new_pack);

-	/* new size of ATTR_EA */
+	/* New size of ATTR_EA. */
 	size += add;
 	if (size > sbi->ea_max_size) {
 		err = -EFBIG; // -EINVAL?
@@ -376,7 +375,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 update_ea:

 	if (!info) {
-		/* Create xattr */
+		/* Create xattr. */
 		if (!size) {
 			err = 0;
 			goto out;
@@ -406,7 +405,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	}

 	if (!size) {
-		/* delete xattr, ATTR_EA_INFO */
+		/* Delete xattr, ATTR_EA_INFO */
 		err = ni_remove_attr_le(ni, attr, le);
 		if (err)
 			goto out;
@@ -428,7 +427,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	}

 	if (!size) {
-		/* delete xattr, ATTR_EA */
+		/* Delete xattr, ATTR_EA */
 		err = ni_remove_attr_le(ni, attr, le);
 		if (err)
 			goto out;
@@ -446,7 +445,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		mi->dirty = true;
 	}

-	/* Check if we delete the last xattr */
+	/* Check if we delete the last xattr. */
 	if (size)
 		ni->ni_flags |= NI_FLAG_EA;
 	else
@@ -485,12 +484,12 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 	int err;
 	void *buf;

-	/* allocate PATH_MAX bytes */
+	/* Allocate PATH_MAX bytes. */
 	buf = __getname();
 	if (!buf)
 		return ERR_PTR(-ENOMEM);

-	/* Possible values of 'type' was already checked above */
+	/* Possible values of 'type' was already checked above. */
 	if (type == ACL_TYPE_ACCESS) {
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		name_len = sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1;
@@ -507,7 +506,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 	if (!locked)
 		ni_unlock(ni);

-	/* Translate extended attribute to acl */
+	/* Translate extended attribute to acl. */
 	if (err > 0) {
 		acl = posix_acl_from_xattr(mnt_userns, buf, err);
 		if (!IS_ERR(acl))
@@ -522,9 +521,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
 }

 /*
- * ntfs_get_acl
- *
- * inode_operations::get_acl
+ * ntfs_get_acl - inode_operations::get_acl
  */
 struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
 {
@@ -560,8 +557,8 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,

 			if (!err) {
 				/*
-				 * acl can be exactly represented in the
-				 * traditional file mode permission bits
+				 * ACL can be exactly represented in the
+				 * traditional file mode permission bits.
 				 */
 				acl = NULL;
 				goto out;
@@ -610,9 +607,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 }

 /*
- * ntfs_set_acl
- *
- * inode_operations::set_acl
+ * ntfs_set_acl - inode_operations::set_acl
  */
 int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type)
@@ -677,7 +672,9 @@ static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
 }

 /*
- * Initialize the ACLs of a new inode. Called from ntfs_create_inode.
+ * ntfs_init_acl - Initialize the ACLs of a new inode.
+ *
+ * Called from ntfs_create_inode().
  */
 int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		  struct inode *dir)
@@ -686,7 +683,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	int err;

 	/*
-	 * TODO refactoring lock
+	 * TODO: Refactoring lock.
 	 * ni_lock(dir) ... -> posix_acl_create(dir,...) -> ntfs_get_acl -> ni_lock(dir)
 	 */
 	inode->i_default_acl = NULL;
@@ -738,9 +735,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 #endif

 /*
- * ntfs_acl_chmod
- *
- * helper for 'ntfs3_setattr'
+ * ntfs_acl_chmod - Helper for ntfs3_setattr().
  */
 int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 {
@@ -756,15 +751,13 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 }

 /*
- * ntfs_permission
- *
- * inode_operations::permission
+ * ntfs_permission - inode_operations::permission
  */
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
 	if (ntfs_sb(inode->i_sb)->options.no_acs_rules) {
-		/* "no access rules" mode - allow all changes */
+		/* "No access rules" mode - Allow all changes. */
 		return 0;
 	}

@@ -772,9 +765,7 @@ int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 }

 /*
- * ntfs_listxattr
- *
- * inode_operations::listxattr
+ * ntfs_listxattr - inode_operations::listxattr
  */
 ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
@@ -804,7 +795,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	size_t name_len = strlen(name);

-	/* Dispatch request */
+	/* Dispatch request. */
 	if (name_len == sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
 	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
 		/* system.dos_attrib */
@@ -840,7 +831,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		size_t sd_size = 0;

 		if (!is_ntfs3(ni->mi.sbi)) {
-			/* we should get nt4 security */
+			/* We should get nt4 security. */
 			err = -EINVAL;
 			goto out;
 		} else if (le32_to_cpu(ni->std_security_id) <
@@ -890,7 +881,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		goto out;
 	}
 #endif
-	/* deal with ntfs extended attribute */
+	/* Deal with NTFS extended attribute. */
 	err = ntfs_get_ea(inode, name, name_len, buffer, size, NULL);

 out:
@@ -898,9 +889,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 }

 /*
- * ntfs_setxattr
- *
- * inode_operations::setxattr
+ * ntfs_setxattr - inode_operations::setxattr
  */
 static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 				  struct user_namespace *mnt_userns,
@@ -913,7 +902,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 	size_t name_len = strlen(name);
 	enum FILE_ATTRIBUTE new_fa;

-	/* Dispatch request */
+	/* Dispatch request. */
 	if (name_len == sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
 	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
 		if (sizeof(u8) != size)
@@ -929,7 +918,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 		new_fa = cpu_to_le32(*(u32 *)value);

 		if (S_ISREG(inode->i_mode)) {
-			/* Process compressed/sparsed in special way*/
+			/* Process compressed/sparsed in special way. */
 			ni_lock(ni);
 			err = ni_new_attr_flags(ni, new_fa);
 			ni_unlock(ni);
@@ -939,7 +928,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 set_new_fa:
 		/*
 		 * Thanks Mark Harmstone:
-		 * keep directory bit consistency
+		 * Keep directory bit consistency.
 		 */
 		if (S_ISDIR(inode->i_mode))
 			new_fa |= FILE_ATTRIBUTE_DIRECTORY;
@@ -952,7 +941,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 				inode->i_mode &= ~0222;
 			else
 				inode->i_mode |= 0222;
-			/* std attribute always in primary record */
+			/* Std attribute always in primary record. */
 			ni->mi.dirty = true;
 			mark_inode_dirty(inode);
 		}
@@ -970,8 +959,8 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,

 		if (!is_ntfs3(ni->mi.sbi)) {
 			/*
-			 * we should replace ATTR_SECURE
-			 * Skip this way cause it is nt4 feature
+			 * We should replace ATTR_SECURE.
+			 * Skip this way cause it is nt4 feature.
 			 */
 			err = -EINVAL;
 			goto out;
@@ -996,7 +985,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 			err = -EINVAL;
 		} else if (std->security_id != security_id) {
 			std->security_id = ni->std_security_id = security_id;
-			/* std attribute always in primary record */
+			/* Std attribute always in primary record. */
 			ni->mi.dirty = true;
 			mark_inode_dirty(&ni->vfs_inode);
 		}
@@ -1021,7 +1010,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 		goto out;
 	}
 #endif
-	/* deal with ntfs extended attribute */
+	/* Deal with NTFS extended attribute. */
 	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);

 out:
--
2.25.1

